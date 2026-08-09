Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7931C84BC
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289053; cv=none; b=iQfUchCwmak8gn0uc2+yTf5N0WTZNrt2C2mCEn93yH7HL2cKAVJq7qbRCW7jOVLHbO9Gf9nnIGIocqgZ3qV2bVS4RVu1Z0WodrmHRnGaUMNaXYAq6VHPnbc/SuQAnQSne9qWNZPQ96jatszJ1lkRlLdhw0iurl6VvrvzzTTUGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289053; c=relaxed/simple;
	bh=B1Q9zlQIzFsF1GOOe1ohsPsr3DF5+n3YxyVyKLPIuL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANQnk3Xfsyg3HDjgBBisT6G2cpDzAfclvqLPIAjGicgZmVysZdWCC7fHWPEf+XaaOhjvo53EMsZeE58Z+/7K+iQMehVHrYVRayK5Tch9Ztnt1KVIIs5C0dluplRq8ADh/8P90XVl5hC1ostUp8qfF0Xm8WxFm/vzUJDzDFP3Q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Eqedw/wP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Eqedw/wP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CKB3Y8SVZF1qnHWGZ/R3ip1eT6dYsKWjR4xe0jgue5A=; b=Eqedw/wPXD0FMLOJChM28ncU2L
	LOqSm4qK7SqvPG42EW9eLDKFRYFNWqVuH2yvQlfUK9U0Ga6OQ/Fd+ia06n9t7JC6ef9XOocAcgEvw
	dRB6LrvpGzFLaLdB8hoIEHZHLA+I+c98F1pIo8KQ8/7lfaJmE7wBuBdbrBSf2WRCxjuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt5Nb-00Gp7E-O2; Sun, 09 Aug 2026 17:24:03 +0200
Date: Sun, 9 Aug 2026 17:24:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v4 4/4] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <b96bf600-80ca-486e-b96e-af9ff3d55afd@lunn.ch>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <20260807070729.12545-5-xuanqiang.luo@linux.dev>
 <58f132b1-74f8-4297-b904-fd4bf18d37c5@lunn.ch>
 <4f186cfc-7aba-4d3c-8f4e-837b555e9428@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f186cfc-7aba-4d3c-8f4e-837b555e9428@linux.dev>

> Thanks. I tried to work through the suggested design, but I am still not
> sure I understand how the different lifetime requirements are meant to
> fit together.
> 
> The reason v4 uses devm_phy_package_join() is that dp83640_probe() can
> return successfully and phy_probe() can fail later. The driver's
> .remove() callback is not called on that path, so devres is needed to
> release both the per-PHY state and the package reference.

You need to be careful with devm_ it can be a footgun. devm_ works
best when all resources are devm_. It gets messy when you need to mix
devm_ resources with resources which are not devm_.

So the rules are, if .probe() fails, the probe needs to cleanup
whatever it did, because as you said, .remove is not called.

> If I switch to phy_package_join() and release the package explicitly
> during driver removal, that failure path will retain the package
> reference.

It should not, if you correctly undo what you did. So if the first PHY
to probe calls phy_package_join(), and creates the shared clock, it
needs to destroy the shared clock and do a phy_package_leave() if
probe fails. In this situation, when the second PHY probes, it will
call phy_package_join(), find that phy_package_init_once() is true,
and create the shared clock. Now, i've not audited the phy_package
code, it might be broken, and you might need to fix it. probe()
failing does not happen to often, so it is not tested well.

> I do not see how to pair a phy_package_release_once() helper with package
> leave without losing the managed probe unwind. Am I missing an existing
> mechanism here?

Maybe you actually need a devm_phy_package_init_once() where you pass
as a parameter the function to call as the release function.

I _think_ that will work, but i don't actually like it. I personally
would throw away of the devm_ calls and do the cleanup manually. It is
much easier to reason about.

> The PHY list is not only used during release. recalibrate() uses it to
> enumerate the fully initialized non-chosen PHYs, read their timestamps,
> and adjust their clock offsets. The package API does not currently
> provide equivalent member enumeration. When you mentioned that all list
> manipulation could go away, did you mean only the list handling for the
> final member?

I did not realise the list was used in other places. So yes, i don't
think you need it for create/destroy of the shared clock.

> The PTP clock is also tied to clock->chosen rather than to the final
> package member. For example, ptp_dp83640_gettime() obtains the PHY device
> directly from clock->chosen->phydev and uses it for the subsequent MDIO
> accesses.

This is wrong. They should be using __phy_package_write() &
__phy_package_read() since you are accessing a package resource, not
an individual PHY resources.

> Should release_once govern only the lifetime of the package-private
> storage, or do you expect the PTP clock to remain registered until the
> last package member leaves as well?

Yes, the clock should be a package resource, so should have the same
lifetime as the package.

	 Andrew
