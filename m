Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC4372B2B;
	Wed, 12 Aug 2026 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547577; cv=none; b=GZN2h2CqW/Hjh7DQde6djs/1k1ZujZgqXUgwEFDCbWziQie5VHJg2fWzGmg3Cm7+WSW23cHwMbdW/6dVc8dX5ZoFPHze2NcX5xcpiYpMyZtAE6WhDy3DiovbztT/ML4yDb5NE2XcngS1oxerDwCY7IBJB1SfRRp6Vvb/xR7GAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547577; c=relaxed/simple;
	bh=knTruU1tFLqOkOKcoLOvNUON1HiU5YfKF5yTdm5fURM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRj1Y/ynsTbhaZAE7oNnMJ9jTJtkUdpn+KCJ6BPY4yM89VUmq+64iF2F8WHruKl2BkR7agEfFV23tT/nzE9OvlJmN61eUCle6V10jUInvcCvvQG8GKRrvH4NxBgeHOSDCLbYGy/U+VG/I6tgNSgbZ9CBZJ60iQ8UAunjNl0qIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=LbuN1OYt; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="LbuN1OYt"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786547573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKGZfaFfR1vzgucryL748YrJAws6C009Y1PHvu3x/S8=;
	b=LbuN1OYtBTQoYRhOhMbZW2zmSmGyM4X9sTwb2c1W08gp5JGeHXWJgYdVNIj6pLFWIEMfum
	RKMqGRK7N7duHcHirktkA+wEjAALvE1Y11x3HYrYiVNVVcUKvIuHO+45lxuwQ7PSMcI4yz
	uA2A6XuGAowd7Ecn9BxZ2WyFeFZP8nUb2HVKjDjd6gbGrv72ZxTxQ4nCsTczFQy7Rde+bj
	v6TMSzXMfLfkUHiiYO6Gx8oq4bAKRvfLDDnEVKOX9kpJ/HldU/k1FhKz4E78EtN7tgvBCS
	lv/o8lobuEUbWUAhXaNzwBbwnUQHMu9tmkdhsj+YKItc97qvbLlLCOKxm4VPRA==
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI
Date: Wed, 12 Aug 2026 17:12:51 +0200
Message-ID: <20260812151252.1160944-1-tillo@tillo.ch>
In-Reply-To: <20260811001429.1036686-1-kuba@kernel.org>
References: <20260811001429.1036686-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Aug 2026 17:14:29 -0700, Jakub Kicinski wrote:
> That leaves two possibilities for this module.  Either the PN field really
> does read "XGS-SFP-ONT-MACI" and SFP_QUIRK_F() would have matched just as
> well, so the commit message statement
> [...]
> does not hold for this entry, or the field really does contain garbage,
> which then falls inside the 16 compared bytes and neither prefix nor exact
> matching can ever fire, making the new entry dead code.
>
> Which of the two is it, and could the comment and the commit message be
> adjusted to describe what the code actually does here?

It's the first one: the field really does read "XGS-SFP-ONT-MACI". The
product name is XGS-SFP-ONT-MAC-I; the last hyphen does not fit the
16-byte field, so the field is fully occupied by legitimate characters
and there is nothing left to pad, with garbage or otherwise. I re-read
the module I have in service to make sure:

  vendor  "FS" + 14 spaces (properly padded)
  PN      58 47 53 2d 53 46 50 2d 4f 4e 54 2d 4d 41 43 49  "XGS-SFP-ONT-MACI"

So prefix and exact matching are indeed identical here, and the "Both
modules fail to space-pad" paragraph overclaims. In v3 this entry
becomes a plain SFP_QUIRK_F, and the commit message makes the
garbage-padding argument only for the XGSPONST2001, where it actually
holds: that stick returns the 12 legitimate characters followed by '!'
and non-printable bytes in the PN field on cold power-up (the same
module reads back clean and space-padded after a warm reseat). The
cold boot is exactly where the quirk has to land, otherwise TX_FAULT
is honored and the state machine disables the module.

> Would it be worth either noting in the comments that the vendor field is
> matched as a prefix too, or splitting the flag so prefix semantics only
> apply to the part field?

Splitting it. v3 scopes the flag to the part field (see my reply on
1/2) and the comments follow.

Thanks,
Martino
