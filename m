Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C02848B2
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770407815; cv=none; b=BmHa09MqdP+3HkDyGHMtCXvMD1R/M3zvK+PqsVItFiIhEOYyMSAVaOQec9gDcUEn55WeSGJFeN83U9jMorJutGGUZ9+IMubdqiLbQqJsGLRVfgmucYK47OrFrN4vJ8vUuQKw/pzOEF2KhcJQIIND22CyGsCq/7g8U39ATngqgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770407815; c=relaxed/simple;
	bh=yOiNt1aWz3rmuRvVHG/FxRWDdY/QOPIXXMSzVnqbyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLVgmNv1O2EmouYUDrZMrQFBR1/SyC8xm02kre5I0AeXWSXAvAaPoQkyZW5pMuL2HMi5PcPltvRIs1rJUPZ/fIVLC7JzFAWPj46AIicB9hjb2Gngkw01dpOHUGrWsXrC51Nt/cHpbOOUe5I+yB7uWq+svQ9AW0tEJtXaXVk1yw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARqKUE7Y; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARqKUE7Y"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a35a00506so18109656d6.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770407814; x=1771012614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6IArvx0vdf7oFz1KRMa/JnNwWUDCFupKTsMgFUEvU4=;
        b=ARqKUE7Y2Ha7e7zYJTLhGEYwou/S8xCdZm7AhclSZCXuTIz1yvm4T5nwbWLCnno8pm
         0p1ubaKrygoCOftkR7ALrIaoEHpWD7w/lQlIvlOvOEm9v3X+JbUYzd+Ra7cBWCSXAdME
         FkVF2LfUmLqinnzcbHJkQ64D4th+0DrqXuBRvkb1eBGyIGSgjAumQ8ex5hKkanyxmRmQ
         35k3jl9RSYSn5v113AdGqZagl7C7K3x3hPxA4qP0zFUhjTroKAwuAqsb/zUBs5cRVT2M
         oTAE3x62aIL6DT9tLvArY6zGfiAkGXKg3Z06UxeO8nAOiRUaH2K3IRv5YgpOcsvPeuU1
         LKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770407814; x=1771012614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6IArvx0vdf7oFz1KRMa/JnNwWUDCFupKTsMgFUEvU4=;
        b=FndxOtPYPAgdh/YJL2cG34l5uoVivvPBePR5d2vvx+1qnmXNko+ch3BNibeVlovffM
         4CfxdbJPKbnhOPkWQVkxN/PYV93tMkxCy9OedVJUW1VYQ7BkgBvcGSgsSvD9pF3ERw27
         +WAnN7MFJqllBG9H7rBQyCZER+lYM2GpKjV0zZSWBM6B7X/FghhEAl42EjRCy58QStKQ
         V/myBA+XCE7C39rbpDI+9s7vZssrmOYJYRogOpQQqluPSYBBnmD4BTEl7vKX4pA9L1r3
         M3/P5vEgnk8R6JE12OyBMFcn7aUyEDnijzjmkba/VH3/idDtnTH3x9SDLDy/YevCW8eJ
         cHxg==
X-Gm-Message-State: AOJu0YyFdghGi3f5lUatZkVtD0ASc9JkSUT12BKKYQDodN/DiBtEYxlN
	xZi3YS6rlZVwX7RhXgnXlQ5cgZsi6bVwHGiNFCtJXqCvAbqtwiAlSp38R/skiA==
X-Gm-Gg: AZuq6aJ7Js4pTH4N7YR6Idcncg38kDOERWAkKDxDviYrS7jSLtXiabpY67SG+babB3r
	tRhaNHsRj5b2EfxqfWHgLs2XMhAQrlBku2PQ5M0Zs3AvCp+76rUEUfaPwUcBEiiNK7qpjWbHn1q
	1j2iJheoqmd+gdfzhAif+sCbXvfZg/rfcKpqlQMDPsx01NhfYFqDcYDJAYBIoD31DhLS/aB54l+
	oFa8Q485mJzc+gxVJo/1eRVnubycP6t3ZAU2Gr+41FicOIKVhW5QbtaE9at75PJydKwBUqyuliz
	cbOvnM+nWKlznBh0r22jnpL/bKHW+Smdp7i1C8UB0pDCXrkHWBoQ+9FBgqrUAFwz5epFztP3vNv
	ELJS5vWpbiZQzZL4ZhHAJWt6m6EsR8XYlecho8NUn1aIf0imzyd1+wGIQI1zWEGFsQPlhCY834M
	jU2RF8otF1UcvBINzzTZUujqBkQZgfCo2pW2ZNM2K1uDhceV8JD8BnsQVwl84AGPz5vTgUya03+
	mk=
X-Received: by 2002:a05:6214:e6c:b0:894:68fa:37e6 with SMTP id 6a1803df08f44-8953cd9897cmr55323726d6.58.1770407813759;
        Fri, 06 Feb 2026 11:56:53 -0800 (PST)
Received: from localhost.localdomain (h69-131-24-92.cntcnh.broadband.dynamic.tds.net. [69.131.24.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50638c37b75sm23139701cf.0.2026.02.06.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:56:53 -0800 (PST)
From: Jie Zhang <jzhang918@gmail.com>
X-Google-Original-From: Jie Zhang <jie.zhang@analog.com>
To: netdev@vger.kernel.org
Cc: jzhang918@gmail.com,
	jie.zhang@analog.com,
	horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: fix oops when split header is enabled
Date: Fri,  6 Feb 2026 14:56:38 -0500
Message-ID: <20260206195643.11333-1-jie.zhang@analog.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For GMAC4, when split header is enabled, in some rare cases, the
hardware does not fill buf2 of the first descriptor with payload.
Thus we cannot assume buf2 is always fully filled if it is not
the last descriptor. Otherwise, the length of buf2 of the second
descriptor will be calculated wrong and cause an oops:

Unable to handle kernel paging request at virtual address ffff00019246bfc0
...
x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
Call trace:
 dcache_inval_poc+0x28/0x58 (P)
 dma_direct_sync_single_for_cpu+0x38/0x6c
 __dma_sync_single_for_cpu+0x34/0x6c
 stmmac_napi_poll_rx+0x8f0/0xb60
 __napi_poll.constprop.0+0x30/0x144
 net_rx_action+0x160/0x274
 handle_softirqs+0x1b8/0x1fc
...

To fix this, the PL bit-field in RDES3 register is used for all
descriptors, whether it is the last descriptor or not.

Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jie Zhang <jie.zhang@analog.com>
---
v2:
1. Update for the latest net HEAD
2. Reduce crash dump message in commit message
3. Add Fixes tag
v1 link: https://lore.kernel.org/all/20251202025421.4560-1-jie.zhang@analog.com/
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a379221b96a3..8adc02003517 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5023,13 +5023,27 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	if (!priv->sph_active)
 		return 0;
 
-	/* Not last descriptor */
-	if (status & rx_not_ls)
+	/* For GMAC4, when split header is enabled, in some rare cases, the
+	 * hardware does not fill buf2 of the first descriptor with payload.
+	 * Thus we cannot assume buf2 is always fully filled if it is not
+	 * the last descriptor. Otherwise, the length of buf2 of the second
+	 * descriptor will be calculated wrong and cause an oops.
+	 *
+	 * If this is the last descriptor, 'plen' is the length of the
+	 * received packet that was transferred to system memory.
+	 * Otherwise, it is the accumulated number of bytes that have been
+	 * transferred for the current packet.
+	 *
+	 * Thus 'plen - len' always gives the correct length of buf2.
+	 */
+
+	/* Not GMAC4 and not last descriptor */
+	if (!priv->plat->has_gmac4 && (status & rx_not_ls))
 		return priv->dma_conf.dma_buf_sz;
 
+	/* GMAC4 or last descriptor */
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
-	/* Last descriptor */
 	return plen - len;
 }
 
-- 
2.47.3

