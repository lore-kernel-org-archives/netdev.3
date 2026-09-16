Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A71368D5A;
	Wed, 16 Sep 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545042; cv=none; b=Hw0QRVU1eHHtjn/Vlil1kNQqxK6mesL//ZtFm8Cv42AsXrJe9+rBR7q2HdG0NyWa6SzT3euxy7QDXoFHutnxqA96jGgjFGhDvxbAFUvusyRu9Rh9L4BPN06Rn+VZ1dKZD/u6WuKjy9YEOraiaG6xenxD/jK2UI4hGjs0HMAsoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545042; c=relaxed/simple;
	bh=HmW3hgKNdZFFqVaGuZlse+FuUvYALkm6XBDMsPTxHDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw9RDWrPKPdSNhNn0uf64q/UGfNYvDgANukPhRj3HFl+kz2SDLQTEQEAPkmBRZa8Q6EIFIkrCwwIuaNhF5x5Mi+AsNyPyVEg82oC4/upf/gCX8AItVngTUXEdJ2vi+yRCXbXDQv1bVbEfHr5PI1Vs+f7uHG9mvV1jUje13A4k5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8gYDB85; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8gYDB85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789545030; x=1821081030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmW3hgKNdZFFqVaGuZlse+FuUvYALkm6XBDMsPTxHDQ=;
  b=U8gYDB85SIb4prRfk3OAvbPlTBxXiPhHnnyUTAMdMLeHwJqu1vUd38y8
   Q6HZxiQqf6UrH8IqI/esahwvdxqaqPsVPRBp/AdonBW625+4tfqwd2YyA
   ja9MIqtrcXoGE5irDUvFuFha4MQyVR3ya0eh3W33vnWlonuKCSRaag8Q6
   S7nhxf3EfMpb22hNVYE128bH3qDQYwT4cvogZb6B20H0lfJskowKdFuoB
   hV7ybeTEZINmq2Fk2NxAtzQ0H19sWlcJEP6R2Jy8t/iQhpq/z+QokI40V
   cHxQ4OKoUb44LJUMJV1hwQxL0D11C4B09Dj2829qDGHiSfJ3h78mG/cC0
   Q==;
X-CSE-ConnectionGUID: O0EtwG76S5Onq/cTK6hZ0g==
X-CSE-MsgGUID: lekpKMgqQvOS+rFKvsyBmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89787592"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89787592"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:50:26 -0700
X-CSE-ConnectionGUID: lT79ZWUSRim8+OhCC8iRNg==
X-CSE-MsgGUID: mn0cNCjwTvmlVSZRXJM3gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1489856"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:50:23 -0700
Date: Wed, 16 Sep 2026 10:50:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lucas Stach <dev@lynxeye.de>, Peter Korsgaard <peter@korsgaard.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: asix: reject a truncated Data header in
 rx_fixup
Message-ID: <aqpKPXiVESngnVhp@ashevche-desk.local>
References: <AS8P251MB0001D5442318B9E58797D230C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001D5442318B9E58797D230C8BA2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 11:57:24PM +0100, Aamir Ahmed wrote:
> asix_rx_fixup_internal() runs its parsing loop while two bytes remain,
> but the branch that starts a new frame reads a four-byte Data header.
> Only a two-byte tail is special-cased, via split_head, so a three-byte
> tail reaches that read and leaves offset at skb->len + 1. The clamp
> below it then takes the unsigned difference skb->len - offset, which
> wraps, so copy_length becomes the full length the device asked for:
> skb_put_data() copies from one byte past the received data and
> usbnet_skb_return() passes the frame to the stack, before the trailing
> skb->len != offset check can report it.
> 
> Reject a Data header that does not fit and reset the parser state, as
> the other malformed-header paths do.
> 
> Only a device emitting an odd skb->len can get there, since offset
> always advances by an even number of bytes.

...

> int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,

> +				if (offset + sizeof(u32) > skb->len) {
> +					netdev_err(dev->net, "asix_rx_fixup() Short Data header, offset %d, len %d\n",
> +						   offset, skb->len);
> +					reset_asix_rx_fixup_info(rx);
> +					return 0;
> +				}

I don't know the rules about __func__ in the error messages in net, but above
may be simplified as

					netdev_err(dev->net, "%s(): Short Data header, offset %d, len %d\n",
						   __func__, offset, skb->len);

-- 
With Best Regards,
Andy Shevchenko


