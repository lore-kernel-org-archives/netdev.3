Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492717;
	b=lWV/5OCxM8wr01TaptEHHse6RMfrd3gvSNZjsbwQmF7g8G79nJsEGiO4KqqEM/Ak9fsF
	 fmnMn8pShDaBPL/giEMbU9ufSX8R1vGsr9MtuqMKm8ErpU+PBp40PpEttj36EedLciXgG
	 3OGu8KN02vK5HFb+GqyKnF9WTl97/ers3N45f42Xeth+oxFoXt2vYFvgqcmQV0zbcA0W6
	 MiG9oiBdeAw14ZmUbZKkKhNc/12q76TpXqcifYxVUwcP+vjA9n0CT7evOGWze2HUpPj7x
	 Swdl3WwU6SBTeW1udde6lGhBGaVaf60axs/e27tb0giz953uryFMP8lk64/FXbpbNBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
	b=m+W7n0anhZW4KAakcaIdsUU6Fp6aouPjKT1TZ3+1evy0JTXKdZWTn03A7XxWNB2yLKlF
	 STv5V00HequZcjGS1II9zO253AZpw2kwz/FUEmuTRzqOyjBm0Qi63re6MtDlD+88flxCa
	 +Og43YGML1KdHvxWQgtGydhhi8w1b59cLjdIQaNNnUUISAW7oLwK5surcK2yfxOyexgem
	 9w4BQwXrLbtW5CcGhpb7h9JQ8VGpQIYz1psCpgnSBSteezlnOdnzgNIuoNynI3nutETVG
	 mNTiNI/PpJM6wNSoWel0bbJ1ytg5aEuw6QHSi7JK56l+PCKboZ+jANcJAf0fkNUNTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=bSOuHo0V;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DF606A32C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 934DF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=bSOuHo0V
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917997ab0d9so26660046d6.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492715; x=1793097515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=bSOuHo0VChRuxXqgAqzeZ5y5gJVxqIMp9ZUNOXlpSfpjdXjV0a9DjNVCEJYWxcuhLg
         vCzguybR+vrrH6srLzXrJecE+HIKY2UKqNibv0H0Y+iZAfKjP3YQUrHXBzPp4X3eFUpo
         8hnwPnGusRZ8KdiA43s39Lwwzl2BeoGdEeUxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492715; x=1793097515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szEWv1HNLVZ5mm2G563EJn2Ompg5wLmZpZr1jwSri6M=;
        b=ExCO7c0ac/arZMObn+J655wvPXrsfsycQW9aQOpK3yqJxk6CTY57KLiQie+sfHp+6j
         5xJt+kk1v4SvEvK3F8aq7H8juvxhoZEjSomdLBQT3FoQEODFtK6zKwDduv3Ymmd2ZIxH
         HHNdei9UpPogn5u8DE/KRFBOJd5O7qzKUUSEu4b913/HkCqpFO6p9GXLiZZ8Y/TcT671
         +yH13zwsCrSMOvRCK4nTOf0yLXQKgaWLTQFZfBm93zeQZQLW4qTYKTXiINxH7B0MzQjz
         l/OEurZmDb+oOfJRrppsgyB/fSZv2cqrsgzxT2z0cGypur5SnU4flUDmy6hv377HBQhZ
         aK1w==
X-Gm-Message-State: AFq9FYJGKwEjBJhBfPEWFvdQqAluRSBLSBu5ThqmFKUUg/2kTQdqUV7g
	B+KLg9ZFDnf10NezO+HdLJz9pqg5K3g4GNqt9AAnKofbEiJEmUwQ9buCjmkyX+XM4NwENKcKXyT
	gHiw=
X-Gm-Gg: AYBFou0tvGov/f69fO9WA8nzELRepWscciTn9Zsg8YQpEa4b3PXE4obBWKuBoamkZIF
	Q4yedtdggdDXYh/z6NV2T/g0MKSnm4P/YqaEsX8YeoYjjaaGqoHVnlpbFRVwMuPvsbg0z5Bvfxq
	qGcAgwK8+1/3CcAYvn/CSyf1QJ7tLGJHx+wnNVfsGTj4m+5+MGnYv1SWoKhtvkTclV2osON65H6
	SWd2B8IFznkYq+41XmZWL02XI7TwxLKdX5g4duV3S+XwCFhdqN36sKfuN62v9D/m0atvahD5zpF
	brn63Xz304FCoa+6jbZY3t01CV/0niDnJcnDs8HlIu4uOxC77/HMeXS/s7xFVZEmWhWqs+2KVjk
	pX5tQeff7EmNFemi7GFMuIIRPn3q+EHIg4BQjJYffgPvuPJhRDKgC/GU3N/UTHYcL0haxRbUPuw
	qLzIhTQZPy9YsZ6ZPpXTNjwIXQf93Mb968vXLOQhE92/2+dGBDo5Ja65/zVAw6ZU9oIw7Ph552H
	+ICMrJIuOedKYQXtEBiBfm8QZWZd1E8gr1jkm53AwXghjHNBoRnuppYZudc7eu03tN5wMbUgxAM
	mb+cEmhu8REgcInMm35uMWV6CnBITQ0nVhjrLCRute4wdw0=
X-Received: by 2002:a05:6214:d87:b0:91b:a948:fbab with SMTP id 6a1803df08f44-91bdec2ea1cmr184223406d6.6.1792492715479;
        Tue, 20 Oct 2026 03:38:35 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040b4915sm23275556d6.26.2026.10.20.03.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:38:34 -0700 (PDT)
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
Subject: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
Date: Tue, 20 Oct 2026 06:38:27 -0400
Message-Id: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r2.20261020051718-1@mojatatu.com>
References: <QDISC-6HS9.v1.r2.20261020051718@mojatatu.com> <QDISC-6HS9.v1.r2.20261020051718-1@mojatatu.com>
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

