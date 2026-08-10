Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B136F900;
	Mon, 10 Aug 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358618; cv=none; b=Ps7dpe+ppBM9nYezcA8AgucVEGl9vGEbkUPdDQQFcqfVR4Z0erVXmCorjXp8J3h9Jnfciz8N1V0Rh0LSgVF+gnC4Dy4BVSzaWe9mmJ7RNP9pGHBTTGYXs/i+/mdE25Uoe0kM/AaHEqriZjdXWFy8CkeviJHG7855157mkdnXDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358618; c=relaxed/simple;
	bh=H3hnNB4UNyV1sp06CjJaNULoM7znOZ64zfIEHTRpD5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2uXy88YPDg2cKTstTLj0HK7sxc0kdQvdbEqlRhjXAtO7gelpyjzg3n30fi/8eCtDLck2jcT4fqjYdVGucQOnaOtZFyeaF4kEoZMx0QtVRodNjORp80XhN/wP0R2PuJyixZ5y2hWHKlLwQfjFfrnLbsvTM51GJeBCxbgLGg3qJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CzFXARr7; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YbQOhqFs; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CzFXARr7";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YbQOhqFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786358608;
	bh=H3hnNB4UNyV1sp06CjJaNULoM7znOZ64zfIEHTRpD5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CzFXARr7z99wvutR06vxKc9at+85MPTZwAxfoe9B8VJteOZPFh2mOR5wj/nc6s6ZB
	 cIK3cO0H2eJruLByfS9yfn6P3BGmqLxOL6m8mVUWkHR0Mf9LVaawsrISoDvpWILZVO
	 srX26cNiT/tb7Q63sHUUtt7dv7P4t5x19ihLE1eLezOu76Slf5PgF2hAcCpqQRdLue
	 mNJL7/XmxrzJaxbY70v7Kmat/sEftGm2N2244M6W/1vihRoEL5VPeA458p+KCW8T2Y
	 KklZWCpa3O5MdtRnE99eqnQkLRy3I6cYEpyiP6SArfNgKnAI7Ks43y2BWPGu2zeA+M
	 kzjBwhdF+Mzow==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3E6064976E; Mon, 10 Aug 2026 10:43:28 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786358598;
	bh=H3hnNB4UNyV1sp06CjJaNULoM7znOZ64zfIEHTRpD5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YbQOhqFsNXaeobNBtVWmOCD/X+RkJr4s2dnUV2TsLXswRwTDTsbcN7/g+/MAbCOeB
	 LXSy+St+Mhbf3rjWGZ0iaA9FZlXdewfh5yUF3/5hrbL+CWzTcoMJSx/9D8z7n0vNIU
	 EGKEeEfgesP+yTqiooaWzQf+WCD2MO7rxN3ifL3rpXA1WITlZvDAY6ZUNFB4TKEAsa
	 D1i+L+JVbCDDUz1JID3UISomkZxqEtJ+yE2eU3mC+xnLQ9H5nJdcgSxIERLTicfGv0
	 cm1K/a1KHmMvDZDHdhPwegtU5uf6179uNyVx6TIhrhRQ9CmY/FGDW+nVhYzUhJZXM0
	 J87cZIw160I/A==
Received: from [IPV6:2003:c6:9f06:3400:aa83:94e1:f1fd:d452] (p200300c69f063400aa8394e1f1fdd452.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:aa83:94e1:f1fd:d452])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5E7C94975F;
	Mon, 10 Aug 2026 10:43:18 +0000 (UTC)
Message-ID: <5b2c4498-2e3c-4ae6-b078-deeccf8b7a5c@birger-koblitz.de>
Date: Mon, 10 Aug 2026 12:43:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
 <20260810013549.2510969-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260810013549.2510969-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 03:35, Jianhui Xu wrote:
>> The only way this could be coming from the driver that I see is via a call
>> to ax88179a_stop(), which would clear exactly that bit.
>> Have you traced this and can exclude that this function is called somehow?
> 
> Yes. I added a dynamic kprobe on ax88179_write_cmd(), filtered to
> AX_MEDIUM_STATUS_MODE writes, and recorded the value and caller stack.
> 
> During 30 100baseT/Full-to-1000baseT/Full cycles, four transitions to
> 100baseT/Full lost RX. In all four cases:
> 
> - ax88179a_mac_link_up() first wrote 0x0102;
> - there was no intervening Linux write to AX_MEDIUM_STATUS_MODE;
> - about one second later the delayed worker read the register with
>    AX_MEDIUM_RECEIVE_EN clear and restored 0x0102.
> 
> All 71 traced writes to AX_MEDIUM_STATUS_MODE had
> AX_MEDIUM_RECEIVE_EN set. The complete 1,209-entry trace contained no
> ax88179a_stop() or ax88179_change_mtu() caller.
> 
[...]
> I do not think this proves an unconditional device-side bug, though. The v6
> driver failed four times in 30 cycles after writing 0x0102, while the vendor
> driver had no failures after writing 0x0132.
I have finally understood what is happening: There is a race condition between
the controller of the AX88179A trying to set up and optimize the link and
phylink trying to configure the link on the mac-side. When a link change
is requested by phylink triggering re-configuring the PHY, the PHY is continued
to be polled by phylink. At this point, the PHY may report that the link is up
before the controller is actually finished configuring it. mac_link_up() is called
by phylink, but the controller overwrites the AX_MEDIUM_RECEIVE_EN
bit that is set by mac_link_up() when it continues with its configuration.

The solution is simple: do not poll the PHY with phylink, but wait until the
controller decides the link is completely configured, at which point an interrupt
USB-URB is sent. Then handle this interrupt in phylink in order to read the final PHY
configuration and only then call mac_link_up().

I will provide a v7 with an additional phylink function phylink_mac_interrupt()
being introduced as suggested by Andrew, which is called by ax88179a_status()
in response to usbnet receiving the link change interrupt. I tested changing
the link a couple of dozen times and it always worked, now.

Birger

