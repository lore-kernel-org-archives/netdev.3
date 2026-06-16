Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3F379EE4
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576470; cv=none; b=iMQoYth75lBmXbhmYwPT45eZKEQUr0pzxgMOK0thWFaPbUzRt2WT4igp/PLzD6ISP3l9xDzncoSJtpHS5EyT6XA3YZbrgQc2yy+Ihq2Z3nKYSCT+IggudCd1qsQh7/z0Zrqqd0pFMTLTyHPyBJZPmJ0uqz5guxIRaMZpH6Wl1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576470; c=relaxed/simple;
	bh=djO0ft+XrvrJoK1f7tXDZE4lm0hqmiWI78bfeN74K7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETNn/kQ7VZwcqG2o3G6gqi/IumyNFvgh5CnGzA2/OSD69kASFmqcvPMN+V/3xTB4feGhQ1JOB0TtdVx06Rmx0Elj7zo7aJfjSYvFwhaamq4toV9twf9Hr6ikWQvALvaZ0BA7BQ1IL+wuHBrsaKhiwkODs5NxROWdwgDnlnHikq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SruLL8qr; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SruLL8qr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781576465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgCBIIw/dfWAko3AMACm5KQHuWKcjQCJjJ8LFx83WEM=;
	b=SruLL8qrEJA6/iv9zghgEJciV1K8BBYx/I7WciaHir7G7ggAGhAvh2cFsleAwGG5RMQiCs
	JpR0PBAgGGq5V1NZEDYuzdNeWu4Wiz9gPm55xKjp96ZG4xbKUmGlpySxFyVDj1Bi4HqKUW
	udWaC6x8dsfzhhbtasv6Wo/+vTsuMTY=
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
	=?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	David Yang <mmyangfl@gmail.com>,
	netdev@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net] net: dsa: Fix skb ownership in taggers
Date: Tue, 16 Jun 2026 10:20:43 +0800
Message-ID: <20260616022043.684-1-qingfang.deng@linux.dev>
In-Reply-To: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16 Jun 2026 at 00:33:00 +0200, Linus Walleij wrote:
> diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
> index cf9420439054..23f032b76190 100644
> --- a/net/dsa/tag_brcm.c
> +++ b/net/dsa/tag_brcm.c
> @@ -102,10 +102,12 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
>  	 * (including FCS and tag) because the length verification is done after
>  	 * the Broadcom tag is stripped off the ingress packet.
>  	 *
> -	 * Let dsa_user_xmit() free the SKB
> +	 * Free the SKB on error.
>  	 */
> -	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_TAG_LEN, false))
> +	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_TAG_LEN, false)) {
> +		kfree_skb(skb);

There are multiple __skb_put_padto() calls in this patch, which can be
simplified to:

	if (skb_put_padto(skb, minlength))
		return NULL;

skb_put_padto() frees the skb on error.

Regards,
Qingfang
