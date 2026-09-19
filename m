Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC38314D06
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789783093; cv=pass; b=JWMQYMuucLWXeYdjcHV2sz6angcm2D7p/Cq8NUWkpIsH3hDAjO8q+YqB8btGdSyFI7pc1xqb6Hk7JPSImqx4zcQtzJ5/9IddClHXb/GS31ZAj+HiDCcsRz2904zlBOxBczWt6hq00PHy4D7LwC7NQna+ZHBeNqAkpFps2sBKXhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789783093; c=relaxed/simple;
	bh=+udBOB/099zLSIn0RVVCikLAGqqVuALV2319TfK+33E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb0FTdb+TbSK8OkBltGb1jyrX86WA7nybNgvnzzbOGsGG3t0EPWlwAVZH7CdC6QceS3B7WyiKfU1daEgtSfL99ONlmri47FCMVLVJ5Ppk9NX52UuZ1tqVNU5SMrNWmxYALy7nzuY3ApKs8oKi9Yejyh8A8w9Ef1xQp4EMfrVN9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gggm9WNA; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gggm9WNA"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f9f0b20so224321666b.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789783089; cv=none;
        d=google.com; s=arc-20260327;
        b=Y3otxStg3ZcBQp8/2n+7gFnFjVUW71tlHrXfgCZKwSFZHAwi4O0t9ZL3GK/h6yOqZj
         +cBMrLALC+tetV48F9PdXY032O5zvCyOP6pSOB7FmSLfMfFZo/QHRWrb3h6krxjWd07N
         rRXGTc1KKJ+9gqkbeqIaAyDR715H1CDzqrymWWsQNt7/K6K2qcKqqD4wi0r0Cejy8GfN
         vUwpjQbyTa0oP7/r+rD/8W+4rqIYdCcRaqXeAagvs51F925sOFkFOPYlCKAaeHhZ1P4q
         JiLqw0GWwMwL1XYhAxGVfQn+6IJBm0Y/A+AjFPkNa8iZ/d3ZtL4cQL2fcsbv2VA0+VFH
         uQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zGaKOqggX7/M6YY/y+fLgAWLcYBkEYrYfOYckgshdU=;
        fh=VBW2S0rTm9TLWg7HOW4D/44yJ6NIIij/B65GbREBOcA=;
        b=UnsjziTJzPCk3gRqNE4CeDmIR6UqXaY1SpwSB8bRxtdY+zZO3ciMjmVNlXKJx7A5Dc
         5BhGJrtcgIBagTGbJnITSxh3eZyBBNKePNNGlsXdvNYMbRJeKF9qH9254i0eGg1NXg7R
         p+4Ips08v6DJ0GLKYNEyx71bLQ9tr28MHZK5m6g1DMrtkxxaCzlEvs/AFEQFT409QMit
         sh769lGXeSKt38WheWBSo8tj44QYOPriY8OL1yMphWiIYavx/MajcW5p26ROW5PBPw9Z
         HFNN3wk2m6EOby/6zvw/EaORQsNKCcsenW4xaykoUyOnrjO72ErqpqqfhIv0fQSFzTYU
         YYaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789783089; x=1790387889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zGaKOqggX7/M6YY/y+fLgAWLcYBkEYrYfOYckgshdU=;
        b=gggm9WNAzah0GRFeJNvOdgjAuEuOK7Gqtr6Gol2+L88lP4S173u0aMJE8Ivf46YrdG
         TacAUUbAWBmkYOp/Mxb4G2xelSHJwZRa4qhQfEos9jb1HcpvfY4MKXnx/jzAK0dykJnt
         r6Q/v+yYEGFyDtzqMiP6qn7k1A1p7wbOcDtL1iyb56iqu84kjLVkyRkEz8+xlnpSrPpp
         LL6TQslaAaDZ/L0SELlfIcO+tFABSljDoFXSmyDM7uOvKMlOTewJL85MvNQkuX6g77N6
         n56ejKaNA+wbdK1b0jrf7FXOlmXdd1RmVcjD1XO/dXTo85lYo7MVj13v+hCb8p3D1OpP
         CXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789783089; x=1790387889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zGaKOqggX7/M6YY/y+fLgAWLcYBkEYrYfOYckgshdU=;
        b=dMTPn6ZJg1nizzu4fg6j/bynErvIc1RV1DsZuXWodH3DuW/8rvQoOl1bix7ec/c8dj
         otaofHt5KY7dTsC3CT79v9hxPn30N/qn+p072WMont0OVBYXPIiTP8hkRa1CXfsvMHTH
         U9btBQdypwafsl6RLSK/a8xhZA59hkGi7YOt7CDs0IGaBwiq0n/toyLrfGgrv/NQ7/ZO
         i1ewe7T1BLN+vbrHhGLWlSBeBP0Pq4Dk3ihX0WFVk2sDm4FyvsC+jhxCBI/DSGam1RuS
         tny2VaLoOsHTIGWhAtQS/TUUs3hgpq4StPjkiSHYq0xOebWrR/Bxqk1sfMECiNh541Gz
         FApg==
X-Forwarded-Encrypted: i=1; AKwUvBx2ySjztarJaw9CXgbV6ulyepOpQEQv9A3S4MyRw9LJ4rgdCAuCZSFG/5p/PRC5M8jW+Kzlb4A=@vger.kernel.org
X-Gm-Message-State: AFuF++lDVTydjVH0fjh5/jfk3zJu/PKCUA5rFG/h+D4QRZDqV2GesGhV
	fsUVuhi3WRetRfNqinDjLzVDuVk6HouXs22+VKRdMsorQCUAW2s4MCgrHH30apr4GE/DG3QhLMQ
	F9OmpD8n1oqsXHxeSh1n/3q0+mLiwTkd7w1zqOvD0RexSj10JPVEonPUT0Bk=
X-Gm-Gg: AYBFou3t/4IjoMQYL9tLy+/N7Y9EAGHxGKbdjZ0E6FgqzCQAVoLFEDdnHbhDlUXINBt
	ALqB++6RKTaQq98rEnnVw6wWB32JUhsRxzi/8Pz3kh6QfcOGK0voQGQrp+akz0evyNqojtJEwZF
	6FMSutZrfA1+9vYQp07o+qcRHUmPmCK896LGYfXxfFPeGO/P8TDqNKG5WTwWl1wT/Om78nrr9Lu
	jvj5KiigfOZe9L9pVv1/bRJSGVzmxJDXy6TgETnDWryFb0yQ2cq7S6n/n/sFZS/Ha5sjWMihs1D
	VKtF1i/8VKu8msGgq4KKoFYvx0W040037OIVWwKWx8VW9ZkvoNz90Osj
X-Received: by 2002:a17:907:c319:b0:c29:f5d8:9c7b with SMTP id
 a640c23a62f3a-c2a158847a8mr397278266b.42.1789782590535; Fri, 18 Sep 2026
 18:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916165533.2187434-9-hramamurthy@google.com> <178971826826.22033.2672059641817523646@kernel.org>
In-Reply-To: <178971826826.22033.2672059641817523646@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 18 Sep 2026 18:49:38 -0700
X-Gm-Features: AcwNN1Wfk4307RGqBof636MRL4Klv81dHnD6LLRK4SSg3N-jEuzD0p3ieyDgH2Y
Message-ID: <CALuQH+ULMqdAsUCGUd0MeVy21y_jP-b_fS_4pc501g4O3Q23Kg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/12] gve: split up notify block allocation
 and setup paths
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:57=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [High] Reset path now frees the notify-block MSI-X IRQs and zeroes
>   block->irq *before* the NAPI/queue teardown that consumes block->irq,=
=E2=80=A6
> - [Low] Reported for completeness, but I could not confirm a functional
>   defect: the concern claims the new alloc/setup/teardown/free split=E2=
=80=A6
>
> --
>
> gve: split up notify block allocation and setup paths
>
> This splits gve_alloc_notify_blocks() into an allocation half and a new
> gve_setup_notify_blocks()/gve_teardown_notify_blocks() pair so that MSI-X
> vectors can be requested after the IRQ doorbell offsets are known. New
> irq_requested and mgmt_irq_requested flags track which irqs were taken, a=
nd
> gve_reset_device() now tears the notify blocks down.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 8cd82d92d3b09..7119b5a9ae41b 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -429,6 +429,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, in=
t budget)
> >       return work_done;
> >  }
> >
> > +static void gve_free_notify_blocks(struct gve_priv *priv)
> > +{
> > +     pci_disable_msix(priv->pdev);
> > +     if (priv->irq_db_indices) {
> > +             dma_free_coherent(&priv->pdev->dev,
> > +                               priv->num_ntfy_blks *
> > +                               sizeof(*priv->irq_db_indices),
> > +                               priv->irq_db_indices,
> > +                               priv->irq_db_indices_bus);
> > +             priv->irq_db_indices =3D NULL;
> > +     }
> > +
> > +     kvfree(priv->ntfy_blocks);
> > +     priv->ntfy_blocks =3D NULL;
> > +     kvfree(priv->msix_vectors);
> > +     priv->msix_vectors =3D NULL;
> > +}
> > +
> >  static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
> >  {
> >       if (priv->numa_node =3D=3D NUMA_NO_NODE)
>
> [ ... ]
>
> > @@ -497,15 +504,65 @@ static int gve_alloc_notify_blocks(struct gve_pri=
v *priv)
>
> [ ... ]
>
> > +static void gve_teardown_notify_blocks(struct gve_priv *priv)
> > +{
> > +     int i;
> > +
> > +     if (!priv->ntfy_blocks)
> > +             return;
>
> [Severity: Low]
>
> This isn't a bug in the current tree, but the early return here keys on
> priv->ntfy_blocks while the management vector release further down depend=
s
> only on priv->msix_vectors and priv->mgmt_irq_requested:
>
>         if (priv->mgmt_irq_requested) {
>                 free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, =
priv);
>                 priv->mgmt_irq_requested =3D false;
>         }
>
> All three gve_free_notify_blocks() call sites currently run after
> gve_teardown_notify_blocks() (or before any request_irq()), so
> priv->ntfy_blocks and priv->msix_vectors are still valid whenever the
> teardown runs and nothing is leaked.
>
> Would it be worth guarding each resource with the flag that describes it,
> so the ordering contract is expressed in the code rather than left to the
> callers, given the mailbox mode is meant to reuse this skeleton?

The early return was a naive attempt to keep the indent levels down.
Will reorder the code to check for mgmt interrupt first.

>
> > +
> > +     for (i =3D 0; i < priv->num_ntfy_blks; i++) {
> > +             struct gve_notify_block *block =3D &priv->ntfy_blocks[i];
> > +
> > +             if (!block->irq_requested)
> > +                     continue;
> > +
> > +             irq_set_affinity_hint(priv->msix_vectors[i].vector,
> > +                                   NULL);
> > +             free_irq(priv->msix_vectors[i].vector, block);
> > +             block->irq =3D 0;
> > +             block->irq_requested =3D false;
> > +     }
> > +
> > +     if (priv->mgmt_irq_requested) {
> > +             free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, =
priv);
> > +             priv->mgmt_irq_requested =3D false;
> > +     }
> > +}
>
> [ ... ]
>
> > @@ -761,6 +770,7 @@ static void gve_teardown_control_plane_resources(st=
ruct gve_priv *priv)
> >   */
> >  static void gve_reset_device(struct gve_priv *priv)
> >  {
> > +     gve_teardown_notify_blocks(priv);
> >       gve_teardown_control_plane_resources(priv);
> >       gve_adminq_free(priv);
> >  }
>
> [Severity: High]
>
> Can this end up calling disable_irq(0) on the reset path?
>
> gve_reset() has this ordering:
>
>         disable_work(&priv->service_task);
>         gve_reset_device(priv);
>         gve_queues_stop(priv);
>         gve_queues_mem_remove(priv);
>         gve_free_control_plane_resources(priv);
>
> With the new first statement in gve_reset_device(), the vectors are
> released and block->irq is cleared before gve_queues_stop() runs:
>
>                 free_irq(priv->msix_vectors[i].vector, block);
>                 block->irq =3D 0;
>                 block->irq_requested =3D false;
>
> gve_queues_stop() then walks gve_tx_stop_rings()/gve_rx_stop_rings(), and
> the per-ring stop only checks that the ring is still attached to a block,
> which gve_turndown() does not clear:
>
> drivers/net/ethernet/google/gve/gve_rx.c:gve_rx_stop_ring_gqi() {
>         if (!gve_rx_was_added_to_block(priv, idx))
>                 return;
>
>         gve_remove_napi(priv, ntfy_idx);
>         ...
> }
>
> and gve_remove_napi() uses block->irq without validating it:
>
> drivers/net/ethernet/google/gve/gve_utils.c:gve_remove_napi() {
>         struct gve_notify_block *block =3D &priv->ntfy_blocks[ntfy_idx];
>
>         disable_irq(block->irq);
>         netif_napi_del_locked(&block->napi);
> }
>
> gve_rx_stop_ring_dqo(), gve_tx_stop_ring_gqi() and gve_tx_stop_ring_dqo()
> reach gve_remove_napi() the same way.
>
> Before this patch the irqs were freed in gve_free_notify_blocks(), reache=
d
> from gve_free_control_plane_resources(), which gve_reset() calls after
> gve_queues_stop(), so block->irq was still the real vector at that point.
>
> On x86 virq 0 has a descriptor created during early boot, so disable_irq(=
0)
> would mask that unrelated line and increment its disable depth once per
> still-attached queue with no matching enable_irq(); where no descriptor
> exists the call returns -EINVAL and the intended synchronization against
> the driver's own vector is simply skipped.
>
> The reset path is reachable from the service task on a device-requested
> reset and from gve_tx_timeout() -> gve_schedule_reset(), so it can be
> driven by ordinary queue stalls rather than only by administrative action=
.
>
> Would keeping gve_teardown_notify_blocks() after gve_queues_stop(), or
> skipping the disable_irq() when block->irq is 0, address this?
>
> The same ordering is still in place at the end of the series, so it does
> not look like a later patch fixes it.

A few things that need to be changed here:

1) gve_teardown_notify_blocks() does not need to happen as part of
gve_reset_device(). It should be in gve_teardown_device() instead,
after the device reset occurs.
2) gve_remove_napi() should guard against block->irq_reuqested
3) block->irq =3D 0 should be removed

Will make these changes in v8.

>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260916165533.2187434-1-hramamurthy%40google.com

-- Josh
