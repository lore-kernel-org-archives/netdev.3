Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69234E13E9;
	Thu, 17 Sep 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647346; cv=none; b=uYbNp0PLLNnC9dwrWKKeBs1BHGrbZa1uVpFUTFm0MvOWuD4VdiAJoir4/k1C9KRBU4EY09jyy8oKsymepbcJ4F+FSqSijjKxJCrPOaA7dd1UWzKbNbzspWDfKdza8IWABYUPUmdBvcrd74Nz+rtOB6KDYp+O67CHFdUEgg9AonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647346; c=relaxed/simple;
	bh=csmcEXeuIogtpckV3mcYsX4OeTO67vpJ7hB7FaA4azI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn0N/dGh1aRDkpksJeWbObp9GqPdziR+hM1UoqRDhjJGsnoOT4syVj0wlv+0auEe/Vl/EZ+o8SCyvRwyykqbgeYHVNQBPks+4XCnPcQmu6/zXvCJDcck75ODRhquTUZ2MzZlPcTvUm147JSf/UoDPzqOCUvC7BaeTrdfaaO0zK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=opLa3zLX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="opLa3zLX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JAi8qV7Ue5TlQBEJwrulFqV4O5tCcEwwdVrlYyXzI6g=; b=opLa3zLXG07ZQaWTGwC9mh4AJI
	jcR3Y1RLoNXrRt7dqCFw/0bd91DbDzHg00vQsq0LjQo3NyC/tcHghFizrvugvGIO/44uA11wyxoIJ
	Zox90CRZIy4EJHckjHXIxf99wTDl7uZbJYKUx5vwWQomQ8arbwzog3UO5z7X0RUQNb0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7B1Q-005fXp-5V; Thu, 17 Sep 2026 14:15:24 +0200
Date: Thu, 17 Sep 2026 14:15:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: Fix device_set_wakeup_enable()
 reference in kernel-doc
Message-ID: <cb5b753e-ce77-4a88-9a04-4c2735ffa80a@lunn.ch>
References: <20260917063051.52727-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917063051.52727-1-kmehltretter@gmail.com>

On Thu, Sep 17, 2026 at 08:30:51AM +0200, Karl Mehltretter wrote:
> The phy_may_wakeup() documentation refers to
> device_set_wakeup_enabled(), but the function is named
> device_set_wakeup_enable(). Correct the reference.
> 
> Fixes: b344bfacf1de ("net: phy: add phy_may_wakeup()")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
