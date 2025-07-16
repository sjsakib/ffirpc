import { ExampleServiceClient } from './proto-gen/example';

import { FFIChannel } from 'ffi-grpc-client';

async function main() {
  try {
    const channel = new FFIChannel();

    await channel.init('./main.wasm');

    const client = new ExampleServiceClient('', null, {
      channelOverride: channel,
    });

    console.log('sending request')
    client.getSubtotal(
      {
        products: [
          {
            name: 'Laptop',
            price: 999.99,
            category: {
              id: 1,
              name: 'Electronics',
            },
          },
          {
            name: 'Mouse',
            price: 19.99,
            category: {
              id: 2,
              name: 'Accessories',
            },
          },
        ],
      },
      (err, response) => {
        console.log('got response')
        console.log({ err, response });
      }
    );
  } catch (error) {
    console.error('❌ Error:', error);
  }
}

main();
