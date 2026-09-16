Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E9D3DAAC2;
	Wed, 16 Sep 2026 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561985; cv=none; b=fcP1G6gkmij5iLmwNZ322qmrOmMbTdw7Hxs2nEnLMYIgWExqloEIQpMGOy9yfxlJw8mZ/iQ3q5pFgHM98NH0ejoc/wiZ0IXfzveqdRDKx74C7EDjxf8J/iKH3OIH7rfVa14XfhYG5ICfXBnUOasElTI+Q+5tnOMA8Tb4Qv/1eDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561985; c=relaxed/simple;
	bh=Jk+W4/VlLhyhpiIUtQ1PxaMM7eH3JVJ0RbTdKpRf6kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3T5G18BxwkiRmg+7NIZ0WiZ1oknpa38g75hVXG7LHvdCZkbO73kD+P50PghdC/scuJm8fFSAY52jmH+kppJCLfkovrZdR4SnUZVSgtc4012c4vQoxhzaFHj/ryGHHsSm8NW3kClTcw1rbPOEFjxX+lUjrs5tRM3JRyYATMGEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hofU4l+k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hofU4l+k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wv8Cf2X2UkBwfiFzVonQUfXyhOOkgA3+b20+2nNgfSc=; b=hofU4l+kkl1NmFOM/oYzsQRXlH
	70Wm8XkPhGPACpuYbkWXnZAURuKyddeIs+EHIGBmGgmh+OdXmO+mNtxc0BK0WaK30bUEVjmkaeonj
	DkAdMzFJaKS5mc9YqaixTtocXXrSXn+UTb6LhfI0Bg/2xx+ODBHElkEEArsB1FMw0lSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6ooo-005Tb0-6h; Wed, 16 Sep 2026 14:32:54 +0200
Date: Wed, 16 Sep 2026 14:32:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 2/3] net: phy: realtek: add firmware for
 RTL8261D
Message-ID: <79e60178-93da-40cb-894a-eef5b2b154ac@lunn.ch>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
 <20260916081444.497-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916081444.497-3-javen_xu@realsil.com.cn>

On Wed, Sep 16, 2026 at 04:14:43PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add support for RTL8261D to load firmware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
