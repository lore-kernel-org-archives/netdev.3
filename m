Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66A4E2343;
	Thu,  3 Sep 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450440; cv=none; b=ZTz/1afxsqx0rAq07r0xTnanlti4cR4CP/AJCxZnEtlvuuoRZnYAuTuBSKBIpQqPZKNwnUlZjh/qPFJqY7AC28/fFFc2GnHSi19ju14l5aq28F8jaN+ujh/LCXDTeXxmptPu0Vkbvba6DioPmpQ8dmmhrz5csP8XIcdma5vjxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450440; c=relaxed/simple;
	bh=XM1j/aLph87KjehGhzloy5KQFE5iSI5nWnm3VvgFBCE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTwqVMsYSgQnxuRmtnIipYqE+8nPEg+bS1QL0axO14c5LELIxbSL++a9w9j48M935nD7XZz8+o6Gp0ILyfuz4zHlL9AkGNYolX7Y6ZWEXf6t+u52Urm82VR1otTMFXyXD/2cjGJ44SGskoyZ+P5Bm2tqx9cjyLE1fFHpisozYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=NGyegiiF; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="NGyegiiF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 1AFC4583856;
	Thu,  3 Sep 2026 15:10:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D1133EF90;
	Thu,  3 Sep 2026 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788448254; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=uYXVTMatMDH0138orMZx6ToE2yw83S5uLOlwjJpjVh4=;
	b=NGyegiiFn+j6/YRzTlbdj0VS4x/hJZZriNEvhhpWyEVsdgPxTMNFT/BNYuYZIqqFlpE2Zq
	vy7IZ+5aRshKRX5KbUsb7+hjxXMrsy198rjXpVaBgBFUg1kedPRAENPul43JGP6YJhJVHn
	qbpdBzX85Nb0jHB7PBb/JTFF+V91T5LQc1l7+AZGfnuhUN0ZTRkc1ov+Ih3wIHbxrMtXkY
	m8VkQLwviddnw/a0lnnuevwaZoXdF9atIzHekZ26M+iIIlBpPyPSVBwXAKE5TrrHpvOnmu
	42YTiwlExKT0IMDbZgdXNYfNeQCs/xRpW5LEimiGCh+a70GFpkPhFM/9pF97nA==
Date: Thu, 3 Sep 2026 17:10:50 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v6,3/3] w5100: detect carrier state using link status
 bit and optional interrupt
Message-ID: <20260903151050.GA185059@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260831-wiznet-link-gpio-v6-3-abee6c5c966e@marmottus.net>
 <178839696443.3394541.11998106403165239318@kernel.org>
 <20260903130820.GA21664@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260903130820.GA21664@marmottus.net>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFt7+Z64xoReW3on4YvpCbHIFE2WLFu56/NKaAgQeY5o5E/KZpcFfC28pZ2KfkCzOzhSxD3W01evXb0glBKmdMRdNyzgL9MvGQE/0gXySyrtuCXNf5hZOLxbT6nBe6gBoCtLVTyQL8n0CbF/jtzjtjT+SDrYGppumnq+Jo6x/lsx4+jSBbNsCEAO0skQSJGIQ1nzFftU6KzSkBp/WYiGpBGzgaxTE1Gy5QG7dr7s2nq+4w96Xe11e4lNDCBghVrUtVHkCsimKfUkr40/r0xDdxnBLgw5jMKNgomcxKC0BAGSaS1VXCtfpzawqwkFHhF7lJYfDuOOwDIP7Atj5wv20P5ft5k4uW/EIY83WAMCnHfATfu5TPqdzGGJ2sAX71EvKmXOyWrQ9LcJNkhdDx7wZHpra6KwcwVWvkI6JfHVXF+DlcelYnmOPJ7Nh7cw3xFQmifB6jQ5kR5+XgiH5XcXHme/rEh9R+4FWNxIU5lVeG1T0tTcxuLmDOsL8bunGr48SUxHpqjuXHygse+ckExl3ahhnD/hmBb7VIJSLWDI6lNFLHmTKHrOsAD53nNmXmHYeWkporxMDJeDC1w9QDIBtunlhd+9ht5EHVLNUtXLmB86+jzzRHIIHQZFhZ6zDW1E6fbZzprKB9JAoLGwy+BpEFZPpLSBpy1MGy4E4EHttSBZw

On Thu, Sep 03, 2026 at 03:08:24PM +0200, Arthur Crepin Leblond wrote:
>On Thu, Sep 03, 2026 at 12:56:04AM +0000, netdev-bot+sashiko@kernel.org wrote:
>>Since || short-circuits, w5100_get_link() is not called at all when link_irq
>>is negative and the carrier is unconditionally turned on.  The ethtool
>>callback added just above, however, keys on the chip id rather than on
>>link_irq:
>>
>>	if (priv->ops->chip_id == W5500)
>>		return w5500_get_phycfgr_lnk(ndev);
>>
>
>Again, good catch! One could setup the w5500 without the link IRQ but
>still use the PHCFGR register for the carrier state.

One more time about this one, if we use w5500 without an interrupt the
carrier state will be the one read from PHYCFGR bit and will never
change.

w5100_open:
	w5100_get_link -> 0
		netif_carrier_off      // stays off forever?

There is probably no good solution, the user can only get the real
state with .get_link.

I think netif_carrier_on should initially be called if there
is no interrupt configured, that way the state stays on like on
w5100/w5200.

Arthur
