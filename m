Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D22BFC7B;
	Tue,  1 Sep 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248298; cv=none; b=JpbAzRXxibUBfCW1xrREb25r/e+1E4J9WWlBC5PWFCt7FydBGeK7ORQyOlHTDx5bFa1PeUyGzU3IQf+QnDMi5vgxfCcfRNDVVQ0R4mVZL0LeTbveog3sWTl6Y7vc/+6wFayocmXTx0FkiYUgN6JVOv0PniaYlvNNPWw+hsx8clE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248298; c=relaxed/simple;
	bh=9spn0Zdq9ptjKE61Ukyr4tlyQHHboYJOftZRpwohZA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/TrmAFkoBe9BpiU7kqftXOtsm7/+6Y7kGyHucSUk0YV6bKB9mgvYDWfrsFO/iZdrtbWp3JVpmFS4oDN8B+fGhNnS3AWze2PKzwU5v8d2SHwmE1WHIYX/SHd2ZK1oiGT8Gm6XwLrUyRSpzwPgaas+wKwdSsLCE9BVTKe+Xi2iFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/B0TM+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/B0TM+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC01F000E9;
	Tue,  1 Sep 2026 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788248296;
	bh=kGJBTxI0BTFP9qYGYHlSLCXCQCO3O2EtQUjch3HFwi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/B0TM+qn7Bc6/87PafTXa00ztozqZNvsXgnr5Z5wdK0mUQIqViGzAQrquu4+Rlej
	 uNvdZTiee3n6L06Qr4N2t2tjJwiBekmH8OwLGpv1fs+wTjDO95HOt/mnrTCipEg9O0
	 TWtI8iHWAcy/Y9s7oTna14pTlQafb6rC7dYf0FmhddV1Mpj3SoM0d2a93UnUZwLmaf
	 zLZzKG6o0TBjLu26QbRbCbVU/aL9P5ath/gR5LkDMVzKL2CEz5B2XOB+jMY0CaiEl9
	 JrQJDQVMG32lCsan1QNse+jfkioI7kV8icktX+tBj2EGTTyBU+MxrUn4h26Bb9oavT
	 ls6sKrNtoP9mA==
Date: Tue, 1 Sep 2026 09:38:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: airoha: recover RX ring after hw
 completion stall
Message-ID: <apaA5jDYH71F0JaS@lore-desk>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
 <20260831234701.206021-1-sochnev.v.74@gmail.com>
 <20260831234701.206021-3-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AGYD2yEKCoEXZcmo"
Content-Disposition: inline
In-Reply-To: <20260831234701.206021-3-sochnev.v.74@gmail.com>

--AGYD2yEKCoEXZcmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On AN7583 hw can stop advancing the descriptor the sequential consumer in
> airoha_qdma_rx_process() is waiting on, while its own completion counter
> keeps moving. The ring is then dead: NAPI is scheduled, finds DONE clear
> at q->tail, and does nothing, forever.
>=20
> Observed directly on ring 4 at its 16-descriptor default (devmem, qdma0):
> REG_RX_CPU_IDX frozen at 15 for over an hour while REG_RX_DMA_IDX advanced
> 29 -> 96, with a 60-byte frame left stranded in the ring.
> QDMA_DESC_DROP_MASK was never set. In practice this is hit during PPPoE
> negotiation bursts on the shared "force to CPU" ring, where it stops the
> dial-up from ever completing.
>=20
> Detect it without trusting ring content: REG_RX_DMA_IDX is hw's own
> counter, independent of what sw posted. If it advances across polls while
> q->tail does not, hw is making progress the consumer cannot observe. Idle
> rings, where hw does not advance either, are left alone. An earlier
> version scanned the ring for a DONE descriptor and trusted its content;
> that OOMed once it reached uninitialised DMA memory that happened to have
> the bit set. A register cannot misfire that way.
>=20
> Recovery is deferred to a work item, since the register access can sleep.
> It drops what is in flight and re-arms the ring through the existing
> cleanup_rx_queue()/fill_rx_queue() pair, which only touch the sw-owned
> [tail, head) window and rewrite both indices from it. Trying instead to
> identify and keep the descriptor hw used caused a page_pool double free.
>=20
> GLOBAL_CFG_RX_DMA_EN_MASK is per-QDMA, not per-ring, so this briefly
> pauses every ring behind that instance; there is no per-ring equivalent.
> The measured pause is 986-1131 us over 13 recoveries, not the 50 ms
> read_poll_timeout() ceiling, so the logged value is worth having.
>=20
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 =
SoC")
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>

IIUC increasing the ring size the issue never occurs again (correct?). If s=
o, I
would drop this patch for the moment and add it if it is really necessary.

Regards,
Lorenzo

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 98 +++++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h |  8 ++
>  2 files changed, 105 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index c59201aded26..177a0e10e372 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -3,12 +3,14 @@
>   * Copyright (c) 2024 AIROHA Inc
>   * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>   */
> +#include <linux/ktime.h>
>  #include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/tcp.h>
>  #include <linux/u64_stats_sync.h>
> +#include <linux/workqueue.h>
>  #include <net/dst_metadata.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/pkt_cls.h>
> @@ -657,6 +659,34 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, stru=
ct airoha_qdma_desc *desc)
>  	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
>  }
> =20
> +#define AIROHA_RX_STALL_THRESHOLD	3
> +
> +/* REG_RX_DMA_IDX is hw's own completion counter, independent of what sw=
 has
> + * posted, so comparing it against q->tail spots the stall without trust=
ing
> + * ring content: if hw keeps advancing while the strictly sequential con=
sumer
> + * does not, it is completing descriptors that consumer can never reach.
> + */
> +static void airoha_qdma_rx_check_stall(struct airoha_queue *q)
> +{
> +	struct airoha_qdma *qdma =3D q->qdma;
> +	int qid =3D q - &qdma->q_rx[0];
> +	u32 dma_idx;
> +
> +	dma_idx =3D airoha_qdma_get(qdma, REG_RX_DMA_IDX(qid),
> +				  RX_RING_DMA_IDX_MASK);
> +
> +	if (q->stall_tail =3D=3D q->tail && dma_idx !=3D q->stall_dma_idx) {
> +		if (++q->stall_count >=3D AIROHA_RX_STALL_THRESHOLD &&
> +		    !test_and_set_bit(qid, qdma->rx_recover_mask))
> +			schedule_work(&qdma->rx_recover_work);
> +	} else {
> +		q->stall_count =3D 0;
> +	}
> +
> +	q->stall_tail =3D q->tail;
> +	q->stall_dma_idx =3D dma_idx;
> +}
> +
>  static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  {
>  	enum dma_data_direction dir =3D page_pool_get_dma_dir(q->page_pool);
> @@ -675,8 +705,10 @@ static int airoha_qdma_rx_process(struct airoha_queu=
e *q, int budget)
>  		struct page *page;
> =20
>  		desc_ctrl =3D le32_to_cpu(READ_ONCE(desc->ctrl));
> -		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
> +		if (!(desc_ctrl & QDMA_DESC_DONE_MASK)) {
> +			airoha_qdma_rx_check_stall(q);
>  			break;
> +		}
> =20
>  		dma_rmb();
> =20
> @@ -895,6 +927,56 @@ static void airoha_qdma_cleanup_rx_queue(struct airo=
ha_queue *q)
>  			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
>  }
> =20
> +static void airoha_qdma_rx_recover_work(struct work_struct *work)
> +{
> +	struct airoha_qdma *qdma =3D container_of(work, struct airoha_qdma,
> +						rx_recover_work);
> +	int qid;
> +
> +	for_each_set_bit(qid, qdma->rx_recover_mask, AIROHA_NUM_RX_RING) {
> +		struct airoha_queue *q =3D &qdma->q_rx[qid];
> +		ktime_t rx_dma_off_ts;
> +		s64 rx_dma_off_us;
> +		u32 status;
> +
> +		napi_disable(&q->napi);
> +
> +		/* per-QDMA, not per-ring: this pauses every RX ring behind
> +		 * this instance, hence the measured duration below
> +		 */
> +		rx_dma_off_ts =3D ktime_get();
> +		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
> +				  GLOBAL_CFG_RX_DMA_EN_MASK);
> +		if (read_poll_timeout(airoha_qdma_rr, status,
> +				      !(status & GLOBAL_CFG_RX_DMA_BUSY_MASK),
> +				      USEC_PER_MSEC, 50 * USEC_PER_MSEC, true,
> +				      qdma, REG_QDMA_GLOBAL_CFG))
> +			dev_warn(qdma->eth->dev,
> +				 "qid=3D%d RX DMA busy timeout during recovery\n",
> +				 qid);
> +
> +		airoha_qdma_cleanup_rx_queue(q);
> +		if (q->skb) {
> +			dev_kfree_skb(q->skb);
> +			q->skb =3D NULL;
> +		}
> +		airoha_qdma_fill_rx_queue(q);
> +
> +		airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
> +				GLOBAL_CFG_RX_DMA_EN_MASK);
> +		rx_dma_off_us =3D ktime_us_delta(ktime_get(), rx_dma_off_ts);
> +
> +		q->stall_count =3D 0;
> +		napi_enable(&q->napi);
> +		napi_schedule(&q->napi);
> +
> +		dev_warn_ratelimited(qdma->eth->dev,
> +				     "qid=3D%d RX ring recovered after hw stall (RX DMA paused %lld =
us)\n",
> +				     qid, rx_dma_off_us);
> +		clear_bit(qid, qdma->rx_recover_mask);
> +	}
> +}
> +
>  static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
>  {
>  	int i;
> @@ -1582,6 +1664,8 @@ static void airoha_qdma_cleanup(struct airoha_eth *=
eth,
>  {
>  	int i;
> =20
> +	cancel_work_sync(&qdma->rx_recover_work);
> +
>  	if (test_bit(DEV_STATE_INITIALIZED, &eth->state)) {
>  		u32 status;
> =20
> @@ -1639,6 +1723,13 @@ static int airoha_hw_init(struct platform_device *=
pdev,
>  	if (err)
>  		return err;
> =20
> +	/* init every instance up front: the error path below tears down all
> +	 * of eth->qdma[], including entries the init loop never reached
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
> +		INIT_WORK(&eth->qdma[i].rx_recover_work,
> +			  airoha_qdma_rx_recover_work);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++) {
>  		err =3D airoha_qdma_init(pdev, eth, &eth->qdma[i]);
>  		if (err)
> @@ -1687,6 +1778,11 @@ static void airoha_qdma_stop_napi(struct airoha_qd=
ma *qdma)
>  {
>  	int i;
> =20
> +	/* must not run or re-arm past this point: the work calls
> +	 * napi_disable() too, and doing that twice spins forever
> +	 */
> +	disable_work_sync(&qdma->rx_recover_work);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
>  		napi_disable(&qdma->q_tx_irq[i].napi);
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index fa9a8edce22f..c195dad5ed58 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -207,6 +207,11 @@ struct airoha_queue {
>  	bool txq_stopped;
>  	bool flushing;
> =20
> +	/* see airoha_qdma_rx_check_stall() */
> +	u32 stall_dma_idx;
> +	u16 stall_tail;
> +	u8 stall_count;
> +
>  	struct napi_struct napi;
>  	struct page_pool *page_pool;
>  	struct sk_buff *skb;
> @@ -567,6 +572,9 @@ struct airoha_qdma {
>  	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> =20
> +	struct work_struct rx_recover_work;
> +	DECLARE_BITMAP(rx_recover_mask, AIROHA_NUM_RX_RING);
> +
>  	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
>  };
> =20
> --=20
> 2.55.0
>=20

--AGYD2yEKCoEXZcmo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapaA5gAKCRA6cBh0uS2t
rL7jAP9qEM/opfNLRp7q5R6TRo2Ez9Nid+r3IAynC+NEWoZQ6QEA0fUQT4kWN7Qu
3xpi2zx+HAETBAl4w32vblKK7tzXeAY=
=ewuH
-----END PGP SIGNATURE-----

--AGYD2yEKCoEXZcmo--
