Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E62EEE6E;
	Mon, 10 Aug 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397188; cv=none; b=Jr0lRTmTsG2ASkQp+oNqQ0nFv2+kpXOE98/v+6tsOkEhgo/ll8+RI7xhIFQm0GV0Q74CBPItHk/HQeHGX4RFFK+rlCTeA7joheBmisp2QjFoSznLsdN76yhGVsIugbG4bj5jrYP4sGQHHuaPShiSRZkhoPSdf0KBMidZRBl6AJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397188; c=relaxed/simple;
	bh=293XGMkdEjpPSrznAmM/Vf5jSeeGrIzXmlWwLsuRzUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwwNomYiFLheDn4GfyBYrcO+YmS4G/0gRbIXGCeAT8IX3bWEu2EZ+kkdm26Kh0LBwfxOHMgKRqScQIy0OkK1HMUfBIZ8GJzVeqKaeuSZS93FJDZLsfEB+fJRRYrHR7TGdsWbltaYTP/oL+tYVkwUagFZfdqDJqKDsvWtwqLQ16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjPP/V/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjPP/V/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF791F00A3A;
	Mon, 10 Aug 2026 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397187;
	bh=0umW7ZzdTAmExgWh+B11WEvlm6crt2noa4Rew2vZKeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SjPP/V/lCtUwESKp68Ks+5jdOcG6sB8RpeJ/lU7T/UgZQT683Bg/4idW59Jvjykw5
	 UBFMvjaYgoD517WXVm1c+8is86PRIXtWuiW81Sdm0SNpLg/ojRvewt5MIrkBkGy3yt
	 iZE4sb5/ShAGtWjRgbGBmkJkml0kfyHGQ7VBdzbonRu5BQy2CWVcJgVN4Coz0x0xaV
	 758oDs7zKFNX0L0oTcBTtor1pVyXFck8tq7+FqA3hkUqbxJt4PeHTa/uF74FRP2SJt
	 Bm/cfSyX/Lf1lF7xLBVs8WnG/RE/SYYN1fjqdk97jOEwouyOBvo+SWTIyDLli+0Maz
	 7fv+xbm95jKGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/7] r8169: refactor RX path to prepare for multi-queue
Date: Mon, 10 Aug 2026 14:26:25 -0700
Message-ID: <20260810212625.844768-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803021305.488-3-javen_xu@realsil.com.cn>
References: <20260803021305.488-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: refactor RX path to prepare for multi-queue

This patch refactors the RX path by introducing a per-queue array
struct rtl8169_rx_ring, allocating the netdev with devm_alloc_etherdev_mqs(),
and updating related initialization and cleanup routines.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 8f3a5c50299ff..924df06398287 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
[ ... ]
> @@ -5873,9 +5995,15 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc)
>  		return rc;
>  
> +	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring), GFP_KERNEL);
> +	if (!tp->rx_ring)
> +		return -ENOMEM;
> +

[Severity: Medium]
Does this code leak the rx_ring array on driver removal?

tp->rx_ring is explicitly allocated with kcalloc() here, but it appears there
is no corresponding kfree(tp->rx_ring) in rtl_remove_one(). Since
devm_kcalloc() isn't used, shouldn't tp->rx_ring be freed when the device is
unbound?

>  	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct), GFP_KERNEL);
> -	if (!tp->rtl8169_napi)
> +	if (!tp->rtl8169_napi) {
> +		kfree(tp->rx_ring);
>  		return -ENOMEM;
> +	}
-- 
pw-bot: cr
