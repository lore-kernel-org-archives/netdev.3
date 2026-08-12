Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEEE25771
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503904; cv=none; b=bkVprE0gOq6BlrgRA2EkvyFow1LdExOrEA9XSQcCKQdwlgXyhxPVke3+LFMmsmYPaykKtHV7CdDZoH6f33zw5ogoyKgC0OwMd2oAOkMDsE8Nlj7ulIanM5nll1Li53+5a9sLGJpYEJnBppjO5q5oxTPZoRQAo++pQW3BzXM+dtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503904; c=relaxed/simple;
	bh=wD/bED4M9VF6qiRex36zKnWoXSQ6OavuLyC3KiZlBVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE/2BpwzjSFVvDub9XUwAZqBiN2f8fzUayIs5W2QtIS4nH5PZdwTkzZBhfyLO/DWHCl5xcfaEAju468wq08dflbwnTmo6dL1deD3ogbkRT4e14MRcNcXYJPiez4vMCzmBixWs0ysoo3BhU9JJF//j+0huLSRqQkccLufcIraO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOyuZARw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOyuZARw"
Message-ID: <a392ea16-f35e-4f5b-b6f7-7f9b584c49bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786503898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqQsw2kSqzYYUfnZ7Ku3OS8asyGWDIXO7pauX3wnZVE=;
	b=ZOyuZARw7tV7s614eZwaK9oNnjc00rCMPu4Q8Md0VtkT3x4EkeSBVvNCJUYT+21PXOmlg8
	ghnJc9q6DgBYkdyWvFuAuluf1wsuStvj4wR23IX1ColNYQOVtuASnrKwfCb01gzxx09w4W
	Qpqh43C40wR9kObxNwa/8Xh2ctHrZF4=
Date: Wed, 12 Aug 2026 11:04:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 0/4] net: phy: dp83640: fix shared clock lifetime
 and probe error cleanup
To: Andrew Lunn <andrew@lunn.ch>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 kuba@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <ansfeXGe8k3bwkW1@hoboy.vegasvil.org>
 <1cb3151b-3dac-4832-ac4a-b3f2b16006ae@linux.dev>
 <dea76ffc-4424-45e2-8871-7ef29fc31958@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <dea76ffc-4424-45e2-8871-7ef29fc31958@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/12 00:35, Andrew Lunn 写道:
> On Tue, Aug 11, 2026 at 10:34:17PM +0800, luoxuanqiang wrote:
>> Hi Richard,
>>
>> 在 2026/8/11 21:11, Richard Cochran 写道:
>>> On Fri, Aug 07, 2026 at 03:07:25PM +0800, xuanqiang.luo@linux.dev wrote:
>>>> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
>>>>
>>>> The DP83640 driver shares one PTP clock between all PHYs on the same MII
>>>> bus.
>>>>
>>>> Its driver-local clock lookup and removal scheme can leak the shared clock
>>>> on probe failure or free it while another probe is acquiring it.
>>> Is this an actual problem that you have seen in the real world?
>>>
>>> Thanks,
>>> Richard
>> No, I have not observed this on real hardware.
> Do you at least have the real hardware, and are testing your patches
> on it?

I should clarify that I have not yet been able to fully test this series 
on real hardware. I looked into putting together a suitable test setup, 
but the most I would be able to get access to is a single DP83640T-EVK. 
The board has only one DP83640 PHY, so it cannot fully exercise the 
changes in patch 4, in particular the case where multiple DP83640 PHYs 
share the same MII bus. So far, the issues identified here and the 
corresponding fixes are based primarily on code inspection, rather than 
on reproducing theproblems and fully validating the fixes on real 
hardware.Sorry I was not clearer earlier about the lack of hardware 
testing. If anyone has access to a setup with multiple DP83640 PHYs on 
the same MII bus, I would appreciate any help testing this series, 
especially the shared-clock lifetime changes in patch 4. Thanks,
Xuanqiang

