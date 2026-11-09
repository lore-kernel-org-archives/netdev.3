Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231462;
	b=laLKVVnL+QC0d4MNhoqIH4jXxEvLnamZazp73LMH1/edPDq12ifT7ga0M6fTAaE+O3L+
	 ApaYrx0OEAOUdfb9BAE0jFSC1oV7LMGS4o4Izq1waMQe2avBo/eoV/VVSJgsuTgou8jcK
	 N1xGHoBzTU2p4yVQ4rjZBmtYW6RzyW0DwCsyTB8xdjCvwTy1aScr2iD6knrf/Aobk0jGW
	 bZ9xRFDZ2LCDqGUNFra+VbCpMbkVLuDaKHV+BfxpLqJ87Hw1KFxhpu39qf9BhVs8cGrea
	 zpi3zZnsBvYoMdQoaazyC6fDo0q0mKRJJMgFifZyiu8B/XkMtZmz421GQZyMrd1WEqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231462;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qTo0Pq7+6TX71rE+/bZ1iamBkpCECZBGOsRsjXhsNHk=;
	b=hy8hMtrscf1mmvmQ9NuVUMiAPfvBy210HePLO0covsmMBN7ydtXET5Mb0zSpmZvQqAtX
	 Q/po/MrlFoDt6Xmu8cGe22aKNfg7ccXUgBv/eNPPvAbqAFolWFjnPWw+H/TPcX5acdKLa
	 UKjgK9WHVF3Raqq2v9sUEo52Wq5EMb+RGu6X9LA+re4Qm/u5A5/huCPjfA0eOPVEIn1zB
	 BOWW4/BIoccR/3l4oiayznBwtZJTUSSp1OzM0J5rxT6HDQNlol5MPO8LzhaGujAtBWCtf
	 hOQr66EV9FXRPCygQNreZutn2l7tT2BLW02hg9y6/gooDaMKKDzrsRHSPhqWpBR7CgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Uvg2c4ye;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C15606A33D
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C15606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Uvg2c4ye
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794231469; x=1825767469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zjr8kPeClPE+6nkxv35AYAmu2x+IiO6+z8m2SKqncqQ=;
  b=Uvg2c4yeWZ0Wp7je7915IdUtJqThXogD7PwbxWODqNPK+DzSd+GlPsEP
   mvwheJ8ejssTegqR4wpDom//r6fM7fxBxM2GIGbxFx7sWRcgbNZ/IHE62
   iHb3hVqYgkmsdgOI8qi0WIXyrOuebe1Wu5BDTez2KgPzkx63jjn8K+zWe
   MaQmD3b0H/hli5ZOq4rc/ORMPT5GCginQdJF/2WOpLOgVMxx9n7hHv96D
   FVvhRUkRa86Hsk3zZU5TAX+ugYOe5E1NloAzE6+ieW65EwcpK3mSIog95
   rLtGTcDY10IDpCqIpdKe+CeokYbdveGZ8yyvr0I3tFGkjq70dnyy0lLnp
   A==;
X-CSE-ConnectionGUID: FB+rwnh4THqCwaC+eWa63Q==
X-CSE-MsgGUID: XYni4QjlTMyDqSqnzT95pQ==
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="297652133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:37:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 9 Nov 2026 06:37:34 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 9 Nov 2026 06:37:33 -0700
Date: Mon, 9 Nov 2026 14:37:32 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <memoriaru@foxmail.com>
CC: <netdev@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 0/2] net: sparx5/lan969x: fix RX ring stall on
 frames from inactive ports
Message-ID: <20261109133732.4tfynt5ccdbqzzds@DEN-DL-M70577.microsemi.net>
References: <tencent_E018A629F0808AA68194ECD60FB6B096BD09@qq.com>
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
In-Reply-To: <tencent_E018A629F0808AA68194ECD60FB6B096BD09@qq.com>

> From: Zhang Hewei <memoriaru@foxmail.com>
> 
> The FDMA RX path on both sparx5 and its lan969x sibling stalls the RX
> ring forever when the hardware delivers a frame whose source port does
> not map to an active netdev: the inactive-port error branch in both
> drivers leaves the FDMA software cursor untouched, while the DCB keeps
> its hardware DONE bit - so every following NAPI poll picks the same
> DCB again and RX traffic stalls on all ports until the module is
> reloaded. sparx5_xtr_flush() only drains the QS_XTR hardware FIFO and
> does not clear the stall.
> 
> Patch 1 treats a bogus frame on sparx5 as consumed (free the skb, clear
> the array slot, return true). Patch 2 splits the two NULL meanings on
> lan969x (allocation failure keeps its retry-later break; a bogus frame
> returns ERR_PTR(-EINVAL)) and advances past it in the poll loop.
> 
> v2: hand-assembled v1 mails were mangled (duplicated newlines, missing
> diff headers, broken threading) and used a non-answerable From/SoB
> address - apologies. Regenerated with git format-patch; same two fixes,
> no functional change. v1 lore link:
> https://lore.kernel.org/netdev/20261108184541.74618-1-memoriaru@foxmail.com/
> 
> Found by code inspection; the stall needs the hardware to emit a frame
> with an invalid source port, which cannot be triggered without hardware.
> Review from someone with access to sparx5/lan969x systems would be
> appreciated.

I tested the changes. They are legit and fixes the issues described. However,
the implemented solutions need more work.

pw-bot: cr

