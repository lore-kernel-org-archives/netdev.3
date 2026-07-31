Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D1449B1A;
	Fri, 31 Jul 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514106; cv=none; b=sz5GKjUHFBNMY6DKtUoJ/QCvwGJTC7w4gbyCXEx52qv8Au35HnELdn/9WISeqS+dpMTahnCH/BzZSFj1QxjKyTIMiRLDAbEL/80a0yvs6V732AIuQWXqMyO/Q0sTGyVgoiVHoCgIaAT8w2SP89MkK07VQ/RIsbnYsLzkUagczEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514106; c=relaxed/simple;
	bh=5XkZntNkglCt626FlCzcq3ASNg3F+oFs6UYZHSu22NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRo+aW2GusMJnfZoHq/qtp4njqDeHXOEhz8bK2AjmsNAM23Es26Fl+HwoVv0cjISLhCWqoowwC8i9uwVeUuafv3/XZxJUO8uTyrt725bdon5SbQyJnyvQlbNZehuUrXWStYCQAyTSsjev3w4GoCCAGPq0Dca+oOnjwwFJsGaSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BR0KNCLc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=i0xODZSh; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BR0KNCLc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="i0xODZSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514103;
	bh=5XkZntNkglCt626FlCzcq3ASNg3F+oFs6UYZHSu22NI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BR0KNCLchZg34Q6KR561wMZltJxXHN0kRj1rd3AZ+6lengL+zu+LXxB0KRQJE5kl8
	 WxI/MKQyOm4+nH4xw3O3cyHHswZvI0OqLu63cWc5qsO2/hoUK0zjp+Br/nEVeKWhYs
	 pRXrUKhIUeauIjiTsJwiHisrfuQOP3tQn1WhZ8xfOUO3PmtY0BeOLa2LgK2Enb8i5M
	 qTHcxy2+OH4kWRCBnKK26WhD0uYmxz4lr0jL/XFckm3U2ejmWbIN9ysv109XhQICA4
	 SZLc2dhOXLYnQ7KDKPbaIDBBossPt07X0YZMClFzJfKd34HvV7T80QzBGipcwJtcz0
	 RQtWcucO6sISQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id AE844494F2; Fri, 31 Jul 2026 16:08:23 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514100;
	bh=5XkZntNkglCt626FlCzcq3ASNg3F+oFs6UYZHSu22NI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i0xODZShWxeHETWgnYOrMKBg43CofIeOgZywnvD/TIR9AVz51vQEYmMru2zlMMoSL
	 MoPYOmKu67BQmmRYAmP5Kzw+n1SVWo1Uj+Hw/n7QpQNkme97vE+YVfl+XkZ7b2DI+G
	 IFywPBmNUCWQmQVUXyJqONeePcXOQDZaohs9llr+xcgWTSo6S5MIg3NmGlZfKlegeb
	 GfPiAikHwE908XBn+qWTREiAiZ/1KJ3216i5AruXLY/DudT/jcNrQO+geXbnQe+U0l
	 C9DnI6YqzauXN9qwVv2SFgz9rn+NX69PBmiAJ0R5gNRmtg3iEUbZU37ouuQDteJXaH
	 33aSLPkl4oRag==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CBA21494ED;
	Fri, 31 Jul 2026 16:08:19 +0000 (UTC)
Message-ID: <518dbc9d-96fb-48f7-b069-9cb1f1f335f7@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:08:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/13] ax88179_178a: EEE setup for
 AX88179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-6-bdde4f905883@birger-koblitz.de>
 <11397c47-a654-4c22-8af5-96cadc4797fc@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <11397c47-a654-4c22-8af5-96cadc4797fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2026 18:31, Andrew Lunn wrote:
>> +	if (ax179_data->phylink) {
>> +		ret = phylink_ethtool_get_eee(ax179_data->phylink, data);
>> +		/* AX88279 MAC does not support 2500Mbit EEE */
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, mask);
>> +		linkmode_andnot(data->supported, data->supported, mask);
> 
> When you tell phylink the MACs EEE capabilities, this will go away.
Fixed in v4 with lpi_capabilities.

> 
>> -	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, tmp16);
>> +	if (priv->phylink)
>> +		return phylink_ethtool_set_eee(priv->phylink, data);
>> +
>> +	tmp16 = linkmode_to_mii_eee_cap2_t(data->advertised);
>> +	return ax_write_mmd(dev, MDIO_MMD_AN, MDIO_AN_EEE_ADV2, tmp16);
> 
> The phylib should do this. All the MAC driver needs is enable/disable
> the LPI timer. Nothing more.
> Fixed in v4 by using phylink exclusively.

Birger
