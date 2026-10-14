Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2C4DD3C9;
	Wed, 14 Oct 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971083; cv=none; b=Qld+1S7uSPTfW5CXmmt4ZafY3rPmG215pqbU8nrytEBpRGQdaKUw4ZtCj9e/rE1nUe6rA4/VyunxINmd631WgVYr5QdCGawfyyQQE+wDrxW3Hp+KB8uvE1QrTvAdxwFa3B2yahEjYxV+81BXa9I3/mFZSV2ngMUCpf53bhy9SPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971083; c=relaxed/simple;
	bh=ysek4aHBu0K0buhWqgycnMaaYu9WclMvVNBclLQQdm0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYLmUeHHF4b3lO9MGIdJiR/AGDXzDxDsykTjlFS7GygcdOcayoktvFdJste7ipMqS0tPz4HsDbpVqDF8cETZufqhaOs928+AJ+kxPkEhfcCvJHjq2hfGoetRfYBok3XgbNnfbP4urX4cF61geJy8Ns0bNS1J9JRvRuk7qtzmIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=whHQ98v3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="whHQ98v3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791971082; x=1823507082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ysek4aHBu0K0buhWqgycnMaaYu9WclMvVNBclLQQdm0=;
  b=whHQ98v3RxCKBx5CkrjCag/ngZl3979Ww125TMQKbdGS7jGjuXdCz1B6
   c191IG+7xF7eWOiTtVykMLB2n4UUU2/5unPx4Ozv4IpNZQMT1cnsNEe3R
   +gunkInhyep1mlvC788T2NM26a9jSkX6KaIVsMnjL67PUGVDGXEsAQNFk
   nkzCJOJSlQ2j+DYOSj1n6ddEwSdg4aYv1H11CjQzaTQzFhFle+KkZSknc
   QFgeXp1PEPpFKxr0acokmKBMrPFOIzpMqf/TeqxQdv5QxrXF9eDlPvCnE
   q+s1ZDZe7gHl5vMJc46akFeH1BloV4vjR/T1YjAOOjd/ah6CQ17lQ8ucB
   Q==;
X-CSE-ConnectionGUID: boNXzslZQNSo+OPTzTF2vw==
X-CSE-MsgGUID: fBHndb8dQ7CH8LVtG9XtNg==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="296435375"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 02:44:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 02:44:39 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 14 Oct 2026 02:44:37 -0700
Date: Wed, 14 Oct 2026 11:44:37 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/5] net: sparx5: add tc matchall port policer
 offload
Message-ID: <20261014094437.tunkwehr5w6v7hdn@DEN-DL-M70577>
References: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2@microchip.com>

> This series adds offload of tc matchall filters with a police action to
> the ingress port policers of Sparx5 and lan969x, which are both served
> by the sparx5 driver.
> 
> In hardware, each ingress port has four single-rate leaky bucket
> policers. A policer drops the frames that exceed its rate and burst.
> The four policers of a port share the pass and drop statistics counters
> of the port.
> 
> The driver uses one policer per port, because with more than one, the
> statistics reported to tc could not be attributed to the right policer.
> This matches lan966x and ocelot. The policer meters each frame
> including 20 bytes of preamble and inter-frame gap, so the configured
> rate is a line rate, also as on lan966x and ocelot.
> 
> Since the policer meters all ingress frames on the port, only filters on
> chain 0 with protocol all are offloaded, and filters on shared blocks
> are rejected. Only drop is supported as the exceed action, and the
> police overhead parameter is not supported.
> 
> Patch #1 drops a redundant prefix from the existing POL_UPD_INT_CFG
> register macros.
> 
> Patch #2 adds the registers used by the port policer.
> 
> Patch #3 tracks whether the ingress block of a port is shared, and adds
> the per-port policer state.
> 
> Patch #4 adds the hardware programming of the port policer.
> 
> Patch #5 adds the tc matchall offload.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
> Daniel Machon (5):
>       net: sparx5: Drop redundant POL_ prefix from POL_UPD_INT_CFG
>       net: sparx5: Add registers used by the port policer
>       net: sparx5: Track shared tc blocks and per-port policer state
>       net: sparx5: Add hardware programming for the port policer
>       net: sparx5: Offload tc port policers via matchall
> 
>  .../microchip/sparx5/lan969x/lan969x_regs.c        |   7 +
>  .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   1 +
>  .../net/ethernet/microchip/sparx5/sparx5_main.c    |   6 +-
>  .../net/ethernet/microchip/sparx5/sparx5_main.h    |  36 +-
>  .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 117 +++++-
>  .../net/ethernet/microchip/sparx5/sparx5_police.c  | 404 ++++++++++++++++++++-
>  drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   4 +
>  .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   7 +
>  .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   7 +
>  drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |  14 +-
>  .../ethernet/microchip/sparx5/sparx5_tc_matchall.c |  38 ++
>  11 files changed, 627 insertions(+), 14 deletions(-)
> ---
> base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
> change-id: 20260930-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-474610756e26
> 
> Best regards,
> -- 
> Daniel Machon <daniel.machon@microchip.com>
>

At least a few medium severity issues reported by sashiko are worth fixing. I
will respin a v2.

pw-bot: cr

