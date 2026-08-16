Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6C18BC3B;
	Sun, 16 Aug 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786866201; cv=none; b=ZTaC5oJhCk88xopzfJljNv3Z6hNYwSuH9pGECF/So6ALnzia58YtnMCuW7cnlEgG1Kh+aleamhNhuef+bmjgDd4a+c80hFE0bh1fSz+pC6fCOtcw6ZPJ7+ETHCzpMGu6gAd30mWqQs3AflZQX7vywTsnAgy3b2uURC0D/BqtSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786866201; c=relaxed/simple;
	bh=ow5M5CMGrSzle/Ls92w/XdWKBzJp/uDMBCjmh+yeWtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0f7F7tBG3b5+YnlUJfpcRXd20G9BZYqQtbu09QA1SxyjfgQRg6BxVILxR/h289w6kkMv9g7tQkVKjZPzhcwaVBs9eqRJ5cMcEDiofV8XCsQHoIvJLPlylztTpQP1GvtM1EOIkgF7icHQ7Q1/8I7ibitJulWMMFwHKWEklP2AoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CQY8QSMA; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eE5nbP0T; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CQY8QSMA";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eE5nbP0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786866192;
	bh=ow5M5CMGrSzle/Ls92w/XdWKBzJp/uDMBCjmh+yeWtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQY8QSMAc5tuN+X15WdqfuQdjr7k3mkAFPWuNUJQzBVvE+YJSxkKj4tqh9mi/8Zm5
	 h2fZ5zrPYSGGQPkIffHI2QYgnuBVdBodITvIP19QHhOVx+GCmMi2ZtSeV46Oa49cc3
	 jIRQWT44ccPZqEQPYXH2HN3lr19eTTPxJ3569ZtTeuKRztlyszCCeqB+iWKqYCk5Yt
	 zrcfYDHtC1QvuE0EyQ9lsJNGJbhC0tCif1kBaod50sl5NJeY1q9siFnjvFqw5e6BYl
	 6ab1Od3uWmVRjWdDPe3gtHeUs5kcHOs4Hzao89j2X6L7v0jS2iTzrP2QrMSIihWRVh
	 zyOTLT1qzFHCQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9A0FC498BA; Sun, 16 Aug 2026 07:43:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786866191;
	bh=ow5M5CMGrSzle/Ls92w/XdWKBzJp/uDMBCjmh+yeWtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eE5nbP0THsUpGi6BNOosy07BjNOGzZVylX9sIkJu/oU0fuA5ddgBxrFjxcXZS/bA1
	 GDbPdbFWc8wnKKyHVLNRLZsFwIF9/dnxHSut/pKSCZnDyQMyK1hVwOevTxz7LnQPg/
	 fTgV8H3CTNx7TkyqvQpYIRN9Ld/zu4a+l2UZbmdJtzhdTBo3vjhjTWHpP8kfqlhL+E
	 aQUK/nrKPe1dIQAK0dTkYoti2e0Ad5Gm6pPPa97yFDGTqPrAxPd9NrvKGyHPy+uJAc
	 +mPyv45WUpEZXayKhdVACSh5w72z/81mCW3RX982ApOCxm7clTgvvNdu8dhT5mD/aL
	 qzTfZyD3NhAZg==
Received: from [IPV6:2003:c6:9f06:3400:2b2d:b04e:7c88:6713] (p200300c69f0634002b2db04e7c886713.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:2b2d:b04e:7c88:6713])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0D643498B0;
	Sun, 16 Aug 2026 07:43:11 +0000 (UTC)
Message-ID: <f2bc0486-e2cc-47a2-b64b-85d82c323017@birger-koblitz.de>
Date: Sun, 16 Aug 2026 09:43:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/14] ax88179_178a: Add support for AX88179A-based
 chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
 <20260816070954.3440027-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260816070954.3440027-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jianhui,

thanks again for the thorough testing!
On 8/16/26 09:09, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested v7 on the same ASIX AX88179B adapter. The 14 patches applied
> cleanly to net-next commit df13c1df8147675470213ffff29dd5762fa321f5 and
> built as 7.2.0-rc3-ax88179b-v7. Full and focused W=1 builds for phylink.o,
> ax88179.o, and ax88796b.o completed without warnings or errors.
> 
> The main functional tests passed: cold DHCP at 1000baseT/Full, the
> 1000/100/10/1000 Mbit/s matrix, EEE and pause disable/restore, EEPROM read,
> module reload, and QEMU USB detach/reattach. I also ran 30 additional
> 100baseT/Full -> 1000baseT/Full cycles; all points passed carrier,
> negotiated speed, bound traffic, and RX-growth checks. Including the normal
> matrix, all 31 tested 100baseT/Full points passed, so I did not reproduce
> the v6 intermittent 100-Mbit carrier-without-RX issue.
>
Perfect. So the race condition with the firmware looks solved.

> However, suspend/resume with magic-packet wake failed reproducibly.
> A deep-S3 cycle with `wol d` passed, but two independent fresh cycles with
> `wol g` both resumed with the AX88179B interface stuck NO-CARRIER. Bound
> traffic failed, neighbors remained unresolved, and RX did not increase
> during immediate, 10-second, or 20-second checks.
> 
> In both failures, dmesg showed the USB reset followed by `Link is Down` and
> `Link is Up - 1Gbps/Full` only about 11-13 ms apart, both before `PM:
> suspend exit`. No later link event arrived after resume. By comparison, all
> six retained v6 `wol g` trials passed, with Link Up occurring about 2.4-2.8
> seconds after `PM: suspend exit`, when the link was actually usable.
> 
> I then tested a small ordering change in ax88179a_resume():
> 
> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 6b57111a0..dc101902b 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -215,14 +215,14 @@ static int ax88179a_resume(struct usb_interface *intf)
>   	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, &reg8);
>   	msleep(250);
>   
> +	ax88179a_reset(dev);
> +
>   	if (netif_running(dev->net)) {
>   		rtnl_lock();
>   		phylink_resume(ax179_data->phylink);
>   		rtnl_unlock();
>   	}
>   
> -	ax88179a_reset(dev);
> -
>   	ax88179_set_pm_mode(dev, false);
>   
>   	return usbnet_resume(intf);
> 
> The modified v7 passed all the aforementioned tests, plus 13 additional
> `wol g` deep-S3 cycles. Every cycle resumed at 1000baseT/Full and passed
> immediate, 10-second, and 20-second traffic/RX checks. All 13 `wol g`
> traces contained a usable Link Up 2.017-4.020 seconds after `PM: suspend
> exit`.
> 
> I'm not an expert in the Linux networking subsystem, so I'd appreciate it
> if you could take another look at whether this ordering is appropriate.
It makes perfect sense to do it this way round. I will test the proposed fix.

Birger

