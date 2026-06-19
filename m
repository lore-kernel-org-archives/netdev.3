Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FD38239E;
	Fri, 19 Jun 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871502; cv=none; b=WHcj97NsjAT2V3h5jN7n6//pZf5i44jLxSi5zhtx4ztq96ADJ0HUFR+4ofpV+yKhr595tYZfG/9vR0TfRaYlXYU8q+wu7AVVYaCnMM4TNCtz8S0yr/0mk92VqQFRE1cshmk7b6zjCWL3ZyrJ+Jf8V7VJVFSfe1rLfKij7JdhFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871502; c=relaxed/simple;
	bh=loXO152dCZ/8p/Q3pQSrnFMHeD/WGMH/2l+E9A6fAIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uviGo7I7a6L9NKljw8dKYJs8RlXj89DIU3XrZ6Q9jMQfJTG1LOT1YsyPv3fkMPz6PFnDwxKqTXnHsw0MIMlQysuPS7OYmzXuzGkoj7d971wb8Xyu82sez+2CAgaPc5PMHgWA3phRXAlYrT3mXqqi0Wf4ark9aPONXlnhVZvILMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEZTbgt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEZTbgt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EF41F000E9;
	Fri, 19 Jun 2026 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781871499;
	bh=Rq9fylMx8IUdw6G/VkTJPnm52IVP6IqHGRfVmafArTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mEZTbgt29HCkpzn5hlZeaxRuSnTmMZX6O1FFEkDvAcCKx+qREvM4OUTHba7Bl+MnQ
	 y3GAiYkpHi3CnhSUnmaiURBBJegDv7fgBq9sOaNEkR9R6rAeCpiY9/pViSLnkhvSC9
	 57nS/dJsQn1TQfeGvJTRy9uVt7GQgpfjEjTd3l6grjWSJUyOk4esAElXh5yNfyfg12
	 Gdx+NKD+9kOjtyWS8EQvRDldTwLJeQSjMYowMGPucrorS3cL3OmXyPMcQKpCcbjJKu
	 MNVl2mcac/jFQm90+ebscA+OrUrcuaaCkWoOyL6huRC+KVeOUTSxnvlaXbzlRHInFz
	 h/OhzP9WkPvGg==
From: Simon Horman <horms@kernel.org>
To: zhaojinming@uniontech.com
Cc: Simon Horman <horms@kernel.org>,
	madalin.bucur@nxp.com,
	sean.anderson@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fman: fix clock and device node leak in probe error paths
Date: Fri, 19 Jun 2026 13:13:30 +0100
Message-ID: <20260619121328.922138-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618075435.1262533-1-zhaojinming@uniontech.com>
References: <20260618075435.1262533-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: I think the first issue below does warrant being investigated
            within the context of this patch.

	    The second one seems related to the intent of this patch,
	    but I don't feel strongly about it needing to be fixed
	    as part of this work.

	    And the last one seems yet more weakly related.
---
net: fman: fix clock and device node leak in probe error paths

This patch aims to fix resource leaks in the error paths of
read_dts_node(). It introduces a clk_put label to ensure the clock
reference is properly released on probe failures.

> diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
> index 013273a2de32f..734cbe8efd7e3 100644
> --- a/drivers/net/ethernet/freescale/fman/fman.c
> +++ b/drivers/net/ethernet/freescale/fman/fman.c
[ ... ]
> @@ -2757,7 +2757,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
>  		err = -EINVAL;
>  		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
>  			__func__);
> -		goto fman_free;
> +		goto clk_put;
>  	}

[Severity: High]
Will this cause a double-free of the device node on error paths?

In read_dts_node(), the call to of_find_matching_node() drops the
reference on its "from" argument, which is fm_node:

muram_node = of_find_matching_node(fm_node, fman_muram_match);

By redirecting the error paths after this point to the clk_put label,
the code falls through to fman_node_put and calls of_node_put(fm_node).
Since of_find_matching_node() already consumed the reference, does this
second put lead to a reference count underflow and use-after-free?

[ ... ]
> @@ -2816,9 +2816,10 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
>  
>  	return fman;

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak the
clock reference when returning successfully?

While the patch correctly adds clk_put(clk) to the error paths, the
success path shown above returns without releasing the reference acquired
via of_clk_get(). Does the driver need to hold this reference throughout
its lifetime, or should it be released here to prevent a memory leak
during repeated driver binds and unbinds?

> +clk_put:
> +	clk_put(clk);
>  fman_node_put:
>  	of_node_put(fm_node);
> -fman_free:
>  	kfree(fman);
>  	return ERR_PTR(err);
>  }

[Severity: High]
This is a pre-existing issue, but is it safe to manually free the fman
structure here when devm-managed shared interrupts are still registered?

The driver allocates fman using kzalloc_obj() and registers shared
interrupt handlers using devm_request_irq(), passing fman as the dev_id.

If initialization fails later in the function, the error path calls
kfree(fman). However, the devm-managed interrupts are not unregistered
until the probe function returns and devres cleanup runs.

Because the interrupt is IRQF_SHARED, could another device trigger an
interrupt during this window? If so, would the still-registered fman_irq
handler attempt to access the already-freed fman structure?
