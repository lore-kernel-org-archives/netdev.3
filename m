Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E33EC830;
	Tue, 13 Oct 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883160; cv=none; b=bXvmcZZvamCeAtmEpJpZVGmfVSpoLTZ/5jeuvHah6teCbNlrYkbYbC714cvmoYI7ao1W/7/rDbphnc5JxZu6D6huonmvMTCKGSvft51vAwF/wfBf1+D6E7+UJmCXsQ4u23QKTIFpVmiiGpncAA7v2pttbA7ex2JY6/YZ+S8ytxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883160; c=relaxed/simple;
	bh=hlkQEar8kCKagIwEA+jFKkHHe7XnB4Tf0+Vmm/f0kQc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgYERi4PF+cVAd3gwQjwndscJTL6KtidnrOdiEaKuigGvY194e/WqdJ36EnzTUNnaksurS3pBsB/OUf0zGtvafw8Xzas1niYJjqU1TECP/5x66Kd3ua1LXJu/k/AG6dbqam6AYz8/L9GvBLoFMC4PAwrrHyWFXFN5ktTQpT9YwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoDLsv5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoDLsv5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85341F000FF;
	Tue, 13 Oct 2026 09:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883159;
	bh=mnKkhlIzvLpDvTXadcEWjvt+AGu+BFFEbSRjFhENpLc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KoDLsv5l49j2VkvlNANH1Afuu/sqxtPjuVgncObBCjrr1AKZ3X/hhi3zgFkJMQbKn
	 RUWQjHc8EjOXauRfe7D/o6avXvJL4TTPnWnv2i4IJ6uUvcosWDPMAjEMhWBwmuCswL
	 KXaJk/im4z5wGuxu2xRPofuVzrEm7e/lrltm0BnaAbAz9fy+53UcTuFc8XW9eZgceE
	 81F6jyxHJFnfq5qgYCgruHYTu/i4fil1vYE1ghHbp6N7UyQXKK2T4+Kp1BK+k2fRtC
	 tV7e/Y48F83ZIRAjXiVAsFNXYhdjamgJuEkaS8tXc6WWEqI3HiuW05yK7/scdGt7oM
	 WD2+MgVB0zhcA==
Subject: Re: [PATCH net-next v4 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Tue, 13 Oct 2026 09:19:18 +0000
Message-ID: <179188315834.434549.15474079506864718007@kernel.org>
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-6-2e2e3bfaf8cc@tipi-net.de>
References: <20261012-nb-genet-mtu-nn-v2-v4-6-2e2e3bfaf8cc@tipi-net.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new field tx_thld_len is used only on transmit: it is set in
  bcmgenet_set_mtu_regs() and read in bcmgenet_xmit().

--

net: bcmgenet: pad transmit frames out of the packet ready window

The commit programs a transmit packet ready threshold that depends on the
MTU. Frames that land just past that threshold are padded so they no
longer stall the transmitter. A frame longer than the threshold gets its
checksum computed in software, and the skb is unshared before either path
writes to it.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 28395cb72fb60..7703e1fb73b6c 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -624,6 +624,7 @@ struct bcmgenet_priv {
>  	struct enet_cb *rx_cbs;
>  	unsigned int num_rx_bds;
>  	unsigned int rx_buf_len;
> +	unsigned int tx_thld_len;

[Severity: Low]
This isn't a bug, but tx_thld_len only matters on transmit. It is set in
bcmgenet_set_mtu_regs() and read in bcmgenet_xmit().

In struct bcmgenet_priv it sits under the "/* receive variables */" comment,
next to rx_buf_len:

	/* receive variables */
	void __iomem *rx_bds;
	struct enet_cb *rx_cbs;
	unsigned int num_rx_bds;
	unsigned int rx_buf_len;
	unsigned int tx_thld_len;

Could it go under the "/* transmit variables */" block with num_tx_bds?

>  	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
>  	struct list_head rxnfc_list;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc%40tipi-net.de
