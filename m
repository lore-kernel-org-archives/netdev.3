Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852464;
	b=gjNMAOvFXi69Ip5E3IaiamlPLhbWPii3jwdbbqYCKajyVkgkPJ9DLbNKTwBuPrVhOzpF
	 02TOYFCBut3aRqcFG7/G4lPXp4gWOYtrv5/zqrDIJ44XRM1gkxftXiEa6V6b8fGHEjnMD
	 2KvE1DM+RkXS58ZpeGThx81ruuSgtay2oDYgFBenBAAN7ATKc4E3iIhE/Fz6Hbb8jKOxO
	 yjiDPxgU+pcEmRSFDR/B85/fI042iCb7GMOZt8iEojCp9OuW49DHzUcu+P36/SBMWajP7
	 SPJ7Bgr6DpMuE9ox/D0jxC6J1GZOwAMxPqYPSO6UWs/zZsC+aW8t503MH9koC6bQdiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DqyrElTlVQDEtJTy9u8cLLzHoS5db6ulKLXpdx4peV8=;
	b=v2AYBm5UKvnHdiXZDFUAuqvvpqyslavu+EF5Pov0Sfe/vmzljC0seMAkoZqWM8i3Yk3O
	 EL2ZhO8BVue5qiLmv6NL04Ad64ZtswzwVOl8WGtEqYlRj1yNI7fFxmi9Jj5VXjVC4POVo
	 nYcPDcpK3vKMMd9p8MCkHTEW4yxKQCSdWEOdEf7ipwU0EOU8t6Qg8Phq/seXulT08xO2R
	 aPJ4ObL/C98t/LV9RCQnL3kOGXlKmRH9i3z0D5+rJw63veNcshyuw00vJM4RyxwLgB+U9
	 vej9nWG1PH0xreCMviwEx4ZFal3eR6NudZBBMd8fRZaG/EnSJ1yUiVz0XEauSJwL4lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=szZkbo4h;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42E606A334
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 14:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB42E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=szZkbo4h
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917c04630c2so18556696d6.3
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852463; x=1793457263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqyrElTlVQDEtJTy9u8cLLzHoS5db6ulKLXpdx4peV8=;
        b=szZkbo4huFdA0qAokSxTLHJGEW7WossaBqFooRqxKrUz063lzP4tURtZTkmy6OZWFY
         A5BgTN/VwtgFFrz3uJDrwJJVxIJ1lVYgRb2XMHAHoFlzeeb0W3NR0HzOcNVx10gO+EVd
         U0rsSFIFUi3wB0QnL5gOlSSgUgwEWi/0txoaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852463; x=1793457263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DqyrElTlVQDEtJTy9u8cLLzHoS5db6ulKLXpdx4peV8=;
        b=MreYonoj2IE7xx+4j06GH8K+1t5saBYhqVnJcyp2Gt21loHU5DoVwLUq1WCI7axW2Y
         H/pLpfyLhYB/1snZo5i/OUT3FZhdCv7ANWjc+bwWKeEjAN68jUdvjaTRBXMWxrXQ51x6
         RSSFDoyqP8wMs3LA5cuV8vQKjWEmpPPBnxI7WxkZWua9fQCFZEkR+YRISsKS//jH5wjS
         /1bsd5H3UGp039SP8lD4ZFkMVooHBpJhGkIlHiAVDV9fs3/eXAvX7hylVjYXWEAkMwTj
         fxc96kLII93MpukbO189Q09kHGIC4UEU84YGeVZZCnCbVI3V8eEU+e3m9iSaJPRAZhM5
         9KPg==
X-Gm-Message-State: AFq9FYJiO66ezJkKy1xxaIqUIdLmqbe8HQhIyrpkyCYvxddEs2MGwj/J
	W6HNFx9ET8eCQz0gpsAKWE26jqpQlbee+2sqoijkemZJwrDVhdh0YjYiuU/M/8cRVCReCNuKYgg
	qq8A=
X-Gm-Gg: AYBFou1eK1Dl+xhSeZVggNRs5ImEb+ndyAwFRzaNINPoP226crnd/r7yYdslNvdVwoN
	eA63uJW/71QtGHTRIGKQ6stdczQVuR8OVnfuQgJkaoa2gbp8YSXopcHJIZRRn1zU8mfagc8NDPj
	oM49I/Cj9XzwmI45k3dFN7NvNILUlo5ou0qut3mgB27NmiVH7wzQk0XqHHhT+RuT3o1v9g5nl0q
	YFX8p/WXfRn7U6wRaP1uMwxxhhgJtkgqkq0o6xNmi3b/PWJx6SWHk0EuZYNHHQVb1B02FxJ+rvp
	DwoV2r4Hu5HRRl2+9AMdKe/gU+KY0J4S1z9XNi3vRwb4kjMKBg9bdQ+9u8PjaRckaqs+COHUFNH
	vkWzi3XGDy4aRNN3kUM8uFodULX6qOs4lDnz4Q5OgCdw0fko1QLKgc4F5nrTzOLz6OulKXYwmVU
	8WShvwkCeW9sCq+17GoSnL2aL9XAi8c6fGfVn0Cs9enraXb3jyDeGZVwOJGu93d1b6XRt6Apo96
	Psoy0bMc0F5MRiqbSPCX0ztv1P1IA3zsSu+y+4wm4MzD+lailOong3S50A863NDEhBXzFn79dhM
	wHxcqTcUsPt4Y10GDnUwebInk0rfZo5NiJBJYKlbWQ==
X-Received: by 2002:ad4:5c8d:0:b0:917:8d82:ad9c with SMTP id 6a1803df08f44-91c48e58627mr34094516d6.24.1792852462930;
        Sat, 24 Oct 2026 07:34:22 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd5b65sm22397466d6.10.2026.10.24.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:34:22 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop
Date: Sat, 24 Oct 2026 10:34:15 -0400
Message-Id: <QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com> <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>
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
need to distinguish consumed results from busy. Only NETDEV_TX_OK keeps
the packet counted in tx_packets/tx_bytes and advances the slave; a
consumed result that is neither a success nor NET_XMIT_CN ends the
attempt and is charged to tx_dropped, so lower-qdisc drops are no longer
reported as good transmits. NET_XMIT_CN is counted like success because
it can accompany acceptance of the current packet: pfifo_head_drop drops
the old head, enqueues the current skb and returns NET_XMIT_CN.

Conditions to recreate the bug:
With CONFIG_NET_SCH_TEQL,
CONFIG_VLAN_8021Q and CONFIG_DUMMY enabled, add lkrdummy0 (dummy) and
lkrvlan0 (VLAN id 37 on lkrdummy0); set a pfifo limit 0 root on lkrdummy0
and a teql0 root on lkrvlan0; bring teql0 up with an address and send one
UDP packet to it. The VLAN xmit returns NET_XMIT_DROP from the lower
qdisc while holding a freed skb.

Fixes: 572a9d7b6fc7 ("net: allow to propagate errors through ->ndo_hard_start_xmit()")
Link: https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/
Link: https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: owen kwan <owen@verialabs.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v1 -> v2 (feedback by Sashiko-gemini):
- Save the slave ndo_start_xmit() result once; use
  dev_xmit_complete() only to decide whether the skb was consumed.
- Count tx_packets/tx_bytes and advance the slave only for
  NETDEV_TX_OK; charge other consumed results to tx_dropped, so
  lower-qdisc drops are not reported as good transmits.  NET_XMIT_CN
  is counted like success: it can accompany acceptance of the current
  packet.
- Describe the counter behaviour in the commit message.
---
 net/sched/sch_teql.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index c7dcec25ef42..b60ab79a6572 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -347,12 +347,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
+				int rc = NETDEV_TX_BUSY;
 
 				skb->dev = slave;
-				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
-				    netdev_start_xmit(skb, slave, slave_txq, false) ==
-				    NETDEV_TX_OK) {
-					__netif_tx_unlock(slave_txq);
+				if (!netif_xmit_frozen_or_stopped(slave_txq))
+					rc = netdev_start_xmit(skb, slave, slave_txq, false);
+				__netif_tx_unlock(slave_txq);
+				if (dev_xmit_complete(rc)) {
+					if (rc != NETDEV_TX_OK && rc != NET_XMIT_CN) {
+						master->tx_dropped++;
+						rcu_read_unlock();
+						return NETDEV_TX_OK;
+					}
 					raw_spin_lock_irqsave(&master->slaves_lock, flags);
 					if (rcu_dereference_protected(master->slaves,
 								      lockdep_is_held(&master->slaves_lock)) == q)
@@ -366,7 +372,6 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 					rcu_read_unlock();
 					return NETDEV_TX_OK;
 				}
-				__netif_tx_unlock(slave_txq);
 			}
 			if (netif_xmit_stopped(netdev_get_tx_queue(dev, 0)))
 				busy = 1;
-- 
2.34.1

