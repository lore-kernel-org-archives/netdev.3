Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932177;
	b=FYYlX6T4ik2G8iRFv5t+1YiJ2s642xkpVrL0klLaAgkbPlOgLyP3PFGCGFwbbZsi4Hkt
	 Re2TPFbo29OEypwQ5BFidnouayfAz1fVav7748C7uKF5npw/v6aUFllqgLDmpZ11uSlGW
	 AL31M617nLNFwl3nTIdJeA8JzUlO+gLHQkgSFHd1uelXq9sFqek13Xexp3uFHGZ+zsZ5Y
	 Jp5Npt/S84T4QqCnSAaFpJ/xiVpOh4swCSOR3mQ/eDg5adZOe80zSE7rqN4/QKNTb1xLk
	 shixy7OzxUBkZ17nC9nsyV/9TQfBiy7Nn8WnPeH3revQ8hcMyC/+Msg98547PCGypKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932177;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WM/BmbROtbBCexKydEHL2ksSUk/oHonsLASEjjScSDo=;
	b=32cHvOxdBQDWSHjZWE1JEmJIJ8O3NQOJk9btoAXxvYEjnXpfBPmfNW+P8YOnhaHVDdMn
	 ziUtr5wM9ujVGayDDJGm31yfWsly3h+Rn8tIGIWRM1hAzCAUxEVcfFTE9EYGFQMv5D0Aa
	 8/e2EoTxdD/XPUNaIujoQQJpOt0wzJZ8iUnbmp9q/oZ804MRrQnQe/OkuowD+D+VYgdkW
	 IjksgvS9grppNwGwskanHsTGFZDWsS3EcKiO0t3btuZcj3dRv3FTsaOCvsK2OGlNKPbxc
	 TE+1iFdw7kWL88xB1tjuCdgCUAg2YpcbeHBzQD1doE3VC2CpDfSbvaQkvBvZXmMx/6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czFFrcF3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DA606A31A;
	Sun, 25 Oct 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czFFrcF3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9E61F01825;
	Sun, 25 Oct 2026 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792932176;
	bh=WM/BmbROtbBCexKydEHL2ksSUk/oHonsLASEjjScSDo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=czFFrcF3I1xvonMXaRgTS56/7xoloRIN1gS+nFb9iQ45BZ5ljqspE1NCQ2GT5kGuj
	 ml8Cll30F1kjbIj4kIEZi1btbbxBhxyGMHCtEGrqExh6TG8fxlb74mGmznCnriGycL
	 zC11/jd6U8ujUXXbZWoF8/hXZR815hBwQT+p32NO9/aHqrmf88VjUOijgZC4rYj5ks
	 HfazE8iKBox1HEkAahlU6uODO8MEFbAAL6VU5oaILeYGGhBvM1ctJZwGV8576kpqqH
	 C+scCqnHW4aE+mGzj8eNN1H3izef9ZcZrMNHcRWD4Ph0IExtGBQr3JlerLkBSmarOD
	 FC0pj3IPODMcA==
Subject: Re: [PATCH v2 net 1/3] net: hns3: fix vector resource leak in
 hns3_nic_alloc_vector_data
From: netdev-bot+sashiko@kernel.org
To: shaojijie@huawei.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
 liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com,
 ningwei15@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 12:42:55 +0000
Message-ID: <179293217584.3134.1103079480225679439@kernel.org>
In-Reply-To: <20261021121426.3096838-2-shaojijie@huawei.com>
References: <20261021121426.3096838-2-shaojijie@huawei.com>
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

- [Low] The commit message says it sets `priv->vector_num = 0` in the new
  `err_put_vector` path of `hns3_nic_alloc_vector_data()`…

Pre-existing issues:
- [Medium] `hns3_nic_alloc_vector_data()` accepts a 0 return from
  `get_vector()` as success.

--

net: hns3: fix vector resource leak in hns3_nic_alloc_vector_data

This patch fixes the devm_kcalloc() failure path in
hns3_nic_alloc_vector_data(). On that path, the MSI-X vectors obtained
from get_vector() are now handed back with put_vector() and
priv->vector_num is reset to 0. The success and error exits are also
split.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 47788be64be68..2f3aeade558cd 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -4854,7 +4854,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
>  			     GFP_KERNEL);
>  	if (!priv->tqp_vector) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_put_vector;
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. What
happens if get_vector() returns 0 here?

hns3_nic_alloc_vector_data() {
    ...
	vector_num = h->ae_algo->ops->get_vector(h, vector_num, vector);

	priv->vector_num = vector_num;
	priv->tqp_vector = (struct hns3_enet_tqp_vector *)
		devm_kcalloc(&pdev->dev, vector_num, sizeof(*priv->tqp_vector),
			     GFP_KERNEL);
    ...
}

With a zero count, devm_kcalloc() returns ZERO_SIZE_PTR rather than NULL.
The -ENOMEM check above would not fire, and the function would return
success.

hns3_nic_init_vector_data() would then run:

	for (i = 0; i < h->kinfo.num_tqps; i++) {
		u16 vector_i = i % priv->vector_num;
		...
		tqp_vector = &priv->tqp_vector[vector_i];

Wouldn't that divide by zero, with priv->tqp_vector pointing at
ZERO_SIZE_PTR?

This looks hard to hit in practice. In hclge_get_vector(), a zero return
needs num_msi_left (or num_nic_msi - 1) to be 0. The HNAE3_MIN_VECTOR_NUM
checks and the pci_alloc_irq_vectors() minimum normally prevent that. The
leak closed by this patch was the only known way to drain num_msi_left.

Would a zero check on the get_vector() result still be worth adding?

[ ... ]

> -out:
> +	devm_kfree(&pdev->dev, vector);
> +	return 0;
> +
> +err_put_vector:
> +	for (i = 0; i < vector_num; i++)
> +		h->ae_algo->ops->put_vector(h, vector[i].vector);
> +	priv->vector_num = 0;

[Severity: Low]
The commit message says:

    Call put_vector() for every vector acquired by get_vector() before
    returning an error, and reset priv->vector_num so the dealloc path
    cannot dereference a NULL priv->tqp_vector.

Is the dealloc path reachable after hns3_nic_alloc_vector_data() fails?

On failure, hns3_client_init() jumps to out_alloc_vector_data, and
hns3_reset_notify_init_enet() jumps to err_put_ring:

	ret = hns3_nic_alloc_vector_data(priv);
	if (ret)
		goto err_put_ring;

Both labels are below the calls to hns3_nic_uninit_vector_data() and
hns3_nic_dealloc_vector_data(), so neither helper runs.

The later teardown paths, hns3_reset_notify_uninit_enet() and
hns3_client_uninit(), return early. HNS3_NIC_STATE_INITED is only set
after init fully succeeds:

	if (!test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state)) {
		netdev_warn(netdev, "already uninitialized\n");
		return 0;
	}

hns3_change_channels() also only calls UNINIT_CLIENT once INIT_CLIENT has
succeeded.

The reader that does benefit from the reset seems to be the debugfs
coalesce dump. hns3_dump_coal_info() loops over priv->vector_num and
indexes priv->tqp_vector[i] without an INITED check:

	for (i = 0; i < priv->vector_num; i++) {
		tqp_vector = &priv->tqp_vector[i];
		hns3_get_coal_info(tqp_vector, s, i, is_tx);
	}

Could the commit message name that path instead of the dealloc path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021121426.3096838-1-shaojijie%40huawei.com
