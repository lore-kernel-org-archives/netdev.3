Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87437F8C1
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784503318; cv=none; b=ce2FefQBf9zYKYbTIxJaTp0JFx+E7MmaclVS2+1aggHWoHWNjUiidwx9MRn1jukIsfemcTQyDQCk/K4LUxciI9TN07noUBl2ra9bnzkTEeT8Q7qhPDN0sA10JJMUsdpJQ4K5mr//PtNTMwdZpNoxMTlgJBODUnbtaeOe+ovELGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784503318; c=relaxed/simple;
	bh=hXLBiA56AtYJu6PvYneevXPNAEmjC0iHDLtyWlRyexE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MN4R+yPJQegXnFQ0+53isLhzAf3n7+mBg7fPWuEuZY73TAPCPeVtHsyfAVP05uBuRhr1YjC0yNQ+bUXQp8ixae6yEdSe07qCnbo9anLjYB6u7i1TaBkeLaOJun2RFcNVtQyaRRW15kSNqgPuAmNyL5YXGSBJjmW6fiChlaKfVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=aqPmmtal; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="aqPmmtal"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc73e322dbso112262255ad.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784503316; x=1785108116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/y8P5MwGMN985NJk2E4j0Ig7gSOteCnsYHCJe1HX2eQ=;
        b=aqPmmtallT7rhlYHP1wYFJ2Y0cvt9DPA/INvq5O/UlPbjSDQ3fbO5SEPz4ASrurAz8
         g5vuV5wBWOnHwqJalaEDxIMpbLQSGgOas5iBjQn6OucLcxuhXtEYN5xKZ7KtTmMPcSAN
         mdyJ/Dxb/r2w0BeJVrDLvUgTN6iH8KAUA3oaN0E6ZH5pgC7MtBfznudTiDXSN4FrJww0
         uTkhRdDBEQg883VhgrUnUTemGRLjGXcPX9loDsIWfj3XOegTqbohME2DQ2iZLdlosDo5
         hvw9Ych/mOcKYsAfLTXzPT5iI3eCHQ2MWhswEoaWrSp8M+60JmryRZ2Yu88spvp4Q5En
         q8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784503316; x=1785108116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/y8P5MwGMN985NJk2E4j0Ig7gSOteCnsYHCJe1HX2eQ=;
        b=V/mU/DgFr5gSMGv3paMG47iRnXZZp5eqoikbQnkThWaTlo9INspEGESEaWuGqYsEhV
         He+3pJUBYWJCNyuozT8d/FjsONRsqvbOl5rhXIqaxYbzKiIP7ZC5rmK7n/0YXxkd9wUh
         5p7x6Mg7rjcT3HY0we1IloBdf+jhGvtpW/CRISdLBqyQRzpgJjEIVcE79vqjVDN3W5nS
         utcHarkHN+Agi18597ZcDzPvQRuIoISQ9fP4VSLmKxhEge01WEmgemtIxXE3eWeEGd9y
         9xavG3DVlk8yugjkkzMAPl/8eUV9YtxFl3Fz+4s9bavhBuNjI7W+pCYZCOWwM3+T75MH
         3taA==
X-Forwarded-Encrypted: i=1; AHgh+RremynN3DsjlAdZHJbvFQaGxrjIFluY62RXSqeZp/4fZZNeQBHmtH1f0l9MAskNnvWMWtrh3b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLang7R6D/mPPQ3jmUIe8qgJWD017DcfwLZgFrAl3f3Iph6DP
	Ik9E902NGnYJ4kS/VcEuGRDaDRZDY0ePKO/V9aZFKUpmZMtsqr88Yw8p1RWnvKrbHQ==
X-Gm-Gg: AfdE7clg+TK7bvxaG8cSp7Ao+3w4tkdTrdoTUKXP/ia63Qz+Sdjqlbv9vniekJjRFks
	JyiSn2ocMYDmqa41ZPxFIjaIrRNB6dFd1lo8ee4wCwNH6DmVa+TzIAjhW/BRFKBUwUbsg4EA5Zy
	qLGdQcrh3gbsT/txGCTbwx+W+z3Hf7xmMxm9CN7hFo/cq8VOF3fNoq91/CgixmKgNvhjJLoz2JL
	651zvfSvtwqFG4cfHxsOIHnIBDc42eUWCjcOsTmv04Fy+fmRZVzqKFciM1Pmuq6DP9P17hbUAC8
	52UbpjrOMtL2I0XFtWLLjnBpP84T0084muu4Y9Bn+hHaxHbnRqYDLK1u0+JOIyRy4V2h4tFk0XU
	XjzhwcHe7ooAVwPSUUGu4hTRG57vuXvkCXLDLiiy/KB/QcrL7DVGyRAwvnNfV4vO/I5y1GG7UMv
	rjbZqYIJU=
X-Received: by 2002:a17:902:e54b:b0:2c9:b48c:fdec with SMTP id d9443c01a7336-2cf348547d0mr135063955ad.12.1784503316225;
        Sun, 19 Jul 2026 16:21:56 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdbd45sm29720183eec.12.2026.07.19.16.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 16:21:55 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] bonding: fix skb_under_panic in bond_ns_send() over stacked VLANs
Date: Sun, 19 Jul 2026 23:21:53 +0000
Message-ID: <20260719232153.1405569-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bond_ns_send() builds an IPv6 Neighbor Solicitation with
ndisc_ns_create(), which reserves exactly LL_RESERVED_SPACE(dev) +
sizeof(struct ipv6hdr) of headroom for the later ip6_nd_hdr() push.
bond_handle_vlan() then inserts the collected VLAN tags into the skb;
each inner tag consumes VLAN_HLEN of that headroom via skb_push(). With
enough stacked VLAN devices between the bond and the ns_ip6_target, the
reserved IPv6 headroom is exhausted, so the subsequent
ndisc_send_skb() -> ip6_nd_hdr() -> skb_push(sizeof(struct ipv6hdr))
underflows past skb->head and hits skb_under_panic().

Restore the required headroom with skb_cow_head() after VLAN insertion
and before handing the skb to ndisc_send_skb(); drop the probe on
allocation failure. For paths that did not exhaust the headroom this is
a no-op, so previously working configurations are unaffected.

  skbuff: skb_under_panic: len:84 put:40 head:... data:... tail:0x50 end:0x180 dev:veth0
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Workqueue: bond0 bond_arp_monitor
  RIP: 0010:skb_panic+0x142/0x230
  Call Trace:
   skb_push (net/core/skbuff.c:224)
   ndisc_send_skb (net/ipv6/ndisc.c:454 net/ipv6/ndisc.c:506)
   bond_ns_send (drivers/net/bonding/bond_main.c:3255)
   bond_ns_send_all (drivers/net/bonding/bond_main.c:3313)
   bond_arp_monitor (drivers/net/bonding/bond_main.c:3458)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3405)
   kthread (kernel/kthread.c:436)
  Kernel panic - not syncing: Fatal exception

Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/bonding/bond_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e044fc733b8c..3ac3418c9498 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3251,6 +3251,10 @@ static void bond_ns_send(struct slave *slave, const struct in6_addr *daddr,
 
 	addrconf_addr_solict_mult(daddr, &mcaddr);
 	if (bond_handle_vlan(slave, tags, skb)) {
+		if (skb_cow_head(skb, sizeof(struct ipv6hdr))) {
+			kfree_skb(skb);
+			return;
+		}
 		slave_update_last_tx(slave);
 		ndisc_send_skb(skb, &mcaddr, saddr);
 	}
-- 
2.43.0

