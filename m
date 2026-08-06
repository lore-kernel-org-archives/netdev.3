Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033853E0226;
	Thu,  6 Aug 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002731; cv=none; b=OQDyrhiJMcnbapYuxetwqtlR6Fpjp3LAa8+RZcu2rqPly4kTJgnzbVq3bA1vXACq4mLSsBOgBpbBD3cEeSneYkC4urTjCGOGXbw9A7hQlYIUdzMbhBj/z6WE31LWVmN2Rx/SiM3THjvQ2hughQ8Us6pHMDs7jCx/nIQjCeLxHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002731; c=relaxed/simple;
	bh=fRcmGXMwRej9suSrzZTFsCUd7WJHKn/weEVPTISRJm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bRPvO1d2Y6EunXcVj27uem0ewEWaFz/hqtB3dOmHK/DfsZyUl+UCSp2ZmeH2r6QEs+1ECdZ6N/fxyau/WpZouOQgDkTUW7LDqbtxcYNSTd+CEM8NCSn4a0GRzNBQawPbO9/3mq5N5vJYx544cqEBI01geSCmEsOkiIKa00Y//HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=Xa1hLyG6; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="Xa1hLyG6"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786002189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dc6O55BQDmAuOTZQF94euARwcjY1I+IzX6P3L2DU4JA=;
	b=Xa1hLyG6rddIerxrbk7eLw+zL697bxTw6FZ17FHZ5g/XEHURElryHCwUzktfRwmacbgDdH
	BvtLDiORhkXZVFOwP8NbvmaIY33vCYv5ZbXCxxImiiixHs++CWZk+t7t5ldw9jwThnmJxr
	M+S9o+cScZfY4GYUkgRIDRAxGJLCRCQ6/+P49uyGXv0/Hlekphgqje2LGY6ZiPSdJQMGkp
	d5G0lWhfeSRDVBwtwIW1zOCUMPW/eloVdbsszjWT46wIhe6bDziymviyT6Zw3WQB/IOT3V
	vblfXCPWHJbYo52zAMc7qqfeRbx485kyRGD2o8Fsfc88xipeVKWTp3b55NUrrA==
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
Subject: [PATCH net-next v2 0/2] net: sfp: quirk support for XGS-PON ONT sticks with unclean EEPROMs
Date: Thu,  6 Aug 2026 09:43:06 +0200
Message-ID: <20260806074308.1996917-1-tillo@tillo.ch>
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

v2, reposted as requested after the July patch-queue flush [1]:
 - collected Maxime's Reviewed-by tags
 - wrapped the SFP_QUIRK_F_PREFIX macro body to fit in 80 columns
   (checkpatch warning flagged by NIPA on v1)
No functional change since v1 [2].

[1] https://lore.kernel.org/netdev/20260720173156.41189431@kernel.org/
[2] https://lore.kernel.org/netdev/20260705185440.136496-1-tillo@tillo.ch/

Martino Dell'Ambrogio (2):
  net: sfp: allow prefix matching in quirk lookup
  net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI

 drivers/net/phy/sfp.c | 38 +++++++++++++++++++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

base-commit: b0057c68df711bf6a62033c072ac61c4f9d3cbc1
-- 
2.47.3

