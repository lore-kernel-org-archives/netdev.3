Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61932A3DA;
	Sun, 31 May 2026 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780190507; cv=none; b=S8MOOV4f3vVxgMIB1Yg9qNLcMOmuzz9CryjK57vrMFCqqLWPtwiFTSUcDEPX87kVK/0UN4gQ+MZ/XcI9XNN6WeEfsaT3Mm36MIOYHHiJHRqGP9HVUX8xzi0L3CQ0IQLXud2oJGNDO4T17wjmlTNfeGHaqhMpoiPFpA8IjOQJoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780190507; c=relaxed/simple;
	bh=EjiLT/+GzYTdvK6MzWqcK2snFg+b2Yy2YUtPZMn5Py0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzSEzTW0xfL55ef9LrzM4Av3QIZHNDV6KTseziwkQi9Rkt7ftvUOX46ep8pZi5sgc80vtgxkVOprhy0QjJTdGXo9ym4l/1/TWKgrfQUgn3WNWAKwaR7kO9VjvVWO9eAa/yyRdDRTj3CaIqM2qxNkr+JYhDEXT3mC9cHNX7KQO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PFxrjsXJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PFxrjsXJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IaleJQsTketk5pHC8lyykun5pugCc7TYxddHxj2OsDQ=; b=PFxrjsXJ/jOxF3FhcFSQZd8Xwq
	rnijp6uMEB5k+UnJfrmhWvTIpG8aDptJkrYZtF7e+2nUTYy8meg1SLiGTp0REiRH4fPvYZiMUHj1p
	hqivlHO8w8PYBgK5076eAopefifuk2USCh0uN1+Rz8vg3meCSCxVFXdoIFwBWUb9iXeg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wTUrf-005K1W-DH; Sun, 31 May 2026 03:21:19 +0200
Date: Sun, 31 May 2026 03:21:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: fec_mpc52xx: add missing kernel-doc for
 @may_sleep
Message-ID: <4d3eb983-8674-4e3b-8dd8-3ce81e67d6f9@lunn.ch>
References: <20260531000042.369043-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531000042.369043-1-rosenp@gmail.com>

On Sat, May 30, 2026 at 05:00:42PM -0700, Rosen Penev wrote:
> Add the missing @may_sleep parameter description to the
> mpc52xx_fec_stop kernel-doc comment.
> 
> Fixes: c35a0824e88b ("net: fec_mpc52xx: Replace in_interrupt() usage")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
