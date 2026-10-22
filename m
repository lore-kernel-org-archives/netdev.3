Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699489;
	b=dsG5QuBnEYrbp+ohDqGx/lIpVNAUz2ETKacm7SSG3OacfIgEJk2+ef/Nym5uX6DfUpbu
	 NKDSa34WD8rJBkTPMF4rRAPw6l9pYRTt7gO2amaxS6t/3T3RRgRac0b/y3CPnj35Lkzs6
	 o5tpY6F2MKjhZOLDkNvy6R2v7okAC6Uhj+oT0FlxcAP9sBJUUdf24PNMKZh3P+mOYuEum
	 8RJd9AMed3h+O3vceDMkFQ8o3/zjcjELYtuxPKstwHPQuI3IsxFyciPCyF2WR/mNZkL69
	 B+Z52TXAOofAEgvhC9xtatrlCJKpww58GXrEZyzjQ7GbKXpgKpBYTZfIYL72XN4i4Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699489;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fPahIDrO5GkN+GCZrLkZ94awZIthv8Zl17byf12rGR0=;
	b=mn7TW0DdLR4GbM20IdsKNmrcchWiqvdJRrjdQHlxT3QFRlQKgPrTaETJToOtAQYuNBJu
	 peEi1n9/IuteT0kXDDswn5Pv6V5t+rDb8qJxDlQGAVqzUMrK9TppdTIP91VpL5EV2Bj9i
	 mHaY88G6VOjnDc/Fx183ST7S6Y5Jzrg8DNN8eGm9bGqfVWevA1XY+PnvEU4gG7JteVQa4
	 Z5HSFnZ/OrAF5OpETx0XsHXcMl/OjCDUI/s6fUs6yjVZjkZg7alq4dWeH+aY1X11HOMrb
	 go0jpEdpTPh5QFI+groFl7H6YwvXwo8gnppN2wt5VUSWsRWXpWJQf3WxOwHigapS8eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AMA0H1dD;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE01606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE01606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AMA0H1dD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792699480;
	bh=fPahIDrO5GkN+GCZrLkZ94awZIthv8Zl17byf12rGR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMA0H1dDv5AHgt8g2zUPvSAvVkKVIqIKtLTN6XOkTkVcZDCCyxJI7qTcXKPJSwPPI
	 bCBr7vzDlbqVOhtjFNOEbifQvRDex8cPWuVplnfU15ZzLlYNGfScEEvIajRFGXT5kP
	 D/nkmU90cXM3ecFGqpGorjCMnDx0xPeL2OJHs9cg=
Received: from localhost.localdomain ([180.165.29.111])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 12294C65; Fri, 23 Oct 2026 04:04:34 +0800
X-QQ-mid: xmsmtpt1792699477to22nigmn
Message-ID: <tencent_920A69A08AE91025A2F5D4ADC3E555862E07@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOKq7ibEX3WuWDIjWmbten8SJMEG39scE1T8eJ0NAPJgiJ/SUXzV
	 JU+duA7k6jeIHPDz9I4Cq0L0/q3iPOjwrC/gTkTroxMCIB5HfbBjSTNzEaOCLlNSkAUfjZjqKV8h
	 MIONymkO6Av7AVkiYFDfWu8Pa6FUx+3/NAlo0f9ZP1vIJVlz6QbV726dcUlf5bJS6L0ejVdzItD9
	 It89xCczN5uZ6OgtoPI38sF1idKeEQZjie1Jrh2sYVjHWh0yR+HlcqBxCceIraM+rSw7fwOsUFiS
	 DG+h8gUTJVna18Z0293ccVcJUZzWAeil1GWHr9WODMx2/6L5ju5B3sJp2GVXJPsof4S0Pb0COMZJ
	 Uo9q2NU9PxDMLiF/Uy9IPsEg0lz5Itm2o0EtGlzI1W9nyzCUFFFeV980K4e/SEhwcFOSiaGSTeaZ
	 FdDrIdRm5MdCo3oUC+89WntrQVvyYmoEcCsN+TWUs6/V2W1N66AIraJdMgs+MX1TOaJ2IMKopSNs
	 F/cmRrHZfJjA7L2XTkaY6bVywpees+u+zvd2AYqMFdLHMEW1Ps70azyUokYEHqs86fWDOHE3Cfis
	 gTiy+zW+lUUGmyNCNI5RC3IuqXOnYXawMSyd3pvlRsc0YP/kEUQOkzDvw8jM+exsu5uVrK/1DKch
	 L1nvLsIKohYU2LWktd8pGVOIP4UruXqFmjNzgASadMxrU6QTsZiEKYMw8fFieQc4gSa/eZ3y5R9O
	 VeGyKKpXhV06m9svlRPnWe8UHHseDCCdp/FWOIL3K6Gaf98uXb7kV2RWHetWm6Kw2aBbKN8EOwu5
	 4hLVjvgDVmLGhFH2a9t/leF2H9S7xxJFhBHmAguiOZjdFVYcV/YlNTAjkM4boQk7lTMl3TUymkAV
	 7/20RjKnL36zFq7XxpPK64MLaRxUeu+S4H8kzTkaEVmUl5TrDyRPYy1KLSwZlJ+KOX9UtKxB96A5
	 IwWcT/mzroIEo4p5QZXS0cnTZV8SYbbPF9XQKX9U3Jk+HZVgBVnvhXaLtKWDYB
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: memoriaru@foxmail.com
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	johan@kernel.org,
	kuba@kernel.org
Subject: [PATCH net 2/2] net: dsa: mxl862xx: reject bridge_id 0 from BRIDGE_ALLOC
Date: Fri, 23 Oct 2026 04:04:34 +0800
X-OQ-MSGID: <20261022200434.80182-3-memoriaru@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022200434.80182-1-memoriaru@foxmail.com>
References: <20261022200434.80182-1-memoriaru@foxmail.com>
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

From: Zhang Hewei <memoriaru@foxmail.com>

The device controls bridge_id in the BRIDGE_ALLOC response.
mxl862xx_allocate_bridge() only checks the transport status (ret < 0)
and returns le16_to_cpu(bridge_id) verbatim.

The API header states that "ID 0 is not used for historic reasons"
(mxl862xx-api.h:243-244), and MXL862XX_DEFAULT_BRIDGE == 0 is used for
the CPU port. Accepting id 0 assigns fid = 0 to a standalone user port,
merging its filtering domain with the CPU port's; duplicate non-zero ids
returned for two ports collapse their per-port FID isolation.

Reject the protocol-invalid value 0 with -EIO.

Reported-by: memoriaru <memoriaru@foxmail.com>
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 12cd407..dbe2001 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -593,7 +593,16 @@ static int mxl862xx_allocate_bridge(struct mxl862xx_priv *priv)
 	if (ret)
 		return ret;
 
-	return le16_to_cpu(br_alloc.bridge_id);
+	/* Per the API spec, id 0 is not used for historic reasons. Accepting
+	 * it verbatim collides with MXL862XX_DEFAULT_BRIDGE (the CPU port),
+	 * silently merging the port's FID with the CPU port's filtering
+	 * domain.
+	 */
+	ret = le16_to_cpu(br_alloc.bridge_id);
+	if (ret == 0)
+		return -EIO;
+
+	return ret;
 }
 
 static void mxl862xx_free_bridge(struct dsa_switch *ds,
@@ -1513,9 +1522,11 @@ static int mxl862xx_port_fdb_dump(struct dsa_switch *ds, int port,
 		if (ret)
 			return ret;
 
-		/* The MAC table capacity is fixed by the device. A walk longer
-		 * than that means the device (or its firmware) is not
-		 * responding correctly; bail out instead of looping forever
+		/* The exact MAC table capacity is not part of the public
+		 * driver API. Use a conservative upper bound: 16k entries is
+		 * well above any documented table size for this family, while
+		 * a device that stopped responding correctly (e.g. firmware
+		 * crash mid-walk) would otherwise keep us looping forever
 		 * with RTNL held.
 		 */
 		if (count++ >= MXL862XX_MAC_TABLE_FDB_SIZE) {
-- 
2.39.5 (Apple Git-154)

