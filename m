Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB7239E63
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494438; cv=none; b=jc/pn3tTZqRPLG+rTPb6nnq9ktBFhKqbKvW54BLl0MYCEF0LIdribbgCBZkG3SYZqizbrfEpIlcwfPj+AduP96qX6Y7CmBRyoLbfjFB2AnpMB4CJ8yIpS6aJ2waZNbZuz2GFwXcJaEEE6PWv6hSp+kct+Ne6GcL5PpJXGQuh69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494438; c=relaxed/simple;
	bh=/7C42wtfN4wi2QGjPOAqXRsBXliDVA++u/UZARfTp+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS2tJrj/l0m/s1y/NVZevLTpI4ZN7FNsudbIMtHDfXSELboNnNhs08DzoxtZ4jyZU3EDu94Yl3pdzv7XcI7Lp5FrP+kkYj5fSaJr+TUi9XheZEsVV20HZmoVvokIr0w+GIdV9zJH6iUvGEY+zo32n92H0IhPMY16nPKL+cUo3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osuchow.ski; spf=pass smtp.mailfrom=osuchow.ski; dkim=pass (2048-bit key) header.d=osuchow.ski header.i=@osuchow.ski header.b=vdKUx8Tt; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=osuchow.ski
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuchow.ski header.i=@osuchow.ski header.b="vdKUx8Tt"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fGpSb2H1nz9tWy;
	Thu, 19 Feb 2026 10:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuchow.ski; s=MBO0001;
	t=1771494431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/co7FbE1LDOOvieMRlaYdRnl3jah2chrYM/3KO5bB48=;
	b=vdKUx8Tt0RQnWRMC8R83e70Xd9yk4jttoE3iT/XBcwIfDcE2QtB3ejbK/f0eUHt3ABpAS8
	oh870teh4ho8n04VIkIhmYpEnjNAK5nvAAsdqDRLtFyhZ4IU2zypGlAndyWSacSi+cFG2T
	ldS8I0orM1AbA1ACZL7Z9QfGbz89AAAsoHEP4SMGVw4OTQOTiP0j6aJijMbckxdX6j+PPA
	H9qF1zbOfCqwYMI8NqyP9toJs+WYi90hU/gFXac8aK5GqnQsOvDTEz3x2VkJLm5ec9ixbW
	cx4Ebc2hdVbs1piH2aACeGyo8gYM9ZWtgJb+qOMO+jvOF0rL4P7Una7/ZjpOZg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of linux@osuchow.ski designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=linux@osuchow.ski
Message-ID: <55190384-e06a-45ef-ba7c-55d341e93e83@osuchow.ski>
Date: Thu, 19 Feb 2026 10:47:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANN] netdev development stats for 7.0 (and some AI review
 thoughts)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260212124208.187e53ae@kernel.org>
 <d3e7fa70-4035-47e0-89cc-92d636497198@osuchow.ski>
 <20260217141500.00c3fa2d@kernel.org>
Content-Language: en-US
From: Dawid Osuchowski <linux@osuchow.ski>
In-Reply-To: <20260217141500.00c3fa2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4fGpSb2H1nz9tWy

On 17/02/2026 23:15, Jakub Kicinski wrote:
> On Mon, 16 Feb 2026 00:31:08 +0100 Dawid Osuchowski wrote:
>>> One more note on testing, we have completed the migration of NIPA
>>> to netdev foundation machines. Due to DRAM shortage, however,
>>> the shipment of additional machines is delayed.
>>
>> Just something I noticed that might be connected to this is that the
>> links to "Raw output" in these announcements broke for each previous
>> message you posted.
>>
>> It is possible to use the new link convention/format:
>>
>> 	Raw output: https://netdev.bots.linux.dev/ml-stats/stats-7.0
>>
>> to go back as far as 6.18 stats e.g.:
>>
>> 	https://netdev.bots.linux.dev/ml-stats/stats-6.18
>>
>> but beyond that (6.17 and older) it doesn't work. The "old" nipa links:
>>
>> 	Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.19/stdout
>>
>> are completely broken.
> 
> Yup, this is due to the NIPA migration from Meta systems to netdev
> foundation machines. I can regenerate the outputs if you need them
> (modulo the JSON format changing since), LMK if and how far back.

I don't need them, just noticed the gap and reported it, as I thought 
you might've not been aware.

> I did copy the "time based" stats from old machines (3mo, 6mo etc) FWIW:
> https://netdev.bots.linux.dev/ml-stats/
> which I suspect to be more useful for actionable tracking of activity
> than the release-by-release. Release stats are mostly an excuse to send
> an email to the list and thank people :)

Understood, in that case my response above still holds true. For myself 
I don't need anything more, but other folks might want/need them for 
some purpose. If they do I guess they will let you know one way or 
another :)

>> P.S. I am using a freshly setup email client on a new machine so
>> apologies if the formatting is wrong on my end. I did send this message
>> to myself for testing and I think it's okay, but I might be missing
>> something :)
> 
> Looks fine :)

Thanks for confirming!
Dawid

