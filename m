Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D334040D
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458890; cv=none; b=OJGWLgiEa924OoAmIjZCPGO4E0PZOBPOBAarND/xegNAsOGib1vmJloveJZdNkmBh/tjftdCxPRvL+/8gc5uz3B4Z1u4hIZEEyVOzqIp7dDmjpB9OrEKFgu0DJ2BansEpqPN/20r52l6dcop7MJcBIOM5jjfzbDZysVoBs/xXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458890; c=relaxed/simple;
	bh=ShglhKyuXyCAeQtFu9WHxuSwRVeKIbvL4fiN53lfdus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL/9TKooGLeeD6wPPfrPylKHwkU3hlz0T7lPWDOTIUEG+gfO4FtyM7hqARbvUrqOtdtMXPpivukfn+ddFGjbVwHdO/G4V0szqrZiLWmizaQ7N5qGk1Xw8J7h1lN9vfQbph2SNuCWRy0oup4eJnImFFApadS0DIHca7FiM8L8WFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dywvRx9K; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dywvRx9K"
Message-ID: <1cb3151b-3dac-4832-ac4a-b3f2b16006ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786458885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShglhKyuXyCAeQtFu9WHxuSwRVeKIbvL4fiN53lfdus=;
	b=dywvRx9KjY0Gp8FLKnewM0nt4/gDX94qNAvyrfDO+unTZaOmxnySFjciNznWHsBF3flEtL
	a2n26BpzHcpNcpIkC8uDXmdfdtGOTEiljQFm9A9/Jey/KCk4RWSOiygCxwu1Bhj8C+Ky+Q
	Re4P35Vj5Zi5wdHxiV5ItI03FFH1uqQ=
Date: Tue, 11 Aug 2026 22:34:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 0/4] net: phy: dp83640: fix shared clock lifetime
 and probe error cleanup
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 luoxuanqiang@kylinos.cn
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
 <ansfeXGe8k3bwkW1@hoboy.vegasvil.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <ansfeXGe8k3bwkW1@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Richard,

在 2026/8/11 21:11, Richard Cochran 写道:
> On Fri, Aug 07, 2026 at 03:07:25PM +0800, xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
>>
>> The DP83640 driver shares one PTP clock between all PHYs on the same MII
>> bus.
>>
>> Its driver-local clock lookup and removal scheme can leak the shared clock
>> on probe failure or free it while another probe is acquiring it.
> Is this an actual problem that you have seen in the real world?
>
> Thanks,
> Richard

No, I have not observed this on real hardware. I found both issues by
code inspection. The probe error path has a definite resource leak, while
the concurrent probe/remove path has a potential race. I have not
reproduced the latter.

Thanks,
Xuanqiang

