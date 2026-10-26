Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001167;
	b=mVWMQMDx6aONrgi64fSDodo0y4xv3kJUVIuHSb75Pi1r+ik3Aeuktr2SSzZNfdAZpMa5
	 Y1NF7Cmx5rDccpTwfjS4t40kpMQ586mjx5IzMkpECPSvM7sltWBCSbUHxCdJrPBtDfpma
	 qZClXzbV/W8oSYwkUAXDIaHYZLfN/KPceyLVIwuDbJGouEd2oUDOq8bDrhgCgBZOX4zHa
	 ysEaoVURTw3FRNE0DMXaGfbLUwUCZR0m4NJV77C+nzwNady6NYrx1AaZ1Na9VGvFM/1cJ
	 Y6kOXoYSXWd2AogINtmKIi2F0n/k0inoaUsQNVvzAsgZq/AsWWF9Ag/al73Q/YsMr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001167;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=s0QRDdFGDzqFxdBABylDhdk+Z7DyRm6s7wUfoRTHgN4=;
	b=Ji7Dt6H0mlp/X2Al/mPrYQ0Dau9/RyAec8dyzUeL2Jjd99WKsLLgG33AlMog1l3ts6zW
	 juO/pvNqjdIL2+bOgpSThqUNem4HCUCqRAsiBhgS0CrpKjQYA8jE1djjI2ILw8zKC6I4s
	 TpWXJTQGFUCE5D6G+sWcG+0/PThqnsZEhvcowjad/NkEgg+M/LrFX+lfUZ0k6Lx6lzDXX
	 z/kC+B6jasdabbe2t93a3MEhff+hNevltAomAALcuflT9MM+XtBXbKehsXWWBuU1K3Qex
	 5Re9PbIvcbyO9Isfe1Q+mPjNooeh8dU2L8toRVr1sJklAbqKwdCVUo4ezADpIAMyzdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=OyLQ2ojW;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD59606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=OyLQ2ojW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793001167; x=1824537167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bos/FCnLvTmkciVvGpuIL4YaK5ohIiWow4ZfEhP1WNA=;
  b=OyLQ2ojW0ERiZqHV7fLy7NX/1J+FygH8K09/z8yoSjVy97I6jWPFWuQ/
   VTcgWELCbWXfpbuSl013lmE0usnkmyH+fxaK3Nkm8I2/PQtQDZlNy1R9g
   vM3ClADUcplHyVFwRGmf9HBDVuMiRiX2aH+WzZpILdYgAyrUvRfYPsGXD
   KymnOoDLH3n5k3Y0lTivxzqtTK3IkgI5V+homVw8JInFb56DInh+jmhQK
   lgSLyivy45e3ZUj1UX+09tj/acbupne0x8TxGiByr8rPo63rRW97cHBtP
   NFtt6TbJl+zOMqwNicrQWRgoZ9ERib9lALFT4oLVjyzCYfbd5wGJLjv2J
   Q==;
X-CSE-ConnectionGUID: 1cZN3j7NR9CteirTnb9Fdw==
X-CSE-MsgGUID: EGygBPv7TF+/cwiw3lyhsQ==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="232625091"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 00:52:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 26 Oct 2026 00:52:46 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 26 Oct 2026 00:52:45 -0700
Date: Mon, 26 Oct 2026 08:52:44 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Dudu Lu <phx0fer@gmail.com>
CC: <jhs@mojatatu.com>, <jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net/sched: gred: keep the qdisc lock while updating
 the table
Message-ID: <20261026075244.txwwhh2vrolt7va4@DEN-DL-M70577>
References: <20261021155434.66572-1-phx0fer@gmail.com>
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
In-Reply-To: <20261021155434.66572-1-phx0fer@gmail.com>

> gred_change_table_def() publishes table->DPs/def/red_flags under
> sch_tree_lock(), drops the lock, and then keeps writing state the
> datapath reads without it:
> 
>   - gred_enable_rio_mode()/gred_disable_rio_mode()/gred_disable_wred_mode()
>     set/clear table->flags;
>   - the red_flags_changed loop writes table->tab[i]->red_flags;
>   - the shadowed-VQ loop frees table->tab[i] and clears the slot.
> 
> gred_enqueue() and gred_dequeue() read those same fields (test_bit on
> table->flags, q->red_flags, t->tab[]/t->DPs) under the same root lock on
> another CPU, so the post-unlock writes race with the enqueue path:
> 
>   BUG: KCSAN: data-race in gred_change_table_def [sch_gred] / gred_enqueue [sch_gred]
>   read (marked) to 0xffff000007ad3b00 of 8 bytes by task 110 on cpu 0:
>    gred_enqueue+0x88/0xc60 [sch_gred]
>    dev_qdisc_enqueue+0x4c/0x19c
>    __dev_queue_xmit+0x10a4/0x1ea4
> 
> The comment justifying the early unlock only covers the DP-vs-DPs check,
> which the shadowed-VQ free loop relies on; it does not cover the scalar
> mode bits and per-VQ red_flags written afterwards.  Move the unlock below
> those updates so everything the datapath reads is published under the
> lock that protects it.
> 
> Fixes: 6639607ed9de ("[PKT_SCHED]: GRED: Use a central table definition change procedure")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

