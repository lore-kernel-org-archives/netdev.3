Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550485;
	b=neNSUcQdGuYqfJmiRMqkXu6y56DXX8gshdbH8Uw3R2D8mKH3JpfgJD7nMYHYIb0OIM3b
	 yXIfCBhg/tGhhOpeCmU6cw2q4rBFuL+RYiJ+IzOfvD46fV6CALeDGaj2pD/x1Dk2eWRcN
	 1doTQonqIAiMdiEgoaJ9A2/IrhEjYNOpKuhL4uJCRs3UMl5o05IPuDBpT5Rnjl4VnPiDT
	 SqXbYZByeE1IFIzvt5/x0debNd+rQlcfdUQsYflTu1hb05aMp08kfc+772CiElU3LZMfO
	 YbTlBT2y5alUsbVy0I9HxfIwNbPtVuW9zO+7DGpvuZqbpve4J4BFzivyj2Z7r9bxLzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gOUXslQy16hktD6E8nWSkfJmsY620ocO63lUGplRni8=;
	b=lrRQixT/WBuHzwMtrtq4Dm2mp4U24zc45eTK1I0+qaPHdxtazUqwinIFiB7LMGYQo0ui
	 zeRxLmnfD0s1svk4up2Y6PASGoX1s/s+FMs3us5bNPivSmccGhSYbPu1Nheo9BMjKPoFg
	 vVE5cfquGuYwp8F88dDr9jT1Q+7kag4V5ODAntY+VjDDie8/K3M3545UKOE58PSOb6DrS
	 EYVT6WhH/psbap4FQAb0/aIpccFnHmVQoIoTuh4w2DotW0KnNI807b+oheWNAcCDfP0/c
	 yenpuPjVGRHM9LcSPISOCWz0qTB4IkVD2+FfgpItk904QOWdvYjHTTC77wAyKNCIoQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KlSbhk99;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0776606A330
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0776606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KlSbhk99
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53bb57f1310so30388841cf.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793550484; x=1794155284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOUXslQy16hktD6E8nWSkfJmsY620ocO63lUGplRni8=;
        b=KlSbhk997vYicLVChZABuzfSGqZO4ISJcWPChRKjMTX6ZLwRdmt8W77XAKkDK3U5Mo
         YxSMeZZ3DdfnlYlb1WTGyTow3tbSO8Fapi5fmUoAULoLCnom4VQpGp/ke4gdWO9p30LK
         mkPjJ/zkVWo+YzECxJlcWe+TYxSTAct51O/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550484; x=1794155284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gOUXslQy16hktD6E8nWSkfJmsY620ocO63lUGplRni8=;
        b=KP1Uk63GdoBNduIMrAjw8ZBOJig9ergfM1ZoixbWgMEtCj2RLI8fQftQtpgv2zEiD1
         VGX0LIVMohGwfoDoaOFAXAVQrJUMMgfqqV6jXMNWmxIEkNdK3XsTKsfCSwDyZGIX1CBF
         UUjSJjVnb6yHE19mttmAaxteNCrotKJ6RqfhqBfjjjlTL4p9sjDL0gzpByS6C11iygJc
         JEKaKbYNOKnjD+sVdrZno94hL2e23E5wtR5HqIVxCS4iX1qmKgyPHplq/f4cmgRX4tzS
         qo6Sp0kmKeVExGhFjWkpdUodYoQCMuNLs1DZ2nfavG/UqrqIE2M2vXj93kvOi7srjvkn
         llaw==
X-Gm-Message-State: AFq9FYLqmjx15kKqswG9NAFsV6rDjn+TFUX9TDYmxz/hpzeb+7SgNTUn
	V26GwLD88H2gdWLa6W+K6USSxx56CeXiMarPpoZo2bv1nVZXbIv7b2ZiEG1PXuQXHT3IZFXZfcQ
	w50U=
X-Gm-Gg: AYBFou2TGki6Z0+f5/3S+YkV54hvPZusDg0j2Kbf4xB5L7uwjJt93Wu5v16mfBXxUeO
	BmHtphOIQcPsDw3h/GZ0OdzX/5xU625OWvdW8IRpNe3dYVh6EYoSI5u2J/KovwNLZLxEQ+YVhnP
	1s4k+gjCQTMYmzQ0GRdwpQMAhyzPC/AQQkIZJkjA47DTYgWgpSMF/pqx9RWLCYQZFA7ck/VA+Le
	caH+ilV6oD65R8Ir8lOMJQ9fu4maJc6UneS2t/g6WrbaxLwNkdxWtY4joYJMadNp1X9xMU5A6P+
	QnV8fER8OE1gcpaQuPODXXUK3IVJKv603rtCqI5KUOBbjLx5CuCjHMt3sY/emRYLxtZNGv/9WX8
	7H+bLr2U864idwJ38gqbCiImFbXyuH/A87oeDj4eESsg39ijijpF+KNWQyQWp8jjEEOCpH78wXY
	EciaagL+Qsopi27ZLNpcQC4wTD7KIz9O2GgxzmO9AIIcDEMJZaOgCycDMvPnRecaSETzyrifpNR
	1RmtSM0ASme2OLvaSlXenPJfPzteRpe+AnsdVYW2NKkIbymCFo4FnwuuZcEsfleU9z+CiywTrSi
	JcNw12mv2HDEPsRC7ssWDMYpM8Zms1zR39xIKMaPenFmkhjUQz1p8q/1P2dj7rQM4AOCqtnnB8R
	Id0Prr9Gwi9Xh1OUy6jlkppFg2Bv2M6iMOW0W
X-Received: by 2002:a05:620a:2801:b0:93f:26d6:d70d with SMTP id af79cd13be357-944216a23bcmr1387687485a.31.1793550483739;
        Sun, 01 Nov 2026 08:28:03 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5492sm627354885a.1.2026.11.01.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:28:03 -0800 (PST)
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
	sashiko-bot@kernel.org
Subject: [PATCH net v2 2/2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Sun,  1 Nov 2026 11:27:56 -0500
Message-Id: <QDISC-6HS9.v2.r0.20261101105945-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
References: <QDISC-6HS9.v2.r0.20261101105945@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path") by Victor Nogueira, which covered the
slave side of the same mismatch.

The issue:
teql_master_xmit() sets skb->dev = slave only right before the slave's
ndo_start_xmit(). If the slave's neighbour is unresolved, teql_resolve()
parks the skb on the slave's arp_queue with skb->dev still naming the teql
master. teql_exit() frees the masters on module unload and a slave can
outlive them, so a queued skb can be reinjected through freed memory.

The Fix:
Set skb->dev = slave before teql_resolve() so the parked skb names the
device whose neighbour owns it, and restore skb->dev = n1->dev at the
neigh_update_process_arp_queue() reinjection point so the skb goes back
through teql_master_xmit() instead of leaving headerless.

The restore is limited to a top-level neighbour whose device has no
header_ops, which is the shaper/eql/sch_teql class: those devices get
neigh_direct_output() from arp_constructor() and ndisc_constructor(), an
output that transmits on skb->dev and builds no link header, so the skb
has to be moved back.

A forward that steers the skb to another device, nft fwd ... neigh or
bpf_redirect_neigh() with explicit nexthop parameters, parks it with the
dst of the original route still attached. The drain looks the neighbour
up from that dst and not from the forwarding device, so when the original
route is itself a headerless device this gate matches there and the skb
goes back out the original device, running its egress hook a second time.
Those forwards supply their own device and nexthop and do not consult the
retained dst, so dropping it at those two sites is where that is fixed;
that is a separate change to the producers, not part of this series.

Some context:
Only a module unload frees a master. teql_master_setup() installs no
rtnl_link_ops and default_device_exit_net() moves the device to init_net
when its namespace exits, so the window is a parked skb plus CAP_SYS_MODULE
on an unloaded sch_teql.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=y, CONFIG_VETH=y, run as root. Create a veth pair,
make one end a teql slave, give the master an address and a route, flush
the slave's neighbour entry and send one packet:

  ip link add v0 type veth peer name v0p
  ip link set v0 up
  tc qdisc add dev v0 root teql0
  ip link set teql0 up
  ip addr add 10.0.0.1/24 dev teql0
  ip route add 10.0.0.99/32 dev teql0
  ip neigh flush dev v0
  ping -I teql0 -c 1 10.0.0.99

On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
still names teql0, so the reinjection can reach a master that teql_exit()
has freed. Moving skb->dev to the slave without restoring it at the
reinjection point leaves the packet going out v0 without a link header.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v1 -> v2:
- Limit the skb->dev restore in neigh_update_process_arp_queue() to a
  top-level neighbour whose device has no header_ops: shaper, eql and
  sch_teql output straight on skb->dev without building a link header, so
  the skb has to be moved back for them.
- Say how a master is freed and add the conditions to recreate the bug.
  Considered comments from Sashiko (nipa) and Sashiko (gemini).
---
 net/core/neighbour.c | 3 +++
 net/sched/sch_teql.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..541cf699abae 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		/* headerless outputs (teql, shaper) transmit on skb->dev */
+		if (!n1->dev->header_ops)
+			skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index ed8faa848f18..4eac1f9c8ddf 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -368,13 +368,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
+		skb->dev = slave;
 		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
 				int rc = NETDEV_TX_BUSY;
 
-				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq))
 					rc = netdev_start_xmit(skb, slave, slave_txq, false);
 				__netif_tx_unlock(slave_txq);
-- 
2.43.0

