Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793904368;
	b=K4hEz1D1rIUqGIEBw+FYWxsHpf+lry2xKPcik8yoPCc7MDsgMZrOzSGGv+eq0Fhrib7S
	 JNObEVTaRCkQ8uRoZnw17t4sgKTvf62WMLMj47yTjR8/sAsV7g16OMzsPGhbxasSZG5Cz
	 WStKu8Nz1ZaKWkLSBmIxhkjgNYuQrq3ajXDs3Jeby885JgeiYRcee9YEmTnzkdqDowsLR
	 OSkwQWgooGH74ed6HeuoYyZ9xhb+NQXLHl9Pq+4U1XIhETBtCdlCUQttLiYXoVTOXJ1e/
	 tuGYkJ0MqPgBFVQ7CGBvinWXZMt/xuYCROjlEylDdQ4kUSkzCI5VIHLXcLRXiFHkMDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IX3xYSKF4ke89yg+k9TlGDhysYoys1qisBWHWTJPmmA=;
	b=MastIdH6eBT1c0OlFhTu3PfKXSTRsfSfWAY33rn9uXL+Lc1ByejXKFPi/RXIi66doCcf
	 Gjpk8DhNB2i45b+niMYSfn0HKsxWyIUAEdn8S+rqFAHjW6MC0+k98wqhbvVatEHfJo6bH
	 GibTwk7eAw5XZLqmmx342z6bDO6zb4vxabcDhelMKqiO9RAOYuiTgukxBTnlW5Fv0TgRE
	 bqT1slfmoVfzYkCGNV+OP0rMlCIOLz8LU0QnW7qT8qV/LrjV3zXbBOMcmjg60pYSs+hOv
	 RVvR1/yaKbD42hZRJVXAsPx0c5RQ0jTAeDbr+Tg/Y+PBpOVXJwLTVbrIUfTY9LvIWMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw3f7d4v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B3606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 18:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE4B3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw3f7d4v
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1010345f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793904366; cv=none;
        d=google.com; s=arc-20260327;
        b=Ed0QcUZ8kbTnUGVLcLT3oouaIA+IuWScTDw/1zcnax/y8uk/nMJbJzmLnFPaJIe3hH
         dKGH1pyi3ubqFFlvw/dwK3CgmdkngI01SAJ0M2tAt52It9cVv4AALlau/i0gBNGiUPyO
         McsIzlTK6fjj4MX6bVLIzXC3yw0R3lDVXutwvZhHw2t3sXJ3BD4HpFSZtWUT7oEVd/Bx
         1XMrK6o0prnuOq83KgVWP5xUAAFBavW9d9BmwkDTu/9kxkkJ8idCyeBRcMYgpYTA0C9m
         1dYCQrvQa2gG8+8RB0yRwJT0ijj8gr2QaB2JIkfY2A6E0qX+2n3Wz5iReMJBBSrWs/24
         kwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IX3xYSKF4ke89yg+k9TlGDhysYoys1qisBWHWTJPmmA=;
        fh=5kObyTp4VTv2iXZlqGmQFchmHtslPii3SIBb2ewpcwM=;
        b=CwOErscTMAB7SrTcbB34R/GSq1TNObSssMsmqJhAZAlT3m12bEpwEZ36g+N4CeaVLC
         K3WQogQOi/2Z2iMvQH1V3z0lhkXNJjjexk1OEIpMUeMa0r9QXDDbPPsh+RzcxGr/JMm2
         dMIzwhZTBv7NgkgcnVcKxtyNOg1it/Hn9FK7Fwu2p5njUC8ndnI0lEWpBscN+p+cLukQ
         pbQ/Gknd+mHZHWb9nMFPjdZUqzXnbvcPQa0dH8XOeiN3GiS5y3yGCALmX/BBDxtOuge/
         kW7rbNkQYJ2CfxNFEGkwOFFYjW4+w703F0LrYt069nIeLPQ2e2PGEZsV9WkFdvYbDRjU
         zfjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904366; x=1794509166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IX3xYSKF4ke89yg+k9TlGDhysYoys1qisBWHWTJPmmA=;
        b=Fw3f7d4vza9x99qdrtUqLXEnNOAahaOReYug4fyh3zJ9lE81SC2VJbJ2w21h1LXAan
         B39cpquiqxMUjhvcRNER2oPEtiht2kMOH791m0huKB1+MpEREfpCLxNSbKNgrsfl1OYD
         Spj90ke4U0vA75xOI1Fj6+sITZYWv3oumcOuyAQjPgMHEpJXkvM2E65qK3DaLhdS9exz
         tONvGpx2Dcxd6Oy3NzYc+rxVx4u++Qs1wODbzw94iE5362JgcUGLjSuwYDBgTn0QUOFH
         rMDAxzi9ZiPnxwBRuEPGb3XBwWMT4RwcvmsY2fDd6TTRL7E51bDlHgIZd1pywqdwkZAW
         p16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904366; x=1794509166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IX3xYSKF4ke89yg+k9TlGDhysYoys1qisBWHWTJPmmA=;
        b=G7pozrZvHK101avuYR1NigpCl1vlDaDZ1ZMuhyCVBaIENBAc/kCY7xjAOa+7KJk3od
         SODxlbcl3A5TsVcXVOnIYNv3rinjx0izptzWIm3bJpUGOn7pT8Myd4iMm9LNAfwfChQx
         uzmUStiIaGZSVEWjpwt9Yotq8bXWZAJAgSDHVUZnf929V73KgSBFiTqepo/k+b46uVqD
         EekvzfYidqz9rC65bQO5H/BNFMKSo/lTIOmmBsgRVt5jtwUv2JRcbG6Eqb4oKc8P4xv0
         by5H7f4S6uUHcAxgycvLmp2AXIRz1FGkLT/5eI0dXp5YtdNSnWPpoejOmWZCWbaE2gvP
         KPNg==
X-Gm-Message-State: APuU4Z/aU7GdAzkFsaXnzbSCPOqHdMdb4ZjXZdKNfwHwUHoefSkDm1Ay
	1Q81BXu9Txs0ec882dwm8S1HJtt4B5l5fUaU/3fXATp8IqrLKlwkgujwrurIjvbLL6tqOPVsPGR
	yNSo3qXKhuVXFE0wvqKr6HtPLs0YZ4DY=
X-Gm-Gg: AYBFou00ZTTfZ9S9mQQd3BniEUjl6jubKP9vF2bH/xH5WCtyMkM+7WAxksjwMV9zzeF
	R7H/hi9p8vTjrKqdFBHjrC2nioU7YZmvkI5bnQLqaAtCJp1CwuToGsWogTO5Hn7snRPlzHpS+qy
	dsobwyUdWaOIT/Aex+2WVU3H//4slDGYlwcpySVE6Ecl9Mxg/FO69dbu+rgYUC3xb8GFMPyFkX1
	0IlKfAcAmCVkGVBbniv5yZ7E54iFrZhYCJLGhnESEjIN/6jQm7XP4Ibb9iU52e8tovokH9Vdldw
	tXVkbV7adHF20xkJycVhei7SsXcPbXWuwZq7L4HGofPiYXfbri95XAH4Nw+w5xNGZ0akHzIdoAM
	E6jVMnZrPfv+JaRl4Y8AVzTY4MY5+oxpLmIbnmqoDQbiPZ7phcwfYGkzI8ftsdyq1c3BkNFbOFk
	l4POu+kPecDGbRKhP3BH5r+8vNskYS+Q9KYboqhAIW4lrhUSaFUHNawg==
X-Received: by 2002:a05:6000:2681:b0:48b:e50:7159 with SMTP id
 ffacd0b85a97d-492753729f5mr949005f8f.30.1793904366097; Thu, 05 Nov 2026
 10:46:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
 <179389871649.994134.5339648334633501825@kernel.org>
In-Reply-To: <179389871649.994134.5339648334633501825@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 5 Nov 2026 10:45:29 -0800
X-Gm-Features: AclHuK-cmGgasDpGGIa1L8SsectSLTRucAVDQygyWdgMdDqUZOgh_hRZEwV7b08
Message-ID: <CAKgT0Uf66hPeHSqS-jviMsR08BVL-9qGfh8DsGqnXyeGempj8Q@mail.gmail.com>
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fraglist
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, 
	pabeni@redhat.com, tactii@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 9:11=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In validate_xmit_skb() (net/core/dev.c), a non-fraglist
>   CHECKSUM_UNNECESSARY GSO skb is relabelled CHECKSUM_NONE before=E2=80=
=A6
>
> --
>
> net: Segment CHECKSUM_UNNECESSARY GSO skbs other than fraglist
>
> This commit changes validate_xmit_skb() to relabel any non-fraglist
> CHECKSUM_UNNECESSARY GSO skb, such as a hardware LRO aggregate sent out
> through tc mirred, as CHECKSUM_NONE. The stated intent is that
> netif_needs_gso() then segments these skbs in software. Without the
> change, drivers that only set up TSO for CHECKSUM_PARTIAL send one
> oversized frame with a bad checksum.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index f32353b0467cd..28b4a652d037f 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(struct =
sk_buff *skb, struct net_device
> >       if (unlikely(!skb))
> >               goto out_null;
> >
> > +     /* Only fraglist GSO, whose segments already carry valid checksum=
s,
> > +      * can be handed to a device as CHECKSUM_UNNECESSARY. Any other G=
SO
> > +      * skb has no csum_start for the device to segment from. NONE mea=
ns
> > +      * the same on transmit, and has netif_needs_gso() segment it in
> > +      * software.
> > +      */
> > +     if (unlikely(skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> > +                  skb_is_gso(skb) &&
> > +                  !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
> > +             skb->ip_summed =3D CHECKSUM_NONE;
> > +
> >       features =3D netif_skb_features(skb);
>
> [Severity: Medium]
>
> On a TSO-capable egress device, does this path actually reach software
> segmentation?
>
> ip_summed is already CHECKSUM_NONE when netif_skb_features() runs, so
> the driver's ndo_features_check() sees a non-PARTIAL skb.
> i40e_features_check(), ice_features_check() and fbnic_features_check()
> all return early in that case and leave NETIF_F_GSO_MASK set:
>
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_features_check() {
>         if (skb->ip_summed !=3D CHECKSUM_PARTIAL)
>                 return features;
>     ...
> }
>
> harmonize_features() also skips its can_checksum_protocol() test for
> CHECKSUM_NONE.
>
> netif_needs_gso() then returns true, and __skb_gso_segment() runs with
> NETIF_F_TSO/TSO6 still in features. tcp4_gso_segment() (and
> tcp6_gso_segment()) turns the skb back into CHECKSUM_PARTIAL:
>
> net/ipv4/tcp_offload.c:tcp4_gso_segment() {
>         if (unlikely(skb->ip_summed !=3D CHECKSUM_PARTIAL)) {
>                 ...
>                 th->check =3D 0;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
>                 __tcp_v4_send_check(skb, iph->saddr, iph->daddr);
>         }
>
>         return tcp_gso_segment(skb, features);
> }
>
> Since the device can do TSO, tcp_gso_segment() then returns NULL:
>
> net/ipv4/tcp_offload.c:tcp_gso_segment() {
>     ...
>         if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
>                 ...
>                 segs =3D NULL;
>                 goto out;
>         }
>     ...
> }
>
> validate_xmit_skb() treats NULL as "not segmented" and passes the
> original skb to the driver as a CHECKSUM_PARTIAL TSO request.
>
> If so, the new comment ("has netif_needs_gso() segment it in software")
> and the commit message ("The netif_needs_gso function then segments it
> in software") don't match what happens on most real NICs. fbnic
> advertises NETIF_F_TSO/TSO6. Did the MSS-sized frames in the QEMU test
> come from the emulated device's TSO rather than from software GSO?
>
> A further concern is that the driver's TSO validation never sees the
> skb in the form that is finally offloaded. i40e and ice drop GSO when
> gso_size < 64 ("We cannot support GSO if the MSS is going to be less
> than 64 bytes"). fbnic checks L2/L3 header length, alignment and
> csum_offset limits. All of these checks are skipped for these skbs.
>
> mlx5 LRO sets gso_size to an average over the aggregated segments:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:mlx5e_build_rx_skb() {
>     ...
>         skb_shinfo(skb)->gso_size =3D DIV_ROUND_UP(cqe_bcnt - hdrlen, lro=
_num_seg);
>     ...
> }
>
> Could a remote peer that sends small segments produce an aggregate that
> gets redirected to i40e or ice as a TSO request with an MSS below 64?
>
> DODGY CHECKSUM_NONE GSO skbs already take this bypass. This patch sends
> every LRO-style CHECKSUM_UNNECESSARY TCP GSO skb through it as well.
>
> Would one of these options give the documented behaviour?
>
> - Clear NETIF_F_GSO_MASK from features for the converted skbs after
>   netif_skb_features().
> - Before netif_skb_features(), turn the skbs into proper
>   CHECKSUM_PARTIAL skbs (cow the header, set csum_start and
>   csum_offset, write the pseudo-header checksum). Then
>   ndo_features_check() validates what is actually offloaded.

Based on earlier conversation the behavior as documented of actually
doing this completely in software would be suboptimal. If we can just
fixup the packets and then send them on then to be segmented by the
hardware this would be preferred.

The original behavior was that these frames were being passed to the
hardware without setting up segmentation. After this change we set the
proper checksum offsets and values and then segment in the hardware.

Based on the fact that GSO_DODGY skbs already had this issue it isn't
an issue that is introduced by this change. If anything it causes the
two to now fall into the same bucket. If needed one thing I could look
at doing would be to also look at setting this bit on the frames that
are coming in and being re-routed to the Tx from a source that is
running LRO.
