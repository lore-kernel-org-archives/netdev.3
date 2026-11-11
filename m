Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377157;
	b=JqNmmNr/I9PoFavRzbH+7xt706bN9ti0Ip4BmI9UJlOkYCzb74vy1cIWkSWhUgl8+W3k
	 Ip4mQce7p9y2ZXGK8b4Ry9XiWNsv7AzKqa1Ajtcx2w+etZRxwlfr10R+S2cSOajqDsPvX
	 E4xaof8okolOKo8uUL+Pc6IlifaYXl4bNdddwJ8qbLx2g6Er+z3GpCIG8VLSenmgwh0Og
	 AOzMHv6iXvApXLVi/23PeKYW5UmrAAtempxxJXWo5dyz+JlHZNPMIKj03xuxruKP1hX54
	 rRTYUatCiDbXJ4FgkltN5wTUydv/YuUCQN0J3aAMSC1f8N2fP8reUkMyJREDb6ijwPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Cei+YsF51AZ83237FXaR1tP6PT4v6t3ufi1JLcCP87s=;
	b=qMimMX6Rjrbk2t+pqCucNh/WJfzAZxafxscLD6Yu0dddL8vYePRbCezbX+yBQNGRHH/g
	 cgzicg+OXcfc59OSKlReyCS3dgJGvH2b1cBtBQAxjfKzNdukx1SBOlUh0vVJ/0zNsP69S
	 vznP0dnpK+HIIfN5gbqIzSaVivSbO3NMOUkije6+DR/ay4Lx1F7G0dAas79KQ2IokRaz2
	 +zuaKR8PW5WYSwVNmBd1RZNpRIC7PtydY4UwJFv3IquBhpj+DFe8dmTJhhuEtJtrsLnJM
	 0ydCbdYPt+7QKvGTfHpDRmvlpDiEfMmsJvAV7MbwA8pmubrtljCe89rGoTdQQV/1wpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ikjssk3h;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B3606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ikjssk3h
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so1134186a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794377156; x=1794981956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cei+YsF51AZ83237FXaR1tP6PT4v6t3ufi1JLcCP87s=;
        b=Ikjssk3h+taqQc8g9oUW+Mt843FvrXo7Eaj2wQByG5rdPL6brWY5qxZ5F3B5ylqW4Q
         qS/F7RnFoPmkU5QG6RGXbRxZk3wRwZBB6fkGnBxiXaHj2OR2ydK8sHRCc27ez96hgsdq
         bXNNidZYWyIGGEPuvFvAm+RVsf08jQeKAPNnGfeKZOJ3Oh3aqlNXMq6LiQ8E9SSP523u
         Wer7+IXqfxmLjssUwMIYAmkcMgvjo3mtmE6n8wiAaPzCQbiJFyk19m0p6iiRerzDTDVU
         SBSw07l2+swtb6BZBCmDUVuyKmTyWlN8UW0i1wfrw5zCLEnw2O65EBMc0nuq35qj3mtC
         7Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377156; x=1794981956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cei+YsF51AZ83237FXaR1tP6PT4v6t3ufi1JLcCP87s=;
        b=SLEHA7cwiOQs0gWY+131T49ExgTE3uGq77kDysEDadMgKUK7TezobQakCKnFVX6l4d
         C9QFeGYunSr5gkcyoGEB+iq/WKnKKk2KkXDt80m95ng1wkLK31xIevcfclDxGHvMsLzz
         zE+2t7SqX86y81S3KnPmSDfWMCq+hv/p2muJEyQlskrPJoA4yUuJ4X3Enbvxxf60H6r/
         x8awrK+Svgyt0KPZ8hRvtKz8RNCHCGoVoW/oiZtE+TxFHOuTT1wyRxaoJN9tiA4ChHer
         apLRCdidUPBm7gdu07dzn9ryTYNA3ALvt3pkPnBEM2Aq59LRCBFMUw5E8aL3th96hcK1
         PHhg==
X-Forwarded-Encrypted: i=1; AL+hErGKn5Ysogf3eJ5k+NjmWvWZla5WUWmBRy3/89/WIlXepULvWzeGdgX7X70RzRBY3jVAC5h7gF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+R6o7VVx3/hLMxUrQrNsNJ6aK+RzytzRipmbT2CG0odKXikohK
	znBtnw9+aelquDUiy09x/PGW0pbZjBmxjtJjbf4IVp+nXOJYYg1RIoNi
X-Gm-Gg: AYBFou0N+QKQZCkKZ+QDdMIga7vOQilYUIWUQBMvZYVcl+/h+8jk/+6hsKiwgYay9r4
	kIphw8Ttkph5pFMbwwFZcpxO0kGXYD2E37ztDLZA1iFIaH7lCq/itTxmyJgFRPpc2xUPHHq6Nxs
	hBK4FGbAhoi6AKDtbrFtM42wosqfInEiOIUyHKTohHnokW9GYoDJ/RQqkqxNUXMKsQlyWFd22OK
	hhn9dH7PNjiaNcudpSVwunKOO3DgtBstEspI5l8XpzD9IZXhEf2ysKIKDq+FGsAQwgTthzYqJzA
	oiI6yPybQHLKVO6KZ0+mjQQA3USg4AkpAZUWfO3LPuVSfwu9KnGZUnmmQ4HuTEkf6J1vg662J7r
	Vq9lmcR7WpgRlV1Rqag4f3WvXJLudGBj6tAxhvbYZmXy19cW5xDTd8Lk+Ie5K+P58G+584qchlG
	ZRLd+PusWjyBkFbuLShEJhvx+9BFOEMC8wDblI/DCFS856yNGTaX93WwxJsrbCKGzRI7Zm/NekN
	53pRnCzIlhx/qxiskAMbLwFYp/tp0lPzLuJG/v83X3+3KxjQhYkD7H8EBBolq27JMJ2sNsa5hbI
	5OD+fG5SP4AoTAMWWB0DBtmvNNCWd4JLCcNbMGIf62mPxBut
X-Received: by 2002:a17:90b:4c50:b0:3ac:b44c:2d84 with SMTP id 98e67ed59e1d1-3b182ec2106mr1683656a91.13.1794377156145;
        Tue, 10 Nov 2026 22:05:56 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e1f88casm2752315a91.12.2026.11.10.22.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:05:55 -0800 (PST)
Date: Wed, 11 Nov 2026 15:05:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] tcp: fix request_sock use-after-free during Fast
 Open accept()
Message-ID: <avQFv_O4qZCTfLWx@v4bel>
References: <avFoNgJENLYu4t7X@v4bel>
 <avP5PfDz6WfnvckT@google.com>
 <avQAb-Gb7FRYNNgO@v4bel>
 <CAAVpQUDwTjXE0-Y1MOjrK2naZ3PTzqdB+sBhC3+8R+1gBPyFkQ@mail.gmail.com>
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
In-Reply-To: <CAAVpQUDwTjXE0-Y1MOjrK2naZ3PTzqdB+sBhC3+8R+1gBPyFkQ@mail.gmail.com>

On Tue, Nov 10, 2026 at 09:54:57PM -0800, Kuniyuki Iwashima wrote:
> On Tue, Nov 10, 2026 at 9:43 PM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > On Wed, Nov 11, 2026 at 05:13:15AM +0000, Kuniyuki Iwashima wrote:
> > > On Mon, 09 Nov 2026 15:29:10 +0900, Hyunwoo Kim wrote:
> > > > Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> > > > made inet_csk_accept() check tfo_listener before taking fastopenq.lock
> > > > to avoid taking the lock for connections that did not use Fast Open.
> > > >
> > > > reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.lock,
> > > > then reads req->sk. If inet_csk_accept() concurrently observes
> > > > tfo_listener after it has been cleared, it skips fastopenq.lock and
> > > > drops the last reference to the request_sock. This can free the
> > > > request_sock while reqsk_fastopen_remove() is still using it.
> > > >
> > > > If the freed memory is reused for a new request_sock with req->sk ==
> > > > NULL, the reset path in reqsk_fastopen_remove() can append the new
> > > > request_sock to the original listener's list of requests that caused an
> > > > RST. After the new request_sock is freed, the next append writes through
> > > > the stale rskq_rst_tail into freed memory.
> > > >
> > > > KASAN reported the following use-after-free when writing
> > > > fastopenq->rskq_rst_tail->dl_next = req:
> > > >
> > > >   BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x210
> > > >   Write of size 8 at addr ffff888108230688 by task swapper/5/0
> > > >   ...
> > > >   Call Trace:
> > > >    <IRQ>
> > > >    ...
> > > >    reqsk_fastopen_remove+0x142/0x210
> > > >    tcp_check_req+0x96f/0xdd0
> > > >    ...
> > > >    tcp_rcv_state_process+0x19c/0x26b0
> > > >    ...
> > > >    tcp_v4_do_rcv+0x16e/0x490
> > > >    tcp_v4_rcv+0x14a0/0x1af0
> > > >    ...
> > > >    ip_protocol_deliver_rcu+0x39/0x1e0
> > > >    ip_local_deliver_finish+0x124/0x1e0
> > > >    ip_local_deliver+0xfb/0x1e0
> > > >    ...
> > > >    </IRQ>
> > > >
> > > > To widen the race windows, mdelay(5) was added after newsk = req->sk,
> > > > mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
> > > > after tcp_rsk(req)->tfo_listener = false. The KASAN report above was
> > > > reproduced with this kernel.
> > > >
> > > > For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead of
> > > > tfo_listener, which reqsk_fastopen_remove() clears.
> > > >
> > > > syn_fastopen_child is a field of the Fast Open child TCP socket
> > > > referenced by newsk, not of the request_sock. It is set before the child
> > > > socket is added to the accept queue. The paths that call
> > > > reqsk_fastopen_remove() in response to a remote ACK or RST do not clear
> > > > this field.
> > > >
> > > > inet_csk_accept() uses this field to take fastopenq.lock only for Fast
> > > > Open child sockets and rechecks tfo_listener while holding the lock.
> > > > Connections that did not use Fast Open continue to avoid the lock.
> > > >
> > > > Other bitfields sharing the same byte can be modified concurrently, so
> > > > annotate the lockless read of syn_fastopen_child with data_race().
> > > >
> > > > Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()")
> > > > Cc: stable@vger.kernel.org
> > > > Assisted-by: LLM
> > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > > ---
> > > >  net/ipv4/inet_connection_sock.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > > > index e56beec438773..e5e7b844fed44 100644
> > > > --- a/net/ipv4/inet_connection_sock.c
> > > > +++ b/net/ipv4/inet_connection_sock.c
> > > > @@ -683,7 +683,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
> > > >     newsk = req->sk;
> > > >
> > > >     if (sk->sk_protocol == IPPROTO_TCP &&
> > > > -       tcp_rsk(req)->tfo_listener) {
> > > > +       /* Stable while reqsk removal can race; adjacent bitfields may change. */
> > > > +       data_race(!!tcp_sk(newsk)->syn_fastopen_child)) {
> > >
> > > Are data_race() and !! necessary ?
> >
> > It was intended to avoid spurious KCSAN reports.
> 
> 1-bit cannot be torn, and I guess KCSAN will not complain
> even if there were a concurrent writer.

Ah-ha.

> 
> 
> >
> > Still.. I agree that it looks a little odd. If you think it is
> > unnecessary, I will send a v2 without it.
> 
> I feel it's misleading as data_race() implies the concurrent
> writer, but when syn_fastopen_child is set, the bit itself
> and the other bit fields are not written concurrently either.

I'll send a cleaned-up v2.
