Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707458;
	b=gXOI04RrJsBro/4fLG9wAWrIc0+FayYZ9MrQw+SBj5KDh7WutG3nU3C5Mp2fL+pwot7W
	 9sxFXK+N/7NkJOYuM8WhsVmQixE3vFR+hDZ3eKMyTazKrxNsqJC0TRgXuprOOZ8/I+oeL
	 1iK5lzoQpIXHbPpvpXGG6iSEL8OUFRSYnK1PQT0jHCtXTwtfGIx5EJ/kS1A4FACWuMcAB
	 epXHAoldIcxgbB7VrpDSRsQFTm6UWIYTPj4bd+4bJWG9bfSXHmqDf314veQPA/vtX//BV
	 YmDEmjtg5srxVgrP0Lf+7xNw28qSFcI3zsD4shNyyuWQWiOXrjpqp6u+ARiKSGQmvJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YNahYpdiHw66I6uTFiHrxOfpUUmCwHBpQrn5JBUBdX0=;
	b=g1qhYtBJ88G+8HQuGyrKR5Ph6Nv98ujj5g827ASqEZCzC0EXitBKhoc+2YgqBXdnOwZi
	 jQ3nTM8bewfFTVxKkQ4cxg6F2uGMzHSfXRK6L1BXNWtBGIlmO19fbfRp+wjuEBuwz3d54
	 LR9rCtphGD/R/WnxMI/UtnR0r5b5qJkP0Zv4bPK8YlveZllNrO2eG6+lUyYIDaf4qvlDF
	 Je9JHmnI8T8LZWf60jLei8DabaNX9sDf73/0KXqL59iYcpY8y46COSIF/Q99te5mXgqJP
	 qLAVsZEwZcuU2lmbQH4VSc0IqLrSS5xTacq7EQaf9LhYNbDrE28Kl34LGPT4CAhVl5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ITdXEEFw;
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D4D606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D4D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ITdXEEFw
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e831e86ebfso1283525ad.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792707457; x=1793312257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNahYpdiHw66I6uTFiHrxOfpUUmCwHBpQrn5JBUBdX0=;
        b=ITdXEEFwOsKvT22iHUZFrynJxZnWnuXSRIjKtFYLTUPo+CPVpGf4DJwgUQK+asp28r
         rxfE1Q820IdErvASV5C0Nb5Yi1+B+5cK3QyA4UGS7U68YSI2vAOab3c6BjurOxQQ4OU2
         ySAwgGVlP4vX1MbiKQop7GR9GlGYCHs99BSCCuw8nnPtkZhbOXSjhO1t7qme1+83tecA
         gRC07vMD/kfFDpl45eS76+ZAcs2crPcvQD6TgnJXzpAJPpwboU+eFgRrhRjSVB4Umov3
         CkSsdQXSVQioBPhdFTWrKpnQHAPvZO1Nvn1H9EG9crVvlszx1lJFyJsJA4swEbkmeJYG
         km8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707457; x=1793312257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNahYpdiHw66I6uTFiHrxOfpUUmCwHBpQrn5JBUBdX0=;
        b=tkmcgl0KQlxE1hH7lH2HQmxFpGdDDltniQzpNU8N9OLJcDjmKpXhTTQkHyMM84A06F
         vjs4Kboenf5OmW4L/zKTvXYR8mxHWoydKeuzDJbcmjygZz/8hw2U5hcLSaUcdORmi09W
         2pBYkU76VU8jYcH9pCyEYmf0rDVytTvwaeSNEqfn1KPW/EafahyneJapw576nKPasSpZ
         AbindNJA7EQudkD2bnght//8+U3ltbRPo6w9wVn1ZI7HhNufXUEzgWFbwyX4v9WtujCL
         7yMgSeOVL92QlsRPPkv0hzMSpWJvAAolPknHrVVOU4F9FOK4VCofpeKT9GZg6seoZHKs
         QM1A==
X-Gm-Message-State: AFq9FYLCCB4XjwCljii0487c2WhfJjWUVanvJT3u3LyMrYMcvcpGsqB6
	t2ei7f/vH8QgrMy5XDoqz47e3P+nAw4SJi0ffgXtIEJIli/wUPy0LGT3YxuyMRLjLD8NpCQBtRO
	UaBFSGKhN8jP54F2INsGrf/0YnlyVXpzQ3Msmo+A1vjP6Srw4ia+1
X-Gm-Gg: AYBFou0s/7zdYOPkiDQE/M7015pQLGOazBBvDZ5JuULi1o60QZywDdEQokOL7iD1toL
	9/2reQs9up2KbA7BRCqUAhY/KaCeVhukx+vj4wLv0QAupgV+HkxBGa2CgJneRxxwelN1e22jo94
	J5j5mVQMwj1z/QEnfZ4s3XX8SBRcMfmk0ZRDXLOk+9i6sBeke14Zj/QlPrhy8Sej+l3c9b+oBax
	ub7hSMe+HX2AzEwZuDpjrW42w0cxOhwd+2I6DtflK4v2eSN8dOdMNjMnkBDXP6Z8ofkT7sJbx6F
	QetGvaZ/PvV6FbPYfWW2UUylCuGvn4zbP0hg9r9BDYxvaKv0n7/wEHlmqZWJreAlAD9f55Utm3f
	VA/Vge1JoiXG8LeveLKA=
X-Received: by 2002:a17:90b:1d01:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3adce0c8601mr212606a91.9.1792707456674;
        Thu, 22 Oct 2026 15:17:36 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada48fcfd9sm2854915a91.6.2026.10.22.15.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:17:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 01C50439BE;
	Thu, 22 Oct 2026 16:17:36 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id F374ADC48A1; Thu, 22 Oct 2026 16:17:35 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/4] tls: device: fix record start in the tls_device_decrypted tracepoint
Date: Thu, 22 Oct 2026 16:14:57 -0600
Message-ID: <20261022221732.1397620-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022221732.1397620-1-rjethwani@purestorage.com>
References: <20261022221732.1397620-1-rjethwani@purestorage.com>
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

tls_device_decrypted() reports the TCP sequence of the record it is
classifying as tcp_sk(sk)->copied_seq - rxm->full_len. The original
strparser read every record out of the TCP receive queue before the TLS
layer looked at it, so copied_seq had already moved past the record.

The TLS-specific strparser leaves the record in the TCP receive queue in
its normal mode and only calls tcp_read_done() from
tls_strp_msg_consume(), after decryption. When the tracepoint fires,
copied_seq still points at the first byte of the record, and the
reported tcp_seq is one record length too low.

In copy mode (e.g. when the receive queue is short under memory
pressure or with a collapsed receive window, or the record spans
overlapping or mixed decrypted/undecrypted skbs), tcp_read_sock() has
already advanced copied_seq past the record. It can also consume a FIN
that ends the record's last skb, which adds one byte of sequence space
absent from the record length, so subtracting the length reports a
start one byte too high. copied_seq cannot tell whether a FIN was
consumed, so the start must be saved before the read.

Record the TCP sequence in the strparser whenever it starts parsing a
new record, before anything can switch it to copy mode, and report that
via a new tls_strp_msg_seq() helper. The value is then valid in both
modes without having to track which path entered copy mode.

No functional change beyond the tracepoint argument.

Found by code inspection while working on TLS 1.3 hardware offload
support.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    | 2 ++
 net/tls/tls.h        | 6 ++++++
 net/tls/tls_device.c | 2 +-
 net/tls/tls_strp.c   | 3 +++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..e1e48a25cafa 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -123,6 +123,8 @@ struct tls_strparser {
 	bool msg_ready;
 
 	struct strp_msg stm;
+	/* TCP sequence of the first byte of the current record. */
+	u32 seq;
 
 	struct sk_buff *anchor;
 	struct work_struct work;
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 60a37bdaaa25..a9f7fd79c69e 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -227,6 +227,12 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
 	return ctx->strp.mixed_decrypted;
 }
 
+static inline u32 tls_strp_msg_seq(struct tls_sw_context_rx *ctx)
+{
+	DEBUG_NET_WARN_ON_ONCE(!ctx->strp.msg_ready);
+	return ctx->strp.seq;
+}
+
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..fbfe6ec3df04 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -990,7 +990,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 		is_encrypted = 0;
 	}
 
-	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
+	trace_tls_device_decrypted(sk, tls_strp_msg_seq(sw_ctx),
 				   tls_ctx->rx.rec_seq, rxm->full_len,
 				   is_encrypted, is_decrypted);
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 6cc222008d95..5d5e8c3fd5ad 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -526,6 +526,9 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 
 	tls_strp_load_anchor_with_queue(strp, inq);
 	if (!strp->stm.full_len) {
+		/* Save the record start before copy mode advances copied_seq. */
+		strp->seq = tcp_sk(strp->sk)->copied_seq;
+
 		if (inq < TLS_HEADER_SIZE)
 			return tls_strp_read_copy(strp, true);
 		if (!tls_strp_check_queue_ok(strp, TLS_HEADER_SIZE))
-- 
2.50.1

