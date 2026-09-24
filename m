Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C64BD7A5;
	Thu, 24 Sep 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269671; cv=none; b=DW/Z5igrPC5sVsA2+h/oeXX2TucUKq6FYi5TYklJj8QLQkBWJwqiQaUxBaKL4H5f8fcbIbL+tw7JdgsPzJcab7ATGgOSPZUowNPY//M3Q/eu2TrmQ261yxZeIHP1Cn7sbWYbecJXIeWwYZVbG7CdWzLYmJDHd+BZ9mF0E0j7VO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269671; c=relaxed/simple;
	bh=XZsb2Wq8jSTG6mgcmTsYONa7BsQlpcThTywS/+2Mk5M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJ2FKfE4/yYn9PSiR4ULc9hxFuu9cBTu3gcR7huwZk8Kjx0HKlo4ftoOZgL82NWFz1oxqSy3h7QU3k69B9Yp18RtiKOjvFVkQTz31W62OCLPHbJG6Y+6Q8n4NEsxhexd+kojxMejHs1oPzajn9SkRRjtT2Dvc6Y12eLw/Y+cXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F52K1gct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F52K1gct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BB31F00893;
	Thu, 24 Sep 2026 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269669;
	bh=H8cOl1hKo/pUqfggj8DKqM89bXaanLkTkTO9dUd2pyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F52K1gctBdpnXU/xH+BV0/faiEtyiAxb4fZ2Fok8nKKeNHem2mVbO3Fl1KF1cgFwU
	 QS76fBaKOjdPqmAgKg5q/vsAXai3+Kjnz0/wXQGET+B9BWgyLENiEBws1b8p3kIGTq
	 Vh+BLzZmvOUz7bf8qbKWwSFOXHzhq+uTa6MIrHWiH7SR1eOoEfNXskfdLM8GkDAF/y
	 JIiM26Gvy3wnFn0mOzYFZicwonoIrZJr5IaBIZjNlGL0fFsRQYOFiqtdev5rHIF4wM
	 8+6WYbp9xufzfh76dnuI5YTQ4ShlYpxKoYTCp37e7vaUdws7UgdKOR9l6LP+rFUIFx
	 OE/kmDHZYq4qg==
Subject: Re: [PATCH net-next v2 6/6] bnge: Create NQ0 during probe and keep
 active across open/close
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 dharmender.garg@broadcom.com
Date: Thu, 24 Sep 2026 17:07:48 +0000
Message-ID: <179026966847.2160803.1967818200849577556@kernel.org>
In-Reply-To: <20260922052904.59237-7-bhargava.marreddy@broadcom.com>
References: <20260922052904.59237-7-bhargava.marreddy@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 6 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bnge_close_core() no longer quiesces NQ0 before tearing down
  shared ring state, so NQ0's NAPI can run concurrently with the…
- [High] bnge_setup_nq0() uses the runtime-mutable aux MSI-X count as an
  unvalidated index into bd->irq_tbl.
- [Medium] bnge_setup_nq0() can double-allocate NQ0's descriptor arrays
  and leak the first pair.
- [Medium] NQ0 is re-armed in bnge_alloc_core() before the freshly
  attached completion rings have usable doorbells.
- [Medium] The patch silently converts an irq_set_affinity_hint() failure
  in bnge_request_irq() from fatal to a warning (the `goto err_free_irq`…
- [Medium] The commit message mischaracterizes the bnge_alloc_irqs()
  change and hides a second fix.
- [Medium] bnge_reinit_nq0() destroys a working NQ0 before creating the
  replacement and has no rollback: it calls bnge_free_nq0(bn, true)…
- [Medium] A failure of bnge_hwrm_set_async_event_cr() during NQ0 setup
  is now permanent.
- [Low] bnge_free_nq0() stores the 16-bit sentinel INVALID_HW_RING_ID
  (0xffff) into the 32-bit ring->fw_ring_id, whereas every other writer…

--

bnge: Create NQ0 during probe and keep active across open/close

This moves NQ0 creation out of open/close into probe/remove, marks it with
BNGE_NAPI_NQ0 so the generic ring/IRQ/NAPI helpers skip it, and adds
bnge_reinit_nq0() to re-create it when the aux MSI-X reservation changes.
It also adds a guard in bnge_napi_poll() for completions arriving while
NQ0's completion rings are torn down.

A few questions about the new NQ0 lifetime below.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 1c12282d7e88f..c19b51221fa8e 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -539,6 +546,9 @@ static int bnge_alloc_nq_arrays(struct bnge_net *bn)
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
>  		struct bnge_napi *bnapi = bn->bnapi[i];
>  
> +		if (BNGE_NQ0_NAPI(bnapi))
> +			continue;
> +
>  		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
>  		if (rc)
>  			goto err_free_nq_arrays;

[ ... ]

> @@ -1270,6 +1287,9 @@ static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
>  	int i, size, arr_size;
>  	void *bnapi;
>  
> +	if (!bd->nq_nr_rings)
> +		return -ENOMEM;
> +
>  	arr_size = L1_CACHE_ALIGN(sizeof(struct bnge_napi *) *
>  			bd->nq_nr_rings);
>  	size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
> @@ -1407,6 +1427,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
>  	if (rc)
>  		goto err_free_core;
>  
> +	rc = bnge_reinit_nq0(bn);
> +	if (rc)
> +		goto err_free_core;
> +
>  	bnge_quiesce_nq0(bn);
>  	rc = bnge_alloc_nq_tree(bn);
>  	if (rc)

[Severity: Medium]
bnge_quiesce_nq0() and bnge_resume_nq0() only bracket
bnge_alloc_nq_tree(), so NQ0 is re-armed as soon as the new
nqr->cp_ring_arr is published.  Is that too early?

cp_ring_arr comes from kzalloc_objs() in bnge_alloc_nq_tree(), so
cpr->cp_db.doorbell is NULL until bnge_set_db() runs much later, during
bnge_init_nic() -> bnge_hwrm_ring_alloc():

	db->doorbell = bd->bar1 + bd->db_offset;

NQ0's nq_raw_cons and fw_ring_id are deliberately preserved across
close/open by bnge_init_nq_tree(), and the NQ ring is never drained.  If an
unconsumed CQ_NOTIFICATION from the previous incarnation is still pending,
it passes the new guard in bnge_napi_poll() (cp_ring_arr is non-NULL and
idx is in range), __bnge_poll_work() sets cpr->had_work_done = 1, and
__bnge_poll_cqs_done() then writes:

	bnge_writeq(bn->bd,
		    db->db_key64 | dbr_type | DB_TOGGLE(tgl) |
		    DB_RING_IDX(db, cpr->cp_raw_cons),
		    db->doorbell);

with db->doorbell == NULL.  Is such a stale entry always consumed before
the next open, or can it survive into this window?

> @@ -1455,8 +1479,11 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
>  		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
>  		struct bnge_ring_struct *ring = &nqr->ring_struct;
>  
> -		nqr->nq_raw_cons = 0;
> -		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
> +		if (!BNGE_NQ0_NAPI(bn->bnapi[i])) {
> +			nqr->nq_raw_cons = 0;
> +			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
> +		}
> +
>  		for (j = 0; j < nqr->cp_ring_count; j++) {
>  			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
>  

[ ... ]

> @@ -1983,6 +2010,9 @@ static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
>  	u32 map_idx;
>  	int rc;
>  
> +	if (BNGE_NQ0_NAPI(bnapi))
> +		return 0;
> +
>  	nqr = &bnapi->nq_ring;
>  	ring = &nqr->ring_struct;
>  	map_idx = ring->map_idx;
> @@ -2007,6 +2037,171 @@ static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
>  	return 0;
>  }
>  
> +static void bnge_free_nq0(struct bnge_net *bn, bool locked)
> +{
> +	struct bnge_nq_ring_info *nqr;
> +	struct bnge_ring_struct *ring;
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_napi *bnapi;
> +	struct bnge_irq *irq;
> +
> +	if (!bn->bnapi)
> +		return;
> +
> +	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	if (!BNGE_NQ0_NAPI(bnapi))
> +		return;
> +
> +	nqr = &bnapi->nq_ring;
> +	ring = &nqr->ring_struct;
> +	irq = &bd->irq_tbl[ring->map_idx];
> +
> +	if (locked)
> +		napi_disable_locked(&bnapi->napi);
> +	else
> +		napi_disable(&bnapi->napi);
> +
> +	synchronize_irq(irq->vector);
> +	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +
> +	if (irq->have_cpumask) {
> +		irq_set_affinity_hint(irq->vector, NULL);
> +		free_cpumask_var(irq->cpu_mask);
> +		irq->have_cpumask = 0;
> +	}
> +	free_irq(irq->vector, bnapi);
> +	irq->requested = 0;
> +
> +	if (locked)
> +		__netif_napi_del_locked(&bnapi->napi);
> +	else
> +		netif_napi_del(&bnapi->napi);
> +
> +	synchronize_net();
> +
> +	hwrm_ring_free_send_msg(bn, ring,
> +				RING_FREE_REQ_RING_TYPE_NQ,
> +				INVALID_HW_RING_ID);
> +	ring->fw_ring_id = INVALID_HW_RING_ID;

[Severity: Low]
Should this be INVALID_HW_RING_ID_32BIT?  fw_ring_id is u32 and the two
sentinels have different values:

	#define INVALID_HW_RING_ID	((u16)-1)
	#define INVALID_HW_RING_ID_32BIT	(U32_MAX)

Every other writer of ring->fw_ring_id uses the 32-bit constant, and every
reader compares against it, for example in bnge_hwrm_ring_free():

	if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
		hwrm_ring_free_send_msg(bn, ring,
					RING_FREE_REQ_RING_TYPE_NQ,

and in bnge_disable_int():

	if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT)
		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);

Since bnge_free_nq0() also clears BNGE_NAPI_NQ0, index 0 stops being
skipped by those loops while fw_ring_id holds 0x0000ffff, which both tests
read as a live ring.

This looks latent today: the bit-clear state only arises after a failed
open (so ndo_close cannot run) and the next open overwrites the field.  It
would become reachable as soon as an internal close/reopen path such as
ethtool -L/-G or reset recovery is added.

> +	if (bn->grp_info)
> +		bn->grp_info[0].nq_fw_ring_id = INVALID_HW_RING_ID;
> +
> +	clear_bit(BNGE_NAPI_QUIESCED, &bnapi->flags);
> +	clear_bit(BNGE_NAPI_NQ0, &bnapi->flags);
> +
> +	bnge_free_ring(bd, &ring->ring_mem);
> +	bnge_free_nq_desc_arr(nqr);
> +}
> +
> +static int bnge_setup_nq0(struct bnge_net *bn, bool locked)
> +{
> +	struct bnge_nq_ring_info *nqr;
> +	struct bnge_ring_struct *ring;
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_napi *bnapi;
> +	struct bnge_irq *irq;
> +	int map_idx, rc;
> +
> +	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	if (BNGE_NQ0_NAPI(bnapi))
> +		return 0;
> +
> +	nqr = &bnapi->nq_ring;
> +	ring = &nqr->ring_struct;
> +	rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
> +	if (rc)
> +		return -ENOMEM;

[Severity: Medium]
Can this leak NQ0's descriptor arrays?

bnge_alloc_nq_desc_arr() is called unconditionally here, but index 0 is
only skipped by bnge_alloc_nq_arrays() while BNGE_NAPI_NQ0 is set.  If an
earlier bnge_reinit_nq0() freed NQ0 (clearing the bit) and the following
bnge_setup_nq0() failed, the bit stays clear, so on the next open:

bnge_alloc_core()
   bnge_alloc_nq_arrays()      /* allocates desc_ring/desc_mapping for 0 */
   bnge_reinit_nq0()
      bnge_setup_nq0()
         bnge_alloc_nq_desc_arr()  /* allocates them again */

and bnge_alloc_nq_desc_arr() just assigns without checking:

	nqr->desc_ring = kzalloc_objs(*nqr->desc_ring, n);
	if (!nqr->desc_ring)
		return -ENOMEM;

	nqr->desc_mapping = kzalloc_objs(*nqr->desc_mapping, n);

Once BNGE_NAPI_NQ0 is set again, bnge_free_nq_arrays() skips index 0, so
is the first pair ever freed?

> +
> +	nqr->nq_raw_cons = 0;
> +	bnge_init_nq_ring_struct(bn, nqr);
> +	rc = bnge_alloc_ring(bd, &ring->ring_mem);
> +	if (rc)
> +		goto err_free_nq_desc_arr;
> +
> +	map_idx = bnge_aux_get_msix(bd);
> +	ring->map_idx = map_idx;
> +	irq = &bd->irq_tbl[map_idx];
> +	irq->handler = bnge_msix;

[Severity: High]
Can this write past bd->irq_tbl?

map_idx comes straight from bnge_aux_get_msix(bd) (bd->aux_num_msix) with
no check against bd->irqs_acquired, and the entry is then written
(irq->handler, snprintf() into irq->name, irq->requested, irq->cpu_mask)
and read (irq->vector passed to request_irq()).

bd->irq_tbl is allocated in bnge_alloc_irqs() with irqs_demand entries
(unless dynamic MSI-X is available), and only those entries get a valid
.vector.  bd->aux_num_msix is recomputed at runtime in
bnge_reserve_rings():

	resv_msix = hw_resc->resv_irqs - bd->nq_nr_rings;
	aux_msix = min_t(u16, resv_msix, aux_msix);
	bnge_aux_set_msix_num(bd, aux_msix);

where the default is derived from num_online_cpus(), and it is never
clamped against bd->irqs_acquired.  If CPUs are brought online after probe
and a reservation is re-triggered (ethtool -L / -G), can aux_num_msix grow
past the value bnge_alloc_irqs() validated, so that the next open reaches
bnge_setup_nq0() with map_idx >= bd->irqs_acquired?  bnge_free_nq0()
repeats the same access through the stored ring->map_idx.

> +
> +	if (locked)
> +		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
> +					     bnge_napi_poll, bnapi->index);
> +	else
> +		netif_napi_add_config(bn->netdev, &bnapi->napi,
> +				      bnge_napi_poll, bnapi->index);
> +
> +	snprintf(irq->name, sizeof(bd->irq_tbl[0].name), "%s-%s-%d", "bnge",
> +		 "nq", map_idx);
> +	rc = request_irq(irq->vector, irq->handler, 0, irq->name, bnapi);
> +	if (rc)
> +		goto err_del_napi;
> +
> +	if (locked)
> +		netif_napi_set_irq_locked(&bnapi->napi, irq->vector);
> +	else
> +		netif_napi_set_irq(&bnapi->napi, irq->vector);
> +	irq->requested = 1;
> +
> +	if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
> +		int numa_node = dev_to_node(&bd->pdev->dev);
> +		int cpu = cpumask_local_spread(BNGE_NQ0_NAPI_IDX, numa_node);
> +
> +		irq->have_cpumask = 1;
> +		cpumask_set_cpu(cpu, irq->cpu_mask);
> +		if (irq_set_affinity_hint(irq->vector, irq->cpu_mask)) {
> +			netdev_warn(bn->netdev,
> +				    "Set affinity failed, IRQ = %d\n",
> +				    irq->vector);
> +		}
> +	}
> +
> +	rc = bnge_hwrm_nq_ring_alloc(bn, BNGE_NQ0_NAPI_IDX);
> +	if (rc)
> +		goto err_free_irq;

[Severity: Medium]
With NQ0 now persistent, does a failure to program the async event ring
become permanent?

bnge_hwrm_nq_ring_alloc() only warns on that failure and returns success:

	rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
	if (rc)
		netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");

so bnge_setup_nq0() proceeds to arm NQ0 and set BNGE_NAPI_NQ0.  After that
bnge_reinit_nq0() returns early whenever the MSI-X index is unchanged, and
bnge_hwrm_nq_ring_alloc() returns 0 immediately for index 0 because
BNGE_NQ0_NAPI(bnapi) is true, so the FUNC_CFG async_event_cr programming is
never retried.  Before this patch the NQ0 allocation was redone on every
open, so a down/up cycle recovered; now a single transient HWRM failure at
probe would leave link status and other async events undelivered for the
life of the driver instance.

> +
> +	if (locked)
> +		napi_enable_locked(&bnapi->napi);
> +	else
> +		napi_enable(&bnapi->napi);
> +
> +	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +
> +	set_bit(BNGE_NAPI_NQ0, &bnapi->flags);
> +
> +	return 0;
> +
> +err_free_irq:
> +	if (irq->have_cpumask) {
> +		irq_set_affinity_hint(irq->vector, NULL);
> +		free_cpumask_var(irq->cpu_mask);
> +		irq->have_cpumask = 0;
> +	}
> +	free_irq(irq->vector, bnapi);
> +	irq->requested = 0;
> +err_del_napi:
> +	if (locked)
> +		__netif_napi_del_locked(&bnapi->napi);
> +	else
> +		netif_napi_del(&bnapi->napi);
> +	bnge_free_ring(bd, &ring->ring_mem);
> +err_free_nq_desc_arr:
> +	bnge_free_nq_desc_arr(nqr);
> +	return rc;
> +}
> +
> +static int bnge_reinit_nq0(struct bnge_net *bn)
> +{
> +	struct bnge_napi *bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	struct bnge_dev *bd = bn->bd;
> +
> +	if (BNGE_NQ0_NAPI(bnapi) &&
> +	    bnapi->nq_ring.ring_struct.map_idx == bnge_aux_get_msix(bd))
> +		return 0;
> +
> +	bnge_free_nq0(bn, true);
> +	return bnge_setup_nq0(bn, true);
> +}

[Severity: Medium]
The working NQ0 is destroyed before the replacement exists, and there is no
rollback if bnge_setup_nq0() fails.

bnge_free_nq0() frees the IRQ, deletes the NAPI, frees the firmware ring
and clears BNGE_NAPI_NQ0.  If bnge_setup_nq0() then hits a transient
failure (bnge_alloc_nq_desc_arr() or bnge_alloc_ring() returning -ENOMEM,
request_irq() failing, or bnge_hwrm_nq_ring_alloc() failing), the device is
left with no NQ0 at all: bnge_alloc_core() propagates the error, open()
fails, BNGE_NAPI_NQ0 stays clear and bnge_free_core() does not restore it.

The commit message describes the reinit as:

	"bnge_reinit_nq0() re-creates NQ0 on open if its MSI-X vector no
	longer matches the aux device's current reservation."

Is losing the always-on async event ring until some later successful open
intended here, or should the existing NQ0 be kept until the new one is
fully set up?

> +
>  static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
>  {
>  	struct bnge_dev *bd = bn->bd;
> @@ -2419,6 +2614,9 @@ static void bnge_disable_int(struct bnge_net *bn)
>  		struct bnge_nq_ring_info *nqr;
>  		struct bnge_ring_struct *ring;
>  
> +		if (BNGE_NQ0_NAPI(bnapi))
> +			continue;
> +
>  		nqr = &bnapi->nq_ring;
>  		ring = &nqr->ring_struct;
>  
> @@ -2434,8 +2632,12 @@ static void bnge_disable_int_sync(struct bnge_net *bn)
>  
>  	bnge_disable_int(bn);
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
> -		int map_idx = bnge_cp_num_to_irq_num(bn, i);
> +		int map_idx;
>  
> +		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
> +			continue;
> +
> +		map_idx = bnge_cp_num_to_irq_num(bn, i);
>  		synchronize_irq(bd->irq_tbl[map_idx].vector);
>  	}
>  }

[ ... ]

> @@ -2465,6 +2670,8 @@ static void bnge_disable_napi(struct bnge_net *bn)
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
>  		struct bnge_napi *bnapi = bn->bnapi[i];
>  
> +		if (BNGE_NQ0_NAPI(bnapi))
> +			continue;
>  		napi_disable_locked(&bnapi->napi);
>  	}
>  }

[Severity: High]
With NQ0 skipped here and in bnge_disable_int()/bnge_disable_int_sync(),
what still serializes bnge_napi_poll() on NQ0 against the close path?

bnge_close_core() runs:

	bnge_shutdown_nic(bn);      /* frees CQ/RX/TX rings in firmware */
	bnge_disable_napi(bn);      /* now skips NQ0 */
	...
	bnge_free_all_rings_bufs(bn);
	bnge_free_irq(bn);          /* now skips NQ0's vector */
	bnge_del_napi(bn);

	bnge_free_core(bn);         /* only here does bnge_quiesce_nq0() run */

Through that whole window NQ0's vector stays requested and the NQ stays
armed, nqr->cp_ring_arr is still populated, and bnge_msix() schedules
unconditionally:

	napi_schedule(&bnapi->napi);

So a poll landing there passes the new guard in bnge_napi_poll()
(cp_ring_arr non-NULL, idx < cp_ring_count) and enters __bnge_poll_work()
on completion rings whose firmware ids bnge_shutdown_nic() just
invalidated.  Can that poll touch rxr->rx_buf_ring / txr->tx_buf_ring
entries that bnge_free_all_rings_bufs() is freeing and dma-unmapping
concurrently, and write cp_db doorbells for rings already freed in
firmware?

bnge_hwrm_ring_free() states the requirement it relies on:

	/* The completion rings are about to be freed.  After that the
	 * IRQ doorbell will not work anymore.  So we need to disable
	 * IRQ here.
	 */
	bnge_disable_int_sync(bn);

and that NQ doorbell mask plus synchronize_irq() no longer happens for NQ0.

> @@ -2629,6 +2838,9 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
>  		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
>  			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
>  
> +		if (BNGE_NQ0_NAPI(bnapi))
> +			continue;
> +
>  		ring = &nqr->ring_struct;
>  		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
>  			hwrm_ring_free_send_msg(bn, ring,

[ ... ]

> @@ -2690,6 +2902,9 @@ static void bnge_free_irq(struct bnge_net *bn)
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
>  		int map_idx = bnge_cp_num_to_irq_num(bn, i);
>  
> +		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
> +			continue;
> +
>  		irq = &bd->irq_tbl[map_idx];
>  		if (irq->requested) {
>  			if (irq->have_cpumask) {

[ ... ]

> @@ -2732,12 +2950,10 @@ static int bnge_request_irq(struct bnge_net *bn)
>  			irq->have_cpumask = 1;
>  			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>  					irq->cpu_mask);
> -			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> -			if (rc) {
> +			if (irq_set_affinity_hint(irq->vector, irq->cpu_mask)) {
>  				netdev_warn(bn->netdev,
>  					    "Set affinity failed, IRQ = %d\n",
>  					    irq->vector);
> -				goto err_free_irq;
>  			}
>  		}
>  	}

[Severity: Medium]
This changes an irq_set_affinity_hint() failure in bnge_request_irq() from
fatal to a warning, which the commit message does not mention.

On CONFIG_SMP=n the helper is a stub that always fails:

include/linux/interrupt.h:
	static inline int irq_set_affinity_hint(unsigned int irq,
						const struct cpumask *m)
	{
		return -EINVAL;
	}

while zalloc_cpumask_var() returns true on !CONFIG_CPUMASK_OFFSTACK, so
before this hunk bnge_request_irq() always took the err_free_irq path and
ndo_open() could not succeed on a uniprocessor build.  Could this be split
into its own patch with a Fixes: tag so it is visible for backporting?

[ ... ]

> @@ -3610,14 +3833,20 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
>  	if (rc)
>  		goto err_free_bnapi_mem;
>  
> +	rc = bnge_setup_nq0(bn, false);
> +	if (rc)
> +		goto err_free_ring_grps;
> +
>  	rc = register_netdev(netdev);
>  	if (rc) {
>  		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
> -		goto err_free_ring_grps;
> +		goto err_free_nq0;
>  	}
>  
>  	return 0;
>  
> +err_free_nq0:
> +	bnge_free_nq0(bn, false);
>  err_free_ring_grps:
>  	bnge_free_ring_grps(bn);
>  err_free_bnapi_mem:

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> index 4711dd4945ffe..7c26943c5cb35 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
> @@ -382,7 +382,7 @@ int bnge_alloc_irqs(struct bnge_dev *bd)
>  	irqs_demand = pci_alloc_irq_vectors(bd->pdev, min, irqs_demand,
>  					    PCI_IRQ_MSIX);
>  	aux_msix = bnge_aux_get_msix(bd);
> -	if (irqs_demand < 0 || irqs_demand < aux_msix) {
> +	if (irqs_demand < 0 || irqs_demand < aux_msix + min) {
>  		rc = -ENODEV;
>  		goto err_free_irqs;
>  	}

[Severity: Medium]
The commit message says:

	"Since NQ0 now needs its own MSI-X vector, fix bnge_alloc_irqs() to
	require "aux_msix + min" vectors instead of just "aux_msix"."

Does NQ0 consume an additional vector?  bnge_setup_nq0() uses
map_idx = bnge_aux_get_msix(bd), which is the same ulp_msix + 0 vector that
NQ index 0 always used, and bnge_alloc_nq_tree() still assigns
ring->map_idx = ulp_msix + i for the remaining NQs, so total consumption
stays aux_msix + nq_nr_rings.

What the new test looks like it really changes is that a
pci_alloc_irq_vectors() return of exactly aux_msix is now rejected.
Previously bnge_adjust_rings() was called with a zero NQ budget, and
bnge_fix_rings_count()'s shared-channel branch set rx = tx = 0 and returned
success, so bnge_alloc_irqs() could return success with
bd->nq_nr_rings == 0.

Is that also the reason for the undocumented hunk in
bnge_alloc_bnapi_mem()?

	if (!bd->nq_nr_rings)
		return -ENOMEM;

Without it, kzalloc(0) returns ZERO_SIZE_PTR and the new NQ0 helpers
dereference bn->bnapi[0].  Could the real trigger and this second hunk be
described in the changelog, with a Fixes: tag?

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> index 7d45e057f2e82..dcec6fdced301 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> @@ -1375,6 +1375,21 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
>  				break;
>  
>  			idx = BNGE_NQ_HDL_IDX(idx);
> +
> +			/* NQ0 keeps running while administratively down to
> +			 * process async events, but its cp_ring_arr is torn
> +			 * down (and cp_ring_count zeroed) by
> +			 * bnge_free_nq_tree() while down. Guard against a
> +			 * stray/late CQ notification arriving in that state
> +			 * instead of dereferencing a freed or out-of-range
> +			 * cp_ring_arr.
> +			 */
> +			if (unlikely(!nqr->cp_ring_arr ||
> +				     idx >= nqr->cp_ring_count)) {
> +				raw_cons = NEXT_RAW_CMP(raw_cons);
> +				continue;
> +			}
> +
>  			cpr = &nqr->cp_ring_arr[idx];
>  			cpr->had_nqe_notify = 1;
>  			cpr->toggle = NQE_CN_TOGGLE(type);

This guard covers the state after bnge_free_nq_tree() has run, but not the
earlier part of close (where cp_ring_arr is still valid while the firmware
rings and buffers behind it are being freed) nor the early part of open
(where cp_ring_arr is valid but cp_db is not yet programmed).  Both windows
are described in the comments above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922052904.59237-1-bhargava.marreddy%40broadcom.com
