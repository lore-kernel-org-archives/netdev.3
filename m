Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C9420E78;
	Mon,  6 Jul 2026 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373318; cv=none; b=ADTBBKSBWwyMY9f6V4yzsjvOCtJOTrB49k6XYbLOsJ8dLZ5rVzkN5MTd0SyX0WZ3anLT1F2yWiY0Pz8hUW8jh0jzlwxLj92/ZwVLsIunnn/CdMUcv9OeSeDxVKNuTSX2uKoqrMjeG5k9jelwS5hdqSkUWgSMssDxcMhPufo+ndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373318; c=relaxed/simple;
	bh=NfFeGMXrHzNARYruWC+3n+ZwrJwJzUAU4YP5HtPgcuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgmEpk4SW/8kguGW4Epk7qdGaLiUt981qavJ++R1AUZGGSvnrMiRH0Pud2GdV76Mk0/Y1lXESHaDy/kNMLQW2XOIR51XjhN7G+b4Rt+VhAsImwSwscWup2TwV14JIzTDFrY35QWxXLv9GyfxYVI2PNknNmyCOKzKEvjHwBTKIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=021m6RD7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="021m6RD7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=phB/xZVURmCiAAbO9shCTxcGld2NBaG91LF7FAgSjhk=; b=021m6RD7AQRlbdpeLVkBlGgLj0
	/CvMxII15nvJ/FOlaLbLsowseW/KiwjGUHVQekUBeIDEWcWvPCys4SOYq6KWLtYqosgRPcObw9yKx
	xZS+G9C9t7HxmeyDcyjNp/8QRGuEETS3SgestxihNweDw/fM2wmZ22NqynarkBoOjAhY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgqrh-00B45y-2L; Mon, 06 Jul 2026 23:28:33 +0200
Date: Mon, 6 Jul 2026 23:28:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <96a77bc9-9804-43fb-acf0-b93574cd60f3@lunn.ch>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
 <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
 <akwToZyYvHZPtdjV@monoceros>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akwToZyYvHZPtdjV@monoceros>

> That's exactly my thought, and there is commit ad428f5811bd
> ("mod_devicetable.h: Split into per subsystem headers") that is part of
> v7.2-rc2 and that does exactly that (apart from the filename).

Ah, O.K. net-next tends to great dragged along the -rcX versions. So
you can probably submit the networking changes in a weeks time. Just
make sure they apply to

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

	Andrew
