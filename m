Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF138837C;
	Sat, 25 Jul 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784951985; cv=none; b=qbtOEpkEcpt1Jwi6c/E96fFOSawb8jyhR/UfKKQ1a2Ts8VZaoQFfq2NTGwgw+4RIGazQbb1uFKESa5Xal+itipqcLPOWuf5QUQ7v4fRBn6b180qTPpVcSQLoPXVvF7EJ2UDw4CwXqyOQdhgtPYCZ34/BCvwiPdOVii31HTyryDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784951985; c=relaxed/simple;
	bh=r5yUEecAIGNB/clK5C/dBjMMYKGNpQky3hjKXZYb0kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0diY5bTik7BvKtCuma6rGy/7rhy563KEKj1dDCcE1+/gnBss9HYAT8pBSRnIVEFtsUrJq7OLSFRygbFiKtDIJ1YkaCQiKt9sE7obrbLnlIgBvPg8qdwlzvPpWVWFAssbEHTfza5o8MS/1jqD34Mun0gV0xBa6tSsNT553eYdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=d0n8J0S7; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=HXy3eu1U; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="d0n8J0S7";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="HXy3eu1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784951981;
	bh=r5yUEecAIGNB/clK5C/dBjMMYKGNpQky3hjKXZYb0kQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d0n8J0S7w6ll2zIGuTT5bg8w1MYophPuWLLOpn1a2nCoy/XYRc5LOi586rpSlF0Jv
	 igRQiaPFL9vpkZuaXn3AVTm23N5LHhyMarsY/SCRFNzYD1rymr5Ay5wth4uWUFcFnb
	 2AWYQQsyCsvuPJ7RzUaxtCuBB3QcgMvWlgtIhU/MMF2pcjkhxT6ZDGXsBUFuX6zdcw
	 IFBuyMcgKlkKLlqOqdxxNw00rlEeSs4mddh6a14ai1b2uv4a40M7ZhXXEXleois8ss
	 OR6b/E5lfS68gogrE+lHLo6p+2tLCcl4Qr6H1mvUBrbTbPk1ijKG8QAetjDu0CmAVN
	 IIhB8OGkzXzvA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 783FD49460; Sat, 25 Jul 2026 03:59:41 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1784951978;
	bh=r5yUEecAIGNB/clK5C/dBjMMYKGNpQky3hjKXZYb0kQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HXy3eu1U6FDZs8opp5Kj+iM6Wj4UntBCD26ohDiSXmHi28sxV7ddHE9VNtZn0oOpi
	 nbiiBfpaJvlvN6QdqzoMIWBNNrsiTM4lSbNjNBo5eJCntLNkYy5emeaZX6MSGLaTrw
	 yBW3KIHsZKyRpwjzW7sNLsTS5cVhTTWrlc5vvz4Dgtb3H0zbP2wV9yb9raUSoroRK5
	 abU8X2wi7y77L7LFAx+MvPdQkwopfBGTSwfb5rCggjf+kSbaRmaZmsfz8ERVJqC2i0
	 W98LUCWFswp86NrpX/e9oi736SE95je1uOQdlrT3Wyt+y8AvFwnhEU6ZKAaHIMKbzg
	 MN/1VEfv4QzBg==
Received: from [IPV6:2a11:fb80:300:900::c08] (unknown [IPv6:2a11:fb80:300:900::c08])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7A29948EAF;
	Sat, 25 Jul 2026 03:59:38 +0000 (UTC)
Message-ID: <170c593b-6da1-47ae-9b49-c195a7a7b558@birger-koblitz.de>
Date: Sat, 25 Jul 2026 05:59:34 +0200
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
 <6a1935b9-dd81-447d-8a38-74d9c19be653@birger-koblitz.de>
 <958d44c6-0902-44b6-b861-ec501ed3ae7a@lunn.ch>
 <c59f2a8e-4bd6-46c0-bb61-bd2fbddf189c@birger-koblitz.de>
 <8284703c-7900-452f-9890-bb6b5e2cf4cc@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <8284703c-7900-452f-9890-bb6b5e2cf4cc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/07/2026 20:22, Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 07:02:48PM +0200, Birger Koblitz wrote:
>>
>> On 7/24/26 18:25, Andrew Lunn wrote:
>>>> Well, only the new devices use phylink, so it is not converting the existing
>>>> chips.
>>>
>>> O.K. I suggested you split the existing driver into two, a library of
>>> code moving frames around, and then the glue to probe and use mii. You
>>> can then add a new glue driver using phylink for the new devices.
>> I replied to that earlier on. My argument was that the frame moving bits are
>> rather different since the older devices use 32 bit header structures, while
>> the newer ones use 64 and the structures also are somewhat different. The
>> library would contain rather a lot of duplicate functions that are specific to
>> the AX179 and AX179A.
>>
>> Are you aware that the asix_devices.c and asix_common.c drivers do already
>> have this structure (including phylink), but target even older devices? And then,
>> there is a 3rd implementation of the ASIX frame moving, again a bit different,
>> in aqc111.c (no phylink). If one changes there aqc111_ to asix_ one gets basically
>> the same code as in asix_common at least for the USB stuff and similarities to the
>> code of ax88179_178a for the frame moving. I did not want to further contribute
>> to the mess, but it now looks like I do just that.
> 
> Yes ASIX is a mess. It is lacking a Maintainer to look after it as a
> whole, and say No to patches etc.
> 
>> To summarize, you suggest to split ax88179_178a plus the new HW code into 3 parts:
>> - ax179_lib (frame moving, USB read/write support)
>> - ax179_devices (HW support for AX179-based chips using mii)
>> - ax179a_devices (HW support for AX179A based chips using phylink)
> 
> This seems like the best way to not make ax179 a worse of a mess.
> 
> When you look at what is actually needed for ax179a_devices, starting
> from ax88179_178a.c and deleting stuff, there is not too much.
> 
> static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
> static int ax88179_in_pm(struct usbnet *dev)
> static int __ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> 			      u16 size, void *data)
> static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> 			       u16 size, const void *data)
> static void ax88179_write_cmd_async(struct usbnet *dev, u8 cmd, u16 value,
> 				    u16 index, u16 size, void *data)
> static int ax88179_read_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> 			    u16 size, void *data)
> static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> 			     u16 size, const void *data)
> 
> All goes into the library.
> 
> I don't think
> 
> static void ax88179_status(struct usbnet *dev, struct urb *urb)
> 
> does anything useful with phylink.
> 
> The _mdio_ and _mmd_ functions all need ax179a_devices specific
> versions.
> 
> phylink does WoL differently, so you need to look at
> static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
> 
> and maybe split it into two and have a ax179a_devices wrapper. Same
> for resume.
> 
> _set_wol and _get_wol just calls into phylink.
> 
> All the eeprom stuff goes into the library.
> 
> The ethtool ksetting and eee calls just become calls into phylink.
> 
> All the rest of the EEE code is ax179_devices specific.
> 
> You need a new ethtool_ops structure.
> 
> You have some changes to set_multicast. Maybe it can be shared, maybe
> a specific version?
> 
> set_features, change_mtu, set_mac_addr all looks like library code.
> 
> Probably a new net_device_ops. The usbnet_mii_ioctl call maybe does
> the wrong thing with phylink?
> 
> More eeprom code for the library.
> 
> efuses code for the library
> 
> I personally would make the LED code ax179_devices specific. That
> would allow you to do a clean implementation of /sys/class LEDs.
> 
> _get_mac_addr() in the library.
> 
> _bind() and _unbind() is clearly ax179a_devices specific
> 
> _rx_checksum(), _rx_fixup(), _tx_fixup looks to be library.
> 
> _link_reset() needs closely looking at, there seems to be some PHY
> bits in there.
> 
> _reset() needs splitting so there is a ax179a_devices specific part.
> _net_reset() as well.
That sounds like a plan. Thanks a lot for providing your insights!
I'll work on with that and send out a v4 when done.

Birger

