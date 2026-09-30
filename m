Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A214C10C2;
	Wed, 30 Sep 2026 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804018; cv=none; b=ibWe6aBs5ucpHCxf6Ugt7R85pzhG4ZxqklR1qU/l0721DkROicMTGZ4HxM64d7e5p1hyokEVxIWM995pXYWknA0DHW3OJtr8l5RCwTwEgfH371e+sB58KJV+CPcCSSJzVQ9RX/C8shQDjbLrn36rZq+peHwXbRWWlvQKSNWruYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804018; c=relaxed/simple;
	bh=GbUp6lbULQoi1HFggsUaT79qIZqZmGeqkbSMqaxYGy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbHU8uSULKvgO05tNbdqxehbi/dbXXEzkmWtomHKQSanq+5TZwG2rk/rdTRnNUSazCL7U78KmtiOT58jlfo9/D4Su+sldMiJGuWOTH6J+bsMP6/NnVQS6Ev/lJPJJFz8NO0uYyoy55/wzEf4LS/lfaWPEgtbQcMTuTrSkLyJ8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KS5IrIp6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KS5IrIp6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xFdOQQi0cFenDsuqHj+VWMp+yIXtEg9sHsIA1fMzT6k=; b=KS5IrIp6tq9InBH0pYFEOJmKF2
	PRJXUVFBxbL2KBU7cS8OntTbD2ZtHudNePYGul5TeV0GtdW54FUzJGm1zK5jaheKE8Ly++cVY47Mo
	W/EQQjBFNjpYrVQA4AooQvTPLeQz57bor6q2FemKf1q7mO1wIpSk0M259LPBrqfYQUmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xC1vZ-008FAw-52; Wed, 30 Sep 2026 23:33:25 +0200
Date: Wed, 30 Sep 2026 23:33:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca83xx: read resolved QCA8337 link
 status
Message-ID: <2ea832eb-33f4-4bf3-bdba-5d983038d012@lunn.ch>
References: <20260928220749.857-1-yongzhao.derek@gmail.com>
 <01a62e77-6c4e-4665-ba46-26d12b1c77b4@lunn.ch>
 <20260930212348.1919-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930212348.1919-1-yongzhao.derek@gmail.com>

> Separately, I have not yet reproduced on hardware the case this patch
> targets, a QCA8337-side SmartSpeed downshift where the old code reports
> the wrong speed; so far that difference is only shown by the model test.
> With a two-pair cable, the link partner advertised gigabit and then
> withdrew it, and the link came up at 100 Mb/s without the QCA8337
> downshift status set.
> 
> If you know of a link partner or setup that reliably makes the QCA8337
> side downshift, I would be glad to test with it.

Sorry, i've never used this hardware.

One thing you can try is to set the link partner to only advertise 1G,
not the lower speeds. I've no idea what it will do then, but you might
get into the situation you are interested in.

    Andrew
