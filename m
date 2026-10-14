Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11A483BF1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007823; cv=none; b=rEhFZYGFt1ky7pNfgop/E4fUXy+WKco+N2/UT7K7cvDZvXgodWdhCawhM1VRbGb+qg5PMgfy7e2O69aSsnpmSQV3NpEdK2Y0a7Lpmnd4f2FZgXgbqGD/JcSZ7xwmK8pSs3onmmu0L4d2ZDvv7cSX6BpPdbuunyQxgc7nnJnSmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007823; c=relaxed/simple;
	bh=VxmCR6RZG34puMftg8s03NryxNCg7LImLRc/GRgXE2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDTZ6iwCbXo2+Q4L1EaSpbgwoAEMFMg/c/5z3JHvrjEYJ7yIKOysW4PrOTmgICmtmBNLxAg3ES7ehOha4QEk9wbSRFwP8aL3vWMPQAowAsIOeyf2gGSbBRKps9eSjJ3b/9pdAwtAhNzYKBGXV6jtmdw+Aq937mTDg+BrVlcBf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=y4AE6z9P; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=K8Gin2S8; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="y4AE6z9P";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="K8Gin2S8"
Received: from pps.filterd (m0094546.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIbJDn2507786
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=dm3JPEpVSI8PQ0BF6xKoWaANpbsmtysnXtnv
	IY1XHD4=; b=y4AE6z9PwZWkpayV0uaZbMNPd9zqnbW9JVpKQns6vJ3YIzKTM2KG
	epvzum/sRrsdfGAZMWz5gW3/sVjMqH80QYHX3Ugcs91XwchwvwhOAH/FJc4pOfpy
	uHXIlbwY1/xHhqt7keateQ2qfrTRMQu21o0e2WoerRBj65T7DYEDyv+3dsal+pvG
	hUoDdtlbx2+H0lIq6rRZvtxBXhSHoRjcb+Oywisobmg86MwheqbRpfKiNjlpWpj5
	lejiby1ldqwA6mifaSdmYkFcy/KlEX89t7bvZa8e24qMOGuUE/CbL+XKtN0YMWs0
	gpLYxsmqgs5/xqikcDSQyhbGX84OJeC5tw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4haf65s915-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:56:54 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9196b477c4cso112649686d6.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792007813; x=1792612613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dm3JPEpVSI8PQ0BF6xKoWaANpbsmtysnXtnvIY1XHD4=;
        b=K8Gin2S8QCf9CyY68CWBvqJXFZRrplB04gemjmwcl9qiMSxybuOZPr28cKsuQP14qM
         8AU0cp6Y8wvpIUy4hQk/ccZNRN8ij6yA/4EA0GrG77sNNTYyS1cgZfn2E6fWKTCZAYOG
         Jhu9zsHMnNr1XBg8iSQmZZFD7OPyuiFJR9zja7+p7EFY5Hlkkl2pf5J63cl3/yA9PaYV
         eqnAIs/o6VuQEHLeRSbt6ngboTDQAtHbDA/iCc5+BX6M7g6bJahcGEEiobqtTDCE96Z9
         jY6T76k7Rg0OQvx5m4R6pqCOwNod5GS1MT27nW1hWGByWiRgMerLj2HeQyOASkrkZjxC
         QC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007813; x=1792612613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dm3JPEpVSI8PQ0BF6xKoWaANpbsmtysnXtnvIY1XHD4=;
        b=kG2PzH+ze83IUFLwhE60u6tYYGIfQf25PtLun3TPoY18d+JAbLjdex2Yjcn39okAEq
         qce8V/TVozw0nzV5o6N15SHsvMkkKK9hZ1UCNVwWKZY0ixOZbI99N6nxTm5+kmpeWJAM
         AfZy+635ZUGvHrJiMphzz5W9Qmo0H6a5npALYUtcN6AtYgaOyuMVtxDrIT2j5MBWyoH0
         oL4B3l6RZPSvNGPB62z3BkrriR0gYjkuIiOJc+G9WsN/U8DN5md+RncoyPiglpr29/dT
         k8j98XjD3qVQLDGmlH/VE8+ObNLLvDZuJnxMSVIwM3Kg0giI5A8MDf/uzVdWrnrr8IuK
         zRjw==
X-Gm-Message-State: AFq9FYIR5p8VsV7p9p6Xa3zG9YWirJHLVsUZHq1muCIeIaNCcyQz4wqi
	BKT0OLA/i9htZirVpZScxE9QWNm2V4rAovpA1Ycw5YT2TEReEGbZFDMemZaW/GbNqh1GEZCuRXA
	fda07fT+qFMZe2R6LfI6ZY+hodqwGqqrJzR/Z9bP5bIi8V5y63ZBc/JA=
X-Gm-Gg: AYBFou1ySPSOwIBP5NLUYrB9asDpf0O1B4R4Bda5H0VYuNvuwN17T1AR0fJ3GEZiiPK
	CgWbdFPT/ZT2r8JEbXYJzwxUPLqKylO1+UZNJqcjANpxaZQauhrkrQnnSNZ58zBvx337pganHvg
	lJO6/fBhrMNN1SfoiJmBZBtY6n1K3FsBOWn1RG0MwOxIjHSKyVFZs3B2ddzfkg7zcD99HPpQbqE
	m1S+KgjxTg9OgcwQMCkD5sIaLsBYqnKENKUGrXspMF3V3s2CnkdfTd6mR5xxSaMXOpEj04PwkJj
	a/gp77ZTFmCPJCSkT08dCFMQ5Q1cQcXTI5FEvb9ZA0YZVGOxAQRW6Dw6Zw6E8DILHzsA68sRQ+V
	TpNXSiz2gALl6nyl8MFGNx/TW6UIIC1iDOADJ
X-Received: by 2002:a05:6214:4586:b0:917:7cc7:8768 with SMTP id 6a1803df08f44-91b53a5192emr265642796d6.11.1792007813463;
        Wed, 14 Oct 2026 12:56:53 -0700 (PDT)
X-Received: by 2002:a05:6214:4586:b0:917:7cc7:8768 with SMTP id 6a1803df08f44-91b53a5192emr265642296d6.11.1792007812796;
        Wed, 14 Oct 2026 12:56:52 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-143.natpool.nyu.edu. [216.165.95.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b383dasm61171016d6.8.2026.10.14.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:56:52 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v2] net: ipv4: add zero check for snd_cwnd_clamp
Date: Wed, 14 Oct 2026 15:56:41 -0400
Message-ID: <20261014195640.430824-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfXwrE6255dBbQr
 P08Zz/KiTLF2yJwneLRm/U91ziz+SEZ+JYIjiCWigymz7Lut+25reLENRktvUijNDgQjYqk4Eif
 zD2SEfcYoQPhBoPpNSSOV7tKQy2wEF9Zd1/a3J3plOHiKnU5GuT1Syj8J/fjzq/1EPEtLvco08k
 hXnWQ2jB57swoKzDB/HnLC4Qk/2GuLaP26OGMI3KWDfclVuoU5q/ybnjuOz6rdyxeWZ5yFJ2czZ
 NepvR56Iv2iHnbbXZSFEeLIE02uTUX88FOaV3twwMTi1u+peyWJrh9bsLDpiDmQooL031tVTHLZ
 VmFmtjlQAv8VZsDfRZCfM7S2NiJ2Yo0D7m8A9f+R7f0r+NJAn0Nu1WR9cTVNQ2wtRuwPpDeA2c5
 FtEYVnk0V9g+utXapV+zkslV/S/alUh3Gf1gZHBTxFbDOHBWGhq0cZFz0uI0xXs68FKek5QCqeM
 bBNo+93zxKwkksdGoLg==
X-Proofpoint-GUID: -GPKCvqzXrN5qsc6gaG3kLcY3gm1g3b2
X-Authority-Analysis: v=2.4 cv=Vd5ir1p9 c=1 sm=1 tr=0 ts=6acfde86 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=iAeFBqZmEazvcMjDlvn68Q==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=T67y4n-0JBmO_r8OIWtK:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: -GPKCvqzXrN5qsc6gaG3kLcY3gm1g3b2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX3lHpjFr7u3cY
 hc3KkqXpD6ipaZu00GhUd1uwbeWsDmzP7P5yNYORRFzhOF67Is4FLTBYXx6WRfgLoWI3mI7U/mn
 eWzwkQLop9FEUNlj5WJCqFfWMNN1ams=
X-Orig-IP: 209.85.219.72
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140079

User can pass zero to snd_cwnd_clamp via RTAX_CWND type.
This could lead to division of zero error if not checked properly.

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
Call Trace:
 <IRQ>
 tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
 tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tcp_input.c:4440)
 tcp_rcv_established (net/ipv4/tcp_input.c:6685)
 tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
 tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
 ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
 ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfilter.h:319 net/ipv4/ip_input.c:262)
 ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:492 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./include/li)
 __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
 __netif_receive_skb (net/core/dev.c:6410)
 process_backlog (net/core/dev.c:6761)
 __napi_poll.constprop.0 (net/core/dev.c:7830)
 net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
 handle_softirqs (kernel/softirq.c:645)
 __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:758)
 irq_exit_rcu (kernel/softirq.c:775)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discriminator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)

Fix by checking if user pass in zero as parameter,
if so reject the value zero.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Cc: stable@vger.kernel.org
Reported-by: co+71b6509cb791e531@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 net/ipv4/metrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..e83a129a25b6 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
 			return -EINVAL;
 		}
+		if (type == RTAX_CWND && val == 0) {
+			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
+			return -EINVAL;
+		}
 		metrics[type - 1] = val;
 	}
 
-- 
2.43.0

