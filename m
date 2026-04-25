Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963BA1F872D
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777098798; cv=none; b=rKwahQJ1j1faaF+VpSRPsl4CVR7JMCKyHw64LpvHapN1m2QOv6i1IzR54YiBdZjZIfZC6sYe9Mz+sIfAD1bvAQQKx/POjYu1aT5ren3iTd5I1uoTpM9lXF9opwzPy7OsHp2crrFALvOCk9iM+9Aq67WSCyJM57g3NpnDrYlHGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777098798; c=relaxed/simple;
	bh=Wv0ZPQCrtq3Ld5a01lq+Zp+Tm0ckXrMa27d0kodfVos=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kRG+eKm2MUoY6E1pCYHI+hTlbmi/fEDyK1UCoGTbkVwhZQBYCu5T2lj56jeMf6QMSnwvd6YxlhyVksvjS7evRtoEQbRRWULr2oCL6XzDJB6Z1Mj5Opti2TqMFrWd4BEIJ0B6NT774y0grzhmw6HQ1gF8j8xKjdQR00bFxXSQHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=OQsmM7n7; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="OQsmM7n7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1777098786; x=1777357986;
	bh=Wv0ZPQCrtq3Ld5a01lq+Zp+Tm0ckXrMa27d0kodfVos=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OQsmM7n7Ou1sUKri7+JveJESGZfXy3y612rARNNcWPKwwst0y/PAjj+EZG+c2Ssgt
	 y36SuhqVgY/Rq72eTCqyE3Q5letnEpbw3fBs7xKY7Qcwmi5kG5Afqydb/gaeT7Iw4H
	 u6DVqDAjjKZLrEj47squpNJSM/F8uBpbYU8MmT4oo5WvjL7PnH2ZC/29CXIBbwb1ln
	 OIscsBWxTphQ01CCBz32s/bT7HZI2asTUBSxGgCe+LZDyghE+EbVkBpMm1SG+fMEgy
	 /cLljCLSUDVwh6Kvj9U/W1/NwXJVUv094k8C18sEOw+FDttajVgEBl8H/XzBqs8194
	 E8R9rdutWxDzA==
Date: Sat, 25 Apr 2026 06:33:01 +0000
To: Kory Maincent <kory.maincent@bootlin.com>
From: Corey Leavitt <corey@leavitt.info>
Cc: Carlo Szelinsky <github@szelinsky.de>, Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Message-ID: <177709877183.2197589.3842996562825753007@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 7cb9a82b364cb7dbe92e7d102d7d509061d9abfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kory,

Thanks for the Ack on 1/4 and the kind words on the design. Agreed,
we'll solve this without MDI-binding for now.

On the Fixes: tag for 4/4, I'll drop it for v2. Patches 2 and 3 are
infrastructure (notifier chain, lifecycle events) rather than direct
fixes against a single prior commit, so dropping reads cleaner than
propagating fa2f0454174c onto scaffolding. The cover letter will note
the regression context.

Thanks for pulling Jakub and Russell in on the rtnl_lock question;
I'll hold v2 until they've had a chance to weigh in, and until Carlo
has had a chance to test.

Regards,
Corey

