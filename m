Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672033C53D
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111184; cv=none; b=Za7yAZIICQxe+As6lCRma66c4Vi4oVlsfVOJ5hZv62D4HQcVbvHP/FA/x6MAGibmrRU2rmZJ24ps7Kb+C6cWLe1lxHXeeNa4px0NZY4pjK089gMI8+svvZgqgNrk/TkkmSjcr0FXYyOXY9kqO0ntZgKyKG7docPNDr9Ps7ZjDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111184; c=relaxed/simple;
	bh=4a9Tll+/tiEtu7TxSANvq0xehRGrVlD9ZjUfRPQXgyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJPVxZrFERhofdeUIHZlUq7HVvT9GmX29RIxy++eoNPpqDQpChEnf1fDkBqrBDQrMlnuCg/OWg7BlOmIQBAlRT1LERLKg5ZAkxP1PrOIMABujMqd8eRlwFBC/XDIun/KGynn1exhhE7hgBLU1mKdfKq+DO9UUHsk/5IX7GRlRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q3Z5Qjmy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q3Z5Qjmy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JxxxMPNZTfaV4rxqXXgPWOMS87Ax0ltHKp5P1BFQVgU=; b=q3Z5QjmyjagkBuLm2sHGUEPTYJ
	l+O4867sMPW797qfOYFspYyVOr2VedVTC6bb/hQ9Q2RsrIlyralHnmzDiz9Yemao+qQBAdbxZQEwO
	JMiKHp4BvmkKx9PENr5xonl0j5Cy1OSNks/NoMB6q9G4BYsQO/pWEXDe/IFMUb2gbsOY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsL6l-00GbE4-AS; Fri, 07 Aug 2026 15:59:35 +0200
Date: Fri, 7 Aug 2026 15:59:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 4/4] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <58f132b1-74f8-4297-b904-fd4bf18d37c5@lunn.ch>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <20260807070729.12545-5-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807070729.12545-5-xuanqiang.luo@linux.dev>

> -static int dp83640_probe(struct phy_device *phydev)
> +static void dp83640_phy_release(void *data)
>  {

...

> +	mutex_lock(&clock->clock_lock);
> +	if (dp83640 == clock->chosen) {
> +		ptp_clock_unregister(clock->ptp_clock);
> +		clock->ptp_clock = NULL;
> +		clock->chosen = NULL;
> +	} else {

Probe has:

> +	/* Ensure other PHY probes wait for shared clock initialization. */
> +	phy_package_lock(phydev);
> +	if (phy_package_probe_once(phydev))
> +		dp83640_clock_init(clock);
> +	phy_package_unlock(phydev);

It seems like a phy_package_release_once(phydev) would help keep probe
and release being symmetric. The problem is getting the semantics
correct. phy_package_probe_once() will be true for the first PHY
probed. You want phy_package_release_once() to be true when the last
PHY is removed from the package. It probably needs to look at
phydev->shared->refcnt. However that probably also requires using
phy_package_join() not devm_phy_package_join().

I then _think_ all the list manipulation can go away, and the driver
will look cleaner.

    Andrew

---
pw-bot: cr
