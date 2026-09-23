Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8332B112;
	Wed, 23 Sep 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168433; cv=none; b=f9GIZJx4AwUK0ilyeQ/ooxlPixnj6jAmZidvXxXXNTZXgq2lK4hdFaSK4TQm4jWw55apsdJIox3C7AO7vhqCfMtBeh1guBXdJkMGeBnkKSN//2LKI3yNcJsM+zVqW3MbmfcFfVp8IZGLhLf09ZWPdUxtISwSPWa558MdCspZN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168433; c=relaxed/simple;
	bh=OuRi4RB4ETc1nsHbqt+ElDxiJpjjkHhEVNTsrEq4D4I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KlCSQaaNoGE/odlQZ9JxWkod1vcpmR2GhmWEplsGKmNgJPbpO+BX1Sx7AfdRc4x+w0Z6Vik6ZU2ho/n5GYUKH8S7y2cgEaPH7dSi7NzMHLkmSMxfobM86h1HbNM2YeU+HP4vFj0Q8fxhBitRgMPm1hwJNW369raXMQqbC+P2/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=RlQRzBS4; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="RlQRzBS4"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E403A4AA2;
	Wed, 23 Sep 2026 15:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790168429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FJKmiNAmuxbpruVO5Wj9VLGixnw/8MdgtY3CHwCOtFI=;
	b=RlQRzBS4tTCx+L5uZlNtuws/1aOHIHQnCV82rjGeD2btkkj0j61U94SmN/+ckgX5O/ph5e
	XVOHDXM9MQ6r6CaWx0FhA1qCXgpQd4GZGQqHbg5OQmp67HMqeAYmGgFvl6jbEBGpVBRe9a
	PpFeODF9IVNkdLBQNCFMj5kxe7YtPFq5nl8q6PCfRtXO15YMlJlpyYQb/4i4S6ObitTvEJ
	1i4X8KrTPFI3WbAXSJjO5gMPm/a9n+2VT69repb5GpxlbrhsCK6HSk+sr+FiOpdbRU39Cv
	7mmrh7IkpbcDCjdk2DBx8YNbSqiYhLgbVPrwK3yz6ZW/QP/ull3jpzhwViudbA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 15:00:27 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kory Maincent
 <kory.maincent@bootlin.com>
Cc: vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 bjorn@kernel.org
Subject: Re: [PATCH net v2 1/2] net: ethtool: don't match a hwtstamp provider
 on a device without a PHC
In-Reply-To: <20260923121644.2194183-2-nb@tipi-net.de>
References: <20260923121644.2194183-1-nb@tipi-net.de>
 <20260923121644.2194183-2-nb@tipi-net.de>
Message-ID: <e604da518229c94ea571db295776f1b1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

+CC Maxime & Bjorn

On 23.9.2026 14:16, Nicolai Buchwitz wrote:
> A device without a PHC reports phc_index -1. A request for index
> 0xFFFFFFFF is stored in an int and becomes -1 too, so the two match and
> a netdev provider is selected on a device that has none.
> 
> Fix this and only match a real PHC index.
> 
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support 
> several hwtstamp by net topology")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  net/ethtool/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 23db40618fed..23e8282563cc 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -980,7 +980,7 @@ int ethtool_net_get_ts_info_by_phc(struct 
> net_device *dev,
>  	if (err)
>  		return err;
> 
> -	if (info->phc_index == hwprov_desc->index &&
> +	if (info->phc_index >= 0 && info->phc_index == hwprov_desc->index &&
>  	    net_support_hwtstamp_qualifier(dev, hwprov_desc->qualifier))
>  		return 0;
