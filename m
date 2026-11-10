Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313493;
	b=eBD9nuceTB7b55ixW4N4ezrn+g7vuzNUbeRxbV7LuW59prpAas74IVVrI78JZ9SD6sqX
	 E0h8CVHAoX7STOSbXii6fjkq5leNCYOyofTozYXTHpcvWsBj1IwQpLBHrrGno3umf2Vr+
	 jZn1LSH0P1LUr0eZER9b2UzYSddqcLv7jFdA2uS0ub768OWqKYXnphiw1ejQTIPOmnZ6g
	 2KI5ji1iIVmDVKT9Oe94PK8JlMEbywAQnql+RU4Jgxt8utfuhWzeYLQh8yyG+xtxfUPrC
	 oBLmsp2nJGwZCRxA1EY+c2XBh5aLfOi/p3hK46EFSxKNfofWfEFJJb2Dnt5oHjUwmLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313493;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=G2QYycHOKTCIWtL0UlBz01TFWL0vV5FBj8Tf8Ts1PJs=;
	b=fwYBdpeC8PvMaEOSVTquGskF1Ui6Dv3mh6aD2RpyzVM/jEwHmW+PPA5ivdgb3N5vaUTx
	 7GwEHqUXSGGnUDATx32fi2OG/It31G9IUidmolKGvqyGkPN/7MyZuGA8MErABwsO6Lxdp
	 YaNSt42lUQpgMiePqM7yBsuI5UoPaWV0n2ze8YyySPWpTgMHqXkGlJ6IKLW9m9sHpJyGM
	 +2/n1xnHdvZrnjnRyK7Dxr1PuHLI/KdcPpYTfVC++FlyAIAyVWW6rYv98yTYJ49FhNgHW
	 GT9VY1esHtRduAqz/f+Tyn4CrXz6EqEsjj6snWoZZuBPAjwVy1RuvSUXXj61jN9jPtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=b9JBP+U7;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354960A2627
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9354960A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=b9JBP+U7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794313492; x=1825849492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eFgR4foWnI5sEXl20xwmcGqYtRzelWn6b82zj7JbO08=;
  b=b9JBP+U7D0k/VBfBIPjmFLm1Czt6q0eHlll42GFS3rGpvTMo/cmj2Wxe
   1K2npCJgMMKCQt6sRIsWLQ9OpOTbjFf40hZSO8UlRz5PGsH2ZsUVMcsqV
   qhCcE9rYZX9nn7EZc2RuDrwLBpGUabSayd2jf6IPC4FGuMJcfPBk59TmF
   ghXFxeteJy3rCFdG6ntTkKPW0ANtwdDsoc9wWLRCNlFRyu47JXHrM5S7w
   KEDwiqUDsDwbQl8dV2dTFA2Qq9s9WJPs/aK4Hvkdd7nANX7vdZo/P7+FC
   1qw4vv+0t4rqX8OXl/ZWHVwJOJCbRVV2ONIgO30EmQamdfp7g4jIxohcJ
   A==;
X-CSE-ConnectionGUID: +hvUYudsTUCjiiQCVUY0gw==
X-CSE-MsgGUID: sRMGi+kjRx6fN1UwVO/L1A==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="65322984"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 05:24:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 10 Nov 2026 05:24:51 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 05:24:48 -0700
Date: Tue, 10 Nov 2026 13:24:47 +0100
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
Subject: Re: [PATCH net-next v10 2/8] hsr: Use skb_clone() while adding the
 HSR header
Message-ID: <20261110122447.imt7jvbnwqo3dtbd@DEN-DL-M70577>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
 <20261104-hsr_ptp-v10-2-2c4a38ad973c@linutronix.de>
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
In-Reply-To: <20261104-hsr_ptp-v10-2-2c4a38ad973c@linutronix.de>

> hsr_create_tagged_frame() creates a new skb where the HSR header can be
> prepended via __pskb_copy(). This does not copy the skb_shared_info part
> of the original skb so any timestamp request is lost.
> 
> An alternative is to use skb_clone() where the skb_shared_info part is
> shared and then skb_cow_head() to make the header part writeable. This
> avoids touching manually the tx_flags and tskey members.
> Using skb_clone() allows also return early (after the clone) in the
> offloaded case so this can be unified a bit.
> The clone case does not need manual adjustment of sk_buff::csum_start
> because by using skb_cow_head() the head does not move relative to the
> payload. Should the head need expansion then pskb_expand_head() will
> move it and update sk_buff::csum_start accordingly. The clone also
> preserves metadata (if available) so skb_postpush_data_move() is used
> instead of memmove() to move both. Finally skb_reset_mac_len() is added
> to set the new length of the header after expansion.
> 
> This is a preparation for PTP handling where timestamps are requested.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
