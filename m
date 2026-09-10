Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1D47A87D;
	Thu, 10 Sep 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043302; cv=none; b=d6TEDt0PKgEOqS0CoJDW0OI9gMMIzr55LCzxj/rwGN8V0kewW6KSAR4vtOIBymEaYK66XJuoLLlWLSbYyBpq0OyyU4ne5z3QRuv/052p0iiQWWlbadU4ciIG8VtTaQIXFysQM2QzRSQkWbckuzA+GKwpjq0J27zL44AAUFGvd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043302; c=relaxed/simple;
	bh=YwrlTOfmq6aUTUt5EId6n2iKhqmNEF8TYxy6EDMGv4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLHpSO1x12B6cZLOPE4iPdQKogq1RUEGiMcY0Qi6WszLLKDql0ACOY/LZ5nteO8qk2iI4MnqaG8xvvT2JXAQ0wU0nyOkcVyy4QIEpTG/efSsCP3nTNKaf7fcrV9FA4tk+pjQ6BVjh+ODGF+1SW3iW1C7o+I85z/7Nc25VVtytx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=fbwKyVUi; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="fbwKyVUi"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A50A73EDAB;
	Thu, 10 Sep 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789043291; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+8DezIineMpZtEHwPmnloDqNAEHy6Vnit4n6vy2E94=;
	b=fbwKyVUi7Yn4Tz0gfzQF3T3BHAMzDWeeP6HsaLZPs3k6/R+Yk9iiYyRDB4RGH3AozdBJg+
	50zEP62YBk5onmvik+oWkTtNv1Q1exmifGw8jGoB2JU7tOL2gVimikK7LDYeU98ON5gT+q
	WRGfQ4W7aD1WbwoXXD2QhXE8Eo4whTPvDKE7EZGELU57FimWEZxRXeFwhCmQsTNM45DXJq
	Y9N5DyuEtZpk+p2ppUM0qGIesfE3Sfz9UqVeObl1f1rC7WLzELbT0Li0EnEdK4pLkBFYNn
	8ff5ouhJckP+YzrxoFR8Hp16KLUzuzg3o89SDWjsW/kuD/RYAk4pJ0MZz6p1KQ==
Date: Thu, 10 Sep 2026 14:28:08 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com
Subject: Re: [PATCH net-next v7 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Message-ID: <20260910122808.GA323870@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260904-wiznet-link-gpio-v7-3-69f01b70c96f@marmottus.net>
 <178895754151.219967.10801079239966954315@kernel.org>
 <013fffd2-6d59-4e99-8214-1377b1cb46bb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <013fffd2-6d59-4e99-8214-1377b1cb46bb@redhat.com>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTE8/LNvONxyr26IlVCblXefvKLibOxDPb8KL/YK2MQjtuilvNIZhhFvNJvg5y6h0Hx9E0bFQvu57VxFURK3mw56WtpwHHuAur38BTqPfv37MHw2P1zn+ABY+Q4vGh6XMEBIEqi0dW3m5aCdZJOLNBoRTYIYLnR8nnPVXNHPIpSLw1rDtROpu7tfqaTc5bsxhrZbYK8prDaJzlJwUzN2j82n98KmqixIZ5PvjI6uLzhZqHejHE2W8tr5IdTGVArCZU4sI9cNimiqo5+uOYWvSifWjTANpVgQ4Mw3hHzTK7p616zs60AHE62ydRnNBojKqjnEZHoQjruV0yI4+jd0tCXEfPqZdq9sIeLRbI8rVnPk+gkpwdgXBWZfXEjOIQeAA/ZJUsB/gMbkfRoR+/HzW8m8JF1/SJPBwuzbN0ofTAIgCRU2QPQIv1vwE0oZ5ClL3q2hqvOPjdcciRHS5ENTOps1OoDBcNWZWV0jh932FMOxhNJdXKbhlBOBo7jpqpIan0QMfkOHmZLctVmuNOOdGG1ngC8wjYL1BKLZW3RSFAjSazqM57Q1g07keGpJ0APb3seavM9mOmAYKVhW3vgde1bZ9c/8+tRctbO6Mnr32toowjbkQ7wahUHofi/jgF79eQYxVE9E4k4/X00Zm8pbkrmDTTz12KWtKwxvP/SpN2VMBg
X-GND-State: clean

On Thu, Sep 10, 2026 at 01:27:42PM +0200, Paolo Abeni wrote:
>On 9/9/26 2:39 PM, netdev-bot+sashiko@kernel.org wrote:

Hi Paolo,

>> Thank you for your contribution! Sashiko AI review found 4 potential
>> issue(s) to consider:
>>
>> Critical: 0 · High: 1 · Medium: 2 · Low: 1
>>
>> - [High] On w5500 the carrier state is now sampled exactly once per ifup
>>   (and once per resume) from PHYCFGR, with no polling fallback and no…
>
>I read this one as 'with a bad config/devtree the eth could non functional'
>which does look a big deal to me...

Yeah I would also say so, wtihout an additional interrupt configured
you cannot really get notified of the carrier state changes. Only
.get_link is useful (and only for w5500).

But where Sashiko might be right is that the previous implementation
was not calling netif_carrier_on/off on w5100_open and did not have
.get_link set. So maybe .get_link should only be set on w5500 and
netif_carrier_on/off called only if the link irq is set.

>
>> - [Medium] `w5500_get_phycfgr_lnk()` returns a tri-state value (<0 on
>>   SPI/register read error, 0 link down, 1 link up), and its consumers…
>> - [Medium] The carrier state is computed and published by two
>>   unsynchronized contexts.
>
>... but the above 2 looks relevant to me. Note that ordering the irq
>enabling and initial link detection is not enough, you need explicit
>synchronization.

I'll try to use rtnl_lock.

>
>Finally please note commit c82ff94592fb68f529afe63ca7f5ddb7dae4ba83, you
>should explicitly handle sashiko's comments.
>
>/P
>

Thank you for pointing this out, I'll address the AI reviews.

Arthur
