Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C12841D137
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227633; cv=none; b=XSm7eeP/VTwd9bT+yJ30IH27BoEAuVgkYoNKgKiDYMmVKq2784cZ8InLdZOCsDQlQLUtYkddf8q3BEDh9AV4xaJNYjabWufhwN/GiwicSoG1OKqUeFKEubk1Kjvy+1LnbkSyp9EXZ9x5pgU7/h/2ZnbEBbIvjC5hOLJ0YOWJuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227633; c=relaxed/simple;
	bh=Fbr9dOk1RewjMBs1vgtBRzWLtklyr348s3NTZHJ57zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/qgoeqAcSkNef0G/j/nokU2i4o2S4l4BbZDBROJ5i6Tuw5HfaUm5uX83HfHl2qlaWREedZnsz4/T5YngUDvAYcctZthYrt5Unf3pbgkYhCGnoj8iQjGceBUptC3yhkNVEIHW7kScyu/jsa+2xpWpIHZrHk91b7lveS1+8cvmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZreduIFB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZreduIFB"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836cbcd0a48so32277977b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787227631; x=1787832431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdskbMIUANv/v+/854sOfwN+OhmEsWhVMVxtO+b+CEA=;
        b=ZreduIFBqiQSTwUaOP14hSBuTH9ny0Pgx2W2+LEKiUA/M+dzA0punR4N3cnmb4IdDj
         F+oCtS7wJo/BHeEB82c66T9X7auJS7u690HuqAW9vTj8174p3Y801kaPCbZ/fJBg59xm
         2PiOmm8PUBntJvDr/5lE3ypZnd9pEvF7mzUxODo6UPUDJueUHumvGxLBMLANZu3smXuJ
         b0spgEWJB1ODR3ucLz+158s2cqu58vaOJ1scx/RgU00DCOxoMdtR/VBb8oKN/STugh96
         wnHZB89/dSUqXHN9pD31C+QdBDqu52/g35pqmg0+Az2Vq8YnIHmFcGMpoRu1HaA9otn9
         INFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787227631; x=1787832431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdskbMIUANv/v+/854sOfwN+OhmEsWhVMVxtO+b+CEA=;
        b=RVQSXycX2WKJYMkaOBD0Cze08sQJ8YuK5/MB8FFoxvwqC53CWzNi5TNThqvns5La7h
         MffH1/sgRyR26UWGgAC2wL1sNgGz3gBY/qhnPuSVdq+sGbkbdrmZJH+cgEquChxWCmv5
         wdpTeNJUJGEw3Qx/aVW+sj7DOxrRv9hdtfTy4LAF6Ig/LaGu170MnRQJ1O5Wyc4X06gE
         GvitS8mFV9psDxkFB6DZYVxy8pE2mfONYypcCV7yxSQRrnkmtgKoQ0GUfqEjydaLkVHG
         p3y5+KXkaF6hK28OMxgyicdqpN0EiB/L7gzT1kfWZ1/BAUJ0403S/pgMfvUzb0i6+MCV
         qr+Q==
X-Gm-Message-State: AFuF++kh9SmYDAj3N81HgouC9CM2UL/rIzEv7frFCfsmbEgUsuGOsnw/
	LWGnWkMPJy2MHNdmRcDaRBdQmdqhb5iGU3q1GZwUlX1aXS/0Izun5MRlnth7kw==
X-Gm-Gg: AR+sD10fd0O69/J/Gcu/fYblAkvXCMDIlpbFLKg8fuj0GacKDZFwigmNATokkChKy44
	FaIxHZ1QCh0PhznJNgrHTDvX4fhMTRQUoEhtwEGRMyo7Txf1UnhjZSwbLanTd5ImTlh0FWgUXiA
	e8HsVXeS0OSV0Wd7VvZYzfLYqL1k+pP8S7ibYWZGOqhkPiwK093IrDO/HD8ZccZNulGH1XthT6+
	2rVAK+6Mxze4Hu3/OK9r2WaqYAhz8DZSimDX4VKoE0/jWSM+YYXhWCNLq5JNzYw0TBd+TaosAii
	9/R2KEDr+xTLJ+SUjRCrZjyK153Cr8K4oxZ9im7qKY7xYGqwFIooblUBhr/pwYuiolze320iPXe
	zyFXZdQMVfk/iMGpi/UjDunIGP5EI64ZSDf0BYArELygL/hGLxmWQPfzkxcj/Mig+hwQQwpM7sj
	LcpnuhXpQ33XwZseAh88mmADAF3++74QVD46iGGtR3ZhWkmZ1J6oMNLnaR3pkXAjiW1C17xlQff
	m6l0PsXXUjs/xsBEFrIMQLag/9c/86H37Osevn0uBxP3Wg/9mpvMTBVOFYLbG0tZC/STA==
X-Received: by 2002:a05:690c:dd3:b0:81e:c17d:7b8f with SMTP id 00721157ae682-844e2ed5250mr60335757b3.31.1787227630896;
        Thu, 20 Aug 2026 05:07:10 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8451955a784sm22966957b3.47.2026.08.20.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:07:09 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] net_sched: sch_fq: fix pacing delay underflow with pacing offload
Date: Thu, 20 Aug 2026 08:06:25 -0400
Message-ID: <20260820120706.1995449-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

When pacing offload is enabled (q->offload_horizon > 0),
FQ can dequeue packets early (now < f->time_next_packet).

In this case, the drift calculation (now - f->time_next_packet)
underflows to a large unsigned value.

min(len/2, now - f->time_next_packet) then evaluates to len/2,
incorrectly halving the pacing delay for the next packet.

Fix this by only applying drift compensation if now > f->time_next_packet.

This bug was triggered when flow_max_rate was set on the qdisc
or for non EDT packets (packets with a zero skb->tstamp).

Fixes: f26080d47007 ("net_sched: sch_fq: add the ability to offload pacing")
Reported-by: Willem de Bruijn <willemb@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iK6O7ujR9zCJzd04MNLQoDi3mA+HWsR-hgQWYzLS3gZfw@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/sched/sch_fq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 7cae082a9847..4b5f6d896c6d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -828,8 +828,12 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		 * f->time_next_packet was set when prior packet was sent,
 		 * and current time (@now) can be too late by tens of us.
 		 */
-		if (f->time_next_packet)
-			len -= min(len/2, now - f->time_next_packet);
+		if (f->time_next_packet) {
+			s64 drift = now - f->time_next_packet;
+
+			if (drift > 0)
+				len -= min_t(u64, len / 2, drift);
+		}
 		f->time_next_packet = now + len;
 	}
 out:
-- 
2.55.0.766.g2966f0265a-goog

