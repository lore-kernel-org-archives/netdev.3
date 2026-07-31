Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76474457B5;
	Fri, 31 Jul 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514014; cv=none; b=Yqz/Z3jV5tIXmdNArjiOgGjDaurO7atKnUtIbc7HxN6rKdwxw4+6smmJzsQmI4aiLUiWpv+WWPLW+9hcpekYPTKPBx/hR1+T1/aCsscWmwEVA89FL8f83kFk6uo6s+/XCAZzKVi/EcH3dnvGSLi0lY82m8XreQtEyCxzCx+3HdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514014; c=relaxed/simple;
	bh=1nEG1vtutbdA3vK1VYmDnSguaehOwWKHv9dFl1QMlhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL09OD5QIDZBK+MlMJ7Nl4Z4DnGagULoefWjkFSa69GTAyRjbgKxrzdjNUulL1WR3ZiYO+AHMQxpeMqhplr8OYOHUb/i4zva2BaXJQrNb0+KZIN2CZA8J+cvr/I/HT1o3EsPWD3Iiqm0Vqmr8nAXNukNEFCpJwFAkia+DlFGq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xVjFIJlq; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=1nTJOPMn; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xVjFIJlq";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="1nTJOPMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514005;
	bh=1nEG1vtutbdA3vK1VYmDnSguaehOwWKHv9dFl1QMlhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xVjFIJlqEDYKf9W1KRj3PwzuBunrtjwhnWuCoNj2rs6TqkNHE5HHhwvIxAfdMbtjZ
	 MmQP3oG5YsH2qGd+JQeucfoIVbZzq32YLzQDg7juD490e0jSVibm95XZwFoWB5Uqel
	 zwidIvJZNEv7k9HOuqN9kWKYVaZl0HOgbZ55aGM13kQB+7ASLL2NoDTdgiDbgtU+09
	 gCfRwnFflxgPQ9Kc8G2CEGgG0FZz3Oc+jN+b5+1Zqk+MmZaInI5MdGlACNjhV2ALmw
	 BOzCTJ55LU4Rod+u2VhaS008CXxS9rovrGiitZQAESyKc44JxhaWbaBaVQuiraWQT2
	 ztWwj/VL0C0Hw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7DB18494F6; Fri, 31 Jul 2026 16:06:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514004;
	bh=1nEG1vtutbdA3vK1VYmDnSguaehOwWKHv9dFl1QMlhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1nTJOPMnLJtZ+xAPLOg4GquBuaZIwYALZ1o/jY4QKMQdsACYcJMN4qWx8CsyU2EBc
	 iqnPN8AVqEu0lY3+pL+cP9OBdm7BSlgDHAoxWcS9HPl6EDNZfu+VclhLLmGN3qMCHA
	 td6B2YCQNBwBDAPRRLCmqqsXqhSjeRZXAcKroFLr+QykM2UAxMottz/hac5LlCOjqN
	 9cAD8i+XD8fUal5liBvqux7KVs6TKgFrKl7NMqnydqseclsxBKw58mVeW4X6Ar8B3y
	 ICkXJTwccTQKCnMRS2oYjmC91kmSiOYKx/UIxikRmzyd06TdzNO3Hdi9pTzb828Rth
	 sEFPjMv9ksUcQ==
Received: from [10.99.12.190] (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6DDF6494ED;
	Fri, 31 Jul 2026 16:06:44 +0000 (UTC)
Message-ID: <10846ba2-1c3a-4e6f-9f2a-711789c36dbd@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:06:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/13] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-2-bdde4f905883@birger-koblitz.de>
 <9cf523c0-f765-4be4-8b8b-7b29a3ed6329@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <9cf523c0-f765-4be4-8b8b-7b29a3ed6329@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2026 18:22, Andrew Lunn wrote:
>> +static void ax88179a_mac_link_up(struct phylink_config *config,
>> +				 struct phy_device *phy,
>> +				 unsigned int phy_mode, phy_interface_t interface,
>> +				 int speed, int duplex,
>> +				 bool tx_pause, bool rx_pause)
>> +{
> 
> 
>> +	ax179_data->eee_enabled = ax88179_chk_eee(dev);
> 
> With phylink, EEE works differently. You need to provide
> .mac_disable_tx_lpi and .mac_enable_tx_lpi in phylink_mac_ops, and set
> bp->phylink_config.lpi_capabilities etc. Take a look at
> 
Will be fixed in v4.

> commit 0cc425f18f59f992c61c1802331d25ce689ff5d1
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> Date:   Wed Mar 4 11:54:29 2026 +0100
> 
>      net: cadence: macb: implement EEE TX LPI support
> 
> and there are other examples.
Thanks for the pointer!

> 
>> +	netif_carrier_on(dev->net);
> 
> phylink devices never touch the carrier. Leave phylink to set it.
Removed in v4.

Birger

