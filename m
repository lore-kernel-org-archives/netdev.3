Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4E435539;
	Fri, 24 Jul 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908437; cv=none; b=tNCHc0YrGd0Wg2FF4LsN4ZH5EL/5cJRFhuudmy7ppU6bvAFcjjucxklQOppMx9/tJWG84NSLkvN6uua0K2UoGy54dE4iABaDKD8MSwQcAYGnyqOqZBYyGka+g5SZPUE9KwSBrASRXBPJG3mHGbaPPxTkuvL7GAdJuSrg2VRE+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908437; c=relaxed/simple;
	bh=pH5jR9xHzNHkt212+X3a9RpQRk4i4MFoDNNBlQ9x2Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k14NXJQLd+TLd6y/yV2baBVHuHwCnYcZJHzWoYNGSUR/bk2heeIheQVFiqTHKi954S7t5Sq2KxeiWyVZedSe27dbUeqBGtKQezOy9JT+o2cUFnAnpviwkKJb/Y5ixcmnDRnJlsdRivosDLXLxZYhzE0T5A5+iZxVUNEvHl64NpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=um1KPIIw; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=um1KPIIw; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="um1KPIIw";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="um1KPIIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784908433;
	bh=pH5jR9xHzNHkt212+X3a9RpQRk4i4MFoDNNBlQ9x2Ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=um1KPIIwArl2vRy9Z6rlKz2hp/4mtCr1IXjSMvrSOpcC93Ep6NAyLdAzGXo8DE3HZ
	 Lz+Nq+6tOLlkDM7W+0SFoBQkOWZAvsy1qhRFbuzCU5wXDaS1D2TAkm1mwgHW14NSY9
	 z0eOC1Vi4zr4bHH/dni8RIwRlzHGMowywUA7nSn34Xk4AqF+PEw18fxu13lP1gdKPK
	 ofFHr7iV/hWRkYRL60QEagJAHNPTPO2Re0dy0r+avDdnGh0u6Qkivnu7cPvrrMdR9x
	 qBQn0yXBtS3iI92EncoGLt7+dWty/PuWDgIqtG0dLgrrGwgeMl3gulPFO8Duq4X1Ai
	 rEpUR6iVfIErA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id F342849441; Fri, 24 Jul 2026 15:53:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784908433;
	bh=pH5jR9xHzNHkt212+X3a9RpQRk4i4MFoDNNBlQ9x2Ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=um1KPIIwArl2vRy9Z6rlKz2hp/4mtCr1IXjSMvrSOpcC93Ep6NAyLdAzGXo8DE3HZ
	 Lz+Nq+6tOLlkDM7W+0SFoBQkOWZAvsy1qhRFbuzCU5wXDaS1D2TAkm1mwgHW14NSY9
	 z0eOC1Vi4zr4bHH/dni8RIwRlzHGMowywUA7nSn34Xk4AqF+PEw18fxu13lP1gdKPK
	 ofFHr7iV/hWRkYRL60QEagJAHNPTPO2Re0dy0r+avDdnGh0u6Qkivnu7cPvrrMdR9x
	 qBQn0yXBtS3iI92EncoGLt7+dWty/PuWDgIqtG0dLgrrGwgeMl3gulPFO8Duq4X1Ai
	 rEpUR6iVfIErA==
Received: from [IPV6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258] (p200300c69f1c3c0011126ccacd9ab258.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:1112:6cca:cd9a:b258])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E77D749369;
	Fri, 24 Jul 2026 15:53:52 +0000 (UTC)
Message-ID: <6a1935b9-dd81-447d-8a38-74d9c19be653@birger-koblitz.de>
Date: Fri, 24 Jul 2026 17:53:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
 <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
 <f66c5d19-fac6-459b-b3d0-354893258073@birger-koblitz.de>
 <6042ea40-376c-43d9-97ab-13243b946a50@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <6042ea40-376c-43d9-97ab-13243b946a50@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/26 17:35, Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 05:06:07PM +0200, Birger Koblitz wrote:
>>
>> Thanks for reviewing the patch-series, Andrew!
>> On 7/24/26 15:38, Andrew Lunn wrote:
>>>> +	if (data->phylink)
>>>
>>> When did this appear? Am i missing a patch somewhere?
>>>
>>
>> In [PATCH net-next v3 02/13] ax88179_178a: Add HW support for AX179A-based chips:+	struct mii_bus *mdio;
>> +	struct phy_device *phydev;
>> +	struct phylink *phylink;
>> +	struct phylink_config phylink_config;
>> But admittedly, this is a rather big patch, which I was unable to break apart
>> due to in particular int ax88179a_bind() referencing most of the rest.
> 
> Ah, sorry. I took a quick look and assumed it was just adding new
> devices.
> 
> Does it make sense to do the conversion without adding new devices?
> That might make the patch smaller.
Well, only the new devices use phylink, so it is not converting the existing
chips. That is why it likely needs to stay together. My handicap is really that I do not
have access to the older chips and from my experiences with writing the phy drivers,
it is absolutely necessary to have access to that for converting them since one
cannot make any assumptions about what is in the registers describing the PHY itself.
My hope is that the older devices can be also converted at a later point and then
remove all the MII stuff entirely.

Birger
