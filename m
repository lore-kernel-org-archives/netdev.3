Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E782868B5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322937; cv=none; b=Q70aASbS9C4iaPbDSeStMeA5WSc4t/0iu+DjmjQCNOieOgCe50D4u3tWrDnOXF40W8HYPnox5PnSxP0HEueDRLFP+u9jlaiZyI7Ht545TbTC44EKRu4bHq5Osze66QjZq1VQFpzrcowNgNp6VPohQ5al9s81UqFW6fY5FOEG3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322937; c=relaxed/simple;
	bh=Nvq0WNRCvvFGiPU97AHJ2/pliUQHVcaAvhD4KB+d6h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3KOVF0ORhW7VcBESoNBCCprxLF42n00S+WaJxCUrv/sYwSi6Jxh5wnDQBOx4DJjXAhZmV3BgyEp2zjZpMgth3X/mIqIfJKLr/B6gRGqkuzzXpfl9GLW8FmHPpwKRNqmWHSVSZfft7Sp/bqBfJ5S5DJEXgvQygzzko0xRWIftR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV+8QKB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV+8QKB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9B6C116D0;
	Sat, 28 Feb 2026 23:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772322936;
	bh=Nvq0WNRCvvFGiPU97AHJ2/pliUQHVcaAvhD4KB+d6h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DV+8QKB3e658jiD8wsW3gXCEQVpjPXUmSW5THeDdhJF8JlFx9CpWYu2HRS+MKFFWT
	 9Kb9iptuOH8MsBu2/dXuackKM8oCCT/5o7wxdl5LvmGOFw5SZ3zblxj7rjOWt1qo6C
	 D/6JbQ081l4G4C7zlf3LnEWUiCNQaYrHAk4CaEjllJdTJ0ZDDOK411YjU3uk8QlK6J
	 z9Jq2I0Pye6LUw31u1f86dJVGixLyCdQr/ONYHfFGAwmq+I3wlNSMlP1Cj1hM8jLfD
	 L6XtaSH8RL+9O9uU3fsHN0x+Qg9BOt4jbR9oPB4vl5ktD8Z1BqMXy3igbzPOzjjufU
	 8JkJIgNGRqhvQ==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	guwen@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	lukas.bulwahn@redhat.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	davem@davemloft.net
Subject: Re: [net-next,v27,4/8] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Sat, 28 Feb 2026 15:55:31 -0800
Message-ID: <20260228235531.30134-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227015546.47336-5-xuanzhuo@linux.alibaba.com>
References: <20260227015546.47336-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: create/destroy rx,tx queues for netdevice open and stop

This commit adds the netdevice open and stop implementation for the
Alibaba Elastic Ethernet Adapter (EEA) driver, including queue creation,
IRQ handling, and NAPI polling infrastructure.

> diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
> index 91f318e8e046..fa34a005fa01 100644
> --- a/drivers/net/ethernet/alibaba/eea/Makefile
> +++ b/drivers/net/ethernet/alibaba/eea/Makefile

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> index 31cb9ca5b408..2ebf0053d05e 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c

[ ... ]

> @@ -116,6 +563,9 @@ static int eea_netdev_init_features(struct net_device *netdev,
>  }
>
>  static const struct net_device_ops eea_netdev = {
> +	.ndo_open           = eea_netdev_open,
> +	.ndo_stop           = eea_netdev_stop,
> +	.ndo_start_xmit     = eea_tx_xmit,
>  	.ndo_validate_addr  = eth_validate_addr,
>  	.ndo_features_check = passthru_features_check,
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> new file mode 100644
> index 000000000000..259f57674d9f
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Alibaba Elastic Ethernet Adapter.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#include <net/netdev_queues.h>
> +
> +#include "eea_net.h"
> +#include "eea_pci.h"
> +#include "eea_ring.h"

[ ... ]

> +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
> +{
> +	/* Empty function; will be implemented in a subsequent commit. */
> +	return NETDEV_TX_OK;
> +}

Does this stub leak the skb? The function is registered as ndo_start_xmit
in the net_device_ops structure, and when ndo_start_xmit returns
NETDEV_TX_OK, the network stack assumes the driver has taken ownership of
the skb and will not free it. Since this stub neither transmits nor frees
the skb, every packet sent through the interface will leak memory. The
device can be opened via eea_netdev_open (which is also added in this
commit), making this code path reachable.

Would it be better to call dev_kfree_skb(skb) before returning NETDEV_TX_OK
to prevent the leak until the full implementation is added?
-- 
pw-bot: cr
