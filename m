Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6F345CDA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609722; cv=none; b=awwaMEZnoQZRKqdW/Z8S/VDynBx79xewTWrmqL0nw4DloSps8sX8g3IgoopFb2Q9o4zUF7PgYMjGkdQpq0VJ/3d7cUo0+ANugcuLLVLpNGoJ36RnZten+G/dR8pFhUH+WSzcbI3pouFpfypHwaaTU8XPlnvoLOROytxJkGlQu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609722; c=relaxed/simple;
	bh=aisUsUxNAGafcrLXuq8OxCnfSNUxmmGM6v2V7FNlw9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyr42XDG/rxD0BWELpCaWoaexlFuxzcgJscns3ta7KoFG7q8tdPEARD0xnAW+mARyTGZSVb/5bV+1G0MvBpxe+qyR3wn1e1CANCIkEnXjDpc4Ca8Fnw1hGzNSwwlCwkillKodYCwwbnzQM504F2Z5kDgClPxVj4Rx9InPCHQ110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=01Lreqzu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="01Lreqzu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2A8BB4E411E8;
	Thu, 13 Aug 2026 08:28:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6E16602B8;
	Thu, 13 Aug 2026 08:28:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A209E11C4DAF2;
	Thu, 13 Aug 2026 10:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786609717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aisUsUxNAGafcrLXuq8OxCnfSNUxmmGM6v2V7FNlw9g=;
	b=01LreqzuD/3vKjq1A+T/ZTUZbltDBHFGWjKRlHi5ZGMAY4FdEPNEdL5fSxCiK+6vUlPDPv
	KjWdF1Spz692pYgMm1q3o6wbIHwtE3G6Yi1ixKcfd5cQ/Tw6MwfiZD5+3pN5gTuzLp2aXZ
	SLJ+HhXJnA8YQF72mLCCmGBVe2OBXCxmK01HnXXuG4qeaYQ9DcRiNbaNO1zEiY0XB7JA7O
	Xw+QDXT6AUdtc3dCizY5pEtm1jrxvztUyu1fx67zGmpfdKiK+oSib+lDJUVDJOJxUIad6Q
	qL3udbbWQwmAPvC2CRqU79HeeuhLwWEB5nFAiuTZez7ub4Vc6i9KfY7GE/It3g==
Date: Thu, 13 Aug 2026 10:28:31 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: pse-pd: guard regulator ops against
 freed PI data during unregister
Message-ID: <20260813102831.3a8f5aa4@kmaincent-XPS-13-7390>
In-Reply-To: <20260812135936.889119-1-github@szelinsky.de>
References: <20260810135233.4be3dc5d@kernel.org>
	<20260812135936.889119-1-github@szelinsky.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 12 Aug 2026 16:59:36 +0300
Carlo Szelinsky <github@szelinsky.de> wrote:

> On Mon, 10 Aug 2026 13:52:33 -0700 Jakub Kicinski wrote:
> > It'd be great if we can figure out the safe lifetime rules for pse-pd
> > from all entry points. Specifically the sysfs complaint on patch 1
> > (assuming it's real) makes the series seem like a bit of of a see-saw.
> >
> > Let's get it reposted and take it from there? =20
>=20
> Thanks for the reviews, Kory.
>=20
> Makes sense. Let me go through everything that still touches pcdev->pi
> once pse_controller_unregister() has started freeing it, so it's clear
> what the series covers and what it doesn't.
>=20
> The regulator ops (pse_pi_enable/disable/is_enabled) are the sysfs case.
> It's real: the PI regulators get registered before the controller, so on
> unbind the controller goes down first and pse_release_pis() frees
> pcdev->pi while the regulators are still live. is_enabled() is
> reachable over sysfs. Patch 2 is what handles this - it checks !pcdev->pi
> in those three ops and frees under the same lock. Patch 1 just does the
> reorder, so the two really need to be read together.
>=20
> The other one is of_pse_match_pi() from of_pse_control_get(). A consumer
> probing at the same time walks pse_controller_list and reads
> pcdev->pi[i].np. Problem is we free pi before list_del(), so the
> controller is still on the list with pi already gone. The series doesn't
> touch this yet. It's a one-liner really - move list_del() before the
> free. Then a lookup either sees a valid pi or doesn't find the controller
> at all, no NULL checks anywhere. I'd add that as a patch 3.
>=20
> Last two are pse_ethtool_get_status() and __pse_control_release(), from a
> consumer still holding a pse_control. They read pcdev->pi[psec->id] too,
> but here the real issue isn't pi, it's that the consumer can outlive the
> whole controller - of_pse_control_get() only takes a module ref, no
> device link - so a NULL check buys you nothing. That's pre-existing and
> not really something to fix in net. The notifier series I have for
> net-next [1] is what deals with it: the phy layer drops phydev->psec on
> unregister before pi is freed, and phy is the only pse_control user we
> have in tree.
>=20
> So for v3: patches 1 and 2 as they are with Kory's Reviewed-by, plus the
> small patch 3 for the list_del reorder, and I'll write all this up in the
> cover letter so the ethtool side is clearly left to [1].
>=20
> Sound ok before I send it out?

This sound good to me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
