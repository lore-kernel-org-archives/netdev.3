Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847CB263F5D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862653; cv=none; b=UyhZZoS2VOPguZh32Zgn3Nh7fu8/4YX4QMLOxJzEVQ95nNoAT01jRqKRma1XopmG3a3yNnNzxDbUnaZ4Ru5SBS/OF7PpI6YjniApubZ8R0O7E/IzX4wR8IwYsnsABHdB8sPR9qMyoUYIMdzgqHmfveXP9QyLPSy419xF245Ib5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862653; c=relaxed/simple;
	bh=Vdkm+Qnn5449sS+vRA4yRjAKyEgS+JyA0fNZ2vjCTJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUHhcRNpnc0SuxRRjFw1ZsSq5mX4SOBpFGSnSqtBED4VvHIbL95tl+97qcjuavW3X0SqYyjfE7eHhodRPpCrE0vg46W1AfptZiv6X95iwTRO13Pi2iYY4VaJZ4RNKVDc+BGLZKiVdkYcifRdsRXI7SBufCJgZsKXfW9I5ImgQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwWInIji; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GYuaCsh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwWInIji";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GYuaCsh3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DjdFM2570668
	for <netdev@vger.kernel.org>; Thu, 1 Oct 2026 13:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	anZMUlFWluJFZosHEUNRpWoVljRu3uvfOe/sW+wWxKg=; b=AwWInIjilIReedJ/
	CRbxxnKSGNEAghoayRYm+Xdvo66GY7FUfaDbhcx6Bek7X6VLzyDu6iMihFGqYO0e
	3TsY8H2UDkBO6XZZdfxUPoSvF58FilX8IGLJxhNRH6dIzRsod12uOgwMQBKlOdms
	zZMrRlhE1bhwYcE/63DpV4iiSd3Ktw743aCFeu98NiAvahB/dV+Y+z3IVnaYucPH
	yd0X5N4/o47kBJIQd4wkv6WC+/gS5tZKLem/IU1JmyPxW/yKeNa+FLQaU2ChVBy6
	gB8KTMlL2Uu9vz5ApsL7AgXmdbZHzDj8KHKrRfquOTQhRv3N59lVL3IRu8ZmJQ+w
	kNkz3A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pn2p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:50:50 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7be35e6911dso1210242137.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790862649; x=1791467449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anZMUlFWluJFZosHEUNRpWoVljRu3uvfOe/sW+wWxKg=;
        b=GYuaCsh3BirExTgzpbbVuPzzKnVOlfTF0WgPD8HwQb6ZTyN0xC/TnoiPNF7W4NRSQ4
         XoK7eRLJWGeI93BiiRdretHUDi90bTUAmHmga4sm09qDhiZ7xcMrsMrjPGo13ZqCB63d
         WX1bXYFEkGC7J/0uAYrKw/4FIl847c/po1XfC2/25dGAFIsx4OUkIV4gnaK5p86sRys1
         SAgiTMEWNivK1mlq/lLScLXMsOq/i69rAaRfohIQf0o0gULf9ij2IVyC7nSJvFqcBb1R
         4UrDrmjwvGajst/r2nZxDK+SANERbnPfW8PSs00+z/Ds9+0CJdpwv33fSb6+RZIalLfH
         FaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862649; x=1791467449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anZMUlFWluJFZosHEUNRpWoVljRu3uvfOe/sW+wWxKg=;
        b=C6ptAscBeHyAMGQ7sl4F/5x71xcSJBSHwIqY6hnQmhnxTT11dPK8+s7pz2yXRkygSP
         acIgRwWE8dMni8HkSvi+76fdv6T3Ku+tNhF3begKLm64xch6AxHkJrSUDM1aVGvijEr1
         j7skesww/mgMDO7qXAdJnAFROhSAfnx2Z586n6Zux46uWdhAnPLJKItGAxjbLYOYsvCl
         tbInJKFJJ7d6kxO45OA2vCZhrbjvE7T/qWcT4Uqgu7VsMAD+KNpe7gjrfG/z2uuY5x6U
         TmpB7yS/kKg67U4NgS/SiDp/A3KInKqaTLy8XuiQ0N6JCzkiDxJo7lrGCk/7bB2Hymxd
         vO+w==
X-Forwarded-Encrypted: i=1; AKwUvBxRRGW1JINTYmsGcPn2R5QDgxfJFABZwFckM52hgO4uNezOWlcjtNMlTdfnLymRj56kFu4dcjc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX+NDhXx0ERaVHrEQGyf/oQWHFb0VQhwiqTU8HYPxROSpILx+W
	azc+/f8b8QyaE2TELU6REaRAa9PdubEHTt/6jfeehcMhTB8/gfR7/aPAGPdH2/+4Pu1KHNXS7LS
	Fn5+8L9rI7ji0Xi0OczKMMyIalXTif1rC+trqtAqccXLGeZdhBY497RMAT6c=
X-Gm-Gg: AYBFou3MzJPyj/T9Ex7YZpaDQeqvY/YQrSVv7vbQqj5jyNx8c8Pv4wRJcIQY5sLYTaF
	6sG4ieWjDLR+jFdKDcxyXI37fa1INZhHpp0QLxFz/t8Se6FNuEh3lBA2Xzulhy3K9ax5FEKx+mW
	gEnliC+sJ6gAWNC0A6G9QTlL1fZ+OWICs6S1nEwWVjoup1ovFYNN43MkANJ9BHtJAerFraht8Jh
	Z2FiLRZc86HrdmhorKskPEihFRoJm8woVVrpMy2KoSrjQX8Ttqmcs/f5p/bCEljTW8RmL3kj8Dz
	81y8j0koaj8XQ/kpup4oCXtwNb4mAhhFNWOK7oKNnMhupoTmTB37i12ApDZxpbRmmtTZxfCRFlv
	/4Qz9wAKoQthw4Q==
X-Received: by 2002:a05:6102:4499:b0:7b3:54c7:7ce4 with SMTP id ada2fe7eead31-7be74985077mr1542550137.35.1790862649307;
        Thu, 01 Oct 2026 06:50:49 -0700 (PDT)
X-Received: by 2002:a05:6102:4499:b0:7b3:54c7:7ce4 with SMTP id ada2fe7eead31-7be74985077mr1542525137.35.1790862648635;
        Thu, 01 Oct 2026 06:50:48 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f90cccesm80653465e9.2.2026.10.01.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:50:47 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 15:50:18 +0200
Subject: [PATCH net-next v4 1/3] net: stmmac: set real_num_tx_queues to
 max(offset + count)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-stmmac-mqprio-prio-offload-v4-1-a74610d7f1e5@oss.qualcomm.com>
References: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
In-Reply-To: <20261001-stmmac-mqprio-prio-offload-v4-0-a74610d7f1e5@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Eo1LSH75QMR6XJ8IQbyo63osvMaHSRTK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfX6CGxclahHZ6H
 rHr8P0iHCMcmZBYodlbiz2G0mpaseWPz7/YEv/nmclrI4O+eRl6BJju7ec9fDWmER/SE9RiqfGg
 +xOuL1GP+rCWjjVvAquJw1p2y743gBY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NSBTYWx0ZWRfXxRbjihTfhIoW
 06V0vMuft2v4EB32+OJGl8zrNdT+ZApE52q/hwnJDmiOILWIFlDT0b/JmIswKVbILVQAcCMvorx
 og3qZldPf8rSynty3pohIR0/6AlYzJcJU7u9eQS2hdwEzochz6M+0ZB4cojEcdl7qsa3pn3KS2k
 MAV8yCPi0MJFcFsPXoSxDxQOMG+e0RFShivfJ+57m6Er6G43aLgZdGmHARwKct4tbfWQZxcOhF4
 AyUn5YF5cvpl83H+UnBkbrBiio4mpdSxkm7Eq3EYeLqpD0eddclTtNoasd9DyPwZpKIs7W2SHhB
 hgd7adD/XUnZTVMU+NydoZjWRLlfXPQzNjZEv+GBYxVejeqJDGA73X6SGQ+Zpi49fghXriVoA3J
 oYQ/OBrG2PY16IzdY0Uj5FCWwbgawyOWvLCmonS6iIpmQCafkqq5KGaATA8Oy7XU/MeRUQBEOLB
 A1PUMFHnA5KzHBuzIcw==
X-Proofpoint-GUID: Eo1LSH75QMR6XJ8IQbyo63osvMaHSRTK
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe653a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=oHinmdPMHoDLt9c3IdwA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010055

tc_setup_dwmac510_mqprio() computes the number of real TX queues as the
sum of the per-TC queue counts. mqprio_validate_queue_counts() only
rejects out-of-bounds or overlapping ranges, so layouts with gaps or a
non-zero first offset are accepted, and in those cases the sum is smaller
than the highest queue referenced by the netdev TC map.

netif_set_real_num_tx_queues() then passes this too-small count to
netif_setup_tc(), which invalidates the mapping.

Compute num_tx_queues as the maximum of offset[i] + count[i] instead of
the sum of the counts, so real_num_tx_queues always covers the highest
queue referenced by the TC map. This is a no-op for the contiguous
channel-mode layouts where offset[i] == i and count[i] == 1.

The issue has been reported by sashiko and the patch has been tested on
Qualcomm RB3-Gen2 board.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 42a00446e9b4..1aa80d51ab33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1303,7 +1303,8 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 			.count = qopt->count[i],
 			.offset = qopt->offset[i],
 		};
-		num_tx_queues += qopt->count[i];
+		num_tx_queues = max(num_tx_queues,
+				    qopt->offset[i] + qopt->count[i]);
 	}
 
 	err = stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq);

-- 
2.55.0

