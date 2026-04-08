Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A421ADC7;
	Wed,  8 Apr 2026 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608667; cv=none; b=KWWOi/7Z4GSc6EyduXXsh79uRfhPfSGThpnD+OKppc0D8GDnf21G1DGgI2Ey7dWmcJ5wEt9SkKWMdf2GrjAdvj1xp0Yjticxm5m3QFdYfrObr3JI1ttDkQiOhUk8rhSRm6YXZ72143aQPe+ZlwJ93aNzfXXTmd7B7RFjrwq/8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608667; c=relaxed/simple;
	bh=ySjLFXBjwv7HBJE0/Pln/VObMOfl0SMPrxVfKXBWdp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDjF5S6rFo2RHypBU6aT0TZbiRqO0dT9rq9l9WRKUyGxywTPhWVrx4vGD3HbFuTzZ1gZc6h6CvXDtPCYsQLVjF2I2y3DMD+cP+gsno08hQcx5hgfz0tSPBsz56FcHxfN/dwkA0vt6R9K50KBh+TkJ/lr4+Z1YkmekMTXi+d6Bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B+ytITZk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B+ytITZk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W9O8Neg/Z/NjbfreFclXER+OLcvNng+xEPKIWgWPBL4=; b=B+ytITZk1dZfnZwxSKyubq46/E
	9jXuj2CAe1SLpKmfWewbSoLoLKzR3PI1v5wDd9x8GWucrfT3AiqeTRFF5ejKu/QyO0ahPoF3c48r8
	YPosKQANLRUKxtGXkSp2gQwON70S1hRGE6fk3CuOm5PodWU+LtlAUwVjJKWa/2qps0zc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAGvH-00FCn9-Sh; Wed, 08 Apr 2026 02:37:35 +0200
Date: Wed, 8 Apr 2026 02:37:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <580ee319-b27c-4772-b763-bce6be560d7a@lunn.ch>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
 <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
 <adWIy9d9VgDha_ub@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adWIy9d9VgDha_ub@google.com>

> Also find an issue
> in the txgbe driver (I think?), sent
> https://lore.kernel.org/netdev/20260405222013.5347-1-fabio.baltieri@gmail.com/
> for it.

I looked at that, and it seems like you are correct, but i also don't
understand why it has not crashed. So it would be good to get some
feedback from the trustnetic and net-swift people.

	 Andrew
