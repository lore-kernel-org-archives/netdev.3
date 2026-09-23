Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901B3CB54F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197682; cv=none; b=j/xVlI3p0NoruS7hvIzMSgBESGJ6KCLIuH0s1w2Wvrgjiw2SaOrs0BQ7q5RxGNC4rFw7dT54boZBytUisMpMVZTRdGnJC4s/RWLXqO+z9luWKFlrKn0ghAQ5oHxU+MTIgNQg/2K6P9QKBDrqli+U7J6HUcqPhWBYK4si8OTcof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197682; c=relaxed/simple;
	bh=8B2fWGIDUgftWpMYtaxbZfUEWzXz+xAFmykfFulfqSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRMKTDVgK7agCNYcZ8jM06pmRyJEjPBRRGJSuSHeLTntQXnuw0Kcvv8cuSUJ+Cz7iipL3BVIiIzHxcTy5ecZTVjsK3VGeAcw0alD8txjqGoznMmcm646SsqXedkVHQeufth7PkBz8wgieJWllJzNQePMthWjPwGerm2zFyhAq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=w5/kP4rT; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="w5/kP4rT"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso9000805ad.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790197676; x=1790802476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
        b=w5/kP4rTscb/mCMMHW3CPd1FkmxYDmkjz7VgryWm6h94s2pHak+1dkIi9RwHeSnmah
         EJkESKN2KfWrNM9esGF/sQr1oayAIpcBXUqNBtMVUlBjS/sWgCmKsglNZhM6iUngP1Iq
         hSg+QIYS3dt/JUV60gl4QUeHym/KnunP+asSN2uIq4wsgz7rVGboozEjBTL4cQ2BW0rj
         cdaCjOrUV+tkoWpb4SWWJr+W7qqitRDZ5XSdvlOJxaULsXE1jTZ9TAMNVK7k4D62TO0r
         I7gq1MvApRSRczysJZ+Wxi4QnFE4OngjIjIlOjfSE5R8IT/rgbLlkEzKfRq8fhNAH7t9
         tijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197676; x=1790802476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
        b=0U7j5bp969CPxLnY5GFrWFJUhsacYt24V5PNIrLd6+vJX1kZj0qrVYWAqbvlqhP0ld
         x2MudpxkTufv44WoULiJG6whGGl1r9hljjZy0bOnKgr51SXnwktBxTNhtik7t2Etv4QS
         ApSfwoBdNwhuO1g2D3gol9qQT4exRt9leUPuSSBCQKOjEGdXTBAHnoiHToMScHrMRY8D
         6HK7w5IpXANf4okJJpKL0EirTsM9aFXpAjC5QmR5dESkM+Jl1R1K4qXU6t4xcBuKsWrg
         IJojgWpdhq6DLraTds/lpTqRHm5abU6yQVJAPqBCp4NOkDb2faEdakm0RjulC6HQA4wK
         fOJw==
X-Gm-Message-State: AFuF++mYQKnNqiFVg/EF5IQbfzpBuunj9rN9HJ+KfOxV+gy7JmwlzIVM
	P9m6wIbl5rFA7uBhwaCprVt3V2q0gqm6wzj8UDTT8MZyVnpXgP2sfsg4djzJ+v0iAM/vgk+Docj
	5NaFN
X-Gm-Gg: AYBFou28klPZIulI8NW2xlUHxx0QBvmPsrsMt4uzJ2wwqSkcspqBRAs1AnFmMe+qZsS
	Y6fERSP4oL/8g+ot3cGM1NAFWrbD4HweWx3w6vztHxApfXONs6xMClReS6vrMayegySvQidbpEo
	TZPX0RhJyrfIrzsyeIyIObvZKgq0ocU7gO71HFTcvZbWD2pjZOC2B4LBBWoZawRrxwTXuLimB1z
	L8R7dD1vCe+1ufpAm3lv2941ZerjXUB1ORx1eXnyGxO3lsLU1kwimx8KT2mIB5rgPjcGIh3orJJ
	IvwJgX1DjYeTRglsd4xmyl0BPWzMxfkCj9di18G6pqbEH3EbbC/g0/yXsGcfK/soTEBQbNv1Kw3
	+H2+NfCV99nSRkgxSKd6GbCTkZT0m374g+ht1KwRqKaVSYs+2nO6vSfyAt75WoXi3GiLxZGOaEL
	Esrv7H7+7KbBuMfGWCw3b0276yrKnykXhoMdJAkZjKkWdESvEvN9cSmw==
X-Received: by 2002:a17:902:f543:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2df7da839aemr2463045ad.15.1790197676232;
        Wed, 23 Sep 2026 14:07:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm16450405ad.64.2026.09.23.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:07:55 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net v3 2/3] bnxt_en: check HWRM response if completion never arrives
Date: Wed, 23 Sep 2026 14:07:41 -0700
Message-ID: <20260923210744.3406861-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923210744.3406861-1-joe@dama.to>
References: <20260923210744.3406861-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a command is sent over a completion ring, __hwrm_send() waits for
NAPI to consume the completion and gives up if it never arrives, without
looking at the response.

If a completion is not posted within the timeout, check the response
before giving up. If resp_len is set, the sequence id matches, and the
valid byte is set then the firmware completed the command and only the
notification was lost. Fall through to the normal error_code handling in
that case.

Several seconds are spent waiting for the completion, so a response that
was written at all is complete by the time the wait gives up. There is no
need to poll for the valid byte here the way the polling path below has
to, where the poll is for a non-zero length and the valid byte at the end
of the message may still be on its way.

Log the response state on both paths so there is more data when this rare
event occurs.

Fixes: 74608fc98d28 ("bnxt_en: Ring free response from close path should use completion ring")
Signed-off-by: Joe Damato <joe@dama.to>
---
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    | 33 ++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 5bfabdca7d0e..4feba90f0bf6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -582,11 +582,36 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 		}
 
 		if (READ_ONCE(token->state) != BNXT_HWRM_COMPLETE) {
-			hwrm_err(bp, ctx, "Resp cmpl intr err msg: 0x%x\n",
-				 req_type);
-			goto exit;
+			__le16 resp_seq_id;
+			u8 valid_byte = 0;
+
+			/* The completion ring entry was not delivered for
+			 * some reason. It might be possible that the command
+			 * was carried out even without a completion being
+			 * posted. Check the response before giving up and log
+			 * the state.
+			 */
+			dma_rmb();
+			resp_seq_id = READ_ONCE(ctx->resp->seq_id);
+			len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
+			if (len && resp_seq_id == ctx->req->seq_id)
+				valid_byte = *((u8 *)ctx->resp + len - 1);
+
+			if (!valid_byte) {
+				hwrm_err(bp, ctx,
+					 "Resp cmpl intr err msg: 0x%x len:%d seq:0x%x/0x%x\n",
+					 req_type, len,
+					 le16_to_cpu(resp_seq_id),
+					 le16_to_cpu(ctx->req->seq_id));
+				goto exit;
+			}
+			netdev_warn(bp->dev,
+				    "Resp cmpl intr not delivered, msg: 0x%x completed anyway (len:%d valid:0x%x err:0x%x)\n",
+				    req_type, len, valid_byte,
+				    le16_to_cpu(ctx->resp->error_code));
+		} else {
+			len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
 		}
-		len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
 		valid = ((u8 *)ctx->resp) + len - 1;
 	} else {
 		__le16 seen_out_of_seq = ctx->req->seq_id; /* will never see */
-- 
2.53.0-Meta

