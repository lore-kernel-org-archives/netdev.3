Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB79282F1D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140455; cv=none; b=m7LA6myIDuzl0YSjqMUXQp0kSgFkziBD3YY2mQOkysHD0v+RL84zjfmLGesqC2p/UWStF7NhSbcJs/Zbg0TI2qosmfrjt0aIl+t5jA/7ZM4i0O4unsu1PIQvjksKb/pWIk6lcj35KIBfseynrKP+lMnf2K4mNCc7Ax90TSwhhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140455; c=relaxed/simple;
	bh=wawo+HWArGTMCt+S2qKcVQwGBT+E0mr03FFdusdgGKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlZBIHcekqXWT3q4hKaXscQ0+bKJiia8QTMBFB09ZNAZ8OoPr7+Pnpetvg4r5J4gwPvt8m/1EbQt0hHQGGCsQ/GafXuoR/63cxfb8Or/0HjTHuDMoxpOtljsMnPmrpbe32bkchgEUuzP2BMHL6pc4HF4gz0kEX8YkzA9rWdpfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=EKRT2xsA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="EKRT2xsA"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5351748222cso20811411cf.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792140453; x=1792745253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1YO8GZRPT+tLk1k1KaGUnKumuD+56wkUQINq0Ps5Q0=;
        b=EKRT2xsA13x2GHMORY/yh46Pa7M7Uo3TGsEFBV/xzm9bIcvIUsmMEyzPLuOjJ25w2l
         52YjOwN8q0OlM9Or15zQPAk9AZma8LpQfhBkkt76AOpwraYP77nPQkkKrjT0Ll0OR2rl
         yvz8Vi3xypqkRJ1m0NtrADdSMpK+6BKWlhIOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140453; x=1792745253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1YO8GZRPT+tLk1k1KaGUnKumuD+56wkUQINq0Ps5Q0=;
        b=anYX+8IEC8aeUUj5BfFYxIM9vIsOqHxvYgr/qTcK5FTOsk6l9uo3ExTmoe0gq+o2a+
         Olj7WSjcjySikQ5b4NGcnME0q/tC01W72fQTDwDuHGbrWS8rZLzcH4bZAgFGl5x+7CN8
         +hIt8zLdyhtx1bU+NC2ol8bbbq4yr2L3QChjMJmh9MGJ1i3Qp5gLmAQBqSPDhFSQ/Sl6
         A3TN3H5m1mWBivsWVf1ea5T2OKaSZMMyaf27GCSA/BARbY5YO/UEGu1TGZeih5EX7gXA
         w8EaFtlc9wLvuADOfczbN2+bNCAZU4Riv2tJMT6s3xuLjkZY5dU54mAuoVcT0M/bA7TO
         Kedw==
X-Gm-Message-State: AFq9FYLdZFnMSqd1NEYcHolx9qXIvMGVDM/KPIxblLDbnVYZqZt2hjoo
	EQvl+nXW3sZD3WPgzZb/SNede1YppW4+2zaBNXEAf78oeOMu6iyf9dIC2zb6WbVq6WDfod4IwRK
	5CFc=
X-Gm-Gg: AYBFou34z7CNmdgnWaGEq3vIm/Z0SMXiMXU2PAn1B8eg5et9OXJQFpiRo1S5bxO+ngY
	auFXIrdL7WjfMxekU3U8jOhJ5M1ZCjvPR4KwledpWE3q6YmgYChsFHFX0JBsFwu2cP1bK/ckc/S
	j13RFlaZqLRrcgdp86+VV1lRtDqdXUmJ7ar5QJWMbn2Zjq+1ymNySzcuJxC7GwmnwYzwXcwQD4d
	i/teMlKR8l1ZCdvPJU3xJCfauwQRFQ30+Q8SPmfmvoSr9CiKbsZzrvSswlmun+UhwBIN3ujrLBs
	eJVOkDqxsZLo81fQDsqPTR3PikVqMNg188ObDlA9KBKfI5utfULmbylykPn1dLA0JuWdCQC7GeH
	HAKbKAiMBhCtWff+aSZRrMR1C179KRrI1n1V/U1WbYaMI36Q2Pt7AO0dya7A6lIdK+56z+BUm3p
	baAhPU2UDLbcwxdKdgwKuUub3CDbSU/a3Uzb2S6DimPSbe5wcANRQaA1byWAgE2OSoM79R7p8F8
	H+lOr+scfdmkUxq1Knt1xzCjelfAD/bd9ySvVLSY5Mc
X-Received: by 2002:a05:622a:4d05:b0:535:ed1:cdbb with SMTP id d75a77b69052e-5359f46d560mr347991571cf.1.1792140452812;
        Fri, 16 Oct 2026 01:47:32 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm17863946d6.1.2026.10.16.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:47:32 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: owen kwan <owen@verialabs.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop
Date: Fri, 16 Oct 2026 04:47:19 -0400
Message-Id: <QDISC-Y0BY.v1.r0.20261015184107-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
References: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: owen kwan <owen@verialabs.com>

The issue: teql_master_xmit() tests the slave's ndo_start_xmit() return
value against NETDEV_TX_OK alone. A slave that consumes the skb but
returns an error code (rc < NET_XMIT_MASK, e.g. NET_XMIT_DROP) is treated
as if the skb were still owned, so the loop restores skb->dev and calls
__skb_pull() on it. A VLAN slave returns the result of dev_queue_xmit()
from its ndo_start_xmit() (propagated since cbbef5e18307), and when the
lower qdisc drops the packet that value is NET_XMIT_DROP after the skb
has been freed, giving a use-after-free in teql_master_xmit().

The Fix: test for consumption with dev_xmit_complete(), which accepts
NETDEV_TX_OK and every rc < NET_XMIT_MASK, matching other callers that
need to distinguish consumed results from busy.

Conditions to recreate the bug:
With CONFIG_NET_SCH_TEQL,
CONFIG_VLAN_8021Q and CONFIG_DUMMY enabled, add lkrdummy0 (dummy) and
lkrvlan0 (VLAN id 37 on lkrdummy0); set a pfifo limit 0 root on lkrdummy0
and a teql0 root on lkrvlan0; bring teql0 up with an address and send one
UDP packet to it. The VLAN xmit returns NET_XMIT_DROP from the lower
qdisc while holding a freed skb.

Fixes: 572a9d7b6fc7 ("net: allow to propagate errors through ->ndo_hard_start_xmit()")
Cc: stable@vger.kernel.org
Signed-off-by: owen kwan <owen@verialabs.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index c7dcec25ef42..b3efd5c28198 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -350,8 +350,8 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 
 				skb->dev = slave;
 				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
-				    netdev_start_xmit(skb, slave, slave_txq, false) ==
-				    NETDEV_TX_OK) {
+				    dev_xmit_complete(netdev_start_xmit(skb, slave,
+									slave_txq, false))) {
 					__netif_tx_unlock(slave_txq);
 					raw_spin_lock_irqsave(&master->slaves_lock, flags);
 					if (rcu_dereference_protected(master->slaves,
-- 
2.43.0
