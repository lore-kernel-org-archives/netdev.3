Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714475;
	b=IOLwLxNUN/b1hxRksCAA1amTPGjEjDgzrEoSEfJ7LUYoJrUQS+34pBpy1aQQ73s9d1Nm
	 8KoPDiGyEw5JcylI2h3dDGv/yzW+w6ZF1HAivBUbdlUn/oBk0Pcl/O80mrgxJPVGXhh8Q
	 qlioNzHoJRykQextwEuBUVgNzE//ABNgyjpGOX6bpBGhQhuI1PP5neP9qzuFj7g6U43jb
	 sEueRePydeW+xAo0cHQxOz8djcNugCB4ZnG/s9HE9w+OnHNYCRS6KAHp6XLSnZ21tOaR6
	 /Vr7BVq8sKZz1cIbBRXC2MEX3miwknzeTmfV6uey7chNgxrIHvlqNLqEM86kDf47v/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714475;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=85RUdm5fHz/EURSg1WKsbBmBBP/Gz+V5vxANV+AddtQ=;
	b=lZgTpFuld2BXjBvzFKEgUD6JqGyiyCMlEfAyIUyitm6zI6XCvvnqaF8FS0/SZYZjf8FI
	 OtbzBDBnQCGtha5wsvNhRUrU+bFuMgyDiCLjfR+zGbN2HWhWXDQmQxGcxDIg/U7iMTrAG
	 XsFYtRs18p6eH52wmIL5JiUkg1vEgpRo/qjCv4fI9xkaOgyLTIVnKWMD+5hdThBb50wr3
	 UyuNImcG5SUsingyI6YTqtKiWxM/jeCjxepBY9z+OV79GU4DDdXE//iSKsl/AJY9sGYWD
	 baAdZeDCE3XKWGwJMZ7q5PFVCdZdVWNFtSq8sBDIdzGBvuIFbU6qkUFliNgClKtVHmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TmR6kNxl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OI2tD6m9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED0606D80D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9ED0606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TmR6kNxl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OI2tD6m9
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZ9vB2651032
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=85RUdm5fHz/EURSg1WKsbB
	mBBP/Gz+V5vxANV+AddtQ=; b=TmR6kNxluCMK9SILJrHgMoURPFDlpNxyeeXSX0
	QDvZx8OYo7Ht7FLEIva7VvCZueXQuVvJTAmkYd3RUChuTRwb9+3kHR8AU8eSaqGp
	Z73xNNrh5xZWPV+ZPIvtw6zPlWxpN2TK1a6VVVreia2i4CbX4DCfMJ6s5dBLNNFK
	0KCYPtQ5UK8tL3Y3B83zm7IzFXAmqvIeICkRHnMI9NcFnXFJUGlqZYWA2jNRxwlU
	1MhH/ofWaDA/Om2EJG3/io2ttgQpjbhNzPozMgLbfRQm5ZUWYfpgWUAl6ufCCOCU
	TyF83gf61QJB6kZh9I/3z6C4M9IA/Xvu7mLBMsdhO0nVwXrQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r42h7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:01:09 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eac2cf3905so527347e0c.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793714469; x=1794319269; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=85RUdm5fHz/EURSg1WKsbBmBBP/Gz+V5vxANV+AddtQ=;
        b=OI2tD6m9I3meEbxNzZkIhUGUCeZqF+fTI9KXPLTxWfD/dEv+24YVTua8SS46fllqlF
         KPlJ+5pL/3eexADRxVO24hcHpdxUsr70XPSacePODYycXoXYmJv5p12Cnz1GC4GdcuPJ
         58lt/jcf8yoBBuc4qxz9Bq08uhjx06wjTbbaAk/YnhXre28hr9gJ2c4w9lIG0ZwaA/dd
         T9/k3T+CmC+NAZTHChkvT96Wr1V5dKKJbtpp/yoBLZdHY0F5t0yPmSP8tY7Bm0Kbk36e
         C32d5weOTixOfHIPxXNNalEvMf29O2xRbog5sqaebn+nbSsV3q8I4dyRIZMo7I1X07M9
         jUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714469; x=1794319269;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=85RUdm5fHz/EURSg1WKsbBmBBP/Gz+V5vxANV+AddtQ=;
        b=MpzeCjIQ12T+5D4v5pWB53zSYahPvliV64CuQX3/LGJWg+8coXSYaKkABisQqXQ0uM
         cO7gwLm00OZTXJMTfeniHUAZbc02HcB0Q3R6Fr/5TWmoZBzNHpSyOWvnhAcBEqR+0rK/
         d9XfG83Y0DxWXc7+DwFv7aWq2xr0mhOurdVc11rT3iDq1fpD2pg/f9ZEfAejCYAbp7MF
         yh+0WeGhNKxoHuDBebI4eTn6WUAaq65Fjw77AqFUxxMwPbdumtJbIeGgZKD9EcA4+MZC
         E3l3/RjEn5xx66uxjodlZQgkOqvFGT/E1tSbwTdp7ArXBreQWZ9cmTKZnQZEDNq6fYAb
         Bh7Q==
X-Forwarded-Encrypted: i=1; AKwUvBw1buFKNeyE1WR48wMfT0CKss0y9COpFDbCH39jRc4AVNXvSiMVclt/g3ON9ud6yitYStL3xoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FPWG+s/GodygpBf08WWbhSJdd8Xwn4C40ip+JN8LGC0x4WCOh
	uK29sHUlpDU9mMAepzDDcxPya+d4ieeb/TjcwElzHgE3vbMI3PCJRVeT09ZcGd19NARkawUlluj
	7Sbi1tc34hskTi501dB7zPZs/pFuJkX6fXdC7jEVhcA8LYHPeeBHY7t7fsro=
X-Gm-Gg: AYBFou1h08ASDPYY0XDJPXTK+n2/0DMb2K2uxGq5OHzvpMVF5NwVPsoo2uw5xAiwwFa
	EAw2u62GlZ1MwRj6nn8RcnLR0G2jUiUB1kfJQ2I8stSBa9ODt4R38t0u7oVTWi/J9vSAUKRMdJQ
	XDMMl31szZeQ8vsTi2lZD7Ln+ggVnUQERjlLKTuwse++4javiZKc9XyAXPVdT/lcblFMSTeejgP
	WVgtqIAemCmfz4zDVgbx1uwfX027c5ToqHdOcR9k0dIMeAUdunXm94Z6J5+drFa4wxETBmpN9Gx
	m6l+jCVTYTgXUw7ogJ8+1N6Ub/rmj3eK+1/MHyycL4mbZJ+m7DyMBPe9z2mSDappWXKpPnoyc7x
	MP1af6uYIn5nIi9Mw30CB8NkcXSfMXEj7Iq0TIfvMyU38V6wgRogkbkAmXI7k58A=
X-Received: by 2002:a05:6122:4b19:b0:5d6:7f46:b8dc with SMTP id 71dfb90a1353d-5ec68971952mr5502162e0c.21.1793714468275;
        Tue, 03 Nov 2026 06:01:08 -0800 (PST)
X-Received: by 2002:a05:6122:4b19:b0:5d6:7f46:b8dc with SMTP id 71dfb90a1353d-5ec68971952mr5502063e0c.21.1793714467380;
        Tue, 03 Nov 2026 06:01:07 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba4ac6sm26968839f8f.52.2026.11.03.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:05 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH nf-next v3 0/8] Add IPv4 over IPv6 and SIT flowtable SW
 acceleration
Date: Tue, 03 Nov 2026 15:00:41 +0100
Message-Id: <20261103-flowtable-sw-accel-ip6ip-sit-v3-0-60b5f063f1df@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NzQ6CMBAE4FchPbukLfLnyfcwHsq6lU2AIkXAE
 N7dhosXE71MMpnkm1V4Gpi8OEWrGGhiz64LJTlEAmvT3Qn4FrrQUmdK6hJs4+bRVA2Bn8EgUgP
 cZ9yD5xFskpRJnuuikCQC0Q9kedn5i+gsdLSM4hqGmv3ohtd+O6l9/u9hUiAhMyrH9GhLW+Vn5
 338eJoGXdvGIXZ/0h9TSfXD1MHEDHWh0VQpVl/Mbdve15XnjSwBAAA=
X-Change-ID: 20261029-flowtable-sw-accel-ip6ip-sit-f3393772880e
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfXwzmLZekQu9fl
 3SzNl2DrMINkKI1bIdm4QLXfTmAgn/lEhizd/Txa9I8d4/PLJM2+xMKbcKQITLm39MBwOxkjx0O
 +EZi3W4lkmkJfkhGo8/bBarNUXPO3XI=
X-Proofpoint-ORIG-GUID: o5J9sVGcoHddAP1rzjUJb8B7GjpzmVZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfXxUDrkkh07qkB
 CUMR8K32NkxJG/Kh7FvzXtPjLKd0CbpFCce6YT2rvCGK8cwN1AVa4zgs0BVd/9PB+Vd3821XFUT
 xNgQWrL3jsT3GCdQzJy0/GX2dc8xM0On/s0q6wblyaHUP2awmo0j4bV7PBQIccYg7ppqj80F+vn
 Xjr+CkRThjmtL4ms2ytMq8JT2PuCp5kA6o1c8SCw+ET2pNFluzFtlUBuK+0dlOEMHkk4w+rFFdh
 d3bnqcY/68XVUyl9XE/bT+7YGZHeiWsj+awtEHo9Yy09AxvmyZvFXIhY0GTBGjZEi+B0AHVrE3l
 RlWcF1bMiVdikF3g0NttIiEcQYhRhZj3QUhFBHlqAMwo6x76bp0jY6zyUfs6pKb9WIYFpXHelts
 Qr2n5q83XrrVoI3C1d+DXICJSpZrOQ==
X-Proofpoint-GUID: o5J9sVGcoHddAP1rzjUJb8B7GjpzmVZU
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9e925 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bI6sO-iELKRFtQfF1kgA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611030055

Similar to IPIP and IP6I6 tunnels, introduce sw acceleration for IPv4 over
IPv6 and SIT tunnels in the netfilter flowtable infrastructure.

---
Changes in v3:
- Fix FLOW_OFFLOAD_XMIT_XFRM for IPv6 in IPv6 and SIT tunnels.
- Link to v2: https://lore.kernel.org/r/20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com

Changes in v2:
- Fix skb dst configuration in nf_flow_queue_xmit{4,6}().
- Rely on tunnel->sit_parm pointer in ipip6_tunnel_fill_forward_path().
- Link to v1: https://lore.kernel.org/r/20261029-flowtable-sw-accel-ip6ip-sit-v1-0-6a17c54f9fb7@oss.qualcomm.com

---
Lorenzo Bianconi (8):
      net: netfilter: nf_flow_table: recognize IPv4/IPv6 in tunnel proto matching
      net: netfilter: nf_flow_table: refactor MTU check for tunnel offload
      net: ip6_tunnel: add IPv4 over IPv6 flowtable tunnel offload
      net: netfilter: nf_flow_table: use tunnel encap proto for route lookup
      net: netfilter: add IPv4 over IPv6 tunnel flowtable acceleration
      selftests: netfilter: nft_flowtable.sh: add IPv4 over IPv6 flowtable selftest
      net: netfilter: add SIT tunnel flowtable acceleration
      selftests: netfilter: nft_flowtable.sh: add SIT flowtable selftest

 net/ipv6/ip6_tunnel.c                              |  19 ++-
 net/ipv6/sit.c                                     |  72 ++++++++++
 net/netfilter/nf_flow_table_core.c                 |  18 ++-
 net/netfilter/nf_flow_table_ip.c                   | 157 +++++++++++++++++----
 tools/testing/selftests/net/netfilter/config       |   1 +
 .../selftests/net/netfilter/nft_flowtable.sh       |  86 ++++++++++-
 6 files changed, 310 insertions(+), 43 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261029-flowtable-sw-accel-ip6ip-sit-f3393772880e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

