Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451D258EE9;
	Sun,  5 Jul 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278053; cv=none; b=qK7f7g4vyzJNvmZ393J5b37maejp1g4veun7ObJhDev2IkODhP04LoSD3DXDguycaZmciJvkPw+8ho9nPkQQbWyS/2dhwWkVNuq9PLO6X9chHdploFvLcmUym/kwuIRj3+Yu3vItgSNZNQ/dSVeSuu/9KiJJOkzSxZEd8gnRkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278053; c=relaxed/simple;
	bh=rfm6ObRtGhGC71McIxv0Dh1SUwb5GZZE+qEI5IZHJgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kom9PqMxQ2bRUYeiA4GJHm6oLIza5HsMgDSIMTCddAi4h4fWltpkFWgtJgiEANZ77mCwjp5FyV/xbGICzy733tmuigc2CYpgJNN/3WCdYWTeHu3uEXjdjYPx1KIhQFDknDqIsuStjk/CxroOFWVPZ9Y36r1+Ld0nrvYN2WmjrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=FuVx4NMf; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="FuVx4NMf"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1783277683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u84a5/yplSHRs4w9tw7UD/LToulfXDxm/OSwiU8t828=;
	b=FuVx4NMfx7lbQYuFlG0rYjOBa+NxHqcDaXt5NlfBRSkO9hIdy6VLSNrPivrVFufAFRa1NM
	W7Vn5ibj5qgI2pbkGlZKOTbdtnNIfy6gnLSgMrRKH7aF5XpKlRUhVSE8QMi1izNphU1Xxx
	/BcDjBgHP8AFMJCE55VSD7rLZPlXy7HrHQJBT23j1Pva+qztz86r+qpqxOT2vm1j3I4rJI
	OpbKYSZekNdqCmkU+LF/injiGVkqF7jt3t76obii7x/LyERlNtMqj3/dPSZHVKOWIT3Xgb
	CTokLvt9Dxv+3IGeY9DVBX5GMW4pHTO7IjO6Kc/STonepbmFR5P+iNoCw59XzA==
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: [PATCH net-next 0/2] net: sfp: quirk support for XGS-PON ONT sticks with unclean EEPROMs
Date: Sun,  5 Jul 2026 20:54:37 +0200
Message-ID: <20260705185440.136496-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some clone XGS-PON ONT sticks ship EEPROMs where the vendor PN field is
filled with non-printable garbage past the legitimate string instead of
the SFF-8472 mandated space padding. sfp_strlen() then can't trim the
field, the exact-length check in sfp_match() rejects the quirk entry
before the string comparison runs, and the quirk silently never applies
— so the kernel honors the module's spurious TX_FAULT and eventually
disables it.

Patch 1 adds an opt-in prefix-matching flag to the quirk table so such
modules can still be matched; existing exact-match entries behave
exactly as before. Patch 2 adds the two entries that need it: the
"OEM" XGSPONST2001 and the Fiberstore XGS-SFP-ONT-MACI, both wired to
the existing potron fixup.

Both quirks are in production use on a Bananapi BPI-R4 (MT7988A)
router on an XGS-PON uplink, backported onto 6.12.

Martino Dell'Ambrogio (2):
  net: sfp: allow prefix matching in quirk lookup
  net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI

 drivers/net/phy/sfp.c | 37 ++++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.47.3

