Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99A3A7D63;
	Wed,  7 Oct 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401657; cv=none; b=Ru97rrkc1w9/+aSFMeHv4jX/SxD7wRnKDThrVNDepHe+VQCftrSCzCoy36IPAe4q1AeazdMx5dDWyZffWfIo9DCNqmGkcLE6NtzyTwovjOOeqnm+M2Jzd8ovf1O1IVri1v1v1zsVDq8FVJdrJ1mHYmVqgm1BS7wZVgjGmrrIyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401657; c=relaxed/simple;
	bh=qBvTS/0nL5YnknhGfRSgaAg0US2PHMc2x7BdxCqV2cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZQQMYweSgI5UP9wleRAEqBvpDV3tjOJ3xq0fCvg6fcqsDl4Vv0NN49qtcZiQ/aCuYRBXjkW61ne1W0C8f308RRHzzvMCn9srG5K8cadj6wabX8c2ZmmkC1+Bt5E9M7LCZ5oz6EhZTreFRrwNrJiiwxSHNdw2BFGfrZwGICL3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DbS60WIG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DbS60WIG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2vM4MEwdHs570z1trHR1waD0+VoMhgMGlPDSlu4CvcM=; b=DbS60WIGzG3WiDfzoqQEcENQmb
	bevs6cpS5TOuX+NfNXHngSavpXHo+JHSjIC5Tg2lXeYBbOJFVPiAOYEcwm+RrI9OiiiqJBMQEniJQ
	gmKrEO+aAiHUzjTJUnemKPvkfQg4bIGRnUWs/eH0KcABlYn/H2FRBJ0FGl6mLY5JjSl8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEXOt-009VZv-PH; Wed, 07 Oct 2026 21:34:03 +0200
Date: Wed, 7 Oct 2026 21:34:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev-bot+sinfo@kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: unwind the WoL IRQ after a safety
 IRQ request failure
Message-ID: <8cd651e5-d240-4663-8361-c3b939d664e9@lunn.ch>
References: <179127056620.2231598.8882282421523696709@kernel.org>
 <CADvTj4orth=RYtb78ND1rdiYh2yb6d+TjZt5ohK_-+1mnVpqfQ@mail.gmail.com>
 <20261006155214.63c5cb5b@kernel.org>
 <CADvTj4obBNgR4w3BW4-gCU-=LUxesQdTRN=EdWTcx7VznFi4kA@mail.gmail.com>
 <e7fea95d-1ce2-4c5a-891d-5e5899931329@lunn.ch>
 <CADvTj4pm8fbgGDiyXVHubnM93qOey7o18O+MDU68MSisXVvHtw@mail.gmail.com>
 <f304ee6d-bbc2-4f76-964a-998c3febb8dc@lunn.ch>
 <CADvTj4pniuLUzsHP_kv03rFUkUD87PD9yVZ=HnW0CsZX78OxLQ@mail.gmail.com>
 <98a7f952-37cd-4886-acb2-e87743e51fba@lunn.ch>
 <CADvTj4ozfxA3E13g5sV2tPogDk=S+VOyf_PAXZVQyaozoe3O0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4ozfxA3E13g5sV2tPogDk=S+VOyf_PAXZVQyaozoe3O0w@mail.gmail.com>

> Should I re-spin this on net-next with the fixes tag dropped? Or does
> this apply as-is on net-next?

You should respin.

We get hundreds of patches a day. Maintainers have no time to see if
is applies cleanly, compiles and passes basic smoke tests on hardware.

   Andrew
