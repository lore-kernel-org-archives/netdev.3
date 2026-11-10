Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322305;
	b=bRAQ6lp2HM/3RsI7eDTS7SVUdZDHk2HMpzsJWO/K7m5JdHqifx4wLRGB6pOaapCYkTDh
	 /VXydmgskOtmZxFPaman+MzmnmUCnl9yTVUsVS+XHcQU5bhs9Fkb546w+tpSHCXdTZTzX
	 Dz3A4KhVhIMEDo0wPNeHZPITHB2vws7QGdpO7SNiEnMjvuZwHIx7FvJr9dXlHSfPxoZ/w
	 UqQr6U71HTu5V8+H1ZJSvd5608kwxlccJFqcmsDlXfDAUjnrLAcvrF2tV0KzYQTsS6FV2
	 4xrpZ3fbYYN8o/t9iaMAzR1vPMkavFFtECRt+3yUXOhDV+NhYoW+x2+ULVx9AkrqzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322305;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oYILpWaYX4mYcYlSh1ZMq8HoO0Hj20LrKZ5ZNs2Zyyw=;
	b=SkmS5qkC6ucRZwYb72jQmK8jHh0jSAl03GHWyAQxWofq6A1AXU2tZtbrMu8J+RXpqNad
	 QTEa22aYelBGijGziTqI+8tKjYV7AGS2P3z7Pd6zWd/LoqayK26KZPK7i9TU06c4otQGe
	 EUSyB+Nv7n9p2ImR20WlGX7zSFAjskRPaFgsV9m20qUqcjNUBZEiqhDoZ5nNk2Be3QKJq
	 G6PzE2DZVjQFzicgAdpYrJJOGYc5SAlJ5aNerCrVfUb6GvdDIF4PH/vGOIbsgdqwwEWho
	 nl89iCQDm9PSk8rge6ETvBU6GLOFuSe3Bimv4EugajoVO6P11jtieNj8ZWzhHid8w9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CopE6Uud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0EA60A2606;
	Tue, 10 Nov 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CopE6Uud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB461F008A3;
	Tue, 10 Nov 2026 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322305;
	bh=oYILpWaYX4mYcYlSh1ZMq8HoO0Hj20LrKZ5ZNs2Zyyw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CopE6UudIT5C6sRLUh5FUX+EIVh3BQ5Elpv+/1GcoDA8vWp3+V6VYpGnupooCCDbs
	 dEO1KLeeQrcxkL2c+Xsu4vxf4jWzEA+ZBZa60/dQ4IvILBZaYGs62Qfp+mlHaHyQXZ
	 EXEZ8Q+pQXxf6xHvJUXeyzxGlIa8D6RQVtii4SacIUuii7VuEeCPNODtsJ8m8v6P/7
	 B4moqvegHMRQ4GVvV3T3UAAzm0O6VnPN+LNo8Eiv+o2unRFmRuJ+IV1T6Zr/MzWbRm
	 oxxlbfp55t13lAiBwttdBJyaN7nnsK4OlbUxuwODwAfbkPtqAjEMLVnrKDjWO+k384
	 M5xOevU+loPRw==
Subject: Re: [PATCH v33 net-next 3/8] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:44 +0000
Message-ID: <179432230424.994134.9323146724334618440@kernel.org>
In-Reply-To: <20261106045631.2224-4-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-4-illusion.wang@nebula-matrix.com>
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

- [Medium] The commit message and an in-code comment describe the
  reconfiguration path the opposite way from how the code behaves.

--

net/nebula-matrix: add intr resource implementation

This adds an nbl_interrupt module that manages the chip-internal MSI-X
vector index space for the control PF. It also programs the
FUNCTION_MSIX_MAP, HOST_MSIX_INFO and MSIX_FID tables, using a
clear-VALID, flush, delay sequence for teardown. The patch also moves
pci_set_master() to after nbl_core_init() and clears bus mastering
before teardown in nbl_remove().

> 1. cfg_msix_map: Allocate global hardware MSI-X vectors from the separate
>    net/other interrupt bitmaps.  Reuse the per-function coherent DMA map
>    table on reconfig, so a reconfiguration neither frees and reallocates
>    the table nor has to take the destroy-path quiesce window before the
>    old vectors are recycled.  The first configuration of a function still
>    takes one invalidate + flush + quiesce window before the table is
>    written; that window belongs to the first configuration only and is
>    not part of the reconfiguration path.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..3969392abdc64
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,851 @@

[ ... ]

> +/**
> + * nbl_res_intr_cfg_msix_map - allocate & program MSI-X mapping table

[ ... ]

> + * Allocate interrupt vectors; MSIX coherent DMA table is allocated once
> + * per function on first configuration, entries are rewritten while the
> + * map is invalidated on subsequent reconfigurations. No free/realloc of
> + * DMA table on vector count changes. This removes the DMA table
> + * free/realloc cycle. On reconfiguration the map VALID bit is cleared
> + * and the hardware-DMA quiesce window is observed (lock held) before old
> + * vectors are recycled and the table is rewritten.

[ ... ]

> +	if (had_config) {
> +		old_interrupts =
> +			intr_mgt->func_intr_res[func_id].interrupts;
> +		old_num = intr_mgt->func_intr_res[func_id].num_interrupts;
> +
> +		ret = __nbl_res_intr_set_mailbox_irq(intr_mgt, res_mgt, func_id,
> +						     0, false);

[ ... ]

> +		for (j = 0; j < old_num; j++) {
> +			hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
> +					      func_id, false,
> +					      old_interrupts[j],
> +					      0, 0, 0, false);
> +		}
> +		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +				     false, official_tbl->dma,
> +				     0, 0, 0);
> +		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +		nbl_intr_quiesce_wait();
> +
> +		nbl_intr_release_bitmap(intr_mgt, res_mgt, old_interrupts,
> +					old_num);

[ ... ]

> +	/*
> +	 * First configuration of this function.  Re-invalidate the entry
> +	 * and take a quiesce window before the table below is rewritten:
> +	 * while the entry is VALID the pcompleter could fetch a table
> +	 * that is being written and route stale gvecs.
> +	 *
> +	 * This is a second, real quiesce window rather than part of the
> +	 * reconfiguration path, and it costs one delay per function on the
> +	 * first configuration only.  Reusing the table removes the
> +	 * free/realloc cycle and the destroy-path quiesce window from
> +	 * every *re*configuration; it does not remove this one.
> +	 */
> +	if (!had_config) {
> +		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +				     false, 0, 0, 0, 0);
> +		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +		nbl_intr_quiesce_wait();
> +	}

[Severity: Medium]
The commit message says a reconfiguration does not "take the
destroy-path quiesce window before the old vectors are recycled". The
comment above the !had_config block in nbl_res_intr_cfg_msix_map() says
the same thing.

The had_config branch above seems to do the opposite, though. It runs the
destroy sequence:

  __nbl_res_intr_set_mailbox_irq(..., false)
  cfg_msix_info(false) for each old gvec
  cfg_msix_map(false, official_tbl->dma)
  flush_write()

It then calls nbl_intr_quiesce_wait(), the same usleep_range(1000, 1200)
the destroy path uses. Only after that does it call
nbl_intr_release_bitmap() on the old vectors.

The kerneldoc for nbl_res_intr_cfg_msix_map() matches the code: "On
reconfiguration the map VALID bit is cleared and the hardware-DMA quiesce
window is observed (lock held) before old vectors are recycled". So the
two in-file comments contradict each other. The only quiesce a
reconfiguration skips is the extra first-configuration one.

Could the commit message and the !had_config comment be updated to match
the code?

The !had_config comment also justifies its extra invalidate and quiesce
with "while the entry is VALID the pcompleter could fetch a table that is
being written". Can the entry be VALID when had_config is false?

- nbl_intr_setup_mgt() clears VALID on all NBL_MAX_PF entries at start.
- A failed fresh configuration exits before any hardware write.
- __nbl_res_intr_complete_destroy_msix_map() leaves VALID cleared.
- DESTROYING can't be seen here, because the single-function destroy
  holds the lock and nbl_intr_mgt_stop() sets stopping.

Separately, the commit message says:

  Everything between pci_set_master() and the scrub is host-side setup
  plus MMIO and does not wait for the device.

This patch moves pci_set_master() in nbl_probe() to after
nbl_core_init(), so it now runs after the scrub in nbl_intr_setup_mgt().
Does this sentence describe the old ordering?

nbl_interrupt.c is not changed by the later patches in the series, so
this mismatch is still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
