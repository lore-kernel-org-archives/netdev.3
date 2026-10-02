Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F544A8FEB;
	Fri,  2 Oct 2026 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961385; cv=none; b=Yng2ncQnDolApzavEtjVCATQHS/h6BN4/sYumHQWDj8drkMKuyn/wlvtRu3rf5wlKwmsHybSx8qIRPWYriO8on9Jri/4j4cQ1wbLNf7usGZ5drbNEEX0UVs7k2BhE0hjd54FTAGCP0RTE++CsTzacMRsplxpU24R5njvNnSfgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961385; c=relaxed/simple;
	bh=rFMGdaUhyCEwTMWcL60mEtzD5LytVtBRd9H12R0FwJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScwvUOF5MdTP5o43zavzEPrAwBVrfUSg0RTOWj58Y1zTAHm4Lzkkcu8CHJLUsDcBAaYfBmU8MHkjzKRyIaB1EpV5WH2E0x2S82O0XI8+RcnKEdnMZExucixrawAs8LEqduEvEOYX1P+KuDSmabCd0Vm01gRtFIMDxrHlNGaQbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpUCQvXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpUCQvXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DBE1F000FF;
	Fri,  2 Oct 2026 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790961369;
	bh=7zDel4jHw7m5D3MupwzGrV1E74Lk6hlgpX3BJ6fDhbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpUCQvXDIORUKfZPtgMTI33ChZEQv4kLFR94v9G1ea0opU7GRyrWTnGSNIKIZjJJ3
	 AjUDpVEIYgewlLQZNmym8rGnpcOrVB0FyOnVaWdigR7W+iqJ4DK1Q7DT4SRi87da75
	 1dPaYZzRikDuVwg3EyLc/S7kmfIvyl1uFPDiacC5CkJ/Fdyd4DE9DwzqL79tJ99R1A
	 /ic2cYlx7znopZI3haBT9dEQeVpszOwI78B1VHrrXtRAEhBA/jhIuKPlKn4CNb//uM
	 dTvrZPRyEtNbRdFokmsMgoCsqSuk+3xf1sMTmTlLyzDW7oWxgqEcttWA2ttcjHHIeE
	 b+SqlQNueYOKA==
Date: Fri, 2 Oct 2026 18:16:04 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/5] net/mlx5: nodnic: Introduce the mlx5_nodnic
 driver
Message-ID: <20261002171604.GM13925@horms.kernel.org>
References: <20260930125708.144767-1-tariqt@nvidia.com>
 <20260930125708.144767-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930125708.144767-2-tariqt@nvidia.com>

On Wed, Sep 30, 2026 at 03:57:04PM +0300, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Introduce mlx5_nodnic, a driver for DRAM-less NVIDIA Mellanox NIC
> functions.
> 
> It defines a lightweight NIC function intended for contexts where local
> DRAM is unavailable or too costly: embedded controllers, management
> planes, pre-boot environments, or any resource-constrained instantiation
> of a ConnectX NIC. The hardware sends and receives ordinary Ethernet
> frames via SQs, RQs and CQs. There is no encapsulation, no private
> protocol, and no FW interposition: packets are forwarded as standard
> Ethernet between whatever peers are connected to the function. The
> interface is documented in the HW spec and has been in production in
> non-Linux OS drivers for over a decade.
> 
> This patch implements the PCI probe and remove flows, including FLR,
> firmware readiness, interface negotiation and capability discovery,
> followed by port and ring configuration.
> 
> It also adds the VSC access layer for PCI configuration-space accesses
> to the initialization segment and to the NODNIC configuration registers.
> Set up the event IRQ for link-state notifications, retrieve the port MAC
> address, and implement the netdev lifecycle, including ndo_open and
> ndo_stop.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Unfortunately this patch introduces a number of Sparse warnings.
Which other than looking like they should be addressed
also appears to have gated sashiko-nipa from running.

.../nodnic/nodnic_pci_vsc.c:336:16: warning: cast to restricted __le32
.../nodnic/nodnic_pci_vsc.c:336:16: warning: incorrect type in return expression (different base types)
.../nodnic/nodnic_pci_vsc.c:336:16:    expected unsigned int
.../nodnic/nodnic_pci_vsc.c:336:16:    got restricted __be32 [usertype]
.../nodnic/nodnic_pci_vsc.c:341:16: warning: cast to restricted __be32
.../nodnic/nodnic_pci_vsc.c:341:16: warning: incorrect type in return expression (different base types)
.../nodnic/nodnic_pci_vsc.c:341:16:    expected unsigned int
.../nodnic/nodnic_pci_vsc.c:341:16:    got restricted __le32 [usertype]
.../nodnic/nodnic_pci_vsc.c:363:25: warning: cast to restricted __le32
.../nodnic/nodnic_pci_vsc.c:407:17: warning: cast to restricted __le32
.../nodnic/nodnic_pci_vsc.c:415:14: warning: incorrect type in assignment (different base types)
.../nodnic/nodnic_pci_vsc.c:415:14:    expected unsigned int [usertype] data
.../nodnic/nodnic_pci_vsc.c:415:14:    got restricted __le32 [usertype]
.../nodnic/en_cfg.c:28:16: warning: incorrect type in assignment (different base types)
.../nodnic/en_cfg.c:28:16:    expected unsigned int [usertype] addr_h
.../nodnic/en_cfg.c:28:16:    got restricted __be32 [usertype]
.../nodnic/en_cfg.c:117:15: warning: incorrect type in assignment (different base types)
.../nodnic/en_cfg.c:117:15:    expected unsigned int [usertype] dbr_h
.../nodnic/en_cfg.c:117:15:    got restricted __be32 [usertype]
.../nodnic/en_cfg.c:237:15: warning: incorrect type in assignment (different base types)
.../nodnic/en_cfg.c:237:15:    expected unsigned int [usertype] dbr_l
.../nodnic/en_cfg.c:237:15:    got restricted __be32 [usertype]
.../nodnic/en_cfg.c:248:15: warning: incorrect type in assignment (different base types)
.../nodnic/en_cfg.c:248:15:    expected unsigned int [usertype] dbr_h
.../nodnic/en_cfg.c:248:15:    got restricted __be32 [usertype]

-- 
pw-bot: changes-requested
