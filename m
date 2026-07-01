Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC133AF676;
	Wed,  1 Jul 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937976; cv=none; b=sb1vdT38c7WPOj7d1kT+aw6A8DKw+t8c9Fh1msAb90s4m6U00IuJJhzGvp0yzgms6R7fzuP2k2qzUYwQ/eLjsuPR2X5NMWw1lhZ3/N0d1kylEbJxShnVHwVSJVlb02R58azjwj54N3Kt8yxR5iZ+wi1whsysaL6L/PIugm+nHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937976; c=relaxed/simple;
	bh=qWm9LX37sYO0MkUyQuCpsu5534nbCncHhb+IAP5U1Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r56dFskOLQ+9k6fE0ps1dtgx6mNbqqA+uoZyzlUjqMRvQqjvm+x0H7OPSX7ihjOEADEfMAPEaiVPq9eKwAErJjYkl7mljCd9x9EnOmmqIs3XssuMfgpMB3lxmwmdwyPl5GHVWp0R0p4/rTlHXJhW4nJm/4Wionf2JlSYnL4yzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xobDnYgu; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VixF3G5A; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xobDnYgu";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VixF3G5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782937972;
	bh=qWm9LX37sYO0MkUyQuCpsu5534nbCncHhb+IAP5U1Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xobDnYgu9VVvQz28oygfvZJZNauh97OQZsGq2yaEVk7jLuPz/k8vhjcK4ybIOBWkO
	 sIpK3nctIsDqNEB+2gFwrhJWfoz7ZYNoXM2TwvJzr3trMfRTqyt7OVeu4rGeJJ2Ova
	 wwiM7Ky5z6DiKvzrMuZCLnYLF4Jga+mrAyVdTxljACRjWtGOxtdAYIysr0/uxl2aP+
	 80ntNn8/vRQZCTWCmFNLbhZoI02TZzeZJ+tE74pL3YtD6K8o3w4a92A5h7P4CgiSgP
	 tmXPXQRrqUCJyMub9S+bwhx5m4HDxC1zO9XW+WRcFr/c1gZiR15V5/H9YEcNib1oix
	 /IiEiUkqlOQgg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id AFC764936B; Wed,  1 Jul 2026 20:32:52 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782937970;
	bh=qWm9LX37sYO0MkUyQuCpsu5534nbCncHhb+IAP5U1Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VixF3G5Afzs8LmtMRESvVVPLh5hZJpCmzAIWpIOyrDwhSfWqX85GIA6c+6UGl4zFR
	 oo5Jh0h5eDXb43T64ttlD+wGI1ksTeAO5gXS167Qw7ZEKjHLSxGMmiFn7Pum/XWbfK
	 H5xx8+7W8ETwSQPV2u2Cyd0QAs8yipMoP0Pgx+eISi5DwWjQgHGU3GDkDiRiYXVlaQ
	 RFASI8IwEJUdgHD8Ousut5mL5227Hxkc0/j5kRkWOS0yGzNizZAHSYZud/FV8Mtz59
	 GI3Qhi39IEaXAjtUyAXrvKv0gcLxLJBTSPjJMBFaxzuySeQLzCNuSIsSDRDETZ19xU
	 RGvtlfbv+aYDw==
Received: from [IPV6:2003:c6:9f1c:3c00:add4:fa17:212c:ec8d] (p200300c69f1c3c00add4fa17212cec8d.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:add4:fa17:212c:ec8d])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3A2304935B;
	Wed,  1 Jul 2026 20:32:50 +0000 (UTC)
Message-ID: <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
Date: Wed, 1 Jul 2026 22:32:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, olek2@wp.pl, pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2026 21:29, Andrew Lunn wrote:
> On Wed, Jul 01, 2026 at 07:24:13PM +0200, Birger Koblitz wrote:
>> Hi Jan,
>>
>> On 7/1/26 19:13, Jan Hendrik Farr wrote:
>>> Hi Birger,
>>>
>>> it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
>>> Could you send it for people to potentially test?
>>>
>>> Jan
>>>
>> The code to create the binary firmware file is at:
>> https://gitlab.com/koblitz-rtlnic/rtlnic_fw
>> But I cannot submit the firmware itself to linux-firmware, as the sourcecode from
>> which the binary data is extracted is published by Realtek under the GPL.
> 
> The obvious work around is to not convert it to binary.
> 
> 8152.c has a clear GPL-2.0 header. So you can edit that file, extract
> the two arrays, and it would still be GPL. You can make the firmware
> loader in the driver parse the ASCII array as it is. It also looks
> like you can .xz or .zst compress it, and the kernel
> _request_firmware() will handle the decompression for you.

The binary firmware file that the driver currently expects has the same
structure that is used also for the other supported chips, e.g. the
RTL8156 which were provided by Realtek and are already in the
rtl_nic directory of the firmware. There is a bit more information
in those files such as a pointer to the right flash update registers
and also version information to not update newer chips.
Another solution would be to publish the binaries with linux-firmware
alongside the bit of source code that creates the binaries. Firmware
file and source-code would be licensed under the GPL.
I still hope for a reaction from Realtek, though.

Birger
