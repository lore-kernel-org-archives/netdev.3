Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318508;
	b=P10CseeOB0SYeAbv0YAHotetX96BjuljrZWuIY8zygaXeUdsBHjOyZiol0OM3LzhZTtH
	 IzO1LiVLlIjsebO+1db7P05A/CltwcXC6RLoPlB+Vxs6OddpEpV7x2pkMEIcGxxTqD2oS
	 CGC4YdUomw2Z/mS7J6/1omolQHjcjwg9vncSVIABUWdV6AOjLpPUuyNem4nrk0+Zk5okB
	 yVFKqQ+xCA6HhtQpcXl4Hf90xiTxoXaYifuJ2jv4V7L0cUkum9UedPOjD5JzIbKUa6vVs
	 Hm1s+JRWX2fuuynkzBYVQ6zmVh9LCsM1jhMi1SEORUdyST4ZdgsNzhZQd6iwigmr6Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318508;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nhxcmlf02t8tB0VGPudyzFnUB3hbIb6rnT8ULNp8xvI=;
	b=d+IoJzN5kf0T5yDL8q/nL7DqLf3Uds/aKeXzOOzH0J1i5XQ5PKkFH4S2+2Du++tQku+D
	 kNo7BNRmP2ViwY2yj5KwV2mIKNtjby0HPZUsG43aouOJujuLwkB4JY6a2HllOOjrpwepZ
	 3t+6q58WdDPPqti18atQrq/MU8rSZjgujdSUONK12x7/+FMgEnQLjVuJBpKXF3/RD6Sl7
	 H3WGV25uuXXxAdWkW0stys3E9SfJ2ceJxb1sDDyE2AMeHG7V/JWxQ3KFrdN6YfEEPrB/U
	 WWaBon7ke6FdaI7xEXzHuAxQoGSHYChRRor6FV9kcG3j16X3Bt3TP0yIecjuxi4u19A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=i38rZivD;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3B60A380F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB3B60A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=i38rZivD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794318507; x=1825854507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j3sAg9DncxObE+sYhK8N4ZT+FkwBD0ePVUJazW9YdFc=;
  b=i38rZivDWnYEvIumyT58nE4L36d7x3lYrB2/clGnH4/Cv5Ly6shZLJFU
   /TRjXLVSLUrUeKgYAEk6iP6VkFhcC8rO2rlw5vKP0bBK0XeATrFil7HYd
   l967NoSCBNARXGk5o5k9KT6ks3rINQcjpVFLZMZ7GOgsxeaZlueXx3/Kx
   bbsIFZe5MHHUk7KmVR2UFfqdWrveVmh4KJa9PWOZyAIHnjLkZONAjRj83
   c/4bZef1UqDLSQmnXSGa+rF+aEYuWosg0/cb0L8af4H7cRfXZOsW7x1uy
   ELE/XLOTYYY8S63UmeTsP4XmdKl2unxHttZECWHgbIVjCuvZ4iYS280Yh
   g==;
X-CSE-ConnectionGUID: 1uIYJndmSOa1FHRf9lLQMA==
X-CSE-MsgGUID: CixZ41JER6eufba2RQYGPw==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="66290121"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 06:48:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Nov 2026 06:48:25 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:48:22 -0700
Date: Tue, 10 Nov 2026 14:48:22 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>, Danish
 Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>, "David S. Miller"
	<davem@davemloft.net>, Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Neelima Muralidharan <neelima@ti.com>, Paolo Abeni
	<pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar
 TK <pratheesh@ti.com>, Richard Cochran <richardcochran@gmail.com>, Simon
 Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v10 0/8] hsr: Allow to send packets on specific
 port and pass the timestamp
Message-ID: <20261110134822.hjqynfqx6yauvnrv@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
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
In-Reply-To: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>

> I am trying to extend linuxptp to support PTP over a HSR network.
> 
> This is the kernel side of the changes. In short PTP over HSR sends its
> packets to a multicast address and every node needs to forward the PTP
> packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
> In order to achieve this, the HSR stack must not duplicate and forward
> the PTP packets as it would do with other packets. The delay caused by
> the duplication and forwarding adds overhead which in turn makes the
> timing information within the PTP packet inaccurate.
> The PTP stack needs to forward the packets so it is aware of the delay
> and can update the PTP packet (the FOLLOW-UP) accordingly to the delay.
> 
> My current approach is to open the slave devices (eth0/ eth1) from
> userland in order to receive the PTP packets. Sending happens from the
> hsr0 device. The actual packet has an inline header prepended of type
> struct hsr_inline_header. The size of the header is equivalent to
> ethhdr. The header has a type (h_proto) at the same position as ethhdr
> and expects it to be ETH_P_1588 as this extra meta information is only
> relevant for PTP packets. It makes no sense to send PTP packets via the
> HSR interface because it gets duplicated and the timestamp information
> is lost so this should not break anything. As an additional safe guard
> there is a magic value at h_source position. The value has '0xaf' at the
> most significant byte which makes the address a locally administered
> multicast address.
> 
> The header passes two information from userland: On which slave port
> the packet has to be sent and does the HSR stack need to prepend a
> header or not.
> hsr_inline_header::{has_hsr_header = 1, req_tx_port = HSR_INLINE_HDR_PORT_A] 
> will send the packet on port PORT_A and it carries already a HSR tag.
> hsr_inline_header::{has_hsr_header = 0, req_tx_port = HSR_INLINE_HDR_PORT_B] 
> will send the packet on port PORT_B and add system's HSR tag.
> The header is skipped so that the remaining stack sees the actual data
> and can send it as requested.
> 
> The PRP packets are sent directly via the SLAVE interface. The standard
> mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP
> packets. There is not really a reason to use hsr interface.
> 
> HSR hardware offloading is optional. The driver needs to know if the
> operating mode is HSR or PRP. In PRP mode it needs to check the ether
> type and for ETH_P_1588 it must not perform any offloading.
> In HSR mode, for ether-type ETH_P_1588 there must be no offloading. If
> the ether-type is ETH_P_HSR there must be no offloading if the
> encapsulated protocol is ETH_P_1588.
> Driver with offloading support enabled need to be updated to handle
> these cases correctly. Also their firmware may need to be updated if
> cut-through forwarding is supported. This is not part of the series.
> 
> This has been tested in a pure software environment and in an HW-assisted
> environment where the HW is able to duplicate and deduplicate packets
> but does not do it for PTP packets.
> It has not been tested within an environment where the HW is able to
> forward the PTP packet and correctly update the timing information.

Hi Sebastian,

I gave v10 a spin on a lan969x board.

With a small test program sending on hsr0 and a PC capturing both ring ports:
 
 - frames go out only on the requested port, both when the kernel adds the HSR
   tag and when the frame already carries one. A supplied tag (src MAC, seq nr)
   is kept as is.
 - malformed inline headers are dropped.
 - received PTP (untagged, VLAN, HSR-tagged) is no longer forwarded or delivered
   on hsr0, but is still seen on the slave with ETH_P_ALL.
 - non-PTP traffic is forwarded and delivered as before.

I tested the offload case on lan969x, with all HSR offloads enabled, using a
driver prototype that identifies HSR PTP frames and steers them out the
requested port instead of duplicating them. All four cases (port A/B, with and
without a supplied tag) went out on the requested port only, and a supplied tag
was kept unchanged.

Overall I think it looks good. I have a few comments on 3/8 and 5/8, only minor
nits.

Thanks, Daniel
