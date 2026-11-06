Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992483;
	b=QEHVX9hVbyYkQhM9Wstvv15kXXSNkT2klQ0Ei4YR6BKCxBlWEbvFjQ0AAhACZ1MAGz55
	 8g4iQ6YL8XR38aAIQV5W1H2kz4wwunnCTvwgAqAOhWPdODh1gIPxMDa9B82T8I3+Fj83b
	 WVlLFOf7VgRXUeo6ZUw6ezwClzX22A1zjlkjcd8ovuF+zRCaL1HLet8GpFws8N2/zMhT5
	 2eE5v9qffcJv+7I8/6AJgQ94/zZ/d+eYraDX9GN5DyV92F7ho5xfJEWJN9vR+2+Rw+8rX
	 PEUDIkvhAVpZXEUlerHgKKp4iW4MVhc9VIJsZ04tYg+GOisBbkY4YUup+2K3X9XVjhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
	b=vjzBxDhbaFv49uTjOMJNlAaDtX0Md2zQ25dY4YvROiczmv3jo+lpEVDQKVrv8IEV6MG/
	 YPzDdvrWj0KrEdVC78wTtigXWHdz7bAQ3vy04QfXXu9+wqVBjVtWQ9evyCxZaLyJqLz7m
	 fPKglSz+PKYpioX+K8nEKUr3PjCM2cTNRnjPAIrP3ra5D2grfF1zhcBseDaiy7r7tmXRS
	 UY1s7xh5NhHku4EF2e5Be3dVGHX09nKC9IlIk/gIgrW/AIIVb5E6LLKHQ8AKm5SlaCS0V
	 sDTadk/2himtrW4fElJZEdVZxazvADIvewHG7tlwm3IDpms5ZOms9QzcRiZ/oOvuiSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fD4M4g12;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898D606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1898D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fD4M4g12
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b271e573adso480706b3a.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793992482; x=1794597282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
        b=fD4M4g12rMDwQ+mCHieGTT+VTcQBpBM0I1nzyEp24lrICR1UikVwZ+X+IWCMI7wV3K
         Wp0/46Fn8EEeeQs9icZxwhBVdstyNIOUpXelauYtrcKUsTNzhRror/h7Oo2xapgwHZJw
         BbV5KT/WxiWSHpffrp6ygKjPMaLwqCbXP+OH3t+N+DW5iEdUsCqlWY+7FsiZn1BwGKL1
         3uYuqHyfiUxmYw8wTh2x28YVu6GzG00kclMFWKHVmGtjX1IXWO5XEYu9pJBnxTq6uMAu
         qgbKAX5psDv1Fw9aeAGfCcNrRt7TzxklYZoaL+2+jeHdNhFsmZ7wUZiu0pv0InHjQx3N
         vOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992482; x=1794597282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aslm3Yn3BYgx8V54FZU0TWe6uKvDrpLLy9fax5L8J1M=;
        b=K70a2GcXHAIlofdPIWTkaQETfRP9h85bTpZKsLnYcTvUtjIIh9VjNGMjTpL+j3+PY2
         8LHLCOArJW8VDFkJsf2sXNZ7Fd17E43ViKtC1mLa2znz8pQB59QBKLJ+KsZ0YhjgGGRs
         cRlfTwPJTWM4YpzC27PjqHi/RBnT9jNC3Q3/7n6lzU9JTvRxYOQVMo5Oj8rQMXrlAs7m
         QVCmfa4i3iorewefc+Zm7s/v1Zr/3w1c1WWMk9Ovq13Yk3mAkOoc2zMQFRkBj4kzfSZY
         xknOSDh0RSkkkX5Oqybvw0wbsgVnnLkpEw2x91M4EfciVMWxeEtt6cpS/vgdlZhG7s27
         hQCg==
X-Gm-Message-State: APuU4Z+KnqQwdVl0hqdepyPbl+Wa+jW0Y5cRiEWQAOcF5mZEiYlfK0Bk
	ATX4vD7h+425cOj62+Fxzgp1jl4t8KqQ4+H4Jl41sXvmBZseLhG7RM0Fo9QdAmxCUPsLpUY8z8V
	kkRip
X-Gm-Gg: AYBFou1RvDtzvHYGNODm6m1M92pZ+1m++nZzP5OS9WDwt3I80YaU0gZgAJVCvDuIYZj
	umkAD430HwgUJoHZD5RkLcnz0QubtcVC0RAjqY+mZYnlMzQRgRxS/h1anhHcPw2fWAdiKhx/rcT
	RB703gYnhroEfZCAVOJaWxozynPFkXYGuLy6wjVrZLdGncSx3w+OJ9cW8tuSyaY91pYOvdCud0Q
	bQr3odAVd1y6us9UMO+qT+wvqtRCa+kiZsLoZg8PeleIogdW/qPXKFh+88IKqBVy/eazCruyVv1
	4s9ly09vG1+rE3alw3OeZuw9HFLbk/8+GGGIDi/53k3kjikL0//3MaYhp5CJMEQIUI0Sj2fGXTP
	MKurjMSoES3W6KLrsnDo8OeEW8q5CdN30vPNDC9PpUByjPeikz4zJLfsAbacZIWuFbtZROQXUqw
	vWOWYOxYfh2QXrEyu+OUc9byaNNqfkOn9OosLIKD9Aef3HgmXwve3s/AyP1d1dnoqLhnAmBGmbt
	ePg+xwXslq6VTJDfBfx5KBev8wbj9HTXgLx1W7Q4SvEqc/KTotDpm+HrD+GupM3ixPQPt46FfCe
	X5T9z5aGA9DGoq36SszrumQrhkyu1i0GgOUgHYp38A==
X-Received: by 2002:a05:6372:a80c:b0:3e1:3858:1dd0 with SMTP id adf61e73a8af0-3ebb293a76amr3480273637.42.1793992482406;
        Fri, 06 Nov 2026 11:14:42 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70aa3ffasm982983a12.26.2026.11.06.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:14:41 -0800 (PST)
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
Subject: [PATCH net v5 2/4] bnxt_en: check HWRM response if completion never arrives
Date: Fri,  6 Nov 2026 11:14:18 -0800
Message-ID: <20261106191423.4194081-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106191423.4194081-1-joe@dama.to>
References: <20261106191423.4194081-1-joe@dama.to>
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

