Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2845A2B4;
	Fri,  7 Aug 2026 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141703; cv=none; b=o1WkZTDhpMiNrxhOuVwtKUaECyEX/q+L9IJFgHQzwSNRlRo3wSts/vqbqC1x63PmNtpHj0lB73RZW2aKMLs3lVfY7PcTE2Qy0lfDjZNUmu+ZyMA3lpUn9f1aWfNS6VGG135nB/QeP1EKImBd3mYNOgQ5Om8T4Memvrgzwexhtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141703; c=relaxed/simple;
	bh=CeNhOlk4AeFdTXVd3vtIq//YY7/J8FU0OC6HMfL6LMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfRSEXCUX/e1giF/uOpdAE8FzOcISJ4HJY0KNtM8zTKTkply0yIu842nNaUGNdSKy7nm3W2P3DNh477jQlXMdrNVAQ8oBTPxCizzcZLuTj64V2neCnl+unnsXlUy8jTyNhFTQ5eyoaR8ORH7GWVoWnjtztONZYuLpHStG4YUkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxA2zNj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxA2zNj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D861F00A3A;
	Fri,  7 Aug 2026 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786141692;
	bh=nGIUAbuxL/GgcZOYXFoP8N5vnO1KeR8oVK2AuhwwhYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gxA2zNj3ypUN+A8mJkuAmWbNt2KJKYtBA9kh+veuIaAYOBG7c0LmPZ6H20YVkXPMx
	 0iAzP8F/Au/95URMkGLQbFVTkpkD2z9rvbRe+Fk+grZ7mz40zV6AgxKusApQqb45AL
	 PgMqzHwd8Hh4/c2KZqCU8qPgVLen/t8YnAzLczlHVKkwh/e3HNbRNBhY8kruU1Tc5s
	 /rdRBhcJBFmUhOm9BC7zBvagJ9dxBgLxiZuGNvk0+u1rx9hgAYXkeGEEPhRYFpZYf3
	 rbMGst2O2zs3E/vkSaHFg0W1CLMIkS4AiNJR2RbhWfQcsh8M4jjHDtT8jByUnceBxa
	 J2wOaa/k+3o0w==
Date: Fri, 7 Aug 2026 15:28:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <git-dev@amd.com>
Subject: Re: [PATCH 00/20] xilinx: tsn: Add TSN Endpoint Ethernet MAC driver
 support
Message-ID: <20260807152811.68158042@kernel.org>
In-Reply-To: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 16:14:11 +0530 Nagadheeraj Rottela wrote:
> Nagadheeraj Rottela (13):
>   net: xilinx: tsn: deliver endpoint RX frames to DSA user ports
>   net: dsa: tag_xlnx_tsn: add skeleton tag protocol
>   net: dsa: xilinx: add skeleton driver for TSN switch
>   net: dsa: xilinx: implement port_stp_state_set
>   net: dsa: xilinx: register per-MAC MDIO buses
>   net: dsa: xilinx: wire up phylink for the switch ports
>   net: dsa: xilinx: program MAC frame filter and per-port nibbles
>   net: dsa: xilinx: register PHC backed by the RTC timer block
>   net: dsa: xilinx: drive per-MAC PTP TX/RX hardware paths
>   net: dsa: xilinx: opt into TX forwarding offload on bridge join
>   net: dsa: xilinx: offload the bridge FDB to the switch CAM
>   net: dsa: xilinx: offload bridge VLAN filtering to the switch
>   net: dsa: xilinx: trap link-local control frames to the CPU port
> 
> Srinivas Neeli (7):
>   dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
>   net: xilinx: tsn: add TSN endpoint wrapper driver
>   net: xilinx: tsn: add endpoint MAC driver skeleton
>   net: xilinx: tsn: parse endpoint DMA channel configuration
>   net: xilinx: tsn: bring up the endpoint MCDMA channels
>   net: xilinx: tsn: add the endpoint RX data path
>   net: xilinx: tsn: add the endpoint TX data path


This is so clearly two series squished into one.
We have a requirement to keep series under 15 patches.
The smaller the better, easier for people to review and merge.
A 20 patch series will take forever to be completely clean

Please read:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
