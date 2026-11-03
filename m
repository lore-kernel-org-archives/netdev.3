Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709564;
	b=NgatKXciH3IgmpVmOMZwbxRwE8j0Vx2yx0IwVmEPxG68P/CReOGwzXE6rBRoWFGDx4ky
	 AJQST8qJixsjUt9C+qgv2ppRAOGtB8hHGgA3n5kHmVw48RfqbUMDyZZ8BsQDeNJZc331B
	 19raGieYmZ/+5g6iCGAY1NhUd+E1NqvWGSJJkH6N+RQkO5Er2pFHk2pJVk/0fpTZb1D3D
	 Xn0kUup+1yeTB97aQ1ITltWF3KE4M3adeuBJ5gyzSh0bYNX49lJijkXUEHl9XMzU37paI
	 dW7FFjJnflq1MgUgSQfRxy9rePZKGvfg3+shQM4l3E/ivOiMX0Y++nVN9clq43Knjsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ofvq5FLhnMECrku4JyuMhVfMEP2OXqyCFi38cWfGgIc=;
	b=rUjIIwdklZcTnDthDtE+NUIeNfSquW0BT5fihfl8MaTpHHoy3CaWa/tIrg6qW3AEeB9H
	 PssQheVXbwRcgr1Rdww1jwBIwjYEtev6eGy2YRaos79LK9uzbXrs67pHgvdCblYLiGdqS
	 DBR6Ffo/xLFPf13FvL78WvikZjR/6q9w/lUXKNa/9vae7EMPL41zOhPxjTCAt2+K2ndxr
	 ZF1Z8iTpZxnsXF/UNpA2Euyv2r3zG9i2m5635s9fNF0bBMgm6rUBEHXNe0ZpHBTqKJyd2
	 NzsexYEnFT0BBKlqbVzHzBSGQ3UvfDhb5bA1Gjzq3K9qbs8ITGyJ7Z0hvn8QUvEMYRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=B6gf7HWV;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C577606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C577606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=B6gf7HWV
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab432273c5so37698717b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793709563; x=1794314363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ofvq5FLhnMECrku4JyuMhVfMEP2OXqyCFi38cWfGgIc=;
        b=B6gf7HWVYBkgEJLxpQvRQClGOADBPj33OVqHdCX9JY5A0Lak1Xc18isduj+/lwASfj
         NE6APutcqLaotXpIV6PJ9yBWdffdUaJm9kqEt9js180KYC9N7jkRSKLHm0mc4PNhf7lt
         Ahtjcu5Q1200wjMuGQ2665Rwm7/MAD62Ql/Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709563; x=1794314363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ofvq5FLhnMECrku4JyuMhVfMEP2OXqyCFi38cWfGgIc=;
        b=RwB8409y4FL5gNTcX84Y2ZjApG/+4CnHb3KUB5HXbabDJUOdKCBG5/q1MZzC0WM5zd
         Ebe/l6jN+4jaqmSC9sr1ho/P2HheZpzGZx2+TzLNU8ALh+TqsBggR+f1LDsqrzG3n4/R
         4031NQYzNd3Pd0kK3hHj46a9yFHqxUV7YaKZyDLY1MsxEBRch1bO7KCFHMumgFTXceq2
         GQth0H80ZsAOB93id/ftONcSM2ugslggqtB8dOXWcFN0RbhqRDURrjc59Qy8R0gDB1xe
         e5d+HSi8F2oslq4XhNQfYVCCRFGXPFzltDGUp0fEbGOWkka9C72Pk04H07hHSCCV3Dxz
         tICQ==
X-Gm-Message-State: APuU4Z8c/1+6ocPmALOeTB8HBjGTgicn83fmXTJljQQ6NlTrRDriCuCf
	9bcUiUMszi/WK1vAw+YQYaM/IN2f65c0IFvi3tZ9SPdTx/J06TR2h2E9NQc8Lbn4IADjKmTkfhI
	YUCk=
X-Gm-Gg: AYBFou2VTwTmZD2pHEYYxjwjWUIehWfq5jZpOjH2bg29Q6mAnGF8sD+OO7fzlEvNyxh
	9DiteWvl7bsPxPjceB3BhJGilOyCAWxEX2BIKHg/on4LoThsh/bL0pqDMU/ju5r/lt0+DqcpLmS
	4rz7bPKHCk+I5TOsyiVoUGmsqQLX0ezXUjKWL6zPDACCA8USL2pvS6DtgsMVt4EndrX7JEcEa7l
	3MgzDjUJtTZMSnX42Tjw89iKOx648WVPSpHMJBu0VYX7l9Tqti8P8ewaa48hBSUofPGp/68jLGl
	EHnqpXPYir3IPC6kILIRa3RY8Pkc3dQdP/bUop82L14TUSzkuriqPAgnchea5lruRwnw0SRPfHS
	v0wYb7SfnxCzcvP9TwtLGB0pFBxfaiJBoHv5xkaL+6BIfqRm1jH7b4RmJw0NxJr6/plqLcYc+JU
	xuK9jS8oHMM8I54G+DcQuKaZ9Y7i4Hihw+D/IbIA1Q4QfcNDUx2/zBKNG8NKTHGmwbaeY3l7Xtu
	Bmoy3yRg1jRBrqqTi/iyHBDaqaWV+FhgPPab7w47+fs2Aiev+cJVA4Nr8+DnhwU8sTGVTLjPbAg
	mmJ3n49bthfYVOxkhPDo4jg/R140zd03EmH6UakEOynuJLunHt3ONdrFaJe4YKoDtTnmsm41jRi
	SHgQYqHyGXq5MLasw
X-Received: by 2002:a05:690c:fd4:b0:8b0:ac82:afc3 with SMTP id 00721157ae682-8b2b672314fmr99305687b3.21.1793709562893;
        Tue, 03 Nov 2026 04:39:22 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b716d420sm72011827b3.33.2026.11.03.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:39:22 -0800 (PST)
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
Subject: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue,  3 Nov 2026 07:39:16 -0500
Message-Id: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
References: <QDISC-6HS9.v3.r0.20261103062649@mojatatu.com>
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

The parked skb has a second consumer: when the neighbour fails instead of
resolving, neigh_invalidate() hands it to error_report() and
dst_link_failure(), which read skb->dev to report the failure, so it names
the slave on that path too.

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
CONFIG_NET_SCH_TEQL=m and CONFIG_VETH=y, run as root. Create a veth pair,
make one end a teql slave, give the master an address and a route, flush
the slave's neighbour entry and send one packet:

  ip link add v0 type veth peer name v0p
  ip link set v0 up;  ip link set v0p up
  tc qdisc add dev v0 root teql0
  ip link set teql0 up
  ip addr add 10.0.0.1/24 dev teql0
  ip route add 10.0.0.99/32 dev teql0
  ip neigh flush dev v0
  ping -I teql0 -c 1 10.0.0.99 &
  sleep 1

The skb waits on v0's arp_queue while the solicitation is in flight.
Remove the qdisc, which drops the module reference it holds, and unload
the module while the skb still waits:

  tc qdisc del dev v0 root
  rmmod sch_teql

teql_exit() frees teql0 there. When the solicitation then fails,
neigh_invalidate() drains the queue through arp_error_report() and
ipv4_link_failure(), whose __icmp_send() reads skb_in->dev; that is the
freed master before this patch and v0 after it. A resolved neighbour
drains the same queue through neigh_update_process_arp_queue().

On the unfixed tree the skb is parked on v0's arp_queue while skb->dev
still names teql0, so the reinjection can reach a master that teql_exit()
has freed. Moving skb->dev to the slave without restoring it at the
reinjection point leaves the packet going out v0 without a link header.

The park and the headerless delivery reproduce without the unload.
Freeing the master while the skb waits needs sch_teql built as a module,
as above.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/179363700308.3131.11778179538290251434@kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v2 -> v3:
- Fix the conditions to recreate the bug: reaching a freed master needs
  sch_teql built as a module, the slave qdisc removed and the module
  unloaded while the skb still waits, and say which part of it reproduces
  without the unload.  Considered comments from Sashiko (nipa).
- Name the neighbour failure path that drains the same parked skb.

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
