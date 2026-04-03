Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE23D75A6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245474; cv=none; b=R+Al9Dpfuvwecv0QUbcxGnn7c6meKCNrbOWOkWWtLpuk7wbzLmDm0en9FOKvF54NDM/6YEAULNP39eyasc0y/SmaYKllLmwSeuc1UblZDLBRGwpr7x2+le8UD+g0x5I9JBTUuLtUBDecyozJCW/8nhGmlG+B9fvxanMl8/c7IMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245474; c=relaxed/simple;
	bh=Iw9hesK/z+Sol4hOcO0IKD8CHg80WV5FOkKP/IYo8X8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxQCV1aA2GMEwipikeL6Kxtmpg32PlJqD+DJv3YHQtG1NYLnpSNW1LKNet8dRr9Sx0u0XkizshyMUYozO3DX31imb/dOgaEbcaFvm8SiaYY7BQYpdYZ8ynuE8SaZlxrUp+dReaWmgVVC8aaBHrhkHJJmpe1k26g5ebnVewRoovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1QSJi7Q; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1QSJi7Q"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35dacc40f92so1766990a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775245472; x=1775850272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vg+FZOIEHE+zfB8G7lvyICT5yA9ZsHjkEh6u1tNePYQ=;
        b=t1QSJi7Qouba7iiq/RKPkzJfHwjNyrp3cOvbpxPs/tA00aPub0Pz/DkN9J6AN7WB2U
         y3fqi5V65OOlRYdoOLky/pgu5M1iuTuqQwn7M0TpcY4zFTBKxSOyKEVxpEehhAUg9+od
         Alz8G99Jpw0t9Faxhajl0lVjskZIpvdXmAzmrdGCAnDv5/vP48j1ZlutTo3jfN4q2+Zw
         lQ0GuMy17UAZW7x6/nBCbxh00mFthdJj5y1nLv6XY67hXXjLw7K29o383r9UzaJ0b/2L
         bQxP2rTNohfNoT9Xk9LKQCJ3AiupTDfq53lTYZrokwnOGzPicpHlKChd/UC0j9bBGOUR
         RqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245472; x=1775850272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg+FZOIEHE+zfB8G7lvyICT5yA9ZsHjkEh6u1tNePYQ=;
        b=csIaf50rbCwObFU8XkXlsE8ZtVkwoDKZhy220V0ou8ZpGtf2Dh7ktAvuD9zJW22bTN
         K7jNfmXYf90PNhQXjzWm1g8GEEPUyziSygAuhYDV6R0OcnVSPoBu1wq5y1lIkNsVvMHG
         2ItbQB+xlDqvgRIy2KHylQSUR+rkU2X71AF7NisY1ym75F4+na3ZEi5clCMI9xVBB68k
         HDTThshaFlvBdb9OyyUKWHQUIWWtGMai3p/k52QUWtvNOudzbRGIvDLbetXFBivROJTn
         d913XokIn4F92TMu5gnDr+2dRJtqgmWLsXouEWsQ81+m4iTYHxHZ3coFQtOpSPEJHJWg
         0/kA==
X-Gm-Message-State: AOJu0Yw96SlnVNWAKTa5v1GTrArglQ13U9+YsHAAhu9Np2sG+FgPl7rD
	X/92f1scGDS0kqgQ0FBnliXOTbuXVdpZvmINzGK6bTJ4Nf4wvoltvpchxuXVQ0M8p7EdA83bs4B
	Qbh4JHJxqydaJQItZPmNTt6uGDKrLu4yQnwwOq/0un73Wn22jAmJIuHHoRxWcKFkWhNVw38dQp1
	XG6+xUUU5K0eKu7PWbHulQVsO6ov1pFxZaanPVYtgk7TyAiricFeKdR9pMH4jjYuY=
X-Received: from pgll4.prod.google.com ([2002:a63:2504:0:b0:c73:bade:9641])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:394a:b0:35b:929f:7e8d with SMTP id 98e67ed59e1d1-35de696f281mr3451466a91.14.1775245471979;
 Fri, 03 Apr 2026 12:44:31 -0700 (PDT)
Date: Fri,  3 Apr 2026 19:44:25 +0000
In-Reply-To: <20260403194427.1830609-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403194427.1830609-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403194427.1830609-2-hramamurthy@google.com>
Subject: [PATCH net-next v3 1/3] gve: skip error logging for retryable AdminQ commands
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, yyd@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rhee <jordanrhee@google.com>

AdminQ commands may return -EAGAIN under certain transient conditions.
These commands are intended to be retried by the driver, so logging
a formal error to the system log is misleading and creates
unnecessary noise.

Modify the logging logic to skip the error message when the result
is -EAGAIN.

Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 26 +++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08587bf40ed4..c7834614c5f0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -416,11 +416,6 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv *priv, u32 prod_cnt)
 
 static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
 {
-	if (status != GVE_ADMINQ_COMMAND_PASSED &&
-	    status != GVE_ADMINQ_COMMAND_UNSET) {
-		dev_err(&priv->pdev->dev, "AQ command failed with status %d\n", status);
-		priv->adminq_cmd_fail++;
-	}
 	switch (status) {
 	case GVE_ADMINQ_COMMAND_PASSED:
 		return 0;
@@ -455,6 +450,16 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
 	}
 }
 
+static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
+{
+	switch (opcode) {
+	case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* Flushes all AQ commands currently queued and waits for them to complete.
  * If there are failures, it will return the first error.
  */
@@ -482,9 +487,18 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
 		cmd = &priv->adminq[i & priv->adminq_mask];
 		status = be32_to_cpu(READ_ONCE(cmd->status));
 		err = gve_adminq_parse_err(priv, status);
-		if (err)
+		if (err) {
+			enum gve_adminq_opcodes opcode =
+				be32_to_cpu(READ_ONCE(cmd->opcode));
+			priv->adminq_cmd_fail++;
+			if (!gve_adminq_is_retryable(opcode) || err != -EAGAIN)
+				dev_err_ratelimited(&priv->pdev->dev,
+						    "AQ command %d failed with status %d\n",
+						    opcode, status);
+
 			// Return the first error if we failed.
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.53.0.1213.gd9a14994de-goog

