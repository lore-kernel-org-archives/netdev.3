Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448750;
	b=mS9uqEcxoxcumL3zlnLIcKlgc9Esgla3NQBjV+qmgFPFHmwfNvVAulSXGIVsXlMWr5of
	 nGrLMsE1yHgzKCmDXMW979sqlhrU9bt+eFjYRQEYS75iRZNKWChKPczjXrL9qJDh04RFn
	 630bcphuKGI1Jf2Q2HjMTtRdkG3lp1XNfSyhP/SlgTOBWmKPgtYowQrk3CwtEdp7rh2Xf
	 njSSuDcE0rQN7STzwWu5bb6z8B5gZp4s4UzZuZcOJBiwBW+/CFtipuZsV/DOBZ90pwoq2
	 vhggHTgPLZ9gVbC2kuRkluX0YexTOif6cO4eqfF6+dqxp5NCqjH+UrvmPWsj8q5fTyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448750;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4KnzCmYag=;
	b=SQ5bNPgaJwuOeNZMdWtNMMTBm0WEtnmmproRifWcbu/MZk43PgKs998Js5kbWFQ9c74Z
	 kh67z/Qv+JBB6cHsjYZlVdk23FM54a9lzMPt5hnqDKkGvtHSuLmMvQUvfbXwlL31MyHaD
	 QV872Wub5hXLT8xOaEr1kT7xu6R5clcLV1yq9ccxP48Tt1BmoQumxFV571QKZHiGG8ibO
	 zWAQvmsWH6CZt0OEOfWsNviXN+DosUlXLndLIw6u2c0jjrGhRAlulz7L5P1A58LiugOnY
	 Qnmaq93y4hzOjylvQPuf5B7Uo4b/e/tb+TYaa616mASkPZg7I3eRkld2Xi1JNsnJzqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=y+QFTAU7;
	dkim=temperror header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=H3ZTe2Zu;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA73606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 22:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA73606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=y+QFTAU7;
	dkim=temperror header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=H3ZTe2Zu
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JLcME8320074
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4K
	nzCmYag=; b=y+QFTAU77Tn8ATA2i+mTXvVjb1amkAsQrsHGuLSJX+lmuDwbigSg
	bfsdv1O0rZVoChfwfz5urvEcu8TckVfXX/5hcU/7NYp/cl4WUOipeJcm9HcAz4Xg
	+G5ALKvw/+YHC9/8HQqgR4O50CehHZaO+YPluDhKJme00q5NODrIUHTl5dAHr9fI
	rwe+72Y9fcK2jxbfSJmAWcrD9dfzLQq+TWiinTrVXtkwP1isSNS50/o+EhmmMtxL
	EMOL2Kpi8T92iQ1fwUy9vuLJ7Fm7hWAs+3N3e0EP1FhIlUdtCwZhOZLYI+SoNbDP
	ZZUrB55/q5Kjg8pVBZZgsuER6P4vyWjcmg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hdua30k1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:25:36 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f20addba1so491608685a.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1792448736; x=1793053536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4KnzCmYag=;
        b=H3ZTe2ZuXlKQDzJRe2SAUWxM2592O/pn/x+OWe7ZUgqSWwdAQK8R3+jtzHhU7MvAmC
         pDEmk8393ISa2njkew2PHY8tswIOkGTm+2dPxRsbNqWv7GGBK9ntLznSyHTKL/iuHinf
         L6Q8mqREp3ziZXgiWaHTiEhkJx23Sn72hZGEgB92N1NiKp0/PXvxY5VdELYuk/m9ekcn
         evOXAIxOtbtzyQfP00FMutgUjVdN3SEybLUN+CR7vTldpchCoup+cIHoALLzv4szaUz4
         muig3Nblg3/O6FNIAAOU2/HPzW4E3Z/e01OtbQ+DAlGgO4TUp3CMHi+nMKWMK494KccP
         xMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448736; x=1793053536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnuswPbu+Jp2bjPIKsOTDcJ/wnKhhsaCrp4KnzCmYag=;
        b=nEcyJfCv+3/SKCi0YBtZQD8nKXN6e2I89vPONIavzlskGVWVN6/zE7A4iYXhCn2Ywg
         PGI9QiaJUpshBWUHaLyPLyZh0saLDIsTM0t2M/H5gcMZnSTNwrR8vNjxLQTTt7kCdtrM
         zy17ePkSsPB+O5FUsFgQxW6/NW6kDz66IytEmUGYdhppAoWoYS8qegHPfMdZSj1z3661
         lyDNCE1F6P1LLK43N9IuWr/SL8sx9rVbW1kkX44fW7+dXaNqsUsgO+M+QAJ95M3lsUiB
         YakV1ASrB9H3jYOV4lp9Z/rdDmUGg5tqUENXa3/44qGwDAj/qLzFIpk4XGY/Q/RphBrH
         9K/A==
X-Gm-Message-State: AFq9FYKshNXAPga3OVRyZuc4RwY4ilz1bQ8bIPADcplQ2w8xtZHAa5k8
	yjO/CMZkYKYuOzl3q1Nm5yj6yqH1KNF/ZVxXZVFGnSh379ooEwCXd2IF3X8rGyKuO4FfofdNDhr
	NtITG/MToJToFGuuCU9LV9WjrDJnt4tMaeRXAXga3cL0JnOs9CC02kHk=
X-Gm-Gg: AYBFou3L3svv3J1eGA83C7OB+a2frca2ARrJQu5k/UtrhW1onLYSu9yLqg4ZyD90QXY
	84Jey+pgXgPCgBRvwz/1FLBx1QlmSe4nVEYFFWLG+pwZ7hzVW2TU8V97vf42o/0d0HWTLj1OCVy
	20oGcQdxd8SYXuZ7X/jFfg53vj7g0BuOdYFBWXgVBAq1Os3aosW4nnco5gT8iN5agFQa5iF8XSa
	5qPGMctUWM792DxYtCenWf1+aliAefSRQsIn2i1y5+drFM6neB1Ad7DSAKlZ54kCeKDXj85yNAU
	4sf7Vif2S5BQ31/+rQgbzKNJiD8qKnYUYyDCauZsqzgeZ6OF6g9D8kIi20rpyP+wlfoHOHxwl3C
	w0mC8FsQV4SDh2cDjyD02vuNOVtvTw9pmX5HJ
X-Received: by 2002:a05:620a:3949:b0:93f:175a:f4ce with SMTP id af79cd13be357-93f29dd7b2bmr1657518085a.80.1792448735840;
        Mon, 19 Oct 2026 15:25:35 -0700 (PDT)
X-Received: by 2002:a05:620a:3949:b0:93f:175a:f4ce with SMTP id af79cd13be357-93f29dd7b2bmr1657514985a.80.1792448735368;
        Mon, 19 Oct 2026 15:25:35 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-167.natpool.nyu.edu. [216.165.95.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c06e9c82bsm1643376d6.24.2026.10.19.15.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:25:34 -0700 (PDT)
From: Kaho Jiang <kj2864@nyu.edu>
To: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        edumazet@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+71b6509cb791e531@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH net v5] net: ipv4: add zero check for snd_cwnd_clamp
Date: Mon, 19 Oct 2026 18:25:31 -0400
Message-ID: <20261019222531.1073-1-kj2864@nyu.edu>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX2znEqV3m+hCg
 a+HKL6cKbpKXNEx8XLpKr3t4W3Psww/22KwDXYqgAexTHGy7FnfNF4Ru4G8AF/nQFU3pw0Hah7G
 KLxp5P5rhk2JY7VlNt/VWNpCXm6Vy9Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OSBTYWx0ZWRfX6vwXrzFXvY3G
 eeUqZm7X08g3ZN7Z2iLIKM63y6AcwIoBtDxnnwqmzSPtWsQYkJwwJD2uqAWVJmFaGVeAw4eZo6t
 gZWtY5ITnl3iV4vY6RKgsxwH9gBEIDloy5US9Ra3pRnmWVw/Tg2JVMm2YayxZhTA6Mr6XD7ZlVA
 /YuHigBh/Ann05wrcv00lTeGnuc0kNt/kX8f229ITs8xJ/h8tMsaZHxUNtQ48ZRr4ZIZ2xjElH8
 b1JKcOH2ynPPE9dwE6Nt1Xt73R68wl+XOH+WO3KlGjh6cgiaba0cQrDfS7Cq6xc/8hhaC2QptmM
 TpUi563OAUnYPcqU3xwd/cNWRgty1prNeokxGRM7yjrJNUNaBJExD0w+or3MlyTuu7XwcUTZ0r0
 iz4WowSBVc9GPCb6TlFAyEtpTwIfjsiJsJpOzygeIbMiFhFZQXxd4H3MTR1DkH+/qwmpqiRIXXh
 F+SOZZCi7nJ0LCCT9wA==
X-Authority-Analysis: v=2.4 cv=FdqiV5+6 c=1 sm=1 tr=0 ts=6ad698e0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=yOGPcoH5O6SU1yo2J2Kppw==:17
 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22
 a=VwQbUJbxAAAA:8 a=qtVHbROC6xTCA7o1MbIA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: B90w4uardyQk3_XvXZ7fGXr0uPZa5rYo
X-Proofpoint-ORIG-GUID: B90w4uardyQk3_XvXZ7fGXr0uPZa5rYo
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190089

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
 include/net/tcp.h  | 2 +-
 net/ipv4/metrics.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4416cdf9bf30..9f605d9ecb35 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1522,7 +1522,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
 static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
 {
 	WARN_ON_ONCE((int)val <= 0);
-	WRITE_ONCE(tp->snd_cwnd, val);
+	WRITE_ONCE(tp->snd_cwnd, max(val, 1U));
 }
 
 static inline bool tcp_in_slow_start(const struct tcp_sock *tp)
diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..cb36686973e5 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,6 +54,10 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
 			return -EINVAL;
 		}
+		if (type == RTAX_CWND && !val) {
+			NL_SET_ERR_MSG(extack, "RTAX_CWND must be greater than zero");
+			return -EINVAL;
+		}
 		metrics[type - 1] = val;
 	}
 
-- 
2.43.0

