Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF837F00D;
	Fri,  9 Oct 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536113; cv=none; b=DkTi8yvGczVageUQlqD50BFwEU60sB9zpL1uUAfABLwByMcsJQwmzptgzjQZV3gplk7LRNZBRtHkJMIdhtDH62ybMBmjWXavvprJIXU+D2R67+BMs9PAYJzP7MOGF6Xhxqov8hYXkMRxf2X6Z2kG+Od1GLooTfO7EKer+uQHfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536113; c=relaxed/simple;
	bh=M/772MkfjZxcZxdMFw08GIOdq6kwRPrIVPBEqXSBW6Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pvT7NxWP3dCuXqJNCjZGjzuqQ/kJqRkRvBzGQTZnG+c6wn4+UWiWqbV9NVErBdXPb3dwTRx00DDfVgaOnXDwowayh0gSMjlbdsNWO9MaCGXgKJDvpsW1gnEVev95EjP4DulHRgAcFsagVNjfUqtgJKEkRCO1qC98nW3bPIHk08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FR36wPfz; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FR36wPfz"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91533A1546;
	Fri,  9 Oct 2026 10:55:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791536106; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IjYswT14LA0G5bCkxr3uocVn1ohEeOrTPJe/VBLRec4=;
	b=FR36wPfzdJIXMnFWr4kFm5yec1kmgM2TrnWrw91tT8Fx1I5cc8iEKPEzyhR7XSG5hyRyRO
	TLa89Xd8iSVSBCGP5gF0AB5Ism1NozLiHH3uzS9V+IC7iXCH+0406JVlLx59AeJl2VJ6Um
	eb5Cly3pu4OzbC9VX0liVopXRHCgEc4HSSorhIuPUCzwI/RgKBvURRwUYWFnQ4Vz+wlQxy
	O8EC5pM2lRyEBAVpVF7dTc/MEtZj/gps2jb3Tz02agkS2BLBYDj4ngGfLtmC8bwetx6WuG
	RoLp5Fzn4y0aoy8sk5suMerHxvCJgqk3x25qjEZm0irBFERhcmiJk/CKfEZ8hQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Oct 2026 10:55:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 6/6] net: bcmasp: fix network filter lookup and
 wake filter pair allocation
In-Reply-To: <20261008210621.1374785-7-florian.fainelli@broadcom.com>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-7-florian.fainelli@broadcom.com>
Message-ID: <eab2af85055e2096fb5d28db18860b0f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 8.10.2026 23:06, Florian Fainelli wrote:
> In bcmasp_netfilt_get_init(), when looking up an existing filter 
> (!init)
> for a specified location, if the filter at loc was not claimed, the
> previous loop continued searching higher indices and could return an
> arbitrary unrelated filter belonging to the port. This caused flow get 
> or
> delete operations on an empty rule location to return or delete an
> unintended filter.
> 
> Fix this by checking only the requested location on lookup and 
> rejecting
> RX_CLS_LOC_ANY when !init. In addition, harden wake filter allocation
> and release by ensuring wake filter pair searches stay on even 
> boundaries
> where both entries are free, checking that loc + 1 is free for 
> positioned
> wake filters, and validating parity and bounds on release.
> 
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net 
> filters")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 121 +++++++++++---------
>  1 file changed, 70 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c 
> b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 972474893a6b..b6a201982080 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -511,6 +511,13 @@ static int bcmasp_netfilt_wr_to_hw(struct 
> bcmasp_priv *priv,
>  	return 0;
>  }
> 
> +static inline bool bcmasp_netfilt_is_companion(struct bcmasp_priv 
> *priv, int i)

nit: Does it need to be inline? Usually the compiler takes care of this 
automatically.

> +{
> +	return i > 0 && (i % 2) &&
> +	       priv->net_filters[i].wake_filter &&
> +	       priv->net_filters[i - 1].wake_filter;
> +}

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
