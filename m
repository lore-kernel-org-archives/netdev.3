Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714494;
	b=aODNEW/j3wkyjDmIGO35UoHjKvKxq6EFLG6+jTWXM2JV+XjKJrvRybFkeajLpPqui+0h
	 DGqBHWqOd9ebqq8Rf/64alLwZT3cIlvQK8pVKq5i0/XDtw/ydiN/PerErhVsWiXfja2tE
	 8EJw0+Sall/uc4Hb3abwA+SHf2k/prqWc5LagQ1F8ENVViYm8YPKXW+rF+0fClIV8Awck
	 yU2QBfmqdrKXiiznX8ch3M5UjOGAvwmeT1MU4p5P76TcBVOJh12cJ7p9diOxLLJxMLhkI
	 S0Mk8uqMjvY/jKNh4hpvSw1vYYKah/xHvrYrn+xpvndtnKO2bywnKFmhM26Qv+UXc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714494;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
	b=QnMQL6JcErMzBfjkLpRbhyyFzK6N5PDBvlzRX0FaPxuxpV5zY6OMQvAWy6jpR9GnmKSD
	 bu/EhUGapIFFi90sjCaHE77SHzdEm9rPKf9FS/7Em+5aR5GC7EOzFKX0AfIYG8HI58D9s
	 pVAE/9dB1hOlXxm1c42FeDZvj30TuegNBKrXcG6+ez0PaeUEYSoBILrYduhlZeHbj/7YQ
	 CRl5dD34pbCxL2Ctev+EM+H/iuIX8CacPLe87pr6ky9TwViMiPz1Mr0qn6wAxSw9rw1s1
	 N4ScCFKqr9o9yMKRznCCXK6dnzkUNEfl4MpX5npar26hjwrhJJtwSKdNPXD24y6Dr8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LDAMOFVR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUMrG8vp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F160A2630
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E6F160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LDAMOFVR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUMrG8vp
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZ93u2651031
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=; b=LDAMOFVRSOlKB/7r
	RoShEFNL0r9wORxBSEVExk4QNcBt2Rx6j5zXD842VED4vTHnl3MRYEw9U0k2cHso
	xeCY3q16TrvqW5c2qo1c6KxUhqlaUypcMu+QQuZaBomo1ToB1vk1dZNPPWGxwmqi
	66hLPi1zYumhyQFDBCUQNMLFqc9SUkUr+aDtbnjGBsaLqhJORPj4VTilO19O0VNd
	PxkLzDovsOPJe8TBV744VmJ7UjyrngPr4m+Va+CoYUFBepWbUIUY5/QnGumiAScL
	+pIxogMcu8Wmr6QFM+jNNscGH+3Kf77+PDYZa7zJA5i8IbLxxK2o2Wwd+0EQsAAW
	PUlzug==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r42n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:01:33 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c83124d530so4769144e0c.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793714491; x=1794319291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
        b=FUMrG8vpmLIH7edsLEnEEmAiTimSL6vRRaCaB9wmvgrAqhex7vR1FPs6tj3WsS8wlT
         crefpDUBq0DLdEZ9ozmePLVBoeBYl4LU5P7xEziUwle7NS8eXAoDQmozkv6Fxt/bTOTs
         b1WtiW0ejhKe+lctNWhAIQZt7ElrXytYliefwiMPj2PcwzKHkalJHg0FHfvpfG3bJw82
         yEKLTjY2RuTZjH8xmGYFP4K8st2ETwgDQnKv8T5Vx1f7sZMK6DChPE9OeCdWYMnqjcp3
         IX6bvWuL/Zj459YRKCwBJ020DfICxdg9M8VdKdA9V3prekTmnHGiuCUDBaEH8317dR0L
         6utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714491; x=1794319291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
        b=WY4YIDC2L2GYzB2u4JUzW2W0m3g8hQuNzIoe6m2KJYIB89larL1Wy6xHebbRJlK1LL
         1tbOpuEr+kpuu1ZbrmQLwm02e4w+YDNbPXY3hVLaBsEWM46du2DUexSVYF8xU+F+YohX
         u+pGTWyEMcFGf3LCotTUlOPKjvmTA4skku4bXdG9uOreViyGYvO/Eb/e4cqhzrq4SgoN
         F+pFbqqi1DLLcXS/x4bpEz1PQC+8euyseYu92gJyRYvwOkbDGlggOCpAYzZQeCUHtTV8
         OPG2Sut1NiarnhTtrH/WkILwskwuXMOQEpJumAplhMPpgAFPlwDy4QKbJwzJGyOgret4
         BeDQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1AU6TYx5GfoPTfTpOQJhLRObIuyfFzHzfq7kcDc76VBdi72S6m6qXEiCqLGOqEP7Yarn6+zo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gp4K5Joc9zwZDKckkxRFcQBZ738zuVZ1S/WsdP4UtMEyohYlT
	pisE/86336FKGVZGrHDjvFES0krrbMv5TNrptLzqkcIVCVBndqCVsG+YC3CvDHNzCaC4ZFFBChl
	AQFl3ekOOdhqVx0z9GsRuuSoSqooJhI5EKN6tphR/E7kemP7Ohdvqjq8Uu7U=
X-Gm-Gg: AYBFou1+U5PTUoYHY6H3hezt/3wpSoaPQHFcZ88fz6pLr4LNd/V+SJoX99Vxt8vDzrI
	auz2pNdKr4rRZR0Gek0mgiU6y/5RcJi4dM07obC7d9p7dXsV+AN3OCOZmPLjTS3uyM/NzzYdVBK
	F2aYCUHfyiQKJX+6EvS+51pA5NDyJSmYy+ztiKnaHF1N5SEKZZA4BZ851nvbOwe/8stDgmLFiau
	DZ34P0BlWWELbezcheha+9XrSnscV5bfnKKvkCL6/pc/heGQ3B3wvmG606VqaDNdZcRRLI5LIUa
	6tjw8ocyIzo/PtkY/L3Ikgnq6BGyp2ini6XnTAW8hY6ojtQZBymCcyAbmohLQ/T4njg/LqfYOYh
	9/EAw+ezjoi73bgn015j1XP8NI25DtccdZwzOeA3NPsArcI6cyRVBVzlfIbVvnxI=
X-Received: by 2002:a05:6122:ec5:b0:5ea:dc36:245b with SMTP id 71dfb90a1353d-5ec6896de21mr5609956e0c.18.1793714489337;
        Tue, 03 Nov 2026 06:01:29 -0800 (PST)
X-Received: by 2002:a05:6122:ec5:b0:5ea:dc36:245b with SMTP id 71dfb90a1353d-5ec6896de21mr5609682e0c.18.1793714487766;
        Tue, 03 Nov 2026 06:01:27 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab010a66sm84552045e9.13.2026.11.03.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:26 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 15:00:47 +0100
Subject: [PATCH nf-next v3 6/8] selftests: netfilter: nft_flowtable.sh: add
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
Message-Id: <20261103-flowtable-sw-accel-ip6ip-sit-v3-6-60b5f063f1df@oss.qualcomm.com>
References: <20261103-flowtable-sw-accel-ip6ip-sit-v3-0-60b5f063f1df@oss.qualcomm.com>
In-Reply-To: <20261103-flowtable-sw-accel-ip6ip-sit-v3-0-60b5f063f1df@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: pAzWg5EtOQgd_ou8vlKjewyUFMsU37vS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX1HwtOUedHhW5
 VD5ywEyUT6tcJ9VV95XW2qypDc/ZxXjLj1C53o8JMEzDCP9W5h0HEi7rKTMKzLM6EUJPBY0Y69P
 kJDcZarQm0iLTTr9owEU/siXwtexp4sSzVJGLBIHAqjMCBsl9Bl8VSjZtfBNEGMyizAVVpHZOag
 XOzodDC8LPPAHgzwT75aBUOsLqiJniApxsjC2cA5yM+eTBRSfj5TP8pG5neFoqpcZK5eZpnZS2G
 Lkx8WzjLbKoBg9PiykZnqbjENQ/BuZ5TOSlJNsTnnm4M5wIFrvNBILtvsp39PDi+H/1hZ3JX249
 GuRArgLM9oeFTYyBtQTnXhGTW8IeXjOKB8XAo7hWVZbN4QMEKhGjmerE0l+gyUOPKW228LpIPPS
 4HEHk6Y8/4Plwr9X6RbG/n1WM77/zfW9Mh3TLXg072P6An+gK3J27uvGhLDbC1ff9wmyciigJzh
 Hub6Gk1CRHfddugQivw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX5b0yAqM0dgRG
 IQ0FLETBg77HOJ9GJimzmG18HFGZuuz6xeQ674qVGqVq7BqyECzTylIHQuETLi8p2FRD3tik5H9
 /xkypQQ7ZQbLZ7U8SQP9a7ggJPmSxx8=
X-Proofpoint-GUID: pAzWg5EtOQgd_ou8vlKjewyUFMsU37vS
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9e93d cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bN0dAzVfwMEGxDOd9cEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030055

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

