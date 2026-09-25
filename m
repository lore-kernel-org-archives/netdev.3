Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EAA3B058E
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358258; cv=none; b=Qwie5e5Mbm3l4r1Yhi2vM9w8/MVkQis6YouFbeGZJNHhseo59G4kkpDILym+ax/NZ/Z6mTtAQ/m39yy1Uj4lMK7dDAEYjcnoKq7XwL0H5hgopiKr3XfjNddn8CJTFb6xrjlch+jUB9Uh5dnzepZsDS8EfXxrKDkfOxdez1XlTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358258; c=relaxed/simple;
	bh=8B2fWGIDUgftWpMYtaxbZfUEWzXz+xAFmykfFulfqSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvRe+oLY+6fbLkfugmY9PWmJWfvb55XUSihZbn3ZCCF7NzqdHTPQvckLCkXmo6gAKNB0GkXqT93dJSgD2RgjZGoMe/AsY/FEs5dkMzQ3YyzFTftXXqf2XxFvxl0EEzbi5tq3sxW1/xgpmF4/6gp+ZM1pMlYw4KWVGZpry8dGYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=0OTeV3xG; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="0OTeV3xG"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so336837a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790358255; x=1790963055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
        b=0OTeV3xGr30TJvyyGZz8L4AFRkV9I6IILtbxmfuxSBwpEL/2fOrxIgziedfmcd1EgL
         yiHLkN0wL0WpTir+drF1gCn+5Y140QRCYAsNJWf/OeyIZUyS7p5k9FJlzXXd+Wzv1j+J
         a+Nv1WEH968XBj80MWCWmp3F5lJf7HNtPO0C6qu0BNoWwN69A9CdPIvkTtejh/1rJPNR
         bN7KhbXWOw3CNOJRf9IitlYi9MqoZhudSnfcGYFayfJKdda24FL39oHOjVlO9OHC4N9H
         Be3OJuIdgIw4V7StQY4SuiN5925XaGkBYQodIXUGdvNqenUnmMGhRP/MgveniJbE+HEb
         7AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358255; x=1790963055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
        b=G5xXpLeQdBrifvWAkvWRx5MtsytQUxJkud7mMg3d/UJz6fnSO+0ufFleSMgzGwJqSP
         p2W5isOj4v5E9m407tLWPZEMYF/RLwYTTORUJyI9mnQ65fustqB2snpFEctthQTttRNP
         tC3eC9vk25N88XvmtajEyF1WJ/McHfbiMcl0AqIejUcoRzIkDSAdrW1C+WSpCU3Igtnj
         niet06P0fb6/SRNTl4EHa/A+KmOsRuFDJfBx8fCRMA+N2j5P+QoXfO988Y36/G7pG1h8
         R3HilIgm1W/ijyfqE6fN2tlig1ru2FlEF49S+qPCWGvmlAwhsW7K/wtj6VF89oWgub2r
         FtnA==
X-Gm-Message-State: AFuF++mlhW8H2jH7h8l2ZXhpU+dOGH3oNt9hNZNbzlaEiw3Owe95RLuu
	AyfqpS/Wzprl9WxQowk95Tizda7Pj/YFZTad4/NzS0L9+Gh1jHLMSxcUUNWjn7aU9VtpGdZykWd
	F+ojv
X-Gm-Gg: AYBFou00LOrYnPs6Ra1pVErxHTXsY7BIspflOLDp3evQsIfwmhfTVOZCgXMpS+tfU19
	cE9yazo5P2Nj8xpxq9SeSwsOuhMWdrf4EjQXhgUpZYH98MomWGpPsaTA77Om9BGOGO+HjZFIh7q
	zsNR8h8cZ8gcUCuWjFmGHv2JbREGBylv3Bfx7iE0/q2dAezwm+TsceoVyyu5sTdM0BO/I+4or/m
	awFsXXacpMnJmw+SlsjHBIoy23bO2/fv6+DR5haSwSLYM3A2++mvAdaPkMJOJFXnba1AOzbMlkO
	7pE77WXdpPooPKmir2ESgdVg8c1WoNmElYbksAqSR4Z+yIBign7Ll69EfGKY7YlqQq9fXdhV7og
	PM5TeVHkdiyHvyfEZbR+VlJ0M0Po+HLa3wFX2kj4ZbWqdZSgPh93XMwPoSgW17mzbUkt0/6NC22
	e5rDtyMOZVj1U3aHBqxfp93czAnNs87XAvWwtWURjb5lncFyF9ruSqS60xukg0MyBT7LT+XLM03
	VSl05ks2k2fmA==
X-Received: by 2002:a05:6a20:6a28:b0:3d0:868d:8ccb with SMTP id adf61e73a8af0-3de0e725d69mr5559430637.13.1790358254568;
        Fri, 25 Sep 2026 10:44:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c3bdsm1686953a12.13.2026.09.25.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 10:44:14 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>
Cc: edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net v4 2/4] bnxt_en: check HWRM response if completion never arrives
Date: Fri, 25 Sep 2026 10:43:59 -0700
Message-ID: <20260925174404.2789072-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925174404.2789072-1-joe@dama.to>
References: <20260925174404.2789072-1-joe@dama.to>
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

