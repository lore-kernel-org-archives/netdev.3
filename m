Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15D412BF7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563755; cv=none; b=a8hVKv/m9peptzw7mVA4KE1J6sBdoqBp0RJLvnM4ouqFSzjzLLhGVqQij5+t9KWmAEPE1shOUYdc0+qhKCrKYdBPDpLqCQIs+8kIRighl7hLWXwDgVJkDnqXynIwIAiEq6zFe1lgi6nE/L4KgJXkdi2eEXmmG3Zzij5yTx6oLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563755; c=relaxed/simple;
	bh=/iA1i+fEz1OGwBmOfoih5OvcxjKj5L5pH1QANttn9/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyUtfXx0mMPKi2YEh2kaASJr/vuDvX2btSvOI2UvyZC0UrZGX0x/pXFAhtuKE7gCZP0QXH9I/PJkLF6biG0BzJ0Aqc2D68PrPttNP8Gcu2Kq1G6y38LNOGmxUkgZx+7l8dKtkXCoatgJzY+LaAo7ldZ6zH1AshtYxzzBKC2+0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LbQIxnE5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LbQIxnE5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B57364E40712;
	Wed, 16 Sep 2026 13:02:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8268F60337;
	Wed, 16 Sep 2026 13:02:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C54811C7B01E;
	Wed, 16 Sep 2026 15:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789563746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ob+rWI8KnN+HI9KrEep3pQqea5Fog14Wdci4nh+7dCY=;
	b=LbQIxnE5GkwaTQBhNYc0u473Lluj0FyRcGGYeSdTAiGzC1Ostl3ejYmmyZo2TMjEJiWZM4
	Y9i00svqukaLhVdDZb77FcmuqJtyeJTdIQ5FLcvzMTTGMpR2izmF8hcr4ZvkJFAZzd1Qjf
	F0g0biJrSj5vvG2gQvuOEbB7QqIQdiNGjgvftWWU1Hy9rHWhRg8G1nB2wjyE8wOXkALpZf
	d2VkQM1uS2rvVwf4geHuIv5S/yw3OmlqL9OwncapVJAyWhKSifh4HZz2y9zbk9Rv2O3GyP
	WDFEUpcwVJmYX7Jo3BD6x9+/o3CTloAgpTiPx4RzsNZzOx/Uv5pu9/fmIItXDQ==
Message-ID: <2377467b-5379-4759-a6ce-1d129c2b41ff@bootlin.com>
Date: Wed, 16 Sep 2026 15:02:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: propagate platform mac_finish errors
To: Thomas Karpiniec <tom.karpiniec@outlook.com>, netdev@vger.kernel.org
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB8413069BD77B03793D1A9B42E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <CH3PR11MB8413069BD77B03793D1A9B42E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/16/26 12:39, Thomas Karpiniec wrote:
> From: Thomas Karpiniec <tom@wendy.sh>
> 
> stmmac_mac_finish() discards the platform callback's return value and
> always reports success to phylink. For example, the Qualcomm ETHQOS
> callback can return an error from phy_set_mode_ext() if SerDes
> configuration fails. Phylink then treats the interface as successfully
> configured and can report carrier even though the SerDes is not ready.
> 
> Return the platform callback's result so that phylink can report the
> failure and keep the link down until a subsequent configuration succeeds.
> Keep returning zero when no platform callback is installed.
> 
> Fixes: e654cfc718d4 ("net: stmmac: configure SerDes on mac_finish")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse
> Signed-off-by: Thomas Karpiniec <tom@wendy.sh>

Let's see if this uncovers other dirt under the stmmac phylink carpet :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

