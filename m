Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167844F575
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193622; cv=none; b=ChVIyWrNwyPbL0tukuAnuS7u1hzxsvPEt4kus9C6JQC7IdXeb6hSKIqZUA9gEA47WCcqSnQpds5Dx5wlaScCaID70Rev/Zze3YxAZj1iDSs2r1/Hu3KYkTIl1NsZu83zb0hgcbNO/hDRRYNCKLwudTEMQqE6rp2eaeVvIe0c3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193622; c=relaxed/simple;
	bh=Ln1CaRAz5yhmpmIV2bNeFY8S6UvvLoFrF8dx6im5KDY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=G9BaAKjbGhZaarJhVzutW+YKXBou7FYueKio5FLigJB9sepk9jumOW9G6u2IPc3OkAQZ0YiAiS0Q+1PoZLxkDlhSvxy01cnjrstu7bOj9rR1fURGLsaleY+2lmQaIaUB4ZtJ5IEb5Jdi0etbdOtIRQYW5IicRiMU5PyqkyrAJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f4e4b52404so1836163a34.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790193612; x=1790798412;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1DD51enbnQ7FLUQimWQmuCMYdC5ARBlUMukwD/j/WF8=;
        b=Hy2DSLCk2FoYBPouuxkO7XzvvystZVfHxBBOJ+0rBlB5uSvJErHrxWJ6u2iFHHNVgK
         d7iOYwWOKaxZwKgdVlz8VWzwse19AZ+u/drZuIqFDQoiDvtnlkpFeaV8KRcZJJiwpNQs
         bdcXfYPugOub7YkVUkHlK4CEj+pAA/IFZU2YRHmEU1OXRWgRUGxWbgZbKwHA3RFa0eyl
         PlzKgQtUN3WZ6UcKc7HaTFyB4waXUu5kQxi5yHRWJkjdwuDUcH9FG3E6cicA60DoBjDD
         wjAgwrFSH11WWoNRUfk3/elvBrRAVwfjqcBqhPn1DexpNmC7UJiSbXjqa+gh6X6sadDD
         4Fsg==
X-Forwarded-Encrypted: i=1; AKwUvByY2nfdb0i8XfVzYTsMEmVwtlSKpEb7nCNNdD1YiMjObip2zuT0d4my7gmoZDOzn/TLw+mjyz8=@vger.kernel.org
X-Gm-Message-State: AFuF++kEWomSNbY+1Pdo7PlPaAiN8PhILo/AJgT3vTLP9yv8h26pK4I4
	fkRDNDUUVjQXZPIXhjQhDcKgJb8w/kUzZWjgqqhWR5JpBWqYWhsuHb0pk6ZkyQ7Igd0oCbkxihy
	wYExVnPI0UJ6GrcW2p72FRlR7/s+yH5PwjKRFu2e82DOR36/Cs/wY1nQvvs4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81c5:b0:6c3:98aa:75ac with SMTP id
 006d021491bc7-6d43e80c6d4mr379567eaf.27.1790193612568; Wed, 23 Sep 2026
 13:00:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 13:00:12 -0700
In-Reply-To: <20260921191239.4249-1-alucerop@amd.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab42fcc.e9f5c185.9abc8.0002.GAE@google.com>
Subject: [syzbot ci] Re: Type2 multipf support
From: syzbot ci <syzbot+ci99860126897da844@syzkaller.appspotmail.com>
To: alucerop@amd.com, davem@davemloft.net, ecree.xilinx@gmail.com, 
	edumazet@google.com, icheng@nvidia.com, kuba@kernel.org, 
	linux-cxl@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rafael@kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] Type2 multipf support
https://lore.kernel.org/all/20260921191239.4249-1-alucerop@amd.com
* [PATCH v1 1/4] driver core: Rely on supplier driver binding at link creation
* [PATCH v1 2/4] cxl/region: Add region reference in memdev attach
* [PATCH v1 3/4] cxl/memdev: Add support for multi PF devices
* [PATCH v1 4/4] sfc: add multipf support

and found the following issue:
WARNING: synchronous SCSI scan failed without making any progress, switching to async

Full report is available here:
https://ci.syzbot.org/series/cce74032-73a7-4071-a29e-65a7ec02c350

***

WARNING: synchronous SCSI scan failed without making any progress, switching to async

tree:      axboe
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux.git
base:      93f51579e7df248780214094418f205253383cc5
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/50697200-bc23-49c1-b943-c9c91049cf06/config

ata1: Failed to create link to scsi device 0:0:0:0
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
ata1: Failed to create link to scsi device 0:0:0:0
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
ata1: Failed to create link to scsi device 0:0:0:0
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
ata1: Failed to create link to scsi device 0:0:0:0
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
ata1: Failed to create link to scsi device 0:0:0:0
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
ata1: Failed to create link to scsi device 0:0:0:0
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
ata1: WARNING: synchronous SCSI scan failed without making any progress, switching to async


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
