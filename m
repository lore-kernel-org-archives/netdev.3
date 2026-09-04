Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFB358378
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507429; cv=none; b=tUz9+g2C8KIP5d3nQI5fPOdOHp7zdrjbJHhzonXcqK7N9dIyMsof1q0hGgoQiAbMvVkUbUZYUPw+swA1hnkwLqvssJ22SYfU3qmsM6KYB4FjP7bqqPsqMpB6hd8b16Y9U0w9Cu/Z54yftwEnDsRn2j0KLAtsg4sRtMDFIkWfZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507429; c=relaxed/simple;
	bh=ZPJNGwI8ZV6TkCkxjJdncHVVOp0xKFRXBgBZmjPUfj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSfeqikjD2GpLBGC5m9uWugjRGRawgA3gTM9An3rSKpT/hjxC+45TYb30j+JYe/aBETBxE8TVnJjiC+StufjxzNGU/dyz59Zcldhox5K1AXUCF83UXuoQK7ATFqRe0ozSn7343E0xK1jvzO5o7Znz/Fyf/gzfZu2xgDP8EisEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdsDHjJX; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdsDHjJX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A55C14E41507;
	Fri,  4 Sep 2026 07:36:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76E346057F;
	Fri,  4 Sep 2026 07:36:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ACB3411C7A463;
	Fri,  4 Sep 2026 09:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788507413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wigr90SVwv4gtrJvgS38fzvdsCXdestHuhH3Gmpm1CM=;
	b=mdsDHjJXRtSP/7yKCFmpYkDbxNRioq8AT2qpYIdZKwPNCSLnXxep6r+tHIXGs6TKzcc7vd
	fuDvoVxrCyTXqyPGk5RAfL0DYMKVjUc87RLIupUOmmWklkpJfhRthRawHoIvTF0ePpB14F
	UYNB9lsO68MEdzpTIN32pxLgCdgGVRiZGr2XkfE1VaAvdU7QCBexiFksO0+cctX/dM2Zfs
	RF6cDugGhCTmfY70e+NFCegpUBvxri3B0AQAMc6LAxf4PcLZY2a6IsD+xg3etFAQ4yerF9
	nAE6ssygRfvF30q8VV47RSP09C732XXdGDn5MDoUGhdf6TCmJLy6myq8Zf402w==
Message-ID: <a5c85a6e-918d-49a3-9a29-c0ce429fc9fd@bootlin.com>
Date: Fri, 4 Sep 2026 09:36:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 0/2] ethtool: add interface capabilities and
 PHY test
To: Shubham Das <shubham.das@intel.com>, netdev@vger.kernel.org,
 andrew@lunn.ch, alexander.duyck@gmail.com, lee@trager.us,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: siddaraju.dh@intel.com, balaji.chintalapalle@intel.com,
 dasshubhamk@gmail.com, magnus.k.lindberg@ericsson.com,
 jonas.wirandi@ericsson.com
References: <20260825043708.1512634-1-shubham.das@intel.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260825043708.1512634-1-shubham.das@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/25/26 06:37, Shubham Das wrote:
> This series adds two new ethtool netlink commands:
> 
> 1. intf-caps-get: Discovers the functional block layout of a network
>    interface. Each block represents a hardware point (MAC/PHY/MODULE)
>    at a specific 802.3 sublayer (RS/PCS/FEC/PMA/PMD) with its
>    supported capabilities (loopback, test patterns, BERT, error
>    injection).
> 
> 2. phy-test-get / phy-test-act: Per-block, per-lane PHY testing using
>    test patterns, BERT (Bit Error Ratio Test), and error injection.
>    The block_id from intf-caps-get identifies which hardware point
>    to test.
> 
> The block model uses:
>   - component: which hardware entity (MAC, PHY, MODULE)
>   - sublayer: which 802.3 layer (RS, PCS, FEC, PMA, PMD)
>   - instance: identifies multiple instances of the same component
>     (e.g., internal vs external PHY)
>   - depth: host-side vs line-side within the same sublayer

+Björn,

I'll try to give this a read/test in the next days, 

Maxime

> 
> Prior discussion on this proposal:
> Link: https://lore.kernel.org/netdev/SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com/
> 
> Shubham Das (2):
>   ethtool: add interface capabilities query (intf-caps-get)
>   ethtool: add PHY test framework (phy-test-get, phy-test-act)
> 
>  Documentation/netlink/specs/ethtool.yaml      | 206 ++++++++++++++++++
>  include/linux/ethtool.h                       |  92 ++++++++
>  .../uapi/linux/ethtool_netlink_generated.h    | 104 +++++++++
>  net/ethtool/Makefile                          |   2 +-
>  net/ethtool/intf_caps.c                       | 130 +++++++++++
>  net/ethtool/netlink.c                         |  24 ++
>  net/ethtool/netlink.h                         |   7 +
>  net/ethtool/phytest.c                         | 171 +++++++++++++++
>  8 files changed, 735 insertions(+), 1 deletion(-)
>  create mode 100644 net/ethtool/intf_caps.c
>  create mode 100644 net/ethtool/phytest.c
> 

