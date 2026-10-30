Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359709;
	b=jz1KGICXBBMwyopcggjVsk06rdWww94HfGZlXPPnVrUjSE/wnhl9e5ysMujbVhfN1j6/
	 0sED/9OMjwX0ScOEf10Y3cCwg3Lqg2hQTrVqtms2F/ZZbH1t2bUN8rMnPGAdqA+NbsXBW
	 X0cBZvIVri7xNk+PBUvviOT4SOE5oo37K225g5bnCTiZJjrHmlPxaK3NGDlUa6WruQakP
	 HhI/ufCOgLx8U/O9kgEEYgKyF+e2KG0LJMeOQnUzVVy8HufxI6X6QlYAElmlZg1q0iit6
	 5yoeuAtOSM4N1kcRTtUaAtNGrHU0VxWZsz9DpKfkz+IkBND+NxoHkAkjfDRX+cfTBZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359709;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l8tFIArwNBGpXF7b0HkWXv0ehLQYJslCMdryKQuEUhA=;
	b=pUnojFBw2pvwUWfXXk/UuBMLkLO644P1YpAearaEC8XYe1CWIcQqB7pBOaL8sD8mrP7y
	 wPl4BsqwjdC9XoGG9/OGj14Xm1GfNfMn0HBsplHoMsxQhm5pNBLr7Mn7iQdwUCgkmGKs7
	 zIQxwYgTbUFxWz136hSvEIRTN3PIKeGYzvHdcLJw+Tw+6wfZkIgPILP6uwrvdLjMnIBKT
	 usjSGqtTtnu2r8flUBulH19jVXt8C3hENNHMKbeZU8yZ1DgJO4BB6U1TjmMGHBtDyBqYE
	 +9/brZnVNIU4J//LWW357cC9ImxlTB7W5frs2CDXXWairHulsGBN5Y6kv14TkGhMg6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db0Nz+TR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC44606A322
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db0Nz+TR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1001E1F000C1;
	Fri, 30 Oct 2026 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359709;
	bh=l8tFIArwNBGpXF7b0HkWXv0ehLQYJslCMdryKQuEUhA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Db0Nz+TRAC3hAzuoOWUrcW0bxXKON8NbOCeovZr7Ix348rhycey4eZxZMsLTZLLG4
	 GqwzLBHrpqW3auBpDAMUtQBeKJ+JETKkQXcZbbotKtLr2iENjIMmxm1PU+cXhC1ufC
	 /MtMW9+TBECN1j9TwIAxPFOcJlW9evOz2jMEvLB6sXHPjQKxQj4Kim/9n2W9j0GvOn
	 T/nSXJBR8Ela5izb843e9l6bjJdk5vpk5P1NfTKNuNIFPdeFiTGqmR8zD/VdIUrdiu
	 GJ5BjLhVweLsu3pkQ/BNjCUTwDrWeAwne9NCbru8K8gETdOSu5RZkkiJdSEdumIkl7
	 Ivl+dbUGMPYpQ==
Subject: Re: [PATCH net v3 2/2] net: dsa: mxl862xx: validate the bridge id
 returned by BRIDGE_ALLOC
From: netdev-bot+sashiko@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, johan@kernel.org, kuba@kernel.org,
 pabeni@redhat.com
Date: Fri, 30 Oct 2026 11:28:28 +0000
Message-ID: <179335970863.3134.5191378244494717635@kernel.org>
In-Reply-To: <tencent_F5633A48A97A7D712B7DB98CE1950213C805@qq.com>
References: <tencent_F5633A48A97A7D712B7DB98CE1950213C805@qq.com>
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

- [Medium] In mxl862xx_allocate_bridge()
  (drivers/net/dsa/mxl862xx/mxl862xx.c), a positive firmware command…

--

net: dsa: mxl862xx: validate the bridge id returned by BRIDGE_ALLOC

This patch makes mxl862xx_allocate_bridge() reject a firmware-supplied
bridge id that is 0, is 0xffff, or is already in use in priv->bridges[]
or priv->ports[].fid. It guards against firmware that does not follow the
API and would otherwise break FID isolation between domains.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 37e8c18f14f33..d8d58f280d358 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

>  static int mxl862xx_allocate_bridge(struct mxl862xx_priv *priv)
>  {
>  	struct mxl862xx_bridge_alloc br_alloc = {};
> +	u16 id;
>  	int ret;
>  
>  	ret = MXL862XX_API_READ(priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
>  	if (ret)
>  		return ret;

[Severity: Medium]
Can a positive firmware result get past all of the new checks here?

The transport layer decodes the firmware result as a signed 11-bit value
in mxl862xx_crc6_verify():

	*result = sign_extend32((len_ret & LEN_RET_LEN_MASK) |
				((ctrl & CTRL_CRC_FLAG) >> 4), 10);

The kernel-doc for mxl862xx_issue_cmd() says it returns a "firmware result
value (>= 0) on success". mxl862xx_send_cmd() only remaps negative values,
and mxl862xx_api_wrap() returns cmd_ret after a successful read. So a
CRC-valid status from 1 to 1023 comes back unchanged from
MXL862XX_API_READ().

In that case, if (ret) return ret; returns the status itself before
br_alloc.bridge_id is examined. Both callers only check for ret < 0:

mxl862xx_port_bridge_join():
	ret = mxl862xx_allocate_bridge(priv);
	if (ret < 0)
		return ret;

	priv->bridges[bridge.num] = ret;

mxl862xx_port_setup():
	ret = mxl862xx_allocate_bridge(priv);
	if (ret < 0) {
		...
	}
	priv->ports[port].fid = ret;

If the firmware returns a status of 1 while FID 1 is already stored in
priv->bridges[] or priv->ports[].fid, wouldn't 1 be recorded as a newly
allocated FID without ever going through mxl862xx_bridge_id_in_use()? The
firmware bridge actually allocated in br_alloc.bridge_id would also be
leaked.

That looks like the same duplicate-FID problem the patch is meant to
close, caused by the same kind of non-conforming firmware.

Would it make sense to also treat a positive status as an error before
validating the payload id, for example:

	if (ret < 0)
		return ret;
	if (ret)
		return -EIO;

>  
> -	return le16_to_cpu(br_alloc.bridge_id);
> +	id = le16_to_cpu(br_alloc.bridge_id);
> +

[ ... ]

> +	if (!id || id == 0xffff || mxl862xx_bridge_id_in_use(priv, id))
> +		return -EIO;
> +
> +	return id;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_1AD6B5B7C296D319F828A281A2A65B95D609%40qq.com
