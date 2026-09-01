Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080F47F2D5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280361; cv=none; b=uWvblLthi+lPYTT/gft5aTwnoaln3+vFUt17wKcKWL/99e69LHdfQz0Hfn9N/jqEerP9W2yju/fatV44PucQXHBiW6sxnOJJKENUxBbQJ+jnwJCwDv/4DkwXEakxSbjSuRlPAd0MORIBFKIZQ7w112nB13VSnB8HuOe27oEj/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280361; c=relaxed/simple;
	bh=2dwZqLAyhY/4Vfm9IVVL6KRgYtolqzmaN8lua+AT/Ho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HMy12vA24XVgfnElXPk7XC1rv9/JHWvhOpeh6rFHN6UWiQmAfxSyV2obLX7eT86I4r6BsXNm7NokKTyHrYLv1WyqVGxbNDki0Wy0UlaRvNXPyXoqpvHSUaxfbahTK8eqzvGqzf1lFlLnitXQD+Ae/jCXMpdBLeUY1R5tFEHqVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cU3Cj8Aj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tj2ERVoV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cU3Cj8Aj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tj2ERVoV"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E960r2912189
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 16:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RWmplTuZP4ejGGGca10U+y
	p/avXJxOthQiyPce9Gzso=; b=cU3Cj8Aj5NA9y2Npk/8BOX7uqMesLcYQ52QMek
	vKOYkSX1cRfh/QDmuWMCdTzrE9KRdPPvJmkDGvVSB5TTOYAXVHhRRNLO7e5GpXS6
	wZ53/pXPT594h9J2lAn1v/djrQ/r3cz5xk33Xidf2q0CkDsChTU+tAg3tbAgEj9k
	FriXdXWnlmndPs4lMWyLdNuRa9q81w4gn9ShwuqXUicsAViFPhMS4CEyyYn5snBs
	XaxJ927nw7eCrf8IF7v6I7Sl/6DeYr9VngW53/9Fsd9EgAWKVB0FC7/vj4htgu/S
	2oj99Y58rLZNyH1+AooacEzhfG+zTro6iM5tR9C4xNM6clZg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7r3g61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 16:32:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e87478402so1736796d6.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788280358; x=1788885158; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RWmplTuZP4ejGGGca10U+yp/avXJxOthQiyPce9Gzso=;
        b=Tj2ERVoVNLlyWjnOJITTegKpAglrap25q4cXHwSZDMSDEx1i4xO0fjb21VTMf0Wp3V
         O2uvlkFg3pyq7/32mr4Im4Bu+TwQAf2dPFZlJEcZznHf1U4nk9Z5a4EuquUjYaHvYS5s
         A4kVW/ityE4qLHVpj5gbI+glLvGA/7DE3Duxc2KjLhUmBdf0cKYLjKicjQslBOXdFJHn
         3q6FFLULb8fIrk5m5HbdlEX8hOtP8PYmNRomp8PCn/G2kYD0xeAjorPC8SDHZ+AwuCSH
         gL7PIiPLdP7Zm/RJNqyOUjK2Cj1No1FzaoRxjQI2zuYAdWFpduyaZKsZ2Dj7U/woYG3g
         t74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280358; x=1788885158;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RWmplTuZP4ejGGGca10U+yp/avXJxOthQiyPce9Gzso=;
        b=cz1KFFEe0YAbv7IkSmQaRP+FlK/KPx/JD6+3sDr+xBpYVg4TS4QIkCNqis5ykzHBUy
         J6+66ExFWBvpBiUA2iMpKsR+P7SF/TQTi8Qyf8mXXYFDDxdrFYVvQDbYCYEYfbdNaOML
         Q+/S9W8U5jKqBmCmuepc4uFjGoSGWyORMTB223qpF5bJRZXwKUzGuqXUi7dunvO4YYrD
         rXOxKZ3JzuRtEMvMib6YxaUNo/qbKdtBb7i8QaDjWMUb8xaojrXsOQ5hBM8V9iv+w/6X
         bK0GWNq4x4z12iBQbHC9isQAnLGxyq/0rVrCHJi4NZxPI+7mcx1KY6Jo1YFAl1XTCD5o
         XDag==
X-Forwarded-Encrypted: i=1; AHgh+RowtY1kLBapyj0P7emS2YRXfcgdGYtxQMIh31GqD/1sPC0jps1JxyOK33+UxXFBEf8NfLkA/Lo=@vger.kernel.org
X-Gm-Message-State: AFuF++nRf6LCwB88PEdukqGRsUSqTlC1h8rwBSigkR3QPXHDz5atUT97
	P8vvzf0yXBA84ZkO2J4WbRc0fYDiGMvOM3LCHw7Kvg9PPcp0GQqVX71Jatz8845TCU2ymF1SuTb
	dZMyaz+o5Gnvt6oIyf70XeOeBHXNtQ/UGw6CFKLsLpPyrdbw0EYOBFLRtRSM=
X-Gm-Gg: AR+sD11UtEzJWiswnCbqO78NE4+QEElC+lJQp/8eF9ZOhGRJwGJLbT41hdXDRznQvai
	bXe7pbkf/fic/vnR9PczEf/M/kHITkd9Yyug4oFXhBLv5I5O7t/YDa4l24VweOCOnrOwpoJ9r5S
	s9Ebni3kTWyecN4JOYYQCkKN/elg3ql9DYIfu6mOFOORV7DfRwhawS38uwljOOobUfDV8NZxQSq
	UD8uc2PZ2xiEcRMjahryLtOqMpL4NvMNGYBywNenyggVRM/m2bxCp6zM2QB4z9dtFJfrKvc879+
	HDbuog4giveUzKSJHVtyspidht1yvV1SZg/RTjMjNFSsMAkWLw22NMGoJ7bItSjp0Wk4F2inp9j
	CFowuNplSYtSUIw==
X-Received: by 2002:a05:620a:19a8:b0:939:f89:3688 with SMTP id af79cd13be357-9391397dc88mr3819559285a.42.1788280358282;
        Tue, 01 Sep 2026 09:32:38 -0700 (PDT)
X-Received: by 2002:a05:620a:19a8:b0:939:f89:3688 with SMTP id af79cd13be357-9391397dc88mr3819549285a.42.1788280357634;
        Tue, 01 Sep 2026 09:32:37 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm793114285e9.2.2026.09.01.09.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:32:36 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH nf-next 0/6] net: netfilter: preliminary support for IPv4
 over IPv6 and SIT flowtable offload
Date: Tue, 01 Sep 2026 18:32:15 +0200
Message-Id: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QrCMAwAf2Xk2UC3soL+ivgQa6KBmpW2uMnYv
 1t8PA7udqhclCtchh0Kf7TqYh3G0wDxRfZk1EdnmNwU3NmNaIKSlrXRPTHWFSlGTqg5aMaqDXP
 hpG81Kl+cg5+F2HnxDL3Ynej2v12hh4y3Brfj+AHU6v1BhgAAAA==
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
X-Authority-Analysis: v=2.4 cv=beZbluPB c=1 sm=1 tr=0 ts=6a96fe27 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hjUsVgM4bzNdy_QoUQ0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfX2T7kngIAVuSp
 09pshn547N9jEpNSmKLXWX+tmhelVtMzvSrTQ4RzKowyk6GC7iNXTcDXGCNUjwu+ePw18vNlPhB
 8bDzbc1lzBcuS7amQ+g5xMKLWak7VMFmRbxcPiDy84oco/rskyb6mEmDuzNvKWyqzRy0nxEbmVe
 AVhU5OKX1IMvfTemMavKQozzc6dlsVeFSaNmF6VnDkiphQnjC5WAQpYBpRsEggk5jOsRkWY6+xR
 tMB+EN7hrFZ8G9+b76JgRKDAyCmeRPIxVz9twTZmbIUbHctXellWctpaI5t4r7QsvgUGesWSpeu
 lXV3wW3svN2eAAm/kaKbkvyYsUQzWA59WRDej3bGA8zC34+uVUlXQ1y1XRyFRrB/rjRlXVQWGYJ
 DiokOS2qcCxXRhoTMWMf73Ep0gVIkOBSLpvLls3UyUyRVTSYc2D3kNR7E1OGVzmAYRpRSv0QlBD
 SRsenWdajyQyZyFKKug==
X-Proofpoint-GUID: gGuX6AktcdR7zukQdaaI8VMPFgt-Z4p2
X-Proofpoint-ORIG-GUID: gGuX6AktcdR7zukQdaaI8VMPFgt-Z4p2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfXzLyxaSlBe0JK
 ctmeJUuINx05nGXFYKIKDKwoHqW5vEusodRjNlSBHvlHjHP60ds3vTH8v+x8Bmk0XwfMLq0S8gK
 vVWQZ0DPkmbHGi2dWRasZNKkwvycgTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010146

Introduce some preliminary changes needed to support flowtable offload
for IPv4 over IPv6 and SIT traffic.

---
Lorenzo Bianconi (6):
      net: netfilter: nf_flow_table: recognize IPv4/IPv6 in tunnel proto matching
      net: netfilter: nf_flow_table: set inner protocol when popping tunnel header
      net: netfilter: nf_flow_table: populate tunnel tuple regardless of inner protocol
      net: netfilter: nf_flow_table: refactor MTU check for tunnel offload
      net: netfilter: add encap_proto to flow_offload_tunnel
      net: netfilter: nf_flow_table: unify tunnel push for IPv4 and IPv6

 include/linux/netdevice.h             |   1 +
 include/net/netfilter/nf_flow_table.h |   1 +
 net/ipv4/ipip.c                       |   1 +
 net/ipv6/ip6_tunnel.c                 |   1 +
 net/netfilter/nf_flow_table_ip.c      | 211 +++++++++++++++++++++-------------
 net/netfilter/nf_flow_table_path.c    |   2 +
 6 files changed, 139 insertions(+), 78 deletions(-)
---
base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
change-id: 20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-5635fae03f3e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

