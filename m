Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60393DAACB
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792651; cv=none; b=RXlAgnRd9lAtYOrOY2qVskxCXqjlN4/Ub29fgeppLEJDeImfI12DUATUaLg2VQwxklR9kKuUAdU0h8SSOFcJM6T+Arx39DHal0aBOZP9+LPohbzuclsL7GgVtQThbn7bcK2ks8n9s279sDi0588CnODt4+QNCbwtF9f8oRcPcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792651; c=relaxed/simple;
	bh=gLQ4S20QbAFSS87VViitTilsh4wYPJVg2NOW9XEM2mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ka5AB6iSYt3kakBekyHI1SkmSAqJeevNJMksmF5xSH2uHOeDk5rCQ1Omvq1KmxIIfm23AmgprZBwXANvVccv7jqTlKQVPsOvutCp88yQjqOCD4I2GiMR1ToGAkSIzfxxveAMlJLbYi8y9iQ3o5i63va/+GEHd+v+rEavjrg8nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUL7lDPk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUL7lDPk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b966dd74so1921515e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784792648; x=1785397448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MblM2TM8BGuW7T2s+VRM2b21exbLaiD9GJmSPm/AYxg=;
        b=qUL7lDPk08pqlgzPfwR4/UdJzpOjVIdf13U8DJEBV2Y6CQsnxwKeX9NsW50FwuauPw
         6VZZHIfciXdM74QA0kgxZF/Mx59ybcl/f30GY7HdFBdI8DrUbm8Bep/rNn1mXkUzZu0T
         coKMq7ubbRftnBnpHmsvTdm4thQcT61AJuemauqy4y1KiXlqHE1AgA944YC7DacadL0k
         hR03vMAY87UKIgXraj8Ea73SxTVRJlhSoCKgM+PHl21x68u97I7jA2NJfqjEj39F/+DH
         R90N8qwlbUr5sMZPhZDCbbBMqpafE1IASg8f7kSGCejPkd2T07AjKtzJHHLFpn4kHvGJ
         M10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784792648; x=1785397448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MblM2TM8BGuW7T2s+VRM2b21exbLaiD9GJmSPm/AYxg=;
        b=QAbqh/DAVBhNykuYewVX7BDoK7XNG8/NgcDf9UINaCjHaNNBhRCV1WYXNvZmAR2sMb
         RZCjrHQeJpKIz2w1RxRNmlxmQlVXBJO2JHE+FNhA4Fp37S28Izr+GdMtizuKfkz05ehU
         Jkt+pBjT+0gr/u7SOKdQyf+1IvT21kvqCN4VsqUDxJzjVh94uRgDLpSbe1kwIZUlOUTm
         Pdj49MFfsn3gAKZV7PCyexe0KWXW8GP7vRNQKK8LF1ssOhkLOXO4NbP/GsU+/yRGIZ0Z
         wlFHoPXUayEivDuXIgBhHbmgLscy2mleR0p4/Cvl3Tyo1jYzoGxhGVsb5mTcWNxOQfmL
         phPw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4W9BNuO6mf1AFZHicMy1lZGcr16zWSNsISGMyKcsQDBnU9UOOi0XAI8ee6zmksqMsArGXlLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCnQ7Vwb9GvrgKDpb3aq/dZI/0tDbt+A+7oLzutpbTxc2EWXSD
	fXSi3M0N2eebhIhoFcq/qceEFBs81V7eMZV5ml66aESYtXCQi+x476x6
X-Gm-Gg: AR+sD12dUalbGIvQA5dXQM4Q8hFHBJ9A6ZccxkL+3O0cyLiedA9J32GIXT3Y3bskuZ9
	DAgMj/CbA4x1eSZ963PnCF8oV+UJX0hnuRaZvhFQxddmZLWAtg5sJIKrmhtAGrDvxU5BeDqdkOt
	xQYAT2VZipMU90V+foP7KYI11FRSqTsGz8RvvgHKYAEQX4eZvuyqWpPhGPrVU80UHUw1NXFem/f
	CwQFFI/fDldngiOd0J3Reyngv9qFsL1uQkBCglmGdhIteG7gHx4dG/VCR9q2jgjtcs5dL+ziPdb
	ULsd24ZmVDSjvc6kT/UjHHv16J6wS97QxkmN8+SEYnscuShFGGIYhBxQ6ryYI4k6zYjICl6uX6Z
	ODE4mpfaRRQCtFSIdkFDL0lZD6Vb7t2K6NCBWTZH5iqf2sRvX6CcMpqU3/+56VZIlllQ41JHypk
	WPN4VFKhlwKJqQ92R7eSdWdP4XNLg=
X-Received: by 2002:a7b:c443:0:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-49573d2068bmr12443275e9.29.1784792647703;
        Thu, 23 Jul 2026 00:44:07 -0700 (PDT)
Received: from LAPTOP-AVI.taile24b5.ts.net ([2a00:a040:1b7:4f41:2931:f9dc:7c7e:1085])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm12333857f8f.0.2026.07.23.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:44:07 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: linux-can@vger.kernel.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Martin Jerabek <martin.jerabek01@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] can: ctucanfd: handle bus error interrupts
Date: Thu, 23 Jul 2026 10:44:03 +0300
Message-ID: <20260723074403.131575-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include REG_INT_STAT_BEI in the top-level error interrupt condition.

BEI is enabled when CAN_CTRLMODE_BERR_REPORTING is requested and
ctucan_err_interrupt() already handles it. Without checking and
clearing BEI in the top-level handler, bus error interrupts are not
handled or acknowledged.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..0cd2d428c1f1 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1136,8 +1136,12 @@ static irqreturn_t ctucan_interrupt(int irq, void *dev_id)
 		/* Error interrupts */
 		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
 		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
-		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
-			icr = isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_ALI);
+		    FIELD_GET(REG_INT_STAT_ALI, isr) ||
+		    FIELD_GET(REG_INT_STAT_BEI, isr)) {
+			icr = isr & (REG_INT_STAT_EWLI |
+				     REG_INT_STAT_FCSI |
+				     REG_INT_STAT_ALI |
+				     REG_INT_STAT_BEI);
 
 			ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08x\n", icr);
 			ctucan_write32(priv, CTUCANFD_INT_STAT, icr);
-- 
2.43.0

