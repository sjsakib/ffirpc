import {
  Call,
  InterceptingListener,
  MessageContext,
} from '@grpc/grpc-js/build/src/call-interface';
import { ChannelRef } from '@grpc/grpc-js/build/src/channelz';
import { ConnectivityState } from '@grpc/grpc-js/build/src/connectivity-state';
import { Deadline } from '@grpc/grpc-js/build/src/deadline';
import { ServerSurfaceCall } from '@grpc/grpc-js/build/src/server-call';
import { Status } from '@grpc/grpc-js/build/src/constants';
import { ChannelInterface, Metadata } from '@grpc/grpc-js';
import fs from 'node:fs';
import '../wasm_exec';

declare global {
  var invoke: (path: string, input: Uint8Array) => Uint8Array;
}

class FFICall implements Call {
  private listener: InterceptingListener;
  constructor(private readonly method: string) {}
  async sendMessageWithContext(context: MessageContext, message: Buffer) {
    const resMessage = global.invoke(this.method, message);

    this.listener.onReceiveMessage(resMessage);
    this.listener.onReceiveStatus({
      code: Status.OK,
      details: '',
      metadata: new Metadata(),
    });

    return resMessage;
  }

  start(metadata: Metadata, listener: InterceptingListener) {
    this.listener = listener;
  }

  cancelWithStatus() {}

  getPeer() {
    return 'localhost:50051';
  }

  startRead() {}

  halfClose() {}

  getCallNumber() {
    return 1;
  }

  setCredentials() {}
}

export class FFIChannel implements ChannelInterface {
  async init(wasmPath: string) {
    // @ts-expect-error: Go is not defined in the global scope
    const go = new Go();
    const wasmBuffer = fs.readFileSync(wasmPath);
    const result = await (globalThis as any).WebAssembly.instantiate(
      wasmBuffer,
      go.importObject
    );
    go.run(result.instance);
  }

  close(): void {
    throw new Error('Method not implemented.');
  }
  getTarget(): string {
    throw new Error('Method not implemented.');
  }
  getConnectivityState(tryToConnect: boolean): ConnectivityState {
    throw new Error('Method not implemented.');
  }
  watchConnectivityState(
    currentState: ConnectivityState,
    deadline: Date | number,
    callback: (error?: Error) => void
  ): void {
    throw new Error('Method not implemented.');
  }
  getChannelzRef(): ChannelRef {
    throw new Error('Method not implemented.');
  }
  createCall(
    method: string,
    deadline: Deadline,
    host: string | null | undefined,
    parentCall: ServerSurfaceCall | null,
    propagateFlags: number | null | undefined
  ): Call {
    return new FFICall(method);
  }
}
