Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771A339847;
	Wed, 26 Aug 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763076; cv=none; b=LzAn/qm2omtecj9KAuwh2WFvKKsDmlRap8+6PFdf1JojsXGPng6JGsr9UHa8iz6sTrOIgV8AxPg9gAroEsU8phrvQ4kZ+YyT+Gr5/mJ1IQ9h4G8wS89Z3n1uIso1JrMn5j1oqA7GGSy1rWEzdTdIyGzZ+dwTxwNiMSoQ2cvJmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763076; c=relaxed/simple;
	bh=PkiUrc1zLTqcAMj7Mx3+LDo5b9c1jlMAnBWG3Cp1VVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK8ZU4Qj3Gx0a5R3DvKZ9kVU/74jzEypxU2R/TKrIbKAv1mrv3f7/SNpAqEoKWFjsgZQ9sk8M6e8Kk55GfSAzBAicXQVQWdEjqvm7DyFO30FZTTkubLru9ipYoXCNOV+uk8Sm9rO6yKBMLhDPmG0PQ4KglZj46K9M/nXE2XsdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E04OWKcA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E04OWKcA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9aTlTrAcUgjj4hArEoKoTq6w3fM8/pT6nYXJB7j/pgw=; b=E04OWKcAdDOgNDJui/H80dCuBh
	YhIoevjc504XTOm2Vuj2a+wFt8AJ13fsca/VQ9N4Q23f14ScvB9noVZrb8A4nq3pKTXmKWo1CrhbJ
	SV4tF7XcHM9v3lbkJ6IkecOfjn+gnscIDKHa8aHSkqNFw8SyvkladDBdF+jGUba32blc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzGpT-001Xv5-Fy; Wed, 26 Aug 2026 18:50:23 +0200
Date: Wed, 26 Aug 2026 18:50:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: ansuelsmth@gmail.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org,
	dqfext@gmail.com, SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221
 gbit SoC PHY
Message-ID: <25195db9-c15e-449d-b792-8f5a7c0aa371@lunn.ch>
References: <20260825193456.1823985-1-cjd@cjdns.fr>
 <20260825193456.1823985-4-cjd@cjdns.fr>
 <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
 <a75b6b15-f86b-4cb2-934c-87583b5bb02c@cjdns.fr>
 <4d594c62-2ceb-43c1-a3d2-731b80493787@lunn.ch>
 <cd7e6b13-a712-43ce-aae6-f45da2f77ba9@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7e6b13-a712-43ce-aae6-f45da2f77ba9@cjdns.fr>

> I tested my board removing the EEE disable and the MASTER line, and it seems
> to work. I can't get any CRC errors flooding the link, and MII_STAT1000
> reads LPA_1000LOCALRXOK | LPA_1000REMRXOK | LPA_1000FULL which suggests to
> me that it's able to operate happily in slave mode.
> 
> 
> So unless you or someone else thinks it's inadvisable, I'm inclined to just
> enable these things and then wait to see if anybody finds a board that has
> problems.

Master/slave should sort itself out, maybe taking a little longer if
there is an initial conflict. Where it can go wrong is when the random
number generator in the PHY always returns 42. Put the same PHY on the
other end and the election always fails.

EEE issues can be more subtle, it depends on what the link partner is.

But yes, we can start without these. But please mention this in the
commit message, just to give a hint to anybody who ends up trying to
debug in these areas.

      Andrew
