Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD73A5427;
	Wed, 10 Jun 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079457; cv=none; b=In4iRGBD9NDl21dhs7KVzrRnwwqMMicLSQpCfIhguxdk9IqBqnmgvtEQIFYbAVsNqZcoZNQ8cIz8CUfjm/NE12s+4yr1uOjjD0fxaDWRCkAwhntNJX9izcg4LwKRCZ2OL/VesARioTowH4QFLDVqhwSF2w9RhwFuT+qLvuw+3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079457; c=relaxed/simple;
	bh=jWe340fNu+mPd/pF10NYauyAvpo+Hc4PmS7vOqcVrBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfR1RXK7azbkvwpuPurulQ5tbQp+fnonRDQOjB/vgY80idYr+TdAjWmHYF06zsWqCn9oPlksI+Ky+Ka6n2deL617YZYIazHClhqZ7rTC8ZTleyS7Y3bYvUTk3JJ4cjAM8TcBHPNeTAbKIWfDpa9NSBQZI810d5TGBz3CigVZNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TPA2mTk3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TPA2mTk3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3p/mMmW7IHJvVRznabZjU91tH/WM3JQEEXniHthnqsE=; b=TPA2mTk3Z6Mok+U8o2EzBxLQec
	0Q5za7ynJfnPUyOwFd1fYa0vvAxTWBD6t++4NcQbkB/FjYSowdI7RgUHR8ElC36qIGJR+bqGifEKF
	x+V2LtXUAdDqLny1ax/Go3SI32WnT2U+rprKXqCRoBgsZ5y2KsYj5rY7feWmNageTvWA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXE7g-006whT-JB; Wed, 10 Jun 2026 10:17:16 +0200
Date: Wed, 10 Jun 2026 10:17:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v1 1/6] dt-bindings: net: dwmac: Add snps,use-ncsi
 property
Message-ID: <a542aee0-cc4a-4bed-85fa-1ec6fdfe87d9@lunn.ch>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
 <20260610072420.64699-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610072420.64699-2-minda.chen@starfivetech.com>

On Wed, Jun 10, 2026 at 03:24:15PM +0800, Minda Chen wrote:
> Add snps,use-ncsi dts bindings property for Synopsys designware

Is there anything SNPS specific in how NCSI is implemented? Should
this be a generic option which any Ethernet interface can use?

     Andrew
