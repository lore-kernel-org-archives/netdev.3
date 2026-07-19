Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E5281369;
	Sun, 19 Jul 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784457183; cv=none; b=m3Sl7QJ7rwyQRnhw7N7uEP9kikNSCZVNisF4DWl6B/n2R1qfLuqXKrALwoydOtgkT42dbeVhkcgDZxHgsi5iWwUA6wbw21halAzRMyfpkRw9m/AuplQ/FkdUTVGCarIiZc+af/zIJMmIwqquHLv4KT23AuKfqkcOaPH1n0Vt9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784457183; c=relaxed/simple;
	bh=+82kLG8JOFg4+s7CBuPpB164uql7KxqmYXOvZNRX680=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=anKoEIljfd1rhCrdqGhgDKZPy+BnsGMvPEdCLMPxOfAarCa9fJh3zCJTvZEBNWcVH0HoGvkIYyl3m1PhWXEM3gUCen9JBGeSy0SUgGoEBElGPUZ7I4W03u8Gi/HQaH8SLVdsDv2iiEMjumolPWXgNtEU0aseT8rKqG92wMvI7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=pJV0VNV3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="pJV0VNV3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B76B7A47FE;
	Sun, 19 Jul 2026 12:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784457169; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7cAgk9XoCReGo1vklu+Fi1iJ3QIZJXUowSXhJqwUifQ=;
	b=pJV0VNV3YfS0CGeadzpLYOB0XEc/ELVgHns4k9339LYmB31EgD9qMNbKN1tzuBHC1XxaNb
	OQnxiFXtujJAnt6hA9bykvDBdtXvegHMVv2eLAN1K/hDHjC4ZvTUMN+wpFPUjJL5kzU1x6
	Fg50Uxt4R+BZVTxzbc3vD0QXAkjE03NL+SBVI/x28KEr7qpvIQnQdGH0ZEfyfkRv+3lRGX
	oMeeuwRbr4eCYRebMUdm8PGeMtM9jH5Kgsoy/gFjto1qPzCswyX7KDDEni4o2XoBH83btY
	BHyFJp/rXY+HhxIoq2tRRrDHSmhfflpYaxzaVCB2+tycwpEjaokQ0D+yyo1UVA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:32:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 02/15] net: macb: unify device pointer naming
 convention
In-Reply-To: <20260717-macb-context-v4-2-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-2-0acbe7f10cdb@bootlin.com>
Message-ID: <be5764f7a984d47c4c4ea49f3e3ce288@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> Here are all device pointer variable permutations inside MACB:
> 
>    struct device *dev;
>    struct net_device *dev;
>    struct net_device *ndev;
>    struct net_device *netdev;
>    struct pci_dev *pdev;              // inside macb_pci.c
>    struct phy_device *phy;
>    struct phy_device *phydev;
>    struct platform_device *pdev;
>    struct platform_device *plat_dev;  // inside macb_pci.c
> 
> Unify to this convention:
> 
>    struct device *dev;
>    struct net_device *netdev;
>    struct pci_dev *pci;
>    struct phy_device *phydev;
>    struct platform_device *pdev;
> 
> Ensure nothing slipped through using ctags tooling:
> 
> ⟩ ctags -o - --kinds-c='{local}{member}{parameter}' \
>     --fields='{typeref}' drivers/net/ethernet/cadence/* | \
>   awk -F"\t" '
>     $NF~/struct:.*(device|dev) / {print $NF, $1}' | \
>   sort -u
> typeref:struct:device * dev
> typeref:struct:in_device * idev        // ignored
> typeref:struct:net_device * netdev
> typeref:struct:pci_dev * pci
> typeref:struct:phy_device * phydev
> typeref:struct:platform_device * pdev
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  20 +-
>  drivers/net/ethernet/cadence/macb_main.c | 636 
> ++++++++++++++++---------------
>  drivers/net/ethernet/cadence/macb_pci.c  |  46 +--
>  drivers/net/ethernet/cadence/macb_ptp.c  |  18 +-
>  4 files changed, 361 insertions(+), 359 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index 2de56017ee0d..9857df5b57f0 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1207,11 +1207,11 @@ struct macb_or_gem_ops {
> 
>  /* MACB-PTP interface: adapt to platform needs. */
>  struct macb_ptp_info {
> -	void (*ptp_init)(struct net_device *ndev);
> -	void (*ptp_remove)(struct net_device *ndev);
> +	void (*ptp_init)(struct net_device *netdev);
> +	void (*ptp_remove)(struct net_device *netdev);
>  	s32 (*get_ptp_max_adj)(void);
>  	unsigned int (*get_tsu_rate)(struct macb *bp);
> -	int (*get_ts_info)(struct net_device *dev,
> +	int (*get_ts_info)(struct net_device *netdev,
>  			   struct kernel_ethtool_ts_info *info);
>  	int (*get_hwtst)(struct net_device *netdev,
>  			 struct kernel_hwtstamp_config *tstamp_config);
> @@ -1326,7 +1326,7 @@ struct macb {
>  	struct clk		*tx_clk;
>  	struct clk		*rx_clk;
>  	struct clk		*tsu_clk;
> -	struct net_device	*dev;
> +	struct net_device	*netdev;

Looks like you have missed the one in macb_free(), from commit 
27f575836cfe ("net:
macb: drop in-flight Tx SKBs on close"):

	bp->dev->stats.tx_dropped += dropped;

This breaks the build until patch 7 rewrites thatline, which breaks 
bisection.

> [...]

Thanks,
Nicolai
