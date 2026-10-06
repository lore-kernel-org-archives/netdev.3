Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B732E737E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283603; cv=none; b=TIb2zaADCn+1RZ/VaM3BcFyvCV8SOGYd57zGTjTmcqQNy7A42ObKMjLHz9/0Zc+pkCDyf54Cb44VCDKTg37IbM4JETAbGOV+rypx0UgXWOLT6HfsEjzCFw3jVavGcP24P+t7BZfeJd05N0dbfgS6TA9U0nEs1f/YOZDGDIlnbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283603; c=relaxed/simple;
	bh=Ty0OGXYtXwXIIpNCR/LXCcos01jjV982hYPRaeceJh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNjPmCyXuSvfKnu9MG1uCJtW1CZRWJNW+9Bmbob8NJAVuQ1lbjIg63+EP2QULO5lLPuPLBw3eOlSnUm9VoRWTGCXyhracY33n+iXUhEsZKlqE0cICfqnSR2two+IhSE6WT0aQ8C8CfOh8vVziY5D+OsLznt6S6NKKElNtntdEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DefDy32m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ur2rA9Et; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DefDy32m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ur2rA9Et"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696ARH5n208878
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S2xyB7XTL0+qCDVUHZbY2vfGSDX7LTYPR+SqfX60x/w=; b=DefDy32m89/epF7H
	UMoS0HTLGsYaRIzlo7FZdgI+u3RBLPi03mUDHRVR5oCv1Vk1cAjvX16uJWcA+XUE
	ELLQwwatmtc1rJkiRd+lmMYLdB/y2kTvGBmNS5NNuMbjEPDdUfMrt9WVIBeOZNlB
	QbsUEFqtetH/QLkyrmBaZP8xj/Xj9+iq/C1NPvD8ntYuB+K1MNoN76hgBejG+j1t
	UxD9Dyxtl1QUVLVlqO4qySaDNz60hHWdI+nk1l4nwQTO1fYB9nt1vkvnBe7/P+l3
	H/uAuavfE+S9jbgPju8Bicm0iXghsvjZvEGv/oj/NaYFPPW+r4DAXVQOd4SaeVMO
	GWMdLQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xdu88hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:46:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917a438816dso70985326d6.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791283600; x=1791888400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2xyB7XTL0+qCDVUHZbY2vfGSDX7LTYPR+SqfX60x/w=;
        b=Ur2rA9EtTFLKQb9PGyQ0MLc4YmJtAFJbqLQaLc4jhzcKPBoCB3E5e/mkmVh9fURDEQ
         gzxitsfYUytG4vUMKfYU4h1DRmVOhz5n9BgD+O7oltOTzqMT52DWa6xVJteloqFsQ59u
         8aFQXpNoU4JavnfGW5ZTN1vqjWy84mPQu6EuS2Wiu5/GRtUYgh7YoDPgE1DBCHlp3mau
         jCnA6SvabwqILHnGqwiisTzw9RTnJIVapOfbOgvsRg0lF1RXv4Wvq2UOByV8UOdXZrCa
         tO4RCRmkdi1CKh5OHvu8rbEMeJ3rCnF2+HcAHB57Ul4Lwsuf6nlRj7V+3WA+fd4Smrb2
         373A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283600; x=1791888400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S2xyB7XTL0+qCDVUHZbY2vfGSDX7LTYPR+SqfX60x/w=;
        b=xaz13zlfyJidXr8kJeAcOrFnkMA2zbcFD5GGrTkAdDwoQIH/sVcxjnVOfXhqKQiyjQ
         JjZw1XNb0AtQWBcvLMPNoQOt8nY38vt9skJUDxeMWsmFqjwZAOtQyMr+Fbdhj3ZC9Bhe
         5/B3m7pRHzFfbJW52I4FuELC2JuGMc2WIXBN1yRFzOGfq0jPuX81MQZZpI++0vLYpT+z
         r8nZatrAkQgaJBSQXcxOnmIbsjNrj75Lfu6ZeVguCjw2WyfShPViA1UxMtTfHYjkBrnv
         EwJoYLdF8moah93z2Bu2Sc2s4nOLn0NuaITHpOS9sKgtQdmtrBiZy82hE3mqpHQfFFbA
         RsFA==
X-Forwarded-Encrypted: i=1; AKwUvBydPTONVnNMzB40P4OVGbMxpqBBDu7ZPKdWzwRK5nceGwPkdPoEsQuQoe3aKfA6D8hjARA+eLg=@vger.kernel.org
X-Gm-Message-State: AFuF++lvVstiAI+xZQvbvnLYNtsuQHeDMqNJKxfbnxaNDgH7Vc9cjIEM
	2Xds+x3GQJBoiVXaMc9uv3T5MbuYd1kkXJJ+iHi/nj+mVIMRCOLpDIXJq/twFJ8QfYYoaBa/cW/
	ktCWsbs/2BRfMHRRFdPPkwxLRIOFecP3eJJuW+teaHfp9Mhu05sILoQZ9Wmk=
X-Gm-Gg: AYBFou0AitzSwfMSqzpsBnzjbMpoMaE7D4ytzwIyBhljoAWrgVSQh0Ikzi8Vz/Bsce8
	ITDW6J9t4Y3M/uodcVVIfG3YLtgJqizS5nbsWqidM/+kezZ7vZTrzNnjPxVTPJ58pJiUobnToEK
	67Kd9i06QaemBCn6IWJLYirrDb5QCQ+HfJLl6prCJvwOivfErLH2RPiQhYJ9EOHNTu5Nd9NmFnP
	lenlcaKttTiiKl7sXk18hbdt1383nIZgmGQR2LjHm03FzAkOuHBqmZ1mVNvEq4096WSqM6qFvFx
	pTM+/0RxIAe50hDiF7mHfY1wWzX0dhwt3C8ud+QlwPuvHpml48IOL4miCVxBw905gDavw8xcHD1
	IAeXNW+z7hQk8IA==
X-Received: by 2002:a05:620a:a2d5:10b0:93e:5953:1cb7 with SMTP id af79cd13be357-93e59533371mr1145544185a.54.1791283599761;
        Tue, 06 Oct 2026 03:46:39 -0700 (PDT)
X-Received: by 2002:a05:620a:a2d5:10b0:93e:5953:1cb7 with SMTP id af79cd13be357-93e59533371mr1145539785a.54.1791283599229;
        Tue, 06 Oct 2026 03:46:39 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6fa8d2cfsm728778f8f.13.2026.10.06.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:46:38 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 12:46:25 +0200
Subject: [PATCH net-next v5 1/3] net: stmmac: set real_num_tx_queues to
 max(offset + count)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-stmmac-mqprio-prio-offload-v5-1-d7da93419784@oss.qualcomm.com>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
In-Reply-To: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX1dP7sUN6t7Il
 hVPAMsOo0tSICLZUFynwZBKDsE7WsjEp5w54S3LikAtBM9ngpn+3YaQ4tnS8fZCZC6PIWPPR7o9
 96fT8kqbb+y/AnwzNkrToMRmj6j/yUQ=
X-Authority-Analysis: v=2.4 cv=NshE4MdJ c=1 sm=1 tr=0 ts=6ac4d190 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rcFsrxwjrcho-PCruckA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: y21izevdrGBR5XITHMv5MJzYNELYO6Q8
X-Proofpoint-ORIG-GUID: y21izevdrGBR5XITHMv5MJzYNELYO6Q8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXxo5cGq55ZQ6B
 vAq5P45EE8I1igQFAvArVEKozZ6H17RYL3D+6+xZYZvKMezDMoPI3UITLYS/rIK9gavfxN1hoKp
 vpuHEKku0hwu01+36078U5m0meuOrakTK1voWROpU8hmR1TbexItp/D5LoS4JIvx8aZfsPzh7UQ
 5ON1WPjWsL2tOC8qZCRpIGaRi9AhUyisTcArGAi1BjYPF/FDtY7i3ArvLHrzOPuSfn0DP5pGhYj
 amfRawlUFViiEJ2e9TMQ5RS+xr8MVoW+/Shz9yue88G9J816TzMwIzX0C/4Xch1hZoOc6B1qJ08
 7iJJ+77XaainAn8KMs2rIY585R1ZSUOX8olA4ke6QrVhbWzrliHkTWQ2TG+ZaK/fBpTZ+vGP3Xr
 3bRnA2mULUAP9mDBe3wr9prLLd1NRdU4kHom8R6G5Fk8AXoTeL3QCrz7SOzW8bTbRxBGfHN1qVB
 2nOUfoKH9Yll6jvs+3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042

tc_setup_dwmac510_mqprio() computes the number of real TX queues as the
sum of the per-TC queue counts. mqprio_validate_queue_counts() only
rejects out-of-bounds or overlapping ranges, so layouts with gaps or a
non-zero first offset are accepted, and in those cases the sum is smaller
than the highest queue referenced by the netdev TC map.

netif_set_real_num_tx_queues() then passes this too-small count to
netif_setup_tc(). However stmmac_set_ndev_tcs() has already zeroed
dev->prio_tc_map() through netdev_reset_tc(), so when netif_setup_tc()
runs every priority maps to TC0 and only the TC0 range is checked. A
layout whose TC0 range fits but where a later TC references a queue
beyond the new real_num_tx_queues is left with num_tc set and its TC map
pointing at queues that are no longer real, without any warning; only
when TC0 itself is out of range is the mapping disabled. The real
prio_tc_map is programmed later by the qdisc, after this call, so the
driver cannot rely on netif_setup_tc() to catch those cases.

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

