Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2074AA00F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859772; cv=none; b=AhXfoDQPy4MiAKTSYOCaDTGS1w/APUAXjPMWR2xMN2qu9Gx3xeXiY6UZ3C1V5vW6N1XST/Ydo3WFxwIOGXxosYmiLYk1N/Q+RZSBA3vLKsk5W544QrNSDzGGqGheYjXIIO/8Xgade41nEWtYQH3PgWvPgdxDMapAt09mf+aclDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859772; c=relaxed/simple;
	bh=JY5O9vO2B4VoAM0WdI/InI3BZEF5TWQbgklizYNHjKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmEsKf9FOUDfeHYQNSYOvfx9+L7obZqKk5wlV/koXxqSjGLIFPe/PCDommft2uJPMf3qwPx/hFJWY/xmnkP0VL2mc2NsAEOSESwpNS6JxfE2Gjqdf6Wg3+Mh8TGo/c4YNpERwivi6abn5kDcrR/jB0BNcNIUHl5T0XYxetyZGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=FRZVCGxo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="FRZVCGxo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so37624465e9.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859768; x=1791464568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mQyLPOZY48s1kRZY5RKIdU0/SMyw14e1a6Wnp+y/C4=;
        b=FRZVCGxoBBmltmx1BOenAQulJ+ia4u98uvtAP/n/Ee4m4rIEtE/XPvKnxNU7gs+v15
         ExpLGMV/Gr353YQMta4xfz3VyF6eQTGC5/767aWqgmTkObEwhrM3xeCEbGPuHZwvJkvr
         hEhN3RSjuIxjcn81mY48yNnIbIPOgRvQf+znb26GoVEM90cWPsUoiTCJcQKYIxk+IMQn
         Gb75Xu4bWs8eB/SaaUy5aP+w/IcGWL95WVLeEzS8i16ihH+pkKX726rHzo+QtgLoN6Pm
         zOHgGOnQTQtPJR4eHaUNZj6nNyg1uGedduWFMukWAQzN+cKjs+enZfFcl+Fue270DPjw
         hA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859768; x=1791464568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4mQyLPOZY48s1kRZY5RKIdU0/SMyw14e1a6Wnp+y/C4=;
        b=Djk/Av6RHyEoD2DLs6xVdqFqkxUDtccex7Um/5pb3TqUg6lyKxaOZI3zw1Xe5qH7EO
         4vrijb9rAHXbi2fIYxGLJj8LO+bUdwSYiWhChTpg2r2wScRMkDgQWl6QF1LXUX7rXDgN
         U96gmjcW7VvbfB9sJSs6DA2orOBGsZtPGshwAM8S6xnEEdw+A8TruDMiw8u5s71pQsmC
         rYgTNxVQg7mVvux8y4lI+SUMIHg1CvCC0G9780dNrtKKtOQinmalPEsGZAvVBNgDtHsr
         WmaCPah+8HieQ/AE71tyx99fPWaSYK3AW6wuGoJTZ0DCdZEJoWpStUNBz+8mebzah0pL
         9Y1g==
X-Gm-Message-State: AFuF++ned2B4YWeZ7lJTXosOf5f0S0TCaBLBQR+uH9kQjAmTjSrWZtEx
	7S84DuPDKzfOE0crskphYBy4mHJbXSPEXGsSgTJpxfSixgC7D9FFNnMKXh58qTOEqqgBO5Q1cJ/
	aNoUOhUwp0fG7MmI=
X-Gm-Gg: AYBFou35L7bU+iqgMHS2CbfoY1HgdnW5qh1AXG26X13Nj/o+k/llnUfrnB7pOjP0qi7
	sPm8Wg1A3EALMZo9GEBILYeM7M703vrLMkFNxK/z7Nhf7Ed7R0w/7uU8723R2YcsOqOY2R0LXZl
	N5UiuqlYzWy1Yuk8s2+E/A/s0I9CkCx+JBUkLCuR3PUqer387KM2F4RWcz2nGYbJv7HXHDMMB2b
	yR9EoQU+uO99mNVYQVx5Y8OjWfZFWbdu0Rpd8m6QY7mwoeW1bxa+3b8fHbqHL1W3LRCocXajlQn
	OvpBNV7//fMz7+cE9WEE6bBJTU4dsJ2Ml8RdNIQsR21HoOMttZCx3RWc8f9S7qDWqAzeFK/Nr9f
	8bGAHikJOxYpUv8E+cJstDWPJczhg3lxQDb588gFTc7M2h4pgcmajlmcCWEJ6+rx9ZtXZyY6XYo
	hEgdiG9+uYUGplZuSO+VB3X0NMvX5GNX7ejgVKBBbRlndIoYtDaQ==
X-Received: by 2002:a05:600c:c3db:20b0:4a0:1ea1:477a with SMTP id 5b1f17b1804b1-4a01ea147d9mr40523215e9.27.1790859767632;
        Thu, 01 Oct 2026 06:02:47 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f913ecesm48051775e9.2.2026.10.01.06.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:47 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	olteanv@gmail.com,
	Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	steve.glendinning@shawell.net,
	f.fainelli@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net v13 3/4] net: phy: take the interrupt back from the bus on detach
Date: Thu,  1 Oct 2026 16:02:35 +0300
Message-ID: <20261001130236.106059-4-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130236.106059-1-f@lex.la>
References: <20261001130236.106059-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PHY's driver is a module that is not loaded yet when the MAC
connects, the PHY gets the generic driver first. phy_probe() then
replaces phydev->irq with PHY_POLL, because genphy has no interrupt
support. Nothing puts the number back, so after the real driver binds
the PHY is polled for the rest of the uptime.

Seen on a Keenetic KN-1012: the Airoha EN8811H behind an MT7531 port
has its driver on the root filesystem. Its devicetree interrupt maps to
irq 15, and after the real driver binds phydev->irq reads -1.

Restore the number when the PHY detaches. It comes from the bus table,
mdiobus->irq[], where the bus or the MAC driver recorded it. Do it only
when phy_attach_direct() bound the generic driver, since that is the
substitution being undone; otherwise the field belongs to whoever wrote
it. Do it before device_release_driver(), because after the release a
probing driver can write the same field.

The store is ordered before the release rather than locked against it:
device_release_driver() takes the device lock itself. A MAC that sets
phydev->irq before phy_start(), as phy.rst describes, is not affected,
since the restore runs on detach, between connections.

Tested on the KN-1012 with a 6.18 distribution kernel: phydev->irq
reads 15 after the real driver binds, and -1 without this patch.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---

Notes:
    v13: the commit message no longer says the PHY got the table entry at
    creation; after patches 1 and 2 that is not true for those drivers. No
    code change.
    
    The PHY module was made to load after the root filesystem, and the
    distribution's own late-PHY patch was removed. The value was read with a
    debug-only module parameter; the three switch ports read 79, 80 and 81
    in both runs.

 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..a9c71a286118 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1965,6 +1965,8 @@ void phy_detach(struct phy_device *phydev)
 	 * real driver could be loaded
 	 */
 	if (phydev->is_genphy_driven) {
+		/* The release below lets phy_probe() write this field. */
+		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
 		device_release_driver(&phydev->mdio.dev);
 		phydev->is_genphy_driven = 0;
 	}
-- 
2.53.0

