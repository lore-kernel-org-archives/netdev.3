Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958089;
	b=VM57uxprj9gUE1mzcM/aoITelHHCRMKHlKgkuR1yHEINAvypS4GEkvosmKoetlpyMZ0X
	 tLIAs+vVZsQrGiQCHyJGsgcnBoJrq2Ucb57XlfbMcSjUiYnlqklWEkibENCZKf/PFn2+R
	 ozEu5UdOI3YdYsGiwaN10KUPtRGz6IDmlQTnrftntn1phfoS/HE3qb1zb/Xm0D+TDvzqk
	 gwCG0QHIKNRXnM6C1GTqvcNILwIKVXpzaU4zcyiJLe/VxWVTPc575alX/z/m3vUm6Sh2D
	 6kJXx1jEVhPXoX20cwj6RsJG1aiiYO+UkNiotBdek9hKgStycmkpCC0cSez98lr0pzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958089;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1exxipTv9IiQ4CFiwZMgERtOohWMODoKe3iruSUX1ks=;
	b=5S0sArOBMRbKRpE4zFjlG2svTU7nZbQQtb9I7JoQd5BMZgRKZXBnp5GAka3dtC/6Hhh3
	 PY4f/2+v4z3M0jTgL2ONZW6szR2E7Ixi9wdoE+TkNYzcBjIjOvaRCNgC8GLMbriMAhp4k
	 fLTGYQyPMj9Hm55mIruuPr/7ZOILGriTTMpgyANx8gC6FJTZ43ZaxMBrSiZaON+fp5iFh
	 SaL7f45zNOujpfvplstxa445bQueRt+M0CK8Xi4ywb2wU5d45VVxnpQo1zQmaJ0gVrq6L
	 baRmDCtRLrLpTebwP84z4hJwc/5eSR67AVZ7BZRNeYPB6gcwlJLyWXLUK2XXH8FZ2sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Xqk4FRTu;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41357606A337;
	Fri,  6 Nov 2026 09:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41357606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Xqk4FRTu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793958096; x=1825494096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=67kVbicySHuWcNkpVHn4W3YahsEdItA4bDjmrETlHe4=;
  b=Xqk4FRTuDsygaU4tn5s8LgVLRIHC7i9B3m3jFGMtikYtO1b9hGZX52u2
   W4wUr0gGaIHVXzrqI/8ZxEtIMRrkQZ5m1ON+rpdbfDIZP8bYvgnTlJtnx
   md2T94Xxt5xr18bDW/1k/t5hnFlszzn9+/bE0ZUobTJKS7ztCsWf98bCP
   wziD74UEoa+mVKKEPCMjA82tyrrW8l+lAqPdaJnZ/PPI/6KVdWerXgPJp
   RtwuD4clksSd20aY0Fb4vx5GQ0A2aS+2fFq3+UvImSOVi1eaD3YlYCypw
   7X0OT2W05scCsUxuRSs6pPqmhhDmE5L9s0tf84P2YemhWyVjV2PKkonv4
   w==;
X-CSE-ConnectionGUID: fgCLId+0QImcz1YZKgVwuQ==
X-CSE-MsgGUID: DGipp+l1ToGdPxU3hQXU6Q==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="233190452"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 02:41:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 02:41:27 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 6 Nov 2026 02:41:26 -0700
Date: Fri, 6 Nov 2026 10:41:25 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>, <macro@orcam.me.uk>
Subject: Re: [PATCH net-next 2/3] net: sb1250-mac: Advertise and honor RX
 checksum offload
Message-ID: <20261106094125.iewq3iguiz3jctvb@DEN-DL-M70577>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
 <20261105193435.2050321-3-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261105193435.2050321-3-f.fainelli@gmail.com>

> The driver already trusts hardware RX checksum status on supported
> chip revisions, but does not advertise NETIF_F_RXCSUM. Consequently,
> ethtool does not report the offload or allow it to be disabled.
> 
> Advertise RX checksum offload in hw_features and enable it by default
> when the existing hardware revision check reports support. Test the
> active feature bit in the receive path before marking a packet as
> CHECKSUM_UNNECESSARY, so disabling RX checksum offload restores software
> verification. Hardware can continue computing checksums while their
> results are ignored.
> 
> BCM1250 pass 1 does not support the offload and retains the existing
> software checksum behavior.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
