Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C55372D1;
	Tue, 22 Sep 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078214; cv=none; b=M1xRpjIBM+afV/fen5Uv3jCmYu1Bt2qLFJm/ztmP8kgYfAvl8nhggaerCRMCg95bKwFoIihrc27CqEp9urKq99+sJ41SC85n3aYqMRjZDXDWqBrExvOf+E14cwXkyb7mTr6x71/ExA/iuz4sDMTDNL50zUmVxd2Em9d9gb1S7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078214; c=relaxed/simple;
	bh=+C7QoDcAIVPMCU/kpRGQT+2whEqa4ZS4BsgPGkplkSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK4gbbf1CyLASH7fA2qvN6ZLJcvUlfXKBHTuyRK5Eb42Tck/aAOkeulthMu64cmGwaVaNwPbwSxywJIwuhIPZzgprEQ8q3/2hraPfkWpb5bV1genlZ3h2Mz1wqzs9clrHQzpP5dzvFRuyHWvmzKto6D4F4D0F3hJ2feQfmlidnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gxviqoaa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gxviqoaa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9zf3UoT5wL2m5nEhRyKg6MSGKLwglE/NzCt+1ocQ/U8=; b=Gxviqoaa88aGueVUy8kmvxzdKg
	aTU0aDrUBq8Am9AwxX+Qm8ekUHjIkaR1bOwHuQWKSdjsUJTdBh+Rxf4R8kkhgqKp07ncTg76ZY4xn
	BhD7JVfuEAmAhZNilAhRLUFFJF6O8XgnoHWrMT3HD1jhIxcuQktmV6Yx6L2mKPyg3y/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8z78-006Zrr-5W; Tue, 22 Sep 2026 13:56:46 +0200
Date: Tue, 22 Sep 2026 13:56:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/8] net: dsa: motorcomm: Split MDIO bus
 module
Message-ID: <dbb2cf1e-f98a-44bf-b482-6046ede4b3d0@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-8-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-8-mmyangfl@gmail.com>

On Fri, Sep 18, 2026 at 02:49:54AM +0800, David Yang wrote:
> Split it in order to be used in other modules.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
