Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3E347FCD;
	Sun, 27 Sep 2026 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499665; cv=none; b=dCYUNAt+B5AlRGv3xkzpisHC1Hj7hu80frWevzzp6UP+v2jLRGkZcl+dSkUCXc7R/kmpLK/QaL3dloZNVeVoy3reT+JmS+FjnGje9UQBEyyvRQVXrtbbK9fej3W0d7+TVwFteeJ29yosq5Q5nDJ+m3kg5CM7W68exrg/mnGHpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499665; c=relaxed/simple;
	bh=PJ+1KSBYgMXhXlmNpWeCO5p+gF3yyMIeFkHmHQqVcI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X765JrqK3EGxJLMOfeGtnjZhyryxCbj8kwtszF/LtVzxhm8LUj2ZQEqd5juDNCExojQvbCl1KC2+Rw3jJZeYEXuqqqCZwTXju1MxquSePp0pRC4TqV2A5+dcvcryWYCqBtzySAYEd3ykIYbCp1opSWmgg+QSdpx/8FkyRSia8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=n0PHAcnw; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=AX6c4buk; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="n0PHAcnw";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="AX6c4buk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499661;
	bh=PJ+1KSBYgMXhXlmNpWeCO5p+gF3yyMIeFkHmHQqVcI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n0PHAcnwUP+3Pib4aiWjLhATwi8C2gOSMZSP366/I2qgTTMUfx/duyLyr/sgfcELA
	 7XIHv0tJcM7dEIOQcHTwZajHszWq1JS7g/ry5zYoTplLC0dFNt4zY3hjQqbuaxR0e1
	 UZzqLDupQZ70CjiPN3Fr51MLpB4EbKgfgnEz9C+D8PmJTzzMX1YacBmSa0aOOhoMaK
	 MHJ3MBKHBkVJP09ZrwWdkyKP8MJQbZ+urA2E6s2Dc54RWoftjUUIRKPUQkGaCzd+gO
	 aFQxVDLhn0Kq/pREhq39WE847PEPGCCEBgdJ5DeAOMBH6izh5Q9hRcdGj+OvSUL+gz
	 CCL7Z8GROTq/w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8EFC141309; Sun, 27 Sep 2026 09:01:01 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499660;
	bh=PJ+1KSBYgMXhXlmNpWeCO5p+gF3yyMIeFkHmHQqVcI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AX6c4bukMZ8dBw1PB/Jh9TFdXrc3nccJhjwMUtJv0HTcIynz1Ix+sdY0vYJJngrZ8
	 mkNfcR837s24VPOzGIjtwNk1CL9mPtOFpeKhZwLuqMOfLnlyKYJMAFQxURckDXmfx5
	 Rk+ySkLYG3esOscXsP5kz5ZPxr36q4D9qg4n06NQ7HARxTp5uZd0bVDuC5RmvJoUCM
	 s83yR/GA0CaDnL3wrpIlk7dlk5ug/0MZlUDkQPKode4YmqJ51pX5nW3VvwTOTkO0gQ
	 p1NkVVhy4vV8vIwDeqRkPE3Q0A1sMH2Oj/Xmn67tth7W23gSzR/QmvO8WvfjyI3rjV
	 CD5WmLizpvQuQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6D9B7412E0;
	Sun, 27 Sep 2026 09:01:00 +0000 (UTC)
Message-ID: <b5480239-344a-49a2-a271-71827c578cfc@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:01:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/15] ax88179_178a: Split driver into
 library and device specific code
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-4-60c04c9924a2@birger-koblitz.de>
 <178968029415.22033.4203681974249867316@kernel.org>
 <20260919150450.3d0ec698@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260919150450.3d0ec698@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/09/2026 12:04 am, Jakub Kicinski wrote:
> On Thu, 17 Sep 2026 21:24:54 +0000 netdev-bot+sashiko@kernel.org wrote:
>> - [Medium] The module is renamed from ax88179_178a.ko to ax88179.ko
>>    (drivers/net/usb/Makefile: `obj-$(CONFIG_USB_NET_AX88179_178A) +=…
> 
> Why not fix this? it's been reported before and looks both legit and
> trivial to address.
Will add module alias in v13.

> 
> When you repost please post the driver split first, separately.
> We can get it merged more quickly since its trivial.
I would prefer if it stays together for now, as the split anyway only 
makes sense if the new driver code also is merged, and that way the 
history of the series is preserved as well.

Birger


