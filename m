Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941BC20C461;
	Sun, 31 May 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780238379; cv=none; b=tMjeWa6BdHjGUpC3V/Bq3NWAtCOpOhZVjWmS/m3+Eq29McE3DGP8zaVnoMGCmj4oXnTg2B7QYfzVDUZMTVoPsJXfoC0i3gag2ig8gjl68F2wDWjBjcFwItKKBPEYnz1aABNmTxyb93Bq/AARkYYFgIVnyqg50DzTc8Se3D69dPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780238379; c=relaxed/simple;
	bh=Ijm/JpK33DkP9zR272Z9t9stMv8XevJLv1R0xgyVCJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC2Tyqy0n8vM1bMbbnhmnug0w1mGQKgvfLHW3jjimU331DZmPuY9AxOpb0hgoSx4CSr15OYEJkg444S+mLVh9/QHrknYPIvxib7CsE2A6EMu1U4YPfWPTe1gDE00zl8dgj0TmOnPRnSbVlv2RV4B5o8P67YzUE/ErrsN61swKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cv4N/ibZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cv4N/ibZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k+G+jC+2OGQmIfkGmvMsm90Hhj1BX8vieXe78dBJ/YM=; b=Cv4N/ibZO+GVeeoVMAxxkhRW1y
	i/nI0ATKhqmaA9ej5aM7wO2xqeM4r39wTIV82k9TabM7MA4EYpiJjPMYtVb3MgPULkaD1zmhcfG4x
	f1KnPzuZxsyPgtY7em4r/B+TBVa0fagtB5x/OlRe7uRgBzBZmrhubsfEFDEcTfqzP+CU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wThK4-005Mrg-14; Sun, 31 May 2026 16:39:28 +0200
Date: Sun, 31 May 2026 16:39:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ibm: emac: Fix NULL pointer dereference in
 emac_probe
Message-ID: <9f01c5c2-873e-46ff-821d-3f36ab023555@lunn.ch>
References: <20260531022219.607001-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531022219.607001-1-rosenp@gmail.com>

On Sat, May 30, 2026 at 07:22:19PM -0700, Rosen Penev wrote:
> Move devm_request_irq() after devm_platform_ioremap_resource() so that
> dev->emacp is mapped before the interrupt handler can fire.  An early
> interrupt hitting emac_irq() would dereference the NULL dev->emacp and
> crash.

Please add an explanation how this can happen, given that iser is
written in open() not probe().

> Fixes: dcc34ef7c834 ("net: ibm: emac: manage emac_irq with devm")

Is this actually bothering people?

	Andrew
