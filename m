Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8B4D0CDF
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846803; cv=none; b=oZ3LDcH8j8/LiHx583AH873DeY19IzgFg98ssQ+wFNSGwKko2riMYPM5CowxG3HfxUKsoAbhl29jxc0bjPEkBh6Z7Go1gS8lSLkEUyZaImTnoG+Ig/FykMKZIY3ZBIu4fQ3GCQgkrt056nR/egq00A+QGLX+SbHetUZHrh4x/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846803; c=relaxed/simple;
	bh=uiC+2hsQgFEEL1cxhE28LDbpTzJj+S6eCTLZ7Y/Ea3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YkkzUyIZqWabVqFh2R/10zlyQjD5KE5yJ+btce3fWORbPQ2GFaBN6JvtOJb1cCsg67YrhPX/ejAdQY/19M4KzVq/UOaH0hODVdlTsh+xj+YQhLPPcpe9dZULaoK9HmRzTi4oHJs8oUTAh8z4d4vYF5BEy0sgb51Wm2TooAQZ4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFbw+y7p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dTP8qGcC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFbw+y7p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dTP8qGcC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xfMU962543
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 09:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c+UM7fuqdRbDcSq7RdvBDoC9dhPLseEVaJ2k9PcLRJ4=; b=eFbw+y7pfdUVWcyu
	GTpkgoNYYoHAQRm7YWSXlU6iuQSLLe5cwwKC7KD42FVqm3oxvr8ddP0qeSd+mZuX
	SJwz+qtnW6zxtMf2ep+Cc3HykeFT66a5E3utJaAkY8wCQ3zXgGjOph9hkr+w/epT
	mmsgb5C9qNoW3uMVe5DvHhaWD8TtIRz8bcs9CQINxw+vg0oNxRAigFxI7VpOsFWh
	TR3xcbh8ryImoBe5vIEFtfTTVhnm+ISiXJ7ZxPM3y+hBdnrDZ4DQEpxwEDeXs37l
	WXiekUSjpwSVwhAs4T7tEZs16KyDbRHHfJwG+dw0J9f+qPJdD3bj8FAaLCfmv1FN
	6z3JYw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcub7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:26:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caa0ce0cdso173280585a.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790846793; x=1791451593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+UM7fuqdRbDcSq7RdvBDoC9dhPLseEVaJ2k9PcLRJ4=;
        b=dTP8qGcCr3VghaqTPPRyoSEG90oSRuDwyXolVB6pE09d2WZGrtfghUYZD4t2Rem6KB
         UORUYkqVEypRWDiQ9jCfAWi0qK8k27Dt2JUQNPWoQrvCAcGl/8S2+yjl6TzqiXAed4ip
         P5LfSQATtLQXLrvOcHlDJCszDvesJCUQL75qzyBFHd/xsbr3rN86vO9lqmhqg7TX4e1z
         5CKp7zGKuEs+C3F/IQ+NgqEgRGVMMxhnDpIEnC6paWcHvn8NfFOUC3bHoQqy7zddjyxj
         RuaL2Uxs3+zcEfEHkji44U8b4npXgaZuZsdY6sAg94xotxpiYsgEuQmLW89TPnvDgIZM
         5GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846793; x=1791451593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+UM7fuqdRbDcSq7RdvBDoC9dhPLseEVaJ2k9PcLRJ4=;
        b=snY2lo9WIR0rTzi8bfR8x/TypIUhOR6yNBNHnet1UuHPkBPIvvRQ3kbizLL5mw8WjW
         /N66FPOf5T4lkShAe7kxle8TZgPUC1vEUd3dBFJaeEMMFEBVzjbK8mHHFA+vICzmX1gU
         /YhSQtEOrQZeRk/BHRTi2qPjTAGurj+vhJv84QFVqqNbnSrzkeeZVl8IsYKk1rTaIddx
         +sRxSJ9DmyuRxOoY7JmRmZx7Pcn4ek8TSufaG2Fipn/vOiOfHkMyZls2I2aehFEiFvgr
         XoKn/booykUgtnyt3N1FTC+Y2+j9EYs+lbHN3843B+kK92dqGo4S79p/w9nW5IFdpEv3
         7l9w==
X-Gm-Message-State: AFuF++kurzACAebdsei34EBDiWoXqM1sw4GPUs9ELf3QdAgWKoO/LTdJ
	K0n/rtZ8+4p5vth5lO5jFV9v70tw64xmnt/SxwHoDMdvxSSEXtDOi46FYp5Kv+a/DjVmor2fVHf
	s2Bjp+Xd+/uJlajIhMzY4gYtpAoZGvICHehSwUT4DzN8e9T3RhKGoZfsCzjA=
X-Gm-Gg: AYBFou3lyyez09kGs9Jm9rwIhtYE0WoDAFj1ogQQC7x84Tf2LyvGYKG+BECmolfhWz3
	uMLkwItAMi9I+wQrCsZpxY9jkrEbYXD8YAZCy9L6pSBvsIAnTEM1UOxFAdFBZj8/YHid2m95qHR
	IEwAoLFum1fEnPG6Cq1RO14cYtP7F1lIZlBmJwzHvUiRpPkKI74fOthx/c1MFDo2s4xq5EkXzRv
	T54sc52bEyIiLG8ZknweqokVhFFSZ2raeSq2OOgac1a33NkNS4nwTxAuECvNag71/FQ6w8r/hdW
	mI6tw8ypX4eeMh/ZoPXfeTDEhpwvwPord/jk5urqpvKyXhU3tNf4T+uNgAtRdDpbw3xHmjKDLcH
	WLXBh/U4Rq5Vxew==
X-Received: by 2002:a05:620a:2245:10b0:93c:aa75:71e with SMTP id af79cd13be357-93caa751be0mr535599485a.55.1790846793230;
        Thu, 01 Oct 2026 02:26:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2245:10b0:93c:aa75:71e with SMTP id af79cd13be357-93caa751be0mr535596985a.55.1790846792654;
        Thu, 01 Oct 2026 02:26:32 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9482cdsm52568825e9.11.2026.10.01.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:26:31 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 11:26:12 +0200
Subject: [PATCH net-next v4 1/2] net: stmmac: fix TX coalesce race and
 div-by-zero in XDP/legacy path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-b4-stmmac-xmit-mb-v4-1-664e0c3eb289@oss.qualcomm.com>
References: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
In-Reply-To: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfXz2puc3h2JsDu
 JN2QYag87sS55IV/zrp0SfjFiCYNv/TxEcddLG0v0kt4t4xQh4d+zNut6vN9Wfv3s3geO1tYppZ
 85kjBpZvTJa/p4z7MJvFh9VjlknP05RQjBBZDtmL7gRf1CCTnyheaddynxnRGDI85FozNC9Gp5G
 mStTba/OuUt20FmmastReHJdOxVDv9bmgXPFAQwlLrIvnVMem6Aq/iCImI+teHoJ/avonyUIQQ4
 aRqnfrcxSbIlmgJeroeeFyrpLhh3/iYduBVIRmKMIng1eYw6FfpdPZQeC7PAQknRYsE3F8znwRv
 Z/gUAwrPW5daWr7IbzEwLwwdgRA7ipMCJGJmR4dje0AZcU4l5IEFMwmKyHllRcgP9cIap8li9Oo
 G6RwVhwjT04LXIWJfOeafgf/jjLT35RrpcsV//6CGg4SdWLrqS6RaPYhNZHIZ31YPl8c5h439I1
 7eY7FNCuSE2j4OwM/ZA==
X-Proofpoint-GUID: KqzEugzdEYXDOtdHQM6k9BBGmhaeCO8t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfX8gMrShP8X/fo
 S+tzxB8B6Pz63YaWWrGHofKXyEQcNhZoUYtfCn/aQMkYO12x/p0KBfVgIHBBFpa7zxStU/yYp1N
 ZYtHz2AJbVyDCBvWKAwvB7Hg/SvIhHM=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abe274a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ot7w2pIUjTT4PScZVSAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: KqzEugzdEYXDOtdHQM6k9BBGmhaeCO8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010037

tx_coal_frames[] is written by ethtool (stmmac_set_coalesce) and read
locklessly from the TX fast path (stmmac_xmit, stmmac_tso_xmit,
stmmac_xdp_xmit_zc and stmmac_xdp_xmit_xdpf), so pair every access
with READ_ONCE()/WRITE_ONCE() to mark the intentional data race and
read a consistent value into a local variable.

Moreover, ethtool allows disabling TX coalescing by setting
tx_max_coalesced_frames to 0: guard the modulo operation in
stmmac_xdp_xmit_xdpf() against a zero tx_coal_frames[queue] to avoid
a division by zero.

Both issues were found by code inspection while extending the XDP TX
path with multi-buff support, and neither has ever been triggered, so
they are only theoretical. Tested on the Qualcomm RB3-gen2 board.

Fixes: db2f2842e6f5 ("net: stmmac: add per-queue TX & RX coalesce ethtool support")
Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 11 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 42 ++++++++++------------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1cf0f8820b33..30e0d499326d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -798,7 +798,8 @@ static int __stmmac_get_coalesce(struct net_device *dev,
 
 	if (queue < tx_cnt) {
 		ec->tx_coalesce_usecs = priv->tx_coal_timer[queue];
-		ec->tx_max_coalesced_frames = priv->tx_coal_frames[queue];
+		ec->tx_max_coalesced_frames =
+			READ_ONCE(priv->tx_coal_frames[queue]);
 	} else {
 		ec->tx_coalesce_usecs = 0;
 		ec->tx_max_coalesced_frames = 0;
@@ -887,14 +888,14 @@ static int __stmmac_set_coalesce(struct net_device *dev,
 		int i;
 
 		for (i = 0; i < tx_cnt; i++) {
-			priv->tx_coal_frames[i] =
-				ec->tx_max_coalesced_frames;
+			WRITE_ONCE(priv->tx_coal_frames[i],
+				   ec->tx_max_coalesced_frames);
 			priv->tx_coal_timer[i] =
 				ec->tx_coalesce_usecs;
 		}
 	} else if (queue < tx_cnt) {
-		priv->tx_coal_frames[queue] =
-			ec->tx_max_coalesced_frames;
+		WRITE_ONCE(priv->tx_coal_frames[queue],
+			   ec->tx_max_coalesced_frames);
 		priv->tx_coal_timer[queue] =
 			ec->tx_coalesce_usecs;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d95482b7f6e5..df6a329fdb80 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2731,7 +2731,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		struct stmmac_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		dma_addr_t dma_addr;
-		bool set_ic;
+		bool set_ic = false;
+		u32 tx_coal;
 
 		/* We are sharing with slow path and stop XSK TX desc submission when
 		 * available TX ring is less than threshold.
@@ -2772,12 +2773,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 		tx_q->tx_count_frames++;
 
-		if (!priv->tx_coal_frames[queue])
-			set_ic = false;
-		else if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
+		tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);
+		if (tx_coal && !(tx_q->tx_count_frames % tx_coal))
 			set_ic = true;
-		else
-			set_ic = false;
 
 		meta_req.priv = priv;
 		meta_req.tx_desc = tx_desc;
@@ -3419,7 +3417,7 @@ static void stmmac_init_coalesce(struct stmmac_priv *priv)
 	for (chan = 0; chan < tx_channel_count; chan++) {
 		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
 
-		priv->tx_coal_frames[chan] = STMMAC_TX_FRAMES;
+		WRITE_ONCE(priv->tx_coal_frames[chan], STMMAC_TX_FRAMES);
 		priv->tx_coal_timer[chan] = STMMAC_COAL_TX_TIMER;
 
 		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -4557,10 +4555,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
 	struct stmmac_txq_stats *txq_stats;
+	u32 tx_coal, pay_len, mss, queue;
 	int i, first_tx, nfrags, ndesc;
 	struct stmmac_tx_queue *tx_q;
 	bool set_ic, is_last_segment;
-	u32 pay_len, mss, queue;
 	dma_addr_t des;
 	u8 hdr;
 
@@ -4679,16 +4677,16 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			      priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
+	tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
 		set_ic = true;
-	else if (!priv->tx_coal_frames[queue])
+	else if (!tx_coal)
 		set_ic = false;
 	else if (!netdev_xmit_more())
 		set_ic = true;
-	else if (tx_packets > priv->tx_coal_frames[queue])
+	else if (tx_packets > tx_coal)
 		set_ic = true;
-	else if ((tx_q->tx_count_frames %
-		  priv->tx_coal_frames[queue]) < tx_packets)
+	else if ((tx_q->tx_count_frames % tx_coal) < tx_packets)
 		set_ic = true;
 	else
 		set_ic = false;
@@ -4843,9 +4841,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct dma_desc *desc, *first_desc;
 	struct stmmac_tx_queue *tx_q;
 	int i, csum_insertion = 0;
+	u32 tx_coal, sdu_len;
 	int entry, first_tx;
 	dma_addr_t dma_addr;
-	u32 sdu_len;
 
 	if (priv->tx_path_in_lpi_mode && priv->eee_sw_timer_en)
 		stmmac_stop_sw_lpi(priv);
@@ -4986,16 +4984,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	tx_packets = CIRC_CNT(entry + 1, first_tx, priv->dma_conf.dma_tx_size);
 	tx_q->tx_count_frames += tx_packets;
 
+	tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);
 	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) && priv->hwts_tx_en)
 		set_ic = true;
-	else if (!priv->tx_coal_frames[queue])
+	else if (!tx_coal)
 		set_ic = false;
 	else if (!netdev_xmit_more())
 		set_ic = true;
-	else if (tx_packets > priv->tx_coal_frames[queue])
+	else if (tx_packets > tx_coal)
 		set_ic = true;
-	else if ((tx_q->tx_count_frames %
-		  priv->tx_coal_frames[queue]) < tx_packets)
+	else if ((tx_q->tx_count_frames % tx_coal) < tx_packets)
 		set_ic = true;
 	else
 		set_ic = false;
@@ -5258,7 +5256,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 	enum stmmac_txbuf_type buf_type;
 	struct dma_desc *tx_desc;
 	dma_addr_t dma_addr;
-	bool set_ic;
+	u32 tx_coal;
 
 	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
 		return STMMAC_XDP_CONSUMED;
@@ -5303,12 +5301,8 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 
 	tx_q->tx_count_frames++;
 
-	if (tx_q->tx_count_frames % priv->tx_coal_frames[queue] == 0)
-		set_ic = true;
-	else
-		set_ic = false;
-
-	if (set_ic) {
+	tx_coal = READ_ONCE(priv->tx_coal_frames[queue]);
+	if (tx_coal && !(tx_q->tx_count_frames % tx_coal)) {
 		tx_q->tx_count_frames = 0;
 		stmmac_set_tx_ic(priv, tx_desc);
 		u64_stats_update_begin(&txq_stats->q_syncp);

-- 
2.55.0

