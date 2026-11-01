Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559757;
	b=luWgoPu84UmLhbBU0ZPuThEGfKEQvQ8vbyTOsn4UirHX9Jd9rak0983PMWvrCjf6tWNt
	 caHaBE5uPIBnezLFN6Ha3YciOwVheaAMEzTTy8+b5O6DZ3EyPgie0HWMnNfcdmDLzb1X9
	 OaJyHAImG4SypYyXJxbW+IavuWtYXFrb1lqGOwApBadJjD8lPG93A5v5Ohspdp8EQZexF
	 K9WqI34O1SI9eicMWvDC/CYWVvWqWYZFUpMNDDNXximrlCVYapY3NQVMLL17Oht5bqhWf
	 QEqz35jXKq+yF+ibdIdBReNyM2H0GswoTlRtUjFcvhURUlQei/VC7+ivoTuJ621CL/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
	b=K1O9oSmdFbUiukbPU6VvgwD/UueQ7I26wyOIgtPyYRIuFT4EittTCaz5WsqHhMKBoihJ
	 hl54YQj6tq7/3Uh8SjN/GAAJZxYZckZ0EDlpy6yl7JXnd9ImtfxDcH/MPvIvyzpnYGX2X
	 AbBSkBTs54vQK2lkI4I7u4YOdxX5k7sOsTDU6Q0fUYkCGHpCEX+6VmKx4nwFgwJcwoWom
	 nc2VJPQPsp0qu6kuGhDJH0rRatsn2TCjl7Ko/wVf4WNgQnYi1gCg3+EiMNW5PqaABfsg5
	 VD2fW7M3Ed3O8xpIgKvprWP9ffkQun2KiCgFX3D97rtz+oX7aX/bLwoJm1OWa/CDKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SYR1ltU+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D13bAviD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88108606A329
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88108606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SYR1ltU+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D13bAviD
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HRi1d4032565
	for <netdev@vger.kernel.org>; Sun, 1 Nov 2026 19:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=; b=SYR1ltU+h+DcYgUS
	KwUm0gjiC5pxOnmN0rOWydYeeAQUt2Y5GWUV9Ssqisgziv5GYDbOASmCtvnRklNM
	APIZSukBaEgcR3cERN5oruncVgcULyq4erxjZw8TgDl1wWIHHGNuka3Q1Q95btu0
	pnxBUwc0ZZ0C/7h5DlIidVGslPUtUURR3NQzhfWVggWB8/1hcLjTcAAtzN/xPHgj
	FnP4bpvTxS78Vlwbejci9vIiNuUZsZVVXVTIzzdyPh06ygnBRAA+iE/8kkFVpgH9
	A4x57MuD7p9gUqjd4rPOuJkPlnmenqRuznfsc52aM4vJf4VqlMmbmYqUDytuTE1u
	mbNusQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk3t09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:02:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so136678485a.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559756; x=1794164556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
        b=D13bAviDa3FmwLyrdjir/hQTXqUkW3+Y8GJICdgYvQ+hK/+ySGmZcJYID8N6JV8+IJ
         e2im+ZP8+UyU7axXKVoZDE9Bin4sAURv/H4D3Ls7riYpzPCVt9hOUqNGUp/yXJrnkuw1
         lSyj/K15bSkRsRpMFcOigYT/V7HE5ZczUn70hGa9z2RTyP53XNkTGMJvgoWrTY/S6vZe
         UTp9OGYteM9dwjcNU04k0xj7wj1zM2BIxCZ7arqyo5ffa1lafGGo7CZgpinJHcZ4cs63
         qCfrUsh18kKfmc1zrvvQtRDdzLAmnBQFxY9mdXmvYAqQ+8x93a1ZbqwDpgt8mnd0e+wI
         OvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559756; x=1794164556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkyFaU7pm1UiMcf0aTZkl/EEwuv05ryAASaXqNs27JQ=;
        b=nECKyt0sDjFlCsZUBcnfv02EhWtYxLecTGaqzig5XkGvs25OxDVJtVXeyoBD5+ZyDI
         SVrJTGlsAYzzRWMaePVN24sYhouuvGobr59RhWMhYbzv4FgggWi40+yHfyXRVBJrjBE7
         M49T527IRPWv5v4YiJM/rZiytR8vV6EpqlGR92UYveBXZGe+wMsmWszZDkgnb4at3snB
         p8nj5C0HCJy+qVOrPAwumo5mGZ26zk8EWuhO7HTSkqMYx8JyvdSswzoJzHGD0w4+YJ5K
         P+eSHwGLfPjN0vL08tljzH1CWwn1Fnnhn2iX+PUkzCrmt3Q83jSVcNfJmeKUQ2LvTI6a
         wwrw==
X-Forwarded-Encrypted: i=1; AKwUvByF67sh0zSng1IQIN5qjtCmUlkf6KQrJYKdv+U3U/Q4KO8DZn4fk4pajg15yTChyJndg7WhkLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJa1f+MIGQsZar50/AL+NVd6Gdi9tJqbXSv90W/t5BKvqSajysp
	iZHefMKdfpw+hxdOTAUQBzp3SoG5pZVZqpF4/Wfio+rhv+MBY3lYU4ueq4XdMmS0FO+0oIr0cYp
	lP6rerP+zp3k1lgFmUsBrR9aQynOFMaHqOsx8k/ywhzwBiiaHLGOy4+FybYM=
X-Gm-Gg: AYBFou3WTSKiCADS+mge7tbK5+yqZqfjo141fhA+QrRzdc/X2F/CKDk+CTzh6ZqohMe
	7m1NjHBwu80uelhivaIpjlJ263ETGXfKN7ruaQAkuxb1Tj3e1f1ValT6RJH/LiIZCNy9vNHfbf+
	C/iVes9lMhSNu9mxBo7vkM9ZDd6tOUntvB99SEXcDUGe9UBvXkAfhw2+W7oh3NCruVT/IlZ6h5V
	krMHoA8QlU4ZdVKZA7CRFJi0NCRBdJuzANDwEP+9aKMWX73i7Gips9m4hvBElZP1cC5w/XEZqzM
	dtUFJWco1H7xGG5EFaMIbJQ06/iueXNAj5JhpUn1aUmcOtZJzifj7CVsqr6URbYxatTrp8GWUf8
	LCsv97pG0kUHGR2wKh09nOhCwJdCzYRMV145Cs5eNHsp3qdhXhZ6v2O8l7xG6pAY=
X-Received: by 2002:a05:620a:404c:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-94421725362mr1333107985a.65.1793559755408;
        Sun, 01 Nov 2026 11:02:35 -0800 (PST)
X-Received: by 2002:a05:620a:404c:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-94421725362mr1333065585a.65.1793559750104;
        Sun, 01 Nov 2026 11:02:30 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm287704435e9.3.2026.11.01.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:02:27 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 20:02:00 +0100
Subject: [PATCH nf-next v2 6/8] selftests: netfilter: nft_flowtable.sh: add
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
Message-Id: <20261101-flowtable-sw-accel-ip6ip-sit-v2-6-c6c282cab5cb@oss.qualcomm.com>
References: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
In-Reply-To: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
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
X-Proofpoint-GUID: 6LwBZkmBj6c7vYsgKxxV_9YCfyLKlddF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX+eMgl7KTUgm7
 VkEJDig+LxGhCsNIB2tvKJ3ep6azvIa8QOYDqiMFgftN9tN6VpGwqDgADqs6ZXSj4jcm9mIEB52
 3jzDF6rROpJa0B+M71ohd8CE9+m0ZiZ1XdRlvrOijAz7Uz0ZdYXyYgmixqYf3F7i+ahp30JHBVX
 eB+dAgUxx8JwJTLONtjHqmvO+LJXqN3bI+4j2HYaC42ECqkgZc3fRa5mmrG6MUt+OfLkcl4k4Eg
 LSpeXaSrrYzyW64y4Ua4exrZwEfTGb4K5IEqeW5rbHVQLetFXC3IW0AmhjqFEgcja1aZhn6A0qo
 rs7FPBE7HvL5W3pmJeQxIGF3oyrmqzT0bxb+Ze5L8pT+8qfVeXIpqjytROPm6sJJBhntcKZa2hd
 +LJEw39ntmbHm+Dgmx9LzHcRoMMyzkeRL5YYBHVn2FVnzmwtlOX+tbtTo8HhWSOszL02tIWDzh2
 3L4VIOeMBLVPBOHO8AA==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae78ccc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bN0dAzVfwMEGxDOd9cEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfXwBzwFN8e72Fj
 kOsaDZG2RksswFrZDoDXUdRIaPH3Fv4pIltuldJYOblYFkSsJPj5CHCxt1RNHL4EphECLG2zw+S
 5bsSisAmiHq/FFVRYfCwJERWy2IjwtI=
X-Proofpoint-ORIG-GUID: 6LwBZkmBj6c7vYsgKxxV_9YCfyLKlddF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

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

