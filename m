Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278A319871
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791509308; cv=pass; b=pi5rX1WMkamhBn4TTG9cPHcApZ8zGptyY8xpZrsk6OiDDsNJ2C2x5s/Fyw4iGYN9bOeZyjn5VmU/WTfSadJsobr7yjEKqcwIk5LcrEDrghucbWOElLFvSVIXQ2V+MqN3hFsWL+hgdvvJVjS5RjRDrzGay2SU5AMUvhGP4PGhX9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791509308; c=relaxed/simple;
	bh=XMa0oWP8WwisJDM0Y3bLC1+ONt4wpusAT8/XsdyqfBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WISqQbpIDepr8GsYpoEU6K7fTqcsbF+xWrC4FiEgVlPcTZm0O5Bwo8MkNWr4mR5iOsz0Ygpk7M0CB+71sJ8WK19mRVekvPs/MX1Y8vugBGRUvXaBIv9gCMuY0wJfgj8HzcB9WtJ+EvZhMpRoomIXvtwuqNOJ/JJen8sim8YdvqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILvudVEa; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILvudVEa"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-884062f3296so2355376b3a.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 18:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791509306; cv=none;
        d=google.com; s=arc-20260327;
        b=NzrT5wnfB1fSREXCC6WOm/FOHzf7vZyLBgxZD6LGiJQnGNiP7RHAXqFa36D+9HRoS7
         1RlL+GbxcTpln5MzHh7iAdxiRNlSDUgBSmB2Qx/k85EXXphj9E8aKRy6O4RIYA+PayhJ
         AOpkG6ovJqC8KWLI84KV0MLH9t0O0z4VTVfdXCL0VKegrCrIZDVsDnac9hF0aYKlwLWU
         dCnHD82s224+MnvSWWGhbQAwCuwCUECbH39JEJSUlEbEpHwveUFSf2p5xgBoO0xqPQhh
         oSqVF4LnVu6nHUGD1f22/w37jGy/RyV+DKkGssjUuBuVmpYiP2JTcX44FJ4enAxKx8fQ
         F3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VJ5H5G50ATCR6DhtkjxgOK/BdPUHl43Tg816ttjnhnM=;
        fh=FcywtlDZoDkM4edKsFlp1mDZyBkJFKZZqzJffsc2CVg=;
        b=QpGHkD5afVtHixA6MQClVj61lK53jDdMhU9XWKWhchtCPJyccOqOlLkAh5jQxMgTFV
         ugieQuMiU0uc4NuWaTeWQyyFMWRUMKvBiSPXsgfERdCPJPJ/BWe4Urz1gSDzRoZWj+I2
         6q3ARb8/j1TMutyVJRRbos/ffS3/PdXW+vL+TyVq31u7ifzYDt0BLKJm4v55pUAyPFN/
         QJVykIwKE5PATwWh+COsrCxhvKOvSU+8HmtwRaYfjEMIDcszD5dS/N+NDdhp7oubkioq
         j0lskNUe/jR8bBPynOy535iXqsKiyxOFYPTNW9UhP8PWy/LXklM8jZ/ceGfjvlD2CRl8
         sxJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791509306; x=1792114106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VJ5H5G50ATCR6DhtkjxgOK/BdPUHl43Tg816ttjnhnM=;
        b=ILvudVEagFJt2UimDwF6ADSBBtKIPhqKkfN2+NjdooADC4SJpUCzJRVYASK1PYRb36
         /X7/q/fS/mQPsCul59eY4oz1rC+7BnNv5e6ApDSXV14J4Dcxv1n5yFFc8/TdpGUVbCvy
         Vwti4TcfSTQ5/k3WEpYhZFXQTSGZaxChw2Qs7Vii+w3wEn+i4AMuZTwOkpzqb8zd1NF4
         S0OVWXP2O2wrC7aA3fDbs4WRMTyp5EYOCLSLPIvANtNUPqVNVdvZ/8+3NjEaC4zT25hh
         HUuDIHANp1XnoW8B30liW5BUzrui7KSkENODzc1pSSb3kpjHVtYO3s+r+Svul5uWwCEj
         HkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791509306; x=1792114106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJ5H5G50ATCR6DhtkjxgOK/BdPUHl43Tg816ttjnhnM=;
        b=GEcdCfI+aFXkBYnHLOXiFP/X8zbqcGTwm/+ypM1TDmoImR77YGzy8Sk6x5ZvJV6aRw
         X6ygUkXsK/3kksEtfE/kEp2ySnKy9gb9qfvmzqBL12QCz9RJwCEsqI+xHiwBMtD3DYuo
         Vs+/TMOdGk5suBlOwyp5+UdD1oBBBaQfTOSdB11WD5RrFy12U17jFeYGq78pc7AgZdsr
         T/5SB3hEjlSrpXaNbziCgoniflbIggT+6DqYVl+CXP5vbey5h5AfqEHASnnQQwjHez5d
         nnPPbMp58Ldo840LaBqSwSG5PC2UAnqzwP+qss/hUMIjWltMYWnCebrmgfgUvG8GpOUA
         n/cA==
X-Gm-Message-State: AFuF++lfMgclppjlXoTqdyZG+E5nbNzaz5wqOVwAWy6fw4Pi52eZnppC
	4qDJNCVxiDwUIDot+AK4IXeYqZpaZs35A/ud2N1WQ/fYPP2O01O7E06rnpqIYGShDl6+LKp8fmy
	I2A1werMWeBhLB4Dh5d5j4C//AZAaQXo=
X-Gm-Gg: AYBFou1SIqFRGzVQLw5CL7B0PL7kcFzX79+W+/UpOgZ50Vwz01PcWzU2fGBQ5zqtIP8
	dB8x7X4QyIE/zYMv5rCyk+MCsT1gxNdWc37Dbb9hB0j9zvc9Ow3lkixHzgQktOcEt8OIiSA65ap
	P760zSP7Ixmbg/vdANF9KZNmLkwZYFiHYhtqn0s8nVrCm6aTLi7EalvCH9Mqe8pXbtOKzjJ/iBp
	dxWxcen7g6v7xI/bcme8KUbNzI1fVdb4MdkhfFC5kDFMR40QM7vMDwVC2m4dzj6NGst9DQ+RuL7
	E3n2gMfHU6o5V+/dQl9byryuUoYJnJxwOxgQP8Sn7V/+Qlb4jBAHER3W/EeayyM250SAUxtydxM
	6UkM2bzfKm5qHdtH7OK5cCncDlW6ephNJuw0hE3DuOVJd2YD6yyoX
X-Received: by 2002:a05:6a20:430d:b0:3de:51e1:e7c1 with SMTP id
 adf61e73a8af0-3e16baa4b77mr279638637.3.1791509306166; Thu, 08 Oct 2026
 18:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a691d4ce8c646dd1d70f1c0f88f081ec30bd03a1.1791227050.git.lucien.xin@gmail.com>
 <179133510837.434549.10953579867468905208@kernel.org>
In-Reply-To: <179133510837.434549.10953579867468905208@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Oct 2026 21:28:14 -0400
X-Gm-Features: AclHuK-pXNUD0zZS35-RypI6zyh8BcFEPS1X53_XEgrT9cE9IlUL4Q1fx7i2pds
Message-ID: <CADvbK_e+wdmcEgY9coo_MY8v1WFPbZ1hP50vKXu7FCSHDTxR4g@mail.gmail.com>
Subject: Re: [PATCH net-next v16 06/15] quic: add stream management
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:05=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] quic_stream_init() (net/quic/stream.c) allocates the per-
>   socket 64-entry hlist_head table (512 bytes on 64-bit) with=E2=80=A6
> - [Medium] The per-socket stream table has a fixed 64 buckets and a
>   predictable, unkeyed hash, (stream_id >> 1) & 63 in quic_stream_head().
> - [Low] The uAPI header (include/uapi/linux/quic.h) puts send and receive
>   stream states in one anonymous enum, so the receive states start at 6=
=E2=80=A6
> - [Low] The comment above
>   bidi_blocked/uni_blocked/bidi_pending/uni_pending in struct=E2=80=A6
>
> --
>
> quic: add stream management
>
> This patch adds struct quic_stream_table, a per-socket hash table of
> struct quic_stream objects. It also adds helpers to get, create and put
> send and receive streams. It includes logic to check stream ID limits and
> to decide when MAX_STREAMS frames should be sent to the peer.
>
> > diff --git a/net/quic/stream.c b/net/quic/stream.c
> > new file mode 100644
> > index 0000000000000..c0bfaab0be8e2
> > --- /dev/null
> > +++ b/net/quic/stream.c
>
> [ ... ]
>
> > +#define QUIC_STREAM_HT_SIZE  64
> > +
> > +static struct hlist_head *quic_stream_head(struct quic_stream_table *s=
treams,
> > +                                        s64 stream_id)
> > +{
> > +     /* Skip the SERVER initiator bit, which is constant per endpoint.=
 */
> > +     return &streams->head[(stream_id >> 1) & (QUIC_STREAM_HT_SIZE - 1=
)];
> > +}
> > +
> > +struct quic_stream *quic_stream_find(struct quic_stream_table *streams=
,
> > +                                  s64 stream_id)
> > +{
> > +     struct hlist_head *head =3D quic_stream_head(streams, stream_id);
> > +     struct quic_stream *stream;
> > +
> > +     hlist_for_each_entry(stream, head, node) {
> > +             if (stream->id =3D=3D stream_id)
> > +                     break;
> > +     }
> > +     return stream;
> > +}
>
> [Severity: Medium]
> Can a remote peer put all of its live streams on a single chain here?
>
> The hash in quic_stream_head() is fixed and has no key. Bit 0 of
> (stream_id >> 1) is the uni bit, so bidi IDs land only in even buckets an=
d
> uni IDs only in odd ones. That gives each stream type 32 buckets, and
> every 32nd stream of a type maps to the same bucket.
>
> The peer decides which of its streams stay open. It could open streams up
> to the advertised limit and then finish or reset every stream except the
> ones that hash to one bucket. It then gets new credit through:
>
> quic_stream_put()
>     streams->recv.bidi_pending =3D 1;
> quic_stream_max_streams_update()
>     streams->recv.max_bidi_stream_id =3D max;
>
> If the peer repeats this, every live peer stream ends up on one hlist
> chain. That is up to recv.max_streams_*, which is 100 by default and up t=
o
> QUIC_MAX_STREAMS.
>
> Once the RX path lands, quic_stream_get() will call quic_stream_find() fo=
r
> each received STREAM, RESET_STREAM, STOP_SENDING and MAX_STREAM_DATA
> frame. Each lookup would then walk the whole chain under the socket lock
> in softirq. A single datagram can carry many small STREAM frames.
>
> Would a keyed hash (for example, seeded per socket), or a larger or
> resizable table, be worth considering? This lookup does not have an RX
> caller in this series yet.
>
True.

Passing net and using net_hash_mix(net) as seed should work.

> [ ... ]
>
> > +/* Create and register new streams for sending or receiving. */
> > +static struct quic_stream *quic_stream_create(struct quic_stream_table=
 *streams,
> > +                                           s64 max_stream_id, bool sen=
d,
> > +                                           bool is_serv, gfp_t gfp)
> > +{
>
> [ ... ]
>
> > +     while (stream_id <=3D max_stream_id) {
> > +             stream =3D kzalloc_obj(*stream, gfp);
> > +             if (!stream)
> > +                     goto free;
> > +
> > +             stream->id =3D stream_id;
>
> [ ... ]
>
> > +             stream->recv.window =3D stream->recv.max_bytes;
> > +             hlist_add_head(&stream->node, &head);
> > +             stream_id +=3D QUIC_STREAM_ID_STEP;
> > +     }
>
> [Severity: Low]
> Should recv.state be initialized to QUIC_STREAM_RECV_STATE_RECV here?
>
> The uapi header puts the send and receive states in one enum:
>
> include/uapi/linux/quic.h:
> enum {
>         QUIC_STREAM_SEND_STATE_READY,
>         ...
>         QUIC_STREAM_SEND_STATE_RESET_RECVD,
>
>         QUIC_STREAM_RECV_STATE_RECV,
>         ...
> };
>
> That makes QUIC_STREAM_RECV_STATE_RECV equal to 6. The stream comes from
> kzalloc_obj() and recv.state is never set. Every new stream therefore
> starts with recv.state =3D=3D 0, which is QUIC_STREAM_SEND_STATE_READY an=
d not
> a receive state.
>
> The only reader in this patch is quic_stream_put():
>
>         if (stream->recv.state < QUIC_STREAM_RECV_STATE_RECVD)
>                 return;
>
> This works only because 0 is less than QUIC_STREAM_RECV_STATE_RECVD. Any
> equality check against QUIC_STREAM_RECV_STATE_RECV would see an invalid
> receive state. So would code that reports the state to userspace through
> the state field of struct quic_stream_update.
>
> [ ... ]
>
> > +int quic_stream_init(struct quic_stream_table *streams)
> > +{
> > +     struct hlist_head *head;
> > +     int i;
> > +
> > +     head =3D kmalloc_objs(*head, QUIC_STREAM_HT_SIZE);
>
> [Severity: Medium]
> Should this allocation be charged to the memcg?
>
> When no gfp argument is given, kmalloc_objs() defaults to GFP_KERNEL. The
> 64-entry table (512 bytes on 64-bit) is therefore not accounted.
>
> Other per-socket memory in this patch is accounted.
> quic_stream_create() adds __GFP_ACCOUNT for the stream objects, and the
> sock itself comes from a SLAB_ACCOUNT proto slab.
>
> quic_init_sock() calls this for every socket(2). An unprivileged process
> in a memory-limited cgroup therefore gets 512 bytes of unaccounted slab
> for each QUIC socket it creates.
>
> Would kmalloc_objs(*head, QUIC_STREAM_HT_SIZE, GFP_KERNEL_ACCOUNT) be mor=
e
> consistent here?
True.

It's good to have it.

Thanks.
>
> [ ... ]
>
> > diff --git a/net/quic/stream.h b/net/quic/stream.h
> > new file mode 100644
> > index 0000000000000..cb6b35929ba51
> > --- /dev/null
> > +++ b/net/quic/stream.h
>
> [ ... ]
>
> > +     /* STREAMS_BLOCKED_BIDI/UNI sent and awaiting ACK for send limits=
 and
> > +      * MAX_STREAMS_BIDI/UNI sent and awaiting ACK for recv limits;
> > +      * MAX_STREAMS_BIDI/UNI needs to be set for send limits.
> > +      */
> > +     u8 bidi_blocked;
> > +     u8 uni_blocked;
> > +     u8 bidi_pending;
> > +     u8 uni_pending;
>
> [Severity: Low]
> This isn't a bug, but does the last line of this comment name the right
> limits?
>
> In this patch, bidi_pending and uni_pending are only used on the recv
> limits. quic_stream_put() sets streams->recv.uni_pending and
> streams->recv.bidi_pending. quic_stream_max_streams_update() reads and
> clears only streams->recv.*_pending when deciding whether to send
> MAX_STREAMS_UNI/BIDI.
>
> Should it say "for recv limits" instead?
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/cover.1791227050.git.lucien.xin%40gmail.com
