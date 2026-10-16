Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A94DD3D2
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167335; cv=none; b=R/MHv0By6cDKi94BenJdC9qO/NeLCiW9w2uNqTksL4lWYe6HvJMFgRYtuoP/UFT+eYvR2vxi/iZSkvXyThYIDuWAUzfCCIqvpaikp/kdv770QrDBpN5Z117vBBQA0zXyJV++1H1XnlSU5Ei9nP59lugDcoz0uYMMjxX4638ka5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167335; c=relaxed/simple;
	bh=xIVIqXqeXMZHo7WcZNa0at4HEMt/ghEEI2/pB73QgfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8W/+QlEGc1QrROuX1218dmLr+32nglZQbt8CtLfFbjrwZSAU/OWa7F/bgxc1pP0Zub6EPh14N+QEs3WyfXU4FQYbapiKpt8GZGUZ987VHe0xUJfgRNSbiDZt8MViEBlBnobuDLyF6sQUjKqMZMnf5OAEXqGHtB4ZTkpa/pJBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lsl3HZL5; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsl3HZL5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so111558eec.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792167331; x=1792772131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0j3Ic2XiSkpUSuqw2KaX3WIQgC+OMSs64+mNG8M5Cqo=;
        b=Lsl3HZL5YK0LSZmUzq1zw3VlfyHBIGrEgAOcgnFbfs0hujm4w+kRDvadrx2hhQqZmQ
         x6RWxnxFEv41QN2lRV2zNE3O78V4CvuiOVajY743ISwR7Ydc4gUCq0tzFghhtkoHFl2v
         AloOlXqciMEDV+wM1bDraznk8md/o8QcNs10jLXXVgQr6hCEer7HKnpsfeiG1EmqaoYd
         tqnYWk4zJ4mJTImpkaasSgzEz4wPjCOC92dafzv4XyFwyVfw/3VBgcosH9QV3YAwpx/5
         ur/O3X4+L3+cF6AqBDKtGKG+EPrhaqGGRAfsy04/ceVffDr7i6XSvHUmW3GTCeefZtD5
         HIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792167331; x=1792772131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0j3Ic2XiSkpUSuqw2KaX3WIQgC+OMSs64+mNG8M5Cqo=;
        b=wTUZ3eGqg/Isb5C2asDC47+D5CoqMvN7QVJCubHQcywy7823wQvk/zNqfPja5jbNQJ
         MRRIApa4scdzo1fJZIPcrJOsSnyKnq+RxIFQGxZ2yh+ouXZ4xJGcQ4LW3u5jF/rPkgXl
         QRL/9XgJw2XfXuFa6rKJ8CYK6jkewVCdrVsP42qSxU6hsq2n9OvGMzaerTVz7YUfCqCS
         KkLlamGLFbAK8GRMhVsCcIqhb/mneNo6nihFEg4W0dFDTd1iRiVTI9TArCQEIY8gYIkS
         9/IOHP1ngd8rzGNR5v5n/0ptxyVocBUU8E1EKTaX468+CXL+iWD2mJuD450PwfWI0/2z
         eMQA==
X-Forwarded-Encrypted: i=1; AKwUvBwCvKAK1XvPr+1RXzWI1E+CgGhMhnLjBQufnAYQbEgR5qAAvTglIIerQ6BwwPLiyJ75vdASOCw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6kd7N+yrSCRsecwA4S8Xv1QvCQprzJKAj6/Mb3924Knp112h4
	OvzpwWQf3HrUpg7jbJXJCUv4FIAjxJ8lng531COKzMK2QSNZYwlh6lQN
X-Gm-Gg: AYBFou3ZB9FyD3MVStPwpMgUi3u3lNm4K3V/WB6KxAqu20sReb5+KY3KVMhkrLPT10p
	CzcnqPwszBBD5VuhWivJ9zMW29g0JHbmrYaOJVnxlyU0rie8M6HXyulGP3PRWWEF66/I2Brvth8
	CbY4A+kZCt19/VXsjrIuD5ZHUGhu9gPCsqHs+8I2utazixXmsHttFwddplnK5zsdxSKwjTaM1zT
	uFHLYrnL61li1CjFXZWTMPnpGT45sMwqLSHFE4u/1nxDkHMICtErc4G1iFKvRr+eJ9rTDo/h3Il
	Sp3QirgSLLWDuOtE7YB78mlvF8XuXpxZuoy/CrcC2sThRh2esqvfhLaw3fO/EPSzZdnbIDGZWRm
	nZ43P2WmrUJREDY8EbjYiHKB15zgo+GIV/Lrh5YVAWn0l5lQ8N9YGynmXDyMaPZK7qjk/m88cL8
	trMfM8gv3GGePeHqvVBGaGZ1bcnZvVdvJVP+YItxGUpqzgGI8CFf9o7CyJul4YRmOqkXeMJNs2
X-Received: by 2002:a05:7301:a02:b0:360:8596:657d with SMTP id 5a478bee46e88-361a3128fdamr255027eec.32.1792167331133;
        Fri, 16 Oct 2026 09:15:31 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16dc::247:b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm15192394eec.24.2026.10.16.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:15:30 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+c3741bb338b5c6d6a4aa@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] net/rds: ib: don't enable IRQs in rds_ib_conn_free()
Date: Fri, 16 Oct 2026 23:15:25 +0700
Message-ID: <20261016161525.146537-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__rds_conn_create() calls trans->conn_free() with rds_conn_lock held
and IRQs disabled when it loses the race to insert a connection.
rds_ib_conn_free() takes the device list lock with spin_lock_irq() and
releases it with spin_unlock_irq(), so IRQs are turned on while
rds_conn_lock is still held:

  raw_local_irq_restore() called with IRQs enabled
  WARNING: kernel/locking/irqflag-debug.c:10 at warn_bogus_irq_restore+0xc/0x20
   _raw_spin_unlock_irqrestore+0x67/0x80
   __rds_conn_create+0x1de5/0x2290
   rds_conn_create_outgoing+0x43/0x60
   rds_sendmsg+0xfca/0x20e0
   __sys_sendto+0x408/0x5a0

It needs an RDS socket bound to an address on an RDMA device (e.g. rxe)
and two concurrent sendto() calls to the same new destination.

The TCP and loopback ->conn_free() callbacks already use irqsave, so
do the same here.

Fixes: 745cbccac3fe ("RDS: Rewrite connection cleanup, fixing oops on rmmod")
Reported-by: syzbot+c3741bb338b5c6d6a4aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3741bb338b5c6d6a4aa
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 net/rds/ib_cm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 6e3110a04ae6..5c717120eab5 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -1271,6 +1271,7 @@ void rds_ib_conn_free(void *arg)
 {
 	struct rds_ib_connection *ic = arg;
 	spinlock_t	*lock_ptr;
+	unsigned long flags;
 
 	rdsdebug("ic %p\n", ic);
 
@@ -1281,9 +1282,10 @@ void rds_ib_conn_free(void *arg)
 	 */
 	lock_ptr = ic->rds_ibdev ? &ic->rds_ibdev->spinlock : &ib_nodev_conns_lock;
 
-	spin_lock_irq(lock_ptr);
+	/* May be called with IRQs already disabled (see __rds_conn_create()) */
+	spin_lock_irqsave(lock_ptr, flags);
 	list_del(&ic->ib_node);
-	spin_unlock_irq(lock_ptr);
+	spin_unlock_irqrestore(lock_ptr, flags);
 
 	rds_ib_recv_free_caches(ic);
 
-- 
2.43.0

