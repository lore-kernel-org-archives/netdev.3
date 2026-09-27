Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20043423A66;
	Sun, 27 Sep 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538026; cv=none; b=ZpPktAfxioeouJteV433Vwb7gAMIOzgk4+odBWDspyeB1StFNTiqoSTWKxl8++Y9ytXbgdG2wSSfIusJoqmew6VVgc4EgAYxA08kCqVr5eAYEIHqbx1ZZdb4MyRfjlsEBOaCKUG7cj1vo/EwfvYy8DzSOSNLVXqqv2LBTP8zYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538026; c=relaxed/simple;
	bh=6ymQVd+fsyAptecxks1UrJYb+TB4txUB6FnPeCzHsb0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Mbv5WxupP0S66/ZgInELX4M+dMkPoJe5yShS4EFwNCwqr2bR8olmI5YRpprdrpjc/lDZvMyO4fYNSyWYkbHBakS/PKBMAFAjhrgmEDz12LRmx+tBC0wswSQaBBubSBd+GSjbI1oHjDImejUUoiafNUPbMUsTNLDm8fe6NMLBXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0mKetHpv; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="0mKetHpv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37485A02D8;
	Sun, 27 Sep 2026 21:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790538021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KnrKA+LVxa/BuHBYa6dl9JUYtGsArMsZu7eJA/ScaHY=;
	b=0mKetHpvFJhqM8YQ+WXRUtOK+rTu4qMQ5T+wRpVvif7LlEJ1Knmokj4MId+UVsUT0aOo63
	pfr0zRlEt5ZlWhcPr34ZQpucxCNhEc65vN+g+VKbNoFksylY7+Um2JzWvqyfnts//cFYP9
	rw2KG+iFYsJHasJEwN7gsf5fusP/zM8cuMX2dcDn9QboWoDQpqZsKtCkVrJbopIhy/LpOr
	8rK9jOXp49/7rm2Wuc46rYL+T5HaQICeEP2DJd2yX/9pBMtZGGFuw+aj8SR0hu9oEgnZqJ
	ozhPL+Vgw/NL7bNq/LOgQvUlpc1R2toAF15v7/HSTSBM/Z7vhcsXPHb1DLZEag==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2026 21:40:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: bcmasp: remove duplicate MDA filter
 register definitions
In-Reply-To: <20260922222525.3992167-3-florian.fainelli@broadcom.com>
References: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
 <20260922222525.3992167-3-florian.fainelli@broadcom.com>
Message-ID: <72d6b4dd7ae8cd606868696351705a31@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.9.2026 00:25, Florian Fainelli wrote:
> Remove the redundant duplicate definitions of ASP_RX_FILTER_MDA_CFG,
> ASP_RX_FILTER_MDA_PAT_H, ASP_RX_FILTER_MDA_PAT_L, 
> ASP_RX_FILTER_MDA_MSK_H,
> and ASP_RX_FILTER_MDA_MSK_L in bcmasp.h.
> 
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h 
> b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
> index 8c8ffaeadc79..b08a7ddc4c64 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
> @@ -80,11 +80,6 @@
>  #define  ASP_RX_FILTER_MDA_PAT_L(sel)		(((sel) * 0x14) + 0x108)
>  #define  ASP_RX_FILTER_MDA_MSK_H(sel)		(((sel) * 0x14) + 0x10c)
>  #define  ASP_RX_FILTER_MDA_MSK_L(sel)		(((sel) * 0x14) + 0x110)
> -#define  ASP_RX_FILTER_MDA_CFG(sel)		(((sel) * 0x14) + 0x100)
> -#define  ASP_RX_FILTER_MDA_PAT_H(sel)		(((sel) * 0x14) + 0x104)
> -#define  ASP_RX_FILTER_MDA_PAT_L(sel)		(((sel) * 0x14) + 0x108)
> -#define  ASP_RX_FILTER_MDA_MSK_H(sel)		(((sel) * 0x14) + 0x10c)
> -#define  ASP_RX_FILTER_MDA_MSK_L(sel)		(((sel) * 0x14) + 0x110)
>  #define  ASP_RX_FILTER_NET_CFG(sel)		(((sel) * 0xa04) + 0x400)
>  #define   ASP_RX_FILTER_NET_CFG_CH(sel)		((sel) << 0)
>  #define   ASP_RX_FILTER_NET_CFG_EN		BIT(9)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
