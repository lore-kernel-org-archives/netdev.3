Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF8339389;
	Mon, 12 Oct 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825589; cv=none; b=Q3Gp2Nr+u/i8xMLDsCm6TvsD12CXUggXcy2PWDMkJIo6X8miq60tXCuP46m3vrDWbOxL7p/2e2Uv7OU2pqIsCpbqyORohfZTqok3CI/A3Z8tqp/ePBWY0Eryh0V++A4CB2xizzfCTLRnAkjxI39wOYab/1z3oxC7TUDp3KGRkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825589; c=relaxed/simple;
	bh=sc7oMQB1iIsG9Tjs2+oy2Y8ewhoddExXpMgmQfLoQT0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNO2/WmPxnSZ7mhYJO0IlmU0LhedffpU2O6vxrbm90D29xa3x5Pp4YcPjExChhGppw6hUfdamqqj7vvCaWr6agRJtCXI/hApRqMNOOMsWPpTY/Dbmm8/Ej1ZZARCB7+dJU0TKLbGcaWVmXHRa68PAU4bCGIjPtrvr5o4z78fP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UefLQ8N6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UefLQ8N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177A51F0089B;
	Mon, 12 Oct 2026 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825587;
	bh=Cb6WTYEtjlNKiWfB8xZNRoCChqjPhaokfbd+nwT/PAY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UefLQ8N63gX5dfbi2PS/zIgVvhCePt/VWii4YiArHw6myceHsHJMggVpu/ikX2iFJ
	 MELnwRWJr5/AiXS6E+kgq6eArR9ZseNTULyJgzdX6+Trco55Mr0oM0sfsNMOikmojJ
	 eHBLBekGGmnq6IyHg+BDtpL3A0bH3/h0R75Z+7RKYXAPLOhjBfqsjhb7IRWZj7EFGg
	 QnHS8Pez20cbXukdXgO6eBqW6U6cwupCufdm3jc3SDdFyQvXDihSfkdF74l8XvYIk3
	 jt2K1XGGxv8un9jJ9UvN+oRszmtCcYKzG4FYCia9ufkcUXyRUKyh3JYVVk2HGNF7ZT
	 ujDouP8u5qLGQ==
Subject: Re: [PATCH net-next V2 1/5] net/mlx5: nodnic: Introduce the
 mlx5_nodnic driver
From: netdev-bot+sashiko@kernel.org
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cjubran@nvidia.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
 shshitrit@nvidia.com, leon@kernel.org, mbloch@nvidia.com, saeedm@nvidia.com,
 dtatulea@nvidia.com, horms@kernel.org
Date: Mon, 12 Oct 2026 17:19:45 +0000
Message-ID: <179182558562.434549.15918325290379101624@kernel.org>
In-Reply-To: <20261008171821.660739-2-tariqt@nvidia.com>
References: <20261008171821.660739-2-tariqt@nvidia.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 1 · High: 4 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] mlx5: Fatal SQ/RQ size calculation mismatch causes DMA
  buffer overflow
- [High] Raw positive PCIBIOS_* codes from config-space accessors reach
  the PCI probe return, leading to use-after-free and double kfree.
- [High] Device DMA buffers can be freed while the device still has DMA
  enabled.
- [High] mlx5: CQ log_size hardware register is overwritten with zero
  during init
- [High] mlx5: 32-bit multiplication overflow in UAR physical address
  calculation
- [Medium] The only device this driver binds, 0x15b3:0xc2d6, is already
  listed by mlx5_core in mgt_ifc_device_ids[] (fw_reset.c:394,…
- [Low] mlx5_nodnic_build_netdev() installs the MAC that
  mlx5_nodnic_read_mac_address() read from device registers…
- [Low] (Baseline: not valid; fixed later in the series.) This patch
  registers a netdev whose ops have no ndo_start_xmit and no RX/NAPI…
- [Low] (Baseline: not valid.) The device-supplied size exponents
  (log_cq_size, log_max_ring_size, log_uar_page_size) are used in shifts…
- [Low] (Baseline: not valid.) The VSC read/write helpers mask address
  bits 31:30 instead of rejecting them, and do not check the syndrome…

--

net/mlx5: nodnic: Introduce the mlx5_nodnic driver

This commit adds mlx5_nodnic, a PCI driver for DRAM-less ConnectX NIC
functions. It covers probe and remove (FLR, firmware readiness polling,
interface negotiation and capability discovery). It also adds a VSC layer
for config-space access to the init segment and the NODNIC registers, and
a netdev with ndo_open/ndo_stop and a link-event IRQ.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
> new file mode 100644
> index 0000000000000..5724ed41d8b89
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/en_cfg.c
> @@ -0,0 +1,828 @@

[ ... ]

> +/* log_cq_size should be read after rq and sq ring sizes were set. */
> +static int mlx5_nodnic_read_cq_ring_size(struct mlx5_nodnic_core_dev *dev)
> +{

[ ... ]

> +	log_cq_size = MLX5_GET(nodnic_q_addr_l, &cq_addr_l, log_size);
> +	cq->num_entries = 1ULL << log_cq_size;
> +	cq->log_num_entries = log_cq_size;

[Severity: Low]
This isn't a bug, but log_cq_size comes straight from a device register.
The same is true of log_max_ring_size in mlx5_nodnic_calc_ring_size() and
log_uar_page_size in mlx5_nodnic_init_uar_map(). All three are used in
shifts and size calculations with no range check.

mlx5_core also trusts FW-reported exponents, so this is only a hardening
question. Would a sanity check on these values be worth adding?

[ ... ]

> +static void mlx5_nodnic_close_queues(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_priv *priv = dev->priv;
> +
> +	mlx5_nodnic_free_ring(dev, &priv->working_buffer);
> +	mlx5_nodnic_close_cq(&priv->cq);
> +	mlx5_nodnic_close_rq(dev);
> +	mlx5_nodnic_close_sq(dev);
> +	mlx5_nodnic_free_dbr(dev, &priv->dbr);
> +}

[Severity: High]
Can the device still DMA into these buffers after they are freed?

mlx5_nodnic_open_queues() writes the ring, CQ, doorbell record and working
buffer addresses to the device. Nothing here clears those registers
before dma_free_coherent().

This patch doesn't call mlx5_nodnic_enable_port() yet. Later in the
series, "net/mlx5: nodnic: Implement data path" adds
mlx5_nodnic_deactivate_queues(), but it only disables the port if the VSC
acquire succeeds:

	if (!mlx5_nodnic_vsc_context_acquire(dev->vsc_ctx)) {
		mlx5_nodnic_disable_port(dev);
		mlx5_nodnic_vsc_context_release(dev->vsc_ctx);
	}

	mlx5_nodnic_deactivate_sq(&dev->priv->sq);
	napi_disable_locked(&dev->priv->cq.napi);
	mlx5_nodnic_deactivate_rq(dev);

The acquire can fail with -EBUSY after VSC_MAX_RETRIES, with -EACCES, or
on a set_space failure. A write inside mlx5_nodnic_disable_port() can
also fail, and that only produces a warning. In any of these cases the RX
pages go back to the page pool and the coherent buffers are freed. At
that point network_en and dma_en are still set and bus mastering is
still on.

The error paths in mlx5_nodnic_init_ring(), mlx5_nodnic_init_cq_ring()
and mlx5_nodnic_init_working_buffer() follow the same pattern. Each one
frees a buffer after its address has already been written to the device.

In mlx5_nodnic_remove_one(), mlx5_nodnic_cleanup_netdev() frees all of
these buffers first. Only after that does mlx5_nodnic_dev_cleanup() set
the interface to DISABLED and pci_disable_device() clear bus mastering.

Should the device side be shut down, or pci_clear_master() called as a
fallback, before these buffers are freed?

[ ... ]

> +static const struct net_device_ops mlx5_nodnic_netdev_ops = {
> +	.ndo_open		= mlx5_nodnic_open,
> +	.ndo_stop		= mlx5_nodnic_close,
> +};

[Severity: Low]
This isn't a bug, but this patch registers a netdev with no ndo_start_xmit
and no RX path. netif_tx_disable() in mlx5_nodnic_create_netdev() keeps
the TX queue stopped, so the core never calls the missing callback.

The data path is added later in the series by "net/mlx5: nodnic:
Implement data path". Is it intended that this patch registers an
interface that can't pass traffic yet?

> +
> +void mlx5_nodnic_build_netdev(struct net_device *netdev)
> +{
> +	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
> +	struct mlx5_nodnic_core_dev *core_dev;
> +
> +	core_dev = priv->core_dev;
> +
> +	SET_NETDEV_DEV(netdev, core_dev->device);
> +
> +	netdev->netdev_ops = &mlx5_nodnic_netdev_ops;
> +	netdev->request_ops_lock = true;
> +
> +	eth_hw_addr_set(netdev, core_dev->mac_address);

[Severity: Low]
Should the MAC from mlx5_nodnic_read_mac_address() be checked with
is_valid_ether_addr() before it is installed here? If the device reports
an all-zero or multicast address, that address is registered as the
interface's unicast address.

For comparison, mlx5e_set_netdev_dev_addr() in mlx5_core falls back to
eth_hw_addr_random() when the FW MAC is zero.

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
> new file mode 100644
> index 0000000000000..a533232bf6ef4
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/main.c
> @@ -0,0 +1,864 @@

[ ... ]

> +static const struct pci_device_id mlx5_nodnic_core_pci_table[] = {
> +	{ PCI_VDEVICE(MELLANOX, 0xc2d6) }, /* BlueField-4 nodnic rshim PF */
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, mlx5_nodnic_core_pci_table);
> +
> +static struct pci_driver mlx5_nodnic_core_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = mlx5_nodnic_core_pci_table,
> +	.probe = mlx5_nodnic_probe_one,
> +	.remove = mlx5_nodnic_remove_one,
> +};

[Severity: Medium]
How is this driver meant to interact with mlx5_core's sync FW reset?
mlx5_core already lists 0xc2d6 in mgt_ifc_device_ids[] in
drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c:

	{ PCI_VDEVICE(MELLANOX, 0xc2d6) }, /* BlueField4 MGT interface device ID */

Because of that entry, mlx5_check_dev_ids() lets the reset go ahead with
this function present. mlx5_pci_link_toggle() then saves and locks every
function on the bus, toggles the link and restores config space:

	list_for_each_entry(sdev, &bridge_bus->devices, bus_list) {
		pci_save_state(sdev);
		pci_cfg_access_lock(sdev);
	}

This driver has no .err_handler and no reset_prepare/reset_done hooks,
and none are added later in the series. Take a devlink reload with action
fw_activate on the PF as an example. Afterwards, the device-side state
this driver programmed would be gone: nic_interface=NO_DRAM_NIC, the
ring/CQ/DBR/working buffer addresses, and the port and MSI-X enables. The
netdev would stay registered with stale software state.

The commit message doesn't mention this coupling with mlx5_core's reset
flow. Is it expected?

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c
> new file mode 100644
> index 0000000000000..6ddbf045a8d48
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/nodnic_pci_vsc.c
> @@ -0,0 +1,343 @@

[ ... ]

> +static int mlx5_nodnic_vsc_pci_read(struct mlx5_nodnic_vsc_ctx *ctx,
> +				    unsigned int offset, u32 *val)
> +{
> +	return pci_read_config_dword(ctx->pdev, ctx->addr + offset, val);
> +}
> +
> +static int mlx5_nodnic_vsc_pci_write(struct mlx5_nodnic_vsc_ctx *ctx,
> +				     unsigned int offset, u32 val)
> +{
> +	return pci_write_config_dword(ctx->pdev, ctx->addr + offset, val);
> +}

[Severity: High]
Should these convert the return value with pcibios_err_to_errno()?

pci_read_config_dword() and pci_write_config_dword() return positive
PCIBIOS_* codes, for example PCIBIOS_DEVICE_NOT_FOUND once the device is
disconnected. Every caller up the stack only checks if (err) and passes
the value up unchanged, so mlx5_nodnic_probe_one() can end up returning
a positive value:

mlx5_nodnic_probe_one()
  mlx5_nodnic_dev_init()
    mlx5_nodnic_wait_fw_init()
      mlx5_nodnic_vsc_context_acquire()
        mlx5_nodnic_vsc_gw_lock()
          mlx5_nodnic_vsc_pci_read()

On that path, probe calls kfree(dev) and returns the positive value.
drvdata, set in mlx5_nodnic_pci_init(), still points at dev.
local_pci_probe() treats a positive return as success:

	if (rc < 0) {
		pci_dev->driver = NULL;
		pm_runtime_put_sync(dev);
		return rc;
	}
	...
	pci_warn(pci_dev, "Driver probe function unexpectedly returned %d\n",
		 rc);
	return 0;

So the driver stays bound, and the next unbind calls
mlx5_nodnic_remove_one(). It gets the freed dev from pci_get_drvdata(),
releases the IRQ vectors, the iseg mapping, the regions and vsc_ctx a
second time, and then calls kfree(dev) again.

mlx5_nodnic_vsc_gw_lock() checks pci_channel_offline() only at the top of
each loop iteration. Probe can also spend minutes in
mlx5_nodnic_wait_fw_init(). A surprise removal or DPC event in that
window looks like enough to hit this.

ndo_open can return the same kind of value through
mlx5_nodnic_open()->mlx5_nodnic_open_locked()->mlx5_nodnic_open_queues()
->mlx5_nodnic_vsc_context_acquire(). netif_open() only checks for
ret < 0:

	ret = __dev_open(dev, extack);
	if (ret < 0)
		return ret;

	rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP | IFF_RUNNING, GFP_KERNEL, 0, NULL);
	call_netdevice_notifiers(NETDEV_UP, dev);

That would send RTM_NEWLINK and NETDEV_UP for an interface that
__dev_open() left down.

[ ... ]

> +static int mlx5_nodnic_vsc_read(struct mlx5_nodnic_vsc_ctx *ctx,
> +				unsigned int address, u32 *data)
> +{
> +	int err;
> +
> +	/* Write the address with the flag and syndrome bits cleared */
> +	address &= ~(MLX5_NODNIC_VSC_ADDR_FLAG | MLX5_NODNIC_VSC_ADDR_SYND);

[Severity: Low]
This isn't a bug, but this masks off bits 31:30 of the address instead of
rejecting it. Neither mlx5_nodnic_vsc_read() nor mlx5_nodnic_vsc_write()
checks the syndrome bit after the flag changes.

Those address bits can only be set if the FW-supplied ctx->offset is
1 GiB or more. mlx5_vsc_gw_read() and mlx5_vsc_gw_write() in mlx5_core
skip the syndrome check as well.

Should an out-of-range address or a reported syndrome be returned as an
error here?

[ ... ]

> @@ -0,0 +1,828 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +// Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +
> +#include <linux/bitops.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/interrupt.h>
> +#include <linux/log2.h>
> +#include <linux/pci.h>
> +#include <net/netdev_lock.h>
> +#include <net/net_namespace.h>
> +
> +#include "en.h"
> +#include "nodnic_ifc.h"
> +#include "nodnic.h"
> +#include "nodnic_pci_vsc.h"
> +
> +#define MLX5_NODNIC_CQ_INIT_CMD_SN cpu_to_be32(2 << 28)
> +
> +static int mlx5_nodnic_write_ring_addr(struct mlx5_nodnic_core_dev *dev,
> +				       dma_addr_t dma_handle, u32 offset_h,
> +				       u32 offset_l)
> +{
> +	__be32 addr_h, addr_l;
> +	int err;
> +
> +	addr_h = cpu_to_be32(upper_32_bits(dma_handle));
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, offset_h, addr_h);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write ring addr high: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	addr_l = 0;
> +	MLX5_SET(nodnic_q_addr_l, &addr_l, q_addr_l,
> +		 lower_32_bits(dma_handle) >> 12);
> +
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, offset_l, addr_l);
> +	if (err)
> +		mlx5_nodnic_core_err(dev, "failed to write ring addr low: %d\n",
> +				     err);
> +	return err;
> +}
> +
> +static u32 mlx5_nodnic_calc_ring_size(struct mlx5_nodnic_core_dev *dev,
> +				      int stride)
> +{
> +	u32 ring_size = MLX5_NODNIC_RING_ENTRIES * stride;
> +	u32 max_supported = 1U << dev->log_max_ring_size;
> +
> +	return min(ring_size, max_supported);
> +}
> +
> +static int mlx5_nodnic_write_ring_size(struct mlx5_nodnic_core_dev *dev,
> +				       int offset, int size)
> +{
> +	__be32 addr_l;
> +	int err;
> +
> +	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx, offset, &addr_l);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev, "failed to read ring size: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	MLX5_SET(nodnic_q_addr_l, &addr_l, log_size, ilog2(size));
> +
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, offset, addr_l);
> +	if (err)
> +		mlx5_nodnic_core_err(dev, "failed to write ring size: %d\n",
> +				     err);
> +	return err;
> +}
> +
> +static int mlx5_nodnic_read_qn(struct mlx5_nodnic_core_dev *dev,
> +			       struct mlx5_nodnic_ring *ring, u32 offset)
> +{
> +	__be32 qn_dword;
> +	int err;
> +
> +	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx, offset, &qn_dword);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev, "failed to read queue number: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	ring->qn = MLX5_GET(nodnic_ring_q_number, &qn_dword, queue_number);
> +
> +	return 0;
> +}
> +
> +static int mlx5_nodnic_write_ring_dbr_addr(struct mlx5_nodnic_core_dev *dev,
> +					   u32 ring_offset)
> +{
> +	int off_h = ring_offset + MLX5_NODNIC_RING_DBR_ADDR_H;
> +	int off_l = ring_offset + MLX5_NODNIC_RING_DBR_ADDR_L;
> +	struct mlx5_nodnic_dbr *dbr = &dev->priv->dbr;
> +	__be32 dbr_h, dbr_l;
> +	int err;
> +
> +	dbr_l = 0;
> +	MLX5_SET(nodnic_ring_dbr_addr_l, &dbr_l, db_record_addr_l,
> +		 (u32)(dbr->dma_handle >> 2));
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, off_l, dbr_l);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write ring DBR addr low: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	dbr_h = cpu_to_be32(upper_32_bits(dbr->dma_handle));
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx, off_h, dbr_h);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write ring DBR addr high: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mlx5_nodnic_alloc_ring(struct mlx5_nodnic_core_dev *dev,
> +				  struct mlx5_nodnic_ring *ring, int size)
> +{
> +	dma_addr_t dma_handle;
> +	void *buf;
> +
> +	buf = dma_alloc_coherent(dev->device, size, &dma_handle, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	*ring = (struct mlx5_nodnic_ring) {
> +		.wq		= buf,
> +		.dma_handle	= dma_handle,
> +		.size		= size,
> +	};
> +
> +	return 0;
> +}
> +
> +static void mlx5_nodnic_free_ring(struct mlx5_nodnic_core_dev *dev,
> +				  struct mlx5_nodnic_ring *ring)
> +{
> +	dma_free_coherent(dev->device, ring->size, ring->wq,
> +			  ring->dma_handle);
> +	memset(ring, 0, sizeof(*ring));
> +}
> +
> +static int mlx5_nodnic_init_ring(struct mlx5_nodnic_core_dev *dev,
> +				 struct mlx5_nodnic_ring *ring, u32 ring_offset,
> +				 int stride)
> +{
> +	int ring_addr_h = ring_offset + MLX5_NODNIC_RING_ADDR_H;
> +	int ring_addr_l = ring_offset + MLX5_NODNIC_RING_ADDR_L;
> +	int size, err;
> +
> +	size = mlx5_nodnic_calc_ring_size(dev, stride);
> +
> +	err = mlx5_nodnic_alloc_ring(dev, ring, size);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_write_ring_addr(dev, ring->dma_handle, ring_addr_h,
> +					  ring_addr_l);
> +	if (err)
> +		goto err_ring_free;
> +
> +	err = mlx5_nodnic_write_ring_size(dev, ring_addr_l, size);
> +	if (err)
> +		goto err_ring_free;
> +
> +	ring->num_entries = size / stride;
> +
> +	err = mlx5_nodnic_read_qn(dev, ring,
> +				  ring_offset + MLX5_NODNIC_RING_QUEUE_NUMBER);
> +	if (err)
> +		goto err_ring_free;
> +
> +	err = mlx5_nodnic_write_ring_dbr_addr(dev, ring_offset);
> +	if (err)
> +		goto err_ring_free;
> +
> +	return 0;
> +
> +err_ring_free:
> +	mlx5_nodnic_free_ring(dev, ring);
> +	return err;
> +}
> +
> +static int mlx5_nodnic_alloc_dbr(struct mlx5_nodnic_core_dev *dev,
> +				 struct mlx5_nodnic_dbr *dbr)
> +{
> +	const u32 bytes = MLX5_NODNIC_DBR_WORDS * sizeof(__be32);
> +	dma_addr_t dma_handle;
> +	void *buf;
> +
> +	buf = dma_alloc_coherent(dev->device, bytes, &dma_handle, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	*dbr = (struct mlx5_nodnic_dbr) {
> +		.db		= (__be32 *)buf,
> +		.alloc_size	= bytes,
> +		.dma_handle	= dma_handle,
> +	};
> +
> +	return 0;
> +}
> +
> +static void mlx5_nodnic_free_dbr(struct mlx5_nodnic_core_dev *dev,
> +				 struct mlx5_nodnic_dbr *dbr)
> +{
> +	if (!dbr->db)
> +		return;
> +
> +	dma_free_coherent(dev->device, dbr->alloc_size, dbr->db,
> +			  dbr->dma_handle);
> +}
> +
> +static int mlx5_nodnic_init_cq_dbr(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_dbr *dbr = &dev->priv->cq.dbr;
> +	__be32 dbr_h, dbr_l;
> +	int err;
> +
> +	err = mlx5_nodnic_alloc_dbr(dev, dbr);
> +	if (err)
> +		return err;
> +
> +	dbr_l = cpu_to_be32(lower_32_bits(dbr->dma_handle));
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx,
> +					     MLX5_NODNIC_CQ_DBR_ADDR_L,
> +					     dbr_l);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write CQ DBR addr low: %d\n",
> +				     err);
> +		goto err_free_dbr;
> +	}
> +
> +	dbr_h = cpu_to_be32(upper_32_bits(dbr->dma_handle));
> +	err = mlx5_nodnic_vsc_cfg_write_be32(dev->vsc_ctx,
> +					     MLX5_NODNIC_CQ_DBR_ADDR_H,
> +					     dbr_h);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write CQ DBR addr high: %d\n",
> +				     err);
> +		goto err_free_dbr;
> +	}
> +
> +	dev->priv->cq.dbr.db[1] = MLX5_NODNIC_CQ_INIT_CMD_SN;
> +
> +	return 0;
> +
> +err_free_dbr:
> +	mlx5_nodnic_free_dbr(dev, &dev->priv->cq.dbr);
> +	return err;
> +}
> +
> +static void mlx5_nodnic_cleanup_cq_dbr(struct mlx5_nodnic_core_dev *dev)
> +{
> +	mlx5_nodnic_free_dbr(dev,  &dev->priv->cq.dbr);
> +}
> +
> +/* log_cq_size should be read after rq and sq ring sizes were set. */
> +static int mlx5_nodnic_read_cq_ring_size(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
> +	__be32 cq_addr_l;
> +	u32 log_cq_size;
> +	int err;
> +
> +	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx,
> +					    MLX5_NODNIC_PORT_CQ_ADDR_L,
> +					    &cq_addr_l);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev, "failed to read CQ ring size: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	log_cq_size = MLX5_GET(nodnic_q_addr_l, &cq_addr_l, log_size);
> +	cq->num_entries = 1ULL << log_cq_size;
> +	cq->log_num_entries = log_cq_size;
> +
> +	return 0;
> +}
> +
> +static int mlx5_nodnic_init_cq_ring(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
> +	struct mlx5_nodnic_ring *ring;
> +	int err;
> +
> +	ring = &cq->ring;
> +
> +	err = mlx5_nodnic_read_cq_ring_size(dev);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_alloc_ring(dev, ring,
> +				     cq->num_entries * MLX5_NODNIC_CQE_SIZE_B);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_write_ring_addr(dev, ring->dma_handle,

[Severity: High]
Does this leave the CQ log_size field set to zero?

mlx5_nodnic_read_cq_ring_size() reads log_size out of
MLX5_NODNIC_PORT_CQ_ADDR_L and sizes the CQ from it. Right after that,
mlx5_nodnic_write_ring_addr() starts from addr_l = 0, sets only q_addr_l
and writes the whole dword back to the same register. That clears the
log_size bits that were just read.

For the SQ and RQ, mlx5_nodnic_init_ring() follows the address write
with mlx5_nodnic_write_ring_size(), which does a read-modify-write and
puts log_size back. mlx5_nodnic_init_cq_ring() has no equivalent step,
and nothing else in mlx5_nodnic_open_cq() writes the CQ size.

FW might stop looking at log_size in this register once it has set it.
If it doesn't, the device would see a single-entry CQ while
cq->num_entries in the driver says otherwise. Completions would then
keep landing on the first CQE.

Should mlx5_nodnic_write_ring_addr() preserve the other bits of the low
dword with a read-modify-write? Or should the CQ path rewrite log_size
after the address, the way the SQ/RQ path does?

> +					  MLX5_NODNIC_PORT_CQ_ADDR_H,
> +					  MLX5_NODNIC_PORT_CQ_ADDR_L);
> +	if (err)
> +		goto err_free_cq;
> +
> +	return 0;
> +
> +err_free_cq:
> +	mlx5_nodnic_free_ring(dev, &cq->ring);
> +	return err;
> +}
> +
> +static void mlx5_nodnic_cleanup_cq_ring(struct mlx5_nodnic_core_dev *dev)
> +{
> +	return mlx5_nodnic_free_ring(dev, &dev->priv->cq.ring);
> +}
> +
> +static int mlx5_nodnic_read_cq_n(struct mlx5_nodnic_core_dev *dev)
> +{
> +	__be32 cq_n;
> +	int err;
> +
> +	err = mlx5_nodnic_vsc_cfg_read_be32(dev->vsc_ctx, MLX5_NODNIC_CQ_N,
> +					    &cq_n);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev, "failed to read CQ number: %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	dev->priv->cq.cqn = MLX5_GET(nodnic_cqn, &cq_n, cq_n);
> +
> +	return 0;
> +}
> +
> +int mlx5_nodnic_init_working_buffer(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_ring *work_buf = &dev->priv->working_buffer;
> +	u32 size = 1U << dev->log_working_buffer_size;
> +	int err;
> +
> +	err = mlx5_nodnic_alloc_ring(dev, work_buf, size);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_write_ring_addr(dev, work_buf->dma_handle,
> +					  MLX5_NODNIC_PORT_WORK_BUF_ADDR_H,
> +					  MLX5_NODNIC_PORT_WORK_BUF_ADDR_L);
> +	if (err)
> +		goto err_free_working_buffer;
> +
> +	return 0;
> +
> +err_free_working_buffer:
> +	mlx5_nodnic_free_ring(dev, work_buf);
> +	return err;
> +}
> +
> +int mlx5_nodnic_open_cq(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_cq *cq = &dev->priv->cq;
> +	int err;
> +
> +	cq->cc = 0;
> +
> +	err = mlx5_nodnic_init_cq_ring(dev);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_init_cq_dbr(dev);
> +	if (err)
> +		goto err_cleanup_ring;
> +
> +	err = mlx5_nodnic_read_cq_n(dev);
> +	if (err)
> +		goto err_cleanup_dbr;
> +
> +	return 0;
> +
> +err_cleanup_dbr:
> +	mlx5_nodnic_cleanup_cq_dbr(dev);
> +err_cleanup_ring:
> +	mlx5_nodnic_cleanup_cq_ring(dev);
> +	return err;
> +}
> +
> +static void mlx5_nodnic_close_cq(struct mlx5_nodnic_cq *cq)
> +{
> +	struct mlx5_nodnic_core_dev *dev =
> +		container_of(cq, struct mlx5_nodnic_priv, cq)->core_dev;
> +
> +	mlx5_nodnic_cleanup_cq_dbr(dev);
> +	mlx5_nodnic_cleanup_cq_ring(dev);
> +}
> +
> +int mlx5_nodnic_open_sq(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_priv *priv = dev->priv;
> +	struct mlx5_nodnic_sq *sq = &priv->sq;
> +	struct mlx5_nodnic_ring *ring;
> +	int err;
> +
> +	sq->netdev = priv->netdev;
> +	sq->device = dev->device;
> +	sq->pc = 0;
> +	sq->cc = 0;
> +	ring = &sq->ring;
> +
> +	err = mlx5_nodnic_init_ring(dev, ring, MLX5_NODNIC_SEND_RING_OFFSET,
> +				    MLX5_NODNIC_SQ_WQEBB_B);
> +	if (err)
> +		return err;
> +
> +	ring->lkey = dev->lkey;
> +
> +	return 0;
> +}
> +
> +static void mlx5_nodnic_close_sq(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_sq *sq = &dev->priv->sq;
> +
> +	mlx5_nodnic_free_ring(dev, &sq->ring);
> +}
> +
> +int mlx5_nodnic_open_rq(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_rq *rq = &dev->priv->rq;
> +	struct mlx5_nodnic_ring *ring;
> +	int err;
> +
> +	rq->pc = 0;
> +	rq->cc = 0;
> +	ring = &rq->ring;
> +
> +	err = mlx5_nodnic_init_ring(dev, ring, MLX5_NODNIC_RECEIVE_RING_OFFSET,
> +				    MLX5_NODNIC_RQ_STRIDE_BYTES);
> +	if (err)
> +		return err;
> +
> +	ring->lkey = dev->lkey;
> +
> +	return 0;
> +}
> +
> +static void mlx5_nodnic_close_rq(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_rq *rq = &dev->priv->rq;
> +
> +	mlx5_nodnic_free_ring(dev, &rq->ring);
> +}
> +
> +static int mlx5_nodnic_open_queues(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
> +	int err;
> +
> +	/* one doorbell record shared by both SQ and RQ */
> +	err = mlx5_nodnic_alloc_dbr(dev, &dev->priv->dbr);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_vsc_context_acquire(vsc_ctx);
> +	if (err)
> +		goto err_free_dbr;
> +
> +	err = mlx5_nodnic_open_sq(dev);
> +	if (err)
> +		goto err_release_vsc;
> +
> +	err = mlx5_nodnic_open_rq(dev);
> +	if (err)
> +		goto err_close_sq;
> +
> +	err = mlx5_nodnic_open_cq(dev);
> +	if (err)
> +		goto err_close_rq;
> +
> +	err = mlx5_nodnic_init_working_buffer(dev);
> +	if (err)
> +		goto err_close_cq;
> +
> +	mlx5_nodnic_vsc_context_release(vsc_ctx);
> +
> +	return 0;
> +
> +err_close_cq:
> +	mlx5_nodnic_close_cq(&dev->priv->cq);
> +err_close_rq:
> +	mlx5_nodnic_close_rq(dev);
> +err_close_sq:
> +	mlx5_nodnic_close_sq(dev);
> +err_release_vsc:
> +	mlx5_nodnic_vsc_context_release(vsc_ctx);
> +err_free_dbr:
> +	mlx5_nodnic_free_dbr(dev, &dev->priv->dbr);
> +
> +	return err;
> +}
> +
> +static void mlx5_nodnic_close_queues(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_priv *priv = dev->priv;
> +
> +	mlx5_nodnic_free_ring(dev, &priv->working_buffer);
> +	mlx5_nodnic_close_cq(&priv->cq);
> +	mlx5_nodnic_close_rq(dev);
> +	mlx5_nodnic_close_sq(dev);
> +	mlx5_nodnic_free_dbr(dev, &priv->dbr);
> +}
> +
> +static void mlx5_nodnic_update_carrier(struct mlx5_nodnic_priv *priv,
> +				       __be32 event)
> +{
> +	u32 port_state = MLX5_GET(nodnic_port_event, &event, port_state);
> +	bool up = port_state == MLX5_NODNIC_PORT_STATE_ACTIVE;
> +
> +	/* Force re-notification if state is unchanged */
> +	if (up == netif_carrier_ok(priv->netdev)) {
> +		netif_carrier_event(priv->netdev);
> +		return;
> +	}
> +	if (up) {
> +		netif_carrier_on(priv->netdev);
> +		netdev_info(priv->netdev, "Link up\n");
> +	} else {
> +		netif_carrier_off(priv->netdev);
> +		netdev_info(priv->netdev, "Link down\n");
> +	}
> +}
> +
> +static int mlx5_nodnic_refresh_carrier_locked(struct mlx5_nodnic_priv *priv)
> +{
> +	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
> +	struct mlx5_nodnic_vsc_ctx *vsc_ctx;
> +	__be32 event;
> +	int err;
> +
> +	vsc_ctx = dev->vsc_ctx;
> +	err = mlx5_nodnic_vsc_context_acquire(vsc_ctx);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_vsc_cfg_read_be32(vsc_ctx, MLX5_NODNIC_PORT_EVENT,
> +					    &event);
> +	mlx5_nodnic_vsc_context_release(vsc_ctx);
> +
> +	if (!err)
> +		mlx5_nodnic_update_carrier(priv, event);
> +
> +	return err;
> +}
> +
> +void mlx5_nodnic_refresh_carrier(struct mlx5_nodnic_priv *priv)
> +{
> +	mutex_lock(&priv->state_lock);
> +	if (test_bit(MLX5_NODNIC_STATE_OPENED, &priv->state))
> +		mlx5_nodnic_refresh_carrier_locked(priv);
> +	mutex_unlock(&priv->state_lock);
> +}
> +
> +int mlx5_nodnic_enable_port(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
> +	__be32 val = 0;
> +	int err;
> +
> +	/* data_msix_en, event_msix_en must be set before activating port */
> +	MLX5_SET(nodnic_port_network, &val, data_msix_en, 1);
> +	MLX5_SET(nodnic_port_network, &val, event_msix_en, 1);
> +	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
> +					     val);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write port network (msix): %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	MLX5_SET(nodnic_port_network, &val, network_en, 1);
> +	MLX5_SET(nodnic_port_network, &val, receive_filter_en, BIT(0));
> +
> +	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
> +					     val);
> +	if (err) {
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write port network (enable): %d\n",
> +				     err);
> +		return err;
> +	}
> +
> +	/* dma enabling requires a separate write */
> +	MLX5_SET(nodnic_port_network, &val, dma_en, 1);
> +
> +	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
> +					     val);
> +	if (err)
> +		mlx5_nodnic_core_err(dev,
> +				     "failed to write port network (dma): %d\n",
> +				     err);
> +	return err;
> +}
> +
> +void mlx5_nodnic_disable_port(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_vsc_ctx *vsc_ctx = dev->vsc_ctx;
> +	__be32 val;
> +	int err;
> +
> +	err = mlx5_nodnic_vsc_cfg_read_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
> +					    &val);
> +	if (err)
> +		goto out;
> +
> +	MLX5_SET(nodnic_port_network, &val, dma_en, 0);
> +	MLX5_SET(nodnic_port_network, &val, network_en, 0);
> +	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
> +					     val);
> +	if (err)
> +		goto out;
> +
> +	/* data_msix_en, event_msix_en can't be modified while port is active */
> +	MLX5_SET(nodnic_port_network, &val, data_msix_en, 0);
> +	MLX5_SET(nodnic_port_network, &val, event_msix_en, 0);
> +	err = mlx5_nodnic_vsc_cfg_write_be32(vsc_ctx, MLX5_NODNIC_PORT_NETWORK,
> +					     val);
> +
> +out:
> +	if (err)
> +		mlx5_nodnic_core_warn(dev,
> +				      "failed to read/write to vsc err %d\n",
> +				      err);
> +}
> +
> +static int mlx5_nodnic_init_uar_map(struct mlx5_nodnic_core_dev *dev)
> +{
> +	void __iomem *base;
> +	phys_addr_t paddr;
> +	u32 uar_page_size;
> +
> +	uar_page_size = 1 << dev->log_uar_page_size;
> +
> +	paddr = dev->bar_addr + (dev->send_ring0_uar_index * uar_page_size);

[Severity: High]
Can this multiplication wrap?

dev->send_ring0_uar_index and uar_page_size are both u32, so the product
is computed in 32 bits and only widened to phys_addr_t for the addition
to dev->bar_addr. With a 4 KiB UAR page, any index of 0x100000 or more
wraps. ioremap() then maps a page at the wrong offset in BAR 0, possibly
overlapping the init segment or other device registers.

dev->uar_base is meant to be the TX doorbell page; probe insists on
support_uar_tx_doorbell. With a wrapped offset, doorbell writes would go
to whatever register happens to sit at that offset.

Should the product be computed as
(phys_addr_t)dev->send_ring0_uar_index * uar_page_size? Both values come
from FW, so it also seems worth checking that the mapped range fits
inside pci_resource_len(pdev, 0) before calling ioremap().

> +
> +	base = ioremap(paddr, uar_page_size);
> +	if (!base) {
> +		mlx5_nodnic_core_err(dev, "failed to map UAR\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev->uar_base = base;
> +
> +	return 0;
> +}
> +
> +static void mlx5_nodnic_cleanup_uar_map(struct mlx5_nodnic_core_dev *dev)
> +{
> +	if (!dev->uar_base)
> +		return;
> +
> +	iounmap(dev->uar_base);
> +	dev->uar_base = NULL;
> +}
> +
> +static int mlx5_nodnic_open_locked(struct net_device *netdev)
> +{
> +	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
> +	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
> +	int err;
> +
> +	err = mlx5_nodnic_init_uar_map(dev);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_nodnic_open_queues(dev);
> +	if (err)
> +		goto err_uar;
> +
> +	set_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
> +
> +	err = mlx5_nodnic_refresh_carrier_locked(dev->priv);
> +	if (err)
> +		netdev_err(dev->priv->netdev,
> +			   "failed to query carrier, err=%d\n", err);
> +
> +	return 0;
> +
> +err_uar:
> +	mlx5_nodnic_cleanup_uar_map(dev);
> +	return err;
> +}
> +
> +int mlx5_nodnic_open(struct net_device *netdev)
> +{
> +	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
> +	int err;
> +
> +	mutex_lock(&priv->state_lock);
> +	err = mlx5_nodnic_open_locked(netdev);
> +	mutex_unlock(&priv->state_lock);
> +
> +	return err;
> +}
> +
> +static int mlx5_nodnic_close_locked(struct net_device *netdev)
> +{
> +	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
> +	struct mlx5_nodnic_core_dev *dev = priv->core_dev;
> +
> +	clear_bit(MLX5_NODNIC_STATE_OPENED, &priv->state);
> +	netif_carrier_off(priv->netdev);
> +	netdev_info(priv->netdev, "Link down\n");
> +	mlx5_nodnic_close_queues(dev);
> +
> +	return 0;
> +}
> +
> +int mlx5_nodnic_close(struct net_device *netdev)
> +{
> +	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
> +	int err = 0;
> +
> +	mutex_lock(&priv->state_lock);
> +	if (!test_bit(MLX5_NODNIC_STATE_OPENED, &priv->state)) {
> +		mutex_unlock(&priv->state_lock);
> +		return 0;
> +	}
> +
> +	err = mlx5_nodnic_close_locked(netdev);
> +	mutex_unlock(&priv->state_lock);
> +
> +	mlx5_nodnic_cleanup_uar_map(priv->core_dev);
> +
> +	return err;
> +}
> +
> +static const struct net_device_ops mlx5_nodnic_netdev_ops = {
> +	.ndo_open		= mlx5_nodnic_open,
> +	.ndo_stop		= mlx5_nodnic_close,
> +};
> +
> +void mlx5_nodnic_build_netdev(struct net_device *netdev)
> +{
> +	struct mlx5_nodnic_priv *priv = netdev_priv(netdev);
> +	struct mlx5_nodnic_core_dev *core_dev;
> +
> +	core_dev = priv->core_dev;
> +
> +	SET_NETDEV_DEV(netdev, core_dev->device);
> +
> +	netdev->netdev_ops = &mlx5_nodnic_netdev_ops;
> +	netdev->request_ops_lock = true;
> +
> +	eth_hw_addr_set(netdev, core_dev->mac_address);
> +}
> +
> +static void mlx5_nodnic_init_priv(struct mlx5_nodnic_priv *priv,
> +				  struct net_device *netdev,
> +				  struct mlx5_nodnic_core_dev *core_dev)
> +{
> +	priv->netdev = netdev;
> +	priv->core_dev = core_dev;
> +	mutex_init(&priv->state_lock);
> +}
> +
> +static void mlx5_nodnic_cleanup_priv(struct mlx5_nodnic_priv *priv)
> +{
> +	mutex_destroy(&priv->state_lock);
> +}
> +
> +struct net_device *mlx5_nodnic_create_netdev(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_priv *priv;
> +	struct net_device *netdev;
> +
> +	netdev = alloc_etherdev_mqs(sizeof(struct mlx5_nodnic_priv), 1, 1);
> +	if (!netdev)
> +		return NULL;
> +
> +	priv = netdev_priv(netdev);
> +	mlx5_nodnic_init_priv(priv, netdev, dev);
> +	dev->priv = priv;
> +
> +	netif_carrier_off(netdev);
> +	netif_tx_disable(netdev);
> +	dev_net_set(netdev, &init_net);
> +
> +	return netdev;
> +}
> +
> +void mlx5_nodnic_cleanup_netdev(struct mlx5_nodnic_core_dev *dev)
> +{
> +	struct mlx5_nodnic_priv *priv;
> +	struct net_device *netdev;
> +
> +	if (!dev->priv)
> +		return;
> +
> +	priv = dev->priv;
> +	netdev = priv->netdev;
> +	if (!netdev)
> +		return;
> +
> +	if (dev->netdev_registered) {
> +		netif_device_detach(netdev);
> +		unregister_netdev(netdev);
> +		dev->netdev_registered = false;
> +	}
> +
> +	mlx5_nodnic_cleanup_priv(priv);
> +	dev->priv = NULL;
> +
> +	free_netdev(netdev);
> +}

[Severity: Critical]
Is the log_size written here meant to be in bytes or in entries?

mlx5_nodnic_calc_ring_size() returns a byte count,
MLX5_NODNIC_RING_ENTRIES * stride. That is 1024 * 64 = 64 KiB for the
SQ and 1024 * 16 = 16 KiB for the RQ. mlx5_nodnic_write_ring_size() then
programs ilog2() of that byte count into the log_size field of
nodnic_q_addr_l.

The CQ path reads the same log_size field of nodnic_q_addr_l and treats
it as an entry count. mlx5_nodnic_read_cq_ring_size() sets
cq->num_entries to 1 << log_cq_size, and mlx5_nodnic_init_cq_ring()
allocates num_entries * MLX5_NODNIC_CQE_SIZE_B bytes.

If the SQ/RQ field has the same meaning, the device is told the SQ has
65536 WQEBBs and the RQ has 16384 entries. Only 1024 of each were
allocated with dma_alloc_coherent(). Once the device's view of the ring
goes past the allocation, it would read or write beyond the end of the
coherent buffer.

The clamp in mlx5_nodnic_calc_ring_size() has the same problem. It
compares the byte count against 1U << dev->log_max_ring_size, so if
log_max_ring_size is in entries, the cap is off by a factor of stride.
log_max_ring_size is also a 6-bit FW field, so a value of 32 or more
makes the shift undefined.

Could you confirm which units the HW spec uses for log_size and
log_max_ring_size, and make the SQ, RQ and CQ paths agree on them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008171821.660739-1-tariqt%40nvidia.com
