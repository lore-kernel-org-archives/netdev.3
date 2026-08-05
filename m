Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27593451987;
	Wed,  5 Aug 2026 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931216; cv=none; b=HRV9CB2HkzUG+MkFjJxUTTYbncn3NKzXWZvHYxzlNlzN+vbDXFdEa/FuuhSDuGkWbUdfk/q4RCHYldiCDYsRNWgRkkoAh/f7+oDwg6GE6yG/w7QEUVAOKvLGjNXwreOxgrcwlD17e/pCJmmtiwjJFMFz2+zbGHBZ7XvmzPzoPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931216; c=relaxed/simple;
	bh=vUEbFmtMFDHxN8MeINDlXkYfl47Ez5Z0pAdJ6+Jeo0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuShEHRidCnRbHKcfLUHYQ4YO6sLLlnye9ChyXVqTkvLaud4buR4MOhuxq/NTBck7/RuZLZYlbSsGYADlKlUxyWr0+ane0ApvCSggqAxNEJStNW4EZ9LX4hr5hrmJUXPJd5ujABsXGH2YJj+9iXiXo+rUapz0u7y1JddUQ+r1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mVyXbkDz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mVyXbkDz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e+Hoq1Q2ghT+Yzbwx2x+tVHCRBFJXtSQo3dmfZQ0ipo=; b=mVyXbkDzQx8Hyi/xdICLU/SAyZ
	MnAppDd5RLzYDQDbzkZxULvzoptjO1PTmEREgiM+bp2dM1Asi6CH37DQfKo7rWWIQNnYSxM4c/IkR
	rQTfg2k7ZumFf8QRq/FsvfDgIhcaBI6Itk6EpgEou65SOeyawbXh9qBv+Bu/zEOsebgs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wraHt-00GA7J-Bo; Wed, 05 Aug 2026 13:59:57 +0200
Date: Wed, 5 Aug 2026 13:59:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, linusw@kernel.org,
	antonio.borneo@foss.st.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] net: stmmac: manage error case during
 stmmac_dvr_probe
Message-ID: <707a0b37-ad52-4b58-b95b-6f500220e779@lunn.ch>
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
 <20260804132052.205273-5-christophe.roullier@foss.st.com>
 <17bdf6d8-a31d-4601-bbc9-4d7b78897272@lunn.ch>
 <080e5ac0-cb7a-4871-a312-1b60459ab5d2@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080e5ac0-cb7a-4871-a312-1b60459ab5d2@foss.st.com>

On Wed, Aug 05, 2026 at 08:39:12AM +0200, Christophe ROULLIER wrote:
> No problem Andrew.
> 
> https://lkml.iu.edu/2602.2/02822.html

Thanks

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
