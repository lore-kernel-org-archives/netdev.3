Received: from herbert.ortolo.eu (herbert.ortolo.eu [80.67.179.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF239B49C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.179.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112880; cv=none; b=c0mXObRVtnn1iIHNfDCd+IA7SuQcEeQhamjj0K7IkPwrOWcDR+U2ZYeL1O17QpqvO4HXhq7HWoU5V2HBnZRK+AByuLCgOPIaYifvNgRrle8ECup0h/oA1IY3zXsebJ9JAbMjTkAAMf+JelF+uz+vyxTNN3s56EQgC6Wek2kUCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112880; c=relaxed/simple;
	bh=xhFAhxwyY0LRcdl6l1GpPF1fLkdrhXY/7otOcSNZRqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuAz2WGJ03bzpNsa/JNU5rlL0Vy26nL6oldol8jj3VddFJewpwpe8mQ+TT5DrhkoTKSDOOrM7HovAQsEWLBQKWyywFlqi7FKjC0dYISW8o5tPmo2XRX67DEZ8NYoLWCSv0lYICHe55zglBwDzz+eWZd50tikqcJh2fAO9ogBVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ortolo.eu; spf=pass smtp.mailfrom=ortolo.eu; dkim=pass (1024-bit key) header.d=ortolo.eu header.i=@ortolo.eu header.b=j/pmQSTx; arc=none smtp.client-ip=80.67.179.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ortolo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ortolo.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ortolo.eu header.i=@ortolo.eu header.b="j/pmQSTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ortolo.eu; s=herbert;
	t=1770112874; bh=xhFAhxwyY0LRcdl6l1GpPF1fLkdrhXY/7otOcSNZRqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/pmQSTxpfdRP1PaJu+DtXQ3QZz202qaOeEKZYXn2hIOXjlRC3P4P0zWkgCwSJZgS
	 GR37h8QxAwwGGjhsIw66Wag1ASIZywWmXrh6EXzSm7YYDAv8h4187xYxgLC4m2VDBJ
	 rxIDhtVj5NI8Bf0stF/eFXvwKtOcLxtV0oUyHkSI=
Received: by herbert.ortolo.eu (Postfix, from userid 1000)
	id 645477377A; Tue, 03 Feb 2026 11:01:14 +0100 (CET)
Date: Tue, 3 Feb 2026 11:01:14 +0100
From: Tanguy Ortolo <tanguy@ortolo.eu>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Francois Romieu <romieu@fr.zoreil.com>, netdev@vger.kernel.org
Subject: Re: Weird issue with r8169: shutdown on carrier comeback
Message-ID: <aYHHanMLATZ5kE50@ortolo.eu>
References: <aYDYSHhaF1vQSxdW@ortolo.eu>
 <602a08b9-134f-421e-bc2a-b89b0867b2e3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <602a08b9-134f-421e-bc2a-b89b0867b2e3@gmail.com>

Hello,

Thank you for the quick reply.

Heiner Kallweit, 2026-02-02 18:25+0100:
>Thanks for the report. Interesting issue .. The network driver (r8169) has no link to the input system.
>Therefore it's likely your network manager which is causing this behavior.

I doubt it, the network is simply managed by Debian's ifupdown. Nothing 
fancy like NetworkManager for instance. By the way, I tried after 
switching to systemd-networkd, and the issue remains.

(I also tried after enabling ifplugd, which deconfigures the interface 
when a carrier loss is detected, and that does avoid the problem, just 
like when I do the same manually: shutdown only happens when I re-plug 
the cable into an interface that is still configured.)

I would more likely suspect something weird in the motherboard itself. 
But this is indeed very hard to tell. I reported the issue to the 
manufacturer as well (Trigkey), but I am not sure they will reply. I do 
not see how the r8169 driver could be responsible for that issue, I 
think it merely creates conditions in which some hardware bug appears.

But since r8168 does not trigger that issue, I felt I should report it 
just in case it could be useful. Do not waste too much time on this. :-)

Regards,

-- 
Tanguy Ortolo
