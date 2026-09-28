Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198348BD5B;
	Mon, 28 Sep 2026 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587096; cv=none; b=FMH7BRr2KmZ/jQCuYYauTWwnE3uMtdGH83gjzmhZqE+J1Td2pq8SGKo1AgYtszHBBwgB0/C+ywzt2RRjl7UGNlygzAfMAxKd4SIW+cv8qA8vahlsx/IfxrzyV/bEx5OqDbEjx/YNzk2pC4lqsfhKmE6bTlyFKaKxtbZjQGhAao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587096; c=relaxed/simple;
	bh=b44XUbiRQYUmDL/k+pA2FEOKYweiIA5RdOF7K3sTzhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyOYCJGxTbJ/1gRdWDH0O7EY7P+WCBPM9GYHTal7HKm2Uyg3DauZ7hjs9SiTuL++XakmYAtgCN4PvgxwynJA+ZAHiuROK32RqySKc1fo37TewPG+w4aNDNOyCiFGXKM+C2nPe5t/k4CoxOHxv4lFWAFf2XIAgkHkWNQpvm5L6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AvzYlyMi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AvzYlyMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790587094; x=1822123094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b44XUbiRQYUmDL/k+pA2FEOKYweiIA5RdOF7K3sTzhI=;
  b=AvzYlyMiQqehsIw661p5RXFbvM3Q9TcyssQD+GnTKoIYsNCTqGJ6EwE5
   xIumFkgJnsbqnqZ7sQGsLFyj2ACB979pp2q8lJ58emoNRvAiBmjSlpqp/
   9xgAagcQmSRdigS5fRNlq5LJKMMGtMT4L5tmVJDI26/KcsZ/Ugrpl8bBf
   D8+wnYdQmokzvw/VOgvFmTp3uk2SCZcaqpGS3vA4ffiWScGlQJglsJA/n
   7xyb8mYckwtxkm8tSryJMINM9TyX9/XY9rwAtd7sjUUE2b539eK4r7OJ2
   T6S0VA9NDx6glzY8qeV2I3dGUiOGmDJnHApq6WMRauuQGk6+2iG0hW2Cl
   g==;
X-CSE-ConnectionGUID: q5Ut9g5gQUS/I7W0oGo0YQ==
X-CSE-MsgGUID: oaii23oQRuKf6L+crpEU7A==
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="231360037"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 02:18:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 02:18:07 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 28 Sep 2026 02:18:05 -0700
Date: Mon, 28 Sep 2026 11:18:04 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <luka.perkov@sartura.hr>
Subject: Re: [PATCH net-next] net: lan969x: correct RGMII port mapping index
Message-ID: <20260928091804.hjnabzi52kz4ktmf@DEN-DL-M70577>
References: <20260922125112.2111256-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922125112.2111256-1-robert.marko@sartura.hr>

Hi Robert,

> Currently, the lan969x_port_dev_mapping does not check for RGMII ports
> and just returns the physical port index.
> 
> However, this does not work for RGMII ports as they have dedicated DEVRGMII
> register space with an dedicated instance per RGMII port.
> 
> So, check if requested port index is an RGMII port and return the correct
> DEVRGMII index.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> index f3a9c71bea36a..bf5320c7a6ca8 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> @@ -142,6 +142,15 @@ static u32 lan969x_get_dev_mode_bit(struct sparx5 *sparx5, int port)
> 
>  static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
>  {
> +       if (lan969x_port_is_rgmii(port)) {
> +               switch (port) {
> +               case 28:
> +                       return 0;
> +               case 29:
> +                       return 1;
> +               }
> +       }
> +
>         if (lan969x_port_is_5g(port)) {
>                 switch (port) {
>                 case 9:
> --
> 2.55.0
> 

The mapping itself is right, but as far as I can see nothing upstream
uses the returned index to access DEVRGMII. Every caller of
sparx5_port_dev_index() pairs it with sparx5_to_high_dev() or
sparx5_to_pcs_dev(), which never return TARGET_DEVRGMII. Those paths
are also never taken for RGMII ports. The code that does access
DEVRGMII, in lan969x_rgmii.c, computes its own index with
RGMII_PORT_IDX(). Sashiko, correctly points this out.

So I don't think anything is broken today. Did you see a problem on
hardware that this fixes?

FYI, we carry the same change downstream. But there it was added together with
RGMII MTU support, which reads and writes DEVRGMII_MAC_MAXLEN_CFG() using this
index.

/Daniel
