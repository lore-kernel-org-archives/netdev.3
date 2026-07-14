Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F43EC2EF
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013859; cv=none; b=qlVC2MkghUVjMs7vR6qomX1v0NpK11O9q77888CLBI/Eng423vnPGhNUSCvhb9mhDGhEz8nCw8pA/ODrp9VxEWMVRbzsbGoaP/Z5JAinXRszZ52iuU/rsSplne2YkFBiDewO6Qp08uneqFA4m69/E7SUwRScI5gIo0TUQ4XvCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013859; c=relaxed/simple;
	bh=mSUr/6R1qiFv0b+xxtketCI/fOxw7qno1faBeXUm8OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvvWZhqSncwk5zm5dyvY8+h4pNBRO9jyVrdm0ZP47oXpvsPHBcNN93QCsTrz4xpyndt5oNea8FPLK3dDg/wtLsEWmlSfLUBArjmZBTmUxU469LkFJP5Aoqjd0tc1hcR7DmzbnoN9TxaBAVbUogzmPCGwjDLDjA45fxqpY1FP0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tpEoW0AV; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tpEoW0AV"
Message-ID: <2cbf31f4-f9f8-4130-86b6-e4c8c7125bda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784013855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9WCeTIyFhenUiyWcHq2wH+tqrW6j+TlfUmjN94wNZ4=;
	b=tpEoW0AVA84DU56yWhaOjzid4WiKCmPnhFOa7wv0/xbnxC3JpohZNB4Sz7Dzji9WzA3tKA
	CXBZylL3pNVuk9SsElkFwMLnOea6bZu8K4y7rxSfDeGgUlWLYFTgKKrdyKIW1oroM6keGr
	51lcTYbOOWY/5TnXF9I/bUKZzC77C3Q=
Date: Tue, 14 Jul 2026 08:24:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ethtool: Embed FEC hist ranges as buffer in struct
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260710230026.47721-1-eric.joyner@amd.com>
 <45d2be78-4e58-445e-81b2-75dbcd15402f@linux.dev>
 <303a0166-efd5-48b1-8a52-39780095b7a1@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <303a0166-efd5-48b1-8a52-39780095b7a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 13.07.2026 23:37, Eric Joyner wrote:
> On 7/11/2026 2:03 PM, Vadim Fedorenko wrote:
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 11/07/2026 00:00, Eric Joyner wrote:
>>> When a driver's .get_fec_stats() handler is called and the driver
>>> supports FEC histogram stats, the driver supplies the histogram bin
>>> ranges via a pointer.  This pointer is assigned while under the netdev
>>> ops lock in fec_prepare_data(), but the actual data is only read after
>>> the lock is released; so this allows the driver to change the ranges
>>> (e.g. from another .get_fec_stats() call) while the current call chain
>>> is reading them in fec_fill_reply().
>>>
>>> Fix this by embedding a buffer for the driver-supplied ranges in struct
>>> ethtool_fec_hist instead of using a pointer; this ensures there's an
>>> ethtool core-owned consistent copy that can be used after the netdev ops
>>> lock is dropped and later in fec_fill_reply(). While some drivers like
>>> bnxt use a constant struct for their ranges and won't be affected by
>>> this issue, others like mlx5 (and eventually ionic) will use a
>>> dynamically constructed range struct and could potentially run into an
>>> issue.
>>
>> I didn't like the idea of dynamic range, FEC is not changing while the
>> link is UP, I don't see a reason to dynamically reconstruct histogram
>> bins every single call. And the histogram itself is stable per HW per
>> FEC, can be constant pre-defined struct in a driver, like in bnxt.
>>
>> But if dynamic allocation is the only option, then yes, we have to
>> change this ABI.
> 
> We can discuss this more.
> 
> I think overall drivers aren't going to need to dynamically allocate a range; I
> mention ionic but at the moment I think there's only going to be two possible
> FEC ranges; the sixteen bin one for RS(544,514) and I think what should be a
> reduced size eight bin one for low latency RS-FEC RS(272,258) (unlike the 802.3
> spec the Ethernet Consortium Spec for LL RS-FEC doesn't talk about a histogram,
> but FEC math says those parameters can only correct up to 7-bit errors).
> 
> So one option could be to have the pointer be required to point to static
> memory; or possibly a pre-defined histogram range entry in the kernel? I don't
> see any other drivers currently combining multiple bit-error counts into one bin
> and I wasn't sure if that's something the mlx5 driver actually uses, too.

The problem of mlx5 driver is that for RS(528,514) CX6 firmware returns only 4
bins with merged ranges, while newer generations have 7 bins for the same FEC.
That means core kernel won't have all possible options and the drivers have to
have their own static lists of ranges. But it's still stable list per HW per FEC
as I stated before.

> OTOH, doing this dynamic range calculation should be computationally pretty
> cheap overall, and provides flexibility without keeping or adding new
> concurrency problems (which is an important concern!), so I don't mind the
> current approach even if it does look wasteful.
> 
> - Eric
> 
>>
>>> Since the kernel API changed here, change the in-tree drivers that
>>> report FEC histogram stats to copy their ranges instead of just
>>> supplying a pointer.
>>>
>>> Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
>>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> 

