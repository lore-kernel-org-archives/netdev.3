Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6E4749D1
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118431; cv=none; b=N/lpRrch6KKJw0xail53pwiTF1+b9NfAiX8YOvtDQzPJ56+/OvsAOEiGQLTzfmp3pVrTOsSVahY+E8sFDuPvBAJKyrtPhphRW1Yu6WKeq9qhDI9rGC2xj8oyKnQBUxNP+98WrvfiFbO0e3B34qfoghb5XFu0ilhKAinwarCUvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118431; c=relaxed/simple;
	bh=c1bYJ6lduOLPkE8z8GLTzA/wHpov2InRYp3y2T05TJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nKpSIQSuxcDMnBEvqlW2d/fQ72yc7eIj+7BmJ/HZfDEuBXd5SuVqKVYnQjf/PoNSaqZFwgkLXSUDJ4Fo1RBAEFuw9N8TCWk9RfMvjyqaCWZZFEeFOudTBFPwjd0ix9ybXYEEjokvjPzY18MXXgGclzPR8QZy2vpfVHZ4yWAe028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hVUze7nn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NnLARTi/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hVUze7nn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NnLARTi/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kmaR3017045
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pOeC9bH/10g+x2ymJYLzmS
	utmP+1dn79sICTa+MWWjc=; b=hVUze7nnRawRkOIdZ0Hr2RpCU8flo/K0pZDfmm
	LVlalXQezk97crqeaIxwxHh+nFzZkI2O2ZQYlA1vdPBXr7YKPEquHITzILJmoWFT
	SfREbh3A3D4AQvL5MbYQfZSP2BUCnseb1jnmuJt3No5TPdZuAXiLoU8AxCQVQDgF
	1VCZyZwalOwEYP+Myc8HMYNhiXuncbO3KxArvhbJCiDT3iDYPT8R6+R77DEibda8
	+IdAn2Iwp96SzzylaWxE6jHZ9p5BNj5HTAliUXYPeQqLBnQcHk0cMQ9Bt0O1al0q
	t4L3Z4fnXR7iOrp2KJwWyB3mPVdKsUqGHHbbpp5dHmmcUT+w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwvx4ek0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:20:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so118883985a.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789118427; x=1789723227; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pOeC9bH/10g+x2ymJYLzmSutmP+1dn79sICTa+MWWjc=;
        b=NnLARTi/ylCMqFQm0PMP5hFuvkv5bpggx/kqkVaQkvNsBQ1wahXsD7nVaOrlrMAgHy
         0wgb6ZyebqYcWOrmsiDBZVvsA2gQ4k0UOBmkXl25HuIZY3a+DIAmDl7XFnEIw80otvBh
         J+VxvNh6tuCDJKr6CmevovZlHL5rDFDDE1eTfY64cZkSGxztjoNSU3rfRlndFgFeDUn/
         T8V0HNyuEYdhh+HpywYkWT9VjvafOL3j6Dtzko/wRJd6kZDhgMX3+tIQ4Vp3WxsUHOk+
         waJb8j6ZHBh0IA6lqzFLuvb7dduRX3OjOHkd86rl9IuK8dgFl0S5fQL1ZxeqOzosALHi
         O9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789118427; x=1789723227;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pOeC9bH/10g+x2ymJYLzmSutmP+1dn79sICTa+MWWjc=;
        b=sWDpH1+2uQ2fMezEfdAWxppZVktecXtM+yHRZlRvPLqZZAWny5JfnU471aNWOuT5am
         5Son+ZRqPKDGttY2/LNnntVLQMHb2Mm+NLzid0QLk6ppUBG+Al53cKszpyEsui4yM6RD
         Q6a4sv49cFu7NP++z4b9Kk0uoOWzosHki+8UbrLi/+WF0bCpXhIcy4kl7Feew7KgocIt
         R7vTtsk7jJSi41rJyolOS8a2skyghv2gizWpQFBDAR/BLLPhDkK3H4hzi7mF2X0XBVZF
         goMWSw/+ktKGBxYfWS9tAA9JyFDgsXg79pYBNt7zPGgW8Nyau7r2jwfKPjNq0Li4dwvv
         zfRg==
X-Gm-Message-State: AFuF++kRz86/dkDAP6k49Nkw7Jpi8W+qFvzUx52DhSkw/yJkCmIVOT3E
	YIY9D/f69n7AaSMOd4wN2kNwVrn9VglawHBRrcHZ7ElKYcUSzoKPdbiCtKKppRxAQ/MYN8YymFF
	wlAahpzcn2n1qK8vox1f5tC9yr5k35WSrt/cZyfRYECucXSmGpMQtMfobOJA=
X-Gm-Gg: AYBFou1f0ZmiCRmyudNA1tWaliJYMXntV/TdAYNmnebJg53UEIU57cb6wCf9jwv/K/S
	Owq320Z+211dvo5EBX4efscuMoZMjDzLhS/zN+fCxlS0U0vrMve19V6swxubWomc57gvsjaKtbQ
	WrAMLrKG9mqcjVRpUZ7aignryGBGUd6PTEGzmm5NjrzNE/imhMHBAKswPJEq75MhpJO7i6wRJeD
	Us4OGWkQho5ZxNPFjIGyDW6p5+V/QNLXji0OrGhp0J2/WFcjXtyl7osM4qKSwvm0OevrzMOgD5k
	Tu5C5JfXtWiSd2JpVXTMsZRy9BhsvEZz2+WluInP+Vq95d6D8Jf75TSVLxVQbX4YoTj1L1PAP2S
	OnfdS/B+ZNe9hwg==
X-Received: by 2002:a05:620a:1a24:b0:939:40d1:2d6d with SMTP id af79cd13be357-939ea27718bmr375850985a.37.1789118427322;
        Fri, 11 Sep 2026 02:20:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:939:40d1:2d6d with SMTP id af79cd13be357-939ea27718bmr375846985a.37.1789118426844;
        Fri, 11 Sep 2026 02:20:26 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62227071sm32076935e9.3.2026.09.11.02.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:20:26 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 11:20:15 +0200
Subject: [PATCH net] net: stmmac: fix TSO header length truncation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-stmmac-fix-header-length-v1-1-8fc103334327@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X23IVswED7K8XDYp5moaYlCVIQ/
 93gcWBmDqoohkqv4aCC3ap9cwd5DDQnzSvYYmfyzgf3FOHatk1nXuzPCRpR+IO8tsQqcfQhBqe
 LUM9/BV2612/KaDSd5wVmmVe9bwAAAA==
X-Change-ID: 20260911-stmmac-fix-header-length-a1d526d60af1
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyOSBTYWx0ZWRfXwLTmW7+l7rNU
 2mwAHWYhvq9QSbhBh2FRWZMZGUQQP/XSKP0TJIE+2nWBDo59njatje4lDvgDqVvfxNgeVHo0+SN
 SWk2pAwNGaToUVmzfY6B3kXpus4Bf+2xvzFN26HEaWYkGYspvsaEPt53sC7yQlL7N4fw5dOE3gI
 nwTYBp/VSGKIeWYgx30mgxuEzTey7QMOS62qyymWMcFp1H+bZEdkE412cIOdsM0NEzFsqhoaT1i
 SRV133mZEw3KIo7+IfTAvbLpYUoxIVeTyRo0X/soBxf0WQU54FyARDloYAgaWxOdE9RPUAWcbcY
 nuZKnEQC3dTdjWslSNz/YULFdcgYQwrDZdXAleNuITPwUeZ2uFSkjQ++Sy60xSATay/8H5UtRU5
 bqOobMhLGWLvN6QHvZlySixLkWnGfXswfbjn3iWKzlTla/72q9IEnjT3Q8Nqfk887Z0D9uR6YsI
 e6mHJR/vW4ICvCbEtwA==
X-Proofpoint-ORIG-GUID: m4ZrAEQn9BBVnCXjoBgLKSGmK2xBtgAy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyOSBTYWx0ZWRfXx0gjatE+E8gO
 mijjZB49wYZg7Lw32ObSuQZ8bCSdaGyhYSEN1Vq6oXE/IUm+oxd7o+Le7YtaYBUmL/MaSuAfFsa
 8C4+tJCCgO7mDTx9vmBgSS0y6ymnVX4=
X-Authority-Analysis: v=2.4 cv=AdkkjHXG c=1 sm=1 tr=0 ts=6aa3c7dc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JMNiLqPw9-2bY0mBONAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: m4ZrAEQn9BBVnCXjoBgLKSGmK2xBtgAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110129

stmmac_tso_xmit() stores the protocol header length returned by
stmmac_tso_header_size() in a u8. stmmac_tso_valid_packet() admits
headers up to 1023 bytes, so a header longer than 255 bytes wraps modulo
256 (486 becomes 230, 256 becomes 0).

A TCP over IPv6 socket carrying a few hundred bytes of sticky
destination/hop-by-hop options makes skb_tcp_all_headers() exceed 255
while staying below the 1023-byte limit, so such an skb reaches
stmmac_tso_xmit().

Widen proto_hdr_len to unsigned int, which is sufficient since the value
is bounded by the hardware limit, and adjust the debug print specifier
accordingly.

Fixes: 9edfa7dab811 ("net: stmmac: enable TSO for IPv6")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62c3441911e7..1fb5f804ea23 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4513,16 +4513,16 @@ static int stmmac_tso_get_num_desc(struct stmmac_tx_queue *tx_q,
  */
 static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	unsigned int first_entry, entry, tx_packets, proto_hdr_len;
 	struct dma_desc *desc, *first, *mss_desc = NULL;
 	struct stmmac_priv *priv = netdev_priv(dev);
-	unsigned int first_entry, entry, tx_packets;
 	struct stmmac_txq_stats *txq_stats;
 	int i, first_tx, nfrags, ndesc;
 	struct stmmac_tx_queue *tx_q;
 	bool set_ic, is_last_segment;
 	u32 pay_len, mss, queue;
-	u8 proto_hdr_len, hdr;
 	dma_addr_t des;
+	u8 hdr;
 
 	nfrags = skb_shinfo(skb)->nr_frags;
 	queue = skb_get_queue_mapping(skb);
@@ -4570,7 +4570,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (netif_msg_tx_queued(priv)) {
-		pr_info("%s: hdrlen %d, hdr_len %d, pay_len %d, mss %d\n",
+		pr_info("%s: hdrlen %d, hdr_len %u, pay_len %d, mss %d\n",
 			__func__, hdr, proto_hdr_len, pay_len, mss);
 		pr_info("\tskb->len %d, skb->data_len %d\n", skb->len,
 			skb->data_len);

---
base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
change-id: 20260911-stmmac-fix-header-length-a1d526d60af1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

