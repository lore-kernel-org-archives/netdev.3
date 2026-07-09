Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F33C1974
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583105; cv=none; b=YkqGvmDLd20Dj1E5JFSCJnBq9GKG+U2eNK/uUgcjFTgO59RKxkt4DpeYSm1JqrmOzIEqPTH/utk1sk8xHo8h+IIGDkV4EpJTlw0db07OC+Z/IFW5GypwOfbKI+vjGPbN8uAAryDXTrIF6xKHXSZ2MWuKz5xocDHw9rLZZtRkvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583105; c=relaxed/simple;
	bh=ljQxIHA11d7j3UwD5SUG7PWcXQCYFxsNMhqkVbdm2WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXfYpJVD4YCIE14Rnlo7vgN38KA6tHwaMAysXNvYWkQoHO/TGD+Lekos5bU3AmKCYqP0PxM8YXi+dKyLYIc59tmQQXx9DLrkTycv97jnkZUBoiGuTCek526QFrgD9YRO+YZF38GhmpartoNJI5hzINXrgb8YUTCHz0dE0Y7EUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=k/R1qZ8E; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="k/R1qZ8E"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-847d1e9db22so1655474b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783583103; x=1784187903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3pmlo/oWq2uNWTooLbzNWToUXky3k5pknmZssX/yPA=;
        b=k/R1qZ8Eov4b7hTEpg6BojLWtq2FsUkfqz9KCFcoPdTz/2jT9BGUzEHaWyzqE13HfR
         Vi60NSdYWz8XgMpRizJzpW9NFWnhcIGRuCpMfPeBPVh2/VLyH6Bu27lDDfRN5xT93u88
         GyTZkyHFh9A8gKji+Lv1SqlnZG5hzD1JR/janhBiI37HI0NvKxL2UMwoqmSKgOtNWj2v
         Hu754VoCscGCDLn63rPmfpP5DULW5+wDqgLgZ+vUq3CosmMC7JeBr8Lk1c+9acWfcxL7
         PVJyGHtwacnTd8ZI05Ap1g6BNBtrvRwO5k7TKn3ibxLcNZcBEeM2G5dAudcdGZWkbJ95
         ENJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583103; x=1784187903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3pmlo/oWq2uNWTooLbzNWToUXky3k5pknmZssX/yPA=;
        b=qpvHkdoZx7o3LZvJgXGLpVb6RzfYREeejWEeaOBCXVMVs39y/7DKOXbD10iVCaO9tO
         RLthVUc71pgSfAPzRMz972m/pV3lYtHGUZPkcpvRu46Q7/0IlxbBEdaOXtNDT94fP1LK
         bwXV+elTyXx4/im0xFDxBGRIpYBe8Wcq9xZyZIPGIQWpbbabBBgKZX95tyvL5J0OSZbb
         J94jC1BpHyCtt/LjLQrvzaETrDLQgUCp7ovL5SN+Uuyp178WOErKwCmaxm8zxmpJo7zN
         C+8sF2nCI0mQrH9A/Ailr79I61WH8msekABFK1rKFQ+4pHc5ZPnrxoQ+tZ9p2E8XxugB
         s29Q==
X-Gm-Message-State: AOJu0Yx60GacsQ4BMYVDtpGrq/kGhp8IIs8DRNmRkLXYc2nIVToe9ixM
	1Ch4d62xPLY1BsSX0VjdlyiFY9FGlAqGebsB3E2O2WVKvAd+yfQOtJyJt+/SNq5zSA==
X-Gm-Gg: AfdE7ckiNOTXvKD/Ncc4i76wn6huhRxk5PtE6UdCawMb6pDQPP3p+VEwqT6QveS4Yzb
	L1LX3iWO0bvAHkjxGHtWOGSX91GBs4RyuI8XNytrHhN5VDD6yVccpx9DNkpe07ogSsVLequUsUC
	ekO1WhbPtnUCza+a2K9vqotUQf1s6K6NMw4nYlJ/PUmAt4O1OYqWAd3vikKzrVJi+CPJNY0XcgU
	aYUvJmt6rTe/5IBENYkAwZZVMb2dfKBWkw9fyfPqXvL7MNxhyVm43HXycToFJM1slHwdAtX1Rwf
	omPc9kPfWiuYDRew4JrejiHsWh4XcMWBUz5oFhVeqnczFKIeX6/Hx9dj1ihJlaAqj+t7SiMxMDH
	/ah9L/LrxFzqAp27GM05z0kt4vYYySETKOIEp2VVmzti/2RxBK8IdE7ILKoZEjBofyzQtVbmG6A
	==
X-Received: by 2002:a05:6a00:1bc9:b0:848:42c4:d8c8 with SMTP id d2e1a72fcca58-848437a26bamr6023748b3a.68.1783583102879;
        Thu, 09 Jul 2026 00:45:02 -0700 (PDT)
Received: from p1.. ([2601:600:a402:c8a0:214c:bc6d:954f:ba01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483dc66f2asm2501048b3a.24.2026.07.09.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:45:02 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] rds: tcp: hold the net_device across ipv6_chk_addr() in rds_tcp_laddr_check()
Date: Thu,  9 Jul 2026 00:44:59 -0700
Message-ID: <20260709074459.326345-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_tcp_laddr_check() looks up a scoped IPv6 interface with
dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
passes the bare struct net_device * into ipv6_chk_addr().

dev_get_by_index_rcu() only keeps the device alive within the same RCU
read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK can
free the net_device; ipv6_chk_addr() then dereferences the stale pointer
in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), reading
freed memory.

Take a reference with dev_hold() before dropping the RCU lock and release
it with dev_put() after ipv6_chk_addr(), so the device cannot be freed
while in use. dev_put(NULL) is a no-op, so the scope_id == 0 path is
unaffected.

  BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
  Read of size 8 at addr ffff8880106ec000 by task exploit/153
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
   ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
   rds_tcp_laddr_check (net/rds/tcp.c:370)
   rds_bind (net/rds/bind.c:248)
   __sys_bind (net/socket.c:1920)
   __x64_sys_bind (net/socket.c:1956)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/rds/tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index a1de114d5e2e..204dcdc33c27 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -363,12 +363,16 @@ int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 			rcu_read_unlock();
 			return -EADDRNOTAVAIL;
 		}
+		dev_hold(dev);
 		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	ret = ipv6_chk_addr(net, addr, dev, 0);
+	dev_put(dev);
 	if (ret)
 		return 0;
+#else
+	dev_put(dev);
 #endif
 	return -EADDRNOTAVAIL;
 }
-- 
2.43.0

