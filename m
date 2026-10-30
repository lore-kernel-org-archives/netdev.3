Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374976;
	b=SoGgTc5LedKHWy91yelKq+yuPlTbjNml4CuMU5/UJDKAherI6eDS5D5rxFDBiX3ubHwV
	 g+V0vvrj145oFONm8y1oSxI2WOZvluet3pXts3+V+tF2B2HRSAbHyX2wdEYuU+YoOyEmw
	 RPa3rhqi9BkttW2NmoMr3dxZUNkBWrvSomou8YkjfdyKhsk69kZzY6xEtRcDUMBpnQy5j
	 fhK/RrQv4YMZ/9vqFuQB3+RsRMmjk3w2UfCNDxwLlx6OhaNnGoB5Z6Ide3Wwk3G48nPgS
	 XzIRMNFowzRInDlY8gnqEfCAZyKAW39+ndZDTQNn8FGSj5zUTXVayrlHiPKPQGunsHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374976;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pwWMYu7cN31DeEVkMWq5JMB825n/IrZotIJKrcqkFoE=;
	b=Qt3afQyZu80wC0nngvqniElhhKn+eJ0DafgYTgocYYQe9Vj2W9vXWur0+3zlV7VDDzb6
	 mqyBzdMo5CzDmEXU0+LyfBWJI0mShUOzRx9In9i6jWyzTUauZRe1aRz8aZFwmrS2iRzph
	 d9axRjB3evLGTGPNKu2nBF3qrdHQCr80D6aekM7Z5i1AUQkw2iufdiYAlBhhTa6qVUAh5
	 K/S+4zYRMzoArPEwmZIxQoS1aTeJ/xQhFpT6L/UTNePK4DSf5uH75hjkphWibMDCIfdxc
	 FJeZJyXOMbavNVJAJTYujgxhYFwYU5L09GW2jLcHZJFAjRitsqqCnrE3Z3e0C3pr4Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=aG7je0jC;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=cAohtmzh;
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF4606A31C;
	Fri, 30 Oct 2026 15:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=aG7je0jC;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=cAohtmzh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793374968;
	bh=vHq78/KCfEVqvcT6Nlgv9+8UL3cGgaMMpXKNxQmnb8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aG7je0jCoIoE9yoazs0wMFily8LEr0e5k/Kb4U8dLcfZ+H2g/5liM1Zcsq6M42BIk
	 zJfNRddfaOyAUg0AApOTohKq9yY3mdxIZoxyFbetKkC3aLUvUAjrbaf7dqasPW9i5X
	 xZk+qkZVmyFMLiSZYmQc31Sbk3KchhkPDLKtjn9Kdtee//KIoUYs59EigOSPYfE6i2
	 oSmb0E3Cs+m9+aywkz1dtjuddsL493CrDEKsOvz/5o7m9974WRoIU7mE4i8giLp52C
	 otpMTFR645+XEG3EzZzpRL4ZJ/eCGJgyj3rAB0lq4hjNhm6T6945Z8pdclMMAGuMxl
	 hRXJf8oO6/omg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 469FB49F41; Fri, 30 Oct 2026 15:42:48 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793374967;
	bh=vHq78/KCfEVqvcT6Nlgv9+8UL3cGgaMMpXKNxQmnb8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cAohtmzhsDIsOm2y41ZIUM7tt41zPVr/LoR+MZUgkAFN278tMvliSucJaKrXKW0Sh
	 yAJk5gzsiRzAROlNs0cSlNWCOLnVYwQ1qtE7aQt2urQQoQ+P2S99tvbSEpeiYND5Td
	 vW/tJduTRveIgsqvOolfjyQEBYJ1PmIMQ/morAdYq6LiLGBxia7ttjGyrUEiOKUWPD
	 M/aho1LpNAnoALSGcHqU2lfglboGrKirl4uBLRXZU9sAUdIsJ+HHy4LrvFpuQhrpxM
	 QBV64gjowokmDRNk6N16pbXoCSmbHbMx3mFWdeyaE7aM9JDmKikBAEFQtnF8sB320C
	 Zxt3p56kSH70g==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B75DE49F41;
	Fri, 30 Oct 2026 15:42:46 +0000 (UTC)
Message-ID: <2a66e94c-0fd0-4c90-bc1c-9e5699f80737@birger-koblitz.de>
Date: Fri, 30 Oct 2026 16:42:44 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Emir Beganovic <beganovic.emir@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Eric Dumazet <edumazet@kernel.org>, Jianhui Xu <neuromoments@gmail.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
 <20261029005809.19405-1-beganovic.emir@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261029005809.19405-1-beganovic.emir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks so much Emir for testing!

On 29/10/2026 1:58 am, Emir Beganovic wrote:
> Hi Birger,
> 
> I tested v19 on a Dell DA305 USB-C adapter. It has an AX88179A
> (0b95:1790, bcdDevice 0x0200, FW 1.0.7.131) behind a VIA VL822 hub,
> plugged into a Dell XPS 16 (Panther Lake). The peer is an Intel I225-V
> behind a switch.
> 
> I built ax88179, libphy, phylink and ax88796b as modules for a 7.2.8
> kernel. v19 needed two things on that base: a4e22e9253e7 and a backport
> of genphy_{read,write}_mmd_c45() from the adin1140 series.
> 
> With the current driver in configuration 1 this adapter never gets a
> link ("Failed to read reg index 0x0040: -32"). With v19:
> 
> - 1000/full link with flow control
> - download 940-941 Mbit/s in nine runs. Upload was 937-941 in five of
>    nine and lower in the other four, and I couldn't find why. Eight
>    later runs with tracing on all averaged about 932.
I have seen similar behaviour with iperf3 for an AX88279 and a 2.5GBit 
link: in the first round, some 4-10 packets get dropped by the 
RTL8372-switch as a link partner and then no further frame drops happen. 
Looking into the switch's error counts, the drops are due to Flow 
Control. I was not able to investigate further, but I have seen the same 
behaviour with RTL8156/7/9-adapters using the r8152 driver and that 
switch. So that seems to be "normal" and the speed of the adapter in 
iperf3 is very close (about 2.35Mbit/s) to the theoretical limit.

> - 1-byte TCP request/response around 190-200 us, against about 1.46 ms
>    with cdc_ncm on the same port (its default 400 us TX timer)
> - switching itself to configuration 1 when the device comes up in the
>    CDC configuration
> - 100M and 10M links
> - VLAN with rx-vlan-offload on and off, and rx-vlan-filter dropping a
>    VID that isn't configured
> - multicast filtering and allmulti
> - suspend/resume (s2idle) and wake-on-LAN with a magic packet
> 
> Two small things I noticed:
> 
> - "Switching to vendor mode" is printed twice, once per CDC interface,
>    and before the netdev is registered, so it shows up as
>    "(unnamed net_device) (uninitialized)".
The device can be registered only once it has been switched from CDC to 
the vendor mode, that is why you see the message for the unregistered 
device. That you see it twice can be due to the fact that it has 2 
active interfaces, see the explanation given in commit c67cc43 for Anker 
adapters.
The devices I have print it only once and that also disappears once the 
device has been switched and stays plugged even if the module is 
loaded/unloaded.

> - After a WoL wake the link goes down and up twice within about 2.5 s,
>    where a normal resume shows a single link up. It comes back fine
>    either way.
I see this, too. It is not triggered in any way by the host or the link 
partner, I checked. It appears that this is due to the firmware on the 
device trying to optimize the link settings further, the out-of tree 
ASIX driver displays the same behaviour, although it works very differently.

> 
> I only have this one adapter, so nothing on the other chips.
> 
> Tested-by: Emir Beganovic <beganovic.emir@gmail.com>
Will add in upcoming v20.

Birger
