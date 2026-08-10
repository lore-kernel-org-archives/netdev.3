Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AB3F20E3
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371530; cv=none; b=sjolHP38AA+gb9hR+VuiNkBIhWgaxwdAijTyI7mFxGwM2ajx+zz7tawsDRQNoOpokDr1nbksLjFeRGSkDuAueEfpqzYfkYQpe01h/R28OfANrMNtwk4Ti99xJlNFXMcpUOq8tiyoZo9GBmvrKsLE+AqGYM1IL73rxgvP4ajNySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371530; c=relaxed/simple;
	bh=sV/xUiJusUADCJH1PKiVs1z2uNzuCmI2B/os38CX5pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrihGzKPPl6L/vBbipLzHzJDnp5C1jLF8vSpNgvKIo2VXFbEoFVsSzN61BtLEOIY+9HMGhUjFZA/9i87/U6ogSC/oGxpj3LmP29ervq6fmsJVTUPyM9bJEVE4k3sxjVgxE4cifgnJhlNHQyQXWfFjX1TDpmZRPtHDasKyn8Sc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9ZkqE3k; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9ZkqE3k"
Message-ID: <9869d26b-1f0e-4b37-8488-5aa763176c2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786371526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sV/xUiJusUADCJH1PKiVs1z2uNzuCmI2B/os38CX5pc=;
	b=j9ZkqE3kG8QWzkUWDHkiEegkByar39EMuZscMhHJESXZFUWR+g6tn3eAfOkxTto92hoaY+
	16VaBvDIVAwgn7xpJfb1W3PlmJUvFYRMgWasBpZLOf0FpXrWFuxbR/BYGox4UydijgWUQE
	0tXN8baTQHy+WY71ScXfy+KW55xsrVY=
Date: Mon, 10 Aug 2026 22:18:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 4/4] net: phy: dp83640: fix per-bus clock lifetime
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 luoxuanqiang@kylinos.cn
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <20260807070729.12545-5-xuanqiang.luo@linux.dev>
 <58f132b1-74f8-4297-b904-fd4bf18d37c5@lunn.ch>
 <4f186cfc-7aba-4d3c-8f4e-837b555e9428@linux.dev>
 <b96bf600-80ca-486e-b96e-af9ff3d55afd@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <b96bf600-80ca-486e-b96e-af9ff3d55afd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew,
在 2026/8/9 23:24, Andrew Lunn 写道:

>> Thanks. I tried to work through the suggested design, but I am still not
>> sure I understand how the different lifetime requirements are meant to
>> fit together.
>>
>> The reason v4 uses devm_phy_package_join() is that dp83640_probe() can
>> return successfully and phy_probe() can fail later. The driver's
>> .remove() callback is not called on that path, so devres is needed to
>> release both the per-PHY state and the package reference.
> You need to be careful with devm_ it can be a footgun. devm_ works
> best when all resources are devm_. It gets messy when you need to mix
> devm_ resources with resources which are not devm_.
>
> So the rules are, if .probe() fails, the probe needs to cleanup
> whatever it did, because as you said, .remove is not called.
>
>> If I switch to phy_package_join() and release the package explicitly
>> during driver removal, that failure path will retain the package
>> reference.
> It should not, if you correctly undo what you did. So if the first PHY
> to probe calls phy_package_join(), and creates the shared clock, it
> needs to destroy the shared clock and do a phy_package_leave() if
> probe fails. In this situation, when the second PHY probes, it will
> call phy_package_join(), find that phy_package_init_once() is true,
> and create the shared clock. Now, i've not audited the phy_package
> code, it might be broken, and you might need to fix it. probe()
> failing does not happen to often, so it is not tested well.
>
>> I do not see how to pair a phy_package_release_once() helper with package
>> leave without losing the managed probe unwind. Am I missing an existing
>> mechanism here?
> Maybe you actually need a devm_phy_package_init_once() where you pass
> as a parameter the function to call as the release function.
>
> I _think_ that will work, but i don't actually like it. I personally
> would throw away of the devm_ calls and do the cleanup manually. It is
> much easier to reason about.

I agree. In the next version, I will remove the devm_ calls and manage
the resources explicitly with phy_package_join() and
phy_package_leave().

If the DP83640 driver's .probe() returns successfully but a later PHY
core initialization step fails, the current PHY core does not call the
driver's .remove() callback. This is a generic PHY core rollback issue,
which I will address separately in a follow-up patch rather than include
in this series.

>> The PHY list is not only used during release. recalibrate() uses it to
>> enumerate the fully initialized non-chosen PHYs, read their timestamps,
>> and adjust their clock offsets. The package API does not currently
>> provide equivalent member enumeration. When you mentioned that all list
>> manipulation could go away, did you mean only the list handling for the
>> final member?
> I did not realise the list was used in other places. So yes, i don't
> think you need it for create/destroy of the shared clock.
>
>> The PTP clock is also tied to clock->chosen rather than to the final
>> package member. For example, ptp_dp83640_gettime() obtains the PHY device
>> directly from clock->chosen->phydev and uses it for the subsequent MDIO
>> accesses.
> This is wrong. They should be using __phy_package_write() &
> __phy_package_read() since you are accessing a package resource, not
> an individual PHY resources.
>
>> Should release_once govern only the lifetime of the package-private
>> storage, or do you expect the PTP clock to remain registered until the
>> last package member leaves as well?
> Yes, the clock should be a package resource, so should have the same
> lifetime as the package.
>
I revisited this part. Extending the lifetime of the registered PTP clock
until the last package member leaves would require broader changes.

The current PTP clock relies on clock->chosen to provide the actual PHY.
For example, ptp_dp83640_enable() and periodic_output() use
clock->chosen->phydev for non-broadcast writes that configure the EXTS
and PEROUT GPIOs.

If the chosen PHY leaves before the last package member while the PTP
clock remains registered, the driver would need to define the behavior of
all callbacks after the chosen PHY has left. clock->chosen is also used
by recalibrate() as the calibration reference, so this is more than a
change to the register accessors; it requires redefining the hardware
selection and synchronization semantics.

Given the additional scope, would it be acceptable to retain the existing
MDIO access paths and keep the PTP clock lifetime tied to the chosen PHY,
rather than keep it registered until the last package member leaves?

That would introduce the PHY package only to manage the lifetime of the
shared struct dp83640_clock. This would keep the change focused on the two
lifetime bugs described in the commit message.

I've sent v5 with these changes.

Thanks,
Xuanqiang

