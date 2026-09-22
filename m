Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27048F033
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101465; cv=none; b=jpmm+HzD35z2tmjEyIzgGGWfdMmnQw8Gv9SJz209dz/Lcpugc8E9NxioOYnjriqVsTuWnjgineYiVlmhWrz6W2aClWDvVwFZ0F3TEmTLKls57j7nnr0HVUW9VcVrJsH1sk7w2ISYowOxtaATF116DgBub9DA4uitlsueaLgm6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101465; c=relaxed/simple;
	bh=wJWRwJSOwUJCCW1ziry9J4YSKqISemZjbWRRzBnqnL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otKxrk3ggQRpZG3xLLG75J2k4BwvXtRDu7hc6qlX89UU/GrQbfV6FPBtjXY2ORFHdEIGV0bIJE5Iv9MSJ/6RQslP2hQ1E7etHexIR1NNwgmIwlt7/om3iG1Cc7s5VE7CXlMHLUYyN8Oo+6LLrhR0xr7YBDbzuduUtHo8/3bN3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ehSt+aNC; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ehSt+aNC"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so131424a91.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790101462; x=1790706262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xO1R65BfMNPc/29NEB8dWdJDbp318jymstIuoTuu6l8=;
        b=ehSt+aNCK/bSUvRlxLpdEeO7iKohkTqoNcwVpCMNl5h/8SyiZm9/7SunT93QhIsRZC
         EICjEjE6yChy1mY9QnF3/3vP2NtfS0Zl+dmPynkr0pQZd21MPA9n37KqxglL0X01K3N/
         2fb+bUfuwpD0hLIf3kNAklxVg/3rGOZgzC4ZIZ4P33K2etSmLdEbO2c5eeJ6f00BVE6r
         KpcTaAQMOX8hKDC51H6K80p3Ye1/Jb2j6jSRRzzO82AVym7G5Td5jIn7t7vMcGWsSfFh
         RfwKkHWcXW+W7jueoUSDwO0FBtftpOwZq9O4HZuGViLsoFLGQBc0FvxoQbqmnFGpoGht
         7hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101462; x=1790706262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xO1R65BfMNPc/29NEB8dWdJDbp318jymstIuoTuu6l8=;
        b=apPzAhNvdwrTkJP9hlPi4g5kStD76TIBNf/DHgSUsuaav7KUpCuJ+l+CIBx8cB0YPx
         lnnWXI3Z7Wtiw7V8SiJTWBHdXZjTM2uSOPzqfUfDYYBATkwUu35zCS0ww+U3ncFslZis
         C3yWI3CTk9t1c3qexubV5LzCEWf+BH4nZ+jk/ARcnfTxHuY3fZ0nEnU/chiILk0hP4vD
         CeMq/tmpIQVqsjE1xorg+L7xlm+iFjbHlC/BhkLZEJ8VQzjyJoS9XBoMgA4mEQgVbfbp
         Z3ReuDJ/sEm4viYI7276Q0gKlR7TM2vVPTwx1iFcMR5e2+PQYBRt+450c8tsHy/cG1CE
         5tKg==
X-Gm-Message-State: AFuF++kzBsvXC1crgRoruGSOxtNmIPQa0uyGEWjoB8L46RG7xFDDG9x1
	85u2MPuUpufWYvfqHm0XqkoajVu0Bi1J58QFKmT621erEtFUfdedPOxyWfnw96sl/ANEoX5YQbc
	f77if
X-Gm-Gg: AYBFou2OYIkdrmiOYoATJrD8W4DYm9o9sb4+ZiPf6TIfz5IZ9JUe6jnWcD+umM484Ak
	i2UMBAUKy7lYrBbFLyUi8sCx0xy1o7lQLLHh0abGS6bLtYHKee0+hkam81iqI212Y6pePWv2PAu
	/YDVRddmdc967Pb8E/xXLkFybcHO3TAUVr2VE7xgm4cTr4pNtTtRtwIIJiEbcMX8OefKNW0IdbE
	UdehBN3C8mfvsv+NCs92cPtIqPiNr8fpwNLziHeA7iZHgKd1Laechde28AkXfe8TZZ1tUzRihQO
	rEIFryba2quKZeurKL5BHXUviHIsWG2t/S/20iSTzwf3N2ZuPZHgiI2Ay6LL16MYl/dT4DAXqy+
	bz56yPLAQiD9rKYkMdLI5N0O5Sy70keF7BPllRyG6PXlrl3s4la6DYN26cqblLKrLfZ5LrnK2MN
	CWyZGDCMo5w5SQHr+c8V6+hRhrET2/BjMuhLzmK9XMWtdCnnpHWZo=
X-Received: by 2002:a17:90b:4a45:b0:39e:6c6a:4b6c with SMTP id 98e67ed59e1d1-3a07e6bacfdmr240793a91.54.1790101461609;
        Tue, 22 Sep 2026 11:24:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07db883b5sm663652a91.2.2026.09.22.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:24:21 -0700 (PDT)
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
Subject: [RFC net v2 2/3] bnxt_en: check HWRM response if completion never arrives
Date: Tue, 22 Sep 2026 11:24:02 -0700
Message-ID: <20260922182405.1290749-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922182405.1290749-1-joe@dama.to>
References: <20260922182405.1290749-1-joe@dama.to>
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
valid byte appears then the firmware completed the command and only the
notification was lost. Fall through to the normal error_code handling in
that case.

Log the response state on both paths so there is more data when this
rare event occurs.

Fixes: 74608fc98d28 ("bnxt_en: Ring free response from close path should use completion ring")
Signed-off-by: Joe Damato <joe@dama.to>
---
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    | 75 ++++++++++++++-----
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 5bfabdca7d0e..c494abb71c51 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -456,6 +456,30 @@ static bool hwrm_wait_must_abort(struct bnxt *bp, u32 req_type, u32 *fw_status)
 	return *fw_status && !BNXT_FW_IS_HEALTHY(*fw_status);
 }
 
+/* Wait for the firmware to set the valid byte at the end of the response.
+ * Returns the number of usec spent waiting; a return of
+ * HWRM_VALID_BIT_DELAY_USEC or more means the byte never appeared.
+ */
+static int hwrm_wait_for_valid(u8 *valid)
+{
+	int j;
+
+	for (j = 0; j < HWRM_VALID_BIT_DELAY_USEC; ) {
+		/* make sure we read from updated DMA memory */
+		dma_rmb();
+		if (*valid)
+			break;
+		if (j < 10) {
+			udelay(1);
+			j++;
+		} else {
+			usleep_range(20, 30);
+			j += 20;
+		}
+	}
+	return j;
+}
+
 static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 {
 	u32 doorbell_offset = BNXT_GRCPF_REG_CHIMP_COMM_TRIGGER;
@@ -582,12 +606,39 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 		}
 
 		if (READ_ONCE(token->state) != BNXT_HWRM_COMPLETE) {
-			hwrm_err(bp, ctx, "Resp cmpl intr err msg: 0x%x\n",
-				 req_type);
-			goto exit;
+			bool completed = false;
+			u8 valid_byte = 0;
+
+			/* The completion ring entry was not delivered for
+			 * some reason. It might be possible that the command
+			 * was carried out even without a completion being
+			 * posted. Check the response before giving up and log
+			 * the state.
+			 */
+			len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
+			if (len &&
+			    READ_ONCE(ctx->resp->seq_id) == ctx->req->seq_id) {
+				valid = (u8 *)ctx->resp + len - 1;
+				completed = hwrm_wait_for_valid(valid) <
+					    HWRM_VALID_BIT_DELAY_USEC;
+				valid_byte = *valid;
+			}
+			if (!completed) {
+				hwrm_err(bp, ctx,
+					 "Resp cmpl intr err msg: 0x%x len:%d valid:0x%x seq:0x%x/0x%x\n",
+					 req_type, len, valid_byte,
+					 le16_to_cpu(READ_ONCE(ctx->resp->seq_id)),
+					 le16_to_cpu(ctx->req->seq_id));
+				goto exit;
+			}
+			netdev_warn(bp->dev,
+				    "Resp cmpl intr not delivered, msg: 0x%x completed anyway (len:%d valid:0x%x err:0x%x)\n",
+				    req_type, len, valid_byte,
+				    le16_to_cpu(ctx->resp->error_code));
+		} else {
+			len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
+			valid = ((u8 *)ctx->resp) + len - 1;
 		}
-		len = le16_to_cpu(READ_ONCE(ctx->resp->resp_len));
-		valid = ((u8 *)ctx->resp) + len - 1;
 	} else {
 		__le16 seen_out_of_seq = ctx->req->seq_id; /* will never see */
 		int j;
@@ -647,19 +698,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 
 		/* Last byte of resp contains valid bit */
 		valid = ((u8 *)ctx->resp) + len - 1;
-		for (j = 0; j < HWRM_VALID_BIT_DELAY_USEC; ) {
-			/* make sure we read from updated DMA memory */
-			dma_rmb();
-			if (*valid)
-				break;
-			if (j < 10) {
-				udelay(1);
-				j++;
-			} else {
-				usleep_range(20, 30);
-				j += 20;
-			}
-		}
+		j = hwrm_wait_for_valid(valid);
 
 		if (j >= HWRM_VALID_BIT_DELAY_USEC) {
 			hwrm_err(bp, ctx, "Error (timeout: %u) msg {0x%x 0x%x} len:%d v:%d\n",
-- 
2.53.0-Meta

