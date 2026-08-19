Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C843552F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131057; cv=none; b=ZYrfQYS9ceHfXFv9iEPMXiJRbhSVqv1v6qTKHDGgQ6sBJLWITviCuBiSAm6CCglEvtkwTyJ/a+sO9jdTV5WAFpfGvKHmKIgHcvlSNkTMSJv6jJuFUMURKYkoFMHC97rIXka1HeJ3VUq7798/kUnBAvbV19X40JBVKhlyvFGeBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131057; c=relaxed/simple;
	bh=FvvqAkqApuqvz+pOl7MkjKZKagiCY1dA8U03bz3JnW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3YxAipFcZRnOePZlnXZC8Xol1zTw7d4PJwdQTqF+tynVJNiMrGCQh0zoPmAYBLcQPVT69wXCuBRHFNIG19vUVFMze1DtyMv94YGGffY64l4iwAuvO8WsYIrukN+Y5kee6UMFlg+GtDG4Oe/JA8WhApQwe1EXNY3+m32yivtt9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx3+VWWQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx3+VWWQ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso908370b3a.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787131047; x=1787735847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tzq7v/fxL853YGVhFMtCMQesOY95cKGN2c6UZbaDsmc=;
        b=mx3+VWWQAB7fpxckHESbHieM3I8x6/FuH3mCDunpk+quMLNes9iN71obJR5gvjj1Ki
         hGQBWa0/0Naq+swQ9XjZ5faSkxYcfTb56OfGZ0qHbqqu+Q5h7NDctDhf27tMGDml3L9O
         LVCxeq/grJOgu9CLoWvCnuKCFF58cBeO55AURC6K4nmhj79vEKz0xBH0L33rUt9g5pCB
         X8s+RaWewbACBybLBIrE9io3ga0Dwa2TBdcJ4N1mZU1wrAZJPuqF7f1/WaLIWHHtFfP4
         hzXowA0St0xOjbE9FyfvgyGHGcC+up9ZQEAwrMZG/UmAPeK5lFR1ePOqXLxR4+d5RZGn
         sNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131047; x=1787735847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tzq7v/fxL853YGVhFMtCMQesOY95cKGN2c6UZbaDsmc=;
        b=Jov71JHCjD+EU6aN2916D0l6tqgelgK9G4q93mhCcQqpIOlFx8NTLPkA1BhCD5K3pj
         MQ3aT6TQ3Rx5dujC/S76/gAdOiHE8Kekw0oGFkCVVv3yCTqg+72JDIEUT58d7uqO8CNF
         JFKuM70+vboyRagim6dhwTbaRJlqOWuFkWUGIeiMzK16/LLqa0utRSl7EBzk+2wohmfG
         3+si+/F5/h6JlPM2xQBhSzR3BVvGDwwMcGAxFy8rszPrBnjY2bBxi4/n22hHTfVqau4H
         hvqwgsz+phuY5f4mFTwBIS8ZnIC2oD+GOM7E4t5rdBFJKnIfxAxm8rOA0idUrPGKMAVN
         j41A==
X-Forwarded-Encrypted: i=1; AHgh+RrS7I7snH6JMr2nUdN7M7Fm6XfgORMWs8QDBwRCqN1v3hGi9Ie9JtOzcttSXUd8CB309W1eKAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvKtjiRN82KlO+r2SBTpLARU7TYzXYHz4N4T4YT3z4I+TfKs9
	+WL4zKMh1IVpjzO9pxo802229+S5RO35X1F+0ll7B7kN7rViDj1MeqFA
X-Gm-Gg: AR+sD13/G8NRP+16vUhWTBKtyF2EIu+cMgBB4ML6Bi597Wgxmx5KXxZBsktoK9rtyVJ
	81NS4yrIE3hHFpsZOnOp/MWbMOb/FUQ+vpKsvatRLTRJLyUxKymvyeRMik2JOm1q5oNUzCKsDxF
	7ZuzFCVErEEzP1SafxiTDqcKyrBxULoVi20F75Qa78ZLnNDs5j7jA5VG+e7xit/NVWY1ZxecWIn
	WKullJxttt+yQsgxzZlc6NDgGJpigzp51QrLLNoK6viDajV+tKgCQwHj+1sdc5dbu84a8KK0lhx
	bJuR5XdGtYE8/ZETPgasVbafNX5wYJX8LdoddY8lWU6r7T01uaTQNgoI+xghSA4Oz4tZ0IAhUOH
	NXHk4/0qE/48cdiWFRucE7trSnC2/8Ryxll/+LU4d4YH3rHzDzbDE9f7PPbgUeN5gDeT+zt7TA2
	Ac1QO409pJmH+x/Hsi83Oz3ccPQXwUFDGuGp+BEhH4sf/r2kc+nOY9PURwSCRw7N4VfjuA/4KbK
	dKxH5sb4mOTut+2O3ZxBPmKqLNCODTqUiYYsP4tg3utl/igJCpbG8EVRvQFMj1vCGTT+Q==
X-Received: by 2002:a05:6a00:189c:b0:84f:b01d:3693 with SMTP id d2e1a72fcca58-851d39419a7mr4521617b3a.15.1787131047417;
        Wed, 19 Aug 2026 02:17:27 -0700 (PDT)
Received: from localhost.localdomain ([203.8.118.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d33b635bsm413423b3a.26.2026.08.19.02.17.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 02:17:27 -0700 (PDT)
From: James <aslan.jnn@gmail.com>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2] net: amd-xgbe: support receiving packets with bad FCS
Date: Wed, 19 Aug 2026 19:16:56 +1000
Message-Id: <20260819091656.23943-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260812091616.35811-1-aslan.jnn@gmail.com>
References: <20260812091616.35811-1-aslan.jnn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd-xgbe driver currently sets the MAC_RCR.DCRCC bit whenever RX is
enabled. This disables hardware FCS validation, causing packets with
bad FCS to be accepted unconditionally.

This change unsets DCRCC so that packets with bad FCS will be dropped,
in-line with typical behaviours of many other network controllers.

Tests:
- Verified that packets with bad FCS are now dropped.
- Verified that receiving packets with bad FCS will increment the
  `rx_crc_errors` counter.

Signed-off-by: James Nugraha <aslan.jnn@gmail.com>
---
Changes in v2:
- Eliminated DCRCC toggling via RXALL: now it simply sets the
  correct default value on MAC Rx enable
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 2de974213..3ceb130a0 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3400,7 +3400,7 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
 
 	/* Enable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);
