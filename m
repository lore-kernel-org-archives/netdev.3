Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D94CEE45
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829272; cv=none; b=Ixwcd1Qh1HOyCoGTGwWDxnnToFp5gLDWXHmLR8PxReKrK1MtxlsezYIRCJoosJ7CgwODMFe/bsZFS4PufLCM3pHUJh6smZtY4A5ZS9LSS48rBlVsSAfkvvDo3Iq7x/Eg7Hctqe10r48mHcR9m6VYhAEzkF2QXoCOibC2r8N5UfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829272; c=relaxed/simple;
	bh=35anN/46F/wn7lyuyc64Wn3s2LfGYLVid8tSiXKPycI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JPtXRP5W0weabEQATSHno7UYpOMal9W+lcsQ15VN5i5GWpV5inUQv0tWhm5lITLIz3gBIh4JVjuqhctqoF9FoRxl19CJFEwx6y1JfdMJv2IeQVpdEuI3FihQZK/Hs6oxF773F3E7QwVT/8Dc4EjI8zqtqP2CrXWrg7jedI3sVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DRTw348y; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DRTw348y"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e50170ba7so144518785a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791829267; x=1792434067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=DRTw348ye0Q3NufTvpCTVucO86QKPbR+W/yBKdzWMTBNTJTXXtk4CJkeYmXOoUgkS+
         HgkK/aCAIDyysGkEKG4ey/tbsFTTH+V3ODGfR5lfuCZd8crFGVzqJ/w0+28g/kvEQL2u
         80JuZvfSd2DY6imV1nuaFiLgNkS6QC1ugwQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791829267; x=1792434067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=vgvEEyDGr5eZH/rktlafLtmluJYbmlsyB+IY5F37eRnqvkVwa6Fg2RtXGYzpiREO/a
         RZeCvAqqx8og2BuqrzFzvK0qpHKelXZTwESDk1mrb76rq547lIVFlqf/KvI4etGA15PF
         wx0hsaPajZRvO8a+7RPm4NvaSFRLX9vpuz3fJQy6NiV7gchz8o1Ar1HqBrrSI+AP9ddx
         bpdJt4q1JIOw9ja46UhOn7y/NHAJL+fObzxFkxK6R1M1bjylBvq8tCFEQpKsJ8MQFD0L
         5f9iwADp6PY0BkXq/fA+sNEWP4m7vXYvFiqEdUAsmFP/5+glktXdBwZt8Xo9Gob8drB6
         fdJQ==
X-Gm-Message-State: AFq9FYLTnwOKApFFrkD2Tg99AqfZ6Ojx9OqgllZS9rSlxVcNdCar2v3h
	K6IXkNE388Zdua4fGfgloH2zkKAHI4vbmBbhY10n5v2k/8yxxQa0py6/sLeL0+ksXuE8U82IkoW
	si/o=
X-Gm-Gg: AYBFou3sQl1C+oftzTc+Vc89GL2hjdnrT5JVFklvOTm+GD0LiPCgTQ/f5xVm7Pcdmz2
	CI56y5MFn7NPqNMpLH8+h5qJXfrjLSdFLwnXqbHKlo+Sr8BeQ8n4Bl34WW3w6+ZJkaDSyUTN8VA
	oGezpAUdU4UKFx5HTihwvl9eEeePHj1Bf0hLLSrHwalBmLOE2NG0PQY8JUzIpQyuzGK5gfg1p2D
	jx59d7p0ALt/wmcaAx3/XwUE2ivdLePRzrNTCqOX/0zdJEKCywnACewQdpc4h6flAGWztNvnNum
	lCNUCNActyfOUh5kgoeY2C2pQgkXUPvb5Z6ljZ9nnNbDx37Wx+wKRSS+Ok3ZsqmFG0hRAhLpbG1
	i19zogjLWrtTlhQLYcdFjiHy6M78rCHySkkFBWXZKGJFPP+smUw84nS/qvYkfLJ4Opz/c8KLK2C
	dSQoc79TJhjx6vneT/whdx/UdkvIk4/5NYJkHmfJv1d1IWOqgKXHV527G0CVvPWviScY9+XGLUc
	+vGezY3XNH5WYiB33hGNXlAdtt3cpBLpLBexd2WuZRl
X-Received: by 2002:a05:620a:a0c1:10b0:93e:c12c:4417 with SMTP id af79cd13be357-93ec12c4ad4mr1206566185a.83.1791829267285;
        Mon, 12 Oct 2026 11:21:07 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50b6c4fsm45130985a.47.2026.10.12.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:21:06 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2 repost1] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Mon, 12 Oct 2026 14:21:04 -0400
Message-Id: <QDISC-6HS9.v1.r1.20261012134711-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

That alone is not enough: when the neighbour resolves,
neigh_update_process_arp_queue() re-looks-up the top-level neighbour so
shaper, eql and teql can be re-entered, but it calls n1->output()
without restoring skb->dev. A skb that was parked with skb->dev set to
the slave then leaves through the slave directly, skipping
teql_master_xmit() and the dev_hard_header() call that builds the
slave's link-layer header, and is transmitted headerless. Restore
skb->dev = n1->dev at the reinjection point; this is the identity for
every other parker (neigh_resolve_output() parks with skb->dev ==
neigh->dev, ndisc probes carry no skb) and the needed repair for teql.

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql:
restore skb->dev on the slave failure path"), which restored skb->dev
to the master after each slave iteration but left the master-vs-slave
mismatch on the neighbour/ARP-queue path, and left the queued skb
naming the master rather than the device whose neighbour took it.

Conditions to recreate the bug: a teql master with a slave whose
neighbour is unresolved; send one packet through the master so the skb
parks on the slave's arp_queue. On the unfixed tree the parked skb
names the master (kprobe on __neigh_event_send shows skb->dev=teql0);
with only the first hunk applied, the parked packet is delivered to the
slave's peer without a link-layer header when ARP completes.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
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

