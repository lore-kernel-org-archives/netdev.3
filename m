Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1E43B3F5
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862173; cv=pass; b=u6mFiiOGv41niAji2MlFJxgVXzf55hNrjS+Z3KufcgjOaxDjN5yu2MKUydhMHHLDiiCtOx9zoNEoGJy2+XhiTDREDYp+OP0ne1qQrDGH3Mo7oUPUVYGzOQHKsTPIK3HpbtpQTf8gazCCWdO3maMx2WnoRQQoj4L71/R9APrtBsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862173; c=relaxed/simple;
	bh=+tf5KT/LBLH9dUzbsqRGcwYkkoel0brUJOereQ+cnFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgskVzoBAwC7ypa5gqUrlSOfgEXs20J3ObdybqVw0m0py83VOjOb9QVGECEi8RSKLRl4lurdZ8ol2ZXoglhZGgVpIdzc3nZEOyCLlReFgVpdKS3Xc9yHwSWwzJrpbk+85GDntq0Y/6DXksFogOM465CGuLc1V5BhCUMPaKkzoA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6SfeQAs; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6SfeQAs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e76469b93so142520285a.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862170; cv=none;
        d=google.com; s=arc-20260327;
        b=Sx3AyQUrZBiVS5OQj3WSIWXs+hUF+cszoSvk3Kd6Goa4RcGgZpnLI94BtRSTkXPNHu
         VD4D83N3dhSOD1N/ATbceSWIXQw70+AT4m8yfAWO0rtOYVzKapVqcEVVvp/t7ADQ/7C4
         j4/se2MEQJ5DE6A2dX7DjxetUTstit82d3AuiQ5+kZ9jevLH33iBRt5G3CbQATZ55CrC
         20WE6gVurnMNGuVD1kPx+XAfvXS5GSqP5cUedJUxHb3Xcpby2TZswl0B9l/p5Btj01A/
         GXjlBkvd+wJUc6qVe7DbZFd6ak4gt22Zy/QQb8QHTwrL44GlVApiczoTGKjvwk/g97xC
         sylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        fh=tO2J31AN0zQun/Ddt3DRGTE/UqLMxWLaD8ih1WJQEU4=;
        b=YGMRJw7q9H/w7faHQIdLbk3hCxG39IXW/XfU1pkb/0xS5k03vXehCioiN3aealH9RV
         LVwbjSoAjYcG9b+FgzeFdEsywyzTDdBfDOoB34uJxcTLhnMFkC6VDBnLlCCaE5iUFsCM
         O4qiuPSrRaK8S3MLWbDI/d9MGW5bj030/HT8uETrYF+Nf65wN+nIsA0slSzUTbRvGhn5
         e6H0IB/z2rxRdhmmklAxWbl9FuSMz6VdLu7QU8kTd9DIChE06DARNe2ju8mMwRI3WBTp
         tTEVhsk4epzTeHGjZqDY5qyZRkRcFVe1FKgGYFKlRudTvZCTPzuT9x5dYRDBW6/yEBwJ
         cBLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862170; x=1792466970; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        b=S6SfeQAsRznvcTlaSmLaDbAYbgy2VgLgpsPLtljYWnDF2AP58kABPuIl7OFfs1+iF7
         SDxRSCifT94U68SzRAvy8o84DMAsbtM/fSbs+V1reKM+rWZVoKXj+anwn8RLr8ph/Vvb
         dX1x/lmM9xW686hGWpH992rqzr2/ltfd3Cg7UO/ZDJ+Jo9EdDPPAcc2QCA7eD1DJ8GYR
         cJ+57wdFxJBUANOSov77Fsqz+OSoe+r8vHSRWMuR505wRRrrpXP8AE5VYQl5s6XoY7cg
         oqpDih5n0AcZysiR2PQJwQFNJD6qOs1FQpb+YVmEbiVDdzjItJuqXTQowHeE8+hSZjmE
         bfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862170; x=1792466970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pjpZB2jPs3cIEERlTXUY/rEvSbEEM3b+tieI1aC2ttk=;
        b=msAYsyMUBLR12bnYeGjtDSnx9YKgB6qpzK718ohtYvwS9TAi0T4hcYSwq7Yc+6P8o+
         McNeaxPAuCq2JtVR8Id99SJqKp8QdKcJH1x7RCgZKyS7Rr9q/lZz9jgQSnTobQH1EqBw
         Hb/g47eZH4HmfrJq7Vil6WEKs8jHbZ6iCn3C7M0zUIgI1CI87cOwSOPBzDR3Sg/5UPcC
         2E1H6z8VdgNmSnPFPzSeHqnZfuH2sBnc8BBKmbI7uRVGPjQWkqBgt4UBdquk+TYOL1iB
         Qp6pdWtuWHQldRKWMwMUqsD8atI2H7gKMD9yHNb2LWcPEHVuOoPdJ5arWCKjHd2HQc2O
         DQoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhmDPP5LngQqioeSgi/vkLrt6WM+jA3uODR526yea6bXmCs7J9QXyrLt0AxPx1iBZC4pgtDXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1/4OfvPgvWhzWG7LCgEEa7J8Sj+q1pxyt3Df7MmeWxIb4A1/j
	WgAlaftPOVH/zFtvGHds5Lwn0UJouws/V9mPj0eLh8wqN3rVfy02d4d+zXHMgZsLzMIoGj9wsEF
	UpzFa3kb7ayjnGXdxVHGddVzq3TzVqw9KcAoj
X-Gm-Gg: AYBFou0OCTEvXdNFCdSyGTKxOCt2GksvSGTHfSWKsmUEzZIjEOgUBlLQBoniBvsxtr3
	Npocb7C1vNWjrFjfB6GTSaxXUkbmZfYaTuyekO3eLO8KLA1MnZadAARh3b3IqcTtima6LAvsVFA
	IoYxKZOV4iWdQXOUamDReAQW+OEb3p9Myhj7tQ//4/PSvDaoAU8vAooT6lhVGdt9oRQg+uJodah
	3kjO6SgcIgAVZyGmq2t1oPjzLXsEy5eG6gaD0XIooiyxQZV2WD0PA40Lv+ZgP3KrC6XgOkxwH8S
	/cK/xWnJqKG7uEtnuWsbdVnL8IX+8VprpE5xC97dLjdLlT8DJ860Uwg=
X-Received: by 2002:a05:620a:2591:b0:93b:d7a3:45d4 with SMTP id
 af79cd13be357-93ebd29c0bcmr1838496485a.61.1791862169689; Mon, 12 Oct 2026
 20:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-3-physicalmtea@gmail.com> <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
In-Reply-To: <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:28:53 +0800
X-Gm-Features: AclHuK8y1cO0AT-SrEL4DpgMypGTtpHkPFcgXXXujBQ_ReOHft-UeQLoN7blnMU
Message-ID: <CAJwVaM+Mht=DiODUJHzokkpGMjcBW9caHh6+Em1+-J-C-_25Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking
 for stream packets
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:44PM +0800, Jia Jia wrote:
> > The virtio-vsock RX worker currently acquires and releases the socket lock
> > for every received packet. Keep the lock held while processing a bounded
> > run of packets that belongs to the same socket.
> >
> > Only ordinary RW packets for an established STREAM socket whose transport
> > and protocol remain unchanged are eligible. Control packets, SEQPACKET
> > traffic, state or transport changes, malformed packets, and sockets whose
> > protocol has been replaced end the active batch and retain their existing
> > handling.
> >
> > Serialize the initial eligibility check with sk_callback_lock because
> > sockmap removal restores the protocol without taking the socket lock.
> >
> > Limit each batch to 64 packets or 64KB of payload, bounding the work under
> > one socket lock. Keep the lookup reference until the batch finishes.
> >
> > Keep a batch only while another skb metadata charge fits in the receive
> > buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
> > enqueued skb consumes the final metadata slot, finish the batch and release
> > the socket lock before processing another packet, restoring the reader's
> > scheduling opportunity from the per-packet path.
> >
> > The virtqueue callback remains a queue_work() callback. Batching runs only
> > in the process-context RX worker.
> >
> > Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> > release the socket lock and lookup reference.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  11 ++
> >  net/vmw_vsock/virtio_transport.c        |  29 ++++-
> >  net/vmw_vsock/virtio_transport_common.c | 147 +++++++++++++++++++++++-
> >  3 files changed, 183 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index f91704731057..26dde6909c4e 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
> >
> >  void virtio_transport_recv_pkt(struct virtio_transport *t,
> >                              struct sk_buff *skb, struct net *net);
> > +
> > +struct virtio_transport_rx_batch {
> > +     struct sock *sk;
> > +     unsigned int pkts;
> > +     size_t bytes;
> > +};
> > +
> > +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > +                                  struct sk_buff *skb, struct net *net,
> > +                                  struct virtio_transport_rx_batch *batch);
> > +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
> >  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> >  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> >  void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 4f9aa9c4c3aa..ef076732158d 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> >       return seqpacket_allow;
> >  }
> >
> > +/*
> > + * Keep a bounded run of packets for one socket under a single socket lock.
> > + * Limit packet count and payload size to bound the work done while locked.
> > + */
> > +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS   64
> > +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES  (64 * 1024)
>
> Why both? Seems like MAX_PKTS would sufficiently bound the lock hold
> time.
>
> > +
> >  static void virtio_transport_rx_work(struct work_struct *work)
> >  {
> > +     struct virtio_transport_rx_batch batch = {};
> >       struct virtio_vsock *vsock =
> >               container_of(work, struct virtio_vsock, rx_work);
> >       struct virtqueue *vq;
> > @@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       /* Drop short/long packets */
> >                       if (unlikely(len < sizeof(*hdr) ||
> >                                    len > virtio_vsock_skb_len(skb))) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> > @@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       hdr = virtio_vsock_hdr(skb);
> >                       payload_len = le32_to_cpu(hdr->len);
> >                       if (unlikely(payload_len > len - sizeof(*hdr))) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> >                               kfree_skb(skb);
> >                               continue;
> >                       }
> > @@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
> >                       if (payload_len)
> >                               virtio_vsock_skb_put(skb, payload_len);
> >
> > +                     if (batch.sk &&
> > +                         payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
> > +                                       batch.bytes) {
> > +                             virtio_transport_rx_batch_finish(&batch);
> > +                     }
> > +
> >                       virtio_transport_deliver_tap_pkt(skb);
> >
> >                       /* Force virtio-transport into global mode since it
> >                        * does not yet support local-mode namespacing.
> >                        */
> > -                     virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> > +                     virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
> > +                                                     &batch);
> > +
> > +                     if (batch.sk) {
> > +                             batch.pkts++;
> > +                             batch.bytes += payload_len;
> > +                             if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
> > +                                 batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
> > +                                     virtio_transport_rx_batch_finish(&batch);
>
> I'm not fundamentally opposed to the batch struct, but I wonder if its
> needed?

With the byte limit retained, the batch still needs to carry the
socket and both counters across calls. A batch may also be finished
inside the receive helper, so
keeping that state together avoids having the worker maintain a
separate counter that can get out of sync. The later notification
patches add their pending state to the
same object as well, so I would prefer to keep the batch struct.

> If we can get rid of BATCH_MAX_BYTES, then we only need to do
> pkts++ in a local var, and can pass an &sk ptr-ptr to
> virtio_transport_recv_pkt_batch()?
>

My thinking was that the two limits bound different things. The
64-packet limit bounds per-packet work for small packets, while the
64K limit bounds how much data can
be queued while the reader cannot acquire the socket lock. A single
packet can carry up to 64K, so a packet-only limit could let one batch
cover as much as 4M. Since
the receive buffer can be enlarged, I do not think the default 256K
buffer is a substitute for the byte limit. I would prefer to keep
both.

> Best,
> Bobby
>
> > +                             }
> > +                     }
> >               }
> >       } while (!virtqueue_enable_cb(vq));
> >
> >  out:
> > +     virtio_transport_rx_batch_finish(&batch);
> >       if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> >               virtio_vsock_rx_fill(vsock);
> >  out_nofill:
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e3e75e59896f..a73e37b3fa62 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> >       skb_queue_splice(&new_queue, &vvs->rx_queue);
> >  }
> >
> > +static bool
> > +virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
> > +{
> > +     return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
> > +             vvs->buf_alloc;
> > +}
> > +
> >  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >                                       u32 len)
> >  {
> > -     u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> >
> >       /* Allow at most buf_alloc * 2 total budget (payload + overhead),
> >        * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> > @@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> >        * queue growth.
> >        */
> >       if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> > -         skb_overhead > vvs->buf_alloc)
> > +         !virtio_transport_rx_skb_has_headroom(vvs))
> >               return false;
> >
> >       vvs->rx_bytes += len;
> > @@ -1834,10 +1840,28 @@ struct virtio_transport_rx_pkt_ctx {
> >       struct net *net;
> >       const struct sockaddr_vm *src;
> >       const struct sockaddr_vm *dst;
> > +     bool *batchable;
> >  };
> >
> > +static bool
> > +virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> > +                                 struct sock *sk)
> > +{
> > +     struct vsock_sock *vsk = vsock_sk(sk);
> > +     struct virtio_vsock_sock *vvs = vsk->trans;
> > +
> > +     return sk->sk_state == TCP_ESTABLISHED &&
> > +            sk->sk_type == SOCK_STREAM &&
> > +            READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> > +            !sock_flag(sk, SOCK_DONE) &&
> > +            vsk->transport == &t->transport &&
> > +            vvs && virtio_transport_rx_skb_has_headroom(vvs);
> > +}
> > +
> >  /*
> > - * The caller holds sk's socket lock and must free skb if this returns true.
> > + * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> > + * locked for another ordinary STREAM/RW packet.  Return true if the caller
> > + * must free @skb.
> >   */
> >  static bool
> >  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > @@ -1850,6 +1874,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >       struct net *net = ctx->net;
> >       bool space_available;
> >
> > +     if (ctx->batchable)
> > +             *ctx->batchable = false;
> > +
> >       /* Check after acquiring the socket lock. Listener sockets accept packets
> >        * from any source and are not assigned to a transport.
> >        */
> > @@ -1891,6 +1918,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >               break;
> >       }
> >
> > +     if (ctx->batchable)
> > +             *ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
> > +
> >       return false;
> >  }
> >
> > @@ -1941,6 +1971,117 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> > +/*
> > + * Finish the RX batch.
> > + * For a non-empty batch, the caller must hold the socket lock acquired with
> > + * lock_sock(). This function releases the lock and the batch's lookup
> > + * reference.
> > + * An empty batch is a no-op.
> > + */
> > +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> > +{
> > +     struct sock *sk = batch->sk;
> > +
> > +     batch->sk = NULL;
> > +     batch->pkts = 0;
> > +     batch->bytes = 0;
> > +
> > +     if (!sk)
> > +             return;
> > +
> > +     release_sock(sk);
> > +     sock_put(sk);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> > +
> > +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > +                                  struct sk_buff *skb, struct net *net,
> > +                                  struct virtio_transport_rx_batch *batch)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     bool batchable, start_batch;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     /* Only STREAM/RW packets can share a socket lock. */
> > +     if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
> > +         le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +             virtio_transport_recv_pkt(t, skb, net);
> > +             return;
> > +     }
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > +     if (!sk) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +             virtio_transport_rx_batch_finish(batch);
> > +             kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     if (batch->sk && batch->sk != sk) {
> > +             /* Never acquire a second socket lock. */
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> > +     if (batch->sk == sk) {
> > +             /* Keep the batch reference; drop this packet's lookup reference. */
> > +             sock_put(sk);
> > +             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                     .net = net,
> > +                     .src = &src,
> > +                     .dst = &dst,
> > +                     .batchable = &batchable,
> > +             };
> > +             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +             if (!batchable)
> > +                     virtio_transport_rx_batch_finish(batch);
> > +             if (free_pkt)
> > +                     kfree_skb(skb);
> > +             return;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     /*
> > +      * Sockmap removal restores the native protocol under sk_callback_lock.
> > +      * Serialize this initial eligibility check with that update.
> > +      */
> > +     read_lock_bh(&sk->sk_callback_lock);
> > +     start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> > +     read_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +             .net = net,
> > +             .src = &src,
> > +             .dst = &dst,
> > +             .batchable = start_batch ? &batchable : NULL,
> > +     };
> > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +     if (start_batch && batchable) {
> > +             /* Keep the lookup reference until the batch is released. */
> > +             batch->sk = sk;
> > +             return;
> > +     }
> > +
> > +     release_sock(sk);
> > +     sock_put(sk);
> > +     if (free_pkt)
> > +             kfree_skb(skb);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
> > +
> >  /* Remove skbs found in a queue that have a vsk that matches.
> >   *
> >   * Each skb is freed.
> > --
> > 2.34.1
