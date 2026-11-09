Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242259;
	b=UxInGjipmNXqsU3iLW59qAAYkAfvLO3WDx0HaawVYhYLl3aElATzokyD3h1bc+ooFBdX
	 8v7xiVbSYm6wiHioZpBsfUGrge6QaMFv125hgzQzMaM5cCeXrW49BOv1VI0Qjd0leGmq3
	 oK82tt2UI7M9MppPRu+NoqQfS5Wg3a7gTrZ2JhmIv90UPqdlw8VJ7vZT+iJ2E9YWM37XI
	 47ZHAHVLkY3GpGF1sZy1d/e8NbwiYSFznjCLnGbT1+/CfBKtGu6rBDKOSk8QTX6RORZ9F
	 gjvQ36OCNst6CqPHa1uxasg7uMcngk3/9/7tHuu3TDzfLGu3G4Fmq4p5cTw2SvswcvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242259;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=R6+n4qgJweGNi9FjUdidewFoHidB+VAbbiGleNpklWs=;
	b=yOcFecfpBez9OF4IBRi/dJAzyAA9KKMgN1NAFkgEibA2iirB81n7RXc80Y4dDDWPNac5
	 sJyEwgJ1ivy2W33VuxWYnZg+N98Sma0rO7HKXj/FBt47yzuEwMx6/5KVhMKyFtnzdQIQt
	 bEhA4BE0LAOj7QUFL5YK5I0lWWxGPSVJV8GqWRH28baY0WhK6toG4EyFmZ5Ec4fLd9ItZ
	 SDOQarNVvdgNlsZsKEjq/YzI07haQplJauGjHaqt7iIyakHcr290E+3idc96Ofh7hqYYf
	 WH/IbW6u5dMGkTHPFf0H63BJXcoSXEopg1182QFtS8dj16R4kdz16zfocMDAtmDwnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VCP6p9Wt;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F0606A330;
	Mon,  9 Nov 2026 16:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F17F0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VCP6p9Wt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R6
	+n4qgJweGNi9FjUdidewFoHidB+VAbbiGleNpklWs=; b=VCP6p9Wtpi8Ig4myXP
	XYv5+JLHbJ85yTa7ezI6uhY3bm4cnNUGs1KkA1zY/Jw4Mv9hkoWGFnXlZWGnJerP
	22GFZ70WVapJn7FDFMJot2+7+7UMs6df3AEA+ERA0dT+76wZnxXVYs2zFDuxoge9
	MXWH8lvGLv/p5TQMOPmDdumAs=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBXNBCo9vFqxKdbGQ--.13492S2;
	Tue, 10 Nov 2026 00:36:56 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: sch_dualpi2: avoid double memory accounting on peek
Date: Mon,  9 Nov 2026 16:36:55 +0000
Message-Id: <20261109163655.301509-1-shawnq1@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022144758.65248-1-shawnq1@163.com>
References: <20261022144758.65248-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wBXNBCo9vFqxKdbGQ--.13492S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1xWry5tFyDGFW3tFWxCrg_yoW5GrW5pw
	s2ga15Cr1vgrsrGa40qw1xX343Krn3Gw13GFWxJwn2yws8WF4FqrykK3yUWFWxCrn5G3yf
	JF12va95u3Wj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjYL9UUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbC8Qr+DWrx9qo-SAAA34

qdisc_dequeue_internal() removes skbs from gso_skb without invoking
the qdisc dequeue callback. Their truesize was already subtracted
when they were first dequeued for peek or requeued after a transmit
failure. dualpi2_change() currently subtracts it again while trimming
the queue, wrapping the u32 memory_used counter.

Skip the second decrement when the skb comes from gso_skb. Packets
dequeued directly from the C-queue still need the accounting here;
the L-queue path is unchanged.

The issue was identified by LLM-assisted source analysis and
reproduced with a purpose-built rtnetlink/AF_PACKET test in QEMU.
The test uses CAP_NET_ADMIN in a user-created network namespace and
CAP_NET_RAW for its AF_PACKET sender. It does not modify the kernel
or use error injection.

On Linux 7.4-rc2, the unpatched reproducer wrapped memory_used to
4294964992 and subsequent packets remained rejected after restoring
the memory limit. With this patch, the counter remains valid and a
packet is accepted after restoring the limit.

The modified sch_dualpi2.o builds with W=1 under allmodconfig and
allyesconfig. Full-tree W=1 builds stop on unrelated warnings in
lib/tests/stackinit_kunit.c, arch/x86/kernel/callthunks.c, and
net/8021q/vlan.c. The QEMU regression passes; tc-testing was not run.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Link: https://lkml.iu.edu/hypermail/linux/kernel/2610.2/16461.html
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/sch_dualpi2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c49ef..ccf6359eeebc3 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -909,14 +909,20 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 	while (qdisc_qlen(sch) > sch->limit ||
 	       q->memory_used > q->memory_limit) {
 		struct sk_buff *skb = NULL;
+		bool already_dequeued;
 
 		if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
+			already_dequeued = skb_peek(&sch->gso_skb);
+
 			skb = qdisc_dequeue_internal(sch, true);
 			if (unlikely(!skb)) {
 				WARN_ON_ONCE(1);
 				break;
 			}
-			WRITE_ONCE(q->memory_used, q->memory_used - skb->truesize);
+			/* A peeked or requeued skb was already accounted. */
+			if (!already_dequeued)
+				WRITE_ONCE(q->memory_used,
+					   q->memory_used - skb->truesize);
 			rtnl_qdisc_drop(skb, sch);
 		} else if (qdisc_qlen(q->l_queue)) {
 			skb = qdisc_dequeue_internal(q->l_queue, true);

