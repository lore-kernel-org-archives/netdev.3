Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358D4A5EC6
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095103; cv=none; b=fWFuxwdJRKfiHXdHpChcOOiqv81FiSzCSVmw3rEnOHFCiy1KrbzVLSN3n21C5rn/qN6IbdunQs+kvTMMbvbMWOUa7O0bOhB5hTxcxWeLHQgoGekyhDJVYRV035NISQeQgAcaxhZlr2AfutYuoOYaZn5pqVlZ3e6x9Z6nReRpk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095103; c=relaxed/simple;
	bh=lckoV7caeWT+K57p91Ud7WyRMvA0nUpa7m/AMwgJJY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRzRhgVbdBHPkIvErZKdPke7sSgaPugMsMb3mdyLFKXsHoJuyU/C75OeurkJQG97xbl9CsdJyy36Ovhnq4rlmWFSE9TQ2ZCQ9wOLBV8Sxcx7GvQ4TRXS1i7CFxV/wedaZq5rG6+BKyhQG/s07GgFA+GMTuWtNFj+sQphDz6isys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DlWVrAJE; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DlWVrAJE"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a706146559so3608233a91.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792095101; x=1792699901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D40i1R//dFQPoarWQHsRuD/UOsp8ZZIh6571H5SOb9U=;
        b=DlWVrAJEMbwamQeXKpNw+Lf92rzwkRLzBWCaSYvtCTlnimOYQ8LeXodKWK+YHAR+PH
         2CVXb6bnrRte7hn4/atbCb1dPcCIxZT9ao0UGGej6Ydw5koOPkb6LMA+ZCcXDw94tOl4
         XI8DJFg+uZv0fcysj4uOJsUeAaneCZpjVmQ1dISUMiC7VAAJ4AVMAZz6h6A29/c35Ygk
         BKZJOU9dvy2xgQyGVc/g3itW+hqAYEdf9kSdQBK79uuA0KEJUvAKFCZ/rk+UogcSixOc
         qHU9yzYGI7Of91JKx1Az3tbojW/aqo83jMKUL9eKpj7XJ2TSX8dnh7PnGt9e+e9OF6sG
         4hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095101; x=1792699901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D40i1R//dFQPoarWQHsRuD/UOsp8ZZIh6571H5SOb9U=;
        b=kTqhWEzop7UxPKIYvJaUMbDinW43PwcXexWVmfXJMaSF/HucFAONAcDRd59M4h4IFG
         PcnpLo8MVHTR2E6EibcD/7pUEBxst62mx4esJyw3dbIhMIJkmk0daDp2raIFBuC47p/5
         E1VaKg6PCkmttBFdgIhmOhLx0PW0FPwGFJ6v9LvD3//WMAsFZxsEnpMwTAJhG/QXnQtZ
         9TBHriDV8n8c4Pi8lJ0JqPB2oirfooWfEE7ZNsiuOO938eUW7O7ONSg2Aw1pSMdNwgph
         UkpI7gywBX5XJ2uw0iC/z4DQWpA9+C8qLXT2QZwp/ClL9bK5upLMGC7wL8l6jhUzOuyr
         N8yw==
X-Gm-Message-State: AFq9FYIw2bnjA98jPc+bvKWQo/1T9iTOtBvC8dsYAKDF7wHMFB/2LoDf
	pNCHaV9X1xHDo15sYkPXaBdJ9xeTTJakYlHvFmdYghEghcVtZnI/95Q+qduw+hZyzaRP0TtOFLH
	GTEwr1XfiqAI3ns+TxVfp57Z+C5AuL6UN+1S/941WhMbq8aex4SUl
X-Gm-Gg: AYBFou1pGLdMf6QU1g6viQ2mKS4eirqZV4Jxzg6f/etrS7atmLXi7Btte6fK2nhPpwt
	qS9EytqjDm4wLgElmCOwrBzT5/HIOPqukkfKL0gYn558FhgrDxMFXb9jKTYkTFlUw0qyCVdMCgO
	XfLZB04dWO+uIWp4rAp7sFGR15E8SSI1RqwNCJMSCcqxivjiZQo/tqPERNtUzUq9ht2z5HvCn/M
	oyBSKqMW0Pl27Uakebqb3BHwi0v/9yxGAAZdcbGM4ZbgkH+jIYNhS1QV1PYtBEkPgikmtf6UagY
	gyJQWCIVQECNlKYG10CTmM6CjBjAlIHNDU/JTu8oMboLetMJjA+uGN2j2CeAKDeLAtHsuQ0OqyM
	1WDbfCzDXnWNq5joksNyx
X-Received: by 2002:a17:90b:1844:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3ab3a90e672mr19229747a91.10.1792095101155;
        Thu, 15 Oct 2026 13:11:41 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acc98adfbasm25158a91.3.2026.10.15.13.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:11:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.112.16.167])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 4022740276;
	Thu, 15 Oct 2026 14:11:40 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 3D722DCE0FB; Thu, 15 Oct 2026 14:11:40 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net 2/2] tls: device: fix next-record sequence in core-driven RX resync
Date: Thu, 15 Oct 2026 14:11:35 -0600
Message-ID: <20261015201135.2744031-3-rjethwani@purestorage.com>
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

tls_device_core_ctrl_rx_resync() asks the device to resync at the next
record, passing rec_seq + 1 together with tcp_sk(sk)->copied_seq as that
record's TCP sequence. With the original strparser the current record
had already been read out of the TCP receive queue, so copied_seq was
the start of the next record.

The TLS-specific strparser leaves the record queued in its normal mode
until tls_strp_msg_consume(), so copied_seq is still the start of the
current record. The resync branch is taken when tcp_inq() does not
exceed the record length, i.e. typically when the current record is the
only data queued, and the device is told that record rec_seq + 1 begins
where record rec_seq begins. The device is pointed at the wrong record
boundary, so records keep being decrypted in software until a later
attempt, retried with exponential backoff, goes through the
parser-driven path instead.

In copy mode copied_seq is already past the record, so the hint is
correct there; the only exception is a FIN consumed along with the
record, after which no further record can follow.

Use the record start from tls_device_rx_rec_start() plus the record
length instead. That is the start of the next record in both modes, so
the hint no longer depends on which mode the strparser is in.

Only drivers using TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT are affected.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
Not tested on nfp hardware; I do not have a NIC that uses
TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT. The fix follows the contract in
Documentation/networking/tls-offload.rst ("informs the device about the
next expected record number and its TCP sequence number"). Build-tested
with CONFIG_TLS_DEVICE=y and =n.

 net/tls/tls_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 33e6dc3d4164..7dfbead19d3e 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -854,6 +854,7 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 					   struct tls_offload_context_rx *ctx,
 					   struct sock *sk, struct sk_buff *skb)
 {
+	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct strp_msg *rxm;
 
 	/* device will request resyncs by itself based on stream scan */
@@ -892,8 +893,10 @@ static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx,
 		memcpy(rcd_sn, tls_ctx->rx.rec_seq, prot->rec_seq_size);
 		tls_bigint_increment(rcd_sn, prot->rec_seq_size);
 
-		tls_device_resync_rx(tls_ctx, sk, tcp_sk(sk)->copied_seq,
-				     rcd_sn);
+		/* the next record starts right after the current one */
+		tls_device_resync_rx(tls_ctx, sk,
+				     tls_device_rx_rec_start(sk, sw_ctx) +
+				     rxm->full_len, rcd_sn);
 	}
 }
 
-- 
2.50.1

