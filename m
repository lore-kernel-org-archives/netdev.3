Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC7285C91
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662988; cv=none; b=LcyViJ8tMfJbo4oiT2bVvCd5t1Iu+yrIEYm8o9A/1xkEL2k7Ri/x6lmWVJSjhcjnQ4xwVRXVy3/Npqgi1wGukixTdF3kMhOPgAVItScvcpWk0Y/orOpTdlQ84PUeUDShB8OfTWbsOAI4bp329AjjjcfrxsMGoqCgmO4YoJIt45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662988; c=relaxed/simple;
	bh=onVULGk+R01lkgCQNR3Xb0v33frHa2V4MZlgLjlm81I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEDURNkTJ10x0mxC+jlvjKknIR7Egi8KbYlHp+v8zkVgw6pV/3Ojez/vBW4bbkU1RfaFhCQD/gg8b1IqUqeiRQJB5IJiKbXwJA7M0XZK/5aZ1F7MXAhp3X18TzpbFe4g6OxRc2BAm9rAhPPPeb6asz6LGZsroVGgWsV4aBKN9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7HqYxe2; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K7HqYxe2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781662984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK7DoZ1P9MNR1dJ3nH31NXwYy61BizuMZoLyrKupyVM=;
	b=K7HqYxe2C40Ldxxa51FWDmb6f4Qsh9rE9PEfrItemYy4VuYD1wHr0S3bD+Ab+z+/OexN3/
	KptDLVTcMbO8vQ27g1PyXfa9GeGrPupWTKuGRSZfQKjtMrKeJOV3UYpLHsNEzjxlWSGnGa
	nJQR+WO5kFBo8YSJtzLfskdb/9wkMaU=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	David Yang <mmyangfl@gmail.com>,
	netdev@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
Date: Wed, 17 Jun 2026 10:22:47 +0800
Message-ID: <20260617022248.1500-1-qingfang.deng@linux.dev>
In-Reply-To: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16 Jun 2026 at 11:36:22 +0200, Linus Walleij wrote:
> --- a/net/dsa/tag_rtl4_a.c
> +++ b/net/dsa/tag_rtl4_a.c
> @@ -41,8 +41,10 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
>  	u16 out;
>  
>  	/* Pad out to at least 60 bytes */
> -	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
> +	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false))) {
> +		kfree_skb(skb);
>  		return NULL;
> +	}

This can be simplified to eth_skb_pad().

>  
>  	netdev_dbg(dev, "add realtek tag to package to port %d\n",
>  		   dp->index);
> --- a/net/dsa/tag_rzn1_a5psw.c
> +++ b/net/dsa/tag_rzn1_a5psw.c
> @@ -48,7 +48,7 @@ static struct sk_buff *a5psw_tag_xmit(struct sk_buff *skb, struct net_device *de
>  	 * least 60 bytes otherwise they will be discarded when they enter the
>  	 * switch port logic.
>  	 */
> -	if (__skb_put_padto(skb, ETH_ZLEN, false))
> +	if (skb_put_padto(skb, ETH_ZLEN))
>  		return NULL;

Same here.

>  
>  	/* provide 'A5PSW_TAG_LEN' bytes additional space */

- Qingfang
