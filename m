Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49779254AFF;
	Fri,  4 Sep 2026 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485830; cv=none; b=TWc72JikgvEWVRYxeIw1BLlssSMbsugMMw2RzZqwyt712l0qnAvpr1/jI9GaiTtGvlk0wbvuPl9VjtyP0UZS1bCGsF4ArJKyhj0hetLp0XQJQ052liWo4XR8qF1YVmKykQV3fgW7Mnf9BvRhpnZGou9ZGKGPmF+WFpZf83zPmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485830; c=relaxed/simple;
	bh=dKBRxKxAm6nvUOWr/yd7ttRY78JkpD5ti5XsPscx5O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZadxjlQMllpDmRT5zmwzW+/KqQoDu11IgUzWnEx3CHgd1yomyvK6NwypQqpLAbKhIcF2Vcv11ZhGUgxRIW4RDfbD3nvM8EG+Y/qmjAVVf2bq4m3rW6wSs5lNhtxQ8VCuluhcr/Ni3XVskhO7aw9cBaMJbiYAQeVkhsN9+KqFASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tS0es+Sf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tS0es+Sf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gPTzn4SqmsPbmc8R6JU50peWEpeHMIDKi5gnnllyFbw=; b=tS0es+SfJ8etMQ3WT7rt4WI31k
	fjEPiSnk/vPw+AbwJ7rHYCIbSeUzue+4l0a+4Oaq9I67+MHcFNCEhV4zru8ddFxlua+MfZPNGSOtL
	+6jHzc98O43rwas+ZZBK/mmy15eKAf5B6WymrG0uPRp+G70nZ2EiF0AojaTquHgbWiuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2IrS-002pXi-8K; Fri, 04 Sep 2026 03:36:58 +0200
Date: Fri, 4 Sep 2026 03:36:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 6/9] net: mdio: add Airoha EN8811H MDIO
 device driver
Message-ID: <79608b1e-ca10-48ef-978a-a6d8bab9a538@lunn.ch>
References: <20260829052546.1152446-1-f@lex.la>
 <20260829052546.1152446-7-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829052546.1152446-7-f@lex.la>

> +
> +#include "../phy/air_phy_lib.h"


We try to avoid such paths. Please use include/net/phy/

> +static void en8811h_mcu_fw_poll(struct work_struct *work)
> +{
> +	struct en8811h_mcu *mcu = container_of(to_delayed_work(work),
> +					       struct en8811h_mcu, fw_poll);
> +	struct device *dev = &mcu->mdiodev->dev;
> +	int ret;
> +
> +	/* The chip enumerates as a C22 PHY; MMD access is indirect */

This is an mdiodev. It is not enumerated. It is explicitly listed as a
device on the bus with a compatible.

C45 over C22 is a PHY concept, not an mdio device concept. In this
case, this mdio device is special and does implement C45 over C22. But
it is up to use to this driver to decided if you want to use it. I
would probably look as bus->read_c45, and if it is not NULL use
direct.

I wounder if there are any boards using this devices which are not
capable of direct?

> +	mcu->waited_ms += mcu->poll_ms;
> +	if (!mcu->warned && mcu->waited_ms >= EN8811H_FW_WARN_MS) {
> +		/* Missing files resolve by themselves once installed; a bus
> +		 * or register error will not, and deserves its own message.
> +		 */
> +		if (ret == -ENOENT)
> +			dev_warn(dev, "still waiting for %s and %s\n",
> +				 EN8811H_MD32_DM, EN8811H_MD32_DSP);
> +		else
> +			dev_warn(dev, "firmware download keeps failing: %pe\n",
> +				 ERR_PTR(ret));

dev_warn_once().

	Andrew
