Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4A36F8EA;
	Tue, 18 Aug 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082020; cv=none; b=urFv5FFCxgUwRHPdYKMr6coCT19j8l/RZk+zyNzLUA3wFpeULsxXyg7VwP2vx/xor/QYhkMLQ/cVf7Bknouwtfmhbrc17RaAGIy4vCq9lwguLaVrj0J+hD825YhxAsQ/uNtSt/mSUrByqbSqRlxiSWPWK9G5dwW0WK4jjsBam5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082020; c=relaxed/simple;
	bh=T2wJ9BjgRlsdLny/z53s7gb5yXot30mUfku1kmL3cRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeuBPXq8W22+iDy2c6vlfQEnugaN1dzSGccULc60e9oldJH5dhEtptRLBOdNLJQ+Rbe6trw89A4Gi+7ptB5KOhHf642Z3oRtjKw4wN3XL8rNj+ljOV9zydfrDUzcfwDum2FoyWfVdZh+VgAJ20ac0XEO0+izv4ftdezuN5VDkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ahId5uog; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ahId5uog"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qcY5lCMzzbsfrlx8fIBhERSXargFQ45oBwuw6EHCuyk=; b=ahId5uog8Ffs5KIo/LUL03I1vd
	duIMVbKN3UkcDna0YmZEal2W7nQdg8aKn7BOP12XRJH7a5u2sT35vbzcbP6VmqbpEcdn+QddbtRDX
	XMClXaNS9hganQXJt26oXTOOogAJuK61zg1j76utj3RfadhDdF48bTb0OQ+l+DPwQVuc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwPf8-000WD7-SX; Tue, 18 Aug 2026 21:39:54 +0200
Date: Tue, 18 Aug 2026 21:39:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com,
	daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, yangshiji66@outlook.com
Subject: Re: [PATCH net] net: dsa: mt7530: do not advertise EEE on MT7621
 switch
Message-ID: <4854e2d6-df1e-4ada-bf49-0623bd207e6a@lunn.ch>
References: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com>

On Tue, Aug 18, 2026 at 09:28:29PM +0300, Vladislav Karmanov wrote:
> From: Shiji Yang <yangshiji66@outlook.com>
> Date: Sat, 28 Mar 2026 23:29:56 +0800
> 
> There are hardware defects in the MT7621 (MT7530) EEE support: with EEE
> advertised, some link partners cannot establish a stable connection.
> Notably, on a 2-pair (4-wire) cable where both ends advertise gigabit,
> 1000BASE-T training cannot succeed, and instead of falling back to
> 100 Mbps the port flaps in a loop and no link/DHCP lease is obtained.
> This is confined to the WAN / phylib bring-up path; the DSA/LAN side on
> the same device is unaffected.

Do we know what is broken here? MAC or PHY?

If it is the PHY which is broken, it would be better to put the
workaround into the PHY driver.

	Andrew
