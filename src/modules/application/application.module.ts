import { Module } from '@nestjs/common';
import { NotificationModule } from './notification/notification.module';
import { ContactModule } from './contact/contact.module';
import { FaqModule } from './faq/faq.module';
import { UserModule } from './user/user.module';

@Module({
  imports: [NotificationModule, ContactModule, FaqModule, UserModule],
})
export class ApplicationModule {}
