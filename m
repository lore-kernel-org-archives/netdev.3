Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60F376BF2
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791416607; cv=pass; b=UO4hl5hjxR8L1osigrUaaGmGS328yh1OG2oW4LXqwf6I5PiXO4PyACi8Y8WqKLev0HoULbBelmFdSuTF2g3bV1OaP8bHglsuStJhYfX7goOxvH0hrVu7zkmhBBSLyp2fnNSAit3IoIiZwAjqc96dP/u+C4XqSuPT0UCkAFcaJaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791416607; c=relaxed/simple;
	bh=m1FZg9IRle3R56VdFr5o49E5nF8+aN/U5G40+6xfSa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCg5qT51aVXYazuIaaBYjrIkWG0O2QrJ688AvXAgvVRcPhARb3Z6xtHxIu5fhNbNSRhvn7llKPgs2ft5GzvRg2uycD0PYDbRluLS8OvXU435xqxoEDFrQhBwDSgh9JrTxMmxvP9UyOuYm9R68XfH6uENbyhhJQIgTo5IXmD3jAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVDSQxfO; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVDSQxfO"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6714595153cso143537d50.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 16:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791416605; cv=none;
        d=google.com; s=arc-20260327;
        b=gWwuwXL3U8JbmG3vcPR9GYyFXMAMsBGwUqZdRVmzmZ1Vg0iWJsS4yAL/JIHnPFLcsg
         GIRbO/qSy1RQpazu4/um757LNwRu8aRe35Qa6gcP1e5E/6jPqy5T2yfmExa0IQrMe6i/
         kIff+nzc7st9AW2n0yo+V4NomNLnLGyKsBZj7WOYLrOW+ul0MHC+VOqLfw2kOEQbr5zX
         PHHt3FAIV+2VNRli3AkWBOYwauBAK5tZyMLqSJdzjwbVTUpDhJ9blIcN8GJqPCXmjuRX
         E9yQj3Ny11bCdLinkwyevKRNlgwcl5Yc7H36OA7nwOlO0ymy5xNaZiJCQZwQPO9TtCia
         j0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cEPAA3AIBaloXxDElVpYTXMx5dpODNCwtanJHbED8ZQ=;
        fh=prAcYyk7LBQZ2PBeU1QLCT/hpa9EVwGiCIQoO6FZLfk=;
        b=iJ8fQA96d9lz79Xp/OIgVBV8zffJKH/lkrTC/bE2EzDq15O7NE42V2AJ3DeHl7ZWS+
         FVL8f6+QeKxz/WTVi/9cQZ+EQqLFD4Zk48JR/kb9tIfk6tydUyHhxrMNJFhSU69Z+jJj
         QwZyqU3fOnXeWOuRM/jTbFKRErZli8IB2/mGBm7Lc0hCAZawH+E97oc37NdIU1B4O+5D
         V//tgImHZVvbk0VW6WHa2BK+WDgDev7uxbOSmktgmQm1N8ECL0qdEgfKlvGbknmO+Qn4
         lBH1Z2Lix+/0zCltdwBcFv51mJ3AQiFZ5JK4n1a+5b/PKVtF8iy4iZ46ByqBVgsMTgPi
         XXEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791416605; x=1792021405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEPAA3AIBaloXxDElVpYTXMx5dpODNCwtanJHbED8ZQ=;
        b=VVDSQxfOrlt78IYiKnOY05C4PsbJR4Say11Cpcu8OKZyfgGhx78olI9uhQqtFzjlVt
         A8cWt9qJcSJ+B+O/yloaxIPOf+seanT0zJwajfaSek1EuLwAR2nQaSgYf8mPKHGJquBi
         8r95x4oVlOkjMGuJ+cDW6pwHu0Hhoja+9XO3fWc58ILLx4CKPKUjB9AEgO+G4KKK/jSb
         QVwcvFGTZX55yAJbqpEhEggE2IqfrzXhWwbhKMRJPNn72CXpq5Zvbe5pflQHAV5SsMBG
         0cwbsSyXR3LE+8r8xm5x1Zj5uBi7x10y11wYqB/3Uo3oENFS/M4TDctq1RogeSpEltu/
         kaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791416605; x=1792021405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEPAA3AIBaloXxDElVpYTXMx5dpODNCwtanJHbED8ZQ=;
        b=ptvlMarMgq3le6W5jj0XEUtsTWVlT+v9ubAzgAhvLbG9NcWhHBeNp8ezz3HgHXwERA
         bjnJeDf5DtO0XZC2JWPVhekSGznV1McDj05+j4YmaiS4pMwjEsxwxWAO5bdA1o8yZqzo
         1TN6Zh3sjcYjmrJaJ7DRpNpBtZlWJTyujYClYBxVsLSqojbtFh4GxRc6+JbLuaBDF4AX
         LwXAKTXK5gw7UMzrOYljsLx6icNaDz8EhsiPy95wf5R5vXt3dnraFZaezPpBHyvtc5wd
         8OVw3hbmEAIMHHdtpYkMU/Hs4c7QoZKZHwnLaoUeSuodu9xROTTJ7oTF+MPC85AKasqM
         LljA==
X-Gm-Message-State: AFq9FYIGImqigmf/LT1k2iv1INlu0/BhCeE90Stk/78wVQrb+Ft3caoJ
	hKuZjjRM8jM+1lQKTP1zZxlV4ANXXaK6ERgvl4WBGFU4YxdKVlMa25yBXHuKcQC+sl/cIYaosmC
	vLCv+WFH2nzB5iSHQtK6SSR2hosjSAd0=
X-Gm-Gg: AYBFou0fUCG7S3hl3y6t7kwztzvcexVZoBum5QosF98pFRfzgBx/vsTzWKksDFcyAQ5
	iFBJoE/ozKEzFRZylLpvmdWRWPNJMW9s2X9SUGFKXLhq3cPSXVEJ0BWoVQ/Gt9gzdnK2Cp9DlpQ
	V0Cd1Yi4NTdA3lCNlFJgE7y0cwZWJJdNMA0o/uZTcQSr/WddUE4t//ft+c/nEFenUbrV3qWeozh
	+8X5ySagS9C1JQxxWLre7t0LGoXAzTZ84SaJJfo/OArubgk5uWkz+nR+o0Ql87zepGPcPFL+9jb
	MleCKGWGZSUoBW0iqXn/ATC8+P1EpqEK22xUePdvi84ZGGY+z/Q9nXAx6O/rSnD0B3EzBv4+2GY
	Fv7MT/249EWNHk4zt91ZDDoAluxr3b6FfAs2n24Zcnsz6wF7vxtIHr9oTOdq9bWWKW7KPtgPsH8
	c=
X-Received: by 2002:a05:690e:14cc:b0:675:300c:3938 with SMTP id
 956f58d0204a3-67922f34d7amr351142d50.14.1791416604648; Wed, 07 Oct 2026
 16:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <20261007175957-mutt-send-email-mst@kernel.org> <CAF=yD-+ZROFbKoQrgz5kGVXZyCQkvDb_gVv1dLCKTbT31sAQyg@mail.gmail.com>
 <20261007184354-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261007184354-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Oct 2026 19:42:47 -0400
X-Gm-Features: AclHuK8RNTVzBROlCfjvRCboyUbQQ0Vi1Ra_p2T692m0HrG_SeDmZm7dKCBzRWU
Message-ID: <CAF=yD-Jd_YDTjiYSyo1Ad+ddumdw51UC1ibZik5n1_Nze7cZWw@mail.gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, jasowangio@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Paulos Yibelo <habte.yibelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Oct 07, 2026 at 06:38:33PM -0400, Willem de Bruijn wrote:
> > On Wed, Oct 7, 2026 at 6:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Oct 07, 2026 at 12:36:59PM -0400, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > __virtio_net_hdr_to_skb() validates hdr->csum_start against nh_min_=
len:
> > > >
> > > >     if (skb_transport_offset(skb) < nh_min_len)
> > > >         return -EINVAL;
> > > >
> > > > Extend the check to account for the link layer header including VLA=
N
> > > > tags, IPv4 options, and IPv6 other than VIRTIO_NET_HDR_GSO_TCPV6.
> > > >
> > > > Payload, gso_type and skb->protocol can come from userspace, so can=
not
> > > > be trusted to be consistent, or correct.
> > > >
> > > > Therefore:
> > > > - For Ethernet packets (ARPHRD_ETHER), parse from ETH_HLEN and
> > > >   eth_hdr(skb)->h_proto, advancing past any VLAN tags with
> > > >   __vlan_get_protocol().
> > > > - For non-Ethernet packets, use skb_network_offset(skb) as nhoff an=
d
> > > >   infer the L3 protocol from iph->version at skb->data + nhoff.
> > > > - If skb->protocol is set and disagrees with the protocol parsed fr=
om
> > > >   the packet, enforce the minimum header length of both.
> > > > - For non-IP protocols, require only nhoff + nh_min_len. No in-tree
> > > >   non-IP protocol generates CHECKSUM_PARTIAL itself. They only carr=
y it
> > > >   when encapsulating IP (e.g., MPLS), in which case csum_start lies
> > > >   beyond an inner IP header.
> > > >
> > > > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yi=
belo@gmail.com/
> > > > Fixes: 49d14b54a527 ("net: test for not too small csum_start in vir=
tio_net_hdr_to_skb()")
> > > > Co-developed-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > >
> > > This doesn't fix all the issues, or does it?
> >
> > It does not.
> >
> > > If not, I am confused why we
> > > are doing this piecemeal approach. I thought we agreed to
> > >
> > > a. validate some basic things about the checksum in the core ip stack
> > >
> > > b. in virtio, validate specific checksum values
> > >    and for anything else, fill in the checksum and fragment then
> > >    and there
> >
> > I understood differently. That the fixes are cumulative, addressing
> > different packet types.
> >
> > I like your approach of doing checksum calculation early, in
> > __virtio_net_hdr_to_skb. I figured that was a follow-up targeting
> > net-next, eventually.
> >
> > I can drop this if you want to send that instead.
>
> Yes it's net-next material I feel. I don't think I can implement that
> today if that is the question. But we can backport later.
>
> But I also am not excited about very clearly UAPI-visible changes
> landing in net at the last moment like this.
>
> To me, it seems highly likely someone has a minor
> bug in userspace and previously it would just make a bad checksum
> and it is dropped, and now it is suddenly failing.

Would it be better if we pass the packets along, but strip the
checksum offload request?

That is not feasible for GSO packets, only, as checksum offload
there is implied.

In many cases, it may be that the software gso stack only validates
the packets, then drops SKB_GSO_DODGY and still sends them
on for HW TSO (see NETIF_F_GSO_ROBUST in tcp_gso_segment).
But we cannot rely on that always being the case (e.g., if TSO is off).

> And if we pile up change upon change then what? Do we commit to erroring
> out on bad packets? On specific bad packets but not others?  It's UAPI.

My fingers _are_ itching to drop all of them.. but you're right: I
understand why we need to be lenient.





> If we are not in a terrible rush, I'd rather we did it carefully and
> fully.
>
> --
> MST
>
