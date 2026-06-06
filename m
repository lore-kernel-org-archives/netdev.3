Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E92F1FEA
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726311; cv=none; b=gmULkqNWCzzlNoqPZbZNQxCQwhpdjQlCChkL7qmYXjPmw6ntwm4DBVkxLFOJf1WrxWVqamOComVtAIafwEbw0zUD3LMfwNo4HMeFiOSt5/6xDeu/FIO67G4HgHAmVONoG6llwwVf+pWIoFVh8CoyfU32kKQCi+s6sbNG5wRpLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726311; c=relaxed/simple;
	bh=x+w9SGxZBWO4hPXg8E+A/q/4ScS0BqeDSCrwJNo6iBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMZYGW2X7XygAwmhtunaetr6aiessVH5IuGMNm5clPSaFrj/cUcGlQZDUFbKutvjmxRWJBX62HVWAvBiIjwvT/VgT7nsYis6zMtdPnRWF6BMR9IOV8DL8pofsCm/E4hrihaOoGK/npOUqeX5O2ONIpaz+uo79ZkMil0BzUBnRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjKXTOhZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjKXTOhZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eee266c6cso2062620f8f.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726309; x=1781331109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ggg4zFesK0IrYb2saIE8cPaSi4XEf6KWehvtWp5AY=;
        b=NjKXTOhZ6oFtD6egk7Q8ZGBQebsZA/l29SSQKp5HIFtTtDs5m9pJncOdhT1E4OMNlw
         voEdgti52EWxYcP4vTsS4BbnzSSgKcN3+Sj8qb3PYtHNlqx0Yti9pz12uYadPiFktEvI
         GEY2VByqek/o37vSoIwXjHuNB2Wk+xq00+LtVXml4K2ZaB309p+/VTaXBq7SvGMQTLaS
         9dG79e/RcblaWFrhC1exZ24H/AznHI1yD5BpA6VnbtCSbx/10pau+uv5bTw4iUoWA6/Y
         MdH4ZC3Vk3LSX0FT0DfUFQvy7RPM7Jc3cMEtLJ/Y56H/K7XXdGGTNtMsrIvCtmE4Y+Hk
         LdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726309; x=1781331109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+ggg4zFesK0IrYb2saIE8cPaSi4XEf6KWehvtWp5AY=;
        b=JirjGaRSG6UC2MTpziP80BOsPmEaAFb1NHjLvS52KhNXyTcQvsjXbX8gl0XaH+V5Zf
         CbyaOsNiNwfFl2Le9lBLPenxNpWyQKBwFCkE+AEmevFLifDA+MKNbrw8OYCTeg+5WYh7
         UkG6UhZRDiVFmbrWE9IBcNYV8dzwKD4jsn+RqL75KpCPlxv8BF5W9TpuVSdnpNPYcgD9
         LUmXRK1tns7/7ctnjNVY2ipYph5mhxkAbc7L2mpU1KgH7NzmA2BMppZzDWwNT9MPIZB3
         51Du4pUTQRHYSG9hWzd/1E+acvh+hvuzl6SyBQSmju1ZlQ4wnGgbwyhutkN2b6wEzfj3
         HliQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CUmwtHqFMItCWj/2FkUtZpHp/l8QEH438cNEuLPNNhVmmzsaMU9ucaKujcFd21usSapEOx5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1UGRzAMU7VXJK3A/fmaWXFk46vEtzuBtnHRv9e9CDrT1XXZ/
	Qeask4CU4/VEnuJCmvcAs/z3SB3BB4A8fGgPiJ45NOpKzTgSZCwVlHYm
X-Gm-Gg: Acq92OH2JgYdPVfPloEzKJfkr7hVGuIkTtfR9FRyl+K9LL6aZ51O/ysDqhVC8SB0Oxn
	5+qrn4UzVyCl0lwrBC7p4u95g27LwaWmHTWe5dfUcLakLDVCI3Ub6KU+BnWYXjhWImK/agt/zs2
	dVzb7Ot90VmXANXYAspXQ6w1Kh9XtJNgmOHxgqKGfFtkDrmNc9o6feP/ibYOfYJv/i0knG057ys
	H3wPWOofUoWM+RHHpHtV0+QMP2aan2yVHdzSerSXaXnhwxEIlx3rdnQIZM6Tekks+GUgtpHwmcb
	4Qcj/oMFhkhHkNEZeqUwyB66RSzXeSnfFl3z0pT6mT2ymBipMJNNb1g/FWve6HRn308KYc7QtZI
	UDlm16UC1YwcMEoccSjNIzyprRQyq5QDFQ8rCS7l/5okTKAtRqx7mMyoPLmdKMBIED43a+ZzgGS
	gCZGUVVn/0rjwWFcyJHMilpVD0thiNtpgPFO1Z6VkD
X-Received: by 2002:adf:e014:0:20b0:45e:f29d:d438 with SMTP id ffacd0b85a97d-46030618a38mr7876243f8f.28.1780726308885;
        Fri, 05 Jun 2026 23:11:48 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46028a6dce6sm24115947f8f.30.2026.06.05.23.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:11:48 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	ltp@lists.linux.it,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 2/5] vmsplice: change argument type back to "int"
Date: Sat,  6 Jun 2026 06:10:28 +0000
Message-ID: <20260606061031.3744880-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My previous vmsplice patchset changed vmsplice argument from
"int" to "unsigned long". This may cause problems, so let's
change it back.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c          | 2 +-
 include/linux/syscalls.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e224e7cb8..77487b307 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1218,7 +1218,7 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 /*
  * Legacy preadv2/pwritev2 wrapper.
  */
-SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
+SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
 	if (unlikely(flags & ~SPLICE_F_ALL))
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a86a88207..46a3ec954 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -514,7 +514,7 @@ asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
 			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
 asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
-asmlinkage long sys_vmsplice(unsigned long fd, const struct iovec __user *vec,
+asmlinkage long sys_vmsplice(int fd, const struct iovec __user *vec,
 			     unsigned long vlen, unsigned int flags);
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
-- 
2.47.3

