Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D93B0586;
	Wed, 26 Aug 2026 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776047; cv=none; b=HMxJ7ojAn+/yIbd06FV6o75WbRmBSFXiXsiXNytpeq/BhIdwnkooghdX88FbnTaE1SV9akXtmnuu4pC8PKFFZ2GX9lhKlqIBjcGd98uoB/jUGoPL1kmO/Kl10jXJOm/0VvlJgvUFKvwp14unLZOvHrFGhN6qK5652C6kLfTSZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776047; c=relaxed/simple;
	bh=Ky6LthHIHTpGbGdgl8B00TwJaOe0BFJIBEAFmD6ikRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1whmI1Myo5NLOb8X//DLrvczm8PFWyOle39sOQEijevFwv+e2gYtGgeBbdU+zpjl2+rOknEsriV9S85pdhT2CjwNiTcEr0A888pC6QYqFP8eYAI2sj2FcLISct/SkPKZeaXhUqXvoUdyWgKy12VnSrsYV5SZmtxXjqL8twk0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=S+AmJYRr; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="S+AmJYRr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F27701E25E0;
	Wed, 26 Aug 2026 22:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787776043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WHfz/XH3YitbIt7V+TouW3EtPz2ZC9CU8oNr6aba570=;
	b=S+AmJYRrI2BDGneRLc4Xr40yRRcGOYvqCju3wJn8tIGW0L/mDN683PvTJ/ycfyFQ+q7roV
	8olNPruPc8pNflssh+kYlnH2lhzPkUB3G2E6JbLW0i5WZeVibig7Znn46yE17IjdyhV/+S
	IMDExSH10GkUbCnyOhYIVkOrxwjOYCUL/27kCr0BU3sWcAeyGTpDu3EREDvS+nWnjEq+LH
	JWnp118lsK+96Z2DNvAmJvmuoi/eCAxd7eaJ+ShjDwSjW/dfs61Ahd+xkYOq6wZoq89nUZ
	Q44Sa6sUQUv//XgTH93FIxmong6cy6aYdZN50U7foPy89aNr2NWpkngrgYKVWw==
Message-ID: <121a7ddc-e194-4773-9165-449d410eedfa@cjdns.fr>
Date: Wed, 26 Aug 2026 22:27:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221
 gbit SoC PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: ansuelsmth@gmail.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260825193456.1823985-1-cjd@cjdns.fr>
 <20260825193456.1823985-4-cjd@cjdns.fr>
 <d7d86078-8a29-4e7f-a62e-91f6b266bea1@lunn.ch>
 <a75b6b15-f86b-4cb2-934c-87583b5bb02c@cjdns.fr>
 <4d594c62-2ceb-43c1-a3d2-731b80493787@lunn.ch>
 <cd7e6b13-a712-43ce-aae6-f45da2f77ba9@cjdns.fr>
 <25195db9-c15e-449d-b792-8f5a7c0aa371@lunn.ch>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <25195db9-c15e-449d-b792-8f5a7c0aa371@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 26/08/2026 18:50, Andrew Lunn wrote:
>> I tested my board removing the EEE disable and the MASTER line, and it seems
>> to work. I can't get any CRC errors flooding the link, and MII_STAT1000
>> reads LPA_1000LOCALRXOK | LPA_1000REMRXOK | LPA_1000FULL which suggests to
>> me that it's able to operate happily in slave mode.
>>
>>
>> So unless you or someone else thinks it's inadvisable, I'm inclined to just
>> enable these things and then wait to see if anybody finds a board that has
>> problems.
> Master/slave should sort itself out, maybe taking a little longer if
> there is an initial conflict. Where it can go wrong is when the random
> number generator in the PHY always returns 42. Put the same PHY on the
> other end and the election always fails.
>
> EEE issues can be more subtle, it depends on what the link partner is.
>
> But yes, we can start without these. But please mention this in the
> commit message, just to give a hint to anybody who ends up trying to
> debug in these areas.


Just re-sent v2, in fact after this conversation I did more testing and 
caught it sporadically failing to negotiate, so I put back the force 
master, confirmed it is fixed, and added a comment.

Thanks again for your kind review and advice.

Caleb


>
>        Andrew
