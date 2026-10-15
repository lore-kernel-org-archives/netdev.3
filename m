Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30C4A4EFA
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095396; cv=none; b=MXbAZM764uQNWU8zoJFvQ65YxrsbYz80MQkjZCpQTunqmIdBbCupUkivpzfeq3LJ1BAGxIG3G7kI/gao+118EX3OCSVwrQZWIleZ9f2olHBHD7pyUnKj72Qnd/Dk9Ik+Nhj5dkmrKXgdS2hFMhsc73P/4dOLS7DExG2quCa3+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095396; c=relaxed/simple;
	bh=eN1x+5Hn6/e2k3mEyta1N57gMIq5bpaCU1jvBuWBEeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPXgKfhWzbXdcKmE+bhtZFjwtZeg5GFvgzqhgXXkj0ClXMViFJz4yGmGaDtKbKldTo6o1t2ZGtclYcRkWu+KH7Qw55Lozon7pTWRfGd5i1mbJlSSc0nnzOw3mmyzVd9OA16205q4bbYJ2Vqlr1W585TL6BL/5+2rgpuFyvFx4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=MuT2+ad3; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=tWKLfW5V; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="MuT2+ad3";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="tWKLfW5V"
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FIcBpJ261508
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=6VqrsXHmAsu6I4kcwECb7Utlh4Uu8hmgdnqU
	Zz4xiKY=; b=MuT2+ad3r0Jf8a0TjBJe9yd2yEN/v+ndU5HoYCOlyoK+q958MDIJ
	6p8YjiGaHkTxMrzobeqoviEIlWpB8eemABDKTJNx/onEpDrcS9VHDi+mnxbuJKns
	+qu6EcU2LjFqfR/QVHRQCR/c4IIVEZf+hcMWXt0c95gbAACwbrH6Y6d9Jtgkb/96
	ooFh2wP6xFDzbLbGkchqJaqMvmr8xXjP+obmCRmUBaR486541Iskbtvfawp320hP
	MgCp7IRDFSmH7s1vqM4hLrMqws9l5VMuHbffjP+obMDBc5wW9y7pv8NKcCOOlX4B
	hLnGVHMlcYd3WGDO59Akvb+Z8iBxVaJbdA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hb49m9n66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:16:27 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5337f26ee19so168715611cf.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792095387; x=1792700187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VqrsXHmAsu6I4kcwECb7Utlh4Uu8hmgdnqUZz4xiKY=;
        b=tWKLfW5VSLv42JkOCHr4Q557mtwn/poZXoUTgjz18SFsueeaS7/RqY9gnhEnmNs4vi
         hdLgHbE5WZ54D60L9JOUebvp9+eBD1HlTf/DZqh0qMvuakLvg4ii7b7wtpHfvYzPEhdA
         5ntbuu/lxKXblTlo9JxplwvzXtAt5FAHCx4y+5zpZ185/y/nPm/jtpr2v0WeEJNzpYlU
         Ligj+qCHWkAOoDUB5VFaHYt94i+QXxH0WjD+F4ThAksAurlgKImgX2k/OMl7HsS4BydF
         x1haHKI3nYqyCQP79lX3BICgIy9v7OFJnySkRiBdlSRyzMS3pqz21RiRcc8hiW3CkCNW
         tN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095387; x=1792700187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VqrsXHmAsu6I4kcwECb7Utlh4Uu8hmgdnqUZz4xiKY=;
        b=rGiRSXEnpQiB/aTjNUrjiYaybFNZRN97Gse5uUYEG5+GLE3Qg0CiFV/OzEjrTOo/G7
         0ePnbwlfa2u5fcJx4tllON4clKkqVEuLWrpS1rNjiIfRWf+MBmhuKAeMNaa+MCDPgbwb
         MeANUVCb3qv9LwGWU/9DAPN5Orjg7nWx6mFGyekyoLzu5RNswjsx4/MCB2p9zOs6KvfN
         f92PjHkaoSBnX1YWw1kgAiBsmku5y7R3WGQZTnDy/beYTzpcPGzpoSP6zTGZ6m5auYMm
         REpRsigFyHToulv4skn/pwTzYy83qXh7akcNlkViIJrdXy0Pdz6UBQ2jTgRF3OyK8K7q
         nGtg==
X-Gm-Message-State: AFq9FYIzEgGftbP5Y5pIBILAytWqQah2mLNYPMH0KXlHCe+2PqFIzUL4
	CfKjgfEOZTJ3VIsVuG6Cei/CIj9yiN/fgCbloBTEj9eu1WqGxIT2qMdjsw2jA8wxKz/co2ursOs
	4X234TLmZHmk2nkIq56G62ZAYwZaxDgiDszZRSDVUg+Jn8viBr0f3AYw=
X-Gm-Gg: AYBFou3B0CC55PP0dUQgVbDfGGKtSnNuHDpxg7G3wnv/plWOgv5t7wOb46qdW9x6IRG
	U9nXra6vgk0LGh085sbaCs1sNTVD3h2VMFBPdOvKRQK3DIYTUSt2BLfvObaP65TXi+lraGFZOmm
	PgWIjfZhjgVxbYtrHKxFCkRPmT2F+wsZY2hyEswF7NxqhQFZ/y+sByZ+/7NNsipfJqKsSDVmCcn
	80dTYwwV10DrfgDNBKVhsWwtE3gCcoFOxfoK8Wp9skzNxjsyhK5FkE0qgt9HKHS6TcdR73L91GM
	X2ETtjShOCjInkLtoqQOBinB/iDRKSpsp6j5eG1xS4Rxm0+7TEENUt/u81qmJVmtbwOPsju4Kgh
	D0rrHvoyOw6bG8hSz3M1jSSfo9Lwa9QXgwNYk
X-Received: by 2002:ac8:5d8b:0:b0:535:859c:b6ff with SMTP id d75a77b69052e-5359fac6320mr338755751cf.20.1792095386263;
        Thu, 15 Oct 2026 13:16:26 -0700 (PDT)
X-Received: by 2002:ac8:5d8b:0:b0:535:859c:b6ff with SMTP id d75a77b69052e-5359fac6320mr338754681cf.20.1792095384885;
        Thu, 15 Oct 2026 13:16:24 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-175.natpool.nyu.edu. [216.165.95.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19a3asm2389211cf.24.2026.10.15.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:16:24 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v3] net: ipv4: add zero check for snd_cwnd_clamp
Date: Thu, 15 Oct 2026 16:15:50 -0400
Message-ID: <20261015201549.4023-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfX5XuVGMU6YdHb
 /0maqQca6zxFKW4lOVAc1pBkK5R61k8sa4IRlPrNjM55TzlmTT2lKniqWeIrblU9IAJeF77qYyE
 gkeWofkRrzQk066xjOuFAImH3eI4+VStwU7dtApX73LaDwb/nt1Ydl4DYRUtQ5oXuF608jjbWi1
 Ngn2NIaDib5fDVQ934YOV9YEBTVl8Ye2E1wNqZMlYPfMQcdzMsd0sJbgT0BudYPNPJOYZDwQfTO
 IAXJjAYbrmP5XTOtFOo4SOmdvphftds5taTeXdAqJOF4Zet4qR4nNOJcD6gda7nh9gGd8AU433c
 mGsVKcSSrf73Cd1Y/7HP6lkUFo8+m0F+XJAuCCXkEOLZkOzHz5FHg/biEcdaJFes3hPPVNvqVSE
 BTsS1Xb260B+O+dhGGNARjMxeYY3Ckh3u2oxraPSymDEmjSjIdYi0fnlLO/EEs7AYWJX7apR6OG
 d6Dlfo1bnh0z4o7sHCg==
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6ad1349b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HR2R1zjsIcTlYEo9jw4mrw==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=A3cO9-ABBa8CDv30UOuY:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MCBTYWx0ZWRfXzDGnczFu2314
 GYbO4A7AXXmxrvsfEzkgRZKFaeI7JLxzhpqWCa6BPZuDPvyIsTNLrmilIGOHEepesdwmGl68m8/
 SVzqiSioG9NR0wMb3eCSi9cyhcmtEn4=
X-Proofpoint-GUID: M1sFe2AS2aqRy3Nrjb3klNyDylGSqnVO
X-Proofpoint-ORIG-GUID: M1sFe2AS2aqRy3Nrjb3klNyDylGSqnVO
X-Orig-IP: 209.85.160.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150080

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

Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
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

