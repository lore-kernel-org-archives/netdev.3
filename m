Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F918364029
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791690718; cv=none; b=ujmLd0MBTMJ1aAVG1QKuaoOZz00SnN2tE8J6iMs5hc6gSQ1h++t9TloGI7fDGJj76I7vtk26FjYYFiLWDDf+bbKNVe/HrfGU0Tm9pEa4+41vrzwp7eA/FG0KMt+H0LSn37yUgy5ZSRHWGKMWW/s+D5YuyeCQRZgST9S3ltP0y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791690718; c=relaxed/simple;
	bh=rsYl2evSxKIO+SY5ef5tx8ssbRNTBeYHiGZ0B0zC0F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5ZNBaMTUwRkhhBXfLRFEGBmD5N6w+ktECbXkBZlRGnCuL34GnBcQNGvb72SzvPSJbihKRYNGHtGa6f/tzs6M9z86gnAcBVxiZ0euC0yfDNPXpnH3g4lKH01fRdNJ/2lPKmSvwP9Ps67UabMlYZyYEpEwD7Lvz8yz1/xX7cyt2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGOGWf/K; arc=none smtp.client-ip=74.125.224.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGOGWf/K"
Received: by mail-yx2-f5.google.com with SMTP id 00721157ae682-8ae946560ceso2838827b3.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791690716; x=1792295516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuaSUooYMWjiVC3in8ithjctEvqzUlOvqy+QwP+9O/Q=;
        b=YGOGWf/K2syJkwyB/x8MUt0E2WuH/vILIJDu2edKk3jNkx09BmMFCDE8IY8VSjdwAx
         HN67J+7ECq/VIRc76YuM4BwY8q/oN6bW8nCV1obMsK38R2xj2OapbrcERtkganxCCOCi
         P2snNmjjlzKwBFtN9CBX+bx4VhO7pnpbfbHriqHIWrhrON3uLIqAo66BvQDY66ni4P9c
         X6S8e8pwGlHhmq6XijfVgN5Ev/nhd+PgcJg9AYzBLcv1ITOV4YtheVxi1AG9VV2GfRaK
         3hCVtS/3FVCeUxDq58SpKkGpYF4xn83UG97P6PFkrVHQRN7prtCz/2RyYchS66wf9xxr
         6EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791690716; x=1792295516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuaSUooYMWjiVC3in8ithjctEvqzUlOvqy+QwP+9O/Q=;
        b=ezegjslW4NVUWMwV6fy6G8RQKzEGBy9hiR7XCdLqOfIhQy+2qS5F1LEFxhQ9RHyH7v
         34/K+bet1CybmF/tG79ZP0Ku11OggwHUbX4e8zeDZ31mG4cjWArZyNrpMcmgkgdq9GaZ
         q4QtKV9yLJXOaLJ0cUHEMIPWsUqMzK3GwHBeKjJ1MqXTXQUs6me0HGdts5CstchQrVgM
         qlWYzewGmsjP+t5y4Da04KZnLx/dH3ZsrWXTrGMJOlRvh/162pKARIaTC72MNoqcMPZq
         vKDqPRUuwUGcNtTBmwaSqRt6sk9VAYd/L8sbakahgwwCMVPTdzwNpknib0hrDj28l75R
         yX3g==
X-Gm-Message-State: AFq9FYKgKkzyuwxxFmZIimHDqM43GpLOdPS9Bb9aDpShISITZEfoJCFb
	Ps9xB0m6+1p0Qv63TvMvJjTuYn0BnO5qgO7NdBaII0M3hk4/QdKfG1MtkH+s316wS9M=
X-Gm-Gg: AYBFou1vQu82p3CbzML1Fu9OocYEkIjJWW5o6CR63i+YSFioIXFujE8uZhgYi43/qTM
	R0BOsaam+kjlzLH0W+M7RABpM+vcfrusfHLTopEiqxCRXQiX63MInh/e0PgyVILVnEI6MG7Wb0E
	i8cd6UFqk/I96RaQQ+uavTWWCYqT0IkM2w20Qdsa3ShnEVpreAMl8uhjZNepgVgK7J9XN0CIXmz
	KzemOxbUs+DG6Aw8zwoxakkKP/Ri/AzYFLQmyGGTZEK38K4wGttOd/DUFBk/zwiWkkSjzc8zQGz
	kBi+xnaK0vtO8TQkj5OAbnj1P9nA0Fjm9I1G1O5MnQrqKn6NRdYd/vEWv7XBoixUAS0JQ0OJBdr
	b68X9Hs8kelrSO24KzJpkz5zRTmvvSoNNzbcrYXaAeuAY7e+EA4cHdz3tPsEJLNYhQSeJ4IVH+R
	xfrjsrehe23liWa/jkHsl0tWQZRA3I7HiYg78XP/GFnEmJ+yNi1OWQrpYcBimpHteHlCZpUlvDN
	0BGAc4/iXYQhWgQHDNVU+D3j1+dxvmS9QrgtY5mFTgv4QvU3p8=
X-Received: by 2002:a05:690c:c045:b0:8ac:36da:c494 with SMTP id 00721157ae682-8b07ed14cebmr16160647b3.38.1791690715908;
        Sat, 10 Oct 2026 20:51:55 -0700 (PDT)
Received: from Xinshengs-MBP.attlocal.net ([2600:1702:7d20:7d20:68ae:b2c8:bae:dcc6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f226b50sm22161307b3.28.2026.10.10.20.51.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 20:51:54 -0700 (PDT)
From: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	oliver@neukum.org,
	giuseppe@southpole.se
Subject: [PATCH net v2] net: usb: cdc_ncm: reject short GET_NTB_PARAMETERS responses
Date: Sat, 10 Oct 2026 23:51:50 -0400
Message-ID: <20261011035150.53315-1-xinsheng.zhu.ny@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usbnet_read_cmd() returns the actual transfer length, but cdc_ncm_init()
only checks for negative errors when reading the NTB parameters. A short
response therefore leaves the missing bytes zero-filled, and
initialization continues with parameters that were not supplied by the
device.

CDC NCM 1.1, section 7.2.1, Table 7-3 defines a 28-byte NTB
parameter structure. Require GET_NTB_PARAMETERS to return the
complete structure before continuing initialization.

Return -EIO for short responses, including zero-length responses, and
preserve negative errors from usbnet_read_cmd(). This ensures that a
zero-byte response cannot be reported as successful initialization when
rejecting an incomplete response.

The issue is theoretical and was found by manual inspection of
usbnet_read_cmd() callers with LLM assistance.

Fixes: 36c35416a94f ("cdc_ncm: fix endianness problem.")
Signed-off-by: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
---
Changes in v2:
- Return -EIO for short responses, including zero-length responses,
  while preserving negative errors from usbnet_read_cmd().
- Add the missing Fixes tag.
- Changes of description in the commit message.

v1: https://lore.kernel.org/netdev/20261005041525.49111-1-xinsheng.zhu.ny@gmail.com/

 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 35db38cb3e4a..79893d2342ca 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -524,9 +524,9 @@ static int cdc_ncm_init(struct usbnet *dev)
 			      |USB_RECIP_INTERFACE,
 			      0, iface_no, &ctx->ncm_parm,
 			      sizeof(ctx->ncm_parm));
-	if (err < 0) {
+	if (err != sizeof(ctx->ncm_parm)) {
 		dev_err(&dev->intf->dev, "failed GET_NTB_PARAMETERS\n");
-		return err; /* GET_NTB_PARAMETERS is required */
+		return err < 0 ? err : -EIO; /* GET_NTB_PARAMETERS is required */
 	}
 
 	/* set CRC Mode */

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.54.0 (Apple Git-157)

