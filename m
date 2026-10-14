Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FA53E303;
	Wed, 14 Oct 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999415; cv=none; b=cAtAdHyYnvzfDM7vobY3eHPfGGfoZx0EOaYnXMcps04MJeyyEv+4Uock+1lbG3Ir1W708aJ4WoZtW2L/MjRoujTVmpGdmi99TuQq6iUA/xYSUqXDjciYela7NgWX68QqUSqdW4UUd1JlavR+AW9Ht9SxPuwk0GPKq3mspO5BL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999415; c=relaxed/simple;
	bh=sZOb/q5trPstnlnZrTzdrlUupWN3qSzxsqc8QYmEaJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuEYEWpAO6jBImtMiAaYS6y31CYAksYicxGKZVTA0Av8oZ6/BaV0AvaX0eaLTIYHyAEulKS6SHmxpC6kt7fAQ4cIIbs3fIPrAYOsH3EqpRTbXKGrXah+2bbHyxL+Pn/YBK/aehrzK6bRnqdt/TtG452kPZ2F2z1wzYBqRzViud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cE3DVJjU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cE3DVJjU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6HvDkb7gcmol+U6f2idd3VW76uJoJqgh/+nwo+x3M20=; b=cE3DVJjU7Xy9DGTA5ze+NgkKYk
	gLyhnsrPqZtTayFhSK1JMlPK+9Upr4UpDR2MlNVRxsxie5tGTsNzis/Wvvdl5Z2YxcVW8009gc4cf
	vZG8wMAYH3EOjzYiHuLeT4MQZC4QN1PwXoCD2rX1Y0xrvY2zrkLA2TLS2ijAE9fOaZDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH2uA-00An1H-5I; Wed, 14 Oct 2026 19:36:42 +0200
Date: Wed, 14 Oct 2026 19:36:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Elder <elder@riscstar.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	Daniel Thompson <daniel@riscstar.com>, donggeunyoo.kernel@gmail.com,
	ansuelsmth@gmail.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qcom: qca808x: Add regulator
 management
Message-ID: <44a96544-5ed8-4bdc-8757-d7413e221f40@lunn.ch>
References: <20261014172300.292324-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014172300.292324-1-elder@riscstar.com>

On Wed, Oct 14, 2026 at 12:22:59PM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> QCA8081 appears in embedded board designs paired with GPIO controlled
> regulators for its power rails. Add logic to allow these regulators to
> be turned on during a probe.
> 
> In order to avoid the complexity of tracking state for suspend with and
> without WoL we take a tremendously simple "always-on" approach to
> regulator management, essentially relying on BMCR_PDOWN to conserve
> power when the phy device exists.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/net/phy/qcom/qca808x.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index bab26e4c61408..6e2bd753257d9 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include <linux/phy.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/module.h>
>  
>  #include "qcom.h"
> @@ -181,15 +182,44 @@ static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>  }
>  
> +static int qca808x_power_on(struct phy_device *phydev)
> +{
> +#ifdef CONFIG_OF

Does this need to be conditional? It seems like
devm_regulator_get_enable_optional() should return ENODEV, which you
already handle.

Making code this like conditional makes build testing less useful,
more combinations which need testing.

Another option is

	if (IS_ENABLED(CONFIG_OF)) {


	}

That at least compiles the code, and then the optimizier throws it
away when it sees  if (0) { }

     Andrew
