Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844094;
	b=EYWm/i9eu5ZYeiMgyonmV42c69vcWAeIlsHPL2xTw0FFnDnECHMEyuy9E7kALkQONYhF
	 GMDF+veoRTfdQUKXyKm3M9dLmSlzT7ENjV49U6y4ydIiJe5R7LImCDnKlGTPpBB0VKXtA
	 cxQDgC63ALUg6rA0IbB3C2RmAsIzKiQVT+KIgO3714wJxIpqhkr5+q8CzzgydIpw8JQSO
	 iyDxEDORGG+a63bX2ilSUlsUnigBc9vVLtjLANHFAAVGWS1OAU8dlEsfyeTcQm/Oqp/RI
	 Kt3A18l2kvmXMoPdQjZr13+Q2u7ZoCwpdrWZB6ucghc78NAty9is7/qRL+Y6ZgGzmsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844094;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ottpThceg5hJCKwYwOig+t32jGLSDNK6UuVyETsOj0w=;
	b=O5TNHoGdzpg/RamwGkJErRzDQ0WpWRiTYgKrDPdnoXDDQ4wW44sfq+xi87jDr51LrZYN
	 GSjsakYIjQM+C9jTCpHA5wqpT8HWdqrwkTRJIh6FeaB3GVT1ejcAkTMG08vGgzb1O/i0q
	 ihUrompX7ut+2X9bV36MtFTIp5H0ffLBn7EUffut0mjp8rqpiwveuwHWoDqEg1TecbQvl
	 JNnBPeSJsLIKmsR1DwyWLo6+Nd5Y5ugv3HKelKyVsFeLnCj2T76021YpAsQHTOijWpLWW
	 pjYZ4IQA9UJFAAAvxAKUrEWXbbMFr692E4vXor/EiLJptxyk/FSii8hor+Gj3aMM03w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeV2HGVz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5342C60A261F;
	Sat, 24 Oct 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IeV2HGVz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E441F031E6;
	Sat, 24 Oct 2026 12:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844094;
	bh=ottpThceg5hJCKwYwOig+t32jGLSDNK6UuVyETsOj0w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IeV2HGVzxStTpQB5FmYdScY3LiRqllUYDs3p5FkPZb+ARWeq1eb1eTDkHTnuvvIdN
	 ZTU4HNh0d7Zo4ZVJJNKLLQvNkBRCkPVlHrRG/f2VpeCz9isC5EKz1q11xQGDLtaHiV
	 ymGlHfOAB/bPzMCZQIoMoZw3wVZhL7QSOF96v2S9fYDNq8zkctNcPTK9Gs2tn9eZKL
	 pfvN/7ZOD9ygaPyzbbrXxhZyo9Uo3U/UJ/d/SWTH/fmJAmoEKP0oPJGfs43JzP0Hhe
	 Dzmjp2oj+cJDRkGPHcptagS5czVa6ao7VLLNyCnjSU/0c0k75VY7TXo5WDdLxSQstv
	 wNefLo4Dqz8ig==
Subject: Re: [PATCH net-next v4 6/7] net: ftgmac100: Add AST2700 upper DMA
 address support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
Date: Sat, 24 Oct 2026 12:14:52 +0000
Message-ID: <179284409298.3134.2544700895306550156@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-6-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-6-4d36b40939b3@aspeedtech.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The descriptor struct comments are now wrong.

--

net: ftgmac100: Add AST2700 upper DMA address support

This patch programs the high RX and TX descriptor ring base registers on
AST2700. It also stores DMA address bits 34:32 in bits 18:16 of txdes2 and
rxdes2, and requests a 35-bit DMA mask. All of the extended address
handling is gated by a new FTGMAC100_QUIRK_DMA_35BIT match-data quirk.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
> index 8c35c895b1465..0c244b1c0a351 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.h
> +++ b/drivers/net/ethernet/faraday/ftgmac100.h

[ ... ]

> @@ -226,6 +229,7 @@ struct ftgmac100_txdes {
>  #define FTGMAC100_TXDES1_TX2FIC		(1 << 30)
>  #define FTGMAC100_TXDES1_TXIC		(1 << 31)
>  
> +#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)

[Severity: Low]
This isn't a bug, but the descriptor struct comments just above this hunk
no longer match the new layout:

struct ftgmac100_txdes {
	__le32	txdes0; /* Control & status bits */
	__le32	txdes1; /* Irq, checksum and vlan control */
	__le32	txdes2; /* Reserved */
	__le32	txdes3; /* DMA buffer address */
} __attribute__ ((aligned(16)));

With FTGMAC100_QUIRK_DMA_35BIT set, ftgmac100_hard_start_xmit() now writes
buffer address bits 34:32 into txdes2 for both head and fragment
descriptors. ftgmac100_free_tx_packet() reads them back to rebuild the
unmap address, and txdes3 only holds the low 32 bits.

struct ftgmac100_rxdes has the same problem. rxdes3 is still described as
the full "DMA buffer address", and rxdes2 is only described as
"length/type on AST2500".

Could the comments for txdes2/txdes3 and rxdes2/rxdes3 be updated? It
might also help to note on the new GENMASK defines that they only apply
to the 35-bit (AST2700) layout. Otherwise a future descriptor writer or
reset path could treat txdes2 as reserved and drop the upper address
bits.

>  /*
>   * Receive descriptor, aligned to 16 bytes
>   */
> @@ -272,4 +276,6 @@ struct ftgmac100_rxdes {
>  #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
>  #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
>  
> +#define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
> +
>  #endif /* __FTGMAC100_H */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-support_ast2700-v4-0-4d36b40939b3%40aspeedtech.com
