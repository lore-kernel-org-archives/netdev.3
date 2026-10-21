Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581631;
	b=aKaM5uBv4nO+XRQb/WgMC07r588eSLmdVv8Jb2jdLkhTZ8QsRxxnXLGK/FIej3HlPXpo
	 pD6dyDlJ5nQOCNAe+mXwhQoIIJJ6hX12+6c9bbABe+xjOc26dzPg7fHLmCgX9mmB9YXKr
	 UGJsdWMNA+a2DRbns881RO3hLcbw1oUHkf+yx2OJa9h4mBC0ocDCKg8KVrNKB67mUDnn/
	 LiAk/l0RGt5zxYdgq58kAAJu92w4xa59bcT0T+MJodiBlCH4z/KI4N9kTBiYVS3iJDPFW
	 qQCXP56Z6xqp/2m4zsIu+n5drRFD/lP7xo8F77T521Fwbn5pKvqx5lZ/QdMH8OA+g/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581631;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=d2cc9KiUyx9GC+3ji9GNJpWFlCn58nYagXjcpo0HDLA=;
	b=ZiyBZzyBPZ5y+YzEZPyXFJAY9A4FqOUJGoZtnAlpHQSmkrQ88gBTA0ekIHVUeGIJykPV
	 +yiyubNBxHm3BoXCUCOo2I4+ZPCw4g2kbYZddN/vmFChuS8II5shS9HuMBuK8DcXtJ8/n
	 qPlBqh33tRPzjUWKWUy65rsSc72Z/DuvqQxAY0qVpbUOaSQGqZVeG3h0hnFT7SEwb5JXv
	 plz7th3rHl6EaexZBwmpz+XPkENg7UMiyvEt8JIDOFZffNWSXcHSG+/XSNjfQ+ugtbpKo
	 piEiedS/7RyZbarNbSDoZx8W9ODfCeP5oKNlMcvqKxKp+WI6gxAZkJavByUdiu95JWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GMWeTqc4;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97125606A31D;
	Wed, 21 Oct 2026 11:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97125606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GMWeTqc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792581637; x=1824117637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fxyvfq7G7wK3zgtXtaLM2M/67lLiOjmYEHf/dJdUy5I=;
  b=GMWeTqc4PrqdKFdTXvE+QKLNYQHegaBG+6P8WA/6Z0X0CxSrg2hHa5EV
   CDy4tnssxtXsz1R4R7ZhfkshT3p3HBb4Kh/rOYxzfaSg3I/XVkz6E0H4M
   feg63sQEAPdnhR8Z6kpfm3rWw9HCkEkAME3U3vJNlTkFer4Pe/PvR1lB8
   NUDFHzo+Ggx21zIT0GRuzY9Q1qHop7UIDy1Q5OevQqtq0iQ7SAzQRtSUU
   +QP6aAjU19Z51UvQbYJ9OIhz/5BS04Eefu1RcgEyTayTvTBJO3pRCQRmy
   wYo0B4jzr5yDjEsabZDv4dLMF8RPfV7hSieAAAyUVRm5Gvhfql0tYRS5c
   A==;
X-CSE-ConnectionGUID: iGSs+gUcQAO0mntE7JBVHw==
X-CSE-MsgGUID: zIJmC+WlTvC7Bkp4sT2dRQ==
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="64407280"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:20:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 21 Oct 2026 04:20:23 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 21 Oct 2026 04:20:21 -0700
Date: Wed, 21 Oct 2026 13:20:20 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<horatiu.vultur@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: don't reuse the last DCB in fdma xmit
Message-ID: <20261021112020.q5zk2xs6bvstqcue@DEN-DL-M70577.microsemi.net>
References: <20261020-sparx5-fdma-last-dcb-v1-1-fb9a956196dd@microchip.com>
 <179257635682.3135.3561272765367316822@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179257635682.3135.3561272765367316822@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] net: sparx5: unguarded fdma_dcb_advance() in sparx5_fdma_xmit()
>   breaks tx ring
> 
> Pre-existing issues:
> - [Critical] This problem wasn't introduced by this patch, but the patch
>   adds a new way to reach it.
> 
> --
> 
> net: sparx5: don't reuse the last DCB in fdma xmit
> 
> This patch adds a check to sparx5_fdma_xmit() so it rejects the next tx
> DCB when that DCB is fdma->last_dcb. This uses the same !fdma_is_last()
> guard as lan966x and lan969x, so the tail of the chain is never re-added
> and the frame is not lost.
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > index dbe86f937b21..221b2f1932f6 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > @@ -218,7 +218,8 @@ int sparx5_fdma_xmit(struct sparx5 *sparx5, u32 *ifh, struct sk_buff *skb,
> >       void *virt_addr;
> >
> >       fdma_dcb_advance(fdma);
> > -     if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)))
> > +     if (!fdma_db_is_done(fdma_db_get(fdma, fdma->dcb_index, 0)) ||
> > +         fdma_is_last(fdma, fdma_dcb_next_get(fdma)))
> >               return -EINVAL;
> 
> [Severity: High]
> Does this fully fix the drift described in the commit message? The
> underlying problem looks like it is still there: fdma_dcb_advance() runs
> before the done check, and fdma->dcb_index is not restored when
> sparx5_fdma_xmit() returns -EINVAL. The new fdma_is_last() test only
> covers the moment dcb_index lands exactly on last_dcb.
> 
> When the ring is full, a failed xmit leaves dcb_index on the oldest
> in-flight DCB. The next call advances again before checking anything,
> so if the FDMA has completed that DCB in the meantime it is skipped and
> we test a newer DCB that is still in flight. Each failure moves
> dcb_index one step further, so a burst can keep dropping frames while
> completed DCBs sit unused behind dcb_index.
> 
> If dcb_index ends up just behind last_dcb and the FDMA then drains the
> chain, every DCB is done and the ring is idle. The next xmit advances
> onto last_dcb, hits the new fdma_is_last() check and returns -EINVAL,
> which sparx5_port_xmit_impl() treats as a drop:
> 
>         if (ret == -EBUSY)
>                 goto busy;
>         if (ret < 0)
>                 goto drop;
> 
> The lost frame becomes a counted drop, but it is still a drop on an
> empty ring. lan966x_fdma_get_next_dcb() and lan969x_fdma_get_next_dcb()
> don't hit this because they use !fdma_is_last() inside a loop over all
> DCBs and pick another free one, rather than failing on a single index.
> 
> The previous tail is also still unsafe. Say the FDMA has halted on
> last_dcb at index L and dcb_index is at L - 2. The first frame advances
> to L - 1, which is done and not last, so it is linked from
> dcbs[L].nextptr and becomes the new last_dcb. __fdma_dcb_add() does not
> clear the done bit on dcbs[L], so if a second frame comes in before the
> FDMA has fetched dcbs[L].nextptr after the reload, it advances onto L,
> which is still done and no longer last. Re-adding it rewrites
> dcbs[L].nextptr to FDMA_DCB_INVALID_DATA, so dcbs[L - 1] is cut out of
> the chain. Its frame is lost, and since the FDMA never visits it again
> its done bit stays clear, so later xmits that land on it fail too.
> 
> The drift itself dates back to f4aa7e361ae2, but since this patch is
> meant to fix it, would it be cleaner to fix it at the source, by only
> committing the dcb_index advance once the DCB has been accepted (or
> rolling it back on failure)? Then dcb_index always follows last_dcb,
> the next DCB is always the oldest one, and the fdma_is_last() check
> should not be needed. Alternatively, sparx5 could search the ring the
> way lan969x_fdma_get_next_dcb() does.
>

The drift is pre-existing and not what I intended to fix. That said, I think I
can fix both with a simple change where the ring index is computed from the last
index instead.

pw-bot: cr

