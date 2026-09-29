Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5E4F4024
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677027; cv=none; b=qk9A2gpI4rckgKX16Pt+/3PRuSi+pT4PpDGz2mYujsh3hAZAvFAnEvd2YR6+Jm42jFCsui6GeOmU0deBG1iszoOwzxnf2qtTfz9NVhBNwQIyA1MCsJba0cxdlzfaFeeAidS2bf15Ul9Fv+7+PBk3FZ2so6azL7V2YwXb9K7T080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677027; c=relaxed/simple;
	bh=a1Rg097Yr51bniGaH0SmdFyh32jryMA500quhl3/SlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I07ND2GYH1f6yemBIVK+RjWAk/qmhpDR1wppD6h2oTBlCOiit+hWPmz+fiwIu6emQfuCD0qOSnaDE+KhxXRnhGY5p8uIXx1eK05CMiUzsPd51oEhykRnXVuvw7E/LL5O5cq5YO5+jrO9bl058cc5PLtKAYXxUhTN02t8rCUNJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=V7pC8aQR; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="V7pC8aQR"
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b3acd242adso709191137.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790677012; x=1791281812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9hvZlReGddEztlJbTgolgZnvl5WN5QuKtMdmaNjRTU=;
        b=V7pC8aQR1GMfqtdS0vX6QisQVKiU8iO9bsKdPZ0Wm/C6Qsv7zJKFTODBmgDPUU8BzB
         zpVbAdDy9mQGNiLWEN+J3YYqqotEeG7H7ULuwjYNfzOxQQPVDrEgkxx537rwOhle8ldN
         NT6REfZQ3Jo/6oDf/m8Q1ki2BY0ieD6k3aIZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677012; x=1791281812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s9hvZlReGddEztlJbTgolgZnvl5WN5QuKtMdmaNjRTU=;
        b=cwfvnWT06+WY7sMEt6Sbvb1Qwy3W++NfNjCB+g+j/4xzNRJjD0Slc8TyG3ZxhQ7eow
         aRBXAwTDovK0CdPNzy6wSwHns39vk+zSfiwPWBUhTWJFNicSrDzr0FP8dq4e0FIdedjj
         DrNOpcoi4fm+r1a2qLJ9rIekL7A5/UbW1whjR9gc66DMNEJ6bd+enaaRXGVJ2AKxxPBQ
         ZBYIr/xsI4LhC1eSYRUMItGmiQpL8lXeQDXswnl5PDU6n6YJ/pmH7G4gktStoI7CapqI
         K7idpOC7jS03z4tycYlZdePdVVNK3z/wOYtwaGfgjEg98R30F/IljAVUAK66COKwEz8+
         JvYA==
X-Gm-Message-State: AFq9FYKydAaJ5DmfHQ8WjcLu1TIXxPM9AJJ29vZxLeyP9GWjv7ZGnihr
	+hwxNLZkZjdpZEXFa2lDyFHjhx+iFB6Ju1ggk2ZKxMXst23VlM0Z2sQT70VU7LxoZ8sWRg7QkF3
	ErjQdSw==
X-Gm-Gg: AYBFou0wIU6dAvrZoxsyNsoDnWyBZ2bX5pBYYGFBo1yxHhPpiawYhQCyHGa/zW4LEGo
	A42sqpjajPD4vvlC/Rvi/jP5+rguV9Hz/28+fnFUTS7QMrVMEbaB15JIysyge51eAsUo4+M9R2q
	rh2GjPiePEgETAYC6HcETfKn35pFSux3LEM8rPUUufzt3JbC4K4fRdOZQfu1juALlU4Ea06Cl4q
	QcylDq8rhjNLlhAz/z/W9EtVd0Bm8PsVrC2YVxEhvasffLI2SjFBM+JABmj9ugykaa4my/SPftk
	AHy7TUqC406bvyUch6vev/okN6Egxf9Sf9dLtSN20+G2pZEC3dYEa6A59SPzCooqmSTntaQCMf6
	u5SQ7mAE5MTev3dZVMd/eHtnIyjgd6J63mpl/8VloSyeHTmIZFDPUJ41hbWa0KaRxywzZZrUefA
	L4iRqAQkaSEEg5aeja5ry7Y7fcElICej38yBCo7s7n5ExC2ukuJnEVPTLQ4bQrhtVkPhdK5+Wqx
	bEwp4FPsX3itastBvtxyqC49SiLe/yL+Q8ZA1euGUiFu2jJ6g==
X-Received: by 2002:a05:6102:869c:10b0:7af:7db1:8291 with SMTP id ada2fe7eead31-7af7db19351mr3104730137.5.1790677012425;
        Tue, 29 Sep 2026 03:16:52 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b15808esm13134189137.5.2026.09.29.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:16:50 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue, 29 Sep 2026 06:16:14 -0400
Message-Id: <QDISC-6HS9.v1.20260928064754@mojatatu.com.2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path"), which restored skb->dev
to the master after each slave iteration but left the master-vs-slave
mismatch on the neighbour/ARP-queue path, and left the queued skb
naming the master rather than the device whose neighbour took it.

teql_master_xmit() sets skb->dev = slave only right before calling the
slave's ndo_start_xmit(). When the slave has no resolved neighbour,
teql_resolve() hands the skb to neigh_event_send(), which queues it on
the slave's neighbour arp_queue while skb->dev still points at the
teql* master. skb->dev takes no netdev reference, and the master is
freed unconditionally on teql_exit() while the slave is still alive, so
a queued skb that runs the ARP retransmit path can dereference a freed
device.

Move the assignment to before teql_resolve(), so a skb parked on the
slave's arp_queue carries the slave's device and is flushed with it.

There is a second issue: when the neighbour resolves,
neigh_update_process_arp_queue() re-looks-up the top-level neighbour so
shaper, eql and teql can be re-entered, but it calls n1->output()
without restoring skb->dev. An skb that was parked with skb->dev set to
the slave then leaves through the slave directly, skipping
teql_master_xmit() and the dev_hard_header() call that builds the
slave's link-layer header, and is transmitted headerless. Restore
skb->dev = n1->dev at the reinjection point; this is the identity for
every other parker (neigh_resolve_output() parks with skb->dev ==
neigh->dev, ndisc probes carry no skb) and the needed repair for teql.

Conditions to recreate the bug: a teql master with a slave whose
neighbour is unresolved; send one packet through the master so the skb
parks on the slave's arp_queue. On the unfixed tree the parked skb
names the master (kprobe on __neigh_event_send shows skb->dev=teql0);
with only the first hunk applied, the parked packet is delivered to the
slave's peer without a link-layer header when ARP completes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/neighbour.c | 1 +
 net/sched/sch_teql.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7448320f7ad5..5823f5007812 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index acd03f9afc6b..3fbd5af10028 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -348,12 +348,12 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		skb->dev = slave;
 		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 
-				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
-- 
2.43.0

