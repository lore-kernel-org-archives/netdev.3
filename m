Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232650;
	b=XQnd/oHFmy9WjE9+E2DxGybrwmBCLhqMrgsqADCJyT1ghMOFz5DT1p+V/hxoVmkv5IZL
	 KWxpzoGmOkKsb3hUa/NWkWHlWB0aK68DU6zYpI6Q8L5AtDzCXvI2lpB1zM/vDfha0/wMf
	 pfeK48lgnIzZXerzVLxl6h3XYlQE8GwcUw4r26Q9CA3G2HrZHZYOPyYxLKkZl53VoGO2Q
	 YU5QNTgNpdCEydV+bsc/U7axEtKCRiacWmuFNALOblrpqbzSEUa3x7TqfAH//vEQVe+gv
	 YCis1b5JN8UvHaaRPQWzWdZXREOyCLRc2RP5W/HqPsFJ4+koa5LL1Pq4sklgkUBE8mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=pUWL0pcwmbMQZs/L2xhsjyboSQEvYXx95/cF1VP0qEM=;
	b=2E6217T0xhkIXnCbDS1sKK2tQEG5+54ZdT0Daxf89fwmbHCz/yLwNi/lXU+UuSifk9/e
	 ILIA73miqMK1ESL296x5XLeKDgxCQcLpq9ryJ3+Jn5oZP0d7+/8E5vAZ+YQX8SyCxlJFy
	 2slpyLE/QPYVyF7XM28mizzHFDScWkZ4dpdw40Mj6dojZsE/bx8R8nwz16wZ6o8AqwR2L
	 7Gm8TdiPm2m8AtQdW0eoQ1UdmS7M8VlhCEkYj4C8/6DLHKowaR1oH7VdLl/RLnSgzODf/
	 kAIUPqpVKFp5gJ33bojzCR57WBsqaSKiDfj48XF8MR1xiN3VdoGfGMIdmPq/SrmkNPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/q1DN31";
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564CD606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564CD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/q1DN31
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so498961b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232650; x=1794837450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pUWL0pcwmbMQZs/L2xhsjyboSQEvYXx95/cF1VP0qEM=;
        b=n/q1DN31kTUn6449EOw0z6AWYDWPy7GuJD6qCtUxgFOlA/vCnt4FCc5SlbUkBJROC/
         8JpulzT/u2Cmv40lqGKct8Pe9/ZGNtNrmKfQdE8rsavznK8Kd1LqPCdlGlcfe7ctDnqf
         0Bpw1p+6jO9fhXCw/eeIVw9M15VnURA0AaAsQ7fC7xlwSDkdQWFifuHz7/UNfRadPK4N
         4m6516tI4qkRKW+wLutY0+ls1BhLbzIcpuGc9eIelO+8a0xD0nyZ0ydABDRf39HKBw7E
         zTluwG/8o3VFve33ReJXHtLaUfoP3YryhkEbC6hp6ElzLs4WGu6VtlMa1y8lfjy4hapC
         sgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232650; x=1794837450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pUWL0pcwmbMQZs/L2xhsjyboSQEvYXx95/cF1VP0qEM=;
        b=RvcjAYPdlXoQSj9PBRqTx06Yx9XRnVUkCQy3G022XNJa1MGRO1i/clNJRKJMzXsU5G
         wYvu+dyR6C7w3goO90w1l5yxafslKCbJ031LppJCPAkMGO5ttdT30Pklul3pgQKOviJR
         dokpZFE3CSAKMv0NxLDNThneFCQLrbWNwa9LEvU4D/XAcY0iVbwjPZTjrzsX3udjrvy2
         yJCBiU8p+UVZqsdlIfvzRVF4np717X7iUxREprd5gNGjOVtqon5MzkVSPaQ/wiWu9OxI
         kkc7ICo737DjAs1GLGV6n4NetrYJoB7ce2kFC2N1zJ2xPix3sXtMx59V/4JzJJHwR7aZ
         ahfg==
X-Forwarded-Encrypted: i=1; AL+hErGU6X2mhrJ2chKjOH6LZrLK3BYHlm8F6igNe82KgUSGgBhIl3rFGRLvxb6OfuCZuZBBuxe8Gd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9o/17BZiOF85RiQZpba727XB5a5UPydoMsjbjXhQOr6jRuxo/5
	SKjlmr/C6i8R9ni/HHPAftA+PVxNty5RzN55cWQWRaPOELj8fUAOcjon
X-Gm-Gg: AYBFou1n1nIaQdV5PFJloWGQ4o3tU0YA9+dyjiGgrL7VG08/jZLUwm6wkNb4+tzk2Sq
	PyKWPeXhTSKM1GUTLLPT7QybFaaIDxSzI7OvEeveYASlknGCdLpFt3ssMAyFWSow9M3FK1obUbn
	wxOa1QtatBkhF4RclRNgzKcPRWEHlj6IFrQx//TYJ+Pc8llLN17wVGe0iUX9Xuw9yjqIuKK/xkR
	KmrvOsNjoBODKEdCWGtq5N5ZLIP0nyKEIYKsyEbEUWR03KnkY9SrvTg7czXBHyB5jfewxrWeV3G
	u4d66FJU/sg7mf9aWYVy54xi5VX3HHX/beWHzqkkuo4kkz/8NjKao0BOu89c549fP+EFIavZVXs
	JWlLc0hms5PLEkt4V7tG8vuAWKfUaqK9nWLTkYF2/FtL1dpsuD3kVb6Zk12F4cbpYgtKy2dN34o
	IikOgsrLq96GetAB4exaRB4CPtSojZ5tf7pTkS35x9TzUAYg1tkoXg0c3FcuZJvv4NDy05XHuQe
	NfecVtR8xZoWBNWDk6UCgIlh3v/wgO636dqAJVf1Snjevi0N8vadeaaXeuguDYiBJMyxWEsC9Qh
	aVOt4guqoSRLFPnlSB0zcwo53OKjwOkZhO47syZAuubNnpE=
X-Received: by 2002:a05:6a00:1706:b0:878:34d7:697b with SMTP id d2e1a72fcca58-8b66f4db364mr3469416b3a.41.1794232649513;
        Mon, 09 Nov 2026 05:57:29 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b648e54de9sm1372614b3a.14.2026.11.09.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:57:29 -0800 (PST)
Date: Mon, 9 Nov 2026 22:57:24 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] tcp: fix NULL pointer dereference when restarting a
 Fast Open listener
Message-ID: <avHRROArfXiPqwz5@v4bel>
References: <avGpsTb2hsGIjSRk@v4bel>
 <CAL4WiirT7+1BDp97UWmBC8xpwDbNn1q0kWhztB9Gvs_i9u2shA@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiirT7+1BDp97UWmBC8xpwDbNn1q0kWhztB9Gvs_i9u2shA@mail.gmail.com>

On Mon, Nov 09, 2026 at 01:55:44PM +0100, Eric Dumazet wrote:
> Le lun. 9 nov. 2026 à 12:08, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > When a valid RST is received for a Fast Open child accepted before the
> > three-way handshake completes, reqsk_fastopen_remove() adds the
> > request_sock to the listener's RST list if the listener is in TCP_LISTEN.
> >
> > An application can call shutdown(SHUT_RD) and then listen() on the same
> > listener socket. inet_csk_listen_stop() checks rskq_rst_head without
> > holding fastopenq.lock. If rskq_rst_head is NULL, it does not acquire the
> > lock and therefore does not synchronize with an insertion by
> > reqsk_fastopen_remove() after that function has passed the TCP_LISTEN
> > check.
> >
> > The subsequent reqsk_queue_alloc() also initializes rskq_rst_head,
> > rskq_rst_tail, and qlen in that order without holding the lock. If a
> > request_sock is added between the initialization of rskq_rst_head and
> > rskq_rst_tail, rskq_rst_head points to the request_sock while
> > rskq_rst_tail is NULL.
> >
> > When a valid RST is later received for another accepted Fast Open child,
> > rskq_rst_head is not NULL, so reqsk_fastopen_remove() attempts to write
> > the request_sock pointer to rskq_rst_tail->dl_next while rskq_rst_tail is
> > NULL. KASAN reports:
> >
> >   BUG: KASAN: null-ptr-deref in reqsk_fastopen_remove+0x147/0x210
> >   Write of size 8 at addr 0000000000000088 by task swapper/3/0
> >   ...
> >   Call Trace:
> >    <IRQ>
> >    ...
> >    reqsk_fastopen_remove+0x147/0x210
> >    tcp_check_req+0xa70/0x1060
> >    ...
> >    tcp_rcv_state_process+0x1cb/0x2ae0
> >    ...
> >    tcp_v4_do_rcv+0x1fe/0x740
> >    tcp_v4_rcv+0x1744/0x2070
> >    ...
> >    ip_protocol_deliver_rcu+0x5c/0x280
> >    ip_local_deliver_finish+0x171/0x330
> >    ip_local_deliver+0x107/0x370
> >    ...
> >    </IRQ>
> >
> > To widen the race window, the issue was reproduced after adding
> > mdelay(3000) immediately after reqsk_fastopen_remove() checks that the
> > listener is in TCP_LISTEN and immediately after reqsk_queue_alloc() sets
> > rskq_rst_head to NULL.
> >
> > Make inet_csk_listen_stop() acquire fastopenq.lock regardless of the
> > value of rskq_rst_head and detach the list while holding the lock. If
> > reqsk_fastopen_remove() has already passed the TCP_LISTEN check,
> > inet_csk_listen_stop() waits until the list insertion completes.
> >
> > Also initialize rskq_rst_head, rskq_rst_tail, and qlen under the same
> > lock in reqsk_queue_alloc(). Drop the references to the detached
> > request_sock objects after releasing the lock.
> >
> > Fixes: 0536fcc039a8 ("tcp: prepare fastopen code for upcoming listener changes")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index e56beec438773..5590fc7efb88d 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1333,9 +1333,11 @@ static int inet_ulp_can_listen(const struct sock *sk)
> >
> >  static void reqsk_queue_alloc(struct request_sock_queue *queue)
> >  {
> > +       spin_lock_bh(&queue->fastopenq.lock);
> >         queue->fastopenq.rskq_rst_head = NULL;
> >         queue->fastopenq.rskq_rst_tail = NULL;
> >         queue->fastopenq.qlen = 0;
> > +       spin_unlock_bh(&queue->fastopenq.lock);
> 
> I do not think this spin_lock_bh() is _needed_ here, this hunk is
> misleading/distracting.
> 
> Once inet_csk_listen_stop() takes fastopenq.lock unconditionally,
> reqsk_fastopen_remove() either inserted its req before we grabbed the lock
> (and we free it), or it will see sk_state != TCP_LISTEN and will not insert
> anything. Nothing can be added to rskq_rst_head until inet_csk_listen_start()
> sets TCP_LISTEN again, after reqsk_queue_alloc().

Ah, yes, that spin lock is unnecessary.

> 
> The double mdelay() needed to reproduce the NULL deref shows the window:
> shutdown() + listen() would have to complete while reqsk_fastopen_remove()
> is between its TCP_LISTEN check and the list insertion.
> 
> Please let's focus on the real issue, which is solely in
> inet_csk_listen_stop().
> 
> Also note the more likely outcome of this race is a leak: a req stranded
> in rskq_rst_head holds a reference on the listener, and a subsequent
> close() will not call inet_csk_listen_stop() again. This is worth
> mentioning in the changelog.
> 
> Please send a v2 with only the inet_csk_listen_stop() part.

Ok. I'll do that.


Best regards,
Hyunwoo Kim
