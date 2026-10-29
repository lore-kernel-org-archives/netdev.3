Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280955;
	b=AWGeEvCUREjwE8KJ0g6t0xn9Uy4xOn0x6SBilQgxzM9l9AfJra4ICdUaok83akhrEQN8
	 hAZHbZgbVLSAgfHlN2s91OX/3dYe/kVykIfJDT+72KT/wYG0pEU7uCD3mIa7mg5gGEEsa
	 W6Mr1eVOh+WOXxPnz8c/kwIQMUeNmYgvQj1mOI93mM5uBflHZrL1G+hZMVtwVDDiVQShZ
	 jY7+EGAnxFd/S6ouyjffZsZC1kHLJ35vKFfYnrqFIQ5a0CA9SffZ3Hgt84hkhv9mCMfZO
	 a1ORSv+5dHrStVS7A+Yy5VKQPvpMwWGSh6NHw6AL3BsVTNwmBI5L9vTk2HR0iU1cJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Z6XS9g1yfpXlXRk9/YKY1ELXgVfvsZxJEw+TI7y+Uo4=;
	b=AAe31LiujJldgHCw9KgM+8aTGuWuAkf6q54jaHk6zvqkUgbGcHsaibrtEcw9Hx35RNbK
	 Dx73oXdk+htsaVbrp5C47N8RuMmQXBPj7yTvphRdGajnyHkgnJhdBTLu8HT/a5lut2Cw1
	 PWJlmQpiXedRoYweqiNzfTQqZKe5W30y6ki+Xn3I+4dg3/O7xOBgqCcsW7wx6uKIPcceK
	 75YlH1aTxOBzpEX5FUK2qysESmhFq4hJ2N91bHTCpBJA54Vc+eOGIe9UeJ2vXz8kRbvLE
	 3BCVfwwG2Wve5l880ZTiNsI4EYswPW4mtIfuJcbAGdSah1/4XJ9hbE9A4jtY6nyk3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iStT91TS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="XoSb/Tkw";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32660A262E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B32660A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iStT91TS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XoSb/Tkw
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCeHFC2761913
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6XS9g1yfpXlXRk9/YKY1ELXgVfvsZxJEw+TI7y+Uo4=; b=iStT91TSpUGSJ60n
	z4Jds6W8d5YfyZoTJo3FvjhLKhpfO/uykese30NjRDN8C96RqwJcS/C0Ox0Dr5qQ
	yX46nnpIAuuk1AiQzdKIg2SmACWTVeTBJ9X00CRJGupkVScXiDVemW6t093ym9Pb
	H8n4rVQzfbvUqMo45FK7tR+jDy3Raf6zZiVl9ZBdb+pEdEH0Fqf1SqCqHfMEWHmh
	szpJbVRrKs9QiI6cCIaNvqBnr8j6hZgutx96mtlSxT22qdZkwV25bB+kTp79ER+H
	jG37l9zv9VR3MEH8GBoDwCqQ865SWSVQoaPSXpPa4LGq2geSAJSos+UV0YgSOCfD
	MPkxQg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b10sp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c7bf2d734so39177196d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280953; x=1793885753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6XS9g1yfpXlXRk9/YKY1ELXgVfvsZxJEw+TI7y+Uo4=;
        b=XoSb/TkwbCc0t8RyMYMTRCHOa9tUeX3Nvdw3CE5P1M3whZecO/F7aB9YHkzfuQPt5Z
         e3JKA/OhQDbGBKhya7ggFocNMeGvdwIFbNdggQV3e6+W4CIaFq3816fsYjIXowUe4WqB
         L6YvtKfD8Kxb1bahiXM22tCig5dsJWlFyOd8/Yo6yjA7PtwsmbfwyZzkoKeSDi8sUUOw
         vUy8xkVk2vOW8DHX2gVHVUP5XBRIAhE/Hkn75ZDMeMBgcnmybBuXauVEkVFNgCBQXvC2
         fTf7NcYXi9WHxQqNEsuvvKEeA9/64Ppaw/DTe6fbsvO/ZKlzshXBn138heMwPaPJWabB
         rATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280953; x=1793885753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6XS9g1yfpXlXRk9/YKY1ELXgVfvsZxJEw+TI7y+Uo4=;
        b=xe6pDTZ/i2DvaoylQsxsI3sDBMdOEQalHfAO52q3yVuHH1Ih4af3NEhKKLuRX0xOoa
         lnv2Rmwn3IdzUcp8AwDW8Ldx8Oj2eHkUWoOemfTwrylhH6szniTEdhKzjO80YjfNSsW+
         d1RC5tg46dYM2ZIlIu7bgs56ztPqyk62/Nmox3Z2kZiNUywrChTyhdARzvKOCBZWlqpm
         u97jTqwTobTwjaSaT1AiDXk1aJZEQzPTxR6v2rHeMGXOp6z2AEUXab8xvHriBJ2JkWox
         sBFL8JOcHRd4ZFZvUTwmrWSGBqU2cPIIpmPjHc8iadA6H0jmRnLbpp/86UOzXiCllkAX
         kioA==
X-Forwarded-Encrypted: i=1; AKwUvBxwegg3SHhfEwRhpWDOY0ifJuGMk/v0vcNTfoIx/Ukt9j7bRJvsQCyCfqUoRkPm8O++09oC2JE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1g01SziDcR9wE7ZhKQ+ngrCxiRdI13/Q6Ql09EjGpSY7Ep3nX
	9+Vtb53ioBDeULxxnkAXE6TrHciKAkpKjJedG7nAyANd91G/gQGk066+OXYexS8cxdkU0iBSZli
	7SACjV46Wz1lfYig8zOGE2pqOC/VCq8rQqQ4F4543vvllZSDAmcEGzWbDeUe6p9hhSXg=
X-Gm-Gg: AYBFou2H8Lro9ilFOIZlNaqE0roZpB6O4b8aiDe3joAsW7bGeMj5Ex58JOP/3aVOWfq
	CTCYlMyx4yPDpYT6GqKZLxkoY1OXf0CjFGrOZYJhixlVi9ivVvaOTzEDuHGxB/3DLXED8SeoFJ0
	862LNVKTWjtwIKMsCitGuqG1lJbrP3iZtk+B/MKLVx3XXOdv/+rMAeLAl3TznL4F1vXziubztjE
	OkwGOUbUnmujY5UYCs1kDD/TedffcUmZVv/3yPsduxF4dlMdGX3p+dXrc72dvO9dpmoCulBaP2q
	TYkM1GWVLD+B+nWOTRKOghVwDYYdO6LwzQoxHbFssQY98xN0q8GLFI9bm/LA0vkw7uKzZhCet1r
	8Hrq6tbRcZ/u7xFqwI+JtuDnH+QAbT8Fx8YfzaD9bCDvip8clXgcvpghrsOgD2zGjJRjIzq75YO
	RLRrDzRL5GbCltnooKdG0Igw==
X-Received: by 2002:a05:620a:170d:b0:93c:635e:6f3e with SMTP id af79cd13be357-94408a5d003mr856599485a.35.1793280952327;
        Thu, 29 Oct 2026 06:35:52 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:93c:635e:6f3e with SMTP id af79cd13be357-94408a5d003mr856593785a.35.1793280951737;
        Thu, 29 Oct 2026 06:35:51 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa820492cesm71866705e9.13.2026.10.29.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:50 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:35:19 +0100
Subject: [PATCH nf-next 8/8] selftests: netfilter: nft_flowtable.sh: add
 SIT flowtable selftest
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
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-8-6a17c54f9fb7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX7WKPdCuaFm5r
 OoxAW/tGJblgZLe3d3iNluEqbZJyMTZkm0kzO78cRW0o+U/1Uz6V8sZHRF/AGX8sliFCI2l/fj/
 lPKsOhEYLYE7AZ/al5ypETtmeJfhK4E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX+hmH/yJZD9LJ
 7ALDQTK33j2wpg+J5Ke01Vw8V3R1dSS0sCXEZwD+m4m8rboKzA0mgQno1YMvZm58wAjqAhs9ntH
 V9glIWvzch39F5uvGhVagTjFHLTQii6xgiBOKBkueC+luwbKA7Jrwe0WsYGJOGGfV76xmQu4QlV
 ibLpCgRSOobYPQmZCVJMgnIXFwAz3zjB2BzS9jvUIo6VhpZ7r8fRuX7p/GdHR/EwGoJBh4pgVn+
 RmEUA/itapNF1kcLTqYqVjLjkFi8+KDjTViRFES2V08blIJO0job+hXtHscZLhNmiFCvjlJSP34
 358RPMbtmitUNMIoZe/VOX/OrWG5R0srStQOYhHHLPChwieynaGQJ0uV8U7hdKMH0IIp0At4w8c
 hFLzSQKY4YYkaTArAhfMyDm5Z9J6ZiD8tp/iQnKy5k5nZbFQxFpZ8u/0SrzOOOc2S9Od/O6iqdf
 IJPnE2MslJXT/nXIOxQ==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae34bb9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XuXj8uMZMfGkPmKnGZ0A:9 a=a1GBzH_hwgqQkvkP:21
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: TQk5WjL9Bs1fecon2QElpsCnTe26-vf2
X-Proofpoint-ORIG-GUID: TQk5WjL9Bs1fecon2QElpsCnTe26-vf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053

Similar to IPIP, IP6IP6 and IPv4 over IPv6, introduce specific selftest
for SIT flowtable sw acceleration in nft_flowtable.sh.

Also add tunnel-specific flow-add rules for sit1 and sit1.10 so that
check_counters() properly verifies offload occurred, and restore IPv6
default routes at cleanup to prevent tunnel routes leaking to subsequent
tests (e.g. IPsec).

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 tools/testing/selftests/net/netfilter/config       |  1 +
 .../selftests/net/netfilter/nft_flowtable.sh       | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 629b2b29ed1a..930374aabec1 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -35,6 +35,7 @@ CONFIG_IP_SCTP=m
 CONFIG_IPV6=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_IPV6_TUNNEL=m
+CONFIG_IPV6_SIT=m
 CONFIG_IP_VS=m
 CONFIG_IP_VS_PROTO_TCP=y
 CONFIG_IP_VS_RR=m
diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index dcbae9a3d92b..3a393c8deab9 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -597,6 +597,10 @@ ip -net "$nsr1" addr add 192.168.210.1/24 dev tun6
 ip -net "$nsr1" addr add fee1:3::1/64 dev tun6 nodad
 ip netns exec "$nsr1" sysctl net.ipv4.conf.tun6.forwarding=1 > /dev/null
 
+ip -net "$nsr1" link add name sit1 type sit local 192.168.10.1 remote 192.168.10.2 ttl 255
+ip -net "$nsr1" link set sit1 up
+ip -net "$nsr1" addr add fe01:3::1/64 dev sit1 nodad
+
 ip -net "$nsr2" link add name tun0 type ipip local 192.168.10.2 remote 192.168.10.1
 ip -net "$nsr2" link set tun0 up
 ip -net "$nsr2" addr add 192.168.100.2/24 dev tun0
@@ -608,6 +612,10 @@ ip -net "$nsr2" addr add 192.168.210.2/24 dev tun6
 ip -net "$nsr2" addr add fee1:3::2/64 dev tun6 nodad
 ip netns exec "$nsr2" sysctl net.ipv4.conf.tun6.forwarding=1 > /dev/null
 
+ip -net "$nsr2" link add name sit1 type sit local 192.168.10.2 remote 192.168.10.1 ttl 255
+ip -net "$nsr2" link set sit1 up
+ip -net "$nsr2" addr add fe01:3::2/64 dev sit1 nodad
+
 ip -net "$nsr1" route change default via 192.168.100.2
 ip -net "$nsr2" route change default via 192.168.100.1
 
@@ -626,6 +634,9 @@ ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun0 acce
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif tun6 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6 accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+	'meta oif sit1 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif sit1 accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
 
@@ -652,6 +663,19 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IP4IP6 tunnel"; then
 	ret=1
 fi
 
+ip -6 -net "$nsr1" route delete default
+ip -6 -net "$nsr1" route add default via fe01:3::2
+ip -6 -net "$nsr2" route delete default
+ip -6 -net "$nsr2" route add default via fe01:3::1
+
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	check_counters "flow offload for ns1/ns2 SIT tunnel"
+else
+	echo "FAIL: flow offload for ns1/ns2 with SIT tunnel" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Create vlan tagged devices for IPIP traffic.
 ip -net "$nsr1" link add link veth1 name veth1.10 type vlan id 10
 ip -net "$nsr1" link set veth1.10 up
@@ -682,6 +706,13 @@ ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif tun6.10 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
 ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6.10 accept'
 
+ip -net "$nsr1" link add name sit1.10 type sit local 192.168.20.1 remote 192.168.20.2 ttl 255
+ip -net "$nsr1" link set sit1.10 up
+ip -net "$nsr1" addr add fe01:5::1/64 dev sit1.10 nodad
+ip netns exec "$nsr1" nft -a insert rule inet filter forward \
+	'meta oif sit1.10 tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
+ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif sit1.10 accept'
+
 ip -net "$nsr2" link add link veth0 name veth0.10 type vlan id 10
 ip -net "$nsr2" link set veth0.10 up
 ip -net "$nsr2" addr add 192.168.20.2/24 dev veth0.10
@@ -699,6 +730,11 @@ ip -net "$nsr2" link set tun6.10 up
 ip -net "$nsr2" addr add 192.168.220.2/24 dev tun6.10
 ip -net "$nsr2" addr add fee1:5::2/64 dev tun6.10 nodad
 ip netns exec "$nsr2" sysctl net.ipv4.conf.tun6/10.forwarding=1 > /dev/null
+
+ip -net "$nsr2" link add name sit1.10 type sit local 192.168.20.2 remote 192.168.20.1 ttl 255
+ip -net "$nsr2" link set sit1.10 up
+ip -net "$nsr2" addr add fe01:5::2/64 dev sit1.10 nodad
+
 ip -6 -net "$nsr2" route delete default
 ip -6 -net "$nsr2" route add default via fee1:5::1
 
@@ -725,11 +761,28 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IP4IP6 tunnel over vlan"; then
 	ret=1
 fi
 
+ip -6 -net "$nsr1" route delete default
+ip -6 -net "$nsr1" route add default via fe01:5::2
+ip -6 -net "$nsr2" route delete default
+ip -6 -net "$nsr2" route add default via fe01:5::1
+
+if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+	check_counters "flow offload for ns1/ns2 SIT tunnel over vlan"
+else
+	echo "FAIL: flow offload for ns1/ns2 with SIT tunnel over vlan" 1>&2
+	ip netns exec "$nsr1" nft list ruleset
+	ret=1
+fi
+
 # Restore the previous configuration
 ip -net "$nsr1" route change default via 192.168.10.2
 ip -net "$nsr2" route change default via 192.168.10.1
 ip -net "$ns2" route del default via 10.0.2.1
 ip -6 -net "$ns2" route del default via dead:2::1
+ip -6 -net "$nsr1" route delete default
+ip -6 -net "$nsr1" route add default via fee1:2::2
+ip -6 -net "$nsr2" route delete default
+ip -6 -net "$nsr2" route add default via fee1:2::1
 }
 
 # Another test:

-- 
2.56.0

