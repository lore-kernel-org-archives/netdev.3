Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D0636F913;
	Tue, 12 May 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617911; cv=none; b=TgFj0GIOoTaVh6nSOf6AMjKF3AahtFo56J0UjRsxoAlVnW2GjbtcNtsP7r9XctAXC+dxIuSQe0Q3+hjk0Z+FP9k93DPZ/5Tu452l7+rrmAZM5oqwyiPHZ6IAEUa2Ig0ILyMCYlSFkCDoemUxtqKx82TD00z3xM8VzcrowFkY+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617911; c=relaxed/simple;
	bh=V71zFNi7F3e+R7/dBjLOtPApPvnjD2YIfhm5M85nDfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed7s/Ye2xeb9fU9A5KhAeezj9UOYd94TTAnjYOVPHOX3WxE84B7+z3C8uTcDJlgqljbhrvVgFtySUjcs+N5bqlJbjRya+ixbrZO9p53NSWFlW1pCHGC0RuAsRSKm2VUnAUBqAB3vMiep+KoUDr7fAM9RJfKrGjhF+4s/KClFKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCTu3Y1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCTu3Y1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BDEC2BCB0;
	Tue, 12 May 2026 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778617911;
	bh=V71zFNi7F3e+R7/dBjLOtPApPvnjD2YIfhm5M85nDfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCTu3Y1eda32Ya+9Wq+DNFrfDSFhyBHnhYZDkhrFzkDZzP8KhCBfb7GjDMmH1eqm9
	 c6Dyi97gHPT/Ok5rD6wRxsJfbe9+rscxhD8GuEhuqJijVV1YYB6vswuXoZ2jw3J8qc
	 cKIOCosZ4diJV62XkJXa08orZaR7Bdi3QIzr2DXPRLVwZFAfHIbV7qlrapF1bzOrkK
	 jVCY0rc7fwVjh5QbPhrQbcDtUqBZzAc/fP10rIadEsBf7cTxssxLd+Y2Dm7Gy/Uj50
	 s7+RzykdBuVc2WyE7YR2sd6ivAEikSnwwYiksX35yJNrdv39q7gEefCzhNnhbPxoML
	 k07u/vEgagQBw==
Date: Tue, 12 May 2026 22:31:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Xuegang Lu <xuegang.lu@airoha.com>
Subject: Re: [PATCH net-next v6 02/12] net: airoha: Reserve RX headroom to
 avoid skb reallocation
Message-ID: <agOONOLeIVbErlXD@lore-desk>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-2-c899462c4f75@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TR0CKm29FXXTLKXr"
Content-Disposition: inline
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-2-c899462c4f75@kernel.org>


--TR0CKm29FXXTLKXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 11, Lorenzo Bianconi wrote:
> Reserve NET_SKB_PAD + NET_IP_ALIGN bytes of headroom for received packets
> to avoid skb head reallocation when pushing protocol headers into the skb.
>=20
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 12 ++++++++----
>  drivers/net/ethernet/airoha/airoha_eth.h |  2 ++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index f71fb18197ec..3fe2561c85f1 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -543,9 +543,10 @@ static int airoha_qdma_fill_rx_queue(struct airoha_q=
ueue *q)
>  		q->queued++;
>  		nframes++;
> =20
> +		offset +=3D AIROHA_RX_HEADROOM;
>  		e->buf =3D page_address(page) + offset;
>  		e->dma_addr =3D page_pool_get_dma_addr(page) + offset;
> -		e->dma_len =3D SKB_WITH_OVERHEAD(q->buf_size);
> +		e->dma_len =3D SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
> =20
>  		val =3D FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
>  		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
> @@ -616,8 +617,9 @@ static int airoha_qdma_rx_process(struct airoha_queue=
 *q, int budget)
> =20
>  		page =3D virt_to_head_page(e->buf);
>  		len =3D FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
> -		data_len =3D q->skb ? q->buf_size
> -				  : SKB_WITH_OVERHEAD(q->buf_size);
> +		data_len =3D q->skb
> +			   ? AIROHA_RX_LEN(q->buf_size)
> +			   : SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
>  		if (!len || data_len < len)
>  			goto free_frag;
> =20
> @@ -627,10 +629,12 @@ static int airoha_qdma_rx_process(struct airoha_que=
ue *q, int budget)
> =20
>  		port =3D eth->ports[p];
>  		if (!q->skb) { /* first buffer */
> -			q->skb =3D napi_build_skb(e->buf, q->buf_size);
> +			q->skb =3D napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
> +						q->buf_size);
>  			if (!q->skb)
>  				goto free_frag;
> =20
> +			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
>  			__skb_put(q->skb, len);
>  			skb_mark_for_recycle(q->skb);
>  			q->skb->dev =3D port->dev;
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 58530d096de7..d3781103abb5 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -32,6 +32,8 @@
>  #define AIROHA_FE_MC_MAX_VLAN_TABLE	64
>  #define AIROHA_FE_MC_MAX_VLAN_PORT	16
>  #define AIROHA_NUM_TX_IRQ		2
> +#define AIROHA_RX_HEADROOM		(NET_SKB_PAD + NET_IP_ALIGN)
> +#define AIROHA_RX_LEN(_n)		((_n) - AIROHA_RX_HEADROOM)
>  #define HW_DSCP_NUM			2048
>  #define IRQ_QUEUE_LEN(_n)		((_n) ? 1024 : 2048)
>  #define TX_DSCP_NUM			1024
>=20
> --=20
> 2.54.0
>=20

commenting on sashiko's report:
https://sashiko.dev/#/patchset/20260511-airoha-eth-multi-serdes-v6-0-c89946=
2c4f75%40kernel.org

- Does the length passed to dma_sync_single_for_cpu() also need to be updat=
ed
  to match the new DMA length?
  I will fix it in v7.

Regards,
Lorenzo

--TR0CKm29FXXTLKXr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagOONAAKCRA6cBh0uS2t
rKGaAQDJBFUqVKCNJOmGIhF2q0V3siWnJZZJ0yQN3UeaMOX2dQD/Ub3cCxWe1pCg
P1grqoWgyEKmfQ6xFJ6PGy4FF1zA+AA=
=57t/
-----END PGP SIGNATURE-----

--TR0CKm29FXXTLKXr--
