Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A13C943B;
	Sun, 27 Sep 2026 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790500874; cv=none; b=uTaY7B3xBvoZhmLDMIrtxCgyNVuNoC272SUD14qDutGox+qTs9QlSAuUWySLJufG84F8gEjpfDo9G9n1QnZ7otX3eJGDWapvPmFrSq122jUw86/j+wlOVfs56aXKr4LXzCIcoCgt0k/yYjWZkD0Oof5uZcaqpD66FFHqbHkEh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790500874; c=relaxed/simple;
	bh=JGLUvXuCQ5gw5sw4HIV/joRWy00QfINJUCs7V+84X04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P885YLQ4Z5F3rrfoI9g+cXgBGjUwsbcECvOE1AfbdI7OG/LcZgR1h5fPOha8CZbY6+SpXHSAQ3La0p+ym9AlbafsUNh1CKVUBDdJz1EL/Szph920d574ZNL+6Ctw5SyoIF9MJE9KOmR0t+6bCzvFGxaEfrQRnuXChL0UV2YOXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eluOcJ96; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eluOcJ96; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eluOcJ96";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eluOcJ96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500870;
	bh=JGLUvXuCQ5gw5sw4HIV/joRWy00QfINJUCs7V+84X04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eluOcJ96TvZKH//6jAHvj/kk6FBtKwleSWvpIO9Nt2yAvSBFjk906e22UG48N+c2y
	 eLKVfoXvcCshtBR147s75bKo6nRx6yjPxXYa3f9fmudx5KxjCYLFnnMcrVvi7wP9yK
	 ViYc+gNuMMD8KcPOXpgTHPW2Uj+0BEMIac0JuWsXAYUOpXSCF4QgaOC/TzN5O2T60+
	 U2kTogKIca/njRc6vQvNAR1utB8dmT5SYRBsCx0XUZrazO55xfxp8IAInMQd5oobQT
	 SigLw7W40PWIo6DUFy4roIpXP8uhcM7BKupZq5Xvq4HU4n+koCGoSMulZKsK6T+XfC
	 qzCacsgWNmmHQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C0E1641309; Sun, 27 Sep 2026 09:21:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790500870;
	bh=JGLUvXuCQ5gw5sw4HIV/joRWy00QfINJUCs7V+84X04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eluOcJ96TvZKH//6jAHvj/kk6FBtKwleSWvpIO9Nt2yAvSBFjk906e22UG48N+c2y
	 eLKVfoXvcCshtBR147s75bKo6nRx6yjPxXYa3f9fmudx5KxjCYLFnnMcrVvi7wP9yK
	 ViYc+gNuMMD8KcPOXpgTHPW2Uj+0BEMIac0JuWsXAYUOpXSCF4QgaOC/TzN5O2T60+
	 U2kTogKIca/njRc6vQvNAR1utB8dmT5SYRBsCx0XUZrazO55xfxp8IAInMQd5oobQT
	 SigLw7W40PWIo6DUFy4roIpXP8uhcM7BKupZq5Xvq4HU4n+koCGoSMulZKsK6T+XfC
	 qzCacsgWNmmHQ==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id F3949412E0;
	Sun, 27 Sep 2026 09:21:09 +0000 (UTC)
Message-ID: <bc23c757-8f59-42fc-9770-0250807032c9@birger-koblitz.de>
Date: Sun, 27 Sep 2026 11:21:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
References: <20260916-ax88179a-v12-8-60c04c9924a2@birger-koblitz.de>
 <178968029951.22033.7295791968219633553@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <178968029951.22033.7295791968219633553@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
> 
> - [Low] The patch exposes .get_eee/.set_eee (ax88179a_devices.c:209-221,
>    table entries at :232-233) and activates the LPI path by populating…
This is due to a limitation of the hardware.

> - [Low] The commit message contains a non-existent part number:
>    "Configure phylink to work with the PHYs in the AX88197A controllers"…
> 
Typo fixed in commit message: AX88197A -> AX88179A
