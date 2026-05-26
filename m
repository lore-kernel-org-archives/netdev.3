Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7F37106E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809760; cv=none; b=Qc58XLZfxNki53UlNsBz5FIN7DQB/TT2X5Ng4A13eC6LNy8VmBe9EC79LtE1ulScEBEHXTQsfClNYtwCmXwh02XKgXmvXx9v8oo/psckJOWsv/I4V28INR8kbkd9h8oiIxt6xFDmUjNdixToU/TcV9guyVve2tliCuUXVcktkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809760; c=relaxed/simple;
	bh=B6hPYFl40/eyJ3MFPl5GUICMKp0Ryg0OTJcAUc5VR3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqW0/wG4HeRQCZ2ReQYIv8fF+VmNA0iNaM3ci20h1ucn7IjncBwCkla+DNuekU3oZ59eL9y59+xvSsLUls2X6RpIpBXEViiSGClriF9a7S+Da5odJ3W5Pf24w/yxmKICH+kYFlAdKp7i1DCHUaDc4Dt1hb6CHvbkKCeNeegScuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUaP4b7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUaP4b7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543451F00ADE;
	Tue, 26 May 2026 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809755;
	bh=xOiuISXPGiIOAbgR3O8B5UDVVXGCmQiwSwSdvlIsyxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUaP4b7zqKiIWS9lxorsSMFZwFY0nqdhrwLznkTfcU3o3SRxx0AZa9ThXTz2hT9TL
	 EFQ9f07SaO8v6k6k+f48VuLNiiiZVJsOyCjacv+nBdz57LOv04GWxiGubj/C+WvKpn
	 FQQPe1Jm64R2Td63MUHfwZYip5T0GWVANdhdJSyvgj+4DV7A+6WlDzINI020SHAf7C
	 6mG/UilEYyRYeDxt4ViXlfqnZD117ELkrDWBmrrA3MeTrxdqnpSnyp2OgbQd8qAqWy
	 PhAjGzWKlHZQaoFliQZPqfmPAzf1h0pTdRzEyLiTysqhAlklF4lsXmBPa7cvuGbMsw
	 Ku95PdbsqyptQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	vladyslavt@nvidia.com
Subject: [PATCH net 10/10] ethtool: eeprom: add more safeties to EEPROM Netlink fallback
Date: Tue, 26 May 2026 08:35:33 -0700
Message-ID: <20260526153533.2779187-11-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Netlink fallback path for reading module EEPROM
(fallback_set_params()) validates that offset < eeprom_len,
but does not check that offset + length stays within eeprom_len.
The ioctl equivalent (ethtool_get_any_eeprom() in ioctl.c) has
always enforced both bounds:

  if (eeprom.offset + eeprom.len > total_len)
      return -EINVAL;

This could lead to surprises in both drivers and device FW.
Add the missing offset + length validation to fallback_set_params(),
mirroring the ioctl.

Similarly - ethtool core in general, and ethtool_get_any_eeprom()
in particular tries to zero-init all buffers passed to the drivers
to avoid any extra work of zeroing things out. eeprom_fallback()
uses a plain kmalloc(), change it to zalloc.

Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: vladyslavt@nvidia.com
---
 net/ethtool/eeprom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 836316df3092..0b8cfeddb014 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -44,6 +44,9 @@ static int fallback_set_params(struct eeprom_req_info *request,
 	if (offset >= modinfo->eeprom_len)
 		return -EINVAL;
 
+	if (length > modinfo->eeprom_len - offset)
+		return -EINVAL;
+
 	eeprom->cmd = ETHTOOL_GMODULEEEPROM;
 	eeprom->len = length;
 	eeprom->offset = offset;
@@ -69,7 +72,7 @@ static int eeprom_fallback(struct eeprom_req_info *request,
 	if (err < 0)
 		return err;
 
-	data = kmalloc(eeprom.len, GFP_KERNEL);
+	data = kzalloc(eeprom.len, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	err = ethtool_get_module_eeprom_call(dev, &eeprom, data);
-- 
2.54.0

