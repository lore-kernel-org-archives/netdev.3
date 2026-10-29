Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280937;
	b=VguG17gGruz8x42NOdw7rtIFRJiqCXN2jjZiUX6zR8R9Q2Y4AhHTAyA3Q8zLjW8b/dFa
	 1OsljYbAzVK+fLDKFfrK7M3S/xheqdJN0FGpEfq5/PEAVY3fDRlrm3Z8ZGIzgq7Wp5U1K
	 ZYV06tpM+7GZxGZpKf7UiIKS8XUZa7KBBpWXOA2DDHE3nt5kBMd0LrWzF/E3c9z8XHRe1
	 0KTfcUG61bIJnqtLFbSidF+kzMXlTXjq1iaiB1ck17l19hKQZYS9UuwDRmnDuwN0iPcCa
	 GQryrhxsueuaTpQkmdqV5PmWQs2CopX0q+yBua7/x8HezBcMg5PHGX5LQgfse134vSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280937;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7+/RPMRcApb38IJk84iUeQLEGtR8QdU2HEBTyYQ+mr0=;
	b=tiIy7p7s+AYS7p+ibigbYwpNlaHqGH7vWqZrsqutqUvN8LuXFEIxMsa1lMO1dWZrVEKm
	 is7ZjwJU+L+eGE6j4cEm/1g0qRACXEpPZY6kBfotae7iLwfr1MfIQ7ThB/kE896OIxkP8
	 y6TJE+Oxu6dlQ9Q1KICDmi+KDPDbAMefSjShpfBJvkzjhoHikXl0IR0odrQHxJHYG0s0Y
	 UVFkFZOQAIocG4lsbGQ5zSo7AYC1gaMV3GkRMH5mQNYKoH1ggl90PQm4QUyURTusm84yr
	 P8Fa1OZTYZVt7qFZDa+42PMr5aFQeSoDSQshk5azq4NshWKTGrTkLC0GX4V5xPSU6xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nSQI+uZS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HVsCxP3j;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5875606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5875606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nSQI+uZS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HVsCxP3j
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdvVI1147371
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7+/RPMRcApb38IJk84iUeQ
	LEGtR8QdU2HEBTyYQ+mr0=; b=nSQI+uZSXb+B5WRvbBvSprvLSefhchq5n0x3iq
	CYtCxEWN7OeLdJlBO+8OlvV5wwJmb8Z65c18V7wgfkw86lJ9VpiZttZZKX0ks7IY
	3Ey06xL2rxIU4FHvqPsvJVj1scze+8T2N9FKCJuNfZoUGMwRm3xoBMbXkQS4Yeda
	ogL25YwdLZBaubZuXA38XkI+UXyeJfQA6CLhu/UHZK38/NlpEOGmEJRoUAnZEQAU
	On3ZnXIDFNVn0fpPhQTSSGJvwXXAUb2N6+XUXTvraCozY0Hvi1z/Bq41PS7UsPAi
	YmSGMr7wwFNoKA99GIsyORqWREk8ShFz15BSF8P7h0gKZCHw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q8pgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:35 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c1a2c3b118so1793812137.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280935; x=1793885735; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7+/RPMRcApb38IJk84iUeQLEGtR8QdU2HEBTyYQ+mr0=;
        b=HVsCxP3j54es+6UhB2RAe9fZsDMdQEjfTEpoSY7T1n0m2thl9Lpyrkp/yRl5CS81QL
         dQNQ8bwTlfiuUeHhrGdqbG8/SxBs34g5L+0cpFtaC4kp6Wc6eKPewMWl/trqRzLSrbII
         HAO1LPVylenA2jh0q+2r1GmlXkoGsCrDenwoQd8ygwfqbCJb6bCOMCX1BG5xImLRIZTw
         p/gM7IYWmHRMoHB4tG+yU5skTOzJvHcNrAPpfq/R8wakr6izNauaVc3ZsjFLoRMI0+vU
         WUsapzqNS+YNxRwmWxWZha7T39xj1yyH/Iv0Kz+mmweXjeFM/5c4I2SsM/kikmIlUpHF
         +/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280935; x=1793885735;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7+/RPMRcApb38IJk84iUeQLEGtR8QdU2HEBTyYQ+mr0=;
        b=YR0RXIq+zwZH/WWWj7exdtqtqAWjsbG8BrSgnGI2VD/t5Hnj5B1BGOgW59eoFWXHrR
         D0z2FlKRF6ruSlgTxigHWCqUJ1H3JomoR9SNrd1dK9LaCBTd4Yq/dEkOe5Y3wl+mNvyA
         aT9AHEYE+TXy6ENcZqpNuLwe2n40hbAkWS1LYVfd5My86DZKRCCYKG/OzfbQf09y0wsW
         jeljDVpODdPjhQ2o/XQD7moquEhhGipHZrkIoiPmjjvDHHd7AvX4CxRJN8qdUyTSibDL
         Jy6WYgiBz+IVJgv4kqSPxZZ6aomQm0TR5ILSzZFdmacSnTnnPyUvMP9xAuHIMwytb44d
         vG5g==
X-Forwarded-Encrypted: i=1; AKwUvBxaY9Vm+cb1Mo9CCdFnzNWGaNejuJA2H2rCH8eGD/BSZPmKo8dFDQUa4aq/qQMVwX7CXbANZCw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK93Zq3LHyXrI+ccBPOmR6Qu6q8uTcOwkKL0YwunpKm6gEBnqq7
	IdCt47agxed++i2dqFZNU/xPeWjTyfVTQoysXUf5r+WjLKhJo0Wy0yg8ktIoOI2MhiK2B8ROnvx
	Bh3cRIEjmXm/CtR3RkJ9jw0hfynvwT7YqHPoU2ifH5IaCXWsUa4pHegowzIc=
X-Gm-Gg: AYBFou0kpX1pJmYzfO1L7PxF7zUpsegRTVurRGJ+9hPLK7O0UMRYOxJ2sQFqdi2iroY
	HXXn/888+dz0eiHYc1XBQecWlbJUM+/lZ/xV2WfAZu2m8ZnHna09DBIJuSmlFT53XTD7ucyPd7u
	BAPKF8vh7MJMzK79w2Qn5ipCnj/PrNtwq1+UcLqw3HYNZjNQGwQ1FLRIU0s+oDl0sssZkWC4wLe
	rJRZAUpgMDoLnOZPtSsPlXH2Ooyf3FSCGEhg6APH2s6P3iwtLloaAO1c32tbv0SsOZVj/1Phfcg
	4tW/tA1uocyA6XvBIr1I1vHamiGOfCXx+1E5CDH9Tnc/zA0u2+uBTpYfXBRbI5Fvst9lpB3YZIw
	VEdfv5r9WJf2srsNqdeyXJ1htSM9HortAwfnZn6Z6ugCmRzOlatpKPFXaW+Zwf/xVgsbWtzS695
	oRvJ+N4S+y6L6r34lg17K21g==
X-Received: by 2002:a05:6102:54ac:b0:7c3:39a3:f65c with SMTP id ada2fe7eead31-7d03a294bd7mr2751744137.1.1793280934782;
        Thu, 29 Oct 2026 06:35:34 -0700 (PDT)
X-Received: by 2002:a05:6102:54ac:b0:7c3:39a3:f65c with SMTP id ada2fe7eead31-7d03a294bd7mr2751724137.1.1793280934202;
        Thu, 29 Oct 2026 06:35:34 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece14a1sm35815214f8f.57.2026.10.29.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:32 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH nf-next 0/8] Add IPv4 over IPv6 and SIT flowtable SW
 acceleration
Date: Thu, 29 Oct 2026 14:35:11 +0100
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-0-6a17c54f9fb7@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MzQqEIBAA4FeJOe+AKfT3KrEHc8caEBNHKojeP
 dnjd/luEMpMAlNzQ6aDhfdY0X4acJuNKyH/qkEr3bVKj+jDfha7BEI50TpHATl1nFC4oDdmNH2
 vh0ER1CJl8nz9+xmix0hXge/zvCrhjVl3AAAA
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX2Zr4E+Ya5XFG
 Zkovmq/2wkuvKM9373hMvWc8Zen2hu778UhiS1tyQyisS3eeslzp0Z9jucKgW9Wz1y8Xe4x5W3J
 lqvKtAXUChZJVEqp5Vb7Ky1f4SPtT9w=
X-Proofpoint-ORIG-GUID: DMnwaeTt9RbfwhAv4uqmXDfyiaLL072q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX2B1jiWj60vuZ
 OQD2WazrMw9E4PbufrgpxQKyrG/DZmQ4qq2lCNp7TilGx9Vah1ctHKKJml4ilArqNXZKiUDflM+
 BMQ0aXAq27iIbkfid5tSdltF88y24SJ72dt/mRULIZ8HrLrofnC2e84bJVOFaAos8NTmeSUUZ67
 FoWYm4y9GWKXbqQa19KWTokNb1lYo0UkpyrhckzMpv3p2gq1zBbFzBXISte5OU3+VtimWcl7uO8
 FSpdsClXU4ZLmH67TUPs8TADFvK+63gP+aTSnYU8GWCkAAv4oGDEDgNoxtvKtO5P3gW2NnJg2z+
 Kw1BoHNgoSp9RL/8NWfPkkN+J970E8idfidAqZoaLF+O1+KU6S7oDUHxJFPOGIN+4q+xdzZ3yQi
 SdCxj4glMI99jycy93Avyn0hhyDbAAw3Mcx8s0TUO0X2jeNikakNzzHJvhZqDFx/Y9Lo8r7IhiQ
 9mTZKZxgSNOPNO3kJlg==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae34ba7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=q9g148jr9wMc7ZL12-MA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: DMnwaeTt9RbfwhAv4uqmXDfyiaLL072q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053

Similar to IPIP and IP6I6 tunnels, introduce sw acceleration for IPv4 over
IPv6 and SIT tunnels in the netfilter flowtable infrastructure.

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

 net/ipv6/ip6_tunnel.c                              |  11 +-
 net/ipv6/sit.c                                     |  59 +++++++++
 net/netfilter/nf_flow_table_core.c                 |  18 ++-
 net/netfilter/nf_flow_table_ip.c                   | 133 ++++++++++++++++-----
 tools/testing/selftests/net/netfilter/config       |   1 +
 .../selftests/net/netfilter/nft_flowtable.sh       |  86 ++++++++++++-
 6 files changed, 269 insertions(+), 39 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261029-flowtable-sw-accel-ip6ip-sit-f3393772880e

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

