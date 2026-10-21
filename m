Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627126;
	b=QLADuM3mB4AJBl1hKHvZDJWWRY8lRETMSQ7ZAcc52GkFJNab1rJf93J6Kxlx4wRffiWd
	 cJqMk5DsDgWbrxX0B2rhL20rCGkwg3dzNW66q66eArvjzcKzYrte7/HoCL4Z44QknMdUJ
	 dInEwxphgQGPlBrdRXs/g8xiRsaVgBw78V7cg0O4rjZcw3U+pgpEQinSRZVYp+9eszFU8
	 xCno6Ce4/6SlewjRlKRN6za1b3am9uZK8Q747D93Mdc1jCldyQbdpgIWF9Mp4YrQ+sT1E
	 nyZmF1a6RVG7v3SEKZjfVaHKDW8zrd563B0BKrVsA2MB6+JHd4b40sp2bNZYwNJcEUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627126;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Orig-IP:
	 X-Proofpoint-Spam-Details;
	bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV6ZVr+/4=;
	b=RyMmhe7Wr57cx8r1FtX3XWlrrInuxOJ/XdFV/dVyDpmnXKDZhgMo8aEn8o+srCgy5prU
	 k2IOG2G9ZJJtfdQI3VX+SGT6KxTGggasmVw+nwFq9CxsBixzSdxarGTU1ekZ20xuP6+bu
	 /8KDLc6/Vqt8YDG/9E6pcw7zu8bSwMvSeiwfvy6BCCzEYKeABBNW5D+TYpHp/1q3SjlQ/
	 xPxh6vX4EET5ArJLgqcs9i0Ig9qQFidiXZqsas1FhJO0DFnOakKqpVcv4FmwEH5oBZ3No
	 DG2rXdfe3OqoWBTcDkRrsHKHQwDdoanxSCzTHKbSRjzO+OcIXzoqOHQXYZIUtdf2KCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=a6Fa3OUA;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=iKFmqBiQ;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0743606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 23:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0743606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=a6Fa3OUA;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=iKFmqBiQ
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LKEh9P3069657
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV
	6ZVr+/4=; b=a6Fa3OUALD4rsno1wFvYCWfxol6f93BK/7jIGkuJwPRRVDp7Hg+B
	vHwhuB2quDUiWyHSn3yJYlg8VFiilOkzJhQxgWJKL5P9cymXCeQwT2f0H0S5Q63T
	yz3qDOut/6kqN6f+M1vRPArcNj6eJPmJsbIwPL9SurwsgTGzoPs61rzPiRyiGJFd
	JrJqYRXLwl7y7RzB9q8S2UiXDVNnWvNFoZ/h/P0DEyMkea7bUL1+TBaUpJqZs/6q
	aYu8zsI0KM9WwZU4Ly2Cz5pTSO35wvv2xX4/TUkr/m6cBnz83It91Ki/fphz1+7f
	8mkRf6qq3w3YgL6kKJuHVUh7Q+WLQufbiQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hf48vawnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:58:33 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9179a556c43so27627046d6.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792627112; x=1793231912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV6ZVr+/4=;
        b=iKFmqBiQoME4CJZuMCqM9oCLLLOFxRlQAiaFaKGJMkT0DKbt3h5b2Ue/N98cR8h8dX
         lRXQ25clRcBufagsaczVqfYMEa/ZbPfZFRs2SDzwqljVW/4gHlix3iAGX9tNalnwC2gY
         rNxdJQCBywE7HWn3sj1BH686YBFjL0pSZdOrWzOT7T/uLH/oazJgEuXJBugazy0t6tsl
         VQdfVKO1qlPjQD/LZuRJVaNclis6eWCwA/nD53hXsQs/bziuvGKGjNfsd0JrW9gjW72Y
         VYOV2XN0ZTKLkVdzO+eM/m1wF0hLleTF40Q3dSpuHVzjH3/M/ETVR7tol9oDk1ZvEOrU
         ODNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627112; x=1793231912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ctT4r30SdHriATAt3tjrtdUslXAqf/DWdqMV6ZVr+/4=;
        b=dtvXX6XO5GQPpKdgeRHas+q1mS8/glmcy7v1H4YRp5E+b4l+pjM6V8t+0tHX5J8ydK
         wYlK//bIaBD6RqdcutH/FCOD9SMmjUZrQfXJIfXtD7MuqFQ24mbCpdoI7VydbUMznJWd
         6w6M4pgHhYtu+tgsupccBOv5Z0MC8jSfrhe3PeQnDXm2yrM3mAzYhzZEp+bBTq6Mf69V
         Kroc81STFO5VLvKOgA8P1ZjfJNLVy9MxvveiGSClq1zml3Y2zsm7JTaF9YLALPgu76oB
         R5Em2tyHkakFEvBugyitrVQrWUQc02ZKXZjT/lu8NpH9MoURvdeK6hwDiYNPKLutxQGH
         HssQ==
X-Gm-Message-State: AFq9FYIt4NjTMIwzMJrQGaLil7YUETwj6saUWrKTdEgIVPGwz0jEyS41
	/PVZw4oDD5qxPXWCK1/p25RbthrYsMu7uzD6gb5j0qlnO193SSNBgVjChs71xohxAQOyY+u8SSB
	pty2xT/1D76DgrS12fW40HssvRJlCEVRFnkjKbkdWBN2n4XSs3svDCSk=
X-Gm-Gg: AYBFou2IjXKChdvFa0JK+i3ETuYgzrd5imy44UYdeA7HYWa+eFZQfGDte5+TY89XZ/s
	Chx46I4rWf3mHVFXtswSCwzTsqUIV7kGi9gqztMCbWySKjhuFzYkAK/nG5LAlyG8o8fSjiTTMyM
	a+IZomqUx9xWD5ZFqZBRMtdfs+SiHdEG5d8oAIlFw+q665hzbyK8U2l8dxDyNeo8u278eHULKG7
	VOXCZjvdbdJY+9bEHTG4XyBVD1ktg9G7/0wXVk7JDChf6vJ9hsTqxANkmuDN8t3QrLSQczw43k1
	p0nj5hveBLsJy/JBGcKFt265PGovgXbxaNPNc1Z2RjNfXscO67liaWVqP44rndSnuz5VSzVUz4D
	FsNvsN6JXrEVemZ5TPjwTG3mySeJVaXabiz4i
X-Received: by 2002:a05:620a:608a:b0:93f:3bb5:545d with SMTP id af79cd13be357-93f57f058fcmr744903785a.27.1792627112599;
        Wed, 21 Oct 2026 16:58:32 -0700 (PDT)
X-Received: by 2002:a05:620a:608a:b0:93f:3bb5:545d with SMTP id af79cd13be357-93f57f058fcmr744901285a.27.1792627112155;
        Wed, 21 Oct 2026 16:58:32 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-137.natpool.nyu.edu. [216.165.95.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d98e66sm387488585a.11.2026.10.21.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:58:31 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net v6] net: ipv4: add zero check for snd_cwnd_clamp
Date: Wed, 21 Oct 2026 19:57:33 -0400
Message-ID: <20261021235732.1313305-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lzfxwF9XwVsAAy1DB6Ho7E4eFwZk3rsX
X-Proofpoint-ORIG-GUID: lzfxwF9XwVsAAy1DB6Ho7E4eFwZk3rsX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5NSBTYWx0ZWRfX8a9EffJlwP08
 dZPB0k+9rKRu3YhzP0X3BcEAC41TxASj2y1aCFbzZPtZUqZE/zgZaO1EMKGJDRtUUyfdi7sUNaw
 cyUUbzPBFnm2m/jdrZpxPsL2e2/EuHA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5NSBTYWx0ZWRfX025FwP0hzPMK
 72W8D/i7ja+d4KJpqMGNh/i535njwjF1UmS2zb2a+rehmhWxnR5KGhfV7YModq+L+u/o3K5XY6X
 hPaxhcwwoUfG4VeROKahyM0AWCxiUoS6P2grKO6PgP79x+FYr9yi9q3L3L4qzofkYHd+it2UmtK
 2js+KJBepRORNRbyFrMB2GzaEI17g3Tujh04dQCTBKTlfNcA4LYefWm5nAxt67SL8fT9QLsijCl
 GDsBvTVi+RxtjbIIDIl/LFGAgC0RXXdX5J56cCqNLPcscFZIcMyCyQ1pDZZCb3FWcYrP/6VmKA1
 jPqleY2U8Bn3o0/nsiKFb81XOquY+OG/beFCw/LxYno3LoDSg2s7vSuzAVOf2XJZlZRsNIyRbqV
 Yo3Vo802/VegRhgNWLNqh1TztlqP3mQIJP9xwRx/goz+/MB2tuWeln7IQGFRnQO+bt9RplTipZt
 VCYvlzlrVqgk8hGjcNw==
X-Authority-Analysis: v=2.4 cv=HLtWhYtv c=1 sm=1 tr=0 ts=6ad951a9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PTGulf1M+RQ7eJaEhEW9rA==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Orig-IP: 209.85.219.70
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210095

When RTAX_CWND is locked, user is able to pass 0 into it.
This could lead to writing 0 to tp->snd_cwnd, leading to a
division by zero error.

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

Fix by checking if user pass in zero as parameter and if lock is present.

Fixes: 814d488c6126 ("tcp: fix the timid additive increase on stretch ACKs")
Cc: stable@vger.kernel.org
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Reported-by: co+71b6509cb791e531@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 net/ipv4/metrics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..4052a90249c6 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -60,6 +60,11 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 	if (ecn_ca)
 		metrics[RTAX_FEATURES - 1] |= DST_FEATURE_ECN_CA;
 
+	if ((metrics[RTAX_LOCK - 1] & (1 << RTAX_CWND)) && !metrics[RTAX_CWND - 1]) {
+		NL_SET_ERR_MSG(extack, "Locked cwnd metric must be non zero");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

