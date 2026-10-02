Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C8233944;
	Fri,  2 Oct 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961442; cv=none; b=shfmtpVrUF/LQEfamisVevHf28Si4sIdnp1FHBmqcR3bnCvbV4yjk+p7iY8QxgPtaX3DSQbnMxrmDzqha3UFG+1CIaSL2J5luGqaL31NTiZjgjCUZKj4KCJ1+GUxB9UFfPhi8VnqMINFTl15fLxFUgfy3nAFeDFKH4qcsC9OY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961442; c=relaxed/simple;
	bh=0BQrA6cGRVgn5Q0h1ymYVtH9JB80FTDxnzz0Tt4mKBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy/aWcuXrN2evYlD1kOJH0VcKoIdSp4J3nUFBWsvV8/o+S4irKupaM/H2bApRCyWwJ6fJPoyJNqtKlp3BP8NXQXYvme+PQCgQ52CCc3SFFnCcj1SHJYgHbC5Xc52xTXbasCQ+K6atlY3VJPMG1HNDAw2sTCUe1gbrKVDCEwH+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaMVPMRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaMVPMRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FA61F000FF;
	Fri,  2 Oct 2026 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790961437;
	bh=Yzk55Y+Q7QB7A9bgtfVqi/SIgCigyGqIZC+IFnFhhTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TaMVPMRjtDthJjauw1G04/SU3fDEjFyXRe7wsTxeQWfhs8CuDjoybovXM7RrKDZUl
	 FbszEqF56f9y+87FOl6W1Noaylboj0l5VhLMlvzqicg1CcVJm4QUzpylh9uvotG7y8
	 yWs1/Yb/+oLboHLveYYr1GNJUyHiPoHLVotryWmiM6q+Z1QOu36aZ9yAZ4weWTCcS9
	 IEyECUzef6/N0AKcjbc1hT56jfs1HKHCukJnhlRcV0tqONnVpuWzdDaVPDvWWg4oS+
	 2CH/u8k60jGvuXYU4RNe4/VL4k81I0senT27z3rFYmAakorV6B3Oryd1rV2hzOtaEf
	 0i6PWsc7vR43Q==
Date: Fri, 2 Oct 2026 18:17:12 +0100
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
Subject: Re: [PATCH net-next 0/5] net/mlx5: Introduce mlx5_nodnic, a driver
 for DRAM-less NVIDIA Mellanox NIC functions
Message-ID: <20261002171712.GN13925@horms.kernel.org>
References: <20260930125708.144767-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930125708.144767-1-tariqt@nvidia.com>

On Wed, Sep 30, 2026 at 03:57:03PM +0300, Tariq Toukan wrote:
> Hi,
> 
> This series by Shahar introduces mlx5_nodnic, a Linux driver for the
> NODNIC (No-DRAM NIC) hardware interface present in Mellanox/NVIDIA
> ConnectX-family ASICs since 2015.
> 
> NODNIC is a first-class hardware capability.
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
> Where it is used today:
> - Embedded management controllers on ConnectX-class ASICs that need a
>   network path to the host without consuming a data-path PF.
> - Resource-constrained SoC integrations (no local DRAM) where a
>   minimal-footprint driver is required.
> - Pre-boot / early-OS environments (PXE, iSCSI boot) that need a NIC
>   without a full mlx5e stack.
> - BF4 management PFs (one concrete deployment): on BlueField-4 the
>   firmware exposes a NODNIC PF on the host side and a peer PF on the ARM
>   side, using standard vport forwarding to connect them. This provides
>   in-band Ethernet connectivity between the host and the DPU OS - SSH,
>   PXE, and any standard networking application work over it without any
>   special handling.
> 
> Design notes:
> - The driver is separate from mlx5e rather than a mode within it.
>   NODNIC uses PCI Vendor Specific Capability (VSC) for command
>   operations - reads and writes over PCI config space - instead of the
>   DMA-based command interface used by mlx5_core. This is what makes
>   NODNIC usable in environments without reliable DMA access, and it
>   makes the two command paths fundamentally incompatible. Folding this
>   into mlx5e would mean carrying a second command transport and a second
>   resource model through code that is already dense.
> - A single SQ, RQ and shared CQ are exposed per function, with two MSI-X
>   vectors: the data vector fires on CQEs and drives both TX and RX
>   completions, and the event vector notifies on port state changes.
>   This is the hardware's model, not a driver simplification.
> - The driver exposes a plain netdev with no private uAPI, no ioctls and
>   no vendor-specific configuration surface. Everything is driven through
>   standard netdev, ethtool and devlink interfaces.
> - The code lives under drivers/net/ethernet/mellanox/mlx5/nodnic/ and
>   shares no paths with mlx5e, keeping the footprint small and the blast
>   radius of changes contained.

Thanks for the above. I agree that this is a valid use-case.
And that the design approach taken is appropriate.

One minor nit: the above mentions devlink, but that doesn't seem to
appear in the driver. Not a big deal. But something I noticed.

Also, I do note that the first two patches are rather large.
But it's a new driver, and that is hard to avoid.

...
