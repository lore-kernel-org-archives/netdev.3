Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482E476697;
	Wed, 12 Aug 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549635; cv=none; b=ivt08+JBopDGbPvUbV4zz8MeaPyPEdsn6GWGK0U7lJzlyAUXXqP+vq2grvJUQ3DKV9m9GaA9p9ua3pwtNCI2mImZFaOE+xvtYG0nAxPVImCDoUNDyxn2tQPmer8BTNiWVSyPOoNW8huxmCABzyvbygRQREVTtp/jnSdr2hYfIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549635; c=relaxed/simple;
	bh=LOetIEQPfdeZwCVX7tE2wmOSvd7RO/fmqcN8ab7R9nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0QwhyQLE/U1Ll3U48i/LZaAT1cwzuhe7SrhwUChub+HeV/WX0ml7RH0FfXQSSckP0vWoZ72ZO6n8WrRK61Ocug2Rm+zCsv80Zi5SXeWtEjL+p4pn6QRihd3ywqvOAKik9WHnvsWujT4BE59dwqBZBp6cw39r33tVDL68PpqMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=iJzSSQDZ; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="iJzSSQDZ"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786549629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WsEkSb4Z9ocx4eno570gO5biflEHwVrDOkX5EsCollU=;
	b=iJzSSQDZauk3uC6WwWoc/sdNKLblRvZQWkucpI/M/JRhKFalm2zCwgEHDlLhR5Fh2KXTd6
	4nmxfYXEE9JrIYf9LVnSiIyzV2vldjP9Gnet3iCto5d4MMb4kfNd+MUcoCCj0ZpOd20KkM
	8msAVCNJqit375d9r/akV+qLBS3L9B3OR7RonjHJACn5vEbRQScAbhEuL4K80vPpAxHCOS
	7FIflVR2MW6d/fkFatLRO2Ld3YYSRqG2kowx0nvp+3Oj4eTSSstl14sTge5dsrc01Rn4NR
	x0mDuTGUTnY8Qc02C4fI567rY+2mJP2W8u/Ik1HU9Yj8rGoPltFsfMJ1kZ+y4A==
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: [PATCH net-next v3 0/2] net: sfp: quirk support for XGS-PON ONT sticks with unclean EEPROMs
Date: Wed, 12 Aug 2026 17:47:06 +0200
Message-ID: <20260812154708.2201266-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some clone XGS-PON ONT sticks return EEPROM reads where the vendor PN
field contains non-printable garbage past the legitimate string instead
of the SFF-8472 mandated space padding. sfp_strlen() then can't trim
the field, the exact-length check in sfp_match() rejects the quirk
entry before the string comparison runs, and the quirk silently never
applies - so the kernel honors the module's spurious TX_FAULT and
eventually disables it.

Patch 1 adds an opt-in part-prefix-matching flag to the quirk table so
such modules can still be matched; the vendor name is always matched
exactly and existing entries behave as before. Patch 2 adds two ONT
stick entries wired to the existing potron fixup: the "OEM"
XGSPONST2001, which needs the prefix matching (it returns trailing
garbage in the PN field on cold power-up reads), and the Fiberstore
XGS-SFP-ONT-MACI, whose PN field is fully occupied by the truncated
product name and matches exactly.

Both quirks are in production use on a Bananapi BPI-R4 (MT7988A)
router on an XGS-PON uplink, backported onto 6.12.

v3, addressing Jakub's review [1][2]:
 - prefix matching is now scoped to the part field only; the vendor
   name comparison is always exact
 - the FS XGS-SFP-ONT-MACI entry is back to plain SFP_QUIRK_F: its PN
   field carries the full 16-character truncated product name, so
   prefix matching bought it nothing
 - commit messages reworded accordingly; patch 1 now describes the
   mechanism only
 - dropped the Reviewed-by tags given the functional changes

[1] https://lore.kernel.org/netdev/20260811001427.1036657-1-kuba@kernel.org/
[2] https://lore.kernel.org/netdev/20260811001429.1036686-1-kuba@kernel.org/

v2 (repost + checkpatch fix): https://lore.kernel.org/netdev/20260806074308.1996917-1-tillo@tillo.ch/
v1: https://lore.kernel.org/netdev/20260705185440.136496-1-tillo@tillo.ch/

Martino Dell'Ambrogio (2):
  net: sfp: allow prefix matching in quirk lookup
  net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI

 drivers/net/phy/sfp.c | 38 +++++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)


base-commit: ac155a26750a595703e7dadff84735456d75a479
-- 
2.47.3

