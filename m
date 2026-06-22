Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EB382F23;
	Mon, 22 Jun 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114802; cv=none; b=qS3CZBV1i2AJUrNdy2SkEAqqvk0XESiPrVY8hnfwQzjvnNjBRh1UYTZw984WE07sd3xwRjMzGrH/pr70apqH2LvqDygGd0TRu5YvcrX9VAnL0efMIymMLQK3nla+AH2MtGCO2nQBERNe9U09Woh/Atbfxx3y3gOlyAXAC0mydBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114802; c=relaxed/simple;
	bh=UmA0D3P5yXy8cz+l5TjF7yGYD0zR8vUtdjgx4efnqLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga4CF2P2OvNBnXCLJr17ecEhfEhs7F/roghFtRmu9PYMR5hr31szlEs9RNIBSsXjXNroKS7xDjjMmdDgq8D/SmWAufcvYS//3QCAVkTYjvL4YuP9uuX+o4cRUw8qOxs+x2v48CbODJuGUyVNrdpHKOltKCJ8cyiDfbdevZlLmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VLKldH54; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VLKldH54"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F9jNnyNYGY1NcwfEUerNCQvkVxFVg9qCMrtvtRAXFJA=; b=VLKldH5485znscUBJ7jdzHIRV9
	n3k6ppQ//qWUe8aHhkIJM1rhZmDzzgK0MH7+bOtdKrEThTsyIk6mgKsY9+Kxhcjjfm4bRqSv38eVJ
	hT7NMgTUR/IE2lzo9XUFveK5Rt4wa8O0LGiGrr7f19UDell2Z/QiLD9fJjGC7F4MPPgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbZSe-008nM7-NQ; Mon, 22 Jun 2026 09:52:52 +0200
Date: Mon, 22 Jun 2026 09:52:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com, horms@kernel.org, lee@kernel.org
Subject: Re: Re: [PATCH net-next v8 3/6] net: stmmac: eic7700: make RGMII
 delay properties optional
Message-ID: <4eb42700-c46e-4d21-8db5-dbd65f83d57f@lunn.ch>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
 <20260610012937.911-1-lizhi2@eswincomputing.com>
 <eaa645fc-be06-4a15-8c2f-6e82129c4715@bootlin.com>
 <30229cfe-b395-4d0f-81ef-eb780ac26599@lunn.ch>
 <512b77d5.993b.19eed207fc9.Coremail.lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512b77d5.993b.19eed207fc9.Coremail.lizhi2@eswincomputing.com>

> I'm preparing a v9 of the series. The next revision will address the
> issues reported by Sashiko review, mainly DT binding schema and DTS
> warnings.
> 
> Before I post v9, I'd like to check whether you have any concerns or
> suggestions regarding the driver changes.

From what i remember, i think the patch was O.K, but i've looked at
100s of other patches since then. The commit message sounds like the
basic design is correct.

     Andrew
