Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871556;
	b=e6IJnoR277VzMHyKQNKlI/rUYBRhrxS6D7YKrDrFsctqJkQxXh52ayueU9DGO28tqbwm
	 BJJOtnwn2Th1XzlF+WIex/zyYsTaPEHxi2eS4s8Bkl80Z1QiMtoxTfan5pmJd/lzC5BYt
	 zrb1f0R3yjK0ccMioHd0XdDAhDMAWBeIQZwV4nGOCdiQiKosFmHF0TkjTRuKDd9E3dhjk
	 K+dAy56tpPAAg718b/xwgS1LWYDs2bwnZ3+w+R/vZDxA56d0WebnDZAMNtt99pILne9KI
	 j1GParfauDdGZ0CTTAwJpd6R+9j5+0gifOpgyIiQ+kcRSTl1ZSTd8f2VTPECg2T+hSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871556;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7R2UOvgn9PI8GoXBAsiFuJshfeF1YzTCjF9GuawHyn4=;
	b=x8zaIttYY6bmy5GQSKuApcAG9/l3D+PTzTkot3WFqlywQHEjcskDau80IKY/AxHgSnqV
	 +n02E+J4tclHCxht1t5JKpYcz9LWH4JH5r9ebQVZYC6kuWCIep09U+dEsHXiKD3+vQCy0
	 okMI8VRUs3MYVfJHTNAYuNn8+YncFp8gXGtcRtrxrTbfEfemV6TIuNwBw1HIAdHCFhuun
	 c7sMmhlrR4seQxxJ1L6U690zVuIMNLsNpyWykxbaouo5P3qP5TyB1sJVZzMHk4pcoRHqR
	 jjq626IigAimehU2TTxhzWxeKktVw6Q1k37sj9MPkYSY7HjJwptKwFkQBRXubdFbRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=NvW9ava0;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A43606D819;
	Thu,  5 Nov 2026 09:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A43606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=NvW9ava0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793871562; x=1825407562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cb0qXMc4wguc0QQCdheJz92gBP+uNeydJh/Nj2aUfIk=;
  b=NvW9ava0pFJmacjE/IY2OEp6R4QMGfARBgjw9rKenVEOTnJ1mCtJzhYH
   kV5KYLKNE/F4peiB/RIIcspNzBr3IpzRSF3ZEcL5mpUD6qT1TaKslLPpx
   qPUQml7j1f28QAnydzsdJg3f8rymX1RVywE1FrBb6x3EI/8XZRbAA0z44
   g2XxHeZPzPo8tqQDYP+C/2xjJATeo6+M6M7PhyJ9xx4GLmhyOo3+Oz7BR
   WZ7V3qHu6NCOTHfbvjizq/mov0vjYzWFN+3Bvn9MB7Bzq80nwaEsc/1go
   nFDzZaA9PpsgeLHJFJIEc33Q2xiJbU18Fw4r9rcxwGq+TYqG01cRGqabk
   Q==;
X-CSE-ConnectionGUID: uOkjWd00SQKHHMxTU88xVA==
X-CSE-MsgGUID: KkZQKROvQzuPrPC+15rDBA==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="66311469"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2026 02:39:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Nov 2026 02:39:08 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 5 Nov 2026 02:39:06 -0700
Date: Thu, 5 Nov 2026 10:39:05 +0100
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
Message-ID: <20261105093905.ln6tdot26wyej7pi@DEN-DL-M70577>
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

Yes, I noticed that. I thought you maybe had some magic button you could push,
in order to trigger the review manually.

> 
> The changes looks sane to me, and addressing points raised on v1, but
> I think nowadays we need an explicit AI feedback.

Ack. I think the missing sashiko-nipa check is not isolated to this patchset
alone. Just FYI.

> 
> Could you please re-submit the series?
> 
> Thanks!
> 
> Paolo
>

/Daniel
