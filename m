Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D243783DA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155240; cv=none; b=ZfClH8TLd/OmonoXfbW/UFix3aTYU9DcOtlgGCVF2kJQbJm/K/CI74PkiW0svpUepOooawGzopFladpRX780DwvWpRjyHfu4XHthdPjusNG9+d4y5rxvR+jttGLNVWNP19RLlVsUW7CuMsZTYE8p01Zkkpsb9GtdT/3TWmQdy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155240; c=relaxed/simple;
	bh=x0dFJKQAR49NfJ3HHSp47oKtiYwxgdO99oLHzu/ZspA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pisv5DWBPys8l/eOSFqzWTs3xnoSauFV8eDU3LunyVBad10WtNjQiWte4YhhkhykMbKS5bEJmZONltoo1ka0GXnA1Nk9PNerR+8wojUox67cU4STpnEiAWbUeRLeQnzawqQ//Evbf8BIBfAFHcw+qgWNu+4A21zmuRlzwJjmX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoItlbfi; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoItlbfi"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8887c0d3074so217233486d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770155237; x=1770760037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T4y+5zFMjm8u2iN2W2YWyaMu/sTq5GANfFLmTyrha9k=;
        b=AoItlbfiNn5UceK9F9aRn+kcU+HAK0ZO6Ydg017FMGjmgvnRCmlCJc0p4wHNqRg0sM
         mdj2/KgjKwY4tIk9BGbPWLB/lYCwhIqbQAVWIT33LxgIIdMKenDtQ51vHG83gExoj2kd
         JkXTHYpqXBp4jVudKkxNmOjjl479pIJmIvUi0nJQbLrrlZvQftc8pYTaKmhI8Lec4nPz
         c85eP55cAz+xwK3SEq7v9rmJd6yxupTmfo4aGilHP2d9bmnonf7+rlorzP/XD7qqXjXM
         gdhuQqsyUXg804mmYm0dlSac3WpdRaMOggLRZxXg0N622LqoE+LItQl28TdDTw2MhBWW
         kSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770155237; x=1770760037;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4y+5zFMjm8u2iN2W2YWyaMu/sTq5GANfFLmTyrha9k=;
        b=oLHN7GJ/Y3pTasyVvH/SCZxNiBJuUMmr958rJe5ZyIX/aME/h9EZsugGw9vDVMIbJ7
         LWnkkwfFTK9xkpvITtvN4jSLdWz0jL9Z1F28/6nV0JdA/Bln12Bjv05PkfiSRFH29ZBf
         /LtyKhMWIxWhTX9ig3LmREe+fgzufJ46/MyKzvPTNMckFk02PZr66KT1jeluOB8v32FU
         39wofOrwEpvSSmpSzaAAv+pDNUDQ65gN1AiPy+O5nYPTwtQwO8HoouxuuLYugH1/695a
         aYOmsBKauNJqJVFNLTlVGqYtdDW/MGWlJemqqGZ49a4mKoXIIiEzPTXIvmcflZuupFyq
         Hcvw==
X-Forwarded-Encrypted: i=1; AJvYcCVZuOITHtEH3Kzb1mcyKnGGcppYCjuUq6eCI5JFae7EBmclP3QHL/1s/zDNRtBVSoZbhXmNLoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchtF36o6ZXCqvf1KpIgOc7+yiC2glkiqPUouS9TDlZIFqD3jQ
	GsYaYCURNCJEPe4t2yNn0emzWjlGVQREwRC7gMPaUctFc1qzP1tebbgCWans/EfpXyJ9Qyp8d0x
	ejrqbPnF5trC50w==
X-Received: from qva5.prod.google.com ([2002:a05:6214:8005:b0:894:6e1f:6a36])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:76f:b0:895:b3b:224e with SMTP id 6a1803df08f44-8952219bf6amr13833906d6.37.1770155237642;
 Tue, 03 Feb 2026 13:47:17 -0800 (PST)
Date: Tue,  3 Feb 2026 21:47:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203214716.880853-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_fq: tweak unlikely() hints in fq_dequeue()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After 076433bd78d7 ("net_sched: sch_fq: add fast path
for mostly idle qdisc") we need to remove one unlikely()
because q->internal holds all the fast path packets.

       skb = fq_peek(&q->internal);
       if (unlikely(skb)) {
                q->internal.qlen--;

Calling INET_ECN_set_ce() is very unlikely.

These changes allow fq_dequeue_skb() to be (auto)inlined,
thus making fq_dequeue() faster.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 2/2 grow/shrink: 0/1 up/down: 283/-269 (14)
Function                                     old     new   delta
INET_ECN_set_ce                                -     267    +267
__pfx_INET_ECN_set_ce                          -      16     +16
__pfx_fq_dequeue_skb                          16       -     -16
fq_dequeue_skb                               103       -    -103
fq_dequeue                                  1685    1535    -150
Total: Before=24886569, After=24886583, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 6e5f2f4f241546605f8ba37f96275446c8836eee..d0200ec8ada62e86f10d823556bedcaefb470e6c 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -665,7 +665,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		return NULL;
 
 	skb = fq_peek(&q->internal);
-	if (unlikely(skb)) {
+	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
 		goto out;
@@ -716,7 +716,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		}
 		prefetch(&skb->end);
 		fq_dequeue_skb(sch, f, skb);
-		if ((s64)(now - time_next_packet - q->ce_threshold) > 0) {
+		if (unlikely((s64)(now - time_next_packet - q->ce_threshold) > 0)) {
 			INET_ECN_set_ce(skb);
 			q->stat_ce_mark++;
 		}
-- 
2.53.0.rc2.204.g2597b5adb4-goog

