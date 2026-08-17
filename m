Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384572D6E5C;
	Mon, 17 Aug 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005683; cv=none; b=VXmdM487SbkF31jICiborD1Hr6wPv10o9R3ApkrV9yEJDD5OMWE+lx2AYN+mjMB8LpxHu8l1yhJobXQ+kat+fE/IBi95UU1b5bWRdbfqPhuIUgmklXeeJ/F5HH5z/q06opV2bdeM7U7z5AROpsS3jBTce6hHTsqeMjKmmFCi9E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005683; c=relaxed/simple;
	bh=UMxkqhcNmdOfEdZpDFLt2yEPvR9waMLCQXwTEEbaqII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ex++pwk1PNAumaizz/AYWDrcPMKyCbmyv2FYl5XUEzocDoigMtwhMsJS3CBe2869CINjUSlmkvRF4bowHnaJIMG7ygsBdq1CH9wJx0dmzSJWbh4+XxnyGvs0PynAR42xhj4fg8iiJP23BOhDaN/LDtneAlSTSzDpWsNEpigUeO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0vrWPzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0vrWPzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9EC1F000E9;
	Mon, 17 Aug 2026 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787005682;
	bh=UyzKyQjtoCAVNkuxn0BStArhhbH9NQbyaiXvV6QUKcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X0vrWPzfedI0zSggWHkj/Q+tOsDtLtMpGVs2J785dLuUToEzSIHvISLzyYTNSFjGv
	 M37BFQYTdTNnCdf16bolJ4amRVtpQTt1Y8LgDvbtdM8iQfPgX9NuBfCjGpuc1lXgYd
	 zGauCGrO3q91MfEeNqOCimHIsqAEYp4XF8H0d/lBXJ4AhQMx8EJmskRgyi6Am1I3Yw
	 pWRJsNDMGHBdYRPmkvIyuBgMbXo9DZHH5wjfbKTw1e7qVEjDBrgaqYhu/cC/GntSnw
	 TrbRhq0RqLjpnkRRZ8PZzCV8DYTjmGoI5emajy0N8+NW376pmmkBIvrQc1xelwCR9N
	 fJe/ufMoLwCBg==
Date: Mon, 17 Aug 2026 15:28:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v7 03/14] ax88179_178a: Split driver into
 library and device specific code
Message-ID: <20260817152800.3dbe9f55@kernel.org>
In-Reply-To: <20260810-ax88179a-v7-3-da633191c129@birger-koblitz.de>
References: <20260810-ax88179a-v7-0-da633191c129@birger-koblitz.de>
	<20260810-ax88179a-v7-3-da633191c129@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 14:33:28 +0200 Birger Koblitz wrote:
> +static int __ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
> +			       u16 size, const void *data)

Local netdev convention is to still wrap at 80 chars.
Anything beyond that is inviting laziness.

> +{
> +	int ret;
> +	int (*fn)(struct usbnet *dev, u8 cmd, u8 rtype, u16 val, u16 i, const void *d, u16 size);
> +	struct ax88179_data *ax179_data = dev->driver_priv;

Local netdev convention - please sort the variable declaration lines
longest to shortest

> +	if (!dev) {
> +		netdev_err(dev->net, "No net device.\n");
> +		return -ENODEV;
> +	}

Is this a real check you need? It was a BUG() previously, so clearly
it must never happen. Please don't add pointless defensive checks.
