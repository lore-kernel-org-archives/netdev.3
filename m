Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EF4A4EFA
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095102; cv=none; b=S9RbhX3VgeiYxPTgxPw9ThC6SZIQ4TzHz7Lx5fCraYkfUBdug2P1a2faeHXK86qebnyoYHykxqOX1+jqcQeIOUTsxr/jylsh4o70QuYvXUgrWmsA9suI4zbZiGh+zDoZA08AuIeVQFcbHTHjMyj9ksEmRzRu08EXlIN/KXRB6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095102; c=relaxed/simple;
	bh=QUw1Rlxrgn749M9frgjDRPdMwPCYN0BCBB1Lwlh6Kkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeGkhvOW9kdut0etCKf5Jxq8EWFHjHnsMRpQGkuXfnIfFLU0mUQ3t3hEudLCYuai02a87hp2/pasJ4Hxog+zGQ+AaUwWAESd/OB7ab6CM5kL2J1nI/jk/2Rifi/2kbshvdiXTru/XZMkrlbz71LW9ikj6PF9aJn8TYa4QO3q/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AIjnE2dM; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AIjnE2dM"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3a813079a55so288324a91.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792095100; x=1792699900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/if9ha5oLSkd38DejXXkAsnvyqUBgaSdHZWj4UraLSE=;
        b=AIjnE2dM3GON4YrV656e9GysaYQ5SiHIFWzJeg9FezEEhOALcd0KcIhgre+b55K4tT
         8vPAXdbHVHkJhDRH9oOToc26RxDnXkC3o6ZOixLPAD2CiZxB5/55jvxvDEoevEOCiDCX
         1klptJhCC08/Z+13nXZuD92AllquqZlnapLYwQprtRKk8HQz542uSobqr0eAI5VfR4xQ
         DLA4XqpSOkRIm9St62ieGelyI55isoI4cdX12ipdRB7lkDtDBriidbWuWCawB0TqeY2L
         VztmG55BUmE1Zk2lqWkeywz9PgubPUDoNZZsZMA2GZ7SqDLnUT5F57SXbSz5xrWRu67s
         515Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095100; x=1792699900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/if9ha5oLSkd38DejXXkAsnvyqUBgaSdHZWj4UraLSE=;
        b=RuKI0WW4LivW8NloxoZycxq18V4FoZjUNSB/Fa8dYkvLaI2w3sziWK3t8gMR+nAXAv
         X3fPaPXoXJF3d8hH+G6oHm+FbXBYUHFKR7pA3wgRJQficYbCYt+i4BZDyOUZYle4JKI1
         5UiQJGKB98jPjlLFZUcBEK8gUul6bE+iJjO5sLKimRinZOdH43tJdBGTHNS6fQkx2dYT
         p31L7UEq8b7U1g7R/tPmxMs1MJjesW6yYj8WRfixvIKclS8RxAtdgbmL1D4K4/9t1G0R
         f81+o/EjlQTuLWb63b2bUaYch4O8oQo4nHuP4jEU0v3Qj0Faz5sSan4a7K+7xsar74uZ
         5Gig==
X-Gm-Message-State: AFq9FYJoiBR+963pi53RchlcXjpChpRB4h2dayPH6WietRICcW/g6Hox
	kU4adEFl7dqe3nJlxJqE0ETuTVgQjHUeo7nymGx7lUBmGBk9GPCU7tgMc+48cOUkcs7TQAGrDyS
	mMTvzRWRTHJAGJRH/awovet0TR+MbWTBqVRB24k+KbSTQkELuV8Xn
X-Gm-Gg: AYBFou22Bf3okEvTaoNDwNUCKagm7KAbjJrm0IZulPubkN49vubNDm8TovYJrU5L73O
	xZQsrRoBu2B8+DcNsu5LHuluXLYOSA0l2sSjdBBsb/VENkptqHtyIQDIafn4MaC5vb733UBNgIv
	aRTabxWnVu/LIlf+O8EpvKf/haQnZFebf/HqYY+3Ukjej+vC4sq5WLUzZ2IWF+OjcMJwI70hhXg
	Hkd7s910uV4WSlKKHLjoNPQYdltrjJGU0q5D/Cf1T+Vb7QHCSnCl1WMwppT2deSinnijkufzYdB
	vUPcEvoA9RBDN/+o3J9qbTbuRr2pQGmtSJarzZXQN1gfMZ0ga9ii2FkxOcheoTBAD1M8eWF/99D
	RqJtlqzZk2tN1CRQgLPU=
X-Received: by 2002:a17:90b:4d8e:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3acbb8bf8cfmr737638a91.37.1792095100339;
        Thu, 15 Oct 2026 13:11:40 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbc5638fdsm460486a91.0.2026.10.15.13.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:11:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.112.16.167])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 7AC724041D;
	Thu, 15 Oct 2026 14:11:39 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 785D8DCE0FB; Thu, 15 Oct 2026 14:11:39 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net 1/2] tls: device: fix record start in the tls_device_decrypted tracepoint
Date: Thu, 15 Oct 2026 14:11:34 -0600
Message-ID: <20261015201135.2744031-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015201135.2744031-1-rjethwani@purestorage.com>
References: <20261015201135.2744031-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_device_decrypted() reports the TCP sequence of the record it is
classifying as tcp_sk(sk)->copied_seq - rxm->full_len. The original
strparser read every record out of the TCP receive queue before the TLS
layer looked at it, so copied_seq had already moved past the record.

The TLS-specific strparser leaves the record in the TCP receive queue in
its normal mode and only calls tcp_read_done() from
tls_strp_msg_consume(), after decryption. When the tracepoint fires,
copied_seq still points at the first byte of the record, and the
reported tcp_seq is one record length too low.

In copy mode (e.g. when the receive queue is short or the record spans
non-contiguous or mixed decrypted/undecrypted skbs), tcp_read_sock()
has already advanced copied_seq past the record. It can also consume a
FIN that ends the record's last skb, which adds one byte of sequence
space absent from the record length, so subtracting the length reports
a start one byte too high. copied_seq cannot tell whether a FIN was
consumed, so the start must be saved before the read.

Save the record start in the strparser when it enters copy mode, and
add tls_device_rx_rec_start() to return it, or copied_seq while the
record remains queued. tls_strp_msg_cow() also enters copy mode, via
tcp_read_done(); save the start there too, so the saved value is valid
whenever copy_mode is set regardless of which path set it.

No functional change beyond the tracepoint argument.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
Tested on mlx5 (ConnectX-6 Dx) with TLS RX device offload: the
tls_device_decrypted tracepoint now reports the record's starting TCP
sequence. Also build-tested with CONFIG_TLS_DEVICE=n.

 include/net/tls.h    |  2 ++
 net/tls/tls_device.c | 17 ++++++++++++++++-
 net/tls/tls_strp.c   |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..aebe21e8917d 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -123,6 +123,8 @@ struct tls_strparser {
 	bool msg_ready;
 
 	struct strp_msg stm;
+	/* TCP sequence of the record start, saved before entering copy mode. */
+	u32 copy_seq;
 
 	struct sk_buff *anchor;
 	struct work_struct work;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..33e6dc3d4164 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -835,6 +835,21 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 	tls_device_resync_rx(tls_ctx, sk, seq, rcd_sn);
 }
 
+/* TCP sequence of the first byte of the record the strparser holds. In
+ * normal mode the record stays in the TCP receive queue until
+ * tls_strp_msg_consume(), so copied_seq still points at its start. Copy
+ * mode saves the start before TCP reads advance copied_seq, possibly
+ * over a FIN that is not part of the record.
+ */
+static u32 tls_device_rx_rec_start(struct sock *sk,
+				   struct tls_sw_context_rx *sw_ctx)
+{
+	if (sw_ctx->strp.copy_mode)
+		return sw_ctx->strp.copy_seq;
+
+	return tcp_sk(sk)->copied_seq;
+}
+
 static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 					   struct tls_offload_context_rx *ctx,
 					   struct sock *sk, struct sk_buff *skb)
@@ -990,7 +1005,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 		is_encrypted = 0;
 	}
 
-	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
+	trace_tls_device_decrypted(sk, tls_device_rx_rec_start(sk, sw_ctx),
 				   tls_ctx->rx.rec_seq, rxm->full_len,
 				   is_encrypted, is_decrypted);
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 6cc222008d95..ad8b5150ac97 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -132,6 +132,7 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
+	strp->copy_seq = tcp_sk(strp->sk)->copied_seq;
 	tcp_read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
@@ -418,6 +419,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 
 	shinfo->frag_list = NULL;
 
+	strp->copy_seq = tcp_sk(strp->sk)->copied_seq;
 	strp->copy_mode = 1;
 	strp->stm.offset = 0;
 
-- 
2.50.1

