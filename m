Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319449D5AE
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818722; cv=none; b=vDw8y2Zrl5k8KhsrNCYO3RR+vr4PtVNWwEltUKZuViZJVw4EJZ6zr5dYedWJjm5EtqLm6PRrRvcVGVpFPyRvF9goH70EDJduy0lNthRqkqwTHyAIT2teZ96RJZWOmwcB9yYKCJIHxab28sv3HzkR+LFD77WXYHm58REb5y9BzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818722; c=relaxed/simple;
	bh=uLgwTTxiZpNInq7W7aL0wWG2WDX0Ic08HNd764X4JW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FhIJdiP0uYYwWzj/SV0Lc6EUDGDOY/GpPCNwKUlS4bU1nkxr890/aOlsI8YG5T/j/QzyA6ld8gG7bUy/ppChB8LvWtWqoDCDPMdrCVDk7PIsVOMPd2E1FQEYfagT1c9rzalunE3aTsoSx0DtfUPn3TndRSe9fGd8DGyZhyQYAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1bG2YNx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R1VZkG9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1bG2YNx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R1VZkG9V"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC087g3292287
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g3lVCKwz3m+1Qgdbpu0enx
	VKwE6OpVLIOQB3rCyKQnc=; b=I1bG2YNx5jnaa1O7dGKuJIoyEDR3xy4PkZQFyK
	KwRDYeS7uxzflVZpXFChySjV6bHq/+W3tarnYnresBAvSEqlu97WjnSq9LUCoF6V
	sINHBWy36I8l2GU014nOZPluVKuCi3SYzxBbo0Sn7FHwdtvM21Enp3xsrNC2Vbyy
	ulJbQESBxrqkeIvXPQ43vuON5l658vhuXk8T5ZEzf4pPJT5PaALW7SRf+Hdlt5Ko
	XR3BrYEtvSBYfpRsKi1BrRonCmECYEQ6dMcY7vy2OS4LSf3aEdDwgEJ4izVm4YOM
	9lS37cXrpDck6JHZMMXkzBnuEHCBZzh3sNstK4gTbKKiAWpw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3j1qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:25:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc40759b2so464887385a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791818718; x=1792423518; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g3lVCKwz3m+1Qgdbpu0enxVKwE6OpVLIOQB3rCyKQnc=;
        b=R1VZkG9VtDq4Nqreowy4lBtokrmUJUgKYFCJ7hsVkCsEX6ik9wwEPH37LIYeeEgc7Y
         VBh72z3f+7QBlGNn7NPsOmBesp4gOgRED7DUwumM+VqsYbrwxO3J2Ljt3GzId7V1boel
         cGlLyoGwpT4B14UreEkNVb6ZLGtYpi6OQRlvX7U0bMHPpDUVOJZ1sfvT/Fr2mg/GujBP
         mVVyu855j3RK1j7EtdLmtG/t6x+KrT3cQaNs5eoS+sdGJpSbybWliwGQQ+nDWM2WqWGo
         hFyGhnqnhivLZV7IFOhsgpVwxj+seQF5WhhWtTIQnO7YpuoM+Ht9oMOXn3q2p1lW7KPp
         pGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818718; x=1792423518;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g3lVCKwz3m+1Qgdbpu0enxVKwE6OpVLIOQB3rCyKQnc=;
        b=dhtWPU+EyHI6LK4aWZd+EwqU6E8gstHn4jq9kiqqcyHcY9yZeiCk6wzVgRUsw3jjlL
         qqTM7g2d5Zqb3JUhI8yPkzrCRHT2Vb1j5H/zNg24j9Xp1yJhOV4ncTSBjZsdO7ezoMaC
         XjLJOkexcg0aeC2VMSNbwNh/4ZWxJF0BIBrXJVJDKRVu1KnfL7QTHeaX7TZmj46oJWA6
         ooht4hlGUazyT8ha85jt1KcLyIx6mrf+IC2eFHCXlckiBHLf4Qc+5t1qvrd5fytEpeDD
         EaQsCAclamu6CO1U7DLu/3kouOW6qiCjso0V5wNfsbvG07owtN2oJvYUAHfG21Dp8ZUJ
         y4IQ==
X-Gm-Message-State: AFq9FYLU2apNsjYjoGnRqpQA1KrlDK52HxuUHHKIEGYIWXKlQWJD/2P8
	YuMj3GgZbiMGCiNcqxiWpoVCQkgmBjKVxWprsb9r8f/pAbRHIdFFDii2P/yGrf3E4ObnXShrj7O
	DJPC5mxpmNTk+36OhK8baeI5MB+iNUrRbfXr7yJ9NfthxFs5pKmZviarAUPw=
X-Gm-Gg: AYBFou0SYFKPHUh8b8HFkzX3GW2d0lsXvMwR+tZtcqdUCVw+OqGW6B9Ue9o/iwq7107
	c6tTIfyRNrsdF0FtuCu3YX3MhevRnUrqiLbLeDdT7DEVPSS8NU0/F7QruiI1Whe4vssVOfNbk9j
	QvmJJNvqYoQoJWcbWT6dL77RMYKvEP//VHd4FUoSWeeRtMX3YSQDlw2RLPQoWD+uJRPxJV8NT9s
	QhoAbOlUXHDzuDgbGAqyvEDBBdW9c+9qN11u1xA9Sx12tddX0gz/G5XxtaSdaBg99pom+ltxV0N
	gFoXaArEm/DruLRZ0t4wLC1101l08fgSmQuNpdOPQCiL8XimVzHgUbo7w5CIr66ZATsigVDFpkM
	4+JiSTuKZqJo1eg==
X-Received: by 2002:a05:620a:4552:b0:93c:6abf:c8ae with SMTP id af79cd13be357-93ebd231201mr1728165785a.50.1791818718440;
        Mon, 12 Oct 2026 08:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4552:b0:93c:6abf:c8ae with SMTP id af79cd13be357-93ebd231201mr1728157785a.50.1791818717740;
        Mon, 12 Oct 2026 08:25:17 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e49792bsm475483735e9.4.2026.10.12.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:25:17 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next 0/2] stmmac: some XDP fixes in XDP_TX path
Date: Mon, 12 Oct 2026 17:24:38 +0200
Message-Id: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqEMAxA0atI1gbajqh4FXFR2ziThVWaIgXx7
 hNcfh7/BqHMJDA1N2S6WPhIGrZtIPx8+hJy1AZnXG+NdShl333AGk8sFc9MuHElwc+wxW40Zh2
 6AHqrvKDzDIkKJqoFluf5A04NlRdzAAAA
X-Change-ID: 20261012-stmmac-xdp-tx-pre-fixes-37fd4800b74c
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfXxQXWIkPYL7aa
 d/RPncUwthGRP4K9o13Sl6rId/25sklXqIZQJeEqQ43MnBbLPOS5AnqxlNbYCeoUsygflPTWPyg
 PH7d4R2cMevfWen6EbkMnYWl/6LgT9khr9Y7+E+OLyfXG1kPuPoSC02bY0jdrc1QxaA9wcbGZQ5
 Pa0xPJIiTj5Ir6UnlwCSFbZq7kZHut9NaEDD3JFex/sucZ0i+NZWy1pch5we2VUhWE/GZdfcbDw
 EBsaMKu6hZDxj2i2x3qntOiXxRUKepZbifr39D3kbGzsHiT6Vthsz4bDmY+jnPy9MmGTaRRAreM
 Qtc2yteAoUto2EgtDpCnn9UN2vqy5JaIqNUnXTNrdh1A2CAdP3uPVyx/JXie4BifwHe6dpiTOx3
 zJhKeW5WYJYV1zLxaFGvcn8pOJkKb2QKUSfawCm+bcxqKoT4+gHCmwFiCUPanc8eHNIKmqxyUM8
 aVT62H09Ggzf0YJ7QHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX9N1TQNhjOaDx
 r2mzu1SEL8mGHgSI/y7vwiCFz7xhuVXvz7nl620uTVYvhm+JDiNBpaL8BZQLKVIP/QHqMQsi3jZ
 W6cXYIdCchWsA0yBIQq8c++ux4/zKCQ=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6accfbdf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=e8Hy17V4MP4qKruQfKwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 4gk6bCHRXNhX_cR9rDBhiNG_gOcdkjA4
X-Proofpoint-GUID: 4gk6bCHRXNhX_cR9rDBhiNG_gOcdkjA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061

- Fix page address lookup for compound pages in XDP_TX path.
- Disable TX checksum offload for jumbo frames in XDP_TX path.

---
Lorenzo Bianconi (2):
      net: stmmac: fix XDP TX DMA address for compound RX pages
      net: stmmac: disable TX checksum offload for jumbo frames on bugged cores

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 29f144016f03608abfddcd6ebaeabafd7aeaadd2
change-id: 20261012-stmmac-xdp-tx-pre-fixes-37fd4800b74c

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

