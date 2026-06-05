Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A037C929;
	Fri,  5 Jun 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663164; cv=none; b=sxQxKl3ctdK7OpXCiI1DZ61Id4j+tBHpltpIzFoF8dx1y5PKrJkLI+ymjyIX2PKqw6q2MbV4jvz2hBrPUDu83s+jqMcew4fVb4qmGBCOqYp8T/f25yyIau/xT+004NHn/MIPw5EB9LMvBXHmIm6zEbf80K1HNq6FzK3PZ+TvrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663164; c=relaxed/simple;
	bh=QIMNFbEm/rP4zbE+xDzKi2taqU1fMYTL4I98EQ/0Qyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAb0cwtnVujiTXTqMyYH2qt/He6U9bYlZz7zFoGRl01DK/LuKNpjKLW6GH/hminQKT1fFQYxOBj1av+cH7N4dgeAy3wENKI4vPMXbiBAHRMu20fe6PMYjnl2Yilb/v8pslTeft/3n7IVjAWa4oLSmKMVvYUKXS1dEpTJBTdDYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=hPA2nkfe; arc=none smtp.client-ip=195.10.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="hPA2nkfe"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gX16Y2KfBzDqrT;
	Fri,  5 Jun 2026 14:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1780662757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfS5G0ratEXTvMqPCAG03cuUQYUs07Avv4AgTCxcQhM=;
	b=hPA2nkfeuV5omkBVz/yzZscp+saKuYMdc3NEyFni+afEsKrzche14R07HzBEuwOcrq0v7m
	xsuRAvfwuE83CCakmQbxrsXPvX8ekUIJed9NQdArAy80fgU7g6RblC9+LQCCfAkW/L3CPs
	1O/a7pwQxDe161+cnBjjtFyDMGTr2tTZoK6WAQJqz8b/7IJuEwhAfLmS5wYXIGUetxkMNQ
	ySBGi3lht9hCzPTqQPvMsAMW5Jps71odyn/zVv7GbdwrC8CzrgoFBqEGAlQ/WUsIOdKC4h
	57AFdP1pUKDGqpc+uA7JCRM2bLGsywnYKcwDu2V6pp6F7j2vbuVXGeDhFS2DZg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch core
Date: Fri,  5 Jun 2026 14:32:18 +0200
Message-ID: <20260605123220.414113-1-ralf@mandelbit.com>
In-Reply-To: <87a4tab1vs.fsf@toke.dk>
References: <87a4tab1vs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4gX16Y2KfBzDqrT

Hi Toke,

On Thu, 04 Jun 2026 20:23:51 +0200, Toke Høiland-Jørgensen <toke@kernel.org> wrote:
> Ralf Lici <ralf@mandelbit.com> writes:
>
> > This commit introduces the core start_xmit processing flow: validate,
> > select action, translate, and forward. It centralizes action resolution
> > in the dispatch layer and keeps per-direction translation logic separate
> > from device glue. The result is a single data-path entry point with
> > explicit control over drop/forward/emit behavior.
> >
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
>
> This is very cool! Going quickly through the series, this seems like
> thorough work that will be cool to have available in the kernel, so
> thanks for doing this! I'll be quite happy to retire my barebones
> BPF-based implementation once this lands :)
>

Thanks, glad to hear this looks useful. I have not had much time to work
on ipxlat lately, but I hope to respin the RFC soon.

> One comment on the device model below (which is also why I chose this
> patch to reply to):
>
> > +static void ipxlat_forward_pkt(struct ipxlat_priv *ipxlat, struct sk_buff *skb)
> > +{
> > +	const unsigned int len = skb->len;
> > +	int err;
> > +
> > +	/* reinject as a fresh packet with scrubbed metadata */
> > +	skb_set_queue_mapping(skb, 0);
> > +	skb_scrub_packet(skb, false);
> > +
> > +	err = gro_cells_receive(&ipxlat->gro_cells, skb);
>
> So given that you're not resetting skb->dev here, IIUC, this means that
> the translated packet will magically re-appear as if it arrived on the
> interface it first came in on, right?
>
> That seems... a bit too magical? Sending a packet to one device making
> it suddenly reappear on a different, unrelated, device seems like it
> will just create confusion. It's like the ipxlat device can't really
> device if it's a device or a tunnel? :)
>

That's not quite what happens in the routed xmit path. There the stack
sets skb->dev to the selected output device before handing the skb to
the device. For IPv4 and IPv6 this happens in ip_output/ip6_output,
where the output device is taken from the skb dst. So when the route
selects the ipxlat device, the skb reaches ndo_start_xmit with skb->dev
already pointing at the ipxlat device, not at the original ingress
device.

The internal 4-to-6 pre-fragmentation path should preserve the same
property as well: ip_do_fragment copies the skb metadata to the
generated fragments, including skb->dev, and the temporary dst used for
that path also points at the ipxlat device. The fragment callback then
feeds those fragments back into the same ipxlat processing path.

That said, I agree that relying on this implicitly is not great.
gro_cells_receive uses skb->dev directly, and the intended receive-side
re-injection model should be obvious at the call site. I will set
skb->dev = ipxlat->dev explicitly before gro_cells_receive in the next
version.

> I think a better model is to treat the device as basically a loopback
> device that translates packets before looping them back (so when they
> come back they appear to be coming from that device).
>
> Any reason why that wouldn't work?
>

That's indeed the intended model for the ipxlat netdevice: route packets
to it, translate them, then loop them back into the stack as packets
received from that same device. That seemed like the simplest model and
the one that exposes the translation point most clearly.

Thanks for your feedback!

-- 
Ralf Lici
Mandelbit Srl
