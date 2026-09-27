Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4D3C1F4B;
	Sun, 27 Sep 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790499877; cv=none; b=guH1cBGxnV99B2zag6SV1X2QkwxF5+umcOsV4m2an5YDi8LOVcj3BK7cjj+puODNtqQBFXDcrAeDHRF/457Ii0PpckQ0sfdlAKHWyVjqe29jKMfIsBfreL8IZ4uvL2Cw9vgYeimA/M87oUngiRaerqvTZMftiEVajfg7pnC0tpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790499877; c=relaxed/simple;
	bh=33dvaicbArbIhRjTZRMuh17NgjpbWZ0sCpmljPyr0eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4PBBomIaOf9nOiC/fxCOcM2lZ3XTHtMh2e5bARkux8sQjUwGCMjLxXkvQ2dPgcQKhc2qTc3sFur708EDaJ4/lYs5YYcU0QtAidjIp+Y/by1do9YmzaSJ6pTIPbtEHWkaIB1SHjKlQqEVgd5jYK9+0Zc1nbNrsG35aLPZa861FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qhdLILOx; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qhdLILOx; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qhdLILOx";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qhdLILOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499873;
	bh=33dvaicbArbIhRjTZRMuh17NgjpbWZ0sCpmljPyr0eU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qhdLILOx2onHtnciGvpXDuyC9UWSQ2F73+xMxicWLSVwSRZuNLKZ2wUAK0FW3yR8x
	 TQQjU8R7CcmSNmmpyNoNC133eBJJ7CyBZMmqo3jweeatoHNGF+GWiM1NFjHf6a/wQB
	 oAHHxnv2xgkXbILdHV/v7BNs8B7/gesRyDI/YuFvxba71kJKeeCjQWQzadHlLmh8Jc
	 Kn1TxDC7vb9oYmeDS8Nix7xaPlWQJcJnYYsvQq+n7CbrsWylXijDwVIlCFyhjJoPSH
	 //tBk8BJfdMqj/3yYmK5PtgbJlWFnfVvuv8RRYCtOxch4OcsdVsmOCrJhU/0SwURkP
	 8Fc6z05wrHyqg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id DA134412E0; Sun, 27 Sep 2026 09:04:33 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790499873;
	bh=33dvaicbArbIhRjTZRMuh17NgjpbWZ0sCpmljPyr0eU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qhdLILOx2onHtnciGvpXDuyC9UWSQ2F73+xMxicWLSVwSRZuNLKZ2wUAK0FW3yR8x
	 TQQjU8R7CcmSNmmpyNoNC133eBJJ7CyBZMmqo3jweeatoHNGF+GWiM1NFjHf6a/wQB
	 oAHHxnv2xgkXbILdHV/v7BNs8B7/gesRyDI/YuFvxba71kJKeeCjQWQzadHlLmh8Jc
	 Kn1TxDC7vb9oYmeDS8Nix7xaPlWQJcJnYYsvQq+n7CbrsWylXijDwVIlCFyhjJoPSH
	 //tBk8BJfdMqj/3yYmK5PtgbJlWFnfVvuv8RRYCtOxch4OcsdVsmOCrJhU/0SwURkP
	 8Fc6z05wrHyqg==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0BDA5412E0;
	Sun, 27 Sep 2026 09:04:33 +0000 (UTC)
Message-ID: <bfffca88-6603-4459-af82-9e406bc5e4c1@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:04:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 02/15] phylib: Add support for PHYs with
 broken forced mode
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-2-60c04c9924a2@birger-koblitz.de>
 <178968029151.22033.7401061944066839860@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029151.22033.7401061944066839860@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0 (1)
> 
> - [High] NULL pointer dereference of `phydev->drv` in
>    phy_ethtool_ksettings_set() (drivers/net/phy/phy.c:1193-1195).
Not sure this is an actuall problem, but will add check on phydev->drv 
as a guard.


> - [Medium] Incomplete gating of PHY_BROKEN_FORCED: the new flag is
>    consulted only in phy_ethtool_ksettings_set()…
I don't think this is an issue as these are direct MII register writes,
the device will just not do what is requested, the PHY_BROKEN_FORCED was
introduced to prevent a stacktrace in phylink.

> 
> Pre-existing issues:
> - [Low] Concern that PHY_BROKEN_FORCED has no in-tree user, making the
>    patch behaviorally inert (dead branch in phy_ethtool_ksettings_set())…
This comes for the relevant PHYs in a later patch of the series.


