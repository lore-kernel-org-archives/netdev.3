Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280949;
	b=remR17/cKgKCQzfkWcTlKIvGiSsomYhQrzC8/qyznAyYOU8/o3p7qOsw5cvscf6gZcxf
	 TPvYM2qaGp597cHtgfqPogt0Jjni1VaM/Uw0tn7a4/8SJDJpwsKnif7lqoKW1o1YHyYus
	 neOxDBZ8QdenFrbMa1pHB6TJClV47dDRgllvWSXEJe7efr1WCvzah9PGaiRRCrZ2rsCxT
	 jivjWE1lPiPTEzrX7jYuM20SdenGw1xY6mywqd0LDDtgdmVyI0/kNe0q6TMBmjf2VOs22
	 BhKrgoXiz9mGIhat08HhaPHDzotZ6MDQM4bgwrvQSOUws6veH/ZcCW/ASmfbFvy+YHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
	b=KqQULsbm3ial1vgpSG0k0KwuVpOjKPdQVtgu6coTmEci1Y4k4sQRjMP1SLgOqVYz9S1c
	 hLvikLVLDo21IkfDuGPUBitd6LuG1/PBMXABa3WgqfZpOqkw10IxRMbpGk5imKq9i8OY0
	 lBACKVtBf3niSUS94MAVKYISpr8hy0TsodajDhCUq4kkGkeqhb3gR8O+6FQEIm+Nr1PTw
	 r+dYfmMZWKdlvQNpPh0hT/gMx8QHQ84kCuPKJK10xaztw1J+EVlOio0+Pt9pR/baBVv4X
	 85rICK8NTr26twRs+3wuTdS6IO7L5uvlgdJzka9rwIbzjtYEhO56uAljluC+QA7Oc6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoqdTPxH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hr4Hcjth;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03991606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03991606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoqdTPxH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hr4Hcjth
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdwPX1147384
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=; b=FoqdTPxHHpMLBuHA
	ewO83g2k/YFW0Y1q1cbkUMEq21OQUJ//YhmvBFtr8kfuYnDWazB3x1gZWJ94T0Pz
	yUZ7pQ37mDeJOIdSURryJzQSsZVFzLt5QttIlJVpEEN4RaJRQxOEI5R1eEs9vlL7
	3/pebAhzcMbXf95bMNkBtBSqa/abdND8onrWC+gtvlrxCcasVqbUKPc8jk01D9OO
	QnbMZytp06Jn8+Sq+N+r+UxnphRGNLblH0eYnqXy49ZzP3nDa19kUu3YHz86bCLh
	7IdoG419IseT9/YhMO0YBARbdUH1FDHP/NHv9lv7lLdU6SfomC+EHn8eWGYMdSKK
	B/XTIQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q8pha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:48 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7c02e1df088so513355137.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280947; x=1793885747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
        b=hr4HcjthmJVKBY8bm/Qto0iyTNnkramsR95Xjsw1SJzWf6rU0M2LBdTECikOogbCvM
         DIqgiTu1Enc3urXA9zHnRtyCocChyehaRSuRSPaAaUuuPQyKHHCbG08r5jJLD+dvHNSC
         7gao/jEz+OxHGum6s0Gf7cdhzsy3G/wI8OS1k1xDHbcbprky4M5SEMqIU/clQpBcVlLx
         qz4XPlzLTVqZTP2wR96rm0CaR0vqTRRKFwnRsPO7rLVJ/cn2Vr46VLcGaCo9qe93NQW/
         0V73nlI5Jx+HFdz18fbdt5xWWBZ3GFnwogEslkOlwQR53oBPs0mo/XjvtgbCsWWj+eEY
         WIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280947; x=1793885747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
        b=FwXzB/C623Ou1ZByokiiw/jK9SpQnps6ggZLpq7Cz/g80CnTWXPdUrtBEPec1TX3UO
         9JMXMb9xlyxFb/6Un1guPiOdtS4DmGGFnjulF7t1QeYEdH7CngpanODRDgIQCxF4SpGQ
         1rygZHaqlsYNbewbqKC5rRvxT0mWPxHgppWldovG5vJ3IUk+Q+0xiZ1HyP7GsYSYFZ9d
         rwY99tlnryDm83kdx/C+t8bLwP9dSFm0vkx7a3dQ9z581M6gTT1efwvdZCIZ+ONqypp+
         l4NlspB570LFekf6t+XNAZbCqSBtV23A9aRBRPzhmSeg4Nlwky0oPZo042KjW8vgrR1v
         A5SQ==
X-Forwarded-Encrypted: i=1; AKwUvBw07SJ5X9lPRrsBzuXQYytTl53FbqcgSTlAy8XZ5p4AElqYbaswkXvgg7xaUFT9ZD5Advr9PFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpegzWCpiOJGh6z9RaV5zZ4hegJ1z+2ZBYg0PYct5VytxYXj2a
	W1CQhQe3QabSDCfnqdlzEOj1LgySYEx1kIkLmWntbszuV366RekoGikoAFRji5d65SRtqrnwWor
	deprLaIXqFcEQsgOIXzx0igHU/8JfvgT/DtXMxqTBKwKUsn099/7I+pcA7W0=
X-Gm-Gg: AYBFou1DX7FV7HsCpertXBXhhFJ5rIawuHpijNCRhytLz4R7I+sUMhWeDnRM5Hr3z75
	5V6buH+c423uY5uyAip19jclE6ypKlCCkYyPWMzda8Hj/v3eT0E0qI4LAUghEf6elfn4w+gZIfY
	pscJUESH4xEHVpd6z7f+R3ZPGGf77V/PtC+IcIItMKRFtlM4UZIVJNiN7boDSKeQDv3oRELbV/Y
	Nvwx6aCFAoyZh0jCu5G86+Ks/by/aTANoOS6zOtCvhoTcgncT7SBWsSZvFclw/62ZvTdiXsG0oX
	NXg2UQKIrbEU5LKp70lHdm9+0vuYgWWGBqu1Jj60i/2AI/9Xb4CHbB7W/fhoQpo6jhXuL0c1Vg1
	X38lqb8QOUKvmmwTQ3DambP8Qm15RhsfbVoJyfccO9si9zI9rJpuP/lLIey0XikF9fIGCDIj0l3
	2oFP3xDskIjTffJPJG28CLhQ==
X-Received: by 2002:a05:6102:6ce:b0:7cc:56a:58da with SMTP id ada2fe7eead31-7d03a5c76bdmr2580931137.23.1793280947102;
        Thu, 29 Oct 2026 06:35:47 -0700 (PDT)
X-Received: by 2002:a05:6102:6ce:b0:7cc:56a:58da with SMTP id ada2fe7eead31-7d03a5c76bdmr2580907137.23.1793280946541;
        Thu, 29 Oct 2026 06:35:46 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3418sm30851162f8f.41.2026.10.29.06.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:45 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:35:17 +0100
Subject: [PATCH nf-next 6/8] selftests: netfilter: nft_flowtable.sh: add
 IPv4 over IPv6 flowtable selftest
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
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-6-6a17c54f9fb7@oss.qualcomm.com>
References: <20261029-flowtable-sw-accel-ip6ip-sit-v1-0-6a17c54f9fb7@oss.qualcomm.com>
In-Reply-To: <20261029-flowtable-sw-accel-ip6ip-sit-v1-0-6a17c54f9fb7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX4oQHK0dG252B
 e8vpA2p4rR4SBsMCDMS1kz0VpDqKec62z0S6Ivz26L5aA+v05uY7jBMQHiNNzpq/R1gXHDmujxb
 ZWxC1P0KsV+X2Y0yRlW3hMEEPSdfpjQ=
X-Proofpoint-ORIG-GUID: AGcQ0vrI4qWqh2_nkMkl8JqCIkrT0tUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX8yISvKn6Mbgb
 Tcbj/XbYnkrsn816HiTRBzSf8nsY0096XITfAIXfpWdNgnKVGP3JEAi1QPQH6otnAYfngKSDJBV
 S9rN2136vwiP1NyJMQENDQ2TpiZBHWEm3tVtGHAL5vTodcL0ERNydbYkNl+a7Ju8eK/yhUqooeN
 tn6hWgqtKomEGJK1hYnRIqfgZe3Jg1raRg/4RCqDyn9NkqmeSg5JACEpXO9cpmKZcw42CPFKkgX
 CoxoQHRxAx5Cwgp6r6kl7Pr3KC3B+GYQMdjcqHEf3skAnvcZBr75wGwiXMjxSZEPn6M3FvNgFPE
 YNjLImm3ZT1NlLBoDHTvaDWmUOdjxmoR6H2drLX15TZ9n6vGoJSLVYqtK/DXa4ZGRrC2BPMANYl
 L70WKHcP2bEKfEZ00BoFCJkYaloFgIWZ1KS10DT7pXSJOcwk/uq28DMB9tuwM+ZvSdz8n3fcil+
 T7aEv5K00mn2Uxx9jjw==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae34bb4 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bN0dAzVfwMEGxDOd9cEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: AGcQ0vrI4qWqh2_nkMkl8JqCIkrT0tUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053

Similar to IPIP and IP6IP6, introduce specific selftest for IPv4 over IPv6
flowtable sw acceleration in nft_flowtable.sh

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 .../selftests/net/netfilter/nft_flowtable.sh       | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947..dcbae9a3d92b 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -579,9 +579,8 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 ""; then
 	ip netns exec "$nsr1" nft list ruleset
 fi
 
-# IPIP tunnel test:
-# Add IPIP tunnel interfaces and check flowtable acceleration.
-test_ipip() {
+# IP tunnel tests:
+test_ip_tnls() {
 if ! ip -net "$nsr1" link add name tun0 type ipip \
      local 192.168.10.1 remote 192.168.10.2 >/dev/null;then
 	echo "SKIP: could not add ipip tunnel"
@@ -594,7 +593,9 @@ ip netns exec "$nsr1" sysctl net.ipv4.conf.tun0.forwarding=1 > /dev/null
 
 ip -net "$nsr1" link add name tun6 type ip6tnl local fee1:2::1 remote fee1:2::2 encaplimit none
 ip -net "$nsr1" link set tun6 up
+ip -net "$nsr1" addr add 192.168.210.1/24 dev tun6
 ip -net "$nsr1" addr add fee1:3::1/64 dev tun6 nodad
+ip netns exec "$nsr1" sysctl net.ipv4.conf.tun6.forwarding=1 > /dev/null
 
 ip -net "$nsr2" link add name tun0 type ipip local 192.168.10.2 remote 192.168.10.1
 ip -net "$nsr2" link set tun0 up
@@ -603,7 +604,9 @@ ip netns exec "$nsr2" sysctl net.ipv4.conf.tun0.forwarding=1 > /dev/null
 
 ip -net "$nsr2" link add name tun6 type ip6tnl local fee1:2::2 remote fee1:2::1 encaplimit none || ret=1
 ip -net "$nsr2" link set tun6 up
+ip -net "$nsr2" addr add 192.168.210.2/24 dev tun6
 ip -net "$nsr2" addr add fee1:3::2/64 dev tun6 nodad
+ip netns exec "$nsr2" sysctl net.ipv4.conf.tun6.forwarding=1 > /dev/null
 
 ip -net "$nsr1" route change default via 192.168.100.2
 ip -net "$nsr2" route change default via 192.168.100.1
@@ -640,6 +643,15 @@ else
 	ret=1
 fi
 
+ip -net "$nsr1" route change default via 192.168.210.2
+ip -net "$nsr2" route change default via 192.168.210.1
+
+if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IP4IP6 tunnel"; then
+	echo "FAIL: flow offload for ns1/ns2 with IP4IP6 tunnel" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Create vlan tagged devices for IPIP traffic.
 ip -net "$nsr1" link add link veth1 name veth1.10 type vlan id 10
 ip -net "$nsr1" link set veth1.10 up
@@ -661,7 +673,9 @@ ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun0.10 a
 
 ip -net "$nsr1" link add name tun6.10 type ip6tnl local fee1:4::1 remote fee1:4::2 encaplimit none
 ip -net "$nsr1" link set tun6.10 up
+ip -net "$nsr1" addr add 192.168.220.1/24 dev tun6.10
 ip -net "$nsr1" addr add fee1:5::1/64 dev tun6.10 nodad
+ip netns exec "$nsr1" sysctl net.ipv4.conf.tun6/10.forwarding=1 > /dev/null
 ip -6 -net "$nsr1" route delete default
 ip -6 -net "$nsr1" route add default via fee1:5::2
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
@@ -682,7 +696,9 @@ ip netns exec "$nsr2" sysctl net.ipv4.conf.tun0/10.forwarding=1 > /dev/null
 
 ip -net "$nsr2" link add name tun6.10 type ip6tnl local fee1:4::2 remote fee1:4::1 encaplimit none || ret=1
 ip -net "$nsr2" link set tun6.10 up
+ip -net "$nsr2" addr add 192.168.220.2/24 dev tun6.10
 ip -net "$nsr2" addr add fee1:5::2/64 dev tun6.10 nodad
+ip netns exec "$nsr2" sysctl net.ipv4.conf.tun6/10.forwarding=1 > /dev/null
 ip -6 -net "$nsr2" route delete default
 ip -6 -net "$nsr2" route add default via fee1:5::1
 
@@ -700,6 +716,15 @@ else
 	ret=1
 fi
 
+ip -net "$nsr1" route change default via 192.168.220.2
+ip -net "$nsr2" route change default via 192.168.220.1
+
+if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IP4IP6 tunnel over vlan"; then
+	echo "FAIL: flow offload for ns1/ns2 with IP4IP6 tunnel over vlan" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Restore the previous configuration
 ip -net "$nsr1" route change default via 192.168.10.2
 ip -net "$nsr2" route change default via 192.168.10.1
@@ -847,7 +872,7 @@ ip -net "$nsr1" addr add dead:1::1/64 dev veth0 nodad
 ip -net "$nsr1" link set up dev veth0
 }
 
-test_ipip
+test_ip_tnls
 
 test_bridge
 

-- 
2.56.0

