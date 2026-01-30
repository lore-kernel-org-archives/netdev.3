Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07132A3D9
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745737; cv=none; b=Zny2qvsL3ezXGPCzJrFs5rZM77dYbWLyb9xVFihOHU8QPUi/pKvnL/3exxHtGBnl1VjBqRfr64Tit5ojb9n5Wi2R2Ens3uq7zVSxVY9XuU1rUMzcHH0475jR8h2vArN28eXhfmgNdMg2cD82Agq/gkI6NccRvft+A2Bajb6ei3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745737; c=relaxed/simple;
	bh=XYz2unhjPUJ0Fp6qvD1qsXOeoH8ctYEWIpLHrsScpGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co2RaDJ531yp1wvYOoQA6lNlYsrNdgUW5vzXxyAvL8GNDA7+zESNmk8fCuYjGEixDgcaq/ZHC473owa6ge2eKXkHQRNwwVwVziBQ16A1KuVkSImWmChQ2ZVqVXY3RYHWPcefJd3Mt+qMu5Z7L/pP0sziyVYMFZoMXc3dGsvuYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4qHrX70; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4qHrX70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A960C4CEF7;
	Fri, 30 Jan 2026 04:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745737;
	bh=XYz2unhjPUJ0Fp6qvD1qsXOeoH8ctYEWIpLHrsScpGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4qHrX70GmvV0lH1KqDljx2+RTLzSdIHHrcuRtKEc56dJPEgcZxMqfOuEo65O1R3U
	 JjJkL3BG7i1Pku8PD+CC5FvHaxuDOnHE78rlVQGRc19ODRNtkBrdOErounTiF6MbhW
	 nuLnO5PXUnEr3VdB+NselQtWAbsvsWUjMU3xIACLCVfYqAQJ3O0RCF05bxThGMR5cF
	 U2EGftlFbK3IoI5u99f/SAg66wZ0ydiyJdKqBhZKW8dFlJIhQBLUxWoz3C7ek6Pv6g
	 Dxo+wkFSNvQ1+VzPNtglp1WkFucTBpFZi6+oXSxSzsjQrVWMP/LO28XzHb8H5qB2aH
	 MmckMhQ0Oi8bg==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	dust.li@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	guwen@linux.alibaba.com,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com,
	davem@davemloft.net,
	dong100@mucse.com,
	vadim.fedorenko@linux.dev,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com
Subject: Re: [net-next,v23,5/6] eea: introduce ethtool support
Date: Thu, 29 Jan 2026 20:02:15 -0800
Message-ID: <20260130040215.708811-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128055232.8021-6-xuanzhuo@linux.alibaba.com>
References: <20260128055232.8021-6-xuanzhuo@linux.alibaba.com>
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
eea: introduce ethtool support

This commit adds ethtool support for the Alibaba Elastic Ethernet Adapter
(EEA) driver, including statistics retrieval, ring parameter configuration,
and channel management.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> new file mode 100644
> index 000000000000..b903ae368473
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c

[ ... ]

> +static void eea_get_ethtool_stats(struct net_device *netdev,
> +				  struct ethtool_stats *stats, u64 *data)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	u32 i, idx = 0;
> +
> +	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
> +		struct eea_net_rx *rx = enet->rx[i];

Can this dereference of enet->rx[i] cause a NULL pointer crash when the
device is not running?

Looking at the driver lifecycle, enet->rx is NULL after probe (before the
device is opened) and after close. However, enet->cfg.rx_ring_num is set
to a non-zero value during probe via eea_update_cfg(). This means if a
user runs "ethtool -S ethX" on a device that has not been brought up,
the loop will execute with enet->rx being NULL.

The follow-up commit 3b731fea0a60 ("eea: introduce callback for
ndo_get_stats64") adds an "if (enet->rx)" check before a similar loop in
eea_stats(), suggesting awareness of this issue. Should a similar check
be added here?

> +
> +		eea_stats_fill_for_q(&rx->stats.syncp, EEA_RX_STATS_LEN,
> +				     eea_rx_stats_desc, data, idx);
> +
> +		idx += EEA_RX_STATS_LEN;
> +	}
> +
> +	for (i = 0; i < enet->cfg.tx_ring_num; i++) {
> +		struct eea_net_tx *tx = &enet->tx[i];

The same question applies here for enet->tx.

> +
> +		eea_stats_fill_for_q(&tx->stats.syncp, EEA_TX_STATS_LEN,
> +				     eea_tx_stats_desc, data, idx);
> +
> +		idx += EEA_TX_STATS_LEN;
> +	}
> +}

[ ... ]
