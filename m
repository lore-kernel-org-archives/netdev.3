Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9A26C385
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234249; cv=pass; b=D2l0y7VvPiLlN9eJ2I0nd13T8gi29TtyoY8pFzA8iBraVUNoO4DnNc2OwmLk4qphk+Jw8kIrd8C82Yt6sVJ5ezPbqQTjgIcFypFGC95Ux+VBFddJpAL/K9ApQ1gdLnorkVC75ZgHr+gAxgj6wOelVi07zBBsoHy4QoCavd1tFhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234249; c=relaxed/simple;
	bh=C7qO8ilSSs08z7vZpD+E5iuwRGqmmu8YkmRRPZ1SvJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfm07B6fZc/kLeLzy0J0Fmzif4C8lrqULL/7O3UPGcxkPDqHQTeAlvj3KkytuIoJ7+Cib+YtxpBTUQanEFdvtrNlifDEJCS1EKPxwvomfc/1cOE7Pwzts0Tx/vFmrrVZlcQ3qS26fR2BohFgF3SCivpcnaMdG6sTqokp9/tMs2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsOLyXdO; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsOLyXdO"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52f9fc510e1so4628241cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790234245; cv=none;
        d=google.com; s=arc-20260327;
        b=JZnqWkQQx4uJhuYQ3l7nug/3tz4K6Yyquwm/8yoMp9HN9RRGteXKZvRSpYtUC14pQy
         Whble6tXh5VxP29VtJN/hveQZP5vWu2xQrM6R2S5QguOJqVLLUfJhPn9/bezAKcc4Zkx
         qbze9S+TVmbckQEv9laqWbeIZ9Zv58OiPtGqoTvRVpdM/GOR6YrUXUhpfb+vjmu6T073
         ncUtD2azcivFZd5hFnDpqdHYlsJmr2Z8dAwqf1EIi7LPiRiIRoRqRftXqpNYadLkUf63
         IWbcMShlwDMrCznEZKFYEqEka/ZkUvtqjNmV7a0y5N0o72Gp67lNSu7HaqEr5UV9MX1y
         CuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfkLFnuq2QF6pxeekjThITQmyU3vX4le2bGY3StAw3w=;
        fh=emzVM+x+XVvHMeSd3CfSjrRipPZq6GqItAQ66AdlZpg=;
        b=bd9h+W3JwMb8DnKEQ/iMXFvSZXkUKcD+UTjetgv0pkNrpPwJcADhymmXp8Sd6kILSK
         k+LTKhGKJg28EZm9GmQwZTA4K4S8edRT+rPdcvIxFbrqCQyzvCRfW8vBqlTWx5kdI+Oo
         if/vWoNrplmHM99V4V2otwqCTSRZHR0Xl6JGZkyf7v2WTWnp1WUG7Ho3Q7WAO9/uppPw
         v26/0bCvnE6ldwOBMAZ8NUX6IZnCGlAU/kRP+cZkvjBgZ2OCLnl7OUPC3OiunS4/6wP1
         w0BIab5lYe4oYwRdlegpr5rblQbjeSwSU+ee+ykgJ2tYKoUi8RhDZFTDLFiBUO3GbIXh
         8LYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790234245; x=1790839045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfkLFnuq2QF6pxeekjThITQmyU3vX4le2bGY3StAw3w=;
        b=tsOLyXdOI336DiTpf2IoA1cFQlozSjHCr2zOh9dNa807l5kSNZUrgDNcqf9E7jyU09
         tK3cByS0+CLt3C5bOdKNXSdFjFan25V7fgbvm7qzx/55+UwgRvv6/X+Ot68f7syVxLAu
         b7n3ClbkHSVdcw+opxZbhwiA7U4Chk4PeRdFhXUxZjv2IEm0PT+0y7P9HTpndl1R/JBN
         iDCGV686ux+BvZwBtjiuNCaNXJB6J1jsxBr79lVXVF/G3Nx3zOPNr/xyxHY/lZLSJeM3
         WOGpnFGEMEFZj19J8rAufgtobWRJlTDaVYTZmgrwVa6MMAMKJTz/j1a/+eJFTbiKNmtu
         TXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234245; x=1790839045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfkLFnuq2QF6pxeekjThITQmyU3vX4le2bGY3StAw3w=;
        b=zjrDVLGibevJw1Y2kB+SGrlgB+PgDspwFB6cXrPXwpOgMVLkwKn/zeV5AdQ74CzDzw
         YDvvBmUTC1iAEL1HLydMbCbkhiinlqPVPAIxxNc3AnRBkglV3MrWNag8Sbs3item2Atc
         cdsssJbx6o16qPpsQ8/DhjCV6/vPVPaohi2S8Qm7pmjN21kJ1t1LQHvKxgO8uU3vLRvr
         mJyp8F/iSqQfUgkNCEMQreR5OAAWMGfl4NbsVZuBi7yA+U4miXcp9g2lhbWdHbmyTbbZ
         IbBH1+6C3NO2okVMc6FVXKvTAkDkE+lcewOJlDkgNyOYMhk4D2I7zBmdLTfygxt0X+BR
         AV/g==
X-Gm-Message-State: AFuF++maMRdEFpH0JC6gHF4P7BfrkMsRqQVMqCK8zLdn/64vaevq7YqH
	Lfs9nGifADwnfGzoFRVnvgD4SIzE9FXA333uMMdCR8K/p6jeizZWQ8QDFYkZlmArvwM+hnhsTHJ
	/A0btOAPBmXdotmaNQuCOmfdbtq+R2fD3WOESSDBK
X-Gm-Gg: AYBFou0KPJS2m+grGlIa0IeUPeaK5fr95+RWPtzPFDb0qLe86Ng6fbBS0nH651Dexds
	zzl5Ic9YGSix1r3agSwWHxOkwWJmpoB7gLInYnTH3trTdw4JFR22WvBTfdIHvlIQChmeSfhMvIX
	87gtw/D6iZgs7NfimDr5om7mMPP1/jr95uKYCpi+6vo3jMA/zAevOV+6uLRgg/dW/5d3iCPTXFF
	w7QnmP5p2vZbHqKqH0C5wRu2oUq7X+bXwAWYaNCd6Kg0wQbCt5/x6x/Wr4+fvYeQwMVVKt/sjJq
	zxLjOVSOXgpYu4tDZj9Rvnn+Ohg6IaIWPntqpOBPCoxSqCrvGN/dwTqPyn9+Zhii1rIgMZFNnQV
	YsCwWUisybSyVndMVxVnBvK2OhoQWyTjMm6ahp7NYJ2RnyCnM8+x0yaI4fkcn45mMH7yU
X-Received: by 2002:a05:622a:4010:b0:532:b087:7335 with SMTP id
 d75a77b69052e-532feace7a1mr10751341cf.17.1790234244504; Thu, 24 Sep 2026
 00:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790136447.git.caoruide123@gmail.com> <f0d62dc44f984114abe09f9b1d0432c98de7dbbf.1790136447.git.caoruide123@gmail.com>
In-Reply-To: <f0d62dc44f984114abe09f9b1d0432c98de7dbbf.1790136447.git.caoruide123@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Sep 2026 09:17:12 +0200
X-Gm-Features: AclHuK_l_pdbmUwCHlrOZBbNh6HZTo7A3R8K431aCvI_CCxdhpiw7CTFKaOfyxo
Message-ID: <CANn89i+ptgaLdeOW+x_xTyanGo54KTxH0yo2tNpNpv1Bwe-vJQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] l2tp: bound the reorder queue
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org, kuniyu@google.com, 
	alice.kernel@fastmail.im, michael.bommarito@gmail.com, mail@david-bauer.net, 
	jchapman@katalix.com, vega@nebusec.ai, caoruide123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:33=E2=80=AFAM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Ruide Cao <caoruide123@gmail.com>
>
> The receive-window check accepts every sequence number in the large
> window. If the peer omits the expected packet, distinct future packets
> can therefore fill the ordered reorder queue. Since insertion walks the
> queue and expiration was checked only while receiving another packet,
> this allowed unbounded memory and CPU use.
>
> Reject duplicate sequence numbers and cap the reorder queue at 64
> packets. Packets beyond the cap are discarded, except that the expected
> sequence number is admitted so an in-order packet can drain the queue.
> The existing timeout recovery then skips a missing sequence number when
> the queue limit is reached.
>
> Use a session timer to run the existing dequeue path at the head
> expiration and shut it down before purging a session. This bounds the
> queue and services expiration even when the peer stops sending.
>
> Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  net/l2tp/l2tp_core.c | 57 +++++++++++++++++++++++++++++++++++++++++---
>  net/l2tp/l2tp_core.h |  2 ++
>  2 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index f940914959b1..c92d4392f9b0 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -82,6 +82,7 @@
>  #define L2TP_SL_SEQ_MASK   0x00ffffff
>
>  #define L2TP_HDR_SIZE_MAX              14
> +#define L2TP_REORDER_MAX_QUEUE 64
>
>  /* Default trace flags */
>  #define L2TP_DEFAULT_DEBUG_FLAGS       0
> @@ -637,7 +638,22 @@ static void l2tp_recv_queue_skb(struct l2tp_session =
*session, struct sk_buff *sk
>         u32 ns =3D L2TP_SKB_CB(skb)->ns;
>
>         spin_lock_bh(&session->reorder_q.lock);
> +       if (skb_queue_len(&session->reorder_q) >=3D L2TP_REORDER_MAX_QUEU=
E &&
> +           ns !=3D session->nr) {
> +               atomic_long_inc(&session->stats.rx_seq_discards);
> +               atomic_long_inc(&session->stats.rx_errors);
> +               kfree_skb(skb);
> +               goto out;
> +       }
> +
>         skb_queue_walk_safe(&session->reorder_q, skbp, tmp) {
> +               if (unlikely(L2TP_SKB_CB(skbp)->has_seq &&
> +                            L2TP_SKB_CB(skbp)->ns =3D=3D ns)) {
> +                       atomic_long_inc(&session->stats.rx_seq_discards);
> +                       atomic_long_inc(&session->stats.rx_errors);
> +                       kfree_skb(skb);
> +                       goto out;
> +               }
>                 if (L2TP_SKB_CB(skbp)->ns > ns) {
>                         __skb_queue_before(&session->reorder_q, skbp, skb=
);
>                         atomic_long_inc(&session->stats.rx_oos_packets);

1) When a single packet is lost (ns =3D=3D session->nr), all subsequent
   packets (nr + 1, nr + 2, ...) arrive in ascending order. Walking
   reorder_q from the head means every packet after a single drop walks
   the entire queue only to be appended at the tail.
   Walking backwards with skb_queue_reverse_walk_safe() (or checking
   skb_peek_tail() first) makes the common in-order-after-gap insertion
   O(1).

2) In the same loop:
   - L2TP_SKB_CB(skbp)->ns is only valid if L2TP_SKB_CB(skbp)->has_seq
     is set. Unsequenced packets can be queued to reorder_q in
     l2tp_recv_common() without initializing CB->ns. You guarded the
     equality check with has_seq, but not the '>' comparison right
     below it.
   - 'L2TP_SKB_CB(skbp)->ns > ns' does not handle sequence number
     wrap-around (16-bit for v2, 24-bit for v3). A modular comparison
     using session->nr_max / session->nr_window_size should be used
     here.

> @@ -651,6 +667,20 @@ static void l2tp_recv_queue_skb(struct l2tp_session =
*session, struct sk_buff *sk
>         spin_unlock_bh(&session->reorder_q.lock);
>  }
>
> +static bool l2tp_recv_queue_tail_skb(struct l2tp_session *session,
> +                                    struct sk_buff *skb)
> +{
> +       spin_lock_bh(&session->reorder_q.lock);
> +       if (skb_queue_len(&session->reorder_q) >=3D L2TP_REORDER_MAX_QUEU=
E) {
> +               spin_unlock_bh(&session->reorder_q.lock);
> +               return false;
> +       }
> +       __skb_queue_tail(&session->reorder_q, skb);
> +       spin_unlock_bh(&session->reorder_q.lock);
> +
> +       return true;
> +}
> +
>  /* Dequeue a single skb.
>   */
>  static void l2tp_recv_dequeue_skb(struct l2tp_session *session, struct s=
k_buff *skb)
> @@ -687,6 +717,7 @@ static void l2tp_recv_dequeue_skb(struct l2tp_session=
 *session, struct sk_buff *
>   */
>  static void l2tp_recv_dequeue(struct l2tp_session *session)
>  {
> +       bool dequeued =3D false;
>         struct sk_buff *skb;
>         struct sk_buff *tmp;
>
> @@ -706,6 +737,7 @@ static void l2tp_recv_dequeue(struct l2tp_session *se=
ssion)
>                         trace_session_pkt_expired(session, cb->ns);
>                         session->reorder_skip =3D 1;
>                         __skb_unlink(skb, &session->reorder_q);
> +                       dequeued =3D true;
>                         kfree_skb(skb);
>                         continue;
>                 }
> @@ -720,6 +752,7 @@ static void l2tp_recv_dequeue(struct l2tp_session *se=
ssion)
>                                 goto out;
>                 }
>                 __skb_unlink(skb, &session->reorder_q);
> +               dequeued =3D true;
>
>                 /* Process the skb. We release the queue lock while we
>                  * do so to let other contexts process the queue.
> @@ -730,9 +763,22 @@ static void l2tp_recv_dequeue(struct l2tp_session *s=
ession)
>         }
>
>  out:
> +       if (skb_queue_empty(&session->reorder_q))
> +               timer_delete(&session->reorder_timer);
> +       else if (dequeued || !timer_pending(&session->reorder_timer))
> +               timer_reduce(&session->reorder_timer,
> +                            L2TP_SKB_CB(skb_peek(&session->reorder_q))->=
expires);
>         spin_unlock_bh(&session->reorder_q.lock);
>  }
>
> +static void l2tp_recv_dequeue_timer(struct timer_list *timer)
> +{
> +       struct l2tp_session *session =3D timer_container_of(session, time=
r,
> +                                                        reorder_timer);
> +
> +       l2tp_recv_dequeue(session);
> +}
> +
>  static int l2tp_seq_check_rx_window(struct l2tp_session *session, u32 nr=
)
>  {
>         u32 nws;
> @@ -774,7 +820,8 @@ static int l2tp_recv_data_seq(struct l2tp_session *se=
ssion, struct sk_buff *skb)
>          * sequence number to re-enable packet reception.
>          */
>         if (cb->ns =3D=3D session->nr) {
> -               skb_queue_tail(&session->reorder_q, skb);
> +               if (!l2tp_recv_queue_tail_skb(session, skb))
> +                       goto discard;
>         } else {
>                 u32 nr_oos =3D cb->ns;
>                 u32 nr_next =3D (session->nr_oos + 1) & session->nr_max;
> @@ -793,7 +840,8 @@ static int l2tp_recv_data_seq(struct l2tp_session *se=
ssion, struct sk_buff *skb)
>                         trace_session_pkt_oos(session, cb->ns);
>                         goto discard;
>                 }
> -               skb_queue_tail(&session->reorder_q, skb);
> +               if (!l2tp_recv_queue_tail_skb(session, skb))
> +                       goto discard;
>         }
>
>  out:
> @@ -986,7 +1034,8 @@ void l2tp_recv_common(struct l2tp_session *session, =
struct sk_buff *skb,
>                  * reorder queue. This ensures that it will be
>                  * delivered after all previous sequenced skbs.
>                  */
> -               skb_queue_tail(&session->reorder_q, skb);
> +               if (!l2tp_recv_queue_tail_skb(session, skb))
> +                       goto discard;
>         }
>
>         /* Try to dequeue as many skbs from reorder_q as we can. */
> @@ -1748,6 +1797,7 @@ static void l2tp_session_del_work(struct work_struc=
t *work)
>                                                     del_work);
>
>         l2tp_session_unhash(session);
> +       timer_shutdown_sync(&session->reorder_timer);
>         l2tp_session_queue_purge(session);

3) l2tp_session_unhash() does not wait for in-flight readers that
   already grabbed a session refcount via l2tp_session_get() before the
   unhash. Such a reader can enter l2tp_recv_common() after
   timer_shutdown_sync() and l2tp_session_queue_purge() have already
   run, queueing an skb onto reorder_q that will never be freed when
   session is kfree_rcu()'d in l2tp_session_free().
   Please either check session->dead under reorder_q.lock before
   queueing, or call l2tp_session_queue_purge() in l2tp_session_free()
   as well.

>         if (session->session_close)
>                 (*session->session_close)(session);
> @@ -1804,6 +1854,7 @@ struct l2tp_session *l2tp_session_create(int priv_s=
ize, struct l2tp_tunnel *tunn
>                         tunnel->tunnel_id, session->session_id);
>
>                 skb_queue_head_init(&session->reorder_q);
> +               timer_setup(&session->reorder_timer, l2tp_recv_dequeue_ti=
mer, 0);
>
>                 session->hlist_key =3D l2tp_v3_session_hashkey(tunnel->so=
ck, session->session_id);
>                 INIT_HLIST_NODE(&session->hlist);
> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
> index ffd8ced3a51f..6e4c1ef6a0a2 100644
> --- a/net/l2tp/l2tp_core.h
> +++ b/net/l2tp/l2tp_core.h
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2008,2009 Katalix Systems Ltd
>   */
>  #include <linux/refcount.h>
> +#include <linux/timer.h>
>
>  #ifndef _L2TP_CORE_H_
>  #define _L2TP_CORE_H_
> @@ -80,6 +81,7 @@ struct l2tp_session {
>         u32                     nr;             /* session NR state (rece=
ive) */
>         u32                     ns;             /* session NR state (send=
) */
>         struct sk_buff_head     reorder_q;      /* receive reorder queue =
*/
> +       struct timer_list       reorder_timer;
>         u32                     nr_max;         /* max NR. Depends on tun=
nel */
>         u32                     nr_window_size; /* NR window size */
>         u32                     nr_oos;         /* NR of last OOS packet =
*/
> --
> 2.47.3
>
