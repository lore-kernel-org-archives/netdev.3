Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002E17A309
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786257083; cv=none; b=XZUyvXhlgS/uNQb6UCAblUupQ+MZ4557mzZUkHnLbrAOgPf0DNWufYN88Vto+9LIdw0pNlVEotUvrOonuwp2q6JAVFfMn8M+DjGpa8X10DjOW88RLeOmQ/vt5PF3zUzsF8MfDk4getkVq8MJv0++P/bhfKWGIu1c0DVjR3PBx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786257083; c=relaxed/simple;
	bh=U81rObaKCBjpRQJrXwtySX9ORQSdndb8rjCqx2UOyhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz8AQ1Gs4+B2A/OT5KffaQH2/uUHPCGPXpTH8aW5eZNjJPJtK8qqWK8cW9G7A8eSaUpPj5fNb0KXAb6/PUu3DExNgjKLaTT6TWc1C5jjrCEdCS1LkE9FNDHmXezIohjxtIZc3BrrYFxbjQJ01PDbIAwTnrMT53A31Ge2MgqWaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qeMY8jNC; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qeMY8jNC"
Message-ID: <4f186cfc-7aba-4d3c-8f4e-837b555e9428@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786257077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l9W9Q6cZ9T9gmjKDB/9Nb0M8914AwgTr0l6AiobEIA=;
	b=qeMY8jNCEnqmtb290gxJ9QdJl4lDU4P6vIjDWq19OdGDlPQCE6SGAU1xyLKq3k+5o1fccF
	Xt0C06Sa3rkx6l8rMDjRKETGkVSHwMMdX2JEwBPrk9Ij8mXAlVsXr3nGfhbJe5C4xgCy40
	DTZ36M7LZe0XO34jvO5jjJNaSCsY1Wo=
Date: Sun, 9 Aug 2026 14:30:59 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <58f132b1-74f8-4297-b904-fd4bf18d37c5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

在 2026/8/7 21:59, Andrew Lunn 写道:
>> -static int dp83640_probe(struct phy_device *phydev)
>> +static void dp83640_phy_release(void *data)
>>   {
> ...
>
>> +	mutex_lock(&clock->clock_lock);
>> +	if (dp83640 == clock->chosen) {
>> +		ptp_clock_unregister(clock->ptp_clock);
>> +		clock->ptp_clock = NULL;
>> +		clock->chosen = NULL;
>> +	} else {
> Probe has:
>
>> +	/* Ensure other PHY probes wait for shared clock initialization. */
>> +	phy_package_lock(phydev);
>> +	if (phy_package_probe_once(phydev))
>> +		dp83640_clock_init(clock);
>> +	phy_package_unlock(phydev);
> It seems like a phy_package_release_once(phydev) would help keep probe
> and release being symmetric. The problem is getting the semantics
> correct. phy_package_probe_once() will be true for the first PHY
> probed. You want phy_package_release_once() to be true when the last
> PHY is removed from the package. It probably needs to look at
> phydev->shared->refcnt. However that probably also requires using
> phy_package_join() not devm_phy_package_join().
>
> I then _think_ all the list manipulation can go away, and the driver
> will look cleaner.
>
>      Andrew
>
> ---
> pw-bot: cr

Thanks. I tried to work through the suggested design, but I am still not
sure I understand how the different lifetime requirements are meant to
fit together.

The reason v4 uses devm_phy_package_join() is that dp83640_probe() can
return successfully and phy_probe() can fail later. The driver's
.remove() callback is not called on that path, so devres is needed to
release both the per-PHY state and the package reference.

If I switch to phy_package_join() and release the package explicitly
during driver removal, that failure path will retain the package
reference. If I keep the managed join, however, the per-PHY devres action
runs before the managed package leave. A release_once check from that
action is therefore not atomic with dropping the package reference. Two
concurrent removals could both observe a non-final reference count before
either managed leave runs.

I do not see how to pair a phy_package_release_once() helper with package
leave without losing the managed probe unwind. Am I missing an existing
mechanism here?

There are also two DP83640-specific details I am unsure how to handle
under this model.

The PHY list is not only used during release. recalibrate() uses it to
enumerate the fully initialized non-chosen PHYs, read their timestamps,
and adjust their clock offsets. The package API does not currently
provide equivalent member enumeration. When you mentioned that all list
manipulation could go away, did you mean only the list handling for the
final member?

The PTP clock is also tied to clock->chosen rather than to the final
package member. For example, ptp_dp83640_gettime() obtains the PHY device
directly from clock->chosen->phydev and uses it for the subsequent MDIO
accesses. The chosen PHY is not necessarily removed last, so keeping the
PTP clock registered after that PHY has been removed would leave this
callback dereferencing stale per-PHY state.

Should release_once govern only the lifetime of the package-private
storage, or do you expect the PTP clock to remain registered until the
last package member leaves as well? The latter would also require
handling chosen-PHY migration, and I am not sure whether that is intended
to be part of this fix.

Thanks,
Xuanqiang

