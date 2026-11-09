Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228957;
	b=ANn0gxHsL5PuqY53gpyzaHgOTVupKBoZ2UhK1CJaVtKYaGG5iK/gnht9azDIfI+dAH6M
	 CMZhtA5tSAhW32l31+HFbrBG9ViTxpyM6oqhByYz7P/MNaHW/bOVDlYCFNLTlMB2e5Nje
	 NGkzMd2SZuaB4cqukUUTdQF6cC3Vz4kdqocdskJ8qU0fP7TR8f12cp4ZHUReUJNH1oeZD
	 V8KRW+htzqE3GRxaGJDsaMYGmu2+/T11BgvQxtIIeiIZKjHOVF6C3W/NPObzQtaJW6NQQ
	 yyEE4p0TNb4qVrcb2JKz25CkNhVnQWOqH1+Cvr3767oTfXrbO6wguixTTI2jWuCAJXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228957;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QmlNSwLc6buEHOgEzj32ULNeq+2FZUUU9zK5Ugfw3Xg=;
	b=OMWIGm1nP533ZSLbjI+BFdGgfe4aXrF6N9MsMBG4mAGpeOEHhYUL6A26OeeZ9AJTcT+R
	 X+jdIoU9K9/OI4OF8WE4gRokNmwdgck/AuMMp3GzP0yV9WmNzdh36/yGY1cs76phiLP9x
	 MU2/Tt3nIqyeQZt7oQz6WikjVlH+vV0Wk/6VYVuQK6rCNi+ZmpkRA2VKtMCY6C8t1wQ3s
	 SWVNV7OLXCWTAJoy93eNL2SkFUF4nwUxVtn9SShdSfjanGq3YDqTvB5uxw93/4vMQnDWp
	 tmnriHwcU8pdlFgOunb8NfpI1smKf5QQF7MhUa4w1DOFmoXMPx+yaWDIaYK9NK9ITMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8H00QAL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC8606A330
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8H00QAL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA81C1F008A3
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228956;
	bh=QmlNSwLc6buEHOgEzj32ULNeq+2FZUUU9zK5Ugfw3Xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P8H00QALHmW07qpsh+/TXpHrnHFdEo8k2j13WillFiwYYd0lEnEWHzgmUbcB83L/P
	 uL8PTZ2B8D69AVVGUrR1hl19StJj4pK4hFir34nUpHzMXZ6auNQcHRtdVkZsENkZY2
	 NLePEZIq39hhMV5A8jCer1YOxMXNHSwYg6T48Yshit3jgvV2BOaXOj0szA4pgun1xR
	 k2O1giPrjQym3/bED6Wo6TZeoK+zIy629FRjMmm6q0Fx2HP4+XoLnJxMPIpLpaKIGp
	 AuvESJ7RYPkFY/5mt28B5NP33hNfROPjpB335aPp08xaDXotAeaGhack5xzsiyfVYp
	 +rppPNBNFtH0g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4adba7b3399so280268fac.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 04:55:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHghwovGZy5RW3ELwlWyVr1MQmEgUuMyi2dr5JSKcXecRqInSZpi19Y9OLoL+LnHkMheIkBWCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+U/QksDLdR1CwXq++j2/sp+0ekFRPzs7pJB491/iM1SdmCDH+2
	D1Odw94HWSzlc/Phpap5Sun8IfaxDTV4PTlfV7gQyQG1yJfG+uLJtITfG1uVV9avZra5kLQHePB
	zuancX2LI+IqEETS90CXanyDAkWRrO8Q=
X-Received: by 2002:a05:6808:3088:b0:567:cac4:f1c3 with SMTP id
 5614622812f47-56814645938mr3302855b6e.23.1794228955967; Mon, 09 Nov 2026
 04:55:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avGpsTb2hsGIjSRk@v4bel>
In-Reply-To: <avGpsTb2hsGIjSRk@v4bel>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 9 Nov 2026 13:55:44 +0100
X-Gmail-Original-Message-ID: <CAL4WiirT7+1BDp97UWmBC8xpwDbNn1q0kWhztB9Gvs_i9u2shA@mail.gmail.com>
X-Gm-Features: AclHuK8AXldAhOny5_DIBeo-TPv-GHc6lNKVE1dWB49YKc5RwF3I9vvwwU8EkqE
Message-ID: <CAL4WiirT7+1BDp97UWmBC8xpwDbNn1q0kWhztB9Gvs_i9u2shA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix NULL pointer dereference when restarting a
 Fast Open listener
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 9 nov. 2026 =C3=A0 12:08, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9c=
rit :
>
> When a valid RST is received for a Fast Open child accepted before the
> three-way handshake completes, reqsk_fastopen_remove() adds the
> request_sock to the listener's RST list if the listener is in TCP_LISTEN.
>
> An application can call shutdown(SHUT_RD) and then listen() on the same
> listener socket. inet_csk_listen_stop() checks rskq_rst_head without
> holding fastopenq.lock. If rskq_rst_head is NULL, it does not acquire the
> lock and therefore does not synchronize with an insertion by
> reqsk_fastopen_remove() after that function has passed the TCP_LISTEN
> check.
>
> The subsequent reqsk_queue_alloc() also initializes rskq_rst_head,
> rskq_rst_tail, and qlen in that order without holding the lock. If a
> request_sock is added between the initialization of rskq_rst_head and
> rskq_rst_tail, rskq_rst_head points to the request_sock while
> rskq_rst_tail is NULL.
>
> When a valid RST is later received for another accepted Fast Open child,
> rskq_rst_head is not NULL, so reqsk_fastopen_remove() attempts to write
> the request_sock pointer to rskq_rst_tail->dl_next while rskq_rst_tail is
> NULL. KASAN reports:
>
>   BUG: KASAN: null-ptr-deref in reqsk_fastopen_remove+0x147/0x210
>   Write of size 8 at addr 0000000000000088 by task swapper/3/0
>   ...
>   Call Trace:
>    <IRQ>
>    ...
>    reqsk_fastopen_remove+0x147/0x210
>    tcp_check_req+0xa70/0x1060
>    ...
>    tcp_rcv_state_process+0x1cb/0x2ae0
>    ...
>    tcp_v4_do_rcv+0x1fe/0x740
>    tcp_v4_rcv+0x1744/0x2070
>    ...
>    ip_protocol_deliver_rcu+0x5c/0x280
>    ip_local_deliver_finish+0x171/0x330
>    ip_local_deliver+0x107/0x370
>    ...
>    </IRQ>
>
> To widen the race window, the issue was reproduced after adding
> mdelay(3000) immediately after reqsk_fastopen_remove() checks that the
> listener is in TCP_LISTEN and immediately after reqsk_queue_alloc() sets
> rskq_rst_head to NULL.
>
> Make inet_csk_listen_stop() acquire fastopenq.lock regardless of the
> value of rskq_rst_head and detach the list while holding the lock. If
> reqsk_fastopen_remove() has already passed the TCP_LISTEN check,
> inet_csk_listen_stop() waits until the list insertion completes.
>
> Also initialize rskq_rst_head, rskq_rst_tail, and qlen under the same
> lock in reqsk_queue_alloc(). Drop the references to the detached
> request_sock objects after releasing the lock.
>
> Fixes: 0536fcc039a8 ("tcp: prepare fastopen code for upcoming listener ch=
anges")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index e56beec438773..5590fc7efb88d 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1333,9 +1333,11 @@ static int inet_ulp_can_listen(const struct sock *=
sk)
>
>  static void reqsk_queue_alloc(struct request_sock_queue *queue)
>  {
> +       spin_lock_bh(&queue->fastopenq.lock);
>         queue->fastopenq.rskq_rst_head =3D NULL;
>         queue->fastopenq.rskq_rst_tail =3D NULL;
>         queue->fastopenq.qlen =3D 0;
> +       spin_unlock_bh(&queue->fastopenq.lock);

I do not think this spin_lock_bh() is _needed_ here, this hunk is
misleading/distracting.

Once inet_csk_listen_stop() takes fastopenq.lock unconditionally,
reqsk_fastopen_remove() either inserted its req before we grabbed the lock
(and we free it), or it will see sk_state !=3D TCP_LISTEN and will not inse=
rt
anything. Nothing can be added to rskq_rst_head until inet_csk_listen_start=
()
sets TCP_LISTEN again, after reqsk_queue_alloc().

The double mdelay() needed to reproduce the NULL deref shows the window:
shutdown() + listen() would have to complete while reqsk_fastopen_remove()
is between its TCP_LISTEN check and the list insertion.

Please let's focus on the real issue, which is solely in
inet_csk_listen_stop().

Also note the more likely outcome of this race is a leak: a req stranded
in rskq_rst_head holds a reference on the listener, and a subsequent
close() will not call inet_csk_listen_stop() again. This is worth
mentioning in the changelog.

Please send a v2 with only the inet_csk_listen_stop() part.

Thanks.

pw-bo: cr
