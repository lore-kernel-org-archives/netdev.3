Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562540;
	b=SwkgV7XY4VWZSY+cuaA90y5ceJGDbQj3NDnZt6eB0ElkviNUjuvGxQ9nFvgxNddAniLY
	 i/U5bZwLPzEdBJN0BMUVqzshsn8mEZfPzIPCdzscrRqoP+oluQHIseMYVwiNhrYi6sLGU
	 +AgKI58+saiMkV45Z48GTVN6xfa+9Yn0c1ZVfjBPcZ8ZBeEFZo0zeDsU3z6EdLae8wQJs
	 H8ORhpXKoUwzYPb4f8z5g/2/RhTePnZuhljcEtpC7zmmx3/6pyRet7CweemEFuD0L/Er7
	 JFk3GTO9HE3CRuTijn6kRERYETNy1fIeYnbhZYyEyJBIhT9bkgr/ZkiG6WsVkFyXAOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=EvWVYCmSrC08VmYMuwyjP4TbqhqKKrVCh8mKPIgk3uU=;
	b=pmNuG/cCk3to820MS7dJeQJJ1Gs5BrCpaEJ4/hM+6PoiqcbS4hLHraJpmvP/vJs8mzMW
	 YYS7Z05mYG6lc2lLS0uPySYd1pU+9z1H8ZGGHcnbSg3tDaWPvLDbxqujc/bOIuW2bKD8N
	 jQsKBPF3ChGXc4O31wN+ZnOyb2uHzr6klWBppKFNp2ZIXU8lrrS6T9os9wRjNlIV8TdKF
	 eNMFME9DwFWzEQm7sRfjC8UgZBOOTPvc18HR/DjD25hO1IDLRZ1vacuhORCsqZZcXwQpt
	 ytxa0sGf5SoyOZhENFY7iueV0S29qMBk5HIrbAO/c6m5jxmzhoaiQnAOdMfhI6JtUMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifBkNW17;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF1606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCF1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifBkNW17
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso302388a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562539; x=1795167339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EvWVYCmSrC08VmYMuwyjP4TbqhqKKrVCh8mKPIgk3uU=;
        b=ifBkNW17ag3PsQDR2M2f2Vr/CK5hdnTZJwwq6uGUXVXwey8VPDG1/WSbFKF9BD0fTQ
         4IN6KhNAUi26mPv5XZqZNO1js6sntMtGTkz+Q2yrIc1Eqjitf2CyVd3jYD8BWhgVWdZp
         Yrg8/PNRE1wQcVpzRwiO4yV8/7Y5FL79aG/DG3YdjybS8RVO0Tcw6HmR7DU4A8crs3d5
         KSWCKoOAh0n1hnXIN9cvmjw3ppH4tDfkv2w2+6bbJYiDCrK808lgpG09HDGdlpALzv5P
         P4KcAutF1x+i89igrxSHOHqg4Ja5mnAT5Qyj1YXiiLp8iF+5bB4ivBkelRRrIzRU10JK
         YpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562539; x=1795167339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EvWVYCmSrC08VmYMuwyjP4TbqhqKKrVCh8mKPIgk3uU=;
        b=Uh3ArFtNvD6QulzX39eVvipeKaEW1Un3M/WU2iMxPVNTJKR0Gl7LaMQLg5+RKw9Oss
         xhCSAAobEGP/xze7mByli/HiXhmVK6nTHc442BXEiHGcwAies8u+ELb9hiHzrWoZWO92
         C+xTKXioW0ZDXLRADmcgDYOgjOBnYDr/PHHi8WQWnYmgIMVWn7snykS83AraOAAHsvsS
         5iVAbakrdFiu2NoVzRqi0MlI+bGaHXylzGRhcl/bjO1RtD1DA2XJ5MzSxKIPk7gOXR/W
         wTSBDoH4gWp1FRfKkBNDI0fKgZrKx1QFpPdhdNYgQRVn3rzco7xDjLwZL+cx5ecR+iiE
         cAwA==
X-Forwarded-Encrypted: i=1; AL+hErEIO8W22RFpk7w467rbC7y1n1XfeGwp2eV2MXNWx9MOQXNROWdOVvX7cY002pGyG4/7ETbaYL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wc1cMqohQ6x8qDAqk/YutDYENvJxjSQFn157uI3v7SkEatUrh
	JMMLBr2eMMZcek6WreqnNLke+stgsjUt13KETCDmhWO/mLfvqaF1T1oc
X-Gm-Gg: AYBFou3P7RPv8HPdp027xm4HQcCRzZz5JkVyNjmmhu04FGQJXdt/4i0C2jjsXHfVzlT
	NAkc8v1BCCIw6Qz5Q8LnYYABpr/A0CQm2MJbVAeZNu6l/T45SpGRRbZ5R8/OqekRIQpCmzo6rln
	CmHrbU/cbL147zttUcJR29x10JQ5F6jV5AIzcEI8kprWqkhouS/IwFymGWGyEs1ch4w4sxwjCSa
	2phF0GG0MkERKrEfIsNNr9qFs+7YJhbrvym3BlZFyR7lrP/Ojelbxco7Bc+PWZmhXGcPL6qYsv0
	CZ24Iyr4QT0rGLw2rlLfAuVhUvhtfZwZASba8clLtCOcLtQv+BuGpVjl/HObGzeLLSsbEmU3s/m
	4f66cu+baQvL2mko3qPnVsqS4x7D1/HICycvlN7v3Z4PHtwdqsq79oS54/l5VRNlEMkXCWtMn6a
	E/J0gMU/OjbhQ8yED4LBzHw81CSQeMGckbZpiWF0gBsPTIm0gzEnbHDOXF2lN/vbd2zJ4siTgJN
	4SLW8TVi5dxRZxwRctCNSXb9etau10YJIHRZ/asbdxWy8ANQUZDpaM2edqzhyKjxIxf2JKrhut6
	8+Z1G3HpWnRNe9zbbnxcbPVHtOtNSg/Sj9FxHqAfNhmjXEK4j5Hj5PnmMPYVcAJsMH9WgU8=
X-Received: by 2002:a17:90b:3146:b0:3a4:b0a1:c7ed with SMTP id 98e67ed59e1d1-3b1b09fa56bmr1796891a91.13.1794562539479;
        Fri, 13 Nov 2026 01:35:39 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c847asm928446a12.28.2026.11.13.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:35:38 -0800 (PST)
Date: Fri, 13 Nov 2026 18:35:35 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2] tcp: fix NULL pointer dereference when restarting
 a Fast Open listener
Message-ID: <avbZ541P9VdrpfUz@v4bel>
References: <avMkfJrXhCFXn8M_@v4bel>
 <179450310167.2199510.18107423940014989443@kernel.org>
 <CAL4WiioP-25nYs19MiNAjnzbvi-H870uem1W+jY5jTJb=DKn+g@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiioP-25nYs19MiNAjnzbvi-H870uem1W+jY5jTJb=DKn+g@mail.gmail.com>

On Fri, Nov 13, 2026 at 09:59:54AM +0100, Eric Dumazet wrote:
> Le jeu. 12 nov. 2026 à 18:05, <netdev-bot+sashiko@kernel.org> a écrit :
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 1 · Medium: 0 · Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [High] The patch is meant to stop request_socks from being stranded in
> >   rskq_rst_head while they hold a listener reference, but another path…
> >
> > --
> >
> > tcp: fix NULL pointer dereference when restarting a Fast Open listener
> >
> > This patch makes inet_csk_listen_stop() always take fastopenq.lock and
> > detach rskq_rst_head while holding it. That serializes the drain against
> > reqsk_fastopen_remove() adding entries to the RST list. The goal is to
> > stop request_socks from being stranded on rskq_rst_head while holding a
> > listener reference, and to avoid the NULL rskq_rst_tail dereference seen
> > when listen() is called again.
> >
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > > index 37cc8606d6835..9ca59dca5d184 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -1533,17 +1533,15 @@ void inet_csk_listen_stop(struct sock *sk)
> >
> > [ ... ]
> >
> > > +     /* Free all the reqs queued in rskq_rst_head. */
> > > +     spin_lock_bh(&queue->fastopenq.lock);
> > > +     req = queue->fastopenq.rskq_rst_head;
> > > +     queue->fastopenq.rskq_rst_head = NULL;
> > > +     spin_unlock_bh(&queue->fastopenq.lock);
> > > +     while (req != NULL) {
> > > +             next = req->dl_next;
> > > +             reqsk_put(req);
> > > +             req = next;
> > >       }
> > >       WARN_ON_ONCE(sk->sk_ack_backlog);
> > >  }
> >
> > [Severity: High]
> > Is this fix complete? The commit message says:
> >
> >     With this synchronization, reqsk_fastopen_remove() either inserts the
> >     request_sock before inet_csk_listen_stop() acquires the lock, in which
> >     case inet_csk_listen_stop() reclaims it, or sees that the listener is
> >     not in TCP_LISTEN and does not insert anything.
> >
> > That argument only holds if every exit from TCP_LISTEN goes through
> > inet_csk_listen_stop(). The failure path in inet_csk_listen_start()
> > does not:
> >
> > net/ipv4/inet_connection_sock.c:inet_csk_listen_start() {
> >     ...
> >         reqsk_queue_alloc(&icsk->icsk_accept_queue);
> >     ...
> >         inet_sk_state_store(sk, TCP_LISTEN);
> >         err = sk->sk_prot->get_port(sk, inet->inet_num);
> >         if (!err) {
> >                 ...
> >                 err = sk->sk_prot->hash(sk);
> >
> >                 if (likely(!err))
> >                         return 0;
> >         }
> >
> >         inet_sk_set_state(sk, TCP_CLOSE);
> >         return err;
> > }
> >
> > Take a listener that went through shutdown(SHUT_RD) or connect(AF_UNSPEC)
> > while an accepted Fast Open child was still in SYN_RECV. Then listen() is
> > called on it again. If an RST for that child arrives after TCP_LISTEN is
> > stored, reqsk_fastopen_remove() passes this check under fastopenq->lock:
> >
> >         if (!reset || lsk->sk_state != TCP_LISTEN) {
> >
> > It then links req onto rskq_rst_head/rskq_rst_tail without calling
> > reqsk_put().
> >
> > Now suppose get_port() fails afterwards, for example with EADDRINUSE
> > because another SO_REUSEADDR socket started listening on the port, or
> > hash() fails. The socket goes back to TCP_CLOSE and rskq_rst_head is never
> > drained.
> >
> > A later close() will not reclaim the list, because __tcp_close() only
> > calls inet_csk_listen_stop() when sk_state == TCP_LISTEN. A later
> > successful listen() just overwrites the list in reqsk_queue_alloc():
> >
> >         queue->fastopenq.rskq_rst_head = NULL;
> >         queue->fastopenq.rskq_rst_tail = NULL;
> >
> > Does this leak the request_sock? If so, it also leaks the listener
> > reference taken in reqsk_alloc_noprof(), which only
> > sock_put(req->rsk_listener) in __reqsk_free() drops. That would pin the
> > listener sock and its netns reference too.
> >
> > This looks like the same leak the commit message describes, reached
> > through a different TCP_LISTEN -> TCP_CLOSE transition.
> >
> > Should the inet_csk_listen_start() error path also drain fastopenq under
> > fastopenq.lock? Alternatively, could the drain move to a place that covers
> > both paths?
> >
> > --
> > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/avMkfJrXhCFXn8M_%40v4bel
> 
> This looks legitimate, but it is a separate and pre-existing issue,
> not something added or made worse by this patch.
> 
> inet_csk_listen_start() sets TCP_LISTEN before get_port()/hash() and
> goes back to TCP_CLOSE on failure without purging rskq_rst_head, so an
> RST for a Fast Open child accepted in a previous life of the listener
> can queue a request there during that window. Nothing reclaims it
> afterwards.
> 
> It needs listen() to fail (e.g. -EADDRINUSE because another
> SO_REUSEADDR socket started listening on the port) with the RST
> landing while get_port() runs, so the window is quite small.
> 
> Hyunwoo, no need to respin, your v2 is fine as is for the
> inet_csk_listen_stop() side.
> 
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks for the review.

> 
> I will send a follow-up on top of it, moving the purge to a helper
> that is also called from the inet_csk_listen_start() error path.

I'll review the follow-up patch once it's posted.


Best regards,
Hyunwoo Kim
