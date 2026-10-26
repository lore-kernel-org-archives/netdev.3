Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003409;
	b=Qfa6/pWnOsmTMScP5Slb2YGsxqD0drX/H6e/n+9JpY8EJ8WME3XSbRn6Ebh2zcs5ynZ7
	 CS1s8F25zkqS2Xz45tg9NUt5jK+bEWj0fpl4PI+YTnwuGF/qVzNinUYd90w5alkGwzRT4
	 XL7nwvFS+b+bZqPB8ReF4nCtN5EdFQT1LK157FSPEViGirKqEq3PlGf23HMWbY9CuxKtH
	 PKNLyay+sCGY6zuTHHFfLb3HMQbyc5UXqZfoGQI/mipYTfwYiMRRkCSRZPTehOuYaEvio
	 arzh8/YUxH31o5Wj9IzwrH7+BC08aDXHhjaq2Rha1xltqQ5z6RygAkZzia6YZLg/N1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003409;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b5etnZhCv6zd/G4FnaCNzVDV5k63+OPwZa8pBcS6d0k=;
	b=K2gMY7oo9moTFP6cZpsJEwdv+9SE/Maa0aF7Uu+aE2uZdaCQOQRBycsD1U/5KxUe3ZJH
	 Pa048FyG1Jg6dL99JsLuFRhafDFnHAEVhG9+hii4isNZ0ZDnwrg/rOv/EQrVwQG/bZc3v
	 +rC5WOsaSa9E2DNgEa3tfppV1Gl8p7gaUpuMbIcGbOtpWdLZxOFJKAP9uQW9J9wmJe9gZ
	 6AvHIZlVWhwYRPyAE4UH3Z7BB4rM0HE2xej/tyw1GKnOlWXpaf43a+jwpsZ1b39o9cGkb
	 r57Exv9FFb40iGXDjGnXaUj9UmvLcnT5QjRHba1j0I654nKWYBrmcqLgPI0EB5PNw2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="ehra3wx/";
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391E606A337
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B391E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ehra3wx/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793003408; x=1824539408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+jtdwjXlLe/VpDKXe9x9KUCq9vhFm4y9pr/sb64kos=;
  b=ehra3wx/dpEWklfOLhBddCyeZjwstIVhkhl98BH+92o+sbgqsV5GWojY
   hfgK7gsBWIiAKD4kgaJJ1Kd80wCFcNrhrZVKMd43WS0KmOZwpnmXF1rTL
   MYz0ARAuRsFCaFUxfyJWYh/4H56WgN9X8xBe0TtLQJ8xAM9x+26mJcikq
   bg57f6oeH5wx0EeKSF4PEu2c0DXlrTI3vuv0TZIHdK/fxatk6n9A+f3SC
   6uePrXQ4XDxlMJMgWSLzzTotDAkZyhh6kZC8FdM08boMD6G6g2Eiq3764
   Cqceo/4WarvHjT6nxjYZlQddZsnuSaoMd0uQrmZQ4hA8qyeyO0h6etRGW
   Q==;
X-CSE-ConnectionGUID: N+VtUP7+R3uldKIGc/953A==
X-CSE-MsgGUID: ujF3hsb/QZ2FyfoBHM8jaQ==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="65544468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 01:30:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 01:30:07 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 26 Oct 2026 01:30:06 -0700
Date: Mon, 26 Oct 2026 09:30:05 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Haon KIM <akrn112@naver.com>
CC: <dsahern@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: l3mdev: Set OIF flag only when an L3 master exists
Message-ID: <20261026083005.edngrb7gs52ouhm6@DEN-DL-M70577>
References: <20261024175746.2341-1-akrn112@naver.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261024175746.2341-1-akrn112@naver.com>

Hi Haon,

> l3mdev_master_ifindex_rcu() may return 0 when the device is not
> associated with an L3 master. In that case, l3mdev_update_flow()
> currently sets FLOWI_FLAG_L3MDEV_OIF even though flowi_l3mdev
> remains 0.
> 
> Set FLOWI_FLAG_L3MDEV_OIF only when a non-zero L3 master ifindex
> is returned, keeping the flag consistent with flowi_l3mdev.
> 
> Signed-off-by: Haon KIM <akrn112@naver.com>
> ---
>  net/l3mdev/l3mdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/l3mdev/l3mdev.c b/net/l3mdev/l3mdev.c
> index 5432a5f2dfc8..92b48d6a4301 100644
> --- a/net/l3mdev/l3mdev.c
> +++ b/net/l3mdev/l3mdev.c
> @@ -279,7 +279,8 @@ void l3mdev_update_flow(struct net *net, struct flowi *fl)
>  		if (dev) {
>  			if (!fl->flowi_l3mdev) {
>  				fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
> -				fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;
> +				if (fl->flowi_l3mdev)
> +					fl->flowi_flags |= FLOWI_FLAG_L3MDEV_OIF;

Looking at the readers of this flag, it does not look like this does much, so if
anything this is a no-functional clean-up for net-next, I guess. The commit
description could be more specific about this. Also, the target tree is missing.

>  			}
>  
>  			/* oif set to L3mdev directs lookup to its table;
> -- 
> 2.37.0
> 

/Daniel
