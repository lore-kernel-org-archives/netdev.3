Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119E4519B8;
	Fri, 28 Aug 2026 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922466; cv=none; b=sSEttsT3wOSSX/HDbt7GKmVYaWjOdXAKE763BdvyfPnIYDibUUH4Vri/svzxCvtkKNq2i1Dp6K84b5w5aKRQlyi9gVolD8XImXPkVRQygQin+o6iAu0H4OXbuRQHO+MBb5LnXYk+HKOpB3anMO8aOaGEzSHixbSF7hESIVvJwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922466; c=relaxed/simple;
	bh=yBazce1ZWkYueOaWEr6WgWdrpBTY/w4ntsY+EX3Kvfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZdf8Ou4IX+srKLaChdKrFV1+986lKG5RAWvV9GINxc6AlWm5FeB1xoZt6S0jubg2v8VseaStfFvFBJwcvNjqt7xTAFAriI71N6D43z07VHy9RwS4slbkaqGKUBMEnSz2WVgLu20e/vHIu3vWSa8OmtiGVdp5ROa1B2Py/eDzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0p/RHAQ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0p/RHAQ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=36W10jThyPqCCiB0lPjUbAlEaFBQJ3iDfK2MHS8CG84=; b=0p/RHAQ5uxVOrTBgp+pCequ3zJ
	b+84BHeFAeL+pzaeciODVGkMNBwgoirl8nUtKMesx/MKvLzl7L29fKNygIel22egA+/YIGc2UJSei
	LH0QkSNmUjHWvVgJyXpiGrGb71/pOeUC/If0O9uggclNH46VG/bZTb594hAn6ptm53sc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzwIf-001obz-BS; Fri, 28 Aug 2026 15:07:17 +0200
Date: Fri, 28 Aug 2026 15:07:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Weiting Lee <weiting.lee@airoha.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, bjorn@mork.no,
	ericwouds@gmail.com, frank-w@public-files.de, joseph.lin@airoha.com,
	wenshin.chung@airoha.com, lucien.jheng@airoha.com,
	albert-al.lee@airoha.com
Subject: Re: [PATCH v2 net-next] net: phy: air_en8811h: select LED GPIO pins
 based on AN8811HB package variant
Message-ID: <8e7094bd-4880-436c-a86b-e13e07d331d3@lunn.ch>
References: <8530a501-705b-45b2-b876-68855955bccd@lunn.ch>
 <20260828050537.2728253-1-weiting.lee@airoha.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050537.2728253-1-weiting.lee@airoha.com>

On Fri, Aug 28, 2026 at 01:05:36PM +0800, Weiting Lee wrote:
> The AN8811HB comes in two package variants, AN8811HBCN and AN8811HBN,
> which use different GPIO pins to drive LED outputs. AN8811HBCN uses
> GPIOs 0, 1, and 15, while AN8811HBN uses GPIOs 3, 4, and 5. Using a
> fixed GPIO assignment causes incorrect LED behavior on one of the
> variants.
> 
> Read the package variant from the read-only silicon identification bits
> in AN8811HB_HWTRAP2 at probe time and store it in priv->is_an8811hbcn.
> Add an8811hb_led_gpio_setup() to configure the correct GPIO output pins
> and select lines based on the detected variant, and call it from
> config_init.

Have yo seen the patch:

Ziyou Xu [PATCH net v2] net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU

There is likely to be a merge conflict with it. We probably should get
that patch merged first.

     Andrew
