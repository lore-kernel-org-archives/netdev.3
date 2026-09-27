Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B93B774D;
	Sun, 27 Sep 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790501162; cv=none; b=kUJw7VNE3Xk6oArt6knByXkKnRKLVqZR6XlJngchyoaQOP/rCaywzq5T7fLtfFVCfQnJqvSml7xnrqVWAKQrR3m7qRJDt0SME6ckZsPqUMAzD7BWLfU9VDy88/Gu9199B5scIzvFm2xOknIsPO6E1mPbMpIX7qvDblIBvhLSuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790501162; c=relaxed/simple;
	bh=Kx0cPmdEpQwL8E+BtXJYrrzBqddWCvdrz/u3bHFg6Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5TdIUJmeQ9kv7qgcuHillpmhW8KDbWAHYPk64b/iRUFXxSJd74CPTwm30vDt5UMuPsjIUPg7GFl98+KyT3ffRUixKYC54iRmWD67Q3OM/nmSiTvGnZnW3hR8GWcHJf5xbDiBzxgzbOQwqCdlklSmCP7Z75SirrkzuR5W2Pwm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WqtWp7yo; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=LiJ3p6N+; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WqtWp7yo";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="LiJ3p6N+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501160;
	bh=Kx0cPmdEpQwL8E+BtXJYrrzBqddWCvdrz/u3bHFg6Vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WqtWp7yoXNwfVnvaElW3XMidZH35d39jdcSm4yfozq25htcmYGendhPBdrG0i3XQO
	 j9E17FkbdSscjUlLV150Obg9+Xxmcb1HDSxuf30+y/nQDDStevuBRsELvIXjcn+NpV
	 v9U2UaiN9WvHh0uxH5m/Fzy0i3vXaG7cXCYRwmFwOF88XhXRqzpROqh9qT+dKZYV3P
	 Zw/QRGLTnhLgiHnZ+jG1EmQRpNbLb+1XEN3krDhBGZrvkPldvd/HVaHmgAk6xRDVyN
	 e0P7aQeMHrCZGaaeW9f8DsOZptO1p9Ho9jf0USsn+80Jfl4LYbA8Gy6Z1IFXSPeDDm
	 4zeC4zo+zxylQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 01D8741307; Sun, 27 Sep 2026 09:26:00 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790501159;
	bh=Kx0cPmdEpQwL8E+BtXJYrrzBqddWCvdrz/u3bHFg6Vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LiJ3p6N+bfSWkMb3i8+dT93P5LUPcHpKJrAN11xdXZYyVJKrPFso3YZB+ZTw0NK0v
	 adjLo362jtjDyX8ptGZMqiUN5699PLCGcYh89RUC4dia+o5+Y8Z3TwCVX9EjWfJTiY
	 kea8WKUEdkgpTlNK9mxo0Vj57JqVNOhrmm++A2Pj+i6Egxd9mLEgPUgNGST3dBgM9d
	 3IRX3e+YcG32Wkoq6bH+CzXsCJHCTCYSkY0QKF6RPdBIH1WVzTpDt6LkGpijCFw1O5
	 hp68E6FZTV5/Quk2zG0FLE2ZgXzV00Z49sGezdHkEMb27R0DM7G+hALF2bQKtUofZl
	 JBDfgHyG/MkJw==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 306D1412E0;
	Sun, 27 Sep 2026 09:25:59 +0000 (UTC)
Message-ID: <4f7ae990-7413-4847-ba15-627f09383647@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:25:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 10/15] ax88179_178a: Add AX179A/AX279
 multicast configuration
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-10-60c04c9924a2@birger-koblitz.de>
 <178968030235.22033.16475533840382469089@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968030235.22033.16475533840382469089@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:25 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> - [High] ax88179_set_multicast() (drivers/net/usb/ax88179_lib.c:305) now
>    only sets AX_RX_CTL_IPE when data->ip_align is non-zero (line 314).
Fixed by moving setting ax179_data->ip_align = 1 in ax88179_bind() 
already in a previous patch where ip_align is first introduced.

> - [Medium] Registering ax88179_set_multicast() as .ndo_set_rx_mode for
>    the AX88179A family (drivers/net/usb/ax88179a_devices.c:618) creates a…

Will not fix. I extensively tested this and could not trigger the race.
Switching multicast/promiscous modes is a rare operation in reality,
so the likelyhood of hitting this is extremely small, and in any case this
will heal itself on link changes or if the user repeats the operation.
The existing driver had the same pattern for > 10 years without issues.


