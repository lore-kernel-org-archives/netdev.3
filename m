Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49A403E9B
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659238; cv=none; b=Znd7jLE6hn8uBLFfPOFAjJqPSRx44w7rU8+5ztLNBudGTzW9p+r3MIdQpz9bcpdoWOj32thew+HkID9gL6vgpeSeciApV9I+AL0TgG7ULbsPhyS715Y0+/dtTq1aTZqER1GUsm5qwMzPQgVrKQfogGcIhXu9MLQPIjbt3y6wYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659238; c=relaxed/simple;
	bh=bpPNaauH/yOzYK6a9nhtjXkDAHrgKfv4q64NZhpBnIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MS+ZN5FQXHOQ7MDE3zmb91JRpQ9z9CpcFJhFbhQeC+Pmjl6IPs9+qo9yf+onricJvagwysvyCuvFuL/7/UqVPJ9G1z5l673goFDw7Bf/mEsfavk4szTlMF8TU7zkJMDMTOOhKhSsVgilblbrZy6U9vMlDOAUujSsnuuWXXtJoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J0h2PeDN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J0h2PeDN"
Message-ID: <f136bfb9-1756-4668-acc3-68962cdc6069@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784659232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ0ot31OHK/yKHYfVophm/uoJcYCC1GLqv4iR7SGhWc=;
	b=J0h2PeDNrV4mUL/lMSCWB3ozxfOmiFEAutGdpxwvDKiYXaM0yDnwqit3tFvdSpj3K7yQCR
	btZijJ+cbjKfvXSiWNAiWf6J/zMY0eofH6cWcMIjnaLy/HuAxAWxYgN8LugnTZn4jeDq/5
	FbNS02otY6qqcsd8SVL9Ud/Pu3VmyeU=
Date: Tue, 21 Jul 2026 19:40:01 +0100
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
> 
> OTOH, doing this dynamic range calculation should be computationally pretty
> cheap overall, and provides flexibility without keeping or adding new
> concurrency problems (which is an important concern!), so I don't mind the
> current approach even if it does look wasteful.

After thinking a bit more, I don't like the idea of copying static constants
over and over again in cases where we have pre-defined ranges. What about adding
an array to the pointer, so drivers with dynamic range calculation can fill up
array per query while others can simply put a static const pointer and don't do
memcpy?

> 
>>
>>> Since the kernel API changed here, change the in-tree drivers that
>>> report FEC histogram stats to copy their ranges instead of just
>>> supplying a pointer.
>>>
>>> Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
>>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
> 

