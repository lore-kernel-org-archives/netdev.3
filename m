Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE833D4E9;
	Mon, 19 Oct 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409120; cv=none; b=eMjIbSJfd363j1zgPEJ4Z0+iDGrnwnJVHOdMBl/xVkXg2iRVXj2fEFZ448NNLVQxTfnUY3saMzJRdtiszaME1QHgekJxerAYNKLX0R0/eqZvnB0puA26VKPhfaVR7ikkaWeWYMhiFk9f7uuEnSjSD/Tr40bUgV+YAedVUd6VZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409120; c=relaxed/simple;
	bh=1mOOSFujhvgs94vGgbMhMXlk/u+ISHgI+nzKorFbgV0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GyhBRtT/O+edImhGKAtewYhkf5g1hKh/lH++1TrNNmiq9pgd2fcVfcn0cAQ8+nM5tqVsHgV0vb9mvnGK1kGE3uYxgHF1uB5l6dtAN2xa8T+8IDL5P2Fo9UVgbBTL9XwH+2PZCSQoJXmT9oX/JqTsaB+SaycnqRkDbVQhQPf0/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=V838IofJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="V838IofJ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FCF0A156C;
	Mon, 19 Oct 2026 13:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792409114; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J6+x4cQLsxMhtrH368z9koyzpirWhm9EMhYA6RfUa00=;
	b=V838IofJg4OOVIPaPOeCMA2XcWEXk5S2HYIGwII25aTJf/495+np1SbbzWZY/i2GDdeB24
	yry+/x78IqUibweoGMUz3TXvc/2xon8NInTQZj1OWbVscnLfCFntS80/TH5AlvkIWyVm6+
	gjYZ/MI/cSowaPmILQ9AvHRu+CLqZSW13r+P5qLxW1Z8yJ+B3CodbRIOEuKZHerza3Ss5D
	plyIhnAF6WktK0XblauT4XPbVH27Nxzi8LcB12g2VSxcZw7RQgRx12OFWWjn/qpHQYGf44
	tODwgdZ4Hu1fgCtnA4NF0hRBcDPo0vwtYt2meoYoerJ3i04dEQqnYsih59oLfw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 13:25:12 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Stefano Munari <stefanomunari.sm@gmail.com>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Oleksij Rempel
 <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: lan78xx: fix error handling in
 lan78xx_open()
In-Reply-To: <20261016000521.92868-1-stefanomunari.sm@gmail.com>
References: <20261016000521.92868-1-stefanomunari.sm@gmail.com>
Message-ID: <7b05d39d4674c16065b03f88b1ccfd05@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Stefano

On 16.10.2026 02:05, Stefano Munari wrote:
> A failed interrupt URB submission leaves NAPI enabled and 
> EVENT_DEV_OPEN
> set. A subsequent open enables NAPI again, triggering BUG_ON() in
> napi_enable().
> 
> Clear EVENT_DEV_OPEN and disable NAPI on the submission error path.
> 
> Reproduced using failslab on a Raspberry Pi 3 Model B+ (LAN7515).
> With the fix, the injected allocation failure returns -ENOMEM and a
> subsequent open succeeds. Verified connectivity with ping and SSH.
> 
> Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for 
> improved PHY and MAC management")
> Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
> ---
>  drivers/net/usb/lan78xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index 5655941f1478..6a95934bb3d3 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -3484,6 +3484,8 @@ static int lan78xx_open(struct net_device *net)
>  		if (ret < 0) {
>  			netif_err(dev, ifup, dev->net,
>  				  "intr submit %d\n", ret);
> +			clear_bit(EVENT_DEV_OPEN, &dev->flags);
> +			napi_disable(&dev->napi);
>  			goto done;
>  		}
>  	}

Looks correct to me. Maybe move the cleanup into an unwind label, so
the next error path added after napi_enable() doesn't miss it?

                 if (ret < 0) {
                         netif_err(dev, ifup, dev->net,
                                   "intr submit %d\n", ret);
                         goto err_napi;
                 }
         }

         phylink_start(dev->phylink);
         mutex_unlock(&dev->dev_mutex);

         return 0;

err_napi:
         clear_bit(EVENT_DEV_OPEN, &dev->flags);
         napi_disable(&dev->napi);
         mutex_unlock(&dev->dev_mutex);
         usb_autopm_put_interface(dev->intf);

         return ret;

Either way:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
