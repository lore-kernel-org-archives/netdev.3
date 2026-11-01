Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559738;
	b=0Pj9LbMa+Eo+fvsuCXUOmYBLTrzUhiwOkLMKtT5pYy3QXfJKnHaOyylyFM0s+dmCmTsK
	 F8bQTmi6ma2sL4RrlYGCmeZtC4Qgrg1O63ysTWqEV3taZKPuVEb/I35pCyeXWXZVC7alq
	 XBZsv5wKjTbFeMxgy3fcxe2DP+nl5MtkvV3wTYCeZFdfAfkREG1qGCW8HfCiHOErgtX4j
	 6xtUUjLHLGhfTpsZyhJ7o8qhkehLBEljp8YBlpZHlcTtQFyIWCixijxYTkI2ojXX1/aKO
	 R96r0UZ1Bb+xPd0dmVVw/5jwEYTUugIK3QX3L25Hse/xWprzdqtXdYX2idNIWuxU70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559738;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mZslQFVUM++BBw+BwrpJpXtc4dPPTdLJDng3B+Sldh8=;
	b=S0wnwRddTSzDy3ON/dj1A1ZXcf5cbjgZqqKv2rkMLf8w+yYImegT5yYHwmNIQlQNDrPF
	 BXolulNraYo17qM1LcaK4AyHKW0jbm7MBojTR/ael8BYnV0jVSnvujPA7UnbO+OdHY/SX
	 os4KilSreIFu9feL+KWXYcYNf/o9JboNsl5u51t6/G8dVauXFJTGQKt8/FK16SuQFBgBX
	 sKFGHgL2maoW3Xw+FuOf4+/fhLO97bB6UQosRrgvHKu0u+D7GWfJl407ggtMrSrusvTV+
	 Cw904TTNLnLlzglsrkErejCUYYJJ5sMUxaLNrMQDat4f0abIjErDVL9Q9lBSvx9LAGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J66abi7e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NlThsw+t;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F9606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA1F9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J66abi7e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NlThsw+t
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HQQnY479362
	for <netdev@vger.kernel.org>; Sun, 1 Nov 2026 19:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mZslQFVUM++BBw+BwrpJpX
	tc4dPPTdLJDng3B+Sldh8=; b=J66abi7eifh/tm4V4JGcRluuWF7pHayao9EUFL
	n9RYqHG8e7I2VgbDaMpHc975iPoHvcNcpWaKmY+AmS2lxnrftmQLloV6XpllNcyG
	kB54B8P5wyWBrVwWP4wC6lGR81d24Mjp8vGW6QdvruKYgIf7mq+3BC/kdMUOttkY
	rkP1DndcqGwwyBG//jsUQyO4BjW8V7c62FPH0s6uCrzCoGrtTP4jJ0jKkUSZ9AYF
	b3ixboyQ0CEEu2BntPRyjLQfwCb4dKUzUlDclxCX0LqaOEX67/JI1Pf2lYYKUYhL
	2ySPMR9BFq4gs40uf37CnnLKWwTvZUdr4hxlpkePCJd+Hxmg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m9btqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:02:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2c0e6653so416063185a.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559736; x=1794164536; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mZslQFVUM++BBw+BwrpJpXtc4dPPTdLJDng3B+Sldh8=;
        b=NlThsw+t9/hOEW2wJSzK6RKTz4elMDU4aOZ9EaqkgVJ7mEzHl+EDV7LRwu+uE4WdJO
         +zx1wWCRKITG1RyqY2g8hW8HtoZLvj6nTA3cHiSYNs5tGyC2Z3uVB1s45ShWxfgZBur/
         fpGozBvX//rN1VVez2xaw6xzbeuGzKwptH529MkcMu8vNK+GahgTty2xBw/rtdgv7M3F
         Otu0H5wTZYcRO/5u+H5UZl4sPA08hvDPQwXyK6vB1hgGAsrINEVrw9F9rJLKoL8JOhAS
         0W49W6EEEhNVtIENueDH1oTxb3ZBszXACtfAsVFzEKd9DhZ637osGU2kjwROnIHBSrkN
         L0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559736; x=1794164536;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mZslQFVUM++BBw+BwrpJpXtc4dPPTdLJDng3B+Sldh8=;
        b=1nykhWvkYQkq9BR0Q7x31/tZ6QSZQMk/ZRN2f7EM2ntYtheL2CKQdwNcC687SAg90/
         ynhdV9WUqM2yEHp9LGl2XZ78WfjNarZB28squSGkkOXZSoaI0P0vej4iC/NYGxb7jSK4
         mIyvF+VqOCYZ4vXdmSRe4aLJzJJhi0vMWRDZtKQzInArTUKM97NwxoRIaJNBPPqoAGFu
         so1va8fvFOOiQbkPD11h99/jr9WCRxyHDIbICHaLF77zO3rFGiSpFUPXTPt5vL1E2pVX
         HvrA6ubrPizAcCcG3EayGZLS2zJlVuBSdPyAHXa0UFkQTAqmFSw134LFhgw1UNdw7+Cc
         2J2w==
X-Forwarded-Encrypted: i=1; AKwUvByiBNm3dzOHo4D03gzOleNUgaQKlNbuIhGSce8vgvlud87d9OmobOOqNHOOwHBOFm3AzWoiKlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYImntOw7OHDpqUrSYFMhfC6wRicxBWXuzX6bR2hVQfdNlUCRnz4
	MppuxlKJOQ4poFPUvURgrsninH5ggb6kaNDAxxi+vRWvZRSR2cBL6tZ2LIQ8k4Eaz+VveHIock8
	ogL4vAAhq0u8wJ6ywpF7CoQU8ghFaMBgH6Hjh7F64kkXn8UE9q/7+/eUzBwU=
X-Gm-Gg: AYBFou0sdliLrSO1E70pQOFg4imma7+hL2XhaknETPljZWQ6fcJPuWEXY+Vu2cHNWK3
	m7SN8a5RfgmLctUwtm3fZrpdff5PIeZuH7aeR2QRp2eqlPfuqeX/CFNcDIeMvBE90clw8TEUW6Z
	te8RuPRIN41o0cgVRzx3RCqDNqi01ZzBxidgK9qYwZS6klAhYEeOYcbmBQD3yBvj461OloR9D04
	i7ley7tvtQoe+OYN3WlQIARSDFgMCVsEGAuStq62thq792MXReCyS6Zquzq7awclgLKMr+eWJPa
	dug1+q29RVgTvqUZ2sd45O79iRM9MDk2Ql5BjtX1xSq9kcqJt5+ql4uvgF8Lj7dvJvc9JYHm46T
	HkYtFVwWioaNC/Rnx49nYs0dh6pE80ifNgC66zlsiYQc1ZmYQWtv9balTSqci7yk=
X-Received: by 2002:a05:620a:45a2:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-944217b0af2mr1362240085a.53.1793559735818;
        Sun, 01 Nov 2026 11:02:15 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:93c:c96c:a5a8 with SMTP id af79cd13be357-944217b0af2mr1362232285a.53.1793559735153;
        Sun, 01 Nov 2026 11:02:15 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm327961625e9.11.2026.11.01.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:02:14 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH nf-next v2 0/8] Add IPv4 over IPv6 and SIT flowtable SW
 acceleration
Date: Sun, 01 Nov 2026 20:01:54 +0100
Message-Id: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZC2KAVX3sOwKHUqk1SKFAFDu
 LsNJ3Dzk5eXvL9BpJEpwjXbYKSZI4c+gTplYDvTPwn5kRiUUKUUqkbnwzKZ1hPGBY215JGHkge
 MPKErirrQWlWVIEiJYSTH65G/Q++wp3WCJomO4xTG73E7y0P/9zBLFFgaqe3l7GrX6luIMX9/j
 Lfh9crTQLPv+w8nEdmf2AAAAA==
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
X-Proofpoint-ORIG-GUID: OYG-FxHWaBsCLL_lCQ-Oc7lKCqNFlyor
X-Proofpoint-GUID: OYG-FxHWaBsCLL_lCQ-Oc7lKCqNFlyor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX5d0iFXJfIOfs
 I3oAVihoj23XhjqJraii7j6CVVEhRkRzFLDnRyZMMbIC/xksfJL6JyTM7DoTx9OvOTxAtNyw73a
 nXQXHyTA2SdZGqQs7uaUnTClSCxY+eOmuND10yeu+X5nrlHWp1Ia6P1HIhW+JX8e3n1nG/IUeHz
 Krj7VQxdKNPauxN4iY1t0cERKlmDw78y0F54bPbd9VWKsolCFRFyevapBUXYW9XRQPB8grsJoiM
 R9JUIVmY3LiNYj4c03vh72PbowFYXTqzVK/swEoBmpB+aDGPpnoPL8hrF5oqYbYgRaSTa+mXWRy
 bAy44irWxktce3uysx9COciUjCF4fd7+vq6Fh5W89X6/8yGrfFvqVL9WWtLM9g2utoeH1+8wnEk
 C+L5ZJYFUMi5d0VBJrAsjClN9YMpOtNJPvGgw7H9fVeRwZnAKifsgAHAhLGOwMv9tkqmsvSQEYG
 dDDdVjPntwq3AW1tgNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX7/LmDeS7P4/A
 mKQB1hw4FLw4PYYxlTNsfgdHE6GdOSF1I/2uESPtv0cJv6M2aWEno2Yf1xPT8EmlUPQUfI2eF6s
 Z3ng+Rzyh1KxH0/AfBalp6S0RJwCpQg=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae78cb8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q9g148jr9wMc7ZL12-MA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

Similar to IPIP and IP6I6 tunnels, introduce sw acceleration for IPv4 over
IPv6 and SIT tunnels in the netfilter flowtable infrastructure.

---
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
 net/ipv6/sit.c                                     |  72 +++++++++++
 net/netfilter/nf_flow_table_core.c                 |  18 ++-
 net/netfilter/nf_flow_table_ip.c                   | 137 ++++++++++++++++-----
 tools/testing/selftests/net/netfilter/config       |   1 +
 .../selftests/net/netfilter/nft_flowtable.sh       |  86 ++++++++++++-
 6 files changed, 290 insertions(+), 43 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261029-flowtable-sw-accel-ip6ip-sit-f3393772880e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

