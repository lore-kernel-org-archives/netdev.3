Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A15318ED2
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754237; cv=none; b=RL2+WIP5SsRhR3Wjd+8y6UDUpYhB+Q0E7h6+OJghpAO2Q+QmMIlwltsErIzolFj2stSGg/kurN2i0s05eaqMM5VWmW9zkBgZPN6zhtlG9Hg8To0gzAZF/Ql1+K32y2SKE70SyXaWd/5q5SARRb9VgRp+z+BEwKhHZIo4tHSs0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754237; c=relaxed/simple;
	bh=Zlb82+IdVuCl9xn/laV+Lll23Ks6kbcvYCU87g1yLoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSgHI00u++qI6PLnMtiscQxwu9b0iuoU9ykChFg4qtuwA6TjYyR/QmTr+D1OBoBI+XpMdSHWL22t/QRKxLw+vEeA9hGgpYuL8yonm19gNMCldTMsH9gDK5TuPlJwxaEHLu6p9EJOK4gvEZVPMqzOTf5CBSS673Whg2cTzHS2yeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=V/9GfggO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="V/9GfggO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e0a4334b6so1960068b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784754236; x=1785359036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBm3wrv4Ky7/5MDSknvd1rCNVUs8d17vGheoqukyOXk=;
        b=V/9GfggOGW1PTz/eGEH+H2Sim0uSRFcV3zQVvh2Bw7Ks+bKaGTJ1BdA+R5FCLIKYnS
         GGAYIiQdKstOWq9fRyqZq1mdf1kReNP5Izg5FfWNta01i0MRKOt72uYwG0KVSw5pgpM7
         ZUXINrtFJRcFy1M7pqeXTsnSmIM+dfISuFYMj3GZKwXVbhqeHmZlxOTvpZp9ipC7e1Wl
         G4xOmfMlxtkoPUk8D8/nMJj7zb8/tQYqEaAhNdQnXZ+CKhoLaQmeGELN56VuRIidbpAi
         8Jn0xuGH3yRmrQ65ZNVx3TlqPjnb9WXNgSAnikz4eN2QLE/BoX9z1ABGU+gt6PMzRXG6
         NQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754236; x=1785359036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBm3wrv4Ky7/5MDSknvd1rCNVUs8d17vGheoqukyOXk=;
        b=J1YthlNNSU8X6dk1PvQ3Ekp2HW3J4t8DrfYdiGwKuMQAZ1tEYfrSKDnXLWFWWaxXRi
         RJ1WcVLHBmfz0LRR4g3rzfbzjALWoFQr5M9dU4mA6qLleQVS8lUGFyfCKhb4DYt9x/tf
         yiFtOWrCA4MsiulCZB9FHOHVmJifG4lTKvPhCPw3/nPzmGh73cjzaD0v29Gw3sYGdqNL
         HDf5VXqdMZvaUMuhqjsiU0oMmeKYxBcU1/Cy1JoNtJufT9kwbt3Rx2rfPnLcIvf1Ed0h
         QacDkqUjHSLP17JJGoCug8dVLZIHropxigjWN8ATPy/w//kN7lsNKCYWZM8szyG6dsFM
         COBw==
X-Gm-Message-State: AOJu0YwF87NtPT8LDKasH+24p7IhKj+dUyrMGe39OkA/XagntvfgKSl7
	aCS6hNG4ueZtxd2YvzKG4N64fWRbrCydH4DzeqQt7bas7Xr7G405/qiyc1Y8THAmZQ==
X-Gm-Gg: AR+sD11hg/JC4zwOZrimrGpbjT1/604Ftam508d7OuJ3Yyn9lTAcp6Xx/QL1lyqtUK2
	nejoCZlgH2c5Z03tWwujf++hkGP2y/XHON433FHItKzRfYiLUBleob6hITVSmunuUKaY6Mtl4fj
	/sAwetb+PnmksJwBNdphJEE+TlEuR52sai0ydXmRumgy/44mKlytFXFjBuDKCjP75enToThYnlG
	92m9sXx6XtsbdwbGbHbMgBYS5Ur58sfuIXn3KrVXVtBZHH8KuCzE1XFtzplvL7PswCwBYhMtFGY
	SddiQUxyHtAV+QihMxzGPJQETxGx5VIR/eu8XyD31IgbhxZGV5UJRMH9WwgUuOnVwgEZ1v+ylf4
	mkWIkXCt87jI4VQvmg5HtB5hYxyc9Goq6UIVx9dhzanTrO4fsl2wvHDzpA5Is1g==
X-Received: by 2002:a05:6a00:2d1a:b0:848:2a55:7110 with SMTP id d2e1a72fcca58-84e2bb53625mr447822b3a.36.1784754235842;
        Wed, 22 Jul 2026 14:03:55 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:c77:30c3:296e:133d:928d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175a3d6csm1839028b3a.40.2026.07.22.14.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:03:55 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
	Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v4] rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()
Date: Wed, 22 Jul 2026 14:02:03 -0700
Message-ID: <20260722210203.565803-1-xmei5@asu.edu>
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

Keep the RCU read-side lock held across the ipv6_chk_addr() call instead
of dropping it right after the lookup, so the device cannot be freed
while it is in use.

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
Reviewed-by: Allison Henderson <achender@kernel.org>
---
v2: Use rcu_read_locks and rebase on rds: Fix inet6_addr_lst NULL
    dereference when IPv6 is disabled
v3: Add change log to commit message as Allison suggested
v4: remove the changelog in the commit message since that was my misunderstanding

 net/rds/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 955d92277d5a..30cfb0087f2c 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -355,23 +355,25 @@ int rds_tcp_laddr_check(struct net *net, const struct in6_addr *addr,
 	/* If the scope_id is specified, check only those addresses
 	 * hosted on the specified interface.
 	 */
+	rcu_read_lock();
 	if (scope_id != 0) {
-		rcu_read_lock();
 		dev = dev_get_by_index_rcu(net, scope_id);
 		/* scope_id is not valid... */
 		if (!dev) {
 			rcu_read_unlock();
 			return -EADDRNOTAVAIL;
 		}
-		rcu_read_unlock();
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6_mod_enabled()) {
 		ret = ipv6_chk_addr(net, addr, dev, 0);
-		if (ret)
+		if (ret) {
+			rcu_read_unlock();
 			return 0;
+		}
 	}
 #endif
+	rcu_read_unlock();
 	return -EADDRNOTAVAIL;
 }
 
-- 
2.43.0

