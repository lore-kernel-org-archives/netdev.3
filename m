Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569263AFB06;
	Mon, 14 Sep 2026 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370477; cv=none; b=DH0C0nwMGkNE58iS5nS/3gKo4dCy4+60NN+riz/xanO+iw0NHxSVJGwa6ifO66jSZBEcIAUWlLwp4cDIgbx30viwTaZriufB8h9KG4njO1Pgto69f4rp+8w4e1vtNump38dPaECrYsOKvyeBoKXBiDk+EGKB++yA7cSdX34nhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370477; c=relaxed/simple;
	bh=YJ6g7kurmpyeZnwP2rn3WDXK74YKb8W78izUn13Iruw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnuz/Pv52CdhsQsqZKdz8U8dwtzPGMs+Fdi2QivpXg+OkWf3CZHg1Hk6C0gGf+To4qNTFlweA3ccUwPL0aBknky1g+sQjNw/XKL+NKNA+z/G/G0KrZcz6AWrR58rEQk9h9W+a6VvuEA59uoQGhZNID4/ZEIfmrsougdacNmQWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bmhj2c55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bmhj2c55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724061F000FF;
	Mon, 14 Sep 2026 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370468;
	bh=q8pHCJRKSkoWRdI92fOmPH+dnDohq3/AXLMmnH/vqlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bmhj2c55zIDuV03l4BNvWZc+J7+O09OcBh3YB7eHwVDL+Nc3xi1oyZ/vLlS/87cEF
	 mJJOs7p4AdvWW6JEXkHVwGoj8SGv9PDBl2Td3hSGBmr0P+M6hz/8QUYQEGRTpyyyM5
	 ebDAL4y4LzfonIS0kNsYVgxRK+BjKVNsFQZZA4dW8uyauyHJQ0axfYqKiSC7nYphKu
	 EsWtGoAXyhe5fkEAcMgZJrBK8WUu7ye35GcmU1YoGyqLlWl8/I6qhRt+V03koP6U9q
	 md3b4nViwXoh9yBmRfiVViDfJ8itJj106lr2c0j7aIBMR2l6jS6/tBkY0cf/14ybwY
	 TyloupSvVlhdQ==
From: Simon Horman <horms@kernel.org>
To: han.junyang@zte.com.cn
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=20net-next=20v2=203/3=5D=20dinghai=3A=20add=20async=20event=20queue=20for=20firmware=C2=A0notifications?=
Date: Mon, 14 Sep 2026 08:20:51 +0100
Message-ID: <20260914072101.233003-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911120507276-LIb4JGajTovY-mjFYhKq@zte.com.cn>
References: <20260911120507276-LIb4JGajTovY-mjFYhKq@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260911115929435mXJzcTF08xlUAdjnT8qqm@zte.com.cn?part=3
---
dinghai: add async event queue for firmware notifications

This commit adds an event queue table and an async event queue for firmware
notifications. The queue claims an MSI-X vector from the async pool and maps
firmware events to notifier chains.

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> --- a/drivers/net/ethernet/zte/dinghai/en_pf.c
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
[ ... ]
> @@ -612,12 +612,26 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_irq_table;
>  	}
>  
> +	ret = zxdh_pf_eq_table_init(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_eq_table_init failed: %d\n", ret);
> +		goto err_eq_table;
> +	}
> +
> +	ret = zxdh_pf_eq_table_create(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_eq_table_create failed: %d\n", ret);
> +		goto err_eq_table;
> +	}
> +
>  	devlink_register(devlink);
>  
>  	return 0;
>  
> +err_eq_table:
> +	zxdh_pf_eq_table_destroy(zxdh_dev);
>  err_irq_table:
> -	kvfree(zxdh_dev->irq_table.priv);
> +	zxdh_pf_irq_table_destroy(zxdh_dev);
>  err_cfg_init:
>  	zxdh_pf_pci_close(zxdh_dev);

[Severity: Medium]
Does this error path leak the modern configuration MMIO mappings?

The zxdh_pf_modern_cfg_init() function successfully maps several capabilities.
If a subsequent step fails (such as zxdh_pf_eq_table_init() or other device
initialization checks), the code jumps to err_eq_table and falls through to
err_cfg_init. However, this label only calls zxdh_pf_pci_close() and misses
a call to zxdh_pf_modern_cfg_uninit(), leaving the memory mapped.

>  err_pci_init:
[ ... ]
> diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_eq.c b/drivers/net/ethernet/zte/dinghai/zxdh_eq.c
> --- /dev/null
> +++ b/drivers/net/ethernet/zte/dinghai/zxdh_eq.c
[ ... ]
> +static u16 zxdh_eq_event_id_get(struct zxdh_core_dev *zxdh_dev)
> +{
> +	struct zxdh_pf_dev *pf_dev = zxdh_dev->priv;
> +	void __iomem *subchan;
> +
> +	subchan = pf_dev->pci_ioremap_addr[0] + ZXDH_BAR_MSG_SUBCHAN_RECV;
> +
> +	return ioread32(subchan) >> 16;
> +}

[Severity: High]
Is there a risk of an out-of-bounds MMIO read here?

The device blindly maps BAR 0 based on pci_resource_len() during
zxdh_pf_pci_init(). If the hardware or an emulated environment exposes a
truncated BAR 0 length that is smaller than 0x2804 bytes, reading from
ZXDH_BAR_MSG_SUBCHAN_RECV (offset 0x2800) could exceed the mapped boundaries
and cause a page fault or oops.

[ ... ]
> +int zxdh_pf_eq_table_create(struct zxdh_core_dev *zxdh_dev)
> +{
> +	struct zxdh_pf_eq_table *pf_eq_table = zxdh_dev->eq_table.priv;
> +	struct zxdh_eq_table *table = &zxdh_dev->eq_table;
> +	struct zxdh_eq_async *eq = &pf_eq_table->riscv_eq;
> +	int err;
> +
> +	mutex_lock(&table->lock);
> +
> +	eq->priv = zxdh_dev;
> +	eq->irq = zxdh_pf_async_irq_request(zxdh_dev);
> +	if (IS_ERR(eq->irq)) {
> +		err = PTR_ERR(eq->irq);
> +		goto unlock;
> +	}

[Severity: High]
Could this lead to an invalid pointer dereference on the cleanup path?

If zxdh_pf_async_irq_request() fails (e.g., due to memory exhaustion), it
returns an error pointer like ERR_PTR(-ENOMEM). This error pointer is
assigned to eq->irq but is not cleared to NULL before jumping to unlock.

When the error propagates, zxdh_pf_probe() jumps to the err_eq_table label
and calls zxdh_pf_eq_table_destroy().

Because eq->irq contains an error pointer, the cleanup check in
zxdh_pf_eq_table_destroy():

    if (eq->irq) {
        zxdh_irq_detach_nb(eq->irq, &eq->irq_nb);
        ...

will evaluate to true, and zxdh_irq_detach_nb() will attempt to dereference
the error pointer, causing a kernel panic.

> +
> +	eq->irq_nb.notifier_call = zxdh_eq_async_riscv_int;
> +	err = zxdh_irq_attach_nb(eq->irq, &eq->irq_nb);
[ ... ]
