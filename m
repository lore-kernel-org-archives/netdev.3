Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67952D9EDB
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167381; cv=none; b=aC+MMioUuypMyejiUHba3ivTVco6KwMaMqv4LemM31ggmiyoJk21ugLJrJW4Im0aBXzVQ3cj1xpONw3ywRWJsH2Cya5VJTLfyM/TgEFzZrJOZv4lR7s1SkXw5PZZ67p0T+lODveG9a955EH/hQ0IeGiWAr892bPKwtoE87D4rQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167381; c=relaxed/simple;
	bh=QYxcDuJlHyn1WCmBCKp35EOPATCh0rELvVAEgRjvnhA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oohHJNP9gmoxpKjQ8/Es445dzteVXpgL0+kfqdBogMsRqp+FFy0QvKbsqhV+TDvM5+W9cCmXpttNbH/yvtJw6tf2JO7HeNI9m9lOLPvhJBGgEdY72bM/kcaQgcrdLJU8HG+hwBb6eQnNgwRphoCO0bFnlC5m9rm6MxfH+z55yzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSe62wez; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSe62wez"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-933023a5980so670930485a.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788167378; x=1788772178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=20fnpYTNp6hWZADg99Vs3quByt/23xw7wIlASlauUE8=;
        b=pSe62wezzaWctsMl86+z0TQXL8UGOkOrjX4eX5yRQB2rbDzxbRkDvx/CNI38r9JWyQ
         /2zlE8EoEXeDu4zA07GkiZISxQl216ypCpQaMb/eLB/3gkn+SvQId2edx3OU83FyHuvJ
         zF9SsSZTaibbLWfat6UBYW6hK2oar++y4e+jvYurtFelHvHC7uNokVL9n5QZJK0OV/br
         ZWqwRmC56yZSRImqH4wMIZBkUmXs/mnTJAnR58zOdpUIrC+Mf/O3BAWU4Ug/PCZbW3hD
         vzznfoSoY9NJmQGnDmzE/d+k1hfWjY53EkUt8EDY9ltPHlfRhP7tpkzq/anJr/LzDFZE
         O6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788167378; x=1788772178;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20fnpYTNp6hWZADg99Vs3quByt/23xw7wIlASlauUE8=;
        b=l1k0ScPp/2p5RWc+9TcnGtFCueGaGBjaQZk7VEb8ksohnRHL/Nxp5Tq3MiRvua4fM1
         vNRni4d08M2Viz4NoSBd86Jqv/mDVM5p/Id4keAbVTzCFc7l7lJayAxOT8qy8KeU5ui1
         UUD6bKR96vUa0q/wURhSM/+EGfg9bBvuTE0/HlP2SSqtlGQ2OPXYcTKncDRO4e2LC7WC
         j7A+Auy2VqepJipn0DzHMmH0Rw9RsadvZfb+V0e+P5OBgorFxscX/Zqaep0u7ZkMT3ZT
         VnOSm1K1sAbavQGwH4JUuZX9OLgLkgeiS/HfHYhNF5INOPRqT8Hp6SOF/frIzKPms6U0
         LZ8Q==
X-Forwarded-Encrypted: i=1; AHgh+RraoakeQkZ+arup3ipbZ3yNC2esv6evSlMSNpJxCpK7OHI6X9O1HP2XZnzPJFzcuYKzbWYzAek=@vger.kernel.org
X-Gm-Message-State: AFuF++miKSQji9fKqJjgNd/4pllvrMrDy5gAwAEeADEDghox+nS4P33T
	VdlnwBiZkcSg9ux0dtSzyC41g9Kh1eQubho2Fa+/tFQGVnH3QN+bxeFuNGoTSkgNITFWHjVrZ1C
	YBEQXHwjJW5ooJA==
X-Received: from qknrh24.prod.google.com ([2002:a05:620a:8f18:b0:939:1ab:c025])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4889:b0:938:fc91:91ce with SMTP id af79cd13be357-939138c4d45mr2495272785a.20.1788167378339;
 Mon, 31 Aug 2026 02:09:38 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:09:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831090937.3342052-1-edumazet@google.com>
Subject: [PATCH net] bonding: avoid ARP flood on RTNL contention in
 active-backup mode
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Tonghao Zhang <tonghao@bamaicloud.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Jay Vosburgh <jv@jvosburgh.net>
Content-Type: text/plain; charset="UTF-8"

Commit f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one
fail") changed bond_activebackup_arp_mon() to reschedule arp_work in
1 tick if the second rtnl_trylock() fails (for sending peer/slave
notifications).

However, by the time bond_activebackup_arp_mon() reaches this second lock
check, bond_ab_arp_probe() has already been executed and sent an ARP probe.
If RTNL remains contended, rescheduling every 1 tick causes
bond_activebackup_arp_mon() to re-execute bond_ab_arp_probe() every jiffy,
flooding the network with ARP probes at HZ frequency (e.g. 1000 pkts/sec)
instead of respecting the configured arp_interval.

If rtnl_trylock() fails at the second check, do not change delta_in_ticks
to 1 so that the next ARP monitor execution is scheduled according to the
configured arp_interval, matching the behavior in
bond_loadbalance_arp_mon().

Fixes: f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one fail")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
---
 drivers/net/bonding/bond_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ef9eb0c53c66..c23cf18a996a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3871,10 +3871,8 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	rcu_read_unlock();
 
 	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
-		if (!rtnl_trylock()) {
-			delta_in_ticks = 1;
+		if (!rtnl_trylock())
 			goto re_arm;
-		}
 
 		if (bond->send_peer_notif)
 			bond_peer_notify_may_events(bond, true);
-- 
2.55.0.897.gb25b4bd76c-goog

