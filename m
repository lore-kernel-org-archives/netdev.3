Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837630E84F;
	Mon, 30 Mar 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874890; cv=none; b=q4Ihz0mdk2EH6bJTRlrdHDQhiZdJD+ORAgm1XrTXCJKUkXzFdFf7CW0pJp1UGhsjrch0UwHGTqC7IwbYVcFdvkhxq2LwAXBK+Wj/mSaQ6QBrHU1SmS/AxpAZp5KYTqbFxdKvR0FUbh+39zu1UmtQBSdrDOqPgmuxOMB+B2uw2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874890; c=relaxed/simple;
	bh=Ussa43LWPtA6yUb/RL9ctofSX1Bow0SUPYYU5fJRt9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihsyt1G++RauNM5a9K5WC3r41utcnTe1OoiQwg0Qm6N9y3liQd0dWtbeg9cV42MFJmLggX/B/l2HQSJY7Xsiv5x38n7/wLyg5PW79AaY6NOqhudcYih4PG7VchlvOofp3Amx4juygWiF8g96vEQpJO7jZwigHorsCe5PMSnMNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4u8bxRXT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4u8bxRXT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SQnnYyQCAMoEC4ylO9r2ZhM0h4XUUS6e+qeqslEd9oI=; b=4u8bxRXTVofUZNO3GnH46dTRFh
	qABu43NQTw6SA6vZbt0RI3XRPew1nnG7gyKQhBVJVQsVvGTFO1BUVWa70F4gHlz/NamAiUfYEUBMI
	RmPQIB7RaCbLT76S1pz4lyKS8jk5zZngwhYJcbPxAj0X9BlDfzYVeEg2lPlUSB5H+lBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7C2E-00E242-Kn; Mon, 30 Mar 2026 14:48:02 +0200
Date: Mon, 30 Mar 2026 14:48:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] declance: Rate-limit DMA errors
Message-ID: <5df83811-91ed-47e3-a6d2-3d96eaef0b0d@lunn.ch>
References: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
 <alpine.DEB.2.21.2603291303190.60268@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2603291303190.60268@angie.orcam.me.uk>

On Sun, Mar 29, 2026 at 01:32:51PM +0100, Maciej W. Rozycki wrote:
> Prevent the system from becoming unusable due to a flood of DMA error
> messages.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
