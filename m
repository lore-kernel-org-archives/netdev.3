Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F93ACA4C;
	Thu, 16 Jul 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214225; cv=none; b=cL/GoN1V0pkvV5WmW1eeLe4tnP+tySyMDc1/ZhhjECG1txq4/hTR/eAU9z/6PeUlwrWoSv27NIr+hPkbjxyRWHGnwDxcgRVuo6yJ1zrRmKyCvd9Ne86trb2hzviEvaSN2xbGvvtYfp4Pdk4uf+Z2FiETjDEymMs5uQSg+OaaB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214225; c=relaxed/simple;
	bh=qq+VdI/9klQNjOHl3y1LbQQxSp4ObtXo54lV0dv8Yrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzElxXOonnx2cFQDmFnWenTVGnv7NURpKNsER6AGIOHUgyKW+iTHK2S9PIn6dNLd19LGQnPcMyYXxmFnwuizt0Wl5kj1UY4wrdp1DxpgiSmI0BOc/tvmsdmjoVDR6TYWGpmd6bcJBQ1jY8PRL7NNvLl+jvQQsCz0hnzJIecPfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=lHX/Myvd; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=JISOUZ4g; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="lHX/Myvd";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="JISOUZ4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784213656;
	bh=qq+VdI/9klQNjOHl3y1LbQQxSp4ObtXo54lV0dv8Yrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lHX/MyvdoCM99kLTkPtBIB+iIhx3/mmJjoZZAFuJslxPpXbJ4EA2K9BAiIPAOwktH
	 s9nGrnU8R5Hy73HRK40aRtp/dWNgo/sRSFONYNUPINqJratK7Ysf99kCPVQv0RTd2R
	 pOD1qlIPr2B8dtZMpw1ZyBcLIaCbq0sbXN6+d8fF/3HvBLCoQaFyuQsHqOv1CNTF2J
	 WDUCBQfPy8bT2nD4o/OWaqir+Uu2WFtzWbdpuuhq7FGdyHozx5qTX25kz14Al2jWBR
	 fxXi2OhMWzKvHmbx/h7UJ923/hvi0gTw5wMyIjywLxExv3vmQqDM0xtgwBmVxMWGRv
	 +AafBIUo9G+7A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id EBC6D48A5A; Thu, 16 Jul 2026 14:54:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784213654;
	bh=qq+VdI/9klQNjOHl3y1LbQQxSp4ObtXo54lV0dv8Yrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JISOUZ4gSwfzIeCssWjyNP3aiJ2jp9+Y1szY5tBuGmxwKoVoi0z4vEJee7cG+yYOd
	 xpETcCt3sR0A1vsgabf0opGCjvYP4MrQtljdfxe+IVUDKCYO9HYo2mt/65j5HJHFAm
	 ik0z+8QiwFP2sw27VNMVZgoJ9ojxUWiIOngP+YmmfqImcZf9iAaql0diN+k1cRqtTE
	 tucoOMqpZ/vJjmBlW8RTmKoZgxxgY+weL3eLDossRIn1+RYLa6jdxcGKnQ1zBVrFqd
	 EO9ppTyIb2WDtLa6ZVRvIP1cqdFbfmCS+mRzqLjJWdZps5TQsmbX+SErhxx217YfwO
	 SyXfqKzo2o6QQ==
Received: from [IPV6:2003:c6:9f1c:3c00:bbfc:bbca:ccd8:f82e] (p200300c69f1c3c00bbfcbbcaccd8f82e.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:bbfc:bbca:ccd8:f82e])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F3BA648A41;
	Thu, 16 Jul 2026 14:54:13 +0000 (UTC)
Message-ID: <de0bfcdc-01d4-4683-97e1-16c0466023ef@birger-koblitz.de>
Date: Thu, 16 Jul 2026 16:54:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/12] ax88179_178a: Add HW support for
 AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
 <20260708-ax88179a-v2-2-0800fedb2e16@birger-koblitz.de>
 <1f858852-8e8e-4cff-bbdc-eb6751f44ca5@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <1f858852-8e8e-4cff-bbdc-eb6751f44ca5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/15/26 00:58, Andrew Lunn wrote:
>> +	/* Initialize MII structure */
>> +	dev->mii.dev = dev->net;
>> +	dev->mii.mdio_read = ax88179_mdio_read;
>> +	dev->mii.mdio_write = ax88179_mdio_write;
>> +	dev->mii.phy_id_mask = 0xff;
>> +	dev->mii.reg_num_mask = 0xff;
>> +	dev->mii.phy_id = 0x03;
>> +	if (!ax179_data->is_ax88772d)
>> +		dev->mii.supports_gmii = 1;
> 
> O.K, so you are keeping going.
> 
> I still think mii has to die, and you need to swap to phylink.
O.K. you have me convinced to try harder. Especially with the suggestion
to create own PHY-IDs for these embedded PHYs it looks doable and not
too ugly.

> 
> It is a bit ugly, but there is a way around the PHYs having a totally
> different API, despite the same ID register values.
> 
> Some generation of Marvel Ethernet switches set the OUI part of the
> PHY ID register, but left the product part as 0. They even documented
> this was intentional. We worked around it by trapping reads to
> registers 2 and 3, and filling in the missing information, using an ID
> from the marvel range which was not in use. We could then make the
> Marvell PHY driver do the right thing.
> 
> You can do the same here. Intercept the reads to registers 2 and 3,
> and return a different ID. You can then extend the PHY driver.
> 
Doing that and seems to work. I will be cluttering ASIX's own PHY-ID space
with vendor part 0x3b, see the ax88796b PHY driver which already provides support
for the 772A, 772B and 772C PHYs. So I will add there the 772D/E and 179A and 279.
This seems safe, since ASIX appears to have stopped selling (discrete) PHYs. At
least I am no longer able to find any references to PHYs built by them. It
also appears appropriate since with the firmware they are using the PHYs are more
ASIX PHYs than whatever other PHY IP-core they may have been.

It will take a bit of time to convert the code, though, and I will submit that
then as v3.

A comment on phylink and USB-Ethernet NICs, though. Grepping for phylink
in drivers/net/usb shows only 2 drivers that use phylink: asix_devices (the
antiquated one using the 772A-PHYs) and lan789xx, which is also rather old.
There are more than 30 drivers there, so that makes < 7% phylink usage vs 93% mii.

And at least for the 179A-based controllers it is clear that there is an
advantage not to use phylink: When the link changes, the controller sends out
an interrupt URB, that has everything in there to set up the link. No need to
do costly USB requests to query the PHY. In fact, the proprietary driver
works hard to not talk to the PHY at all. A good example is WoL, which is in
principle a PHY configuration issue. For setting that up, the driver actually
never talks to the PHY, everything necessary is done by the controller's
firmware. For USB Ethernet controllers it makes a lot of sense to abstract the
PHY away and rely only on controller commands that concurrently configure MAC and
PHY to reduce USB transfers.

On the bright side, it appears possible to convert also the r8152 driver to phylink:
The RTL8157-based USB controllers have:
[10848.976063] usb 2-1: New USB device found, idVendor=0bda, idProduct=8157, bcdDevice=30.00
[10848.976068] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=7
[10848.976071] usb 2-1: Product: USB 10/100/1G/2.5G/5G LAN
[10848.976074] usb 2-1: Manufacturer: Realtek
[10884.829998] r8152 2-1:1.0: PHY REG 2: 001c
[10884.830079] r8152 2-1:1.0: PHY REG 3: c862
rg finds:
#define RTL_8251B                           0x001cc862

RTL8159:
10970.521382] usb 2-1: New USB device found, idVendor=0bda, idProduct=815a, bcdDevice=30.00
[10970.521386] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=7
[10970.521389] usb 2-1: Product: USB 10/100/1G/2.5G/5G/10G LAN
[10970.521391] usb 2-1: Manufacturer: Realtek
[10970.797123] r8152 2-1:1.0: PHY REG 2: 001c
[10970.797207] r8152 2-1:1.0: PHY REG 3: c890
#define RTL_8261C                           0x001cc890

RTL8156:
[11299.622636] usb 2-4: New USB device found, idVendor=0bda, idProduct=8156, bcdDevice=31.04
[11299.622641] usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[11299.622644] usb 2-4: Product: USB 10/100/1G/2.5G LAN
[11299.622647] usb 2-4: Manufacturer: Realtek
[11299.882412] r8152 2-4:1.0: PHY REG 2: 001c
[11299.882467] r8152 2-4:1.0: PHY REG 3: c840
#define RTL_8221B                           0x001cc840

RTL8153b:
[11498.161341] usb 2-4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
[11498.161348] usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[11498.161350] usb 2-4: Product: USB 10/100/1000 LAN
[11498.161352] usb 2-4: Manufacturer: Realtek
[11810.891092] r8152 2-4:1.0: PHY REG 2: 001c
[11810.891138] r8152 2-4:1.0: PHY REG 3: c800
#define RTL_GENERIC_PHYID                   0x001cc800

Looking into the Realtek PHY driver code, what is done there appears to duplicate
the code in r8152.


Cheers,
   Birger

