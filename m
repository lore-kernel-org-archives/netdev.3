Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC083CC7F3;
	Tue, 22 Sep 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064348; cv=none; b=Ci/gfHTKhprjdOTuuQr8qnTwS7gBhCRhUjzPTgkHlB33bPJr4kd2PbCT6Gfj0sxFe6c48XUR1nW53M4EtF2z9WMpCamKYsXPtgvOxZD4z0aYmD7WbywzN0eOPrK0R1BQtBiGBSeIxLrYviB1B5/HAyA2elSOEoed4ysGMzBKTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064348; c=relaxed/simple;
	bh=PDfqLIrtKXc56e+IxGVn2DHnILwSPY5ARzjjT75vb4I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QMOHcGrxbNBYY+jFpmwKpi3ABssF6nDVK1+iOXhLtc21bCje7abOYy9k/rJHrTJWxtzbXq470kRFOztPwY8QOWBDWDRjklVVt12U6BTjJ3sIKtBXLth8z/POnYnqvt/a/vb2keJCXPkfvG4vR+Mx71CWCIOVRg5KgKBsCUiwJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2mEKz5PH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2mEKz5PH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9DFEA4A18;
	Tue, 22 Sep 2026 10:05:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790064332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=foVdRgaMl1qFwxL6Tifr5TOpbq3AA20cOEg6B93g4Hc=;
	b=2mEKz5PHqiXTHCnWQP1JT/umvxPZ7N/7iHewQV4yFcowQ3Q7dZIbrpY7i37X1IjnUdowiY
	OQYZXpaljfye+FEk5AnYSnBkMeoNXiP2LznujYDce5tapD9w0VKFBb90UROfoYl+jtzHoZ
	AIX9SdOy59Bzazye/qncnA+Avve1OLko9ToGBz6b1wz+sQyVTHSTlX62qWPb09eojhEQNV
	+EomXLwFQWJNv6wsw/n/2jFztOJDzvex3HI2O/Y4p1mQfbfYMkTMQiO45GJmPxyOwfmNLD
	PZ1PH59p8+42sOFJOz1YSkf7obnPbJLRGRwku5DBhHCNFAA+2kcfqgOlPt+C7g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 10:05:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Kory Maincent <kory.maincent@bootlin.com>,
 vadim.fedorenko@linux.dev
Cc: James Clark <jjc@jclark.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: let tsconfig reach a PHY-only timestamp
 provider
In-Reply-To: <20260922070813.1458713-1-nb@tipi-net.de>
References: <20260922070813.1458713-1-nb@tipi-net.de>
Message-ID: <5af6a329b41d6d40d1488ab4ceffef02@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

+TO vadim.fedorenko@linux.dev

(get_maintainers seems to missed Vadim, sorry)

On 22.9.2026 09:08, Nicolai Buchwitz wrote:
> TSCONFIG_GET and TSCONFIG_SET reject a device that implements neither
> hwtstamp NDO, even when its PHY can serve the request. The ioctls they
> meant to replace handle it, so the two interfaces disagree on the same
> hardware and user space has to pick one.
> 
> Drop both checks and let the phylib helpers decide, like the ioctls do.
> 
> As this makes a netdev provider reachable without ndo_hwtstamp_get, 
> test
> for the callback before calling it.
> 
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to 
> get/set hwtstamp config")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Follow-up to 31995571219c ("net: don't require the hwtstamp NDOs when a
> PHY provides timestamping"), which fixed the ioctl side:
> 
>   https://lore.kernel.org/netdev/20260918095540.34286-1-nb@tipi-net.de/
> 
> Tested on a Raspberry Pi CM4 with BCM54213PE.
> 
>  net/core/dev_ioctl.c   |  3 ++-
>  net/ethtool/tsconfig.c | 15 ---------------
>  2 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 164643140a52..f6029f60c1dc 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -267,7 +267,8 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
>  		    hwprov->phydev)
>  			return phy_hwtstamp_get(hwprov->phydev, cfg);
> 
> -		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
> +		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV &&
> +		    dev->netdev_ops->ndo_hwtstamp_get)
>  			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
> 
>  		return -EOPNOTSUPP;
> diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
> index 6be3aa5d4bc1..8c99b2dc26d0 100644
> --- a/net/ethtool/tsconfig.c
> +++ b/net/ethtool/tsconfig.c
> @@ -42,9 +42,6 @@ static int tsconfig_prepare_data(const struct 
> ethnl_req_info *req_base,
>  	struct kernel_hwtstamp_config cfg = {};
>  	int ret;
> 
> -	if (!dev->netdev_ops->ndo_hwtstamp_get)
> -		return -EOPNOTSUPP;
> -
>  	ret = ethnl_ops_begin(dev);
>  	if (ret < 0)
>  		return ret;
> @@ -248,17 +245,6 @@ static int tsconfig_send_reply(struct net_device 
> *dev, struct genl_info *info)
>  	return ret;
>  }
> 
> -static int ethnl_set_tsconfig_validate(struct ethnl_req_info 
> *req_base,
> -				       struct genl_info *info)
> -{
> -	const struct net_device_ops *ops = req_base->dev->netdev_ops;
> -
> -	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
> -		return -EOPNOTSUPP;
> -
> -	return 1;
> -}
> -
>  static struct hwtstamp_provider *
>  tsconfig_set_hwprov_from_desc(struct net_device *dev,
>  			      struct genl_info *info,
> @@ -459,6 +445,5 @@ const struct ethnl_request_ops 
> ethnl_tsconfig_request_ops = {
>  	.reply_size		= tsconfig_reply_size,
>  	.fill_reply		= tsconfig_fill_reply,
> 
> -	.set_validate		= ethnl_set_tsconfig_validate,
>  	.set			= ethnl_set_tsconfig,
>  };
> 
> base-commit: f0b88fade64c6fe52e15b246097d10bb115d8af3

Regards Nicolai
