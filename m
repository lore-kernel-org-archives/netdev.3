Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320A2D5925
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817639; cv=none; b=LCWcUzqhgB/dSIravt0ubdlmijnFLXHb4fjo3q4wsikchQfJ/I73nrHEVFO5IqYwu86G8BeUcbWDRuiwLGELB0Rza+U3+0ypFIKxWuGKIVT7j+G7jgTA8mV/79+47l1yEGdVbhjVbuMqF0F0RGzYgUD08kS17CfywePPSW1rSBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817639; c=relaxed/simple;
	bh=JTD90hJRdBPQAyqlcQ6wO3gUQqYvVOdqpjDHQ4QkmVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=plyT3/oJw2nWtO+fgmABjq51PR2RN8XKgGGwvwD4QiBEJf7uGlXU56JZNrvctU/fYtdqi8jS2ROSSxF6R4+bfykXDiaWSyPdVGJNL4n7s1spAAB3YwO/BreX5ZCQEFU80CyyvKqNRVpxbcQwXzHIL6QT+PIt9bDROmP9LdvSlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h/bHmj1u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=haZBA45k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h/bHmj1u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="haZBA45k"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687KlGrT1155767
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 21:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mqh/nh8e1scV0jQje+BMVt
	hxAKQf7nBklsHsrorkxwU=; b=h/bHmj1utPj8gSxoEjFQUboQGsLVlbU9/WiFov
	O5yu9vB0xQHl4F9/iGeN+rnW2r1yBfkNUvmHuErlAqsiVbBXdPSM5wHJrAbvnuqs
	ufXAeskFGjbLenaU7pYNQO/MegHgAOcV+2d12RkkYJsgISV828HPA6JEuB6RsTFc
	89pRUu+aJKCDUeS9GeAN06DvX+9eKifE1MAXDgVylpmRkjJdxQsFvCt1wmiLbvXt
	BIlrE0F9KuSsySS+nEvf7u/+FgMnagxS5LyehoQtg9K3tEchziLgnrhNbKkWy97T
	BzKQTIMiCun9lZ68QHD2pyK6RfTf5rzbtVQ1VcSQYx2U7wVA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86tvjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 21:47:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so78559351cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788817631; x=1789422431; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mqh/nh8e1scV0jQje+BMVthxAKQf7nBklsHsrorkxwU=;
        b=haZBA45knj8jhmXejZL8aZT2W7BAsAQwaXMIMrNrN5Z20e/ER0jGneb4ucdHeBNbqQ
         g/lTbCgytIcWzK1rybfyv0f7DGSvpz7wXa0jbM5iFHZbLWs+PMwLPEIZ1Zbd3J8mMRne
         zW1WsPLta5gPw2Ea/qCtJVZiAnw3FUQr3NEudtYxe9sTiHP0VRWoGS4EXCNxh2jsCA4E
         K5pZFHRxPEyBCGmzdKF6QG3ws2+WP1St6YfWJrJl6bIChnSlTVUJTlEdoBm/1jV9EUmQ
         PGHG2FhvmwzwosTTZJGwh3NL9LlBrd6cK8YiQ1EvRSkMMxoI99Y5ECmo+0jP8Qm3Tq52
         gICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817631; x=1789422431;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mqh/nh8e1scV0jQje+BMVthxAKQf7nBklsHsrorkxwU=;
        b=e+uWC0UGi+8zd3j48IWsL7M2VWeTy4Wf/Qx6px17HzY8nwQkur40TWZLVUrDRvJQpH
         GrGCGUtGol5kt9GVJl0gB5HxmzmX0gJzEkz+8Ckl5iTk6M/YojArPO1hubD2Emv7tq0J
         AdA+73vt3QaH12dfFseFrc9xHZDvqagSt69kTd1rc5Kw/W4ouYfmFqQh3rjxiKOduhs4
         +KzaFuLtaAISuDqutmx0rDIyFroIFI7lv6aICJRhEr3WxvELpv7f2nX4cCz3hgY/puHU
         KZEP1dz6iBVICrtndsJ5liJqv31fHXWVbWYnH7xZxNnifeYaXF6aRFcSHtlTH8TQrEt5
         CHmA==
X-Forwarded-Encrypted: i=1; AKwUvByG5pBZ08uv4wOsNGBN60Mul0wW5jIgboDDokfxzVzUI7cx5SVVAxlL7EWM/bLQ/zf/g24wD1w=@vger.kernel.org
X-Gm-Message-State: AFuF++my0ZUimV+8Ma4pDq9B166e8fdC488D4e2h2pZm/KpIlwKRAIHA
	PHGgsZhe4iTvtBnRzy/ndbgPVA61X1O8Ar0UHkVJLvmeyJz7nKesMbII/cCGWLRG4yYSTYMx+KR
	m4wRsA5VdOezudsNfrRbLKR3Ypvm0TcYJaShI/WcbefItQ3YwpPSi2Qpq0kk=
X-Gm-Gg: AYBFou2IsSi8niVfq2aeE6WDdHAnd3yhxAtyeujAOiVl4KbXaRJsCoYeRg7qa516olP
	QuD57AHHtJIrQE6xuOSQcY9wHLA6xAp3jjc6iHTvqjZiyQAIK05Utn3OIXcZWdB+LXa5yxGWVsr
	cIcedCmCacNpMQUQrjEp9zfrsWVK/jn19PDX0VZxcUYN8Ad/ZwDgyZ98GlCdqSGH2QeFT/wtUqH
	gnRRR+Pz1uks6poTfzKNTR2ukPwrZlsQdiBye/ZF1gQ3So/2SDujl5/Rv25C2B5VaNlXgUhIaeK
	9B/fFpuN7XUXZhHG2cbBCc3eWpSWisNPHDrOsdcAJ4T/YSgTzU2xX6kFHit4DwI7NtQ+AxUXQWN
	rmOBjCRIHmWNNfw==
X-Received: by 2002:a05:620a:262a:b0:939:72cb:bae5 with SMTP id af79cd13be357-93972cbbc7emr2320805285a.28.1788817631280;
        Mon, 07 Sep 2026 14:47:11 -0700 (PDT)
X-Received: by 2002:a05:620a:262a:b0:939:72cb:bae5 with SMTP id af79cd13be357-93972cbbc7emr2320801185a.28.1788817630821;
        Mon, 07 Sep 2026 14:47:10 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm461640535e9.5.2026.09.07.14.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:47:10 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 23:46:45 +0200
Subject: [PATCH net] net: stmmac: fix TX descriptor availability check for
 TSO traffic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gZqwRn0KuIiZlINYpWmiCDe3
 TLLB59/g0lSMeirG5KcarrHgqaugBeKs6D+isE7/3Gd+6LlbSPGoBdm2zGGRLMhL8Ir+kY4kCd
 27QTlcCQp3f8+QJQM4/O88YD2zXIAAAA=
X-Change-ID: 20260907-stmmac-fix-tso-nfrags-check-21ecfa2ac05b
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre TORGUE <alexandre.torgue@st.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: JdMo_vBAG0MvYXt4wCrouhBMlYvS1Rc8
X-Proofpoint-ORIG-GUID: JdMo_vBAG0MvYXt4wCrouhBMlYvS1Rc8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDI0MCBTYWx0ZWRfX9Eae3Iw13VSg
 cZZlQXHXy9icEn2VOJuApc632kyGCU3fvu+961TX0aIL0DMs6PWaj3RINJqTFN2q3wQJgL18C/u
 2Ez/Gj40WZtPv6U7Axah1DSoGkqOymg=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9f30e4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qG1sbvjNePByhSKIw2QA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDI0MCBTYWx0ZWRfX49ShWnWK54om
 3xPLPMlQ2SPsz+8Z9u7eRZowLaXXaDZT3gFE3TWi3oez5Rck9XiEimLSwd57ECPQnXfTzxU3A2E
 9oimUcuxyk/M7RuvXLDhzsAiJrF6nf06T4mnpNx2eRCE90l+wMAfdmJkt77R02AOv71A7FkqZBp
 k2r/momHry7JZEuLWerf2ABq6AyEa1bd5kuL0hKJsw743vDVL2cs1FugAEF6qXFbznvhLj5q7Ti
 LisYMoDqfYqw2ZJisEwSGqASRzrzhk9KpJ7BwCDn3B23hn7tQKgShD1ZLQz2hVxGHEks7B+oSiB
 IUR7Fn52rkWNijNItcw26lqlHErH1c/kab6lTpwHvYkTwH0FJcR95Hql+h2jpIaYaQMYj5fEOXl
 DD5CVx9WpZKZn9gJaKNojUrZ2L1D3aGKcAbMcBGzh/viheaAvOGlF3BV4yB9kGP1UmOk8V7EXGU
 ctPuafQCtLBz7SvR2EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_06,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070240

stmmac_tso_xmit() estimates the number of free TX descriptors required by
a TSO skb as:

	(skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1

which assumes the payload is split into TSO_MAX_BUFF_SIZE chunks. This
underestimates the descriptors actually consumed by stmmac_tso_allocator(),
since each fragment is mapped individually and so it needs at least one
descriptor regardless of its size. Moreover, one descriptor is used for
the L2/L3/L4 headers and, when the MSS changes, one more is consumed for
the MSS context descriptor.
For a highly fragmented TSO skb the check can therefore pass even when the
ring has too few free slots. stmmac_tso_allocator() then writes past the
available descriptors, overwriting descriptors still owned by the DMA
engine, corrupting the TX ring.
Add stmmac_tso_get_num_desc() to compute the exact number of descriptors
needed for the header, the linear payload and each fragment, plus the MSS
context descriptor when required, and use it in the availability check.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 31 ++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24656b35350b..3566b33bc34e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4454,6 +4454,26 @@ static bool stmmac_tso_valid_packet(struct sk_buff *skb)
 	       header_len + gso_size < 16383;
 }
 
+static int stmmac_tso_get_num_desc(struct stmmac_tx_queue *tx_q,
+				   struct sk_buff *skb, u32 pay_len)
+{
+	int i, ndesc = 1;
+
+	/* head payload */
+	ndesc += DIV_ROUND_UP(pay_len, TSO_MAX_BUFF_SIZE);
+	/* frag payload */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		ndesc += DIV_ROUND_UP(skb_frag_size(frag),
+				      TSO_MAX_BUFF_SIZE);
+	}
+	/* MSS update requires a new descriptor */
+	ndesc += !!(skb_shinfo(skb)->gso_size != tx_q->mss);
+
+	return ndesc;
+}
+
 /**
  *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
  *  @skb : the socket buffer
@@ -4497,10 +4517,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	unsigned int first_entry, entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
+	int i, first_tx, nfrags, ndesc;
 	struct stmmac_tx_queue *tx_q;
 	bool set_ic, is_last_segment;
 	u32 pay_len, mss, queue;
-	int i, first_tx, nfrags;
 	u8 proto_hdr_len, hdr;
 	dma_addr_t des;
 
@@ -4513,14 +4533,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Compute header lengths */
 	proto_hdr_len = stmmac_tso_header_size(skb);
+	pay_len = skb_headlen(skb) - proto_hdr_len; /* no frags */
+
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 		hdr = sizeof(struct udphdr);
 	else
 		hdr = tcp_hdrlen(skb);
 
-	/* Desc availability based on threshold should be enough safe */
-	if (unlikely(stmmac_tx_avail(priv, queue) <
-		(((skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1)))) {
+	ndesc = stmmac_tso_get_num_desc(tx_q, skb, pay_len);
+	if (unlikely(stmmac_tx_avail(priv, queue) < ndesc)) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
 								queue));
@@ -4532,8 +4553,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_BUSY;
 	}
 
-	pay_len = skb_headlen(skb) - proto_hdr_len; /* no frags */
-
 	mss = skb_shinfo(skb)->gso_size;
 
 	/* set new MSS value if needed */

---
base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
change-id: 20260907-stmmac-fix-tso-nfrags-check-21ecfa2ac05b

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

