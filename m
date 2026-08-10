Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC3423EB2
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375019; cv=none; b=VWrpGav9fkZbwYUZi5uTT4rrxPaBgR09YmekGylKpV9UsCqAizLWBZPPjOdjrMoP4SUAzj8GvuDeyFhOSNHOpAUbjuOGMzmOnePHD9hjT8nh+XNE0Epi8UqtRFWjSKRJPQJ6v1ObdkCh/Qkw9cIHgTFMDUWOezpEF1Nmn+fVpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375019; c=relaxed/simple;
	bh=CYyAOSFpJs6y6xrLjY6ksRSiRYyjyqqo3TvftM3+FEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZqCcSEEIrNDi9+jcVXhrpWMU2jdnxUzyZ4UlK4tvnh7Z/gSDN5vLysQCsoWKO9POSD5GBe6C5Qkohyactie6MbjtrhT4GWcYMHfhzltBtkg2ETukH5OPDYxOQ/xyiaZUf+67R7JV6t58XOT9L/nRNBTJQc24007L2Mip88AnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OA3Vud7b; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OA3Vud7b"
Message-ID: <8aa47d4f-10f7-4e66-b81e-10e9b79f2f56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786375014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlRQg8eVOrzCH/jsz77b1ZG4cBjKb8YxVY/gMWUo9Vc=;
	b=OA3Vud7bfAEJtBRouvQi4FuHszIPNVvgkxCIUOkCEMrZlGDKqxQi8CBrcBtGhmwwRq3y8t
	nSb3Jb64ghJvBmSUp1NiNqF1cJDUf931etbuCelSAapNNAhLAENXLRMZUBNoCFgvZ3MnRC
	ilB/qvxOSd24k2m6+G+Xhyc+tkBEAvs=
Date: Mon, 10 Aug 2026 23:16:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v5 4/4] net: phy: dp83640: fix per-bus clock lifetime
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 luoxuanqiang@kylinos.cn
References: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
 <20260810141511.73204-5-xuanqiang.luo@linux.dev>
 <57719c88-854b-4c92-956e-a673041b8587@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <57719c88-854b-4c92-956e-a673041b8587@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/10 22:50, Andrew Lunn 写道:
> On Mon, Aug 10, 2026 at 10:15:11PM +0800, xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
>>
>> Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
>> removal handling") moved per-bus clock cleanup from module exit to the
>> remove path. This leaves two lifetime problems.
>>
>> dp83640_clock_get_bus() publishes a newly allocated clock before the
>> driver allocates its per-PHY data and registers the PTP clock. If either
>> operation fails, no PHY is bound and the remove callback cannot release
>> the clock, leaking the clock and the MII bus device reference.
>>
>> The remove path can also free a clock after dropping clock_lock. A
>> concurrent probe may already have found the clock under
>> phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire
>> a freed mutex and access the freed clock.
>>
>> Use the PHY package infrastructure for the per-bus clock. PHY packages
>> are tracked per MII bus, and the driver uses BROADCAST_ADDR as the
>> package key so the DP83640 PHYs on the same bus share the same clock
>> storage. Call phy_package_join() during probe and phy_package_leave() on
>> probe errors and in remove.
> Ah, i missed BROADCAST_ADDR. Looking at ext_write(), either accesses
> are broadcast to all devices on the bus, or to the specific PHYs
> address. There is no one address which is special. I was expecting to
> see calls to __phy_package_write()/__phy_package_read() but those are
> not needed.
>
> Overall, using phy_packages has simplified this driver a lot.
>
> Once you fix your email address, feel free to add Reviewed-by: Andrew
> Lunn <andrew@lunn.ch>
>
>      Andrew

Thanks for the reply.

I will fix the address and send v6 after 24 hours.

Thanks,
Xuanqiang

