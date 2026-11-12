Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484842;
	b=s9E5uiBJSfRZ9exHvUg63o7xsrGQxTM+vU+fshxZrZPl61BceXBthbl8ZCB33Ac+FhW3
	 1uq/72wyd1WbvRR6C/FyAX6CGEYyRidIKi5tmtRmu3qHC94LrtKg+DhrS+zCRuQaS/RG/
	 88jNF4cNAzIC0Ir1tvaZ7xnu/U06BG75O9CAeLAK3nsIqufK9loZzfMarxIpdW/n1NM+u
	 i5zvEc6LDax/4E35/IIs/k21wrGVbC9MPI/zw7v5lMeHAQvgbU5gurjQepgCQ04VzVX+Q
	 +hklBLxqPbJB7rW6Q4Fe9UFZPtsp/YHH55TZxxP7G5qZgbUDkmimkGyLevWoPrTmWvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484842;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IOcav2pGNy3lQm/PSqemR+GeEy0HZzX9o8Nsfel6XUU=;
	b=i7DEEPmqFwcv86UiGSfBJUBjnVpdK47EuyeFxoZ6IRpjRRKXtfkbPyrhGDEiwMSGbwYT
	 G9HvTAptMc0uUyHgtqy9JhVWOFl/Pl/9PnOReiD69GST74OihdQ5fvOOVIqc6pNdkptFc
	 0iSBmpCCQR7Mfah/ZP+aHvhwq3uFyYvtwXATVJ4ycPOeJB6OEUvXiX4mT6mjHKqqtRpxB
	 4pCiYKQtD/M+eOHkcYxEA+RkhARAhNvka2A5YkEyL9jSYRaDQHbwGe39fbLgeHA5AnxrO
	 o0jxvxP5QkqQeFD4FhVWpS8QhPqw8gt9JP5vVOUg4XzDMhtytVxLrjP0XREeLrHpGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh8Ez97S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D220606A334;
	Thu, 12 Nov 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wh8Ez97S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913CD1F00A0E;
	Thu, 12 Nov 2026 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484842;
	bh=IOcav2pGNy3lQm/PSqemR+GeEy0HZzX9o8Nsfel6XUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wh8Ez97SyplE1hdS6xGQqcW0vUz2ojKiNChkZlYVhSnZsX67HEx7QqHg/etqCu0fB
	 mbWsSfOjWc8Dnaym7foFhvq5VRLKcDBixhCmnTFF+5JKq81dDFYJDnotBYMOFLdklx
	 OVQRHp039bfGbCJTug31TErpyJzWo89FYyouubdTDMiVsw0euGnyH6abG/nBXzFvln
	 TCxUheytvVHDo0VCqwgK0W9Eo3TggBMZccDdMqjgtSwQGXKmHluW0TFxYxtXYmhsST
	 ZaExAugTlRaWMukf3pbBGbSVCjxgCl8+PE9A6zTKPQLLK/afzMZN1yn6x1lhoJP/Fy
	 WbiK2pZJ5veBw==
Subject: Re: [PATCH net-next v2 4/7] net: phy: adin1100: Add separate driver
 entries for ADIN1110/ADIN2111
From: netdev-bot+sashiko@kernel.org
To: iustin.stolniceanu@analog.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, parthiban.veerasooran@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, marcelo.schmitt@analog.com,
 alvin.sipraga@analog.com, ciprian.regus@analog.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 12:00:41 +0000
Message-ID: <179448484117.2199510.5313880396309449143@kernel.org>
In-Reply-To: <20261109085952.105331-5-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-5-iustin.stolniceanu@analog.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message for "net: phy: adin1100: Add separate
  driver entries for ADIN1110/ADIN2111" says the patch is "not a…

--

net: phy: adin1100: Add separate driver entries for ADIN1110/ADIN2111

This patch splits the single adin_driver[] entry into three entries, one
each for ADIN1100, ADIN1110 and ADIN2111. The old entry used a 0xffffffcf
mask to match all three parts. Each new entry uses PHY_ID_MATCH_MODEL(),
as the mdio_device_id table already does, and keeps the same callbacks.

> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
> index 8f9753d4318c8..b946cb86b6c41 100644
> --- a/drivers/net/phy/adin1100.c
> +++ b/drivers/net/phy/adin1100.c
> @@ -322,8 +322,7 @@ static int adin_probe(struct phy_device *phydev)
>  
>  static struct phy_driver adin_driver[] = {
>  	{
> -		.phy_id			= PHY_ID_ADIN1100,
> -		.phy_id_mask		= 0xffffffcf,
> +		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1100),

[Severity: Medium]
The commit message says:

  The callbacks are unchanged, so this is not a functional change apart
  from the reported driver name.

Doesn't this change also alter which PHY IDs bind to the driver?

The old entry used PHY_ID_ADIN1100 (0x0283bc81) with a 0xffffffcf mask.
That mask ignores bits [5:4] but keeps the revision bits [3:0]. So
phy_bus_match()->genphy_match_phy_device() only matched these four IDs,
all with revision 1:

  0x0283bc81, 0x0283bc91, 0x0283bca1, 0x0283bcb1

PHY_ID_MATCH_MODEL() uses PHY_ID_MATCH_MODEL_MASK from
include/linux/phy.h:

  #define PHY_ID_MATCH_MODEL_MASK GENMASK(31, 4)

That mask ignores the revision nibble completely. After this patch:

- Every silicon revision of models 0x8, 0x9 and 0xa binds to the ADIN
  driver. Before, any revision other than 1 fell back to the generic PHY
  driver.

- 0x0283bcb1 (model 0xb) was accepted by the old mask, but no new entry
  matches it.

The 0xffffffcf mask came from commit 875b718ac380 ("net: phy: adin1100:
add PHY IDs of adin1110/adin2111"). That commit replaced a
revision-agnostic PHY_ID_MATCH_MODEL(PHY_ID_ADIN1100) entry, and adin_tbl
stayed revision-agnostic. This patch partly reverts that narrowing.

Could the commit message describe the change in revision matching? It
would also help to say whether the change is a deliberate fix, perhaps
with a Fixes: tag for 875b718ac380, or a side effect.

The later patches in the series keep PHY_ID_MATCH_MODEL(), so this
difference is still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109085952.105331-1-iustin.stolniceanu%40analog.com
