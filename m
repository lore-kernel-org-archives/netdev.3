Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68B5678C9
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062835; cv=none; b=DJ2kD6Y0xz0w/tpw1nJiMuWPfKfeRu6quvpHMP4027H0WZZ1qwWlNYshK8P2iNyMyGui/au8UcGL1i7smDpqr5pAt/caQJZcEv5WRAKlvEJEkwoV6jPezK2R567ZN7ERbBOqZ4CulUkkOlKbB7UEHd6cMs1G5F/ad9RUaNdegRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062835; c=relaxed/simple;
	bh=OmmYDULCAhxxwCGfc8f2jli+oq6yQsGRKtNM6XN5Gvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9Qxou4Eo8HKEjFB//I9NteUBowjjddmNS3yGjpZLCQIHfXzY4CIg7GLjOpLxlwIkr1umnMUOU4PSLqfvFDFKIOV3FlaGS0Xhzj5XW7FN/ksd6/O8RzJbkwLW57HwRvrcoa5XWwtPfvevwz08z4Y/sd5AdaalsHpYuJ4VgriXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fjmlwlgj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fjmlwlgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789062824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RDSzcHCE05xPzjy6Xo6KC+PCiUblPrx84N5aVhq59vg=;
	b=FjmlwlgjJTrWlkmw6Yqfn65E0ioxq1fW8iAn9YGijsWka6KlyEUH5gMOgW6OXtpEbNVzAl
	xXxa5eUF5bXyuixiPflcn1RE6mr0g05kmBqPky/PJBLdwMIFlm5VwjAfAdmFsZkgXzTiWT
	CZ8Bpg7cB9BUz3eF8pmQVge2aeyQwoA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-AATMVXf4M0KWFKi0_kCiOA-1; Thu,
 10 Sep 2026 13:53:41 -0400
X-MC-Unique: AATMVXf4M0KWFKi0_kCiOA-1
X-Mimecast-MFC-AGG-ID: AATMVXf4M0KWFKi0_kCiOA_1789062820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4105A195DBAC;
	Thu, 10 Sep 2026 17:53:19 +0000 (UTC)
Received: from x2.localnet (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC32C180034F;
	Thu, 10 Sep 2026 17:53:17 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 shuah@kernel.org
Subject: [PATCH net 1/1] net: preserve socketpair output on setup failure
Date: Thu, 10 Sep 2026 13:53:15 -0400
Message-ID: <JyK226D0S5CWGUpAC4MO4A@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

socketpair() writes the reserved descriptor numbers to userspace before
creating the sockets and their file objects. A later failure therefore
leaves a modified caller's array despite returning an error, contrary to
POSIX. For example, socketpair(AF_UNIX, SOCK_STREAM, -1, fd) returns
EPROTONOSUPPORT but replaces the array's sentinel values with unused fd
numbers.

Defer the output stores until both file objects have been created, before
installing either descriptor. If a store faults, drop both file references
before releasing the reserved descriptor slots. Keep the early descriptor
reservation and the existing setup-failure cleanup paths.

In practice, I doubt anyone notices. But this aligns with the expected
behavior

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 net/socket.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index c05d86e63abf..4cb8662869f0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1851,10 +1851,7 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
 		flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
 
-	/*
-	 * reserve descriptors and make sure we won't fail
-	 * to return them to userland.
-	 */
+	/* Reserve both descriptors before creating the sockets. */
 	fd1 = get_unused_fd_flags(flags);
 	if (unlikely(fd1 < 0))
 		return fd1;
@@ -1865,14 +1862,6 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 		return fd2;
 	}
 
-	err = put_user(fd1, &usockvec[0]);
-	if (err)
-		goto out;
-
-	err = put_user(fd2, &usockvec[1]);
-	if (err)
-		goto out;
-
 	/*
 	 * Obtain the first socket and check if the underlying protocol
 	 * supports the socketpair call.
@@ -1916,6 +1905,16 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 		goto out;
 	}
 
+	/* Publish the descriptors now that it shouldn't fail. */
+	err = put_user(fd1, &usockvec[0]);
+	if (!err)
+		err = put_user(fd2, &usockvec[1]);
+	if (err) {
+		fput(newfile2);
+		fput(newfile1);
+		goto out;
+	}
+
 	audit_fd_pair(fd1, fd2);
 
 	fd_install(fd1, newfile1);
-- 
2.55.0




