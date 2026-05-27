Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537272D8378;
	Wed, 27 May 2026 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843112; cv=none; b=m98TZ0YeFydlapXPTHuGRKFC18qY9VrIh9Idx+nlVUpPRPZ1yj3GF75OGgs3W2lAqiXGsrWfAiOgu2IorrO0unV+uEygwR9NLoTlfze9VXpjuU9uxKS5hbyQKdg7HpZxft/ai1UsohzYYcN6d1YzOnvV6JP91YQ1UCTdclG8JQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843112; c=relaxed/simple;
	bh=CT3cly6M97NP8wu/iaLMtK2SmY2oYSSsjKKTRA7JfBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoK9GTpJ5pz55Sz3jwZA3ykpyV5WJ/vSkchdYKjlIdPyzxzPWVbkzTqQ8BaQNLDRSf+Io3tlOR5HDy+aLi4015xEszIRXd8xUJcnm8+srQxqwDK9d9DEt2NBWgD+oJekM708xmEAcjaunOS+aqJrjaJ/L3TwGI97FAAeQjEex7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=332FTBYv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="332FTBYv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gB5TbcgKTadRNpZYesg7RXDBY6ZFYlxYzrcB8cPJzMk=; b=332FTBYv10uqtWijmBw4zxjk2L
	9GrjFozvqwYXbRpXJFF/7gHkHA1pXF8Aqc5fwnxLozhwS3HbWwzwK9weNojaKVqIgduxUhw0dayve
	6LN6DRTkxbTM4eg3hwSSPexCAMS2mTARZJG4c2EZ8fU9oWyc5PdAjWhNyvSAl7CgaYZBH/hBeq2If
	//wavN3Qd+8YrU4lCGKr9cCF3do4J4ZUCw3SdEx3HgYcG10DHYKbzbBDk+ZLD9wMMkK7JZ0cRV46l
	Z6n10Mzuv6LeYtSCLEm410pmCvXOE6Eza9NIAtgNhaVAWbbKipGULF54mWCQhDJ+SLn3X+0v9w8YH
	37c2UXew==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS2Us-000000036Wi-2ZNF;
	Wed, 27 May 2026 00:51:46 +0000
Message-ID: <9757813c-dfc2-4979-80da-c3bbf962dc4c@infradead.org>
Date: Tue, 26 May 2026 17:51:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
References: <20260526160151.2793354-1-kuba@kernel.org>
 <1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
 <20260526153719.7261b7f2@kernel.org> <20260526154001.4a8d30bf@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260526154001.4a8d30bf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/26/26 3:40 PM, Jakub Kicinski wrote:
> On Tue, 26 May 2026 15:37:19 -0700 Jakub Kicinski wrote:
>> On Tue, 26 May 2026 11:48:41 -0700 Randy Dunlap wrote:
>>> WARNING: ../include/linux/netdevice.h:2622 Excess struct member 'ax25_ptr' description in 'net_device'  
>>
>> I wonder how that sneaked in? ;) ;)
>>
>> I'll clean this up separately, hopefully we haven't regressed too many
>> things while the script was broken :(
> 
> Ugh, I'm still not seeing this on Linus's tree.
> Is the fix for kernel-doc skipping such warnings on its way to Linus, 
> or queue for -next?

It's in today's linux-next (20260526), line 1950 of
include/linux/netdevice.h:

 *	@ax25_ptr:	AX.25 specific data

from 2014:
commit 536721b1cb3f
Author: Karoly Kemeny <karoly.kemeny@gmail.com>
Date:   Wed Jul 30 20:27:36 2014 +0200
    net: kernel-doc compliant documentation for net_device


-- 
~Randy

