Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BD2857F0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371455; cv=none; b=RopxBQQ4fk/xRCTuFzn7d2Ef5GTlE0iJX7BEaCvaJ9kyZ9IquBKrVfQzGfQrkUpMPz2UpHY7EyfSxPFnG10EZJ5BTRTmyjzaDdCHEym2xLRuVeSkZjqxCijrxQKBq9uHwhc59w+XVxsK/ygYD2be9FkRWjwzedYIW4ryG8z6i9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371455; c=relaxed/simple;
	bh=LsupKWcrL8cjUH30zrtmt6wogBV2dJQCnN+ov2g7X48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsgOYlvrnxiBkw9We4beM+PGVpRB3aO+USzfK5e8MceghfMd9GSYkCfnSCaTu7VE2D5t3uq7kLOdFX8pQoBYzFyrNGtwbmX5qb/XXgGQlietbVQUaT1CZGtdoG2OtKoE5BpcvetqOcRDvMGfFHO0/xiAerTZeRtwbBAhnO2XQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRgIXk7J; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRgIXk7J"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cdae130cso9755765e9.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 10:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781371452; x=1781976252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BLDhJq26g9BPnksNwZrotmX9SVeSU3d8Z2v75G7jIu8=;
        b=eRgIXk7JmlIoQWtTUsmW8yOgFGjonT08P47B5S4LetEBoLow2QDzjFZa3S+1dv3S04
         lOy36Swto3FSuMBS3eCswmKPB8Dxo9N3RBu6Ou4LaQ15XVeLjlm7cPmFmVWmsMUIQS5m
         DrLD49AWmAZlSKPnZ6ZbR9tsiSpFKH20ZSuK6f43quG3fW4iHGHDUgyzHWRjrBRJ/EjL
         9cuZ8Y54UnxYGxuWh7aQM3ObqT3qjPaMG+Azhh1aNk+wj0x7tTSaqB+BEVrORhRz7SJz
         TA7wgu4aZfS0la/KzPOfQsgQ1sRgruzwij+rObBeuPmSQtt0jA9+tREeI7/W15hwCa1L
         IdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781371452; x=1781976252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLDhJq26g9BPnksNwZrotmX9SVeSU3d8Z2v75G7jIu8=;
        b=jJ6387U6iHElusqaV4GAVDHOQTiwKRAv09wm76ozG7Bjl13lgV/3kO015yKs05H+kt
         +2jzCLvKu3igfKoA8TdnDnxdrM6ySORutEKqtJBNu39WeUYCOz765ukph4tN6MpjH4rJ
         /j8ynbnf96XlsZa91LLL93/7jwj+/XWfpz4bhB+GmITYwlmep2huHSNzF2dOFAys3irY
         z761AM5IrIR+t27l9Gg3llF/vwYhyky61620eqsSt/08HZ2PW+wdmC2fNfwr7apJpXGo
         kypCi+4GZZyXidSbhaM8DVU8Uq/CkjqQlnihglqkLZbB3cicxq4KSqvuirjC4DsKG6z/
         1ERA==
X-Forwarded-Encrypted: i=1; AFNElJ97ot7ndvw+vwbJB5XTELYig3RqacZNNTfMs5/7EKyCiYIUUjv1sHJgEfUQfa1VlR7iVSJCeec=@vger.kernel.org
X-Gm-Message-State: AOJu0YylhwgLQXWYk2NBDKifX6BNH9R4jN0HEGI660LENseki+2Y6svK
	snYHK5YfuzruHdrF2xlTNIAAkmwL0fsFMe7YNNUoUTEuZy6zSUWQxlBQ
X-Gm-Gg: Acq92OE6aNaoVAVb4sjDlewb35IeJ8PhT0Su2k9xtloK862VMrtWCQ0GhKQxfMAQoW2
	hnr3Y+5ywmlMHP7Y6Wqp1UVrBApXZ8UK4DOvTc9tP3HuzM6WqSI5mNT2a4qoZCtcH+axwm/WDKV
	yguvlJeguHIj+bX6+24xfGmHC+mEmCOFy10iTZVNGhYi2ABVqYvlNwdlw51/UyPs9mkbrclkQJF
	tDDmZQrNWal/HHypdQqnYBSpf84ovagNuFZNBcWykeN+g/7hlRfOUmkalx2CHDN4nSbwyDMeEK5
	CnWSZZG2C2qvMIcXnncW2UZZeDj6nl+4qhDgT6UbACMH25vQ0FE3L0GkiqiL9WcB4NCP4DitvYQ
	WOEd27irzOTvF544jbX7+LfehzLTgpoXWIjTY4ZRvw4lk5nRp8jyLGAAM80D1vsJLNJ14Fpv401
	psuMKWWujCdPckKWv3t90gYNJtcETJvws3iJe6noiP1X470OUxOndHjUdUke4=
X-Received: by 2002:a05:600c:2157:b0:492:1e36:bb04 with SMTP id 5b1f17b1804b1-4922011e194mr34788555e9.37.1781371451614;
        Sat, 13 Jun 2026 10:24:11 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2404.dip0.t-ipconnect.de. [91.46.36.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203d05d1sm123001425e9.12.2026.06.13.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 10:24:11 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 97EC231BD311; Sat, 13 Jun 2026 19:24:10 +0200 (CEST)
Date: Sat, 13 Jun 2026 19:24:10 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
Message-ID: <ai2SOvftn0pQ4xQy@gandalf.schnuecks.de>
References: <20260608151452.706822-1-edumazet@google.com>
 <aic-SfHAIsYCswa7@gandalf.schnuecks.de>
 <CANn89iKybuU_JmTtt2U3JZJZp62oU-0ZXDdWb3vROZLhu+fzSQ@mail.gmail.com>
 <aigpnYzdgKSF8FZ4@gandalf.schnuecks.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aigpnYzdgKSF8FZ4@gandalf.schnuecks.de>

On Tue, Jun 09, 2026 at 04:56:29PM +0200, Simon Baatz wrote:
> On Mon, Jun 08, 2026 at 05:45:30PM -0700, Eric Dumazet wrote:
> > On Mon, Jun 8, 2026 at 3:12???PM Simon Baatz <gmbnomis@gmail.com> wrote:
> > >
> > > Hi Eric,
> > >
> > > On Mon, Jun 08, 2026 at 03:14:52PM +0000, Eric Dumazet wrote:
> > > > Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> > > > receiver requirements") removed the special FIN case that
> > > > was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> > > > FIN packets when RWIN is 0").
> > >
> > > Commit 0e24d17bd966 did not remove the special handling; it is still
> > > present and covered by the test "tcp_rcv_zero_wnd_fin.pkt".
> > >
> > > > If a peer sends a segment containing data and a FIN flag before
> > > > it learns about our window retraction and has a buggy TCP stack,
> > > > it might place the FIN one byte beyond what it thinks is the
> > > > right edge of the window (i.e., max_window_edge + 1).
> > >
> > > The FIN exception in tcp_data_queue() is not a generic allowance for
> > > incorrect FIN handling.  It is much more specific and only applies
> > > when:
> > >
> > > 1. the packet is in-sequence
> > > 2. RWIN == 0
> > > 3. the packet is a bare FIN
> > >
> > > > The data portion (end_seq - th->fin) will end exactly at max_window_edge.
> > > > In this case, we will drop the packet if our receive queue is not empty,
> > > > even though the data was sent within the window we previously allowed.
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > Cc: Simon Baatz <gmbnomis@gmail.com>
> > > > ---
> > > >  net/ipv4/tcp_input.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > index ab7a4e5435a8a2cbb532d42c54af76d8541c903b..8560a9c6d38207c098d673497caf2c7652c36f5c 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -4812,18 +4812,20 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
> > > >                                        const struct tcphdr *th)
> > > >  {
> > > >       const struct tcp_sock *tp = tcp_sk(sk);
> > > > +     u32 seq_limit;
> > > >
> > > >       if (before(end_seq, tp->rcv_wup))
> > > >               return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
> > > >
> > > > -     if (unlikely(after(end_seq, tp->rcv_nxt + tcp_max_receive_window(tp)))) {
> > > > +     seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
> > > > +     if (unlikely(after(end_seq, seq_limit))) {
> > > >               /* Some stacks are known to handle FIN incorrectly; allow the
> > > >                * FIN to extend beyond the window and check it in detail later.
> > > >                */
> > > > -             if (!after(end_seq - th->fin, tp->rcv_nxt + tcp_receive_window(tp)))
> > > > +             if (!after(end_seq - th->fin, seq_limit))
> > > >                       return SKB_NOT_DROPPED_YET;
> > >
> > > It is not clear which additional case this change is intended to
> > > allow.  Are you sure such a packet would not be rejected by later
> > > checks in the data path?
> > >
> > > (For the existing FIN exception, the previous condition also seems
> > > broader than necessary. Actually, it should be sufficient to use
> > > "!after(end_seq - th->fin, tp->rcv_nxt)")
> > 
> > It is possible our internal sashiko instance got this wrong.
> > 
> > <quote>
> > If tcp_max_receive_window() is greater than tcp_receive_window()
> > (i.e. the window was shrunk), and end_seq is after tcp_max_receive_window(),
> >  then end_seq - th->fin will always be after tcp_receive_window().
> > Does this mean the FIN workaround is disabled when the window has been shrunk?
> >  Should this use tcp_max_receive_window() instead?
> > </quote>
> > 
> > Can you suggest an alternative? Why using two confusing variants of
> > what should be the same stuff?
> 
> Judging from past discussions, I think you prefer us to be strict in
> tcp_sequence(), so I think we should replicate the conditions
> (in-sequence, RWIN == 0, bare FIN) for the FIN exception in
> tcp_data_queue() closely here.  I’ll send a patch that mirrors those
> conditions in tcp_sequence().

Based on the discussion on the alternative (see thread
https://lore.kernel.org/netdev/20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com/),
we want to accept the "only FIN is beyond window" case in general,
not just for the RWIN == 0 special case.

It might be worth adding a test for the new "accept data packet with
only FIN extending beyond max win" edge case; I can propose one if
helpful.

Reviewed-by: Simon Baatz <gmbnomis@gmail.com>


-- 
Simon Baatz <gmbnomis@gmail.com>
