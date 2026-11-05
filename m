Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871611;
	b=2mpn51kR7S+Yg1Zcz0iD28q233hNcrpZQH+oLZhpD3jKj0lakUCozuEu7bmC/ub8tiR8
	 qg6JIMNMbsIZrfaQb42AMlj2PtYOAdP0lebmeC3P7i/ixopWlhsdDhJqdZNp0+uQEG1D3
	 zkbNQCCd3DqF5Rn77uUcD1fvW3J7AnAovhyaLWERxuD3tpPHYou/1Z9jqxOUd76zCenBl
	 MpqZV41UAlmMSvIgnvCyFbGVofVKbWTxueLv9BfamNqM6KbY0PNr6XxOw85aYmY7VGaLu
	 Yuu7WN5TxtF0eSD6wxUTFuNPEvsMZ95GQrtZ4sw1A3sQToX9T9EAeaZWzJ7X/7YAQjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871611;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IAkDT+xOxuplCH0DU1qbjq1v0CAsiM+XsgikQ8pVRS0=;
	b=Q+gKxrtz/sSpUdH8hpZRb/Q2pJyTx3aALEMBKAOXmzP3noCa6lSR9VgltWtsXBf+1EYe
	 sZnPJtwp38cA8Eo5xBDII+TodFvKp6x/26SaFV6emIPbbWVzGDVHornmorpqdF/k2EKPq
	 njgR8b5UdvNWeubGdPajJAV7XIptLFtmPdY3AB1XaBcJKvoogtL5vziRBVZEE49MY9K/b
	 8814afW5/lC4BX/OOp5R780IQYMBpP2UzUjgqaS1P/k0fFRKMJ8rklbZUtzmVeCY5t8xr
	 wDrz+rX4DpWFsFB4oEhJoOoFrgBtzYjVvz8fbGVef2qsLPB9aBixLnHG+uOZBVyYe+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ixG24aBT;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC021606A31B;
	Thu,  5 Nov 2026 09:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC021606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=ixG24aBT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793871611; x=1825407611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0zMxg5jJREjnB3ChtK0twT9anfZvUFbnTRKAGFoCWSM=;
  b=ixG24aBTLgWMaK+mBBLg0mi7CS45KfmfDovzFzkmu6HA2kyz98XLeLSw
   HI5NdLXfgxwUW09lWFHOEatdcT0MXrbo9potOjCOJrl4AXvGz9VZ55mkO
   raloo0s+3IGmfMlZ+SHs3Uu9zFe6z5gt65sq+GM+pZc/03jXiL2c5hyPp
   i2qyTwGOs5/UoMY7HjC4/TLT/9d7Mfq2SpaW6x+4UhMNEiCcayNZxERLV
   TriwjvQ2uUzAaq1q0JtqWpe1STHgJlyp2BPEkjZNbRoBB3NWqKfJOs7rB
   zeSCAXnkEAudIgCAi75p282uJZk9HzY1+naHo1JZdyOD5lOepB9B/xmCa
   Q==;
X-CSE-ConnectionGUID: /4wbJlm7S2GHsXCNxkp7Ng==
X-CSE-MsgGUID: qIHMoxitTvqGuLVkkg26/g==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="297491437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2026 02:40:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Nov 2026 02:40:03 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 5 Nov 2026 02:40:01 -0700
Date: Thu, 5 Nov 2026 10:40:01 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <robert.marko@sartura.hr>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/5] net: sparx5: add tc matchall port
 policer offload
Message-ID: <20261105094001.dqcpzra54a2okwc6@DEN-DL-M70577>
References: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
 <679b8dcf-0aac-4674-a006-5af0156a82ae@redhat.com>
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
In-Reply-To: <679b8dcf-0aac-4674-a006-5af0156a82ae@redhat.com>

> > This series adds offload of tc matchall filters with a police action to
> > the ingress port policers of Sparx5 and lan969x, which are both served
> > by the sparx5 driver.
> > 
> > In hardware, each ingress port has four single-rate leaky bucket
> > policers. A policer drops the frames that exceed its rate and burst.
> > The four policers of a port share the pass and drop statistics counters
> > of the port.
> > 
> > The driver uses one policer per port, because with more than one, the
> > statistics reported to tc could not be attributed to the right policer.
> > This matches lan966x and ocelot. The policer meters each frame without
> > preamble and inter-frame gap, so the configured rate is a data rate, as
> > tc police expects and as on lan966x and ocelot.
> > 
> > Since the policer meters all ingress frames on the port, only filters on
> > chain 0 with protocol all are offloaded, and filters on shared blocks
> > are rejected. A police action that is already offloaded as a port
> > policer on another port is rejected too, since in software it is a
> > single bucket for all of its users. Only drop is supported as the exceed
> > action, and the police overhead parameter is not supported.
> > 
> > Patch #1 drops a redundant prefix from the existing POL_UPD_INT_CFG
> > register macros.
> > 
> > Patch #2 adds the registers used by the port policer.
> > 
> > Patch #3 tracks whether the ingress block of a port is shared, and adds
> > the per-port policer state.
> > 
> > Patch #4 adds the hardware programming of the port policer.
> > 
> > Patch #5 adds the tc matchall offload.
> > 
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> I understand the following will be very frustrating, but for unknown
> reason AI review did not kick on this series.
> 
> The changes looks sane to me, and addressing points raised on v1, but
> I think nowadays we need an explicit AI feedback.
> 
> Could you please re-submit the series?
> 
> Thanks!
> 
> Paolo
>

pw-bot: cr
