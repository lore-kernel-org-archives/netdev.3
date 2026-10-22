Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671466;
	b=qV/yAPDRD6KpEcN0X05jEQp3OrLlnrxRp8MmNU1eU/9fAviqE01hkBndlSk1CnvTSno3
	 4BkW017ss2/UmQ4Dr8DB5BhApvnSK5an4bwSHntGGrthJOrPFmM5MAfNA/x5BiaohPukL
	 CezQkNjBVMSH0nGoPMt2s2m4ctqw8MDYLjG9rguQQA3VGTIHaK1YrjRkpAJxC3B6iXKYy
	 AWAjop0EAa18d90VtKrc8vwU5cQKLWoBM9F0zCTt7xEuUxB+lRI8SWz1rRY68a0ZHaN5y
	 nR8Q7Mz//65PRsi9DSSEIs4ENjVFpW4rCd/+eERKKlWxIP7hEev0BFqzyYSlgNhYARQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671466;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:
	 Subject:From:To:CC:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=IDIWgFHtkKN0qFyPZ4ulufZujfYESP26RcU9o6ALHvk=;
	b=NpI1NPoP90q5IOj7MQazFti1f9eAhJwKmi7VFpOCjYSWe3PitKkXcb2akpGBqPkJbNO3
	 kLSMSRw5PxVy3R0nwnZENpOeifUi8OmZgx3YUPqSUBKAjfEbwQzuXiQ+WR3LDpHQwnY9W
	 RfEDxh2iyBYpTG7B2QwysdgrarxtAX5f2LK7GV6J106R1ll9jhqjv4SD10LehmVJ/iVHJ
	 yDxgRh7576QRtYUN+JkvVBIXcG96fiU8SmNPWf/A9jeltO2maegxOJ76R7v/Rzh6fBCGY
	 IufL1ppNNNhxrMWfR4IBKP0u9XGtl2z8HNm5Q8JGZLFfXN7Ky3T9AgWZbPtvwyxnQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cD5DgsO5;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA0606A31A;
	Thu, 22 Oct 2026 12:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67CA0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cD5DgsO5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792671465; x=1824207465;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KoiH/k+AEDOTwxpCk3nZuqPG78kez9SH8DRHyaeSgzQ=;
  b=cD5DgsO5MT1+E7jmzM2nr3JdDRY/7S4e8ltnGQIPkQKT9Ne0UqwYpqbx
   sBe9D1dxDSxYpHeYri4pBw3ppf2VUNMqt4x3Tt4qhbVsbHamoL5U5725u
   6EdOaHPzWtN81JjzPPLCQrACsTMhEd5Cr4PAVC1Doh6Wn9SnCeEx+X2Wm
   qOkTrhebf1FDKxCpALPCye3FZxkBJjPUypnJKONrWbh7QSDT/n3rB3pS8
   xXSoK5rUcIC9UfXBuj8W820Np1Suoaz8JOBHvivXfn+XgKoEBPDUuIOqu
   gUnss3xulzdsnaKGaFQhIOUjSbvvF3KI8oSwY6tgrstwqpTWYm4QJGajE
   w==;
X-CSE-ConnectionGUID: DLLUhzt7QoC/ZcAvf6UhMw==
X-CSE-MsgGUID: zw3vjhGISzGCeK7hSdrd/w==
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="64459479"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2026 05:17:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 22 Oct 2026 05:17:43 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 22 Oct 2026 05:17:40 -0700
Message-ID: <a1f7a38b614d0b5b802c422dab8ca304fd6b9a81.camel@microchip.com>
Subject: Re: [PATCH net-next v15 9/9] net: dsa: lan9645x: add port statistics
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>, <edumazet@kernel.org>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Thu, 22 Oct 2026 14:17:39 +0200
In-Reply-To: <179240453307.3135.2065386937763476332@kernel.org>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-9-562f316f78b9@microchip.com>
	 <179240453307.3135.2065386937763476332@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 10:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] lan9645x_stats_get_stats64()
>   (drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c) counts error=E2=
=80=A6
>=20
> --
>=20
> net: dsa: lan9645x: add port statistics
>=20
> This adds port statistics support to the lan9645x DSA driver. The 32 bit
> hardware counters are polled into a 64 bit software cache, and the pMAC
> counters are summed into the aggregate source. The cache is exposed throu=
gh
> ethtool -S, the standard ethtool groups and ndo_get_stats64.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > new file mode 100644
> > index 0000000000000..a21afb4d98532
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > @@ -0,0 +1,854 @@
>=20
> [ ... ]
>=20
> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +                             struct rtnl_link_stats64 *stats)
> > +{
>=20
> [ ... ]
>=20
> > +     stats->rx_packets =3D c[SCNT_RX_SHORT] +
> > +                         c[SCNT_RX_JABBER] +
> > +                         c[SCNT_RX_SZ_64] +
> > +                         c[SCNT_RX_SZ_65_127] +
> > +                         c[SCNT_RX_SZ_128_255] +
> > +                         c[SCNT_RX_SZ_256_511] +
> > +                         c[SCNT_RX_SZ_512_1023] +
> > +                         c[SCNT_RX_SZ_1024_1526] +
> > +                         c[SCNT_RX_SZ_JUMBO] +
> > +                         c[SCNT_RX_LONG] +
> > +                         c[SCNT_RX_PMAC_SHORT] +
> > +                         c[SCNT_RX_PMAC_FRAG] +
> > +                         c[SCNT_RX_PMAC_JABBER] +
> > +                         c[SCNT_RX_PMAC_SZ_64] +
> > +                         c[SCNT_RX_PMAC_SZ_65_127] +
> > +                         c[SCNT_RX_PMAC_SZ_128_255] +
> > +                         c[SCNT_RX_PMAC_SZ_256_511] +
> > +                         c[SCNT_RX_PMAC_SZ_512_1023] +
> > +                         c[SCNT_RX_PMAC_SZ_1024_1526] +
> > +                         c[SCNT_RX_PMAC_SZ_JUMBO] +
> > +                         c[SCNT_RX_PMAC_LONG];
> > +
> > +     stats->multicast =3D c[SCNT_RX_MC] + c[SCNT_RX_PMAC_MC];
> > +
> > +     stats->rx_errors =3D c[SCNT_RX_SHORT] +
> > +                        c[SCNT_RX_JABBER] +
> > +                        c[SCNT_RX_CRC] +
> > +                        c[SCNT_RX_LONG] +
> > +                        c[SCNT_RX_PMAC_SHORT] +
> > +                        c[SCNT_RX_PMAC_JABBER] +
> > +                        c[SCNT_RX_PMAC_CRC] +
> > +                        c[SCNT_RX_PMAC_LONG];
>=20
> [Severity: Medium]
> Should short, jabber and oversize frames be counted in rx_packets in
> lan9645x_stats_get_stats64()?
>=20
> rx_packets and rx_errors both add SCNT_RX_SHORT, SCNT_RX_JABBER and
> SCNT_RX_LONG, plus their pMAC versions. JABBER and LONG are also added to
> rx_length_errors. So every malformed frame received on a user port counts
> once as a good packet and once as an error.
>=20
> The rtnl_link_stats64 kernel-doc in include/uapi/linux/if_link.h says:
>=20
>   @rx_packets: Number of good packets received by the interface.
>=20
> The v5 changelog also says CRC and symbol error frames "are already count=
ed
> in SZ_* buckets". Since those buckets feed rx_packets, frames with a bad =
CRC
> would be counted as good packets as well.
>=20
> This also gives a different answer from lan9645x_stats_get_eth_mac_stats(=
),
> which counts good received frames as UC + MC + BC only:
>=20
>         m->FramesReceivedOK =3D c[SCNT_RX_UC] +
>                               c[SCNT_RX_MC] +
>                               c[SCNT_RX_BC] +
>                               ...
>=20
> As a result, rx_packets is larger than FramesReceivedOK by the number of
> errored frames. ocelot_port_get_stats64() uses a similar rx_packets formu=
la,
> but that does not match the uAPI description either.
>=20
> Could rx_packets be derived the same way as FramesReceivedOK?
>=20
> A separate point: c[SCNT_RX_PMAC_FRAG] is added to rx_packets but not to
> rx_errors. The comment in lan9645x_stats_get_rmon_stats() says:
>=20
>         /* ... Only SCNT_RX_PMAC_FRAG counts runts with an invalid
>          * CRC, so fragments is left unset rather than reporting the pMAC=
 alone.
>          */
>=20
> Going by that comment, a pMAC runt with a bad CRC would be counted as a
> good packet and left out of the error total. Is that intended?
>=20
> v12 removed the eMAC SCNT_RX_FRAG from rx_packets, but the pMAC version i=
s
> still there. Since the pMAC gets no traffic without MAC merge, this has
> little effect today.
>=20

Dismissed, intended.

This follows mscc/ocelot. The hardware has no good frames only octet
counter. rx_oct counts good and bad frames, so rx_bytes cannot follow
the uapi description. We make sure rx_packets matches by counting the
same frames as rx_bytes. Bad frames are also reported in rx_errors.

FramesReceivedOK is the 802.3 good frame count and is meant to differ.

SCNT_RX_PMAC_FRAG is the size class below 64 bytes for pMAC runts with
an invalid CRC, so it belongs in rx_packets next to the size buckets.
Its frames are already in rx_errors through SCNT_RX_PMAC_CRC, which
counts CRC errors at any frame size, in the same way a frame of 64
bytes or more with a bad CRC sits in a size bucket and in SCNT_RX_CRC.
Adding it to rx_errors would count those runts twice.

The eMAC SCNT_RX_FRAG is not the same counter. It only counts runts
with an invalid CRC on half-duplex links, and on full-duplex links
counts frames received after the port is paused, which is why it is
not used.


> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip=
.com

