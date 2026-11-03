Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714498;
	b=ehAVEwo5Fm06UXOguINv8jKZ/+5Ec/ksR4NqzK2DWlD0qKqlGO3ypFJEnqHGKgCyuNHo
	 SGEzmTlw/0WMp4dZ518Tv02u/dG2xAv+JhL7c9f16pv7DP+UMk6TJ7WJpVC0hdkoWMr5N
	 13R8ObdsJbJ/m9kpWEfIt0Wf2L6d99vY2cMo1aUMZg3y0LOWDZXBfz4qzXKiCHdI0236y
	 qKIQOAJYsgHPCSaRErL5aXdHwTsOaEiTbtHnsVWHSlQpdroJDDOluXLA8QOD8mZMI+YnP
	 nF9JzO1fJbx1kjLEu+MxxHvsuBfLz9fLVBG+CLDfhwWoswzFCLqC3liVZ9dEaCqj2MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714498;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=crtlCQWUpiltNN3I3i9wQGUeGiNDUE1VlL/TwhcNurA=;
	b=zU3OKJ2Sa4ueNusMiLcDYZjFvThzZguO/u1b7Qdn2yMull6OXRqAMSaV7H731GxrWCXw
	 CwxtImeOUBty38NMeuPREQV++bbghnKerK+fPZmTFuJhLNuDHQOmFQxgXFxpxFNMCt5F6
	 VuqMvtdmOoY3uX2GNvVQjpfhAgBLmU7VaMPcTd8bzROZSk8W2CuYo2Ff41vW1PNGhkLSW
	 9DoIYsYwBVrs7KLQY17AS7nQ70R7uQWL+N4MQzavQdL/X2NShZcfNygAl91tgP/2Kdkle
	 71ujKB90SZFVPaNvOaQbMBPivL6w0VodlAko/JV9rikFwJkJNw8dAtyWCGp776TfefQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mk3P49Nv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BHa7Ejcn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFD6085088
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FAFD6085088
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mk3P49Nv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BHa7Ejcn
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZO012651343
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	crtlCQWUpiltNN3I3i9wQGUeGiNDUE1VlL/TwhcNurA=; b=Mk3P49Nvd1OSxHgS
	E5kJgffxiHbNGOtD118cMvp0eal24xyXnVwMCSF79qsNvtA27Vz5vLoxG69maIpT
	PU5urcdH0lvzYkrGfGh+iIEELWW+zlqA0ZK1Dm1NWqEt3g4/0w99AAXtpscdkc2c
	cCo4OIV8aaze8pOEawRcjCXUmmc3NuYvbKjG2pMRFmGi7Wf/NZ6AT0nzkTymali2
	3ZrNv3Dkelcg1IcQ8Musyrucf8yz699jVigb8Igb/gDxAIV5iKdkAy62J9mYvv66
	jfZbDjRi8fX6/pB+GIVFokH6rx8vLxrcsutVuHNuTqYKoTNU24bxsf5INiDjAIfa
	1p6UkA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r42nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:01:36 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so4237320e0c.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793714496; x=1794319296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crtlCQWUpiltNN3I3i9wQGUeGiNDUE1VlL/TwhcNurA=;
        b=BHa7Ejcn0/HNgQncqP7WevO0sLreZk25jVBXL23+uApv55hXgEVANj9IBeHxbaWzO4
         6lzGWAdEhfAonHU+RiXrzu7NRAJoSQybdfrCxsAmf5QG9EY1pWN1/kVgb/cUJWmwXV3k
         tzI13dCjPNnExk3GPTwdtBx5cs1jHdFSlVlw3kFsK14YXCXiUT8qFvWd5FNJLQgSdg5n
         RaYfjSrFcnMviid8KCqtzVhcHqizOukunonR9HHyYJJuH/KTTQEsk6NzZHS3bBMi6w8R
         PtBwTD3Moz1biwwDGVREvDUZmnYI2/TOaIzO0bguMdbM2+xBhJUswxnaSSO76/aOMULy
         fOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714496; x=1794319296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crtlCQWUpiltNN3I3i9wQGUeGiNDUE1VlL/TwhcNurA=;
        b=OWXkayjpUn3A5veJmPTc1sMW+t+OrA2HaWdc2vd5Eqh498hkRLAcLkcmuU/NsmYMtj
         jag53CoSgP54S5t+xmQKaV4QbvbMW1c1GUiJzqSQGi69Op8glraboiEFZ6fozsObyac2
         6dq9dOSMOMyF9CIkgOUbnfvH71WvhMnod7OFy7GEJ58fpQtSwRXbYi/SdvDlu5mywK6D
         15aKkLc6UDmojGjig1XD1Jc4y8JVT1TdXfTC8xQF9ofyvuwCkdW8v5WdFfSMsKzsZ3Mu
         YMKc/ISZQQWS9UpDsfOL6E706uJCMIj1VGG6/bpb5lYPzU2FDslM/yZFwzljv4lAoPfu
         sKEA==
X-Forwarded-Encrypted: i=1; AKwUvBwJltgJ1gQzpZ1rUn+3UAiGSUlwNmEyOCYfTFREuev+ic+85nn1EkpnFlOUU7hVkjrW1E8y7r8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9U4EuHDapH/pqIBqWC2dJvV0esKvObEARHaE4C0f2KcV1zsWVb
	3udwbYWqefMSvf+ncVcyZIvoZ3HeTod674FDPmMbecdqvIj5uaBxStvlr9JPFmRovLCpngTdRXf
	IKScxNlvRqro1K/ChOm8aJer+8MT0OlQcYpC0IcPKvvSzZgQxRBghxghBTcQ=
X-Gm-Gg: AYBFou23DSEGJnTvd92vRl7UMynxQtoFmJjpNnWcx6P//E/C0GxLCbdvgP0LPhmMfIW
	mE77Ng+LW3NjVcUI+tRpU/GwUdcgSKyCjQBeDKKJW6zSENnEXWmRVx9KOpXVijc0GztwdyH3pwg
	XbET5u44a3N0wF32jfABYQ+P5YBauQmzXlfd3gLkqaUVocDvKDj+6k8M0UONBHZH+xhGboebokE
	28P0G2NtY/Djx8ZMXsbJvWlzBQMrGopI6wz+tuxka4H+QtKj6+tje4q43adDiS7Rczxe56DddJ1
	3HNVe0SMlt16cMJ9ZbNtLyRMXZ0plME4GA7JYlrwJN709ij8edfRx/B5DZ7gFHZv+dpb4ZoQEku
	Cp2t/xIVIkfG8TR5eWXzYTQP+NNShX/PpaO7nK1FnqSyTjyag0Hwc6lRGWFgxUW0=
X-Received: by 2002:a05:6122:d17:b0:5c9:a60b:e5a2 with SMTP id 71dfb90a1353d-5ec68996340mr5900292e0c.13.1793714495182;
        Tue, 03 Nov 2026 06:01:35 -0800 (PST)
X-Received: by 2002:a05:6122:d17:b0:5c9:a60b:e5a2 with SMTP id 71dfb90a1353d-5ec68996340mr5900176e0c.13.1793714494007;
        Tue, 03 Nov 2026 06:01:34 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2afee292bsm65397275e9.4.2026.11.03.06.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:32 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 15:00:49 +0100
Subject: [PATCH nf-next v3 8/8] selftests: netfilter: nft_flowtable.sh: add
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
Message-Id: <20261103-flowtable-sw-accel-ip6ip-sit-v3-8-60b5f063f1df@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: BKPZn3fT2L3Wd5JFs0mArgP9u8N67wcx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX7rOfBRdYXFS1
 PissLtVxIV0l/pHr6howFtx9zNDV5L+W10DFghtKzZrlsKe2E5mJ9+A8G0BwMfsP8HsftrlyqgL
 MAOlsQuE1v3+1VK3a6h9A4bBIMOMyBrbpbcl1bzSBQ8jWjicmRTMDKcwZbpM+sa9IEPKtmtuKD1
 l88HQGdwPk0QmteBHv7mx8UbWphZnvt16ky9kebfr6AYvdUctxyMx0Xi39mHO6e8XKm/diZbZO2
 vyjeU5j+zS5Z7bzDLSUE/YsR23DlRk+z+c2eYyoN/T+cYDDQ5Sd2U4y8fyIk/8XBlr+oekUPLjc
 1KqokcYwiRmFd3boPNA8U7/V9pdE9KxvW5JfZ0gDr++fUYLbim892HG4teIfvcRM6paIfOFj20a
 Fkv8+5MpGr9MzWnuIjnxStFu5tvb+ujbb/I+yIxoHPO1kTY36uMmh6ahzhpzufhTVb/o5k60Y4v
 vvaiyiGI5MtSc71siPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfXyvHorRnV8LAz
 R2dV9n5DEzjN9L2U/K7VXwkn7PP5iUeW5ZYPdNHUG8RQCCnKBXLEsiLlJz05YzSDogkcgDj99WT
 n4HDPti0OjGEfG2o9q2490iKjBdOhuA=
X-Proofpoint-GUID: BKPZn3fT2L3Wd5JFs0mArgP9u8N67wcx
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9e941 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XuXj8uMZMfGkPmKnGZ0A:9 a=a1GBzH_hwgqQkvkP:21
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030055

Similar to IPIP, IP6IP6 and IPv4 over IPv6, introduce specific selftest
for SIT flowtable sw acceleration in nft_flowtable.sh.

Add sit1 and sit1.10 devices, route IPv6 over them, and add
tunnel-specific flow-add rules so check_counters() verifies offload in
the original direction.  Append the unconditional accept rules after
the ct-mark counter rule so packets that cannot be offloaded are still
counted instead of bypassing the counters.  Enable CONFIG_IPV6_SIT in
the selftest config and restore the IPv6 default routes at cleanup to
prevent tunnel routes leaking to subsequent tests (e.g. IPsec).

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
index dcbae9a3d92b..efab3854ddb8 100755
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
+ip netns exec "$nsr1" nft -a add rule inet filter forward 'meta oif sit1 accept'
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
+ip netns exec "$nsr1" nft -a add rule inet filter forward 'meta oif sit1.10 accept'
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

