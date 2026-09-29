Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB55172E3;
	Tue, 29 Sep 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683752; cv=none; b=IIY1rClQIeTbzJeofzofMFSbKP01PXW5lmuw5ttj7W5S0E4RQTVveDAgTktWthz62/TRzOVu65FFIqHjhR29vPJQLkfxhXS29MP7z9M/NjfKzIduzkDd7sKihSUQcKgXRujgTJTbsNt+kJ4seFyR/iUPbr2567YOdJhQiLFzk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683752; c=relaxed/simple;
	bh=fUEHF47M7WKRCHrthzZ0wgaJU0aCQTKdbRlyJ0WN10M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfHJyC+aNs58XgOpvDqtNgWHCgv6IEXnfh76S+OLe9JK3RRRWFe+GUDgDNIeC07PVT0/h3pcdWMMg76Kf4PrJcnQd4OC8zg0ytYKnChPrWEHc8FP1VVyH7ZfEu9zguxvAwWkAjttP8869KUfSRmqul21IImuTCzkcmZRHUtRcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mf8Js0ww; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mf8Js0ww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790683749; x=1822219749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fUEHF47M7WKRCHrthzZ0wgaJU0aCQTKdbRlyJ0WN10M=;
  b=Mf8Js0wwBY7WcKqSB4XUT2KvGtOnkx18zBQGno218jO8FP90C50uOGAX
   nNfhU+hbdIW2ozDIMCSfNzi4MgcgWgf+2HWp+om9RLQIwlHGVEtNkffss
   hCqKYmdj6BjUSrO7W4GVNLyhz4iWpcOO+aqsI/MsQgABR4GFDpwBzoNIh
   /0TjA68BeIFik8Ac3IkCVQ4JefoHwOIoUOzqXCAU8qHXJ9dlvQVkXQcLM
   BlR/gvnU0jAtG8JypN5QVo3KLuboPqX0qzsmAt+pJEEr2G0uJO3W1qpp7
   Ehjcwz1PCX+HXYymu8O8TZQk9rtOPo8TE8JFYBDw24t73yaPbb5xv1TjF
   A==;
X-CSE-ConnectionGUID: m9FKC+SuTGSgQF4KR/WVAQ==
X-CSE-MsgGUID: 1e1vtWY5TeqyxnmFszmc5w==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="231424125"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 05:09:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 29 Sep 2026 05:09:02 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 05:09:00 -0700
Date: Tue, 29 Sep 2026 14:09:00 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Quentin Freimanis <quentin@q-lab.dev>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: start the domain 0 TOD counter on
 non-PTP lan969x variants
Message-ID: <20260929120900.zld2c3h4keqcnmcj@DEN-DL-M70577.microsemi.net>
References: <20260928044955.29647-1-quentin@q-lab.dev>
 <20260928151453.fzch356vrp3ergy7@DEN-DL-M70577>
 <4e1ef527-e843-4f1b-9f7f-cf2400fa443e@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e1ef527-e843-4f1b-9f7f-cf2400fa443e@q-lab.dev>

Hi Quentin,

> Hi Daniel, thanks for taking the time to reply.
> 
> On 9/28/26 8:14 AM, Daniel Machon wrote:
> > Hi Quentin,
> > 
> > > Currently the base non-PTP capable lan969x variants don't forward any
> > > ethernet frames. Testing showed that starting the domain 0 TOD counter
> > > gets them working again.
> > 
> > Ack. Not initializing the TOD domains on certain variants is a problem.
> > 
> > However, TOD domains shouldn't affect basic forwarding. I tried it on my board
> > with PTP forced off - no forwarding issues.
> > 
> > Certain TSN features do require TOD domains to be configured, though. How did
> > you test this, and what exactly did you see fail?
> 
> Here is my test setup:
> 
> - a LAN9698-V/3KW purchased on digikey in October 2025.
> 
> - My SoM dtsi [1], board dts [2], schematics of the som [3] and
> schematics of the carrier board [4].
> 
> - net/main commit a7bfaba4823e
> 
> - a minimal buildroot initramfs [5]
> 
> - eth10 in the test log is a 1g RGMII port connected to a RTL8211F PHY.
> 
> Note: I've snipped the output of some commands to save space.
> 
> Without this patch, right after a reboot:
> 
>     $ cat /proc/cmdline
>     console=ttyAT0,115200 earlycon
>     systemd.mask=systemd-networkd.service
>     systemd.mask=systemd-networkd.socket
> 
>     $ uname -a
>     Linux buildroot 7.3.0-rc4 #11 SMP PREEMPT Mon Sep 28 19:14:03 PDT
> 2026 aarch64 GNU/Linux
> 
>     $ ip link set eth10 up
> 
>     $ ip addr add 10.0.0.45/24 dev eth10
> 
>     $ ping 10.0.0.1
>     PING 10.0.0.1 (10.0.0.1): 56 data bytes
>     --- 10.0.0.1 ping statistics ---
>     9 packets transmitted, 0 packets received, 100% packet loss
> 
>     $ cat /proc/interrupts
>                 CPU0
>     20:          0  GIC-0  120 Level     sparx5-fdma
> 
>     $ ip -s link
>     12: eth10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>         link/ether 4e:b7:8e:61:37:1e brd ff:ff:ff:ff:ff:ff
>         RX:  bytes packets errors dropped  missed   mcast
>             53745     278      0       0       0     174
>         TX:  bytes packets errors dropped carrier collsns
>                 0       0      0       0       0       0
>         altname enx4eb78e61371e
> 
> After a fresh boot with this patch:
> 
>     $ cat /proc/cmdline
>     console=ttyAT0,115200 earlycon
> systemd.mask=systemd-networkd.service systemd.mask=systemd-networkd.socket
> 
>     $ uname -a
>     Linux buildroot 7.3.0-rc4 #10 SMP PREEMPT Sun Sep 27 21:23:12 PDT
> 2026 aarch64 GNU/Linux
> 
>     $ ip link set eth10 up
> 
>     $ ip addr add 10.0.0.45/24 dev eth10
> 
>     $ ping 10.0.0.1
>     PING 10.0.0.1 (10.0.0.1): 56 data bytes
>     64 bytes from 10.0.0.1: seq=0 ttl=64 time=1.927 ms
>     64 bytes from 10.0.0.1: seq=1 ttl=64 time=0.876 ms
>     64 bytes from 10.0.0.1: seq=2 ttl=64 time=0.832 ms
>     --- 10.0.0.1 ping statistics ---
>     3 packets transmitted, 3 packets received, 0% packet loss
>     round-trip min/avg/max = 0.832/1.211/1.927 ms
> 
>     $ cat /proc/interrupts
>                 CPU0
>     20:       2039  GIC-0  120 Level     sparx5-fdma
> 
>     $ ip -s link
> 
>     12: eth10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
> state UP mode DEFAULT group default qlen 1000
>         link/ether a2:ef:53:a5:06:73 brd ff:ff:ff:ff:ff:ff
>         RX:  bytes packets errors dropped  missed   mcast
>             147075    1646      0      96       0      61
>         TX:  bytes packets errors dropped carrier collsns
>             75918     957      0       0       0       0
> 
> 
> > 
> > > 
> > > Fix by moving the TOD counter start code into a helper and calling it in
> > > sparx5_ptp_init(). Non-PTP capable lan969x parts now start the domain 0
> > > counter, and PTP-capable parts start all three, as they used to. A similar
> > > workaround that starts all three and registers the PHC clocks is
> > > implemented in the vendor BSP 6.18 kernel [1].
> > 
> > What we do downstream, is to ensure that all domains and PHC's are configured
> > and registered on all variants, with a very simple is_sparx5() check.
> 
> My reasoning for only enabling the first counter and not registering the
> clocks is that the part does not have SPX5_FEATURE_PTP, so it should not
> expose any PTP features to userspace.
> 

I acknowledge the problem, and I agree that the PHCs should not be registered.
As for the solution, downstream we always start all three TOD domains, including
on sparx5. If you take the same approach here, you don't need the new helper.
Just move the existing TOD start sequence above the if (!sparx5->ptp) early
return, so the counters are always started, while the PHC registration below it
is still skipped on the non-PTP variants.

> > 
> > > 
> > > [1] https://github.com/microchip-ung/linux/tree/bsp-6.18-2026
> > > 
> > > Fixes: 207966787b71 ("net: sparx5: add feature support")
> > > Signed-off-by: Quentin Freimanis <quentin@q-lab.dev>
> > > ---
> > > If anyone with access to documentation more detailed than the
> > > register map knows WHY this clock needs to be running, I'd like to add
> > > that to the commit message.
> > 
> > 
> > > 
> > >   .../ethernet/microchip/sparx5/sparx5_ptp.c    | 72 +++++++++++++------
> > >   1 file changed, 49 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> > > index 5953e04ef14e..b436684ddae6 100644
> > > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> > > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
> > > @@ -573,6 +573,42 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
> > >          return 0;
> > >   }
> > > 
> > > +static int sparx5_ptp_tod_start(struct sparx5 *sparx5, u8 phc_mask)
> > > +{
> > > +       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
> > > +       int i;
> > > +
> > > +       if (phc_mask > GENMASK(SPARX5_PHC_COUNT - 1, 0))
> > > +               return -EINVAL;
> > > +
> > > +       /* Disable master counters */
> > > +       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
> > > +
> > > +       /* Configure the nominal TOD increment per clock cycle */
> > > +       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(phc_mask),
> > > +                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> > > +                sparx5, PTP_PTP_DOM_CFG);
> > > +
> > > +       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> > > +               if (!(phc_mask & BIT(i)))
> > > +                       continue;
> > > +
> > > +               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
> > > +                       PTP_CLK_PER_CFG(i, 0));
> > > +               spx5_wr((u32)(tod_adj >> 32), sparx5,
> > > +                       PTP_CLK_PER_CFG(i, 1));
> > > +       }
> > > +
> > > +       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
> > > +                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> > > +                sparx5, PTP_PTP_DOM_CFG);
> > > +
> > > +       /* Enable master counters */
> > > +       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(phc_mask), sparx5, PTP_PTP_DOM_CFG);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >   static struct ptp_clock_info sparx5_ptp_clock_info = {
> > >          .owner          = THIS_MODULE,
> > >          .name           = "sparx5 ptp",
> > > @@ -605,7 +641,6 @@ static int sparx5_ptp_phc_init(struct sparx5 *sparx5,
> > > 
> > >   int sparx5_ptp_init(struct sparx5 *sparx5)
> > >   {
> > > -       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
> > >          const struct sparx5_ops *ops = sparx5->data->ops;
> > >          struct sparx5_port *port;
> > >          int err, i;
> > > @@ -622,8 +657,17 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
> > >                  sparx5->ptp = 1;
> > >          }
> > > 
> > > -       if (!sparx5->ptp)
> > > +       if (!sparx5->ptp) {
> > > +               if (!is_sparx5(sparx5)) {
> > > +                       /* the base, non-ptp-capable lan969x variants need the first tod counter
> > 
> > Nit: s/the/The
> > 
> > > +                        * running to forward frames.
> > > +                        */
> > > +                       err = sparx5_ptp_tod_start(sparx5, BIT(0));
> > > +                       if (err)
> > > +                               return err;
> > > +               }
> > >                  return 0;
> > > +       }
> > > 
> > >          for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> > >                  err = sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
> > > @@ -635,27 +679,9 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
> > >          spin_lock_init(&sparx5->ptp_ts_id_lock);
> > >          mutex_init(&sparx5->ptp_lock);
> > > 
> > > -       /* Disable master counters */
> > > -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
> > > -
> > > -       /* Configure the nominal TOD increment per clock cycle */
> > > -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0x7),
> > > -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> > > -                sparx5, PTP_PTP_DOM_CFG);
> > > -
> > > -       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> > > -               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
> > > -                       PTP_CLK_PER_CFG(i, 0));
> > > -               spx5_wr((u32)(tod_adj >> 32), sparx5,
> > > -                       PTP_CLK_PER_CFG(i, 1));
> > > -       }
> > > -
> > > -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
> > > -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> > > -                sparx5, PTP_PTP_DOM_CFG);
> > > -
> > > -       /* Enable master counters */
> > > -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
> > > +       err = sparx5_ptp_tod_start(sparx5, GENMASK(SPARX5_PHC_COUNT - 1, 0));
> > > +       if (err)
> > > +               return err;
> > > 
> > >          for (i = 0; i < sparx5->data->consts->n_ports; i++) {
> > >                  port = sparx5->ports[i];
> > > --
> > > 2.55.0
> > > 
> > > 
> > 
> > /Daniel
> 
> [1]
> https://gitlab.com/qfreiman/buildroot-external-qlab/-/blob/master/board/qlab/openswitch-lan969x/dts/microchip/lan9698-openswitch.dtsi
> [2]
> https://gitlab.com/qfreiman/buildroot-external-qlab/-/blob/master/board/qlab/openswitch-lan969x/dts/microchip/lan9698-openswitch-10x10g.dts
> [3]
> https://gitlab.com/qfreiman/openswitch-lan969x/-/blob/master/openswitch-lan969x.pdf
> [4]
> https://gitlab.com/qfreiman/openswitch-10x10g-carrier/-/blob/master/openswitch-10x10g-carrier.pdf
> [5]
> https://gitlab.com/qfreiman/buildroot-external-qlab/-/blob/master/configs/qlab_openswitch_lan969x_defconfig
> 
> - Quentin
> 

/Daniel
