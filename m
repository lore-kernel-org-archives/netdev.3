Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79B359A70;
	Sun, 30 Aug 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099524; cv=none; b=vAmif2A0iszv0SS3fGR4JhbvfpiaeSyO25W8a9bF4M4RQy9Z0N6hG+N/pe5HJerZM5EWmAQX26NoorNMv49iwFdUx1pV+fBX0hNfVg+ZuK5+atDWEXlu+rpDX4HYk2JYHbVBw2K2yPxf1ud3pcETj2n/0uPMvHOzRVxhWHr8IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099524; c=relaxed/simple;
	bh=Pwft9ceAsdmSZpBs8KKETG2flHaE6OFVldA/aoRhsGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFvd8PrXeg3Nm/yY0FedQdRhn/h9fVxImzVMKLGB+I39ete5+gpJMyrcAwxW5F79NwDpmH/DlGp26xOXdHALCZm8kSl3PhqDv8/wiHAXJbEvyXQhCNqad2x6Aa5FdajhuaBxYEHKL5HXemydRZVQt3EGWIfcQxT4xEAc33v+dos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0E8dMS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0E8dMS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24171F000E9;
	Sun, 30 Aug 2026 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788099519;
	bh=EyRJWneXyGST5ftP91P38n8abGQ5FCWVH0jmO1LnEDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e0E8dMS4Bxx6ZoP1O3xpp7VtU1HVbsm3pXL5H62mIMvGZVmmhsi255/YotUwYh8a/
	 PobwEwgtzrZ+XE3GPw+qpNaK+95ghSPbJ82a3nu3UdnXDCRqkYsYnZhYm1pNMoOjQH
	 +ro9qZfKxx7ALxL5UgPdf48y5FQVwj+lXAMOYsZ1Jil5LrAHhhdzQ5m3qoE/VqhvHk
	 1njeI9nsbngmX2XPt+mI8/6VVMuX/m29Py2f2Q9N9oL8cDiiAm4hPFZ7uS90Cm1kO/
	 8QxZs5RfoBFnwD1lg9S2YZHFZ8lpd/Za9W/7qo0MNmq6o0FuEXTy63IGbrjrj5IUq3
	 B1dU8EO/xgMsA==
Date: Sun, 30 Aug 2026 16:18:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: airoha: recover RX ring after hw
 completion race
Message-ID: <apQ7vXZHiK5qZOcc@lore-desk>
References: <20260830095717.37218-1-sochnev.v.74@gmail.com>
 <20260830095717.37218-3-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y1Nj6AZQ3riJKCr8"
Content-Disposition: inline
In-Reply-To: <20260830095717.37218-3-sochnev.v.74@gmail.com>

--y1Nj6AZQ3riJKCr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vitaliy,

this patch targets net-next tree that is closed at the moment for the merge
window.

> On AN7583, hardware can write a completed RX descriptor past the
> software-posted boundary (q->head) before airoha_qdma_fill_rx_queue()
> has actually posted a fresh buffer there, as if hardware advances its
> own completion pointer independently of software's posting
> bookkeeping. Since airoha_qdma_rx_process() consumes the ring strictly
> sequentially starting at q->tail, the consumer stalls forever waiting
> on a descriptor that hardware never writes, even though real,
> completed frames are sitting further along in the ring. In practice
> this is reachable during PPPoE/DHCP negotiation bursts on the small
> shared "force to CPU" ring, and the interface silently stops receiving
> on it.

I guess we should spend more time understanding if we can avoid the problem
instead of adding a recover mechanism.
IIUC the practical problem stems from the small size of this RX queue where
the airoha_qdma_fill_rx_queue() processing overwrites the RX descriptor DONE
bit written by the hw. Is my understanding correct? If so:
- Have you tried to just increase the queue size to check if the issue still
  occurs?
- Can we check QDMA_DESC_DONE_MASK bit in airoha_qdma_fill_rx_queue() and in
  some way bail out if it is still set? (we should probably need to clear i=
t in
  airoha_qdma_rx_process()).
- Is QDMA_DESC_DROP_MASK bit set when the issue occurs?

>=20
> Detect this without inspecting ring/descriptor memory content at all:
> REG_RX_DMA_IDX is hardware's own completion counter, independent of
> what has or hasn't been posted. If it keeps advancing across polls
> while the software consumer (tail) does not move, hardware is making
> progress the consumer can never observe - the ring is stuck. Idle
> rings, where hardware isn't advancing either, are correctly left
> alone. An earlier version of this recovery instead scanned ahead in
> the ring for a DONE descriptor and trusted its content; that caused a
> real OOM panic once it wandered into genuinely uninitialized DMA
> memory that coincidentally had the DONE bit set. Comparing a hardware
> register cannot misfire that way.
>=20
> Once a stall is confirmed, defer to a work item (register access here
> can sleep) that disables RX DMA, waits for it to actually go idle,
> resyncs the ring via the existing cleanup_rx_queue()/fill_rx_queue()
> pair - which only ever touches the software-owned [tail, head) window
> and rewrites both RX_CPU_IDX and RX_DMA_IDX from it - and re-enables
> RX DMA. This deliberately drops whatever was in flight on the ring
> rather than trying to identify and preserve the specific descriptor
> hardware used; a prior attempt at the latter caused a page_pool
> double-free when the assumptions about which page was safe to free
> turned out not to hold in all cases.
>=20
> GLOBAL_CFG_RX_DMA_EN_MASK in REG_QDMA_GLOBAL_CFG is per-QDMA-instance,
> not per-ring, so recovering one ring briefly pauses RX DMA on every
> ring behind that QDMA (bounded by the 50ms busy-wait below). No
> per-ring equivalent exists in the register map; this is the same bit
> airoha_qdma_start()/stop() already use for whole-device up/down. Log
> the actual measured duration of that pause alongside the recovery
> message, rather than just citing the 50ms read_poll_timeout() upper
> bound: that's the real cost paid by every other ring on the same QDMA
> instance each time recovery fires, and it's worth having the real
> number instead of the theoretical ceiling.

We should try to avoid it

>=20
> One cost worth calling out explicitly: airoha_qdma_rx_check_stall()
> adds an uncached MMIO read of RX_DMA_IDX on the RX path, once per
> airoha_qdma_rx_process() call that ends via the non-DONE break - i.e.
> essentially every poll, on every ring, even though the condition it
> detects is rare and specific to one ring. Gating the read on whether
> the *previous* poll for this ring also reaped zero descriptors would
> keep it off rings that are actively receiving, and I traced that
> through for correctness: once the race actually happens, q->tail
> freezes permanently (consumption here is strictly sequential), so
> `done` is 0 on every poll after that point, not just some - the gate
> would only cost about one extra poll before AIROHA_RX_STALL_THRESHOLD
> is reached, not a suppression or false-negative risk. I haven't
> implemented that gating here for lack of profiling data justifying the
> added per-queue state against the (also unmeasured) cost of the
> current unconditional read; happy to add it if it turns out to matter
> in practice.
>=20
> Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 135 ++++++++++++++++++++++-
>  drivers/net/ethernet/airoha/airoha_eth.h |  16 +++
>  2 files changed, 150 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index a3e5aaeb75b3..b53fe5b17653 100644
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
> @@ -657,6 +659,47 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, stru=
ct airoha_qdma_desc *desc)
>  	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
>  }
> =20
> +/* number of consecutive polls where hw completion (RX_DMA_IDX) advances
> + * while the sw consumer (tail) doesn't, before declaring the ring stuck
> + */
> +#define AIROHA_RX_STALL_THRESHOLD	3
> +
> +/* Detect an RX ring where hw's own completion pointer (RX_DMA_IDX) keeps
> + * moving while the sw consumer (q->tail) doesn't - i.e. hw has written
> + * further descriptors somewhere in the ring, but the strictly sequential
> + * consumer can never reach them because the one at q->head, which it is
> + * waiting on, was never marked DONE. This happens when hw writes a
> + * completed descriptor past q->head before airoha_qdma_fill_rx_queue()
> + * has posted a fresh buffer there, decoupled from sw's own posting
> + * bookkeeping.
> + *
> + * Deliberately does not inspect ring/descriptor memory content to detect
> + * this: an earlier version scanned ahead for a DONE descriptor and trus=
ted
> + * its content, which caused a real OOM panic after it wandered into
> + * genuinely uninitialized DMA memory that coincidentally had the DONE b=
it
> + * set. RX_DMA_IDX is a hw register with a well-defined value regardless=
 of
> + * ring content, so this can't misfire on garbage memory, and idle rings
> + * (no hw progress either) are naturally left alone.
> + */
> +static void airoha_qdma_rx_check_stall(struct airoha_queue *q)
> +{
> +	struct airoha_qdma *qdma =3D q->qdma;
> +	int qid =3D q - &qdma->q_rx[0];
> +	u32 dma_idx =3D airoha_qdma_get(qdma, REG_RX_DMA_IDX(qid),
> +				      RX_RING_DMA_IDX_MASK);

Can you please respect the RCT code style?

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
> @@ -675,8 +718,10 @@ static int airoha_qdma_rx_process(struct airoha_queu=
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
> @@ -894,6 +939,75 @@ static void airoha_qdma_cleanup_rx_queue(struct airo=
ha_queue *q)
>  			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->tail));
>  }
> =20
> +static void airoha_qdma_rx_recover_work(struct work_struct *work)
> +{
> +	struct airoha_qdma *qdma =3D container_of(work, struct airoha_qdma,
> +						 rx_recover_work);
> +	int qid;
> +
> +	for_each_set_bit(qid, qdma->rx_recover_mask, AIROHA_NUM_RX_RING) {
> +		struct airoha_queue *q =3D &qdma->q_rx[qid];
> +		ktime_t rx_dma_off_ts;
> +		s64 rx_dma_off_us;
> +		u32 status;
> +
> +		if (!q->ndesc)
> +			goto next;

Can this really occurs?

> +
> +		napi_disable(&q->napi);
> +
> +		/* GLOBAL_CFG_RX_DMA_EN_MASK is per-QDMA, not per-ring, so
> +		 * this pauses every RX ring on this QDMA instance, not just
> +		 * the stalled one - track how long for, since that's the
> +		 * real-world cost of recovery on unrelated rings.
> +		 */
> +		rx_dma_off_ts =3D ktime_get();
> +
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
> +		/* Drop whatever is currently in flight on this ring and
> +		 * re-arm it from a known-clean state. cleanup_rx_queue()
> +		 * only ever touches the sw-owned [tail, head) window and
> +		 * resyncs both RX_CPU_IDX and RX_DMA_IDX to it, which is
> +		 * what un-wedges a ring where hw wrote past the sw head
> +		 * without the consumer ever advancing - no need to figure
> +		 * out which descriptor hw actually used.
> +		 */
> +		airoha_qdma_cleanup_rx_queue(q);
> +		if (q->skb) {
> +			/* discard whatever scatter-gather frame was
> +			 * mid-assembly when the stall was hit, cleanup_rx_queue()
> +			 * above only resyncs the ring, not this
> +			 */
> +			dev_kfree_skb(q->skb);
> +			q->skb =3D NULL;
> +		}
> +		airoha_qdma_fill_rx_queue(q);
> +
> +		airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
> +				GLOBAL_CFG_RX_DMA_EN_MASK);
> +		rx_dma_off_us =3D ktime_us_delta(ktime_get(), rx_dma_off_ts);

Is this delta time really meaningful or is it just for debugging?

> +
> +		q->stall_count =3D 0;
> +		napi_enable(&q->napi);
> +		napi_schedule(&q->napi);
> +
> +		dev_warn_ratelimited(qdma->eth->dev,
> +				     "qid=3D%d RX ring recovered after hw stall (RX DMA paused for %=
lld us on this QDMA instance)\n",
> +				     qid, rx_dma_off_us);
> +next:
> +		clear_bit(qid, qdma->rx_recover_mask);
> +	}
> +}
> +
>  static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
>  {
>  	int i;
> @@ -1594,6 +1708,8 @@ static void airoha_qdma_cleanup(struct airoha_eth *=
eth,
>  {
>  	int i;
> =20
> +	cancel_work_sync(&qdma->rx_recover_work);
> +
>  	if (test_bit(DEV_STATE_INITIALIZED, &eth->state)) {
>  		u32 status;
> =20
> @@ -1651,6 +1767,15 @@ static int airoha_hw_init(struct platform_device *=
pdev,
>  	if (err)
>  		return err;
> =20
> +	/* INIT_WORK() every instance up front, before any of them can fail
> +	 * init and jump to the error path below, since that path tears down
> +	 * every eth->qdma[] slot unconditionally, including ones this loop
> +	 * never reached.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
> +		INIT_WORK(&eth->qdma[i].rx_recover_work,
> +			  airoha_qdma_rx_recover_work);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++) {
>  		err =3D airoha_qdma_init(pdev, eth, &eth->qdma[i]);
>  		if (err)
> @@ -1699,6 +1824,14 @@ static void airoha_qdma_stop_napi(struct airoha_qd=
ma *qdma)
>  {
>  	int i;
> =20
> +	/* Make sure rx_recover_work is neither running nor able to re-arm
> +	 * before any napi_disable() below: it also calls napi_disable()/
> +	 * napi_enable() on q_rx[].napi, and napi_disable() on an
> +	 * already-disabled NAPI spins in napi_disable_locked() forever,
> +	 * since only napi_enable() clears the state it waits on.
> +	 */

I guess we can drop this comment. AI driven?

> +	disable_work_sync(&qdma->rx_recover_work);
> +
>  	for (i =3D 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
>  		napi_disable(&qdma->q_tx_irq[i].napi);
> =20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index fa9a8edce22f..483d6b59c351 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -207,6 +207,15 @@ struct airoha_queue {
>  	bool txq_stopped;
>  	bool flushing;
> =20
> +	/* RX hw stall detection: last REG_RX_DMA_IDX/tail snapshot taken
> +	 * whenever the head-of-line descriptor isn't DONE, and how many
> +	 * consecutive times hw made progress (DMA_IDX moved) while the
> +	 * consumer (tail) didn't. See airoha_qdma_rx_check_stall().
> +	 */
> +	u32 stall_dma_idx;
> +	u16 stall_tail;
> +	u8 stall_count;
> +
>  	struct napi_struct napi;
>  	struct page_pool *page_pool;
>  	struct sk_buff *skb;
> @@ -567,6 +576,13 @@ struct airoha_qdma {
>  	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
> =20
> +	/* recovery for RX rings whose hw completion pointer (RX_DMA_IDX)
> +	 * keeps moving while the sw consumer is stuck; see
> +	 * airoha_qdma_rx_check_stall() and airoha_qdma_rx_recover_work().
> +	 */
> +	struct work_struct rx_recover_work;
> +	DECLARE_BITMAP(rx_recover_mask, AIROHA_NUM_RX_RING);
> +
>  	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
>  };
> =20
> --=20
> 2.55.0
>=20

--y1Nj6AZQ3riJKCr8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCapQ7vQAKCRA6cBh0uS2t
rB/4AP9P858q4JjD4X/aNgYx4KXqQ5hoVuvhBXuRihS4X2Em9AEA2YbQ6XHi1SYa
ctWjQZFa/SPYWxEWEtYgTOnDN/6X2wU=
=UziW
-----END PGP SIGNATURE-----

--y1Nj6AZQ3riJKCr8--
