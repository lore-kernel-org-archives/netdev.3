Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83C2D46B3
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663473; cv=none; b=D+O3gWyllgQpN2aKaciH2ByvXD2RcZIDk4CoNlgMACNuJvWl3Mwv1F7MkmksHaBHXxABf8Qos/JcmgBvinwyhQPQG+RutlLo450JxKN5S09/tbxVvSOgLquVPxsy82eB4LL7aNBgnUPPGq0o3PhcFu/0/PriwYufRMUPN0Rxx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663473; c=relaxed/simple;
	bh=W9fqYP+KrfTCzJpFa0BishbYUbcgHmATKHrdr0OacMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0I6uiO1ISgZB96tYfRr8qTh2TrJcrxDjhYDhJ/33cK1Aij5fdI6Qxsz7+2ePkyuyO1b9U820xnXeRdKN+YEnrJy/KWWhnvxDGwHNUsdMBoTToTHIceYILuVAI+pkgxhgiLsdnE3U/YckHrd0JHKAIlmsn4ZPhV6IwMnQTCCdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc4twbEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc4twbEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63C2C116D0;
	Thu, 29 Jan 2026 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663473;
	bh=W9fqYP+KrfTCzJpFa0BishbYUbcgHmATKHrdr0OacMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc4twbEyR/Ek9EGD44bFFn8wehzl7xdWkRlHTpu7ultX5sb7hWcpEeU8dw1yb/ehM
	 tCJ3q7MbisSj8UJHrougdG2wLdVvcs3fNglCUI1jQ7JJbgmdGOwB6EthH7CFX/85+o
	 6pO2uK0ETY6PSQTuztN7loH0sR7dnJiezcmvNMgTohLUTUUfq/8M/xEGqaycXvhtfV
	 m+oRaBXeow3dYuVn7BWkEID4VDBOQPojeGIGqu+LvFkmfiBwfSUaBCGehUQN2Wwvb1
	 n/CtRuuqW6gCfqcisD9awCA/h9MRbTKT9SyUmhin0igXpqoQhSzGM8jHeaycAAbNEZ
	 ce8WN5xCGptXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: Raju.Rangoju@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	Shyam-sundar.S-k@amd.com
Subject: Re: [net-next] amd-xgbe: add support rx alignment and length errors
Date: Wed, 28 Jan 2026 21:11:11 -0800
Message-ID: <20260129051111.376038-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128075843.696961-1-Raju.Rangoju@amd.com>
References: <20260128075843.696961-1-Raju.Rangoju@amd.com>
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
amd-xgbe: add support rx alignment and length errors

This patch adds support for reading rx alignment errors from the hardware
MMC registers and updates the rtnl_link_stats64 structure.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index b5a60a048896..ebc5fe8324ea 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1838,6 +1838,8 @@ static void xgbe_get_stats64(struct net_device *netdev,
>  	s->rx_length_errors = pstats->rxlengtherror;
>  	s->rx_crc_errors = pstats->rxcrcerror;
>  	s->rx_over_errors = pstats->rxfifooverflow;
> +	s->rx_frame_errors = pstats->rxalignmenterror;
> +	s->rx_length_errors = pstats->rxlengtherror;

Is this line a duplicate? The assignment to s->rx_length_errors already
appears three lines above. Perhaps this was intended to be a different
assignment?
-- 
pw-bot: cr
