Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C22DF126;
	Thu, 27 Aug 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846298; cv=none; b=bQzHQg1qw8B0SC6kCKEW9R0gpKkUctK4fyRh4qWDN3j+66qV9n+dsxfQ1MCn83fE8BRLGGpY6U/gDIUtXWqeRbqjTN32dt1OaNtAyVJxBi6lV9VxjcufdnOWth1T4xx9nwyN9gZIeVAY4XPSXvoFhDdxRW0S9bUqxzyN5U3n3EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846298; c=relaxed/simple;
	bh=Z+eipQhdtOKYG9k8rAHYiBvYAhnVgaDQShblxN/RvgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnEgHrxC9mb0T5kDrJ4J9q+3yl7g5+lGXQDzzH7k+/7L+Ptuv4w2e+BIyVXFvanC4a9LqtOJmmeiIzFCIhG8JmiPuGJ9NIOIiCV9ruHVWznQtv9WG0yyfweTriwV75Qg/uIFPWaXdKMoaB36RnvDyYs82brP3GEtUk1NNBsIj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dvhiR35v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dvhiR35v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6BAlB5E9Lc1tBEnNCwlOu2d8LC7r9rm3Xnm3W0D01Mk=; b=dvhiR35vEJvxEZUuql1UlX+9GV
	IfV77reIhC5gkpBkc0kYUWI6/+KN7n6GlSOhYV4iFftE8S7MID6/SbuXImCuDrPhnlyGH4qdctVZr
	JLZ7nvt2WZcO1HwwFnIrGP4hYLO6PGPJ8lWw66lC+lcbuO32wrGpRZg3aOU5dju/W96M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzcUP-001gVy-Kk; Thu, 27 Aug 2026 17:58:05 +0200
Date: Thu, 27 Aug 2026 17:58:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH v3 net-next 2/2] net: dsa: Add support for Motorcomm
 YT922x
Message-ID: <4eef8e07-8593-4c50-a46d-eda5f72e2d35@lunn.ch>
References: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
 <20260825061610.3116673-3-kyle.switch@motor-comm.com>
 <55523ac4-023b-4ed8-8519-293c778044a4@lunn.ch>
 <0c8024bc-c444-42ea-83fc-88446c8c560e@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c8024bc-c444-42ea-83fc-88446c8c560e@motor-comm.com>

> I would also like to seek your advice on a design question.
> For the yt92xx_series_info table, the maveall reference design invokes
> chip_detect() inside probe() to perform the matching lookup.
> However, in the existing yt921x DSA driver, chip_detect() is called within
> dsa_setup() instead.
> 
> We are considering two possible approaches:
> 1. Keep the code as-is and relocate the initialization of certain
> dsa_switch structure parameters into dsa_setup().
> 2. Refactor by moving chip_detect() into probe() to align with
> the reference design.
> 
> Which of these two approaches would you lean toward,
> and what are your considerations?

There is some advantage in postponing as much as possible to
later. The DSA design when used with MDIO to control the switch has a
chicken/egg problem.

The conduit MAC driver probes, and first creates its MDIO bus. The bus
is walked and the devices on the bus probe. Meaning the switch driver
probes. At this time, if you can detect if the switch exists, cheaply,
do it, so you can return -ENODEV. However, don't do anything
expensive, because... the switch driver registers the switch with the
DSA framework. The DSA core pokes around in the DT description and
looks for the phandle to the conduit interface. It wants to take a
reference on the interface, but finds it does not exist yet. So the
DSA core returns -EPROBE_DEFER. The switch probe unwinds, and returns
-EPROBE_DEFER.

The registration of the MDIO bus completes, without error, because bus
and devices on the bus have different lifetimes. This allows the MAC
driver to continue and it will eventually register the interface.

Sometime later the driver core will reprobe the switch, and this time
it succeeds.

So avoid doing expensive things early in probe, because you will have
to do it again later.

   Andrew

