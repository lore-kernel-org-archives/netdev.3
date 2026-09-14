Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED13C1F54
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409297; cv=pass; b=GkyIdtCtLNIo8/cx3Ff9JiY7eEmJhGFJV5GZ4owR9t4DlnUd7DWNZbWngNqoBH6xFebanHf0DUQBjmwi43SyK/1/7HdSEQrRELMJERvGXpXEA+KBX99Bd9ZYGgDcEkEJIsqOvQOXrVr/0rQ6YdIOsisMw8mqrQbKNzoTzJQApkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409297; c=relaxed/simple;
	bh=GNtEnyksoZpieQFZBEVPTyijM5iCA+K11bd3cC2SOjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnUY6w7Hk1tKbKQf4UYfwgY1gB9btlTrqtylfTKrNvyvzqSTGYMKsnBmIe22XKxB5vEZyp4qPmDPeRbB5il19+8s6R7jgGWW9OYauWA5XGcc0vshkRCnmUEhtK2+dVWNi1ccMox8oPRgv7QtWZq8z+SyPp7FW05Ho0X6Qb3KNu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nsj7g9SO; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsj7g9SO"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2507a0a24bso40634966b.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789409291; cv=none;
        d=google.com; s=arc-20260327;
        b=qskBTLeVx31KWbSMPbDpxUskQkXcKIkS6TwZ+ieLcy1xWRFjjtTdMKLI6uAR8bhYv5
         AbtyZT+Wb3CaPLT21J7PgKKJEmIr8pgKYZYR7p66prCeBs+kG+hUfTRky8xS/25mRuDO
         rHigF4IcoERVaFagXJqbLzsZ81Y6u43+LvSkESbcnPJ7L4C6o78Dgw4sOmFpviqUrmYQ
         dIErO0/mtpcHUhzNx9XypeNB8nwkiqn5rK8qVyetMVOJMKBcUCffc68dMhxsbbfsWsjQ
         3/nelAqxTyYIQMDcv4SRbvGBOlohr0kgWopO59UG7y1XgxcNqfoeNWsibKupNsZxK84A
         X+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dZsSAMkqmvVrGGLo+Ywm+06xr1Q8V8tL5t2T+paIFpo=;
        fh=z+LlXHNMunQ99zMQ84h9TSyrlT03dB3msBGlHjmIrhc=;
        b=qCyENq/wfihQNNhn1ic1gWW9+I0FAMDchHN0aliFxnjzpF1ecRUZdya87m+b5HTq9y
         2HnsUH9EQaI8sDAVnh6b6sUCimkaMunDo8eon5krS/WyXizljyiu19oUvAmCMde9KG7m
         KJFxbhOz/pSS4C2vVTwogKEfknc2SeaspqunM5Eu2spcbnTwp/JjhGqwavVA575usb3b
         XQ/YWG0rjAEWVvtfipqqxl7tXIbCQmUgXtJwCFNlKOeA9u0lAtIlwyCKurAKyB7c1HvA
         BsCs4rd+e9ZFne+11NJkiADjapdWpzUBMcolCZ5zw16cqH2Nb1AwGepC5nYSxLxMyXtr
         4d8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789409291; x=1790014091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dZsSAMkqmvVrGGLo+Ywm+06xr1Q8V8tL5t2T+paIFpo=;
        b=Nsj7g9SOrGSs9BA704u5oUQu+x0cyu9OjVlbCYuI9ODcRzEhFs8J5vs/866WXHoC/f
         AgdRF9GUmhINCO3DVSxQ57akTV/jul/YoUj/7FAvnema2jUkgQC7W4zrWZQgDZCdW0Ok
         4jozPlI+vEi4VwRRPVUQO+vXr8U7JCSHI4vVu2SaCF/TiNZGsz2wPwBb+wt+ExlhAxay
         eS6pmM5g3kAJjyiMZ4ZrU9U+KxHTE++xkjSKGE1JIpdo4jjCDryWgcqrVpBaXA3kmlLE
         4hOoIjZfAzagtNKaOSPILJKQP7sO0n1wkLzKvujFy2+BkVLD8rYj22FooVmi+tN+JETa
         QdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409291; x=1790014091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZsSAMkqmvVrGGLo+Ywm+06xr1Q8V8tL5t2T+paIFpo=;
        b=JilZmka4KqcV2zRlUTK14RGCO/3RwuO1PRSTfYsobmRgsphQadtjxDTFSw3Wmd0A9t
         GvsDOQD5f/ZbwIUjTb0pqJ5xxkMzP3bg18KKO625rZGIdbc7mI5+zXt+9HugEyb6YiJ+
         Z1EEl73zenpUS1zNea7qTZtx3z5Dim20ISMwqUA7pkkJwHOih6N+6yjIrhA4lP0idzJD
         wl6mrwQVeMi7PiHAgbuusyQxMWOiO+JGZi8XABqb57fBGDafqZyS6WTQzCJQyh4emsx3
         gVriDE/H0aCkHY+RyshcJfpwGcpAiWG7x+FWUz1IyAKXGi1L3EdMxChGfIfmnVou56Y8
         utVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHOhoBA58z/8q452g6uwPDDysYo4Rxnq0HnbMQX2erOUVb+ldhNCbK2JECD//6Zy3mT8IlY/8=@vger.kernel.org
X-Gm-Message-State: AFuF++mlLdOl20HdhMvLXj55rmlAZNjJI5y0wLB2RX1J1XgAbz0P2JZo
	QCMQJ9RKmH63wggx5iREasYV5vA5KICBahpg+hSyM5YjTP6HNc6E+DJs6vKLcR8j/xh/MvoxKn5
	2dlQ1uc1Qj4hAChAIpBiUjRHUHHVLvoM=
X-Gm-Gg: AYBFou0RahGMuxHrskHKx6K6d6B7YOkeoOJFXwn34XbZOajCj/ijC35FeMYR7Du0Ycg
	aBmFFHaCaAHLVe2RV/x4Tch1wvHcWCZoZyvEX6J/To9apoFJVRQ1n2JlkGOGyPSduQbcOc1kbc2
	jrqTdDddl/m2Y3WrEY3KI7IJKDV0VExSq6zCXeq+oqhVEDzBlJS+jYKn8yl9R2iUpk62yEdodC/
	VznP2cXIYUrTewjgalwaQcMhk7F3acgZnRAJZKd5sl9kR1EulbhmwIn5aQRjMPmiIhYWzZuwc91
	qqmrCocqF9l3PZr0BslBMGrqDR5PwMOVHeDpb5B9+CWFJcFlGs97NXZ/LG/qVJQqswmR+/XZZjL
	6n4XzHOyx
X-Received: by 2002:a17:907:961a:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c29b805aa58mr272778166b.0.1789409290921; Mon, 14 Sep 2026
 11:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824150220.216067-1-nicoyip.dev@gmail.com> <3226752.1789397935@warthog.procyon.org.uk>
In-Reply-To: <3226752.1789397935@warthog.procyon.org.uk>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 15 Sep 2026 02:07:59 +0800
X-Gm-Features: AcwNN1VV9Vfvtm8hYHvkD4szkX5eYUJBHtX0vHbJHnsG1sOPyeukOzqEL0dVaiI
Message-ID: <CAAo+4rVwjW07EWGft77D4+B_ptVK+bj8zfHdhr3yJG8BM2+3qA@mail.gmail.com>
Subject: Re: [PATCH net] rxrpc: Take write lock when publishing the initial
 RxGK key
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 10:59=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Chengfeng Ye <nicoyip.dev@gmail.com> wrote:
>
> > On a client connection, a second sendmsg can observe
> > RXRPC_CONN_CLIENT through a lockless load of conn->state,
>
> I wonder if I need something like the attached also...  Or if it might do
> instead, though I think there's no harm in doing your writelock suggestio=
n
> anyway.
>
> David
> ---
> commit 21a0c0765f5d2654379f3a0065b059e676d7c761
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Sep 14 14:40:13 2026 +0100
>
>     rxrpc: Fix lack of conn->state barriering
>
>     Because rxrpc can manipulate the connection state in one thread and t=
hen
>     read it in another, but it also guards access to some members in the
>     struct, it needs to have release/acquire barriers.  Fix this by using
>     helpers to read/set the connection state.
>
>     Fixes: 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O t=
hread")
>     Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113=
743.1453210-1-dhowells%40redhat.com
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Marc Dionne <marc.dionne@auristor.com>
>     cc: Eric Dumazet <edumazet@google.com>
>     cc: "David S. Miller" <davem@davemloft.net>
>     cc: Jakub Kicinski <kuba@kernel.org>
>     cc: Paolo Abeni <pabeni@redhat.com>
>     cc: Simon Horman <horms@kernel.org>
>     cc: linux-afs@lists.infradead.org
>
> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index cb36a709f540..dde262ffc7fe 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -601,7 +601,7 @@ struct rxrpc_connection {
>         unsigned long           events;
>         unsigned long           idle_timestamp; /* Time at which last bec=
ame idle */
>         spinlock_t              state_lock;     /* state-change lock */
> -       enum rxrpc_conn_proto_state state;      /* current state of conne=
ction */
> +       enum rxrpc_conn_proto_state _state;     /* current state of conne=
ction */
>         enum rxrpc_call_completion completion;  /* Completion condition *=
/
>         s32                     abort_code;     /* Abort code of connecti=
on abort */
>         int                     debug_id;       /* debug ID for printks *=
/
> @@ -1185,10 +1185,23 @@ void rxrpc_process_delayed_final_acks(struct rxrp=
c_connection *, bool);
>  bool rxrpc_input_conn_packet(struct rxrpc_connection *conn, struct sk_bu=
ff *skb);
>  void rxrpc_input_conn_event(struct rxrpc_connection *conn, struct sk_buf=
f *skb);
>
> +static inline void rxrpc_set_conn_state(struct rxrpc_connection *conn,
> +                                       enum rxrpc_conn_proto_state state=
)
> +{
> +       /* Order write of conn info before write of state. */
> +       smp_store_release(&conn->_state, state);
> +}
> +
> +static inline
> +enum rxrpc_conn_proto_state rxrpc_conn_state(const struct rxrpc_connecti=
on *conn)
> +{
> +       /* Order read of state before read of conn info. */
> +       return smp_load_acquire(&conn->_state);
> +}
> +
>  static inline bool rxrpc_is_conn_aborted(const struct rxrpc_connection *=
conn)
>  {
> -       /* Order reading the abort info after the state check. */
> -       return smp_load_acquire(&conn->state) =3D=3D RXRPC_CONN_ABORTED;
> +       return rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_ABORTED;
>  }
>
>  /*
> diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
> index 47824120f1da..1dcfd9e5fca4 100644
> --- a/net/rxrpc/call_accept.c
> +++ b/net/rxrpc/call_accept.c
> @@ -398,8 +398,8 @@ bool rxrpc_new_incoming_call(struct rxrpc_local *loca=
l,
>                 rx->app_ops->notify_new_call(&rx->sk, call, call->user_ca=
ll_ID);
>
>         spin_lock(&conn->state_lock);
> -       if (conn->state =3D=3D RXRPC_CONN_SERVICE_UNSECURED) {
> -               conn->state =3D RXRPC_CONN_SERVICE_CHALLENGING;
> +       if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_SERVICE_UNSECURED) {
> +               rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE_CHALLENGING=
);
>                 set_bit(RXRPC_CONN_EV_CHALLENGE, &call->conn->events);
>                 rxrpc_queue_conn(call->conn, rxrpc_conn_queue_challenge);
>         }
> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index 817ed9acb91e..29f9a01394c1 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -459,7 +459,7 @@ void rxrpc_incoming_call(struct rxrpc_sock *rx,
>
>         spin_lock(&conn->state_lock);
>
> -       switch (conn->state) {
> +       switch (rxrpc_conn_state(conn)) {
>         case RXRPC_CONN_SERVICE_UNSECURED:
>         case RXRPC_CONN_SERVICE_CHALLENGING:
>                 __set_bit(RXRPC_CALL_CONN_CHALLENGING, &call->flags);
> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index 48519f0de185..3055ef6fd11d 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c
> @@ -182,11 +182,12 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *=
bundle)
>         conn->upgrade           =3D bundle->upgrade;
>         conn->orig_service_id   =3D bundle->service_id;
>         conn->security_level    =3D bundle->security_level;
> -       conn->state             =3D RXRPC_CONN_CLIENT_UNSECURED;
>         conn->service_id        =3D conn->orig_service_id;
>
>         if (conn->security =3D=3D &rxrpc_no_security)
> -               conn->state     =3D RXRPC_CONN_CLIENT;
> +               rxrpc_set_conn_state(conn, RXRPC_CONN_CLIENT);
> +       else
> +               rxrpc_set_conn_state(conn, RXRPC_CONN_CLIENT_UNSECURED);
>
>         atomic_inc(&rxnet->nr_conns);
>         write_lock(&rxnet->conn_lock);
> @@ -206,6 +207,7 @@ rxrpc_alloc_client_connection(struct rxrpc_bundle *bu=
ndle)
>  static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
>  {
>         struct rxrpc_net *rxnet;
> +       enum rxrpc_conn_proto_state state;
>         int id_cursor, id, distance, limit;
>
>         if (!conn)
> @@ -215,8 +217,9 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connect=
ion *conn)
>         if (test_bit(RXRPC_CONN_DONT_REUSE, &conn->flags))
>                 goto dont_reuse;
>
> -       if ((conn->state !=3D RXRPC_CONN_CLIENT_UNSECURED &&
> -            conn->state !=3D RXRPC_CONN_CLIENT) ||
> +       state =3D rxrpc_conn_state(conn);
> +       if ((state !=3D RXRPC_CONN_CLIENT_UNSECURED &&
> +            state !=3D RXRPC_CONN_CLIENT) ||
>             conn->proto.epoch !=3D rxnet->epoch)
>                 goto mark_dont_reuse;
>
> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 611c790bc6d0..f60bceff0bad 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -25,14 +25,13 @@ static bool rxrpc_set_conn_aborted(struct rxrpc_conne=
ction *conn,
>  {
>         bool aborted =3D false;
>
> -       if (conn->state !=3D RXRPC_CONN_ABORTED) {
> +       if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_ABORTED) {
>                 spin_lock_irq(&conn->state_lock);
> -               if (conn->state !=3D RXRPC_CONN_ABORTED) {
> +               if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_ABORTED) {
>                         conn->abort_code =3D abort_code;
>                         conn->error      =3D err;
>                         conn->completion =3D compl;
> -                       /* Order the abort info before the state change. =
*/
> -                       smp_store_release(&conn->state, RXRPC_CONN_ABORTE=
D);
> +                       rxrpc_set_conn_state(conn, RXRPC_CONN_ABORTED);
>                         set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);
>                         set_bit(RXRPC_CONN_EV_ABORT_CALLS, &conn->events)=
;
>                         aborted =3D true;
> @@ -272,7 +271,7 @@ static int rxrpc_process_event(struct rxrpc_connectio=
n *conn,
>         bool secured =3D false;
>         int ret;
>
> -       if (conn->state =3D=3D RXRPC_CONN_ABORTED)
> +       if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_ABORTED)
>                 return -ECONNABORTED;
>
>         _enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.s=
erial);
> @@ -286,7 +285,7 @@ static int rxrpc_process_event(struct rxrpc_connectio=
n *conn,
>
>         case RXRPC_PACKET_TYPE_RESPONSE:
>                 spin_lock_irq(&conn->state_lock);
> -               if (conn->state !=3D RXRPC_CONN_SERVICE_CHALLENGING) {
> +               if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_SERVICE_CHALLE=
NGING) {
>                         spin_unlock_irq(&conn->state_lock);
>                         return 0;
>                 }
> @@ -302,8 +301,8 @@ static int rxrpc_process_event(struct rxrpc_connectio=
n *conn,
>                         return ret;
>
>                 spin_lock_irq(&conn->state_lock);
> -               if (conn->state =3D=3D RXRPC_CONN_SERVICE_CHALLENGING) {
> -                       conn->state =3D RXRPC_CONN_SERVICE;
> +               if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_SERVICE_CHAL=
LENGING) {
> +                       rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE);
>                         secured =3D true;
>                 }
>                 spin_unlock_irq(&conn->state_lock);
> @@ -548,7 +547,7 @@ void rxrpc_input_conn_event(struct rxrpc_connection *=
conn, struct sk_buff *skb)
>                 conn->tx_response =3D NULL;
>                 spin_unlock_irq(&conn->local->lock);
>
> -               if (conn->state !=3D RXRPC_CONN_ABORTED)
> +               if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_ABORTED)
>                         rxrpc_send_response(conn, skb);
>                 rxrpc_free_skb(skb, rxrpc_skb_put_response);
>         }
> @@ -556,7 +555,7 @@ void rxrpc_input_conn_event(struct rxrpc_connection *=
conn, struct sk_buff *skb)
>         if (skb) {
>                 switch (skb->mark) {
>                 case RXRPC_SKB_MARK_SERVICE_CONN_SECURED:
> -                       if (conn->state !=3D RXRPC_CONN_SERVICE)
> +                       if (rxrpc_conn_state(conn) !=3D RXRPC_CONN_SERVIC=
E)
>                                 break;
>
>                         for (loop =3D 0; loop < RXRPC_MAXCALLS; loop++)
> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 1be50e0c9cee..12914fb72345 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -407,7 +407,7 @@ void rxrpc_service_connection_reaper(struct work_stru=
ct *work)
>                 ASSERTCMP(atomic_read(&conn->active), >=3D, 0);
>                 if (likely(atomic_read(&conn->active) > 0))
>                         continue;
> -               if (conn->state =3D=3D RXRPC_CONN_SERVICE_PREALLOC)
> +               if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_SERVICE_PREA=
LLOC)
>                         continue;
>
>                 if (rxnet->live && !conn->local->dead) {
> diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
> index 39c908a3ca6e..04a8206f3a44 100644
> --- a/net/rxrpc/conn_service.c
> +++ b/net/rxrpc/conn_service.c
> @@ -126,7 +126,7 @@ struct rxrpc_connection *rxrpc_prealloc_service_conne=
ction(struct rxrpc_net *rxn
>                 /* We maintain an extra ref on the connection whilst it i=
s on
>                  * the rxrpc_connections list.
>                  */
> -               conn->state =3D RXRPC_CONN_SERVICE_PREALLOC;
> +               rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE_PREALLOC);
>                 refcount_set(&conn->ref, 2);
>
>                 atomic_inc(&rxnet->nr_conns);
> @@ -161,10 +161,6 @@ void rxrpc_new_incoming_connection(struct rxrpc_sock=
 *rx,
>         conn->security_ix       =3D sp->hdr.securityIndex;
>         conn->out_clientflag    =3D 0;
>         conn->security          =3D sec;
> -       if (conn->security_ix)
> -               conn->state     =3D RXRPC_CONN_SERVICE_UNSECURED;
> -       else
> -               conn->state     =3D RXRPC_CONN_SERVICE;
>
>         /* See if we should upgrade the service.  This can only happen on=
 the
>          * first packet on a new connection.  Once done, it applies to al=
l
> @@ -174,6 +170,11 @@ void rxrpc_new_incoming_connection(struct rxrpc_sock=
 *rx,
>             conn->service_id =3D=3D rx->service_upgrade.from)
>                 conn->service_id =3D rx->service_upgrade.to;
>
> +       if (conn->security_ix)
> +               rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE_UNSECURED);
> +       else
> +               rxrpc_set_conn_state(conn, RXRPC_CONN_SERVICE);
> +
>         atomic_set(&conn->active, 1);
>
>         /* Make the connection a target for incoming packets. */
> diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
> index e9a27fa7b25d..99d2c850b94e 100644
> --- a/net/rxrpc/proc.c
> +++ b/net/rxrpc/proc.c
> @@ -146,6 +146,7 @@ static int rxrpc_connection_seq_show(struct seq_file =
*seq, void *v)
>         struct rxrpc_connection *conn;
>         struct rxrpc_net *rxnet =3D rxrpc_net(seq_file_net(seq));
>         const char *state;
> +       enum rxrpc_conn_proto_state cstate;
>         char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZ=
E];
>
>         if (v =3D=3D &rxnet->conn_proc_list) {
> @@ -159,7 +160,8 @@ static int rxrpc_connection_seq_show(struct seq_file =
*seq, void *v)
>         }
>
>         conn =3D list_entry(v, struct rxrpc_connection, proc_link);
> -       if (conn->state =3D=3D RXRPC_CONN_SERVICE_PREALLOC) {
> +       cstate =3D rxrpc_conn_state(conn);
> +       if (cstate =3D=3D RXRPC_CONN_SERVICE_PREALLOC) {
>                 strcpy(lbuff, "no_local");
>                 strcpy(rbuff, "no_connection");
>                 goto print;
> @@ -168,9 +170,9 @@ static int rxrpc_connection_seq_show(struct seq_file =
*seq, void *v)
>         scnprintf(lbuff, sizeof(lbuff), "%pISpc", &conn->local->srx.trans=
port);
>         scnprintf(rbuff, sizeof(rbuff), "%pISpc", &conn->peer->srx.transp=
ort);
>  print:
> -       state =3D rxrpc_is_conn_aborted(conn) ?
> +       state =3D (cstate =3D=3D RXRPC_CONN_ABORTED) ?
>                 rxrpc_call_completions[conn->completion] :
> -               rxrpc_conn_states[conn->state];
> +               rxrpc_conn_states[cstate];
>         seq_printf(seq,
>                    "UDP   %-47.47s %-47.47s %4x %08x %s %3u %3d"
>                    " %s %08x %08x %08x %08x %08x %08x %08x\n",
> diff --git a/net/rxrpc/security.c b/net/rxrpc/security.c
> index 2bfbf2b2bb37..f64acaa6cf53 100644
> --- a/net/rxrpc/security.c
> +++ b/net/rxrpc/security.c
> @@ -114,12 +114,12 @@ int rxrpc_init_client_conn_security(struct rxrpc_co=
nnection *conn)
>
>  found:
>         mutex_lock(&conn->security_lock);
> -       if (conn->state =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
> +       if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
>                 ret =3D conn->security->init_connection_security(conn, to=
ken);
>                 if (ret =3D=3D 0) {
>                         spin_lock_irq(&conn->state_lock);
> -                       if (conn->state =3D=3D RXRPC_CONN_CLIENT_UNSECURE=
D)
> -                               conn->state =3D RXRPC_CONN_CLIENT;
> +                       if (rxrpc_conn_state(conn) =3D=3D RXRPC_CONN_CLIE=
NT_UNSECURED)
> +                               rxrpc_set_conn_state(conn, RXRPC_CONN_CLI=
ENT);
>                         spin_unlock_irq(&conn->state_lock);
>                 }
>         }
> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index ed7ff32da184..dcbd2033ca01 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -336,7 +336,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>         if (ret < 0)
>                 goto out_unlock;
>
> -       if (call->conn->state =3D=3D RXRPC_CONN_CLIENT_UNSECURED) {
> +       if (rxrpc_conn_state(call->conn) =3D=3D RXRPC_CONN_CLIENT_UNSECUR=
ED) {
>                 ret =3D rxrpc_init_client_conn_security(call->conn);
>                 if (ret < 0)
>                         goto out_unlock;
>

Thanks for looking into the problem, this looks like a better fix. If
appropriate, I would appreciate if there could be a reported-by tag in
the patch:

Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Best regards,
Chengfeng
