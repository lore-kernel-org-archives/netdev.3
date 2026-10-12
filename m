Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D784BC00B;
	Mon, 12 Oct 2026 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825592; cv=none; b=Qeb41LLDG1fG5cP+OaugL5uKjZ61P2+2A/ckdqKAK/pj2I4SPfEeu9V44QC7S0N07RvZ80GNwoKpc3s0tke0B4hk2iyRyDN+PEmVyYdG957o4P7c0cPWWPdXvtnnB/d1ql2631ck5eO2wiDpx3MfkGK1G8ukAWv21sY5ICqfQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825592; c=relaxed/simple;
	bh=Zb9I0ivDglkWiACciWW5UQmd8xplB5gGsgMawQSIcgw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBU7/6GngGoRqrBOOEndvXRzWGSnufchVYgxt6GHubYNN8NNEPR25gWYu3x0g67u4PlN9JGw2RUO/l3W66dXoI73mhiTBDZH6o+sXLZRet5rpd0M+LGndY2S26TFY+j4n1qBiHwQM3fcB1HmBl8mXp8k+2KXFe6ozhY3vi7oWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcUM/rq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcUM/rq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A131F0089B;
	Mon, 12 Oct 2026 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791825591;
	bh=rO6l07YTEWayoFv6v/3u3GiQMDj+Pw79i8+52ZJfs60=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dcUM/rq83JOrwjMBagQwfGsoyCIogprRko2RwIE91YrJAxg+lF+r4Ksatlf50qIOK
	 ov2pAjxzRQqcwNIx1Za+6HDzDvNd2UmQ9kFjUfS99KO1ZAB9QVLQrVlwk0Itk4zGZv
	 3OWW/SrkJiFSXMcxd6dwvPgyfxv8zDR6sgIxGHw/9KWyAA6UDgQHaytwk80yiyOxKJ
	 VPp2Isuc4g549RdUmtJrqMH0TpSn7WyZx451sP40jMS4F48S4VaSnI5NegidBSD3mh
	 VcmDCmzonDPQJDUVPG2e9v+PV5MKHpuaua9phv9JhPbe7ztNqAgXmo4dJwiHIE21BZ
	 CvYgpr/lOxVGA==
Subject: Re: [PATCH net-next V2 5/5] net/mlx5: nodnic: Add health monitoring
From: netdev-bot+sashiko@kernel.org
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 cjubran@nvidia.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
 shshitrit@nvidia.com, leon@kernel.org, mbloch@nvidia.com, saeedm@nvidia.com,
 dtatulea@nvidia.com, horms@kernel.org
Date: Mon, 12 Oct 2026 17:19:49 +0000
Message-ID: <179182558993.434549.14029169550800193089@kernel.org>
In-Reply-To: <20261008171821.660739-6-tariqt@nvidia.com>
References: <20261008171821.660739-6-tariqt@nvidia.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch removes the trailing newline from
  drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile.

--

net/mlx5: nodnic: Add health monitoring

This commit adds firmware health monitoring to the nodnic driver. A timer
periodically polls the health buffer in the initialization segment. It
detects fatal sensors, stalls in the health counter, and syndrome changes.
Polling is started from probe and stopped in remove.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
> index 25865d7244d82..1d09edeaf3af8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/nodnic/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_MLX5_NODNIC) += mlx5_nodnic.o
>  
> -mlx5_nodnic-y := main.o en.o en_cfg.o tx.o rx.o nodnic_pci_vsc.o
> +mlx5_nodnic-y := main.o en.o en_cfg.o tx.o rx.o nodnic_pci_vsc.o health.o
> \ No newline at end of file

[Severity: Low]
This isn't a bug, but the trailing newline at the end of the nodnic
Makefile has been dropped. Before this patch the mlx5_nodnic-y line ended
with a newline. Could it be put back so that checkpatch doesn't warn and
the next change to this file doesn't show an unrelated whitespace hunk?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008171821.660739-1-tariqt%40nvidia.com
