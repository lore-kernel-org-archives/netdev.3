Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793377544;
	b=qDkrqXFlv0HwbypFZJ30qnoJ0RyKY3HAaOucVgRSxAo1YySbqhZqew7s8tYTq78L2Nax
	 CST0D9o4kju+wbQS/AZJWew2nHV6d5og44E1qNfy6fWeucs0qi5Etd7drGSlVNkBJ8PNU
	 OSlrz2dalBSv7PnTF4afGal2vz9BRVF2hrYdStGlcFVw/Md29lpEVOY0yfSd2+KbnD0ri
	 MObnS9eTBl1C6d3XnNxfZWqoqnLzL5H1aj6atkeHajniNSXcQZUTF5FyjTogI6syw0yCJ
	 mArxvI68BhGnvJhMgDBJBqiSa/NfuN0W7zFbHYv2y1+ykbmjdvvv2OnbOBbsZuKa9lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kXy++yDe59dkKCjS5FUXLAaHk0TybWZRMjYhR93Bt6Q=;
	b=C0/XwoRW6oY9SsCKGSoZBycEG/pDeI06BhOHC0L9UJ8qPltg1HkfkP+IbXYW6LZRzkYj
	 VMDbn0vZdLg726F3hRqGXBY/d+hAVkUGwgOsAwrmlhiWOaUPMjinAwb9oK3nkX3nsAOXp
	 t6FkvEhOYT9BCFKUvZLiYfu02mLV9iVwGBaUUwssgpORKTUmS4pw634Zf9kYaQ3fnM4Pa
	 HrDMpx50uYdqRVKvwh2EmklEmBJpxDP/WVVmcRH157RUrn8Ww6nqTpSU4HuXng9KcKGn6
	 SFhitPQPE7TxXhc5pyexo2xTNi2W8wi4FbDxwhUjimFgh56KkQIxM7kVe1VGUJ7P8Qg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x/eDCmuH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316B606A322
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6316B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/eDCmuH
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so5696675e9.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793377543; cv=none;
        d=google.com; s=arc-20260327;
        b=lWN6CZhXEtUJ+3Lh4doTkDvgbwdq7kH9BOIMWgjazY1RV+e9kUT3znHGAGcNa7lElj
         RF/ow09D66pDIvNSypdP3YKs+CeqOcl/gvSNvX2yRxiiUnIp3bQJomYTan9O9TZka5Qt
         u4VNBwXxkVUMPYOMXUfHc50m2KvzgitBQEcsGE9YfuTGPilp0JxVMBt0YX0MFGGq5qtM
         0vZfWF6ZM5391zvZVfO7kVWD5xtvAkjpl4jdQfwkzJpH5U6WY1uA/SkKN2qJGwHBCOWs
         EhruaNzlsX1EssqLySt8F+1W7gHgVvY4iNR5tZAKoScw4xYC5P0ndi4OberQdMsDV76j
         B37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXy++yDe59dkKCjS5FUXLAaHk0TybWZRMjYhR93Bt6Q=;
        fh=w3I57MQQGmwjpjsV+wXh6UV/v7ns2MbcgLPYltjL974=;
        b=opT3Tg9cSePZwPwuyWTUFO7XWUfQTw0XiR7zjh8uCM3SYpGHFghEuwVY9ZwzFPbYnC
         ZCyQwd09XZZckLeXp2TxiKIVQuYcnXdkuF0xef980McqSDQmmeoMhtfEd45K4eGECG9Q
         LE36E4nqqQnb6mdiTJyz6imRL9Z3IDgsJzcgGFCYdh0831q0No+a/2/BDfGfAKRa2mOP
         KNqwqrOzWWafOB+Zoms/mIrcNlLwa/YGHSX26m60pGkZR+N6ESsS5PGVFZxDjba2uIaC
         elPY8i1XmmuHWpQFX6BIhYMsAnvEQTOVt1fvXNQXuoJRT8aTzA7qnS9M9yLXkDoqPmbt
         bOnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377543; x=1793982343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXy++yDe59dkKCjS5FUXLAaHk0TybWZRMjYhR93Bt6Q=;
        b=x/eDCmuHK8pvg+qDnj2z9tmDOhhZNk3eWiLEJXiiksyOl4kNu/fhBlNxdc4gPgj5N/
         99T4VxZFAeN1jHypkkWKUpmycXH94wryXKR00EbNpKkp7Dt1bNmS+K+4asCIjLc5JWmY
         yVAdVmxHy6LM+qaprmRUIyDy2gzc6L7DP0OvJznW9KZWIJksqXWY2DxXcj8YG8GQBBP2
         dDEfWQZY22pVY6VWluv/Nu7CyG1vBT6lRQocSJQEcv/thS9O9lMWfpHvZFz5ZD0Yyhh5
         Ti/TblvmWJGXZrAO6yax/rJJVtbiqkjQR1LMkWyCHFQhZ6GiXIOXP6kfkao+fTHRIrJm
         AkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377543; x=1793982343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXy++yDe59dkKCjS5FUXLAaHk0TybWZRMjYhR93Bt6Q=;
        b=Jey/l8B6PvJsoQS4JOIZN5TD0UQAw3heHuLkIuwi5oZF60ZIlwaahiGsVYg4q7GkRs
         X5Uyza89eFbefkRsjngwT9tRGnB3pYaCa1mlNo2QJMWddSQp22H9XlnIzN4ekNM/pnpN
         V9SOGr/fN8ygpWDuIXbR8Gw1bxFK/L+atnxIYtqxhSvCDqkSwjwp3vbsyEX/1wn6QdFA
         30UCgNxZOmbr9EmJbLUadMbAy+Ng2AIuirBhHu83fTE5+ausXIE9eWpyZKTz/8+zXTMS
         2wwE9bp3oe6ul4uoTqKaZXTIADh1hExahever8IuHpMA3sLttt5A+rxReyS33yAuNvjE
         KpYg==
X-Forwarded-Encrypted: i=1; AKwUvBwbz0z7qGziQV/z0l4CZb6ETelECp0nC6TX4U0XBxj7KcVn6Mp52MHgxZsKUg34xDCbUNgL9/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQCR+EyysNuBZRMkD7ExK6/xnytXDKy83v3T9nzL665cPvJV3E
	wZ/f6KI3VaME+ojj/fxE66g1ALP87vdXSXUswjGa58Y5rU/ZFGkwuhwokOinkYxTMuv9WljP0dt
	pw/Hy+LMLQGRrnnXWWd6lYrawAVKTzxs=
X-Gm-Gg: AYBFou27HMoXfcbp34KdbxNoOX5EorYnZiuV0Fm5aHBi8INRrPWpueScjqsfe1VgJjv
	0qjru9QLE9XDrSSgrzRXA8eeL1yCeZaxmuv2yNOpadNKR3iVJmKKxIcSI57Ki/qhq7+GGJIO/K9
	HhiSEh134zX7ondEb76W+YUz9LspTJla+u1ypTsaMMa7sF9DjEpEky/Vt1ESQDI2P2VH4Yrf/Ye
	KsdxoTjCcuXwE6C0vphbNd6OSRVDnzGGm9UjYuA0OIIoF7MojWXDlacpzWAQNaHrRmsffY49N+t
	xXMUIeETeMN/7tcbW5kI3Ag7Xb51QI5Jx2/H57HtqumQ3qfADqnlV9OKQiFUoAJwSUbIIpeDRuk
	1Rxe+iYtsFRwk50iVngRegSM/6C5SrhvUrwE3dPKvnmWRA6m0JGL2zIjTOjVUNxLQvP3k0OGEvo
	za+Md4bxuleWTr3s0k
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4ac185bc1d2mr57388325e9.26.1793377542406; Fri, 30 Oct 2026
 09:25:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030100504.23498-1-ahmadag1001@gmail.com> <willemdebruijn.kernel.2e53c121ad9ea@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2e53c121ad9ea@gmail.com>
From: Ahmad AG <ahmadag1001@gmail.com>
Date: Fri, 30 Oct 2026 19:25:30 +0300
X-Gm-Features: AclHuK9FiCD6Ap4_Z7bw5M7_2UvH5KvQ6q5xX-gBNx49bJGjnFmhulCDxxu_6J0
Message-ID: <CAASqGyYfFwZizof-O+Bn3_H85sEFytVr9GapOVQsW9miVa+Zsg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/packet: account user-triggered allocations to memcg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. I will send a v3 to net-next, without the Fixes and stable
tags, keeping the allocations that scale with user input (ring
buffers, fanout array, membership entries) and leaving the small
fixed-size per-socket ones such as the rollover state alone. I will
add __GFP_NOWARN to the vmalloc fallback.

On Fri, Oct 30, 2026 at 5:21=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Ahmad AG wrote:
> > A packet socket allocates memory for its user that is not charged to
> > the user's memory cgroup:
> >
> > - PACKET_RX_RING and PACKET_TX_RING: the ring blocks themselves
> >   (alloc_one_pg_vec_page(), both the page allocation and the vmalloc
> >   fallback), the block array (alloc_pg_vec()), the deferred-free work
> >   of a TX ring, and the rx_owner_map bitmap of a TPACKET_V1/V2 RX ring.
> >   The size comes from the tpacket_req passed to setsockopt() and has
> >   no limit other than available memory.
> > - PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
> >   group with max_num_members =3D 65536 (a 512 KB array, rounded up to a=
n
> >   order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
> >   packet_fanout.arr size configurable up to 64K"), and the per-socket
> >   rollover state.
> > - PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
> >   (packet_mc_add()), with no limit on the number of entries.
> > - socket(): the per-CPU TX ring pending counter
> >   (packet_alloc_pending()).
> >
> > A process with CAP_NET_RAW, which an unprivileged user has in its own
> > user and network namespace, can therefore pin kernel memory far beyond
> > the memory.max of its cgroup. With memory.max set to 16M, a test
> > running as uid 1000 took 525804 KB of system memory with 64 sockets
> > each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
> > memory.current grew by 892 KB; 264640 KB with 256 sockets each
> > creating a fanout group with max_num_members =3D 65536 (memory.current
> > +512 KB); and 46664 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
> > entries each on lo (memory.current +256 KB).
> >
> > Allocate all of these with GFP_KERNEL_ACCOUNT, as other allocations a
> > user can make on demand in the networking stack already do, for
> > example the AF_XDP rings since commit b0057c68df71 ("xsk: account
> > ring allocations to memcg"). vzalloc() takes no gfp mask, so the
> > vmalloc fallback becomes __vmalloc() with __GFP_ZERO. skbs are bounded =
by
> > sk_rcvbuf and sk_sndbuf and are left as they are, as is the per-packet
> > zerocopy state in tpacket_snd(), which lives only as long as its skb.
> > struct packet_sock itself comes from sk_alloc(), and the
> > netdev_hw_addr entries that PACKET_MR_MULTICAST and PACKET_MR_UNICAST
> > add through dev_mc_add() and dev_uc_add() live in net/core; neither
> > is changed here.
> >
> > With the change each of the three tests in the 16M cgroup is stopped
> > by the cgroup's OOM killer. With a higher memory.max the rings charge
> > 525436 KB for 524832 KB of system memory used (1G), the fanout groups
> > 262656 KB for 265128 KB (1G), and the membership entries 26880 KB
> > (1G). These figures are from a KASAN kernel, which inflates the small
> > objects; without KASAN the 200000 membership entries are 20480 KB
> > charged for 26412 KB used.
> >
> > The missing charges were found by code inspection of net/packet/ with
> > the help of an LLM and then triggered with a small test program that
> > creates the sockets, rings, groups and entries and reads
> > memory.current; the numbers above are from that program. Tested in a
> > QEMU/KVM guest on this tree (x86_64_defconfig plus kvm_guest.config,
> > KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
> > memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
> > and psock_snd.sh pass before and after.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> This predates the introduction of memcg accounting and indeed
> much of the code that is being instrumented.
>
> I also don't think this is stable material.
>
> Especially on the actual ring buffers: retroactively enabling
> this may break existing users.
>
> Consider net-next. Else, net still needs a Fixes tag. Review how
> important each of the conversions is, keep the important ones, find
> the oldest one and use that as tag.
>
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude Code
> > Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
> > ---
> > v2: cover every user-triggered allocation in net/packet in one patch, a=
s
> > Willem suggested on v1, and resend with git send-email; the v1 mail had
> > tabs replaced and lines wrapped by the mail client. v1 changed only the
> > fanout group allocation.
> > v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO=3D=3D51S=
VsQW_x_mk993y1pNO8A@mail.gmail.com/
> >
> >  net/packet/af_packet.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 823e0911c91..06386db4c8e 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1233,7 +1233,8 @@ static int packet_alloc_pending(struct packet_soc=
k *po)
> >  {
> >       po->rx_ring.pending_refcnt =3D NULL;
> >
> > -     po->tx_ring.pending_refcnt =3D alloc_percpu(unsigned int);
> > +     po->tx_ring.pending_refcnt =3D alloc_percpu_gfp(unsigned int,
> > +                                                   GFP_KERNEL_ACCOUNT)=
;
> >       if (unlikely(po->tx_ring.pending_refcnt =3D=3D NULL))
> >               return -ENOBUFS;
> >
> > @@ -1735,7 +1736,7 @@ static int fanout_add(struct sock *sk, struct fan=
out_args *args)
> >       if (type =3D=3D PACKET_FANOUT_ROLLOVER ||
> >           (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)) {
> >               err =3D -ENOMEM;
> > -             rollover =3D kzalloc_obj(*rollover);
> > +             rollover =3D kzalloc_obj(*rollover, GFP_KERNEL_ACCOUNT);
>
> Is it worth accounting even such small ones?
>
> >               if (!rollover)
> >                       goto out;
> >               atomic_long_set(&rollover->num, 0);
> > @@ -1778,7 +1779,8 @@ static int fanout_add(struct sock *sk, struct fan=
out_args *args)
> >                       /* legacy PACKET_FANOUT_MAX */
> >                       args->max_num_members =3D 256;
> >               err =3D -ENOMEM;
> > -             match =3D kvzalloc_flex(*match, arr, args->max_num_member=
s);
> > +             match =3D kvzalloc_flex(*match, arr, args->max_num_member=
s,
> > +                                   GFP_KERNEL_ACCOUNT);
> >               if (!match)
> >                       goto out;
> >               write_pnet(&match->net, sock_net(sk));
> > @@ -3773,7 +3775,7 @@ static int packet_mc_add(struct sock *sk, struct =
packet_mreq_max *mreq)
> >               goto done;
> >
> >       err =3D -ENOBUFS;
> > -     i =3D kmalloc_obj(*i);
> > +     i =3D kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
> >       if (i =3D=3D NULL)
> >               goto done;
> >
> > @@ -4494,7 +4496,7 @@ static void packet_free_tx_ring(struct sock *sk, =
struct pgv *pg_vec,
> >  static char *alloc_one_pg_vec_page(unsigned long order)
> >  {
> >       char *buffer;
> > -     gfp_t gfp_flags =3D GFP_KERNEL | __GFP_COMP |
> > +     gfp_t gfp_flags =3D GFP_KERNEL_ACCOUNT | __GFP_COMP |
> >                         __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
> >
> >       buffer =3D (char *) __get_free_pages(gfp_flags, order);
> > @@ -4502,7 +4504,8 @@ static char *alloc_one_pg_vec_page(unsigned long =
order)
> >               return buffer;
> >
> >       /* __get_free_pages failed, fall back to vmalloc */
> > -     buffer =3D vzalloc(array_size((1 << order), PAGE_SIZE));
> > +     buffer =3D __vmalloc(array_size((1 << order), PAGE_SIZE),
> > +                        GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>
> Consider adding __GFP_NOWARN here too, similar to the pg_vecs, to avoid
> excessive warning when enabling memcg accounting.
>
> >       if (buffer)
> >               return buffer;
> >
> > @@ -4523,7 +4526,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_re=
q *req, int order, bool tx_ring
> >       struct pgv *pg_vec;
> >       int i;
> >
> > -     vec =3D kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_N=
OWARN);
> > +     vec =3D kzalloc_flex(*vec, pg_vec, block_nr,
> > +                        GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> >       if (unlikely(!vec))
> >               return NULL;
> >       vec->order =3D order;
> > @@ -4532,7 +4536,7 @@ static struct pgv *alloc_pg_vec(struct tpacket_re=
q *req, int order, bool tx_ring
> >
> >       if (tx_ring) {
> >               vec->deferred =3D kzalloc_obj(*vec->deferred,
> > -                                         GFP_KERNEL | __GFP_NOWARN);
> > +                                         GFP_KERNEL_ACCOUNT | __GFP_NO=
WARN);
> >               if (!vec->deferred)
> >                       goto out_free_pgvec;
> >               vec->deferred->vec =3D vec;
> > @@ -4648,7 +4652,7 @@ static int packet_set_ring(struct sock *sk, union=
 tpacket_req_u *req_u,
> >               default:
> >                       if (!tx_ring) {
> >                               rx_owner_map =3D bitmap_alloc(req->tp_fra=
me_nr,
> > -                                     GFP_KERNEL | __GFP_NOWARN | __GFP=
_ZERO);
> > +                                     GFP_KERNEL_ACCOUNT | __GFP_NOWARN=
 | __GFP_ZERO);
> >                               if (!rx_owner_map)
> >                                       goto out_free_pg_vec;
> >                       }
> >
> > base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> > --
> > 2.43.0
> >
>
>
