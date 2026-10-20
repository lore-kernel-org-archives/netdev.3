Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485346;
	b=VLwWpdIfBdO70hC+FQmspzukRqB/PjNsjp5ZLdRISW82GPcY9O+yqyI8jne1SkJvLU9+
	 fdHrm5s4d9g0lwJSqYNxomdE1pxwgfZVdJU10kPwOD94KhjECOjmCjDLfy52xZzlk+q+1
	 GGfjRLRq5gbo8oikKJ92XPgunPN9FC48ucJzLy2qAPnW7O7MtXRmC8a6lERY/7ZjWpviV
	 hFjZFJtjGe8Gyg1QmBYL8un1URSTsOd1fFM1EXhYlrfk9OKXKh1MutACLAkI2yGHG124m
	 O8yHTaiyTwt78L17fEHCt20dn7vXfd7ksO/J3I4RfpLWYueA3J95R/CG/Pz1e17HzAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RGJ6nvgIGJO/enN5yq9yuRJ1WU6gfRhfJ+bat/05ql0=;
	b=YEOo34q7QrLOJg1eWpSMhpG/xs1vSnw29cSjyqhRDSrTSG9sccYuX7XgyGfP0V83DU4c
	 hAGQAs3XX4KFD7AWFvA1O9eX5uNvkzvvppv3OgiTdgUc7ajd8cD3plF2+SJvGj0WM6jIP
	 BVxcfRGs+ZnTCHsplKMtw/FIxEOXzwWPgjZs4xGV0LWhkKS+aMfO+s1rQ67g/2kp7K2f3
	 f2Cq7KmUk+705yk6AmrPdpKWREwoEHpuU1Blt1rB7HsSYz76ry980gSHmOpq0NMzjlik1
	 fXOEBeNc+iS/hCt6JEHhpnc7gMNYNI5nhuYE/Oq7Poadcjqnr1oDbG5swOnOtztD5Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=G4Adzm5p;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4E606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=G4Adzm5p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792485346; x=1824021346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TAqQbgdhP5H4o91Dg2307RV6zgvSBoNN063Ur1kSnZ8=;
  b=G4Adzm5puCJ2G3oFF1eKbnRHVGbx6IVsyKL9NW/ie2oqnexRZ8VUcGld
   07XMSJo5EWJ5xX+qHILd4vCz8FLOPbQTUvuw4iv/9WCtvklfhsExWIsWt
   1QoasHeHovTHVK0kE2bDSXboucZowI39GOpXfHjVBN84l1S7biQgdJJFZ
   eWoGCueCuGnOwIFaiAP5k1CHCxPVZ12PtgW+EeoOxHI/oOuSUKA+vbKb9
   JyuCamAL/fO0PDEpAqiUoIroZvh6Ax5lSiTI4IKJ1LqQR/xRb+yL4Ss6d
   +5MrVFRGF9U4EDB4grUiB0LC7hhzvLgRZnZkwQ1tl7Fr3USxuM0p5iK+G
   A==;
X-CSE-ConnectionGUID: YAtt76YRRreTu7OcRhmFhA==
X-CSE-MsgGUID: MLrzO8XqQG+P0pA+PyGmtA==
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="296714639"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 01:35:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 20 Oct 2026 01:35:37 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 20 Oct 2026 01:35:34 -0700
Date: Tue, 20 Oct 2026 10:35:34 +0200
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
Subject: Re: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261020083534.p7layxpvmpu7p6yf@DEN-DL-M70577.microsemi.net>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
 <20261016090940.a2ztkv6p3wtysk57@DEN-DL-M70577.microsemi.net>
 <20261016094118.Mq6pgtly@linutronix.de>
 <20261019133348.Mp_8923i@linutronix.de>
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
In-Reply-To: <20261019133348.Mp_8923i@linutronix.de>

> On 2026-10-16 11:41:20 [+0200], To Daniel Machon wrote:
> > If this is important, I could add to the patch description. The removed
> > skb_reset_mac_header() should be obvious.
> > The csum_start() removal and so on was mostly sashiko complaining about
> > one thing at at time and memove() got replaced with
> > skb_postpush_data_move() in the last iteration which I just learned
> > about myself ;) That looks like a nice clean up.
> 
> Updated as:
> 
> | hsr_create_tagged_frame() creates a new skb where the HSR header can be
> | prepended via __pskb_copy(). This does not copy the skb_shared_info part
> | of the original skb so any timestamp request is lost.
> |
> | An alternative is to use skb_clone() where the skb_shared_info part is
> | shared and then skb_cow_head() to make the header part writeable. This
> | avoids touching manually the tx_flags and tskey members.
> | Using skb_clone() allows also return early (after the clone) in the
> | offloaded case so this can be unified a bit.
> | The clone case does not need manual adjustment of sk_buff::csum_start
> | because by using skb_cow_head() the head does not move relative to the
> | payload. Should the head need expansion then pskb_expand_head() will
> | move it and update sk_buff::csum_start accordingly. The clone also
> | preserves metadata (if available) so skb_postpush_data_move() is used
> | instead of memmove() to move both. Finally skb_reset_mac_len() is added
> | to set the new length of the header after expansion.
> |
> | This is a preparation for PTP handling where timestamps are requested.
> 
> Is this better?

LGTM.

> 
> > > /Daniel
> >
> Sebastian

/Daniel
