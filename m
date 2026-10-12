Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BB4A0935
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818724; cv=none; b=N0+sklCn9+jpnFfR8CGveWvpAkcRI5zMEAoxke/TM04Tu1gCuUQBjLRthCfLWpt+VUOkxGzh7Z/iJGE54dHAYgMVQ3ImAwXviV97a+dp0LnjhJr/AFlKnxPR/ZltLiD6pJ4LUQZL8pcIX1Dtwi4A6fcsFdQ3Egi2Ib40d+xbT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818724; c=relaxed/simple;
	bh=RYlmXp7AGFVS+ACX+tCb7XN2buLHBYos+Ik4dgl8m/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgI3DutTFk1TKXOY0pa/nNW2QmHmXQ0eTx+vA2sp9IZEXwvwQf2VUMIl7a2wosk8RDv+rewFRlr0RVx5lU4NLoixOifFenHzF9eWNF2Iim2W3NljvVXaT1Hmy7W3D6dVe8rbYJzr+BI69qiLsH4neJWFv2O8TXIK3JRaWs0b0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxwrcQeb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qi6hvRoR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxwrcQeb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qi6hvRoR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CBxsKw3363785
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7jqF+qYHICj5HER0svNlKUByr8EgTf60Xnpf6q1p3Hc=; b=dxwrcQebicojW1Xq
	PvOE0VKUDwurCLfgVIQiiiAvDaOwAT6uZLscLJp12Q13kt5w00QoXCQo8sAF9vye
	vq5K1qF/8UY/sU50zGgiEg2soAPpj5g4vo01zdoS5dsdm2GohCjjCTyzu8MirCbi
	Ee3QFV/FCMX9abRkzAUqwK73+zUQfz10TK5vmPuzyRV1DnhET8oVkffRiNtlI7PC
	d2oFa9LMbLl0HYYhIjWIOuVEG1z3U/WOQzMgHC+IDbupdHEDHJ9FkAZs/uwaiKkv
	jxefz+3X14wlRHFW7mv1EXLYhTzRVXX3I+24G3pkt32OfSeGE3qAhcRmI52yuGry
	2kr9zg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr9dt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:25:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc40759b2so464897685a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791818722; x=1792423522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jqF+qYHICj5HER0svNlKUByr8EgTf60Xnpf6q1p3Hc=;
        b=Qi6hvRoRT27DpeJwT3hcgovRmCSF0rmuRVqS/38V0dlKjFFn6Id1M5OMypgUVOmebZ
         O7OyGgUwUwhqXv/mkJrY/Z8MQTOT3rdGtX1YNNND8ZYywOYr6GEuNFdCwraGpHeCF6w1
         CIuTHosxPVvTWYYOB7xQqt6IFxcfk6AY1gfOGSxJE1deeOMORL8PJOmin2lvcZc5Wo7b
         RlT5SlMZzvhjFwbhZjge453n93nU5bSHDvRUOFM8WBHQTQnWbDkzvxZXCJeZegPTgAxw
         sbNp/sqOXigoljs7KiKIAM+mzI089x+ZRRU0NCkteaT3Vqk5M03/ueHUEsIsbKa/2uMo
         nnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818722; x=1792423522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jqF+qYHICj5HER0svNlKUByr8EgTf60Xnpf6q1p3Hc=;
        b=Uw+d4cgrlsp0pVNOJ4zg9RSU5HiP/c4HjjN0DzG1VU4+YhTQ8zEcqvS+9UhRbgxIoZ
         lU3IH/HaNCUI1eNU/b334TJ1aUa5UWFhlbs6KFDXS9jfi1PB2V52CXBidyK796OpNndl
         fx6M1AIEQSyNOUkfdNUL9TkNtL+896L0zeUB3IR98QIKjiBV7/EfcskqORLeXIFHtv6I
         sCxHxNS82bw1dzfmkKA3mec3wYWNYw8CpkTsmmK92W4hhtZQZDFt4VEjRI6s5UGMflWu
         KayFM39EXz8T85nJ1cm5EHrcQzEl+ZG50NqtK244Nc5QDiSj6LhxH2F61BWiLyfvPAl5
         rHRw==
X-Gm-Message-State: AFq9FYKuz3SqTHNkmf+rGWASNlSfI0acy/KKMjjro826FzDpomNeYSIX
	ITKd/1W/c6z3vSGhAqdXMgwjypaVam8gp0kCIp9B/mi/yoLrsVtjqedY/RrWfB7WHGF428eDBXm
	Jr6Rpr6dLkYGeo135LjI1owgk4/TDQwpuUvRvYcVmOpSerwCYp8d0dK9sVAU=
X-Gm-Gg: AYBFou0rXqgpaYyJ/sZULeDO2nVffPUEfMgapENbZht7NyHIBgW9HKtNIANbcmwQa+q
	AorzOVj7jlsG8mitAy7Qz2qtcdEwX17IARl8qti7IOtu7tPAPh/HwbR5g0nQ9AyXGDFkl+jzB7Z
	AFuO96e1m6Fm4advFOUA0JEgyewiz8t7WRGYd6ZRxe5FimkQavNQ6JcfD+kOSujuETam0MYthre
	EWNhS27L8ZyESo7boh7pFDRO3GTS/BLxftztJy0FELol6N51R05sNdNg1QvjChQwdjQ4dYsrYbU
	Lz0QHVTschehMuMe6fzJ+gIti1E20oNvpXrJnAG0FOH/RBgL7ru+cr5uV+F99rvZWElx35x5Mn0
	R+7b+TzSNft4hSg==
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr1566453085a.59.1791818721637;
        Mon, 12 Oct 2026 08:25:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0f:b0:93b:d7a0:d9e1 with SMTP id af79cd13be357-93ebd2445b1mr1566447285a.59.1791818721037;
        Mon, 12 Oct 2026 08:25:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a199e5db12sm177527835e9.2.2026.10.12.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:25:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 17:24:40 +0200
Subject: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload for
 jumbo frames on bugged cores
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
In-Reply-To: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX2VVKNb1qmSpp
 kA1K5qzqtRD3vUxqjxw7Uct0KsGtPf/VeESm++bzq4ExUm0u/lbQJ+T8w7QaEqKw0eIUlwRq0bW
 IYPbLF0hkULRvDoTYVAVgAy1oziOkMw3Q1bgKEOgO8M40hwJDFjo7dthfHfWEvos+cQpUC9Bt8o
 jxCe00nJBiF6ZgFZbmdlC5/DvaKnYq/nnTSNkYfZgz3IPvOcWjgIyZjLBsADRHUw5chmB7emsUq
 Zmpq2eHlUJ40lnosdh3aJvlvrmT88Obhq1E8bwdDWa02hs1wXwH3jtsW5s2rbb0NeAvd7mP7RgS
 lyCEVPGxtXa1HcSh0GdmYhn8+stwSaCkbWa4JjYp1R7P1j3xrXPpepFc/TDLJOpuS7g2EtulGoM
 6E7Z1jo6ocdYiCpuA2fVw+SoB1dg1K/Y0lZxF9swmaT1TGDqjnDclzeidg4tBOzVne4JSPfReG1
 xHLUL16e3ovuWE4tGOQ==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6accfbe2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IBDDDhxC7lntIW3zH5MA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfXy+WsBRBgbN8u
 TH4eE42yN3+SLfLv9bxjZbZbrhX54YlqK8IxvnFKavzK4BSxoW2Tnx27o7ISYtTB5RlWMb41QqJ
 drQbkBFySfIedcprQdmAgsb/lZGjudg=
X-Proofpoint-ORIG-GUID: adVPPaJ6MKR1DHfEzGOmM9jaUcdCeZ5C
X-Proofpoint-GUID: adVPPaJ6MKR1DHfEzGOmM9jaUcdCeZ5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061

stmmac_xdp_xmit_xdpf() decides TX checksum insertion from the queue COE
capability only:

	csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;

and lets the enhanced descriptor set TX_CIC_FULL accordingly. On the
bugged_jumbo cores (snps,dwmac-3.40a, snps,dwmac-3.610 and
snps,dwmac-3.710) hardware checksum insertion is broken for jumbo
frames; the skb path works around it by clearing NETIF_F_CSUM_MASK in
stmmac_fix_features() when the MTU exceeds ETH_DATA_LEN, so skbs are
never marked CHECKSUM_PARTIAL and no checksum is inserted. The XDP TX
path bypasses that workaround, so once XDP is allowed at MTU >
ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
device would leave the interface with a full checksum insertion enabled
on those cores - exactly what the workaround is meant to avoid.

Disable checksum insertion for oversized frames on bugged_jumbo cores in
the XDP TX path too.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ca61ab449e32..0e29c5d04714 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5276,6 +5276,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		return STMMAC_XDP_CONSUMED;
 	}
 
+	/* Disable TX checksum offload for jumbo frames on cores where
+	 * checksum insertion is broken for oversized frames, matching the
+	 * stmmac_fix_features() workaround used by the skb path.
+	 */
+	if (priv->plat->bugged_jumbo &&
+	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
+		csum = false;
+
 	while (true) {
 		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
 		int len = frag ? skb_frag_size(frag) : xdpf->len;

-- 
2.56.0

