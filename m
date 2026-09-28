Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF349EC52;
	Mon, 28 Sep 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593485; cv=none; b=uLtdD0C1Jl1dQuz5KPxf/oYYW0CIHo8MrfwJuUxUA4L8G7Z5DhjXIHWYI5GHjjIOL4SDEcpcsoEGMY/A5tKIOXfxClnMjK/IjrJMqNseRT2pu9MppfBRbwxGc+ahjKwyTrjDuJYPuOc8XnPocxprj5lCrQvn1UMzo7uHK/GlyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593485; c=relaxed/simple;
	bh=ZkjFAi/k8AmKcZuYiJLAefOEjecRNWDOt5UnznZtXIQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm93ttQZnvJEN2kwhCyeLQYmPnIu5TdeYL1l2PNjHLNCnUJMG0gKQMBDPH3DHEoxOHOKMNJZHKSqpnqZupHPUhLpG/UQuHZ/Pcyw5954YGOggfsRsOjTjtulHriC2iz24oF9jbMi4RhNNRkDbnOTvpgZkd2uC6R8lpLYA078Clc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M00qvVXS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M00qvVXS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790593488; x=1822129488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZkjFAi/k8AmKcZuYiJLAefOEjecRNWDOt5UnznZtXIQ=;
  b=M00qvVXSoqtOqfOJeY2mCE+7fG/yzH4LQpKCPCVHHgepa4+/nRd+Atpw
   2nSSbAV5XdHivM4NkXLOSl6bdRQZJOy/nlddzEruXqEg3fZ2GM21vGp3+
   Awe3Va/Y0HG0yKAHNZQTdyy+PQLn+L8wP6IemSd07Ei9tQyU29SEJN8Kj
   WNvO/tlqskFmwY09lPNOFoski304m/CPez/zzU3umKo3/UnPskzlrv2sV
   qDu9dbg7RkJnZ00SGmrDy7C9q+mZZZEt5thzjX9IxnBhfJhtHrrbm1iy8
   JcaMoJy8d4DxAVBCI3CDK/RZA0HqsJoc08g+MLhp/B5L0oIhCdgjf//VA
   Q==;
X-CSE-ConnectionGUID: b2K+lPFjT8+AVcLXeOju6w==
X-CSE-MsgGUID: qWsRg5LPQEadkleZV6n17A==
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="63312697"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 04:04:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 04:04:41 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 28 Sep 2026 04:04:39 -0700
Date: Mon, 28 Sep 2026 13:04:38 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <luka.perkov@sartura.hr>
Subject: Re: [PATCH net-next] net: lan969x: correct RGMII port mapping index
Message-ID: <20260928110438.unoxnyymg7zwuuqk@DEN-DL-M70577>
References: <20260922125112.2111256-1-robert.marko@sartura.hr>
 <20260928091804.hjnabzi52kz4ktmf@DEN-DL-M70577>
 <CA+HBbNG2nGXpXC63AVUJX3KaqzJG+Q=-Md92eTpq7Y-O4CHMzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNG2nGXpXC63AVUJX3KaqzJG+Q=-Md92eTpq7Y-O4CHMzg@mail.gmail.com>

Hi Robert,

> On Mon, Sep 28, 2026 at 11:18 AM Daniel Machon
> <daniel.machon@microchip.com> wrote:
> >
> > Hi Robert,
> >
> > > Currently, the lan969x_port_dev_mapping does not check for RGMII ports
> > > and just returns the physical port index.
> > >
> > > However, this does not work for RGMII ports as they have dedicated DEVRGMII
> > > register space with an dedicated instance per RGMII port.
> > >
> > > So, check if requested port index is an RGMII port and return the correct
> > > DEVRGMII index.
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > > index f3a9c71bea36a..bf5320c7a6ca8 100644
> > > --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > > +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > > @@ -142,6 +142,15 @@ static u32 lan969x_get_dev_mode_bit(struct sparx5 *sparx5, int port)
> > >
> > >  static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
> > >  {
> > > +       if (lan969x_port_is_rgmii(port)) {
> > > +               switch (port) {
> > > +               case 28:
> > > +                       return 0;
> > > +               case 29:
> > > +                       return 1;
> > > +               }
> > > +       }
> > > +
> > >         if (lan969x_port_is_5g(port)) {
> > >                 switch (port) {
> > >                 case 9:
> > > --
> > > 2.55.0
> > >
> >
> > The mapping itself is right, but as far as I can see nothing upstream
> > uses the returned index to access DEVRGMII. Every caller of
> > sparx5_port_dev_index() pairs it with sparx5_to_high_dev() or
> > sparx5_to_pcs_dev(), which never return TARGET_DEVRGMII. Those paths
> > are also never taken for RGMII ports. The code that does access
> > DEVRGMII, in lan969x_rgmii.c, computes its own index with
> > RGMII_PORT_IDX(). Sashiko, correctly points this out.
> >
> > So I don't think anything is broken today. Did you see a problem on
> > hardware that this fixes?
> >
> > FYI, we carry the same change downstream. But there it was added together with
> > RGMII MTU support, which reads and writes DEVRGMII_MAC_MAXLEN_CFG() using this
> > index.
> 
> Hi Andrew,
> As pointed out nothing yet is broken, hence no fixes tag.
> 
> I am using it downstream as well, for the MTU change support where as
> you pointed out RGMII code
> uses it to get the correct index.
> 
> So, I thought that it would be good idea to send it upstream before
> eventually getting around to sending
> the MTU change support as well.

It wasn't clear to me that this was preparation work for a future feature. As a
standlone patch it does nothing. IDK, to me it would make more sense to just
send it together with the patchset that would actually use it.

/Daniel

> 
> Regards,
> Robert
> 
> >
> > /Daniel
> 
> 
> 
> --
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura d.d.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr
