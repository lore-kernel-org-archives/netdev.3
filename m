Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194140B110;
	Thu, 24 Sep 2026 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291592; cv=none; b=oitsmQhz6QO5yOzH5qsru5y7MYIQ1iAUgGwJMVpcqzkHfS8YPagTSbQPUFR3vqvZr0lz/5f/Rh1xuWXHYdxiYPCd7duXqQ2i8L7TA9mmdzAqI80MTcPYsghzFdHKVMUbJLwKUs9doQVLC95Kf88qbtB2pIcIoSYKjvOB0bKKTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291592; c=relaxed/simple;
	bh=s9fIgfAyPBl5uLR8laz9ZE5ehPBaWVG3E99kVjS/fiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhKWAHeYi7zX0GYM4TEcD8driOX70C3Tr3LPHPVpiaW9+UvDu31UOHG1Y+10ovfM/dYpIcK4NHqoNahJ8Zxz6GtcgVS7pwlconbzNWzbfeK003fF6C/t5JHnaDxDoREufrDE5Z4En8Ld6d14GIY9iZLaBGDV8p1MGFPn4EEdbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pOTXKLXb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOTXKLXb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4ZbPDKVVmE5JT4FU9/OsNfslYb/btTUybFogtbTfUWc=; b=pOTXKLXbXC2KSwCChi44zbgSfx
	kAcnwCf/R8Ps+sSTMc1HwVM+xIbfrqq13YUQwLevBp6lUajCFsyz67GSwUFBgbTvnEGkTeIu+3RD9
	iscYedfSxU4heWs9xbOOOCitXaRs6XgSbmijBSqUiZGi4TnQgRIX8KCTKYu7GpLziWiRrGP3f6VJ2
	3iCQHORBXDs/5kzPgklswoxgTK85/FQUThqOwLft4UleM7PZD2rplAIWrJmaINgf/i/bOLYjSy3j2
	M41n9pTzaVJR+JRfFH+Brv61rLZZ5+O57jzE27oP7cRtgE340IQlABp1KfMNgaiQUXuahsyZJbnGF
	BTs+ZAOw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9scj-0000000CN9P-2jdq;
	Thu, 24 Sep 2026 23:13:05 +0000
Message-ID: <d461b048-b08a-4bbe-b5e7-60ed6686ab52@infradead.org>
Date: Thu, 24 Sep 2026 16:13:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net_shaper: fix kernel-doc rendering
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mchehab@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1786751700.git.kmehltretter@gmail.com>
 <178700041013.1735578.3422132046076853057.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <178700041013.1735578.3422132046076853057.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karl M. wrote:
| Friendly ping on v2. It already has Acked-by and Tested-by tags.

| Is anything else needed from my side before this can be picked up?


On 8/17/26 2:00 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Sat, 15 Aug 2026 03:32:27 +0200 you wrote:
>> The net_shaper_ops documentation contains a malformed ReST list and
>> exposes a kerneldoc.py title-context bug which drops valid headings.
>> Fix the list first because the parser correction makes it visible. The
>> parser fix also restores three Xe DRM RAS headings already in mainline.
>>
>> Tested with Sphinx 9.1.0:
>>
>> [...]
> 
> Here is the summary with links:
>   - [net-next,v2,1/2] net_shaper: fix kernel-doc list indentation
>     https://git.kernel.org/netdev/net-next/c/09b7c00d55a8
>   - [net-next,v2,2/2] docs: kerneldoc.py: preserve headings in kernel-doc output
>     (no matching commit)
> 
> You are awesome, thank you!

so these 2 patches are merged into net-next, which should be merged
into mainline Linux at the next merge window (in the 2 weeks after
Linux v7.3 is released).

Patch 1/2 is in the current linux-next daily releases.
However, patch 2/2 is not merged anywhere in linux-next AFAICT.

I also would like to see patch 2/2 merged...

-- 
~Randy

