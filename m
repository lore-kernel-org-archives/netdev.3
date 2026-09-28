Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB64BA9F2;
	Mon, 28 Sep 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597443; cv=none; b=p4TSfBq4Nk0Fserv9sf3GSkdMFOtiTU7kj9WYS16LpNV+448ovukAIGYc5LCx4Bn5UIE6v5W5wu3zxLvPFsPSM6JedKwpqgpou6zYYlHEhaWy2qU8isZ4e4jgoTCKm2Rizc9CDS3ys19EEiUtPb4tvSk2HqMPx1QhAEt4lkZABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597443; c=relaxed/simple;
	bh=11T/FXaU6/yHKFLaw2ytHH77JsNUcI8PhrK/1EEIHWw=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=knIGcTOMgm1DAOx70M+pOW1HwXRjd9MkBd4C2926yotkYc+4h/VzyTfwi1vTp645uuUX0bBJf6mxlVnVM2pW4aQhEqK54TghA/IVOfjk2tRrKTeHGM/2th2x4wwyu95X59BcXGblXvDU/lI2aZcY3FnFQ3gD8tBO1gbJiehS7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4htgB66gGXz8Xrrg;
	Mon, 28 Sep 2026 20:10:38 +0800 (CST)
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl1.zte.com.cn with SMTP id 68SCARCe062864;
	Mon, 28 Sep 2026 20:10:27 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 28 Sep 2026 20:10:30 +0800 (CST)
X-Zmail-TransId: 2afd6aba59367b8-060b9
X-Mailer: Zmail v1.0
Message-ID: <202609282010301316BZ8zDUYb1NPROJaErr_Q@zte.com.cn>
In-Reply-To: <20260922100913.GA13925@horms.kernel.org>
References: 202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn,202609211459460680vBvKdpuZZ9yR4QVn3ONR@zte.com.cn,20260922100913.GA13925@horms.kernel.org
Date: Mon, 28 Sep 2026 20:10:30 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <horms@kernel.org>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXQtbmV4dCB2MyAyLzNdIGRpbmdoYWk6IGFkZCBNU0ktWCBpbnRlcnJ1cHQgcG9vbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 68SCARCe062864
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 28 Sep 2026 20:10:38 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ABA593E.000/4htgB66gGXz8Xrrg

On Mon, Sep 21, 2026 at 02:59:46PM +0800, han.junyang@zte.com.cn wrote:
> > From: Junyang Han <han.junyang@zte.com.cn>
> >
> > Allocate the fixed MSI-X vector layout of the device and manage the
> > vectors in per-purpose pools: the async event queues first, a range
> > reserved for RDMA in between and the vq queue pairs last. This series
> > wires up the async pool; the vq pool comes with the netdev series.
> >
> > IRQs are reference counted so that several event queues can share one
> > vector. The pool hands out the least loaded matching IRQ once it passes
> > the pool minimum threshold, and binds newly created IRQs to the least
> > loaded CPU of the requested affinity mask. Interrupt delivery fans out
> > through an atomic notifier chain attached to each IRQ, which the async
> > event queue setup posted later in this series hooks into.
> >
> > Signed-off-by: Junyang Han <han.junyang@zte.com.cn>

...

> > @@ -516,10 +604,24 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > goto err_modern_cfg;
> > }
> >
> > + ret = zxdh_pf_irq_table_init(zxdh_dev);
> > + if (ret) {
> > + dev_err(&pdev->dev, "zxdh_pf_irq_table_init failed: %d\n", ret);
> > + goto err_modern_cfg;
> > + }
> > +
> > + ret = zxdh_pf_irq_table_create(zxdh_dev);
> > + if (ret) {
> > + dev_err(&pdev->dev, "zxdh_pf_irq_table_create failed: %d\n", ret);
> > + goto err_irq_table;
> > + }

> I am wondering if you considered calling zxdh_pf_irq_table_create()
> from zxdh_pf_irq_table_init(). And likewise for
> zxdh_pf_eq_table_init()/zxdh_pf_eq_table_create() in patch 3/3.

> I mainly ask because it seems like it would simplify zxdh_pf_probe()
> slightly. But I don't feel strongly about this.

Both taken in v4: the create() steps are folded into their init() counterparts,
and every probe error path now goes through the same destroy() functions
remove() uses, so each patch carries one cleanup authority from the start.
This also drops the internal pci_free_irq_vectors() on the pools failure
path - destroy() releases the vectors exactly once for any partial init state.

> > +
> > devlink_register(devlink);
> >
> > return 0;
> >
> > +err_irq_table:
> > + kvfree(zxdh_dev->irq_table.priv);

> As a counter to my previous comment: I see the line is changed to call
> zxdh_pf_irq_table_destroy() in patch 3/3. But I'm wondering if it should be
> (or would be nicer if it was) zxdh_pf_irq_table_destroy() in this patch.

> > err_modern_cfg:
> > zxdh_pf_modern_cfg_uninit(zxdh_dev);
> > err_cfg_init:

...

> > diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_irq.c b/drivers/net/ethernet/zte/dinghai/zxdh_irq.c

...

> > +static struct zxdh_irq *zxdh_irq_alloc(struct zxdh_irq_pool *pool, int vecidx,
> > + const struct cpumask *affinity)
> > +{
> > + struct zxdh_core_dev *zxdh_dev = pool->dev;
> > + struct zxdh_irq *irq;
> > + int err;
> > + int cpu;
> > +
> > + irq = kzalloc_obj(*irq, GFP_KERNEL);
> > + if (!irq)
> > + return ERR_PTR(-ENOMEM);
> > +
> > + irq->pool = pool;
> > + irq->irqn = pci_irq_vector(zxdh_dev->pdev, vecidx);
> > + if (irq->irqn < 0) {
> > + err = irq->irqn;
> > + goto err_irqn;
> > + }
> > +
> > + ATOMIC_INIT_NOTIFIER_HEAD(&irq->nh);
> > + snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
> > + vecidx, pci_name(zxdh_dev->pdev));

> W=1 builds complain about this. E.g. GCC 16.2.0 on x86_64 says:

> CC [M] drivers/net/ethernet/zte/dinghai/zxdh_irq.o
> drivers/net/ethernet/zte/dinghai/zxdh_irq.c: In function 'zxdh_irq_alloc':
> drivers/net/ethernet/zte/dinghai/zxdh_irq.c:94:52: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 99 [-Wformat-truncation=]
> 94 | snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
> | ^~
> drivers/net/ethernet/zte/dinghai/zxdh_irq.c:94:9: note: 'snprintf' output 8 or more bytes (assuming 107) into a destination of size 100
> 94 | snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 95 | vecidx, pci_name(zxdh_dev->pdev));
> | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> ....

Thanks for testing with GCC 16. Fixed in v4: the pool name now has a
buffer bound of its own (16 bytes; the longest pool name is 13) instead
of sharing the 100-byte IRQ name buffer, and the copy uses strscpy().
The series is now built per-patch with W=1 before submission.
