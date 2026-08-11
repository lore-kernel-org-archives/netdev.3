Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D60365A13
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474059; cv=none; b=jYxky1HDfnaMOA3JDUw/WvaJqB1hDhoCRG1F/lmNP4h2W3WNxXTjmTJIQx2JVix1OOzFLs04OkUeKZbRICHaOOQgD3jx0gCOp9/wfGJdI6fAdCM76gUXQAtUIb69/oL5IMIdXY7AKAFmh1sorRLm1lohuGpGQR6ICac7Z+dE4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474059; c=relaxed/simple;
	bh=2DiZ3irCZiIEKl32oG5caVRm/8aYN1MMU3tKso8r9ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIApJKTuK4bQTU9+ZvdsDZUh780pTDgUerLpeeDAv+8yvFt+F0GMK4HDWUj4D4tsGlSzsXbKQh0CSoH+0mEHMvqXQvBhg9Te/Na/FmKfJdT7wgE87qrqwxNryZW2BUmEX288onWaho9M25HGkERYKOKMUs27bG4YaGwI2Dl8qGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Pc8QmYRq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Pc8QmYRq"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so220118b3a.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786474057; x=1787078857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ylYeUW6ISwS0E2bcw9LPY5hcAfyBnPwa8fuwoqs4yU=;
        b=Pc8QmYRqmk6sc84CMLh4fRQt8MGuhZNYsp1wwi1LfPpRNzdaVo8huCYx9uBjDoddfh
         cpsSqMQydmtEzI8qX2LxMbvNfMDQdcaLczk+aBi0F6/SUw3jdidTv/gxiO8/plJgMgMk
         JopAz1RgVxzHIw8IUyl4q/KDc0DVgGuEEY0PtMypk9FGmo5FttCA4u9V1z/3Y44ePo2h
         TAE266SpmCUL8AJ+7DAKOiaVBM4lTEBol9nRoeDu1Lx8D43CF0fkhq/IqE8b2NzPNJzY
         ZnEqrPhmSiyLHZ4mj+pXGlWUnO/4nmn7oCqRWDAbS7hKdIs+vS6VceWosisEBlBpNW03
         uigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474057; x=1787078857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ylYeUW6ISwS0E2bcw9LPY5hcAfyBnPwa8fuwoqs4yU=;
        b=g8stx+Uol9FERInZXB8oiN7vWB1FtkAihrzczwSjiAlC7hmQxUWwXFY2YPIU+1JZ92
         7nR0Q3IayLf5Vw0pISPOJsOL6RkZNOA6xQem4Mm/jaIVi6wWKr7SLsxgGjSTPcUbPWMn
         lAK/eM84O94CJ148GetPacNSjBDVhbWCEL+/8n8Gq778uVNZU2hyx2WsUtRH3aTCeLaK
         JHJwI9aRdfAlP7kNew2SQ1MiwXm9Z+C/3fjCvqkrfsNkYw95w/vqWBMGwqjJQLJtgwUC
         ZvOzh1PV8rwqplWjpJlCL/I6SuTwxijYOqd8Sf7CdZA7AWCoS71KezzIrwpN/xwcsyu1
         jzSg==
X-Gm-Message-State: AOJu0Yzh14dDg0vlPom0m2CjUe3BLJPIpNcjadd2yEYRJjc8fqcze1n3
	GQLshhblR02TIo1qWt7houNGPBGmRpW+2reF0KixAF4e/Vep8sjd3WmovCeugaPducZRf2qloAn
	ZOBC/
X-Gm-Gg: AR+sD12KajUi85M5+x7C64wMcDTcd/Fgah6ubmmpt6bcst4goFEvjsj5s5pX6U3NY0L
	xh+zZP92BcQu2DgB/XLbXg43R6TXKbBg8+rk0Rs95yqrmIntty/OaUjWEoahInS0MZtpdOaBhlM
	AWyXmwYvLnrDheGaFXQOqyEqzK84xnzCLYMkpvE7dQVH0memMilhg4LTPuRDRnTa0pbEpyjeNH5
	daKhLJXPDlln/2Mvnvymkmtj2QQGZKnyatjvShhsnldUNdFg+afQsbiQFQHHfJ6AgH5l/txF1PJ
	23kDPHjmk8oflEuN57LLzDFFTc+NNHmCbLCRlUje0HsnOc+lTY3YB2jjBIN9s5Oc57hvh6xsO5X
	IUG0FyoFNOhRU76T8omI6s5XqamteYQeoHNWBdAWpULF8Eg4mF8Q5rIbdZKgx397a0HNg39DbjB
	+wceJYqLjGOKgcQxaqQdUFRWuNM8hv3nYKOFZmHOQJsQ==
X-Received: by 2002:a05:6a00:886:b0:845:e97d:447e with SMTP id d2e1a72fcca58-84faf9ffbf4mr2473205b3a.26.1786474056875;
        Tue, 11 Aug 2026 11:47:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf450bsm177227b3a.9.2026.08.11.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 11:47:36 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch,
	willemb@google.com,
	Joe Damato <joe@dama.to>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net/packet: Reduce VLAN tag code duplication
Date: Tue, 11 Aug 2026 11:47:19 -0700
Message-ID: <20260811184722.2612345-2-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811184722.2612345-1-joe@dama.to>
References: <20260811184722.2612345-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce code duplication for VLAN tag extraction by factoring the
repeated code into a helper and using it.

Signed-off-by: Joe Damato <joe@dama.to>
---
 net/packet/af_packet.c | 95 +++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 435756877aba..ee60dcc639ad 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -568,6 +568,27 @@ static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 	return ntohs(vh->h_vlan_TCI);
 }
 
+static bool packet_get_vlan_tci_tpid(const struct sk_buff *skb,
+				     struct net_device *dev,
+				     u16 *tci, u16 *tpid)
+{
+	if (skb_vlan_tag_present(skb)) {
+		*tci = skb_vlan_tag_get(skb);
+		*tpid = ntohs(skb->vlan_proto);
+		return true;
+	}
+
+	if (unlikely(dev && eth_type_vlan(skb->protocol))) {
+		*tci = vlan_get_tci(skb, dev);
+		*tpid = ntohs(skb->protocol);
+		return true;
+	}
+
+	*tci = 0;
+	*tpid = 0;
+	return false;
+}
+
 static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 {
 	__be16 proto = skb->protocol;
@@ -997,20 +1018,19 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
 	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+	struct net_device *dev = NULL;
+	u16 tci, tpid;
 
-	if (skb_vlan_tag_present(pkc->skb)) {
-		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
-		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
-		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
-	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
-		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
-		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+	if (po->sk.sk_type == SOCK_DGRAM)
+		dev = pkc->skb->dev;
+
+	if (packet_get_vlan_tci_tpid(pkc->skb, dev, &tci, &tpid))
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
-	} else {
-		ppd->hv1.tp_vlan_tci = 0;
-		ppd->hv1.tp_vlan_tpid = 0;
+	else
 		ppd->tp_status = TP_STATUS_AVAILABLE;
-	}
+
+	ppd->hv1.tp_vlan_tci = tci;
+	ppd->hv1.tp_vlan_tpid = tpid;
 }
 
 static void prb_run_all_ft_ops(struct tpacket_kbdq_core *pkc,
@@ -2247,6 +2267,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		       struct packet_type *pt, struct net_device *orig_dev)
 {
 	enum skb_drop_reason drop_reason = SKB_CONSUMED;
+	struct net_device *vlan_dev = NULL;
 	struct sock *sk = NULL;
 	struct packet_sock *po;
 	struct sockaddr_ll *sll;
@@ -2262,6 +2283,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	__u32 ts_status;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
+	u16 tci, tpid;
 
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2436,18 +2458,12 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		h.h2->tp_net = netoff;
 		h.h2->tp_sec = ts.tv_sec;
 		h.h2->tp_nsec = ts.tv_nsec;
-		if (skb_vlan_tag_present(skb)) {
-			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
-			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
-			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
-		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
-			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
-			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+		if (sk->sk_type == SOCK_DGRAM)
+			vlan_dev = skb->dev;
+		if (packet_get_vlan_tci_tpid(skb, vlan_dev, &tci, &tpid))
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
-		} else {
-			h.h2->tp_vlan_tci = 0;
-			h.h2->tp_vlan_tpid = 0;
-		}
+		h.h2->tp_vlan_tci = tci;
+		h.h2->tp_vlan_tpid = tpid;
 		memset(h.h2->tp_padding, 0, sizeof(h.h2->tp_padding));
 		hdrlen = sizeof(*h.h2);
 		break;
@@ -3547,7 +3563,9 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	}
 
 	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
+		struct net_device *vlan_dev = NULL;
 		struct tpacket_auxdata aux;
+		u16 tci, tpid;
 
 		aux.tp_status = TP_STATUS_USER;
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
@@ -3562,29 +3580,22 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		aux.tp_snaplen = skb->len;
 		aux.tp_mac = 0;
 		aux.tp_net = skb_network_offset(skb);
-		if (skb_vlan_tag_present(skb)) {
-			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
-			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
-			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
-		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+		rcu_read_lock();
+		if (unlikely(sock->type == SOCK_DGRAM &&
+			     !skb_vlan_tag_present(skb) &&
+			     eth_type_vlan(skb->protocol))) {
 			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
-			struct net_device *dev;
 
-			rcu_read_lock();
-			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
-			if (dev) {
-				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
-				aux.tp_vlan_tpid = ntohs(skb->protocol);
-				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
-			} else {
-				aux.tp_vlan_tci = 0;
-				aux.tp_vlan_tpid = 0;
-			}
-			rcu_read_unlock();
-		} else {
-			aux.tp_vlan_tci = 0;
-			aux.tp_vlan_tpid = 0;
+			vlan_dev = dev_get_by_index_rcu(sock_net(sk),
+							sll->sll_ifindex);
 		}
+		if (packet_get_vlan_tci_tpid(skb, vlan_dev, &tci, &tpid))
+			aux.tp_status |= TP_STATUS_VLAN_VALID |
+					 TP_STATUS_VLAN_TPID_VALID;
+		rcu_read_unlock();
+
+		aux.tp_vlan_tci = tci;
+		aux.tp_vlan_tpid = tpid;
 		put_cmsg(msg, SOL_PACKET, PACKET_AUXDATA, sizeof(aux), &aux);
 	}
 
-- 
2.53.0-Meta

