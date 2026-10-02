Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE804570F2
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934213; cv=none; b=H3v7UBo746QklkzGc1fpeOUyOmlX57fwigMUpY1Q6GxWR6BPS7CcIcNxXLsyIYDyRKfcMvx20vFj/w7DMwau3x5X3up0AAmqauPJD0OrLkoD7rMGqqR2JriDmxrXRNR0ZPD2mN8oDODbtNEWnem44b+v22yOhc0ul0j+wDKi21Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934213; c=relaxed/simple;
	bh=AT8e4OPs8AP8eH9/vaaRnPiQgn3UARZ4uOtGA3NPFKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5Q5VXMtDnrBJ+i0VBBwf605phC6kAfRZMpYVijCvqb/c4bpkj/CUCvxFJ3elEfc3Hj38iPs0ffDbBm+9JhHouSjIdKU31ZzSq0Qh7SZ0NleiCqSlZGH1k6ZpeuKRahhdssgis5Wr9ian3qsy9rTIFRB9PZdGQaHbs2YwMplP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oj2YGiRa; arc=none smtp.client-ip=91.218.175.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oj2YGiRa"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AT8e4OPs8AP8eH9/vaaRnPiQgn3UARZ4uOtGA3NPFKY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790934209; v=1; x=1791539009;
 b=Oj2YGiRa0Dc2VxB6jOX5U0ThSOS/pi6PCCkLIH1XEuHcaRw4ihvpYvwQe0yn6oqjA/cipsOI
 h9mEMV43/asNEetODV7cXppsn3FeYB6Ftkcao23/KrL9RLIFXaVVm3VendplOu1xMtF8PESvfaW
 0XEyMW8vOAv9xY89jI48uKm0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87803f23de601c48;
	Fri, 02 Oct 2026 09:43:28 +0000
X-Mizu-Trace-ID: 87803f23de601c48
X-Migadu-Flow: FLOW_OUT
Message-ID: <83eeeff9-5271-471f-89ed-2644da69d923@linux.dev>
Date: Fri, 2 Oct 2026 17:43:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: phy: make the hwtstamp provider lifetime
 symmetric with the PHY
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
References: <20260923071132.908826-1-chenguang.zhao@linux.dev>
 <20260929170300.39a8cb63@kernel.org>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <20260929170300.39a8cb63@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/9/30 08:03, Jakub Kicinski 写道:
> On Wed, 23 Sep 2026 15:11:32 +0800 Chenguang Zhao wrote:
>> phy_detach() removes dev->hwprov when it points at the PHY being
>> detached, but phy_attach() does not install anything: the setup and
>> teardown are not symmetric. The teardown path is also reached from
>> the probe error path with no RTNL and an unregistered netdev, making
>> rtnl_dereference() of dev->hwprov trigger a lockdep splat.
>>
>> Track the provider with the PHY instead: dev_attach_hwtstamp_phylib()
>> installs a default provider in phy_attach_direct(), and
>> dev_clear_hwtstamp_phylib() removes it in phy_detach(). Both sit
>> next to dev_set_hwtstamp_phylib() so the locking is obviously the
>> same, relaxed for unregistered netdevs via
>> netdev_ops_lock_dereference_or_invisible(). No driver callback is
>> invoked; installation is skipped when the PHY is not the default
>> hwtstamp provider or when ethtool already set one.
> This is pure slop, you added this incredibly ugly
> netdev_ops_lock_dereference_or_invisible()
> instead of just taking the RCU lock.
>
> Please don't send send any patches to networking for the next 2 months
> and use this time to learn kernel programming basics.

Hi Jakub

You are right. dev->hwprov is an RCU pointer. The probe error path does not hold RTNL, 

and I silenced the lockdep splat by teaching the ops-lock helper that an unregistered netdev 

needs no lock. That was the wrong fix. The access should use rcu_read_lock() with rcu_dereference().


I was trapped in a misleading mindset: I overly focused on making the phy_attach() and phy_detach() 

paths fully symmetric and tried to avoid RTNL lockdep warnings in the error path, which led me to 

invent an inappropriate workaround instead of using the proper RCU pattern.

I will not send networking patches for the next two months. Thank you for pointing this out.


Thanks

Chenguang

