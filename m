Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AC38E8DB
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784322391; cv=none; b=XK17xI1/qk+05GCIF+zS44gyUnWv221hnV50pIB7WOwy+n+7auLoR1gLwQTNhEHV+W88R2JLKuOPnEhmaqjoarwj4lQh8P6acd6UpAk0DOm5icrJv5QM2BpE+VoO3m+/v+qbR4GHjp1JI27tdmuKTYwAEWwcwIVE6KyFvAEOsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784322391; c=relaxed/simple;
	bh=ASdT0f8H3yfgG5E46En01VC9ok09vx95L5+FlCaz4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLrJUzdWzKrPPRltSRF9BqHGMhAxd/+dhwQ4crbpqrTdOj3n0Klk5zC+J/FLW8CsgGxaK4gX/iUGOOYZ0X7i4BU6wQg6jVdu0ubZB2rxKgpq8Hb1Vixsf5Am/fbJd7mOx5NeS4ouJVUg447xTJe2KwX75ZMhzPqzUDgQfgaucJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPUuhYGK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPUuhYGK"
Message-ID: <c559e661-95c4-0e81-f8bd-b51f27bda8e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784322377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPF/Is+uBt5eHkORkKAjtT0f0UC1SOLzIhxi9hHOXOM=;
	b=rPUuhYGKSXs69H1MQfPXPO+Emijl0M+ww/rlnNyG9T9v5fh6jTLJGdNzTOHczv6rCXSgP0
	4i11Hb+VA8KqHmknVa7uVu66TfJWinrecK1LN0ogIFljbQZQRndFr34WfuuzAqk7fupmY3
	a0Ygh/Y9frc0gS9CVVwfyR9RiSfMmr4=
Date: Fri, 17 Jul 2026 17:06:13 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
 <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
 <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
 <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
 <26cb3349-5344-48c0-b0b7-37133b4e0662@redhat.com>
 <eee42ee1-386e-996f-b9d8-8aa2e820d311@linux.dev>
 <382033a5-77a6-4505-ac50-58120308507b@redhat.com>
 <DK0V3M8CTZFU.1T6GJTFM5DJ4M@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <DK0V3M8CTZFU.1T6GJTFM5DJ4M@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/26 08:57, Michael Walle wrote:
> On Fri Jul 17, 2026 at 2:44 PM CEST, Paolo Abeni wrote:
>> On 7/17/26 2:05 PM, Sean Anderson wrote:
>>> On 7/17/26 07:11, Paolo Abeni wrote:
>>>> On 7/17/26 12:13 PM, Michael Walle wrote:
>>>>> I've seen that, but.. that was the actual change between v1 and v2
>>>>> as suggested by Sean. It does not depend on the actual link speed,
>>>>> but the maximum link speed. So it is not relevant if the link
>>>>> negotiates to a slower speed or not. At least that now matches the
>>>>> behavior prior to the phylink conversion. If that was working -
>>>>> that I can't tell you.
>>>>
>>>> I'm sorry, following all cross revision discussion is a bit hard here.
>>>>
>>>> I don't understand if the 'link never established' is specific of your
>>>> board, or it a constant with this driver. Could you please clarify?
> 
> I don't think it's related to my board, but rather to the link being
> a SGMII one on my board. I assume Sean had an RGMII link while
> converting the driver (?) and moreover, that it worked correctly
> there :)

I didn't have a link at all! I only personally tested this conversion on
layerscape (memac). I'm pleased to learn that there were only two major
bugs, but a little concerned that it took four years to discover one of them.

>>> I think we should set byte/nibble mode in link_up as well as mac_config. That
>>> should fix the problem where the link never comes up (possibly broken since
>>> the phylink conversion). I think it's unlikely that this config is supposed
>>> to match the phy interface speed and not the link speed, but you never know...
>> FTR, the above does not answer my question ;)
>>
>> Still I think (mostly guess) bringing the mode initialization in both
>> link_up and mac_config should be safer (that is, I agree with the above
>> plan).
> 
> I agree. I looked at the original driver and there adjust_link()
> will also select between byte and nibble mode. I'll prepare a v3.
> 
> Sorry, I misunderstood Sean's intention/suggestion, thanks for
> pushing on this. FWIW, I also tried with nibble mode as the initial
> configuration on my board and link_up() is getting called. Whereas
> if it's 0 (as in being documented as "reserved", though it's the
> default), .link_up() is never called. Thus, it seems that it just
> has to be any valid setting until link_up() will set the correct
> value.
> 
> -michael

