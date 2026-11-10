Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322309;
	b=vb/vZI+sTWZEjv45jPKwFNg6+IBB5MJ1bqeEgt5r+2GbkEX3wJ34I2he9ZukH12CA7GJ
	 zGdQ0JvMKIabZUaBNh67qv24eICFn/wJszu4FVbWugI+MciuBogEdoN7kd5hQ76q7RxNG
	 IZWCNynU27zfkBjHO8lZ2IRV9RoYJxxTPctGgyiPOZ40SDHHHowGnHf95GmN4Fol923yi
	 fksT+QW74CaiZwFp3frG8XUB9xAIgqckn2xeJhgD1hRinCOxIycFsM19tha75sEg3OOWL
	 VvmebvSn6N5h1heFGFQQwt+utFPEJIhanhWY54jp16IRrGKPL03u1ZRP2B5Eq6CDvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322309;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e1KpTWu4eWR69Fbxd+V1cdxC0knFqwScyCQVEkuHsB0=;
	b=n+a7gHJI7mheFPsPiWIN1IZMROxPYmS5b3HtZyVr+azIx6mRMf9rilwjWGR3JJqmL798
	 O6OtoqBclr7DMZl5ALVRD2x4gsVWoR0XmtE5vqWR9RIJIKq61nzJf/vEa0GIG7OhUosDv
	 Qy6MJGmT82OjQDs4bSMX7oBQtUFWLLsRZz3oGcSSxmNG9uOihoT6hBpsJGkWHhAYFmmr3
	 LxzucKWp+Q5n5lTD0Hu8qiVWtHAnTD32XaCEN4avtklubBVI8XjA2P0eSn22ugAnaSd3E
	 +4uzzyVcN6Z/trfQA28eDcH8QuG+QUhcB4p1y0KBH9lrq5tK3BjdRWMkuvZujexsfZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGsiiQ0o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8860A3801;
	Tue, 10 Nov 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGsiiQ0o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0AE1F008A6;
	Tue, 10 Nov 2026 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322308;
	bh=e1KpTWu4eWR69Fbxd+V1cdxC0knFqwScyCQVEkuHsB0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EGsiiQ0oqWPL/dxaJul5vkWvAKDLe4buGaCOrro0H7mLKo7/DY5eglX0R30fHpQJm
	 FfsZUED0fJHoPZAcOXXGI7YK/rERfliR6wpOeKSaKg+/QLA8IA9JbZl4G4JRNwR36v
	 M81nOSZzuC0PfgPVdtlsYzhanJfi0LrgzYgmxiSxXLvWXUKYkmqJKg2DyIFizXIrcG
	 IfX5UpFb/PY6DkfbPPYsQSSKfiQL9ZduY4mghZUnPHDscvdxvgQJ3W5gVLM0q6DNXO
	 mcYbah+Ut1EWVXx9H3BfK4H7qA7JK7W25R9c1tXNb1e8s3iT5QlISCylqVUXJrARRb
	 sKqqxVA88gFKg==
Subject: Re: [PATCH v33 net-next 7/8] net/nebula-matrix: add common/ctrl dev
 init/remove operation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:47 +0000
Message-ID: <179432230770.994134.2864379401996403810@kernel.org>
In-Reply-To: <20261106045631.2224-8-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-8-illusion.wang@nebula-matrix.com>
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

- [Low] The comment in nbl_dev_init_msix_cnt()
  (drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c) says the…
- [Low] nbl_dev_setup_common_dev() (nbl_dev.c) explains why VSI/ETH
  identity is not fetched at init: "the control PF's responder may still…
- [Low] This patch adds the first caller of cfg_chan_qinfo_map_table
  (nbl_dev_setup_chan_qinfo()) and puts the responder-teardown…

--

net/nebula-matrix: add common/ctrl dev init/remove operation

This commit adds nbl_dev.c with nbl_dev_init() and nbl_dev_remove(). These
set up the mailbox clean work and the mailbox channel queue. On the control
PF they also program the mailbox QINFO routing and run init_module. The new
entry points are called from nbl_core_init() and nbl_core_remove().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 0000000000000..01287c39a9655
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,303 @@

[ ... ]

> +static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
> +{
> +	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> +	struct nbl_msix_info *msix_info = &dev_common->msix_info;
> +
> +	/* Reserve one MSI-X vector for the mailbox.  Nothing here
> +	 * allocates or requests it: vectors are allocated and the handler
> +	 * attached when the device is started, after probe, from this
> +	 * count.
> +	 */

[Severity: Low]
This isn't a bug, but is "after probe" accurate here?

nbl_dev_start() arrives later in the series, in "net/nebula-matrix: add
common dev start/stop operation". By the end of the series it is called
from inside nbl_probe():

nbl_probe() {
    ...
	pci_set_master(pdev);
	pci_set_drvdata(pdev, adapter);
	err = nbl_core_start(adapter);
	if (err) {
		nbl_core_remove(adapter);
		pci_clear_master(pdev);
	}
	return err;
}

So if start fails, the probe fails. The comment above
nbl_hw_clear_stale_status() in nbl_hw_leonis.c agrees: it says sibling
PFs' RPCs "time out in nbl_dev_start() and their probes fail".

The "after probe" wording is still there at the end of the series. Should
it say the vectors are allocated in the start path, during probe?

> +	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
> +}
> +
> +/* ----------  Channel config  ---------- */
> +static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
> +{

[ ... ]

> +	chan_ops->cfg_chan_qinfo_map_table(priv, common->hw_bus, common->devid);
> +}

[Severity: Low]
This isn't a bug, but this patch adds the first caller of
cfg_chan_qinfo_map_table, and that makes a few existing comments wrong.
All three are unchanged at the end of the series.

nbl_chan_cfg_qinfo_map_table() in nbl_channel.c still says:

	 * 0xfe/0xfc/0xf0.  Nothing enforces that here: the resource layer
	 * that validates the mask, and every caller of this op, arrive in
	 * later patches of this series.

But nbl_res_init_pf_num() already rejects non-contiguous masks and any
pf_num outside {1, 2, 4}, and this patch adds the caller.

nbl_res_init_pf_num() in nbl_resource_leonis.c says:

	 * this running first: resource init completes before the channel
	 * layer is set up.

nbl_core_init() actually calls nbl_chan_init_common() before
nbl_res_init_leonis(). The dependency only holds because the QINFO
programming happens here in nbl_dev_init(), which runs after resource
init.

The kernel-doc for struct nbl_dispatch_ops in nbl_def_dispatch.h says the
teardown order "is documented with the code that performs it, in the next
patch in this series". This is that patch, and the text went into
nbl_disp_remove(), which does no teardown itself.

Could these three comments be updated? Could the "next patch in this
series" reference also be removed before the code is merged?

> +/* ----------  Dev init process  ---------- */
> +static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
> +{

[ ... ]

> +	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
> +				   &common_dev->clean_mbx_task);
> +	/*
> +	 * VSI/ETH identity is deliberately not fetched here: it is only
> +	 * known to the control PF, so it has to come from a mailbox RPC,
> +	 * and the control PF's responder may still be probing while this
> +	 * function runs.  The fetch is therefore left to the start path.
> +	 */

[Severity: Low]
Can the control PF's responder still be probing when a sibling PF reaches
this point?

nbl_probe() calls nbl_probe_chip_deps() before nbl_core_init(). For a
non-control PF, nbl_probe_chip_deps() holds func 0's device lock and
defers the probe:

nbl_probe_chip_deps() {
    ...
	if (mgt->dev.driver != pdev->dev.driver ||
	    mgt->dev.links.status != DL_DEV_DRIVER_BOUND) {
		device_unlock(&mgt->dev);
		pci_dev_put(mgt);
		return -EPROBE_DEFER;
	}
    ...
}

driver_bound() only sets DL_DEV_DRIVER_BOUND after func 0's entire
->probe() has returned, and that includes nbl_dev_init() and init_module.

The header comment for nbl_dev_remove_ctrl_dev() in this same file says the
opposite:

 * between.  A sibling therefore cannot
 * reach its mailbox setup before the control PF is fully probed, nor

The commit message of the last patch in the series says the same thing.

Should this comment give a different reason for deferring the fetch? It is
still present at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
