Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7F41C6A;
	Fri, 28 Aug 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897419; cv=none; b=MS5Y96ECJmJYXHlfddIbQD5y1uUCgCwtW+wFoUyt3mqncrGhh4OkHTSXZyVKip3CON5QLtKL4r8H32Gg9X0RyJZfiHyp9ySKlI1idYMvMpFiyKUWkmXL8yn9OQnEl8fjNPLzqZ5RwXV+NZD0DaRUJ/xPNaREUat8x52dw1QBSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897419; c=relaxed/simple;
	bh=2ShxXbg/WXPkLKVlOfIcxkSzSfE3n62us5GpSUhv3S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmphJfXxda1aswYl2OefYlWcbRZ7dhHRb4jIaS9clqGSGC68Wg8jAC4Y0ihU47BWn+sqyJwhQt8C2Ix6gbtGT1VL+MaHdBFg4erIFY7Tx0lPQ98CychpIx92H/7asd3Gsf5KnZ+SOGSKDOb5oTh7FRqkQ6rMMOMBZNojGGVUmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=cBKT+1MS; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="cBKT+1MS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A4BA1487E85;
	Fri, 28 Aug 2026 08:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1787897058; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IeXlbKopy25D1cxmA5FDWjy1hNWPVZ0ZdcBgGyK1nxY=;
	b=cBKT+1MSOlxZwKvXBXr9zaFsyz8vZ4BDTBZbG6VET1b542cLSfSj+AYJ9nIKNvQE6OcPwG
	q456RnIUXBg0lfmqjsUHoHm/46wsJTQ7UDaF+/7JtuQDCX+TVk9fL9pe2lB56ZhylsT+zp
	Prt9ywLdnX+qZsBM13sWUs87eAHSAUzJM5aGhixdKqHPF2WtDw8uCN3ijqGgbkiqQYZjBN
	wQhSud73d4OpaDKRAgegUCKk0/zdjQ51XFUraUtkwulC9GMQRebn5uNHdr9RH8ao6CD1FZ
	KoC2Jf4oSb3v8sEtC+R6whtBbdN95htktSO9RW315eYj1BHQ8ERgAPXBxRChSA==
Date: Fri, 28 Aug 2026 08:04:08 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: macb: fix zero UDPv4 checksum on transmit
Message-ID: <20260826-untrimmed-take-024590e9f9d8@thorsis.com>
Mail-Followup-To: Nicolai Buchwitz <nb@tipi-net.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260824134703.766708-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824134703.766708-1-nb@tipi-net.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

Am Mon, Aug 24, 2026 at 03:47:01PM +0200 schrieb Nicolai Buchwitz:
> When a UDPv4 checksum computes to zero, RFC 768 wants 0xffff on the
> wire, but the GEM sends the raw 0x0000, which receivers read as "no
> checksum". Raspberry Pi confirmed in a simulation of the Cadence IP
> that the engine skips the substitution for UDPv4. UDPv6 and TCP are
> fine, and the IP changelog suggests all GEM revisions could be affected.
> Reported and analyzed on the Raspberry Pi 5:
> https://github.com/raspberrypi/linux/issues/7550
> 
> Patch 2 does UDPv4 checksums in software and lets the existing pad
> and FCS path keep the hardware off the frame, UDPv6 and TCP keep
> the offload. That path miscounts tx_bytes by the software FCS, so
> patch 1 fixes the accounting first.
> 
> Tested on CM5. To reproduce, send bulk UDP to another host and capture
> zero checksums on the receiving side:
> 
>   iperf3 -c <host> -u -b 200M -t 30
>   tcpdump -ni <iface> 'src host <dut> and udp[6:2] == 0'
> 
> Without the fix a packet shows up every few seconds:
> 
>   12:46:20.002739 IP <dut>.36309 > <host>.5201: UDP, length 1448
>   12:46:23.773968 IP <dut>.36309 > <host>.5201: UDP, length 1448
>   12:46:40.227460 IP <dut>.36309 > <host>.5201: UDP, length 1448
> 
> With the fix the capture showed none.
> 
> Some numbers (udpgso_bench):
> - 18-byte UDP throughput dropped by ~ 8%
> - 256-byte UDP throughput dropped by ~ 10%
> - MTU-sized UDP and UDP GSO were unchanged at the 116 MiB/s link limit
> 
> Unfortunately I don't see a cheaper fix, the zero only shows up after
> computing the checksum, the MAC inserts it in flight, and AFAIU there is
> no register or descriptor bit for the substitution.
> 
> I'd appreciate testing on other silicon.

I tested without your patch on at91 sama5d2 (Cadence GEM rev
0x00020203), sam9x60 (Cadence MACB rev 0x0001010c), and sam9g20
(Cadence MACB rev 0x0001010c), and tried to reproduce the flaw (not
the fix).  Rewrote the Python reproducer suggested in that RPi github
issue in C, but iperf3 gave similar results:  tcpdump started as
suggested showed not a single wrong package!

However according to ethtool it seems at least the older MACB bases
hardware has no hardware checksumming here.  On sama5d2 (GEM, but no
Gigabit) I'm not sure if it is supposed to be done for UDP?  See:

    $ ethtool -k eth0 | grep sum
    rx-checksumming: on
    tx-checksumming: on
            tx-checksum-ipv4: off [fixed]
            tx-checksum-ip-generic: on
            tx-checksum-ipv6: off [fixed]
            tx-checksum-fcoe-crc: off [fixed]
            tx-checksum-sctp: off [fixed]
    tx-gre-csum-segmentation: off [fixed]
    tx-udp_tnl-csum-segmentation: off [fixed]
    tx-tunnel-remcsum-segmentation: off [fixed]
    esp-tx-csum-hw-offload: off [fixed]

On sam9x60 (MACB) there seems to be no hardware offloading at all:

    $ ethtool -k eth0 | grep sum
    rx-checksumming: off [fixed]
    tx-checksumming: off
            tx-checksum-ipv4: off [fixed]
            tx-checksum-ip-generic: off [fixed]
            tx-checksum-ipv6: off [fixed]
            tx-checksum-fcoe-crc: off [fixed]
            tx-checksum-sctp: off [fixed]
    tx-gre-csum-segmentation: off [fixed]
    tx-udp_tnl-csum-segmentation: off [fixed]
    tx-tunnel-remcsum-segmentation: off [fixed]
    esp-tx-csum-hw-offload: off [fixed]

How are those chips affected by your patch then?

> Nicolai Buchwitz (2):
>   net: macb: exclude software FCS from TX byte statistics
>   net: macb: fix zero UDPv4 checksum on transmit

That fix seems to be very generic and not specific to macb or gem nor
to any variant.  I'd suggest narrowing it down and testing on more
hardware.

Greets
Alex

> 
>  drivers/net/ethernet/cadence/macb.h      |  3 +++
>  drivers/net/ethernet/cadence/macb_main.c | 28 +++++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> -- 
> 2.53.0
> 
