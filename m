Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3A2D0602;
	Wed, 12 Aug 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540783; cv=none; b=ODXy6LeJa/MyMiufxwdgC/UWlpE+ET1Rndkd0NjkG+1Zf1mt2jqEajUB/y2hwmdfkg82BIA8e+aWrVPqZMq4oTrBIHV9LRPDPAqUyScM4xvladaLQSE9A+cALO/KZgPxs7bTymzLKr8up04FNT1nuuloMtZ8D1LvORculDqtt5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540783; c=relaxed/simple;
	bh=4XnWgiUjqrePfkTNl2IDWh8lZCCWfInIuj8N64KsTRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkG2uicyJ5NgDDjz9YsL2GBMe9ioubCXk/PmDZTLrYUfJH4dxmoXLz6J6Q9vathdr2rcmXALNui7QLfqxMhoqN+rb+fTuDrIALFPa68x5qNe/9WhVCpOzZaB1fEp5j6nzjRkC4unU4XcLG7XggVs1+5TzPdirNEUNpOdMuYhk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qg+d63ql; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qg+d63ql"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ltFJWqGSmNsokBlgUbV9yE2lhbk1QmO7WyjKPMZHPWQ=; b=qg+d63qlaLcfNDbE8CmEIX4veX
	pk4R1pM4kEngFvlzBlvGW3pJaioVo8syRt9BJWHWJiAaydqEw2+SToyyeIUmGBnT62Fg2mLgSfvZp
	r2zGwMQSgSHPPBlBdLJcGKbBdJWfbQz2rIcxiQPpQ2snXStsdMu09KNJkSVitkuiUFoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wu8rg-00HGpY-2I; Wed, 12 Aug 2026 15:19:28 +0200
Date: Wed, 12 Aug 2026 15:19:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: Disable mgmt Ethernet for qca8327
Message-ID: <469e446d-36ab-45c7-9bf5-6e040747572b@lunn.ch>
References: <20260810061612.23745-1-kernel@kempniu.pl>
 <cc6d8243-e82b-4f1b-acf4-13ba6a74baaf@lunn.ch>
 <anw5OvAxKh3pnezZ@larwa.hq.kempniu.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anw5OvAxKh3pnezZ@larwa.hq.kempniu.pl>

> Could you please point me at the exact retry mechanism you had in mind,
> either the qca8k one or the Marvell equivalent?  I cannot see any in
> drivers/net/dsa/qca/qca8k-8xxx.c.  If I'm reading qca8k code correctly,
> when wait_for_completion_timeout() fails, its return value is just
> bubbled up the call chain.

With the mv88e6xxx code, if ethernet times out, i repeated the request
using MDIO. The code is not in mainline but a few users are using it.

At minimum, i would put a printk() there, and see if it happens.  It
could be unrelated to your problem...

      Andrew

