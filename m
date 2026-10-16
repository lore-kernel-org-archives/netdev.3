Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A142123F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141271; cv=none; b=iFC9+dl0uvGFZQBz3+IboDjkUDdK7cTBZlgu+53cVegXdhwAOkFjqngCWU0cfQDm4FGVn29N1x06EZ6/v7cianh3zcKYvkNtdvHoXEbGn8KR4r5cH1W6ozEgwT1S3g2gshUkp2NRyKfWtfs3LyNeCLhr1E442jlOulCXKpJ6jVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141271; c=relaxed/simple;
	bh=7rievG5oH4a47PFqylXvWpWaWTQ3re+8nOd+7POFa1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssjkHRkYNdHdazvs72Pu6AIYc07xxPxg38HHVg7vHp6O6KtN4D3EXfPgCWUmh+o7UQcaexL9PZtVv+EWFhmwrk+Kn340tXehrl4xTxYyXHFewH9XIa9TgudnhDTiPOXU5/CKYewcsrEbYd6zS0F/rZW1vFCHoywfniE43UxLMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XGzn4gZU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XGzn4gZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792141269; x=1823677269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7rievG5oH4a47PFqylXvWpWaWTQ3re+8nOd+7POFa1Q=;
  b=XGzn4gZUM5QgRealMXR3WfOm1vULUMdnapvse83RS81vbazld0hBNuK5
   +LM+cOPyo48MItmVCIjzn8U6q8QMGCPEH6kAHDFpQNayLIQ5o+dNhektm
   zzyIlt74rTqdYgSznSX0aw0/hn0EbZyDBuVsKI/2Owuqnvy6sMy3CoyFs
   8lDEKFMSlfBvUU6vjZ0gCaPdMLJJ87Dbocp90UlsJg/g5OfwcwzDHaBZ1
   //bQ/i9//aibnFZaOBQQctLsGLdFkFw8j5S0Y5aHYq5HWnp/HUmSDcULp
   0b58V+shTA8ymND9YR8ztufkuLmRPVnYiALUEe7VK5kjsMkBb7nvV/XCM
   Q==;
X-CSE-ConnectionGUID: nz5ujrE0Rr65Kj1Z2PYKjQ==
X-CSE-MsgGUID: DpaU7qlXQW6mCFTR04D97g==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="64187826"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:01:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 16 Oct 2026 02:01:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 02:01:05 -0700
Date: Fri, 16 Oct 2026 11:01:04 +0200
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
Subject: Re: [PATCH net-next v9 0/8] hsr: Add additional info to send/
 receive skbs
Message-ID: <20261016090104.cqli34hczhsav6e3@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>

Hi Sebastian,

> I am trying to extend linuxptp to support PTP over a HSR network.
> 
> This is the kernel side of the changes. In short PTP over HSR sends its
> packets to a multicast address and every node needs to forward the PTP
> packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
> In order to achieve this, the HSR stack must not duplicate and forward
> the PTP packets as it would do with other packets. The delay caused by
> the duplication and forwarding adds overhead which in turn makes the
> timing information within the PTP packet inaccurate.

I think the main reason is that PTP over HSR needs per-path delays, so packets
have to be steered out a specific ring port.

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

It was not entirely clear to me that hsr_hdr=1 meant "this frame already carries
an HSR tag" as opossed to "please add one".

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

I think my question on v8 still stands: some existing drivers will undo the
directed TX. Should they be updated to check for PTP frames? I am not sure
myself.

> 
> This has been tested in a pure software environment and in an HW-assisted
> environment where the HW is able to duplicate and duplicate packets

s/duplicate and duplicate/duplicate and deduplicate/

> but does not do it for PTP packets.
> It has not been tested within an environment where the HW is able to
> forward the PTP packet and correctly update the timing information.
> 
> ---
> v8…v9: https://patch.msgid.link/20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de
> - Use skb_postpush_data_move() for the data move
> - A few patches got their description updated so that the bot does
>   hopefully not complain about a few things that are meant to be (such
>   as skipping PRP).
> 
> v7…v8: https://patch.msgid.link/20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de
> - Use __u8 instead of uint8_t, add header file for in hsr_ptp.h
> - Add header file to if_hsr.h for struct ethhdr
> - Remove the inline keyword from hsr_ptp_test.c 
> 
> v6…v7: https://patch.msgid.link/20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de
> - Change the logic in hsr_create_tagged_frame():
>   - Don't update ->csum_start (the cloning takes care of this)
>   - pskb_may_pull() does not need to include HSR_HLEN (it only copies
>     'movelen')
>   - Set network header to 'movelen' which takes VLAN into account
> - Drop also PTP packets which were received on HSR_PT_INTERLINK (not
>   just HSR A/B).
> - Move include HSR header to include/uapi/linux/hsr_ptp.h, so it is also
>   available in userland.
> - selftests:
>   - Add hsr_ptp.sh alphabetically ordered to the Makefile
>   - Use "$0" in hsr_ptp.sh
>   - Drop unnused arguments in open_socket()
> 
> v5…v6: https://lore.kernel.org/r/20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de
> - hsr_ptp_test: Let it wait up to 100ms for a packet. Otherwise it will
>   complain if the recevied packet is not already in socket.
> - Use TEST_GEN_PROGS instead TEST_GEN_FILES, the test can not run
>   without additional arguments.
> - Make the inline header mandatory for sending ETH_P_1588 packets via
>   the HSR device.
> - Use kfree_skb() instead kfree() for the skb.
> - Rephrase the commit message saying that skb_clone() shares
>   skb_shared_info and does not copy it.
> 
> v4…v5: https://lore.kernel.org/r/20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de
> - Split the patch into smaller pieces
> - Added a test for the added inline header (which signals the port while
>   sending packets).
> - Replaced __pskb_copy() with skb_clone() + skb_cow_head() in
>   hsr_create_tagged_frame() to preserve timestamp request.
> 
> v3…v4: https://lore.kernel.org/r/20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de
> - Removed skb extention. The information within HSR is passed via
>   struct hsr_frame_info. Driver with HSR-offloading capabilities need to
>   know the HSR mode (HSR or PRP) and parse the skb to decide what needs
>   to be done (whether to send on both ports and if adding a header is
>   needed).
> 
> v2…v3: https://patch.msgid.link/20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de
> - Remove af_packet changes entirely.
> - Add an internal header to pass additional information for HSR-PTP
>   packets.
> - Remove PRP, userland will use slave devices directly.
> - Drop all received PTP packets. Userland needs to use the slave device
>   for RX.
> 
> v1…v2: https://patch.msgid.link/20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de
> - Added PRP support
> - skb extention is used instead of extending struct skb_shared_info
> - in af_packet
>   - packet_sendmsg_spkt() is no longer extended
>   - jump labels are used to avoid the overhead if there no socket that
>     is using this HSR extension.
> 
> ---
> Sebastian Andrzej Siewior (8):
>       hsr: Add header_ops::parse_protocol
>       hsr: Use skb_clone() while adding the HSR header
>       hsr: Add a magic header for sending PTP packets
>       hsr: Drop received PTP packets
>       hsr: Use the port and header information in hsr_forward_skb()
>       hsr: Assign a socket for cloned skbs
>       hsr: Move struct hsr_ethhdr to a global header
>       selftests: hsr: Add test for the inline PTP header on HSR
> 
>  MAINTAINERS                                    |   1 +
>  include/linux/if_hsr.h                         |   7 +
>  include/uapi/linux/hsr_ptp.h                   |  20 +
>  net/hsr/hsr_device.c                           |  67 +++-
>  net/hsr/hsr_forward.c                          |  84 +++--
>  net/hsr/hsr_forward.h                          |   3 +-
>  net/hsr/hsr_framereg.h                         |   2 +
>  net/hsr/hsr_main.h                             |   5 -
>  net/hsr/hsr_slave.c                            |  34 +-
>  tools/include/uapi/linux/hsr_ptp.h             |  20 +
>  tools/testing/selftests/net/hsr/.gitignore     |   1 +
>  tools/testing/selftests/net/hsr/Makefile       |   5 +
>  tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
>  tools/testing/selftests/net/hsr/hsr_ptp_test.c | 482 +++++++++++++++++++++++++
>  14 files changed, 791 insertions(+), 49 deletions(-)
> ---
> base-commit: ec8bf8280261294a9b9b4520414b42704c7f9f6b
> change-id: 20260204-hsr_ptp-1f6380f1d35f
> 
> Best regards,
> --  
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>

nit: the subject for the cover letter says little about the patchset, maybe that
could be updated.

/Daniel
