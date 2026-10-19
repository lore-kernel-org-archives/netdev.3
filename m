Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDC4CDA0A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405012; cv=none; b=sZajAkrc/hk0pZaLnmYUtPwoXtkMhO6FJyFRcprKe+t7geLjsKP8eY2ILbJqaKXmjsUT9/Fs7TTSdr7yJJAZ2o1ozWZVbjGf212RZiRT6UJ2SfByZfBXOlHnBhXQt/12fjLwkWY4u4vWYgIC9DAVSunviPWzqPsJhbJDJg/nOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405012; c=relaxed/simple;
	bh=1H0FNz+n80FCown/LZvUyZBH0Hf8RqvHhNNGv70eFqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E3OuiePbE+V6iYAbYtW0bL4uHZJkt2S9Ceu2DOyULusCbtQE7Y7pZuMEaJnD/FXxOq52AMFXPu69sQCxupstgpaucy7RFQSYmnDT1SejdKS/Nq2CPs1q443p/sOl6Iovb8GEzU70Bd1D1rCoAdd54dUaPmIn9ULWFqVpiP/NIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGdbfS93; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VAA1gI2M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGdbfS93";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VAA1gI2M"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Otr13256627
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/TzuN/kAKQJmAhx9QGfrfV
	bOHmKxUQ0A1jrrL3yIsPQ=; b=GGdbfS93mde0fPqQ15LM9FbrpP2MkPyexVDmK6
	u6iXZiOCyRKGbWTPzIKlRFQHnn2t39HbcEjDrZAPumHTWnsljasAbRB4GPqY9Vus
	4KDa4rWfzBwFQD6phj3ShxQvA0AQOYDAu5Jrzq5K07CJm4GqxBNHByInichzOeK5
	yKLeui6XyQLnEc8MfzEileDtvW3W4nuu99+X11lgKa7T5h/pFW/uUwp1D11cEiY8
	+wT9Iwxz9kPswRbLi4DZUqClhSjww8Aym6c+uiCYlJNF85ztG2ByZ+evc82rFvZO
	D2usT1G7DbaP7ReZsKCiuXLhkZzMvdPtmTba3Qq+Afz/DGUg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8k16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:16:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cbf2fd504so336656085a.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792405008; x=1793009808; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/TzuN/kAKQJmAhx9QGfrfVbOHmKxUQ0A1jrrL3yIsPQ=;
        b=VAA1gI2MEexu/k0Xd6GcWWaRejeS7xAzXvgK7+zCMJ0qXvdAmOgo3fcaw3bC0yYq4y
         oJQyJ/Qyua1BEI0OMJVRHIjntjqjYHd3ZpF9TPg2o8CG7G3rAk9bEPJKvd1z6HIQeE55
         yXniYoDlM/WBdrFmB/MmzWafOUsmiYrWoiUPwFKnNbHw4W3VyHtaYPXQ2jPJxrigNttS
         STf3u2lZ31qawFOq1dXyLVV4De58OvkStQvyl7ySg164JS11L061qMxuYSKEkqMLMtPL
         t0hRornl0OYQou+jUjS0bTXoy+ds1q0CsB1NpaQqjaYk7GnE552k13N46iSuacSnDcty
         Vljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405008; x=1793009808;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/TzuN/kAKQJmAhx9QGfrfVbOHmKxUQ0A1jrrL3yIsPQ=;
        b=ztrwpdFY0d4DCiiYgXS69mdT77/3J+bIO6zRn+Z+zyGxEeUbnprE+ACfGh/dmx+dRe
         sVH7oYqqIgzG9rSHLR3eRsaKyag2Jv7KPc8KT25TKu5pJKU28fant7DDqWMaAiKopzQp
         HLNy/xSTNL1hUB0hOUmWjf9zFGWOrGp4WI4QmpdP0tqHRRympt/l1JHTIDou08N0VIV2
         4vinrp9DZZD+DCBe4u4ONRncpWT0OKB4spVQwLWGxyTKWZu4R+tK1TuXLGblUtDlREtS
         VpbobtUdxHNf0Px3k/hsRqQo4xci7jeUJgNvXa5PJ3EBouh1I2UuiI4PPlkvxrjHkI1i
         JwqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzb+2ocM7dVCitDyXKIfIWOm5pb7EPORbA0bv/GDnvxw2JzwHxuB+fZk+8m0lA2fPrqOFxZVMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHgjllptPDZZR6pjqQtI6id2z+mHF5fhtorzp0l/lGJaAz5Lfr
	vr2GC76be2RLXVoxnCWYwpyOIMpg++v0tzf1GVUJ3cdTb4dH6jrpid7WCQsFcoeRvzn/og2Oebz
	jVc3jy+rUgniPiqf7HIpIjXPBv7M6pQicbn9EKwCqGr0DZBjhXr6Jw1J5Z0o=
X-Gm-Gg: AYBFou2bq2d5E5HNHWDgHeeoXkg2inxDP0QltLCBLei5OpBcMKWflJMY3gwfE8YF+ad
	r6utDaPLbfhY26x2y29Or89ZPNKWajoH1jV0NBb1wlgsRPn+v1R2oowgmvbVVnmMTQ43zpgaBGS
	uvF+IvBz0EcNId7TLyyO/3i4B1vVBI8Z4lwJuykd4tS2iubnvpOZJqxMwOIVWLFx8lUTfikc0o7
	SNX8xCpg1R4vFWtPVTvLsn7bRZzz6uSYkDXnd08nWdrz6m3wU/mnQD6///8UZnnZW8duaoGwy9h
	ewKcLQJphhveR1SiI43G2WhVCGUjCgrywXqOcOz+00DjP/G+d46CqdiXrQoZv1wwJjWdFfaJUGy
	VBJNZsBdWx5Ew7Q==
X-Received: by 2002:a05:620a:4503:b0:93e:7939:43f0 with SMTP id af79cd13be357-93f29cfbe5dmr1161424885a.32.1792405008352;
        Mon, 19 Oct 2026 03:16:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4503:b0:93e:7939:43f0 with SMTP id af79cd13be357-93f29cfbe5dmr1161421385a.32.1792405007837;
        Mon, 19 Oct 2026 03:16:47 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d756ce69sm185607365e9.4.2026.10.19.03.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:16:46 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:16:24 +0200
Subject: [PATCH nf] netfilter: flowtable: fix pmtu discovery in
 nf_flow_tunnel_ip6ip6_push()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-nf_flow_tunnel_ip6ip6_push-fix-pmtu-v1-1-324979b15484@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2N0QqDMAxFf0XyvIDtWJn7lTGKuGQGNJbW6kD89
 4XBeTkcuPeAQlmowKM5INMmRRY1cZcGhrHXD6G8zcG3PrjWdagceVr2uFZVmqKkYMRUy4gsX0z
 zWpH57sIt0NXzALaUMln7vzxBGV7n+QNyr8qeeQAAAA==
X-Change-ID: 20261019-nf_flow_tunnel_ip6ip6_push-fix-pmtu-ff81656e32fc
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 7IWV-7ws6o5IUYNoJ4SzWEB3hQZTQrjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfXzFhFJTEZuL9P
 6gb2frRaMc09b0HY3oUdtvO3LFLGDixssQGwiOS5CVKy9FWnQ+D0ZeUrS5Fr3zogZjGcbpPxd2O
 jf066NZKPW+uZh1FgXtAulyAlo7QxbXUTqO8iLZWXu+m4qjdccUY0lB6CoO0rCt70XvgZ7ggius
 NI6ZTwQ9a3mTi8AMGw879RqZ91kJ0IqaRicp6Rxvpbi3Zcg6SuflcPZZtylLhdN2htfy+kLcPpH
 k+fYVR9yz3CLwhXS1K+/BpfwUaKIuiJrjzToHdu++/Vkg3VzN4g07EmRoVehhGXQByZzG7LZh97
 8i6tc46IikFv9OU5oXCeGMLdjI4zEHKfNhCjuutV4kKFUEJ7CDwlFvk717up+2fgWOGj372hJXZ
 Ar+DN1OuC3ntawsGiDqPhckdN9RK1E9+1TofTkQn9ifvZEqyjPN62n4udylu33emQwpWPuntv/m
 b3lO46TzThhPZddXFAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX+TwJusyNeary
 IPRrdzDg4qHWW8jOlvXTlwNxqZhnYW/Y13es58wEYshaUTW/pgQKj7OU8Erw7Nwapp8YJrqGsdj
 P3dMjIaxq0SJ0Bt4vbANcW3S0W+NV74=
X-Proofpoint-GUID: 7IWV-7ws6o5IUYNoJ4SzWEB3hQZTQrjp
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5ee11 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=3HDBlxybAAAA:8 a=EUspDBNiAAAA:8 a=jdz-NEu0cmAWA5xRHoAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=laEoCiVfU_Unz3mSdgXN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190040

nf_flow_tunnel_ip6ip6_push() invokes skb_scrub_packet() before updating
the PMTU. skb_scrub_packet() drops the skb dst, so
skb_dst_update_pmtu_no_confirm() finds no dst and the PMTU update is
silently lost.

Move the PMTU update before skb_scrub_packet() so the inner route is
updated with the MTU advertised by the tunnel dst, as done in
ip6_tnl_xmit().

Fixes: 93cf357fa797 ("netfilter: flowtable: Add IP6IP6 tx sw acceleration")
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index c8c29a9a1684..12faf85ee374 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -664,10 +664,10 @@ static int nf_flow_tunnel_ip6ip6_push(struct net *net, struct sk_buff *skb,
 	if (err)
 		return err;
 
-	skb_scrub_packet(skb, true);
 	mtu = dst_mtu(&rt->dst) - sizeof(*ip6h);
 	mtu = max(mtu, IPV6_MIN_MTU);
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
+	skb_scrub_packet(skb, true);
 
 	skb_push(skb, sizeof(*ip6h));
 	skb_reset_network_header(skb);

---
base-commit: ee2d4c2d7cc18a2cd504044a75ea614e720248eb
change-id: 20261019-nf_flow_tunnel_ip6ip6_push-fix-pmtu-ff81656e32fc

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

