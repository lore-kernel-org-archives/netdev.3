Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F893033DF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096971; cv=none; b=NG2sJFdoBnswjHZBaCGeBpxeABgvPxh4RC8o1u+vdwnT0oB+OdGEdPRdnbPU/px8+ByMtdMBlRVGKjv9FF1gPijSk5CbZc3Mw3uVG+ntfguxz6EpX1I8JU6NXmYqPE7ZqdK5wKXDMQLr+nZtk1RQzTHD2+1pRRm8yBjVw1f7Vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096971; c=relaxed/simple;
	bh=2ZIadZfnwGR+rR3E8xPHbf8ulPp8/n6NwtJ4i2rxkqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrxqC+dpcLBbzQOzHgTn3rrmpz8fHDAWJ2lskfrLHMUGfFwJ0iq/uaOVAENhbpSH4OslnO0vXLtViU0N0B9RIhrgjr3cOZmUW/pl5OKcEThb4F3cChHqHN61/P5Bgx6EIKsfWvW35bSOV9GjBQ2X67ZKb2Rku4A5NG1m4w78nhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTqb7I02; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTqb7I02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783096968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxRNRltqewzagAgkP1r/1SJPCCrK9xhR2ZkTX5tzEsA=;
	b=bTqb7I02FWrvGIzlnT1/U2F6I0g/0hrDnTpwzxnC9EaESZbd46mkwA5Qg0DXRPK3102EZO
	C9+ofzThEYjYYt3Iolj5oBFX7+iwUJ+uHZsCK/JIEYOZW+p1BQ3T4gnkpghoJGd+OPrniH
	ROEg1KUMWKVFFJxlP11FrDUa284PxEo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-g1WsvhRbPsmy6EnB1M7SnQ-1; Fri,
 03 Jul 2026 12:42:45 -0400
X-MC-Unique: g1WsvhRbPsmy6EnB1M7SnQ-1
X-Mimecast-MFC-AGG-ID: g1WsvhRbPsmy6EnB1M7SnQ_1783096964
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03FB61863B07;
	Fri,  3 Jul 2026 16:42:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B670430030DB;
	Fri,  3 Jul 2026 16:42:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v7 1/2] dinghai: add ZTE network driver support
Date: Fri,  3 Jul 2026 18:42:32 +0200
Message-ID: <20260703164232.336162-1-pabeni@redhat.com>
In-Reply-To: <20260630111300830lukBczfNSgWE5wt6qR95k@zte.com.cn>
References: <20260630111300830lukBczfNSgWE5wt6qR95k@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
dinghai: add ZTE network driver support

Add basic framework for ZTE DingHai ethernet PF driver, including
Kconfig/Makefile build support and PCIe device probe/remove skeleton.

> diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
> new file mode 100644
> index 0000000000000..b492fd2c261b8
> --- /dev/null
> +++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
[ ... ]
> +static int dh_pf_pci_init(struct dh_core_dev *dev)
> +{
> +	struct zxdh_pf_device *pf_dev = dev->priv;
> +	int ret;
[ ... ]
> +	pf_dev->pci_ioremap_addr[0] =
> +		ioremap(pci_resource_start(dev->pdev, 0),
> +			pci_resource_len(dev->pdev, 0));

[Severity: Medium]
Should this check if BAR 0 is actually an IORESOURCE_MEM before mapping it?

Calling ioremap() on an I/O port address or an unpopulated BAR could map
arbitrary physical memory.

Would it be safer to use pci_ioremap_bar() or pcim_iomap() which enforce
resource type and length checks?

> +	if (!pf_dev->pci_ioremap_addr[0]) {
> +		ret = -ENOMEM;
> +		dev_err(dev->device, "dh pf pci ioremap failed\n");
> +		goto err_pci_save_state;
> +	}
[ ... ]
> +static void dh_pf_remove(struct pci_dev *pdev)
> +{
> +	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
> +	struct devlink *devlink = priv_to_devlink(dh_dev);
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +
> +	devlink_unregister(devlink);
> +	dh_pf_pci_close(dh_dev);
> +	mutex_destroy(&pf_dev->irq_lock);
> +	mutex_destroy(&dh_dev->lock);
> +	dh_core_free_priv(dh_dev);
> +	devlink_free(devlink);
> +	pci_set_drvdata(pdev, NULL);
> +}
> +
> +static void dh_pf_shutdown(struct pci_dev *pdev)
> +{
> +	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
> +	struct devlink *devlink = priv_to_devlink(dh_dev);
> +	struct zxdh_pf_device *pf_dev = dh_dev->priv;
> +
> +	devlink_unregister(devlink);
> +	dh_pf_pci_close(dh_dev);
> +	mutex_destroy(&pf_dev->irq_lock);
> +	mutex_destroy(&dh_dev->lock);
> +	dh_core_free_priv(dh_dev);
> +	devlink_free(devlink);
> +	pci_set_drvdata(pdev, NULL);
> +}

[Severity: High]
Does this destructive teardown in the .shutdown callback create a race if
.remove is called afterwards?

If .remove is triggered (for example, during a hot-remove event during
shutdown), pci_get_drvdata() in dh_pf_remove() will return NULL.

The macro priv_to_devlink() will then convert NULL into a bad pointer,
causing a panic in devlink_unregister().

Should .shutdown only quiesce the hardware without destroying software
structures?
-- 
This is an AI-generated review.

