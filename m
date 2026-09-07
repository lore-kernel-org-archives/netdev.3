Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF140A93E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766450; cv=none; b=uvqXFB+izphMGvQMQowJ155rhONt+rvimm1oupBR9luzXmqa23ixA5glA1XpwB7+yYGusw3fep+XdI6SeF4BT3ioRvcz2N5Lw1dntPJsIzvHDIZx7KSlVgZm2ekD/uZ+QvvrcUKOtsFdfH4SUQpgSKqxHbX18wEld681lZq7z+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766450; c=relaxed/simple;
	bh=yagJzAETAF4TC2pRSdlDch5zUPhjR+z4M/nbHRlg9vQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OOdU/d/Jw4FWYsCPmPc7yd1cH6JaSQPzMmZzEiiEMCaXQCC74roFMqr+qflZnMXjFoonq4oLrX59vwr8x86MiXPcttSvgG3jKNuUUbUewfZd21T7pMWh2eMmMiRzTAN/NGo/58NewB9L8xinoXwevvGbrN6kHb85Ug9F0uPAPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AsydXSqe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JmmuyVMm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AsydXSqe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JmmuyVMm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877NNSd333053
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 07:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BCeB2q39kGDNUzJWVGp367
	dKzfsU4Ljb97JBe37jcyk=; b=AsydXSqeRixpMaoIVj1h4B2ZDcov3KreYxAomN
	H9OEO/1qF1X3PW+XaY5E7AFHwwD4ewHsYtbw86JuHENHtjbL//1Vc1H0woS0jZlp
	V0HjM47ULHAuparY43HyQ+TTEEn93PwhE4UuKQmmfeQ9HBysW7m9xveXeslFI/TS
	vR7EmGYLMoknfE6Hy+wDN5D/xZtuMsMrXUKlm16M6wAImwa1y1PDvPHHNlNRsBE7
	pKfju2gSByU51Qw6JykPpKQggcGTE7OVjBGq1aKmFITP1uAO0JclyPGIKgdW8DTY
	pkSJtaJqunyP/aTivGgA2c44LGZ40fP95ARpE/UBWvcG2Npw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua854h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:34:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b571432fso509222685a.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788766446; x=1789371246; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BCeB2q39kGDNUzJWVGp367dKzfsU4Ljb97JBe37jcyk=;
        b=JmmuyVMm8ixtR+8BXNqJzWC8L5Hnb/xV7djha72vX0D3b9AFuZQHK8p1+cD1pjepPn
         2E8vhMS/xvV7zpKgiNBZjlnX9xjQMCNj7l+FDAJL2euu2HOOfxIKiKIgI2S/3Fl3P0y+
         uPR3l7w4iPNqlPYyAUdt3mGyGJUFgwJlRbhFjMvOdKDXatzPDPvbFs4dRzOFH1Pa23fN
         /gjAnKApOWlr9xuVHrdRN4+yliWDoPhQ2WJvLvbb6bxpG78CLPDCb5lu+DRIIDWW+MSD
         04gNV9gxvEofT6nEe92PeYxCFR+ig7shPDqq1ETT18Syf9mvTBq0nzHU081oyJYkrlIQ
         CP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766446; x=1789371246;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BCeB2q39kGDNUzJWVGp367dKzfsU4Ljb97JBe37jcyk=;
        b=It3DrMqbik1dhPhQ46SM790ZMmrfchvc7utB8UkjHZx54sIe93g40kkhfFfgxQZlzy
         SwgEhZiFxb7HILYfdO3XTDzrI/dq/C+FRdqZ3z+kqOCQY9IKquKFAveNT6m+VJvQHI7z
         IDt/dNG4CXdQrVbzghGpol52vmYlBz+HGQNeXhjaqtcrxORd9oKdRJ2ctl3r34IbKjKb
         BCFw95JrbdOeTbTjpa6arBHRu6uCt2SfijSiC0c3mFCVh6L97CqnzzLwjCM16ezR1j9T
         8xbspRm1nwCSIAnPojRVuxlY4f+PU5/GiWd0K53XO90jZT58GVOuxfwnc2MTPdLV5U+V
         Cl8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxYBfohtVexYlwUCVTQCGIUGuoMG7Il7HFZ0lGQd1VqxtdpxAjS1BuMb3OjBFx54gL7JNHdtoY=@vger.kernel.org
X-Gm-Message-State: AFuF++kOSg+z0WLyFI4pcywy36Jvgf2O82rTOzwrmhbbzcjUTRwmZR6o
	P/C98afMSLJFBuY8i1PSSCRxeDEifJ7+IgUF+F6YubRVikgTKr5NgObVMRPCtDP90UCii91mOAP
	FEP44woeF/0jo2uuc6Dsay/Pb/C8FuUk5I28w9yi2RZ6F1mwporBLSKire4c=
X-Gm-Gg: AYBFou1DzSLuRTMyS5/VlgNIxskkQUs98ncGuPlqnT9nxhSt3bKs+BDpbOftCSjNSeJ
	bM+rqMXEXxBbrJTn0/2LE5yGbAPxPj1ZGL8jFoik/aGs9b5JLDgmmDShXV2Mt4m3BSDY2QMCUJ2
	II0jGZb9sK8CKl1zRyuJRKyG6RPgYHRH0wu+/84GgmVJuvJcUQprmR3pY6TLa+jjuGyFe/YibZu
	sTY/cf1ZZmQd9ZiYLMZZY9PxoFS04NA58S7Eb8EG+zSdp66xNMBsRGlIsrJMod7BHc1TU7eb+ta
	b9b/kcJIBOw3X71CYb/QAWpAM8viSUJH6dqyyt/ZcFIA+SOfiNCVdhUBtg1KmQI/KrmTlH/4CXd
	IFxrqgCq/RE+ZEA==
X-Received: by 2002:a05:620a:8393:b0:939:78da:5c2f with SMTP id af79cd13be357-93978da5d6amr1959837485a.43.1788766446248;
        Mon, 07 Sep 2026 00:34:06 -0700 (PDT)
X-Received: by 2002:a05:620a:8393:b0:939:78da:5c2f with SMTP id af79cd13be357-93978da5d6amr1959834485a.43.1788766445826;
        Mon, 07 Sep 2026 00:34:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm24990405f8f.22.2026.09.07.00.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:34:04 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH nf-next v2 0/6] net: netfilter: preliminary support for
 IPv4 over IPv6 and SIT flowtable offload
Date: Mon, 07 Sep 2026 09:33:35 +0200
Message-Id: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-0-7c6ac1750725@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OQQ6CMBBFr0Jm7ZBSBMWV9zAsSp3KJKXFFgFDu
 LsNR3Dzk5+XvP83iBSYItyyDQLNHNm7VOQpA90r9yLkZ+oghaxFIwp0Bo31y6Q6SxgXVFqTRR5
 rHjHyhGMgywM7Fb5Y1WVlFInSlATJmJjh9Vh7QBI5WidoE+g5Tj58jxdzceC/BucCBV4knZuOr
 roszN3HmL8/ymo/DHkKaPd9/wGqP9Ch9gAAAA==
X-Change-ID: 20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-5635fae03f3e
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 8WUsvaMHiXCC27EXFofexhMAWq0H9c3k
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9e68ef cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hjUsVgM4bzNdy_QoUQ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 8WUsvaMHiXCC27EXFofexhMAWq0H9c3k
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfXzFVMH5oaFklF
 QJLsS6kwhjgvSwndcyuUBf/IQVle4YLaAL9ezeney+acGgPjzHaU49KwM2XISQlQzjaLdMB8VNk
 2hRUAqYbPs+D7FWclkSYpWJQP/f1DCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfXx6cekmXV6l/d
 Jz437q53R3BWajc9+Lm9gORmO+1yK/IphLNbe1sH1h7KtZ0v08fBggsBMQQjf0JIKrGDOmzKHiy
 r04R97qM7w0H/fFLWIihjhT6/aKL2YYtH9xyKjseHe6JX/cGMR4rOd1fi9sfF/GgV5f3z0JPcGX
 HYH4dzSWwgv3F1Q0b9SfHvscSXjdvyq1UMGcA0pDiMizaQh9wD2hYATXReuclMKQ1/J8IqGwvqZ
 jgwGXg8u7MuouH7Sd1uCyLkc85K8konXy917y/J6Ip5E8CA+CO/3JIx2yy0KSfSi6kAAjGAw6IJ
 iT8IeFCNAOTR2j/Jagk7t7VVRpPYqcoG/0TP4TNO0+40kAwxqf2PdsmBndDj2vm1VsrG+plo9bv
 LTyKfxHIgrXAkiOEPLug6XAdpWyY/C88VTe4N7sgbETtA13uoFhRZe+DweJV6Wp4q3Xdv/ERlp9
 Z6b5PeiDJfflKL9gxFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070080

Introduce some preliminary changes needed to support flowtable offload
for IPv4 over IPv6 and SIT traffic.

---
Changes in v2:
- Fix dir configuration in nf_flow_offload_check_mtu() to compute tunnel
  MTU overhead.
- Link to v1: https://lore.kernel.org/r/20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com

---
Lorenzo Bianconi (6):
      net: netfilter: nf_flow_table: recognize IPv4/IPv6 in tunnel proto matching
      net: netfilter: nf_flow_table: set inner protocol when popping tunnel header
      net: netfilter: nf_flow_table: populate tunnel tuple regardless of inner protocol
      net: netfilter: add encap_proto to flow_offload_tunnel
      net: netfilter: nf_flow_table: refactor MTU check for tunnel offload
      net: netfilter: nf_flow_table: unify tunnel push for IPv4 and IPv6

 include/linux/netdevice.h             |   1 +
 include/net/netfilter/nf_flow_table.h |   1 +
 net/ipv4/ipip.c                       |   1 +
 net/ipv6/ip6_tunnel.c                 |   1 +
 net/netfilter/nf_flow_table_ip.c      | 201 ++++++++++++++++++++++------------
 net/netfilter/nf_flow_table_path.c    |   2 +
 6 files changed, 135 insertions(+), 72 deletions(-)
---
base-commit: 6ebcf5074cff0402730c6981d2397139fee6322d
change-id: 20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-5635fae03f3e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

