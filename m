Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7636A374
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782551; cv=pass; b=iOgR8MbWcQ+Xvy9/6GZg3voFwzx66AAhkvpIs9uYiG4PFMRdlOGo3X+gn4gaANtODEdX1BK4oLGA0AIUO1j50du+JRonnRyBwwJ3t9gdXIdiYNYJj+N+lhCmPymD+9LHQDksBmQVyjm8Y0GE+sk9BTt/pl2Lo3wYFo6Z8v6ZzJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782551; c=relaxed/simple;
	bh=8mLhQjFzbnDtZL3RLj4NMp1vbK4Ud5V55RlXePRzdoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNgX87+eQwWFmx/2jMQoHb6uoekgYqe0TanFeTXsiXl36SLWx9n6sBYDuRVUlvR29OC2oMffL8muFFjGApZ2V7hUsh0nW3k2/9lSFP7ckBjl7MnKuJ9GFM5kyogDA+4kmH8fvAZZ9A/cELk3TUEPH4cnDSIeCKXRnbZuy99LbqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzE6PWjJ; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzE6PWjJ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a468f4c547so16942161fa.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 05:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788782547; cv=none;
        d=google.com; s=arc-20260327;
        b=ISTBtIIPQi5Cp8yQPxHZPSVA3Uq62PPtANISVAv9F4Q2gLJN8wcvZiR0UDM8o5OEmJ
         2fEWuI4dfYUco6IUlW9JmP66mWMatCfYvyKVgAPOS9vJzGJEZnGRmBvPikKcYKQBP4wC
         MF5L7OSfqUPZ74AZpHZIfP+pkl3RDCMcjCFzPr8IGf069ekR5cYymURcVHPzh+Vf1yGw
         1kinrOr1QOAgZzUKzLgXPOKXqOtxRAwxCinlM/mRwVXjgB1CzlZkdV4tOb3dhMz8LC7s
         hUv0GqHD0/QuGHVrBrkj1tdlo3O1RTmtBq46KfuhCyNKOtkSJkRokmQ8ajyVc4fPtLwj
         pbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3B8KS8WBh42Tb8VOzZfjr64kES2Mp9rftQPtYL4FQk=;
        fh=GihRKJay7TZgzI6ci5evheP8hrIdIwJLd7TkBeqWEqk=;
        b=DhFNtNq+L+qmYIs7NHzXmUTuugIDOf09oYX5+EHh04H6bERJ4j8Lfp1LSbzkYqxkVj
         Qj2cqSli+5g4wxicsYSzWpwozmyjNo8hJoTBHvzXOd8+DucEJq8eu1tCKDT4fAkJk/OL
         +ETRMlc5Ite5xza1mF8BifegXSCz+xDjogJ3R1cfHuymXeKMSXWSgJi963WxaKktssw3
         w0j63XP8/yZnGKRiUzydKyAsHn71B8eXmyq/YRke7OaLrElItBF6rGISMj5u+A1hYWmO
         nkECCSspNzQxnktxj2yrZj3z3p13tRplUGowg046RCxU8f7a1qpdDHtKcYKOjAlYFVOk
         UEYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782547; x=1789387347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3B8KS8WBh42Tb8VOzZfjr64kES2Mp9rftQPtYL4FQk=;
        b=mzE6PWjJtVn7KQQ0MllXuV/UJD/rG2Z1cnKDPNsslr8xMHu7vItvyqtFpMeSSs003k
         XFCuxcweVICG4jj1B38Lm10MRO+pWnOdWVNe2rsee0soCgaOQWrmLd2edjZ9FhqbVx/w
         aqg5KcQRWBb9UBM/EfFg6WTZPFTsiGBuyN6AgJIcTqBRceYg0a5g7Skpp+7xQIdt5P29
         AZ5f4NlDFwqfc04ESHgWVPRK4f9b9zzBQMYHR9ZnK6NVnfmOyuwdY/CbQXN+LOssyLJi
         +0ZFaQU6k5woItyzztSmc1nw97v42lIM+MCDmHowiEvEKK3SNEAwXXaerpW+mlMLOuJa
         E5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782547; x=1789387347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3B8KS8WBh42Tb8VOzZfjr64kES2Mp9rftQPtYL4FQk=;
        b=chtJ50wPwJZuVEy9SraJvQTikQjacsiK73Ik/ISJCfMY5a2roIkJhRUSMyoMKP648n
         uPYVyV5SMQiWthcRTkwTRgzpwqxCOpIpacmVaY/V9xMBoGiRRSJONIs89wncMp1OV1Ik
         6BYYtOs/mLZFlG/hX+bfi70qiYXAPLR1zle2oxi04ss/phnUStSuqHLCbQOQzMeJd8ik
         TuuOetdlh9MbhvnypCuvUeqQBSK4dL2SeqGhtWwSRnYam1gIKB7tHLjNQhuQqnol61Kg
         TQ5jP8a5mFkwm1Or3V3S3638g26mUmm2DUGve8o40vW8uOr+I6ADFxF/lM5xql0hwg8i
         yOWA==
X-Forwarded-Encrypted: i=1; AKwUvBwlVkH34MUhPmqbHM1n25EjAJql7edHRZ3uwSftDdKbeUNkbBhTzWG2+kEn8iiL3wOnBYpX+t0=@vger.kernel.org
X-Gm-Message-State: AFuF++mNK0C68rJfxahfyz1njGaCYyPlGZnqvqpR4icb9i9liiS9dcO3
	DLRCSnqKDVZ0DitFl/rk1gJpardKVnCO+jEYcdT0fLSb/Qwr0CmD8FKo/5PCZQwvWT1PI04HBX4
	Q8HOwld+B+scWFM50zKqvJQPaDFCt+h4=
X-Gm-Gg: AYBFou0VlanWG87RycVPcDR3b5Ww6GyPMM4uN4oOg2kM7SfOtoOQAvfjua0sTHu1Beu
	zh2v1ID77S/jNXbnHnLvhP99IIixv0iksKjROiLbpidjzi0cFOMJzdmkxZa3YZsacL2UGwZ5lu6
	ee0SfaJV/UX6qPIplNKhAT5crjbV8TWuVsaJnA7gMx7zdh13IQtVIFfbjKNmruucqKWxvyxwlVP
	IAm6KIQWdExerRe1GzXrgpeYOzYYkstMhPf46aVqPiBtd+rj4Bo0QVH8HyzZhKrRMqhFuNZQUyK
	uihewX+GnkmDMuhE2EwVxw7ebpp8450XvCr718pUnw3p/yai9VhLqtaHbn8EoalGHOlj1A75WeO
	ngaMCWQ4LKfLu2vjpfESxhR86pRNBTREoNTOpKtjp0u3eqNAjYWBBoexYQDDg7/hjGbk3pg==
X-Received: by 2002:a05:6512:3c9b:b0:5b6:4ae:8c04 with SMTP id
 2adb3069b0e04-5b61706b270mr3397799e87.31.1788782546928; Mon, 07 Sep 2026
 05:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902121028.74092-1-kerneljasonxing@gmail.com> <178875475592.219967.3353530907347334836@kernel.org>
In-Reply-To: <178875475592.219967.3353530907347334836@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 7 Sep 2026 20:01:48 +0800
X-Gm-Features: AcwNN1Wer9yQeRJHRbGGSnaXJdlvEOLVEKwGoPC3Lb0_2G1H3MBxfPoD6oYKNgc
Message-ID: <CAL+tcoCPKPucCJVGD7MA=XSUyCte0K7WTOYuCrLfbRTdWv2mrw@mail.gmail.com>
Subject: Re: [PATCH net v3] xsk: set network header on skb at generic transmit
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 12:19=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> - [Medium] net/xdp/xsk.c: xsk_skb_init_misc() (line 950) now does
>   skb_reset_network_header(skb) unconditionally, i.e. it declares the=E2=
=80=A6
> - [Medium] By making skb_network_offset() valid (0), the patch makes
>   tunnel ndo_start_xmit paths that were previously *always* rejected=E2=
=80=A6
>
> --
>
> xsk: set network header on skb at generic transmit
>
> This adds skb_reset_network_header() to xsk_skb_init_misc() so that
> skb_network_offset() no longer returns -hr for skbs built by the XSK
> generic transmit path.  The negative offset was promoted to unsigned in
> pskb_may_pull_reason() and tripped the DEBUG_NET_WARN_ON_ONCE(len >
> INT_MAX) check when such an skb reached a tunnel xmit routine.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f63994eec
> Link: https://lore.kernel.org/all/20260901083325.3445-1-kerneljasonxing@g=
mail.com/
> Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@=
gmail.com/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6f..2077bb6299ca9 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, s=
truct xdp_sock *xs,
> >  {
> >       int err;
> >
> > +     skb_reset_network_header(skb);
> > +
>
> [Severity: Medium]
> The changelog says:
>
>     AF_PACKET only cares about the boundary because it can cook an L2 hea=
der
>     itself (SOCK_DGRAM) and supports GSO/checksum offload; none of that
>     applies here, where the frame is sent as-is via __dev_direct_xmit().
>
> Is the checksum offload part of that accurate?  xsk_skb_metadata(), in th=
is
> same generic xmit path, does:
>
> net/xdp/xsk.c:xsk_skb_metadata() {
>         ...
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
>
>                 if (unlikely(pool->tx_sw_csum)) {
>                         err =3D skb_checksum_help(skb);
>         ...
> }
>
> So when the descriptor carries XDP_TX_METADATA with
> XDP_TXMD_FLAGS_CHECKSUM and pool->tx_sw_csum is clear, the skb is handed =
to
> the driver with CHECKSUM_PARTIAL, and hardware checksum offload does appl=
y
> to AF_XDP generic xmit.
>
> With network_header now anchored at skb->data, on an ARPHRD_ETHER device
> that offset points at the userspace-supplied struct ethhdr rather than th=
e
> L3 boundary, so skb_network_offset() is 0 where the drivers expect
> ETH_HLEN.  Drivers derive descriptor geometry from it:
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_tx_csum() {
>         ...
>         vlan_macip_lens =3D skb_checksum_start_offset(skb) -
>                           skb_network_offset(skb);
> no_csum:
>         vlan_macip_lens |=3D skb_network_offset(skb) << IXGBE_ADVTXD_MACL=
EN_SHIFT;
>         ...
> }
>
> That programs MACLEN as 0 and an L3 length that is ETH_HLEN too large
> (igb_tx_csum() is the same shape, and i40e_tx_enable_csum() sets ip.hdr =
=3D
> skb_network_header(skb) and then reads ip.v4->version, which now inspects
> the destination MAC bytes).
>
> For comparison, the AF_PACKET complete-frame path anchors both headers:
>
> net/packet/af_packet.c:packet_parse_headers() {
>         ...
>         /* On TX skb->data is the L2 header; anchor it for all socket typ=
es. */
>         skb_reset_mac_header(skb);
>         ...
>                 skb_set_network_header(skb, depth);
>         ...
> }
>
> Could the changelog either drop the checksum offload claim and document t=
he
> remaining descriptor inaccuracy, or could the network header be set to th=
e
> real L3 boundary (mac header plus dev->hard_header_len / VLAN depth, or
> consistently with csum_start when XDP_TXMD_FLAGS_CHECKSUM is requested)?
> Note the pre-patch offset of -hr was worse, so this is not a regression
> relative to current behaviour, but the value chosen is wrong for every
> ARPHRD_ETHER device.

I think it's a pre-existing bug associated with csum logic, which is
what I've already replied in the V2 thread:"Until now, it seems we've
got three fixes in the queue:1. reset mac header:
https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/
(commit 35fcde7f8deb "xsk: support for Tx")
2. reset network header like this patch. (commit 3914d88f7608 "xsk:
Respect device's headroom and tailroom")
3. handle csum offload issue by adding probing code. (commit
48eb03dd2630 "xsk: Add TX ... checksum offload support")"

However, I strongly feel a need to discuss this before moving on to V4.

https://lore.kernel.org/all/CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyH=
tABA@mail.gmail.com/

Thanks,
Jason

>
> [Severity: Medium]
> Does making skb_network_offset() valid also newly admit AF_XDP frames int=
o
> tunnel xmit code that parses the inner L2 header without any length check=
?
>
> Before this change, erspan_xmit() dropped every AF_XDP skb at its first
> statement, because pskb_inet_may_pull() -> pskb_network_may_pull_reason()
> computed (unsigned)(-hr) + nhlen and failed the len > skb->len test:
>
> net/ipv4/ip_gre.c:erspan_xmit() {
>         ...
>         if (!pskb_inet_may_pull(skb))
>                 goto free_skb;
>         ...
> }
>
> skb->protocol is never assigned in net/xdp/xsk.c, so nhlen is 0 and after
> this patch pskb_may_pull_reason(skb, 0) succeeds and the frame reaches
> erspan_build_header() / erspan_build_header_v2():
>
> include/net/erspan.h:erspan_build_header() {
>         ...
>         tos =3D is_ipv4 ? ip_hdr(skb)->tos : ...
>         if (eth->h_proto =3D=3D htons(ETH_P_8021Q)) {
>                 qp =3D (struct qtag_prefix *)(skb->data + 2 * ETH_ALEN);
>                 vlan_tci =3D ntohs(qp->tci);
>         ...
> }
>
> Those read skb->data[1], skb->data[12..13] and skb->data[14..15] with no
> validation, and the results end up in the transmitted header via
> ershdr->cos =3D tos_to_cos(tos) and set_vlan(ershdr, vlan_tci).
>
> Is there anything in the AF_XDP path that guarantees the frame is at leas=
t
> 16 bytes long?  Descriptor validation only rejects zero length:
>
> net/xdp/xsk_queue.h:xp_aligned_validate_desc() {
>         ...
>         if (!len)
>                 return false;
>         ...
> }
>
> and neither __xsk_generic_xmit() nor __dev_direct_xmit() enforces
> dev->hard_header_len, unlike AF_PACKET:
>
> net/packet/af_packet.c:packet_snd() {
>         ...
>         if ((sock->type =3D=3D SOCK_RAW &&
>              !dev_validate_header(dev, skb->data, len)) || !skb->len) {
>                 err =3D -EINVAL;
>         ...
> }
>
> For a descriptor with len between 1 and 15 those offsets are past skb->le=
n
> inside the non-zeroed head from sock_alloc_send_skb(hr + len + tr), so ca=
n
> this copy a couple of bytes of uninitialized slab memory into the packet =
on
> the wire (and produce a KMSAN use-of-uninitialized-value report)?  The
> "complete, opaque blob from userspace" premise in the changelog is what
> opens this, since nothing checks that the frame contains the device's lin=
k
> layer header.
>
> An approximately equivalent primitive already exists via AF_PACKET SOCK_R=
AW
> with a 14-byte frame on the same device, so this mainly exposes the short=
er
> frame variant.  Would a minimum length or header check for AF_XDP generic
> xmit be appropriate here?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902121028.74092-1-kerneljasonxing%40gmail.com
