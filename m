Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807F749B5CB
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541615; cv=none; b=KV6bRYyVynFv3Gm9Vn06bs7i9kM9XzpvZi5vbcW4dCxpZ4k6E3K7CSamEO69xYDm+645ok4DcXn2OcjSr23Czj7nf7hTyQm8RLRiS6BkzQYNW/bH6KBHhUdj19/wR9Wnujea2StL8knsC9SPN58zT13P+MX9BdcLImaxJc5zMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541615; c=relaxed/simple;
	bh=M7mNStVKC1ugr04TAxWIyEHUaWMb2wYabMIiEfVYPco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNd3DwWF/2TXhe3FWp1JrNQ1T/Rfkhm4CaDHMDDwqQ7Q6wVE2AafQmtbMH4+m6N8O8m3ldFOvfVwA5jVxJ2BlCMhLZmMVb0dOEI1X4d7uoiPQv/hS9w4YuNz02b0kjjDDu4EVvlk/gBZAlNgsXh9B6sMMk+HFy9RYTpeNgmp+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NNOJ82jI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KbLi1pSe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NNOJ82jI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KbLi1pSe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KF3L906796
	for <netdev@vger.kernel.org>; Fri, 9 Oct 2026 10:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrQRBTmL2QElj1OdIKBi4dLiSjrCHV8ryD7nPGM4RaU=; b=NNOJ82jIrvQaC7gr
	S7y0H6qn0uR+BGyXnmBQZUvkyf6TdsKaFvywPI0dIEuJjV4oO1MZ7PBWgJvNwMr/
	ny/W2J5c5ehGINVu2Mox/WGELpjMj3gpr8o5B/lXEYqFllB5GgBOYmdbOEQoy3+s
	cNgsxjvFNr3ThEpqCLcKlolfpzlY6Am0CW8tLAWgjm6hiIxI9aBE4iyW0H4fhnkp
	WTs7CSJB3xwJCBlU0wlvUYVZ0FLacCZxSPk3o1Dnb/0ZM9o3ZXnfRcb4ause769t
	uO3Pud0cULvjl/In+IOErOe7gSteXgo1v3Ph61/XiyVjLCRHT4y+r04QFDLzdacp
	p1grTw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqu78u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 10:26:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ea8067974so561195885a.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791541613; x=1792146413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrQRBTmL2QElj1OdIKBi4dLiSjrCHV8ryD7nPGM4RaU=;
        b=KbLi1pSeGc9F8jywFqsragEEErg6QvOiM4biX3yTh1Rw96D/rFXJkHvV+qCee2vW5j
         Go+1v3tEAXgvLgjHOEdsp/nliKcR5BTxTqUXE1U99OITyajhzAxFWnk4KNnu0NYsYh46
         /CDzVKIqHmxDa5aB7W87JY/LTEajlnMICD/KZkn6tpJUERb8CI07CAvfYfq0KslPH+5Y
         m7tWOtdSCM8EtPyAoI+MOsq0BTGgEFgVodnog5EFkDm9ryouSHv/l7SDsNoe8CX64k7d
         rl/6v3lrZnRgKcwi8SSZh73zBwxfpR84oMR9Z5w0d8bEX70i1qiRWMccvGKq2VAMnsCq
         P2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541613; x=1792146413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrQRBTmL2QElj1OdIKBi4dLiSjrCHV8ryD7nPGM4RaU=;
        b=zHSPgeEqn4yU7WkyLrfJ597q+sZRbHkup0Ae8rJu0KhJCcWZ33mCtVOREiX7lOMHvq
         08BDQDpGmZOMs9p6ERg3L2+caeH8/FwD8X3DF7/Q8vg/dwikSdzmJC82TldLE9UXgdAT
         iif8lFT58P7r4oxEXJE+eTLPHSK8U8BcKrdANbV2Z5TfNK+Ag6Di6ceWMPft+ykTBTmF
         NUrZOaimlI8pD/mHJQSdwk8YAC6UH/349hFh6rlbBd/COeWHjTqziulycLxA/fu2WyAL
         f6dNxKI8tKHAKQXzv6Wx3nUTH2cNadQs6nef/rHAvXEJybXAC/9LFWBMxsZliklzrs32
         wF0A==
X-Gm-Message-State: AFuF++mwzrvOGANM7ApkVA8D7F1RyhK1sdh9qPFxSfEnOpSXhK7tkBt8
	VDKm+lyOizXAtrZDau1JkkHBnKOMXd/sNjwkft730peXIszlCCwLBo+aw4My0YR+3JGj9g+x+HK
	2qefNZScspmzNcBWo8GmqmdVwgNnrM0WnBDBdXPSYiiFgFNrWdjxYzgHIaT4=
X-Gm-Gg: AYBFou0VNQUM78MMdAr0mKLKAhNKAACqo4iuW+ybAoXCcnOpxUzU696Tssv/qSopzbi
	/G/AGQ7V1UdS8lL9IZwHhhDYH/3VM2kKh+rJYk0hDG03kR7gPnNAfXvFwWcAuIrUtsKVoAVCq+U
	FjXzGpUtIRTcsNIdc8beP0jWHRNfTpahPvsXe60so33I7tGR0kedtb6vhFfvji0CRkiWuRPyyyQ
	2MHGoK3XaxY/Gd/w8ZLT8YfmEfGjR5Q2YOSAlyNsfmv8ngNLn/+0jh6swscl9kusRV4RmBtigE8
	eF2obj7TrT5PpcjWCD+BY2JokM0fbcSSa4Tz519CNyzRebvEYhpZhVjqzLHkiGitfnbxMFFlSd/
	IxMpPbJ34Sc77tw==
X-Received: by 2002:a05:620a:1b8a:b0:93d:23b3:508e with SMTP id af79cd13be357-93ebd0c08demr190781085a.5.1791541612543;
        Fri, 09 Oct 2026 03:26:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1b8a:b0:93d:23b3:508e with SMTP id af79cd13be357-93ebd0c08demr190777985a.5.1791541612035;
        Fri, 09 Oct 2026 03:26:52 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acf232sm3175313f8f.47.2026.10.09.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:26:51 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 12:26:33 +0200
Subject: [PATCH net-next v5 3/3] net: stmmac: allow non-linear xdp_buff in
 XDP mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-stmmac-rx-mb-v5-3-c38fa4eaa138@oss.qualcomm.com>
References: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
In-Reply-To: <20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com>
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
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX916xyrVfFqbV
 7f9K2q2E4dD9Reskch8un5bQxYak6ZlXyBUL8WpMzB1U1otwYkpy3lPHWMA5Ks+mhg+Ub1PWxu4
 /d7+NjAl0k7+YUerozDjjOh5epvNUkw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MSBTYWx0ZWRfX/Q9NYTin7fp6
 84bojmjjcUDXapIuIi7N1kpP6z+Wji8o+aOrQ+K1Z7+rcjq7ASTKjExId9SF/MKE9gBzis/x3qV
 2YivIH8IMS/w61kBvwZXVNrHu9SSx3bosEz7JbwQ69GwbV20gQQQFyIbWQ6ak6DNBi+SvCb/UW/
 ++2ohk4MT0XQP63C9XOI58LajyW+LGgxX7fZaWTCF5DXf7G35PA2rvQPj74+acyWSHv3M9QeFgS
 8TxtZi5AnfKVYsOrTwCveaL47qFghiWZSStcZBapU0o/sdmmDhynKutul7uQcRt2m4SWrM7v1Fq
 sdyN+0q/2qzu9yh+w8Pj0bm05Mi2u2OMwXoaQCVl6leYyLkw3sTnrZ2PwtsEJjMYVqRyftOQfdd
 AbztjCO5qkRgWDa829UyJVmlWcxH4svuEq2owHZAh//uEmpaKTC8acr56FeX85Pghiz9u+umwJ5
 dFKoGUrAWwNQBtnOdbg==
X-Proofpoint-GUID: q0pnwKvirWFXicVLTQcH-CpiDKOGiK7A
X-Proofpoint-ORIG-GUID: q0pnwKvirWFXicVLTQcH-CpiDKOGiK7A
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8c16d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=o4XRzpSnRLoaN3dIwwgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090041

Since the RX path now builds multi-buffer xdp_buffs, XDP can operate on
frames bigger than ETH_DATA_LEN (jumbo frames and scatter-gather
frames). Drop the checks that rejected attaching an XDP program when
the MTU is larger than ETH_DATA_LEN, and that refused to increase the
MTU while XDP is enabled.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index be2cba8fcbc6..cbeb43011c4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6351,12 +6351,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		txfifosz = priv->dma_cap.tx_fifo_size;
 
 	txfifosz /= priv->plat->tx_queues_to_use;
-
-	if (stmmac_xdp_is_enabled(priv) && new_mtu > ETH_DATA_LEN) {
-		netdev_dbg(priv->dev, "Jumbo frames not supported for XDP\n");
-		return -EINVAL;
-	}
-
 	new_mtu = STMMAC_ALIGN(new_mtu);
 
 	/* If condition true, FIFO is too small or MTU too large */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 9af9e0cb366c..f6b3e8628a7c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -109,14 +109,6 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 
 	if_running = netif_running(dev);
 
-	if (prog && dev->mtu > ETH_DATA_LEN) {
-		/* For now, the driver doesn't support XDP functionality with
-		 * jumbo frames so we return error.
-		 */
-		NL_SET_ERR_MSG_MOD(extack, "Jumbo frames not supported");
-		return -EOPNOTSUPP;
-	}
-
 	if (!prog)
 		xdp_features_clear_redirect_target(dev);
 

-- 
2.56.0

