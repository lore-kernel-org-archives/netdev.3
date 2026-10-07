Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FA376BF2
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412754; cv=pass; b=iN0vDZ/sWJ2lan/8EV8qf1EGsLTvqEwDeX7ofW0f7qjVBIX3VfjT2R2FzKvsOpgfmzcafccF853BuxQ3EuEvq8LREvTwjuXgoZwACEWJeULxwlXegLw8g6GN7O7gqFw/e6GOu+jvxgr2CVu0DTsdV8fb65PyzB9vRqhqWsD9ses=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412754; c=relaxed/simple;
	bh=9YE+7SdzL12MMmsZnHCxlOKS1BjhAcA2JVU3YT1VOZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsOKW5TFfZtQfc8p18GtjyX65mvcYMkQ64uoGL/S8JvvIcaGeK5Zgww4yIQ5YIy65U8DpCsbvseFJ6FhCRN1KqUPse0pWNUleMR+Lgsu0WWyEfDfOR+C+1QV+heQjouy20Qs2feumOXi77W5NOYPCqps3BHjIlcIWr30QAFi4Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfY1veIk; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfY1veIk"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8acda240937so23583957b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791412752; cv=none;
        d=google.com; s=arc-20260327;
        b=XZHQ2nE3LkHKDvdH+e1nUIvGW1N2hNW7w88T8zFudjTbY/Z1F3kKM8XR5LIJ0scps8
         gybT0b/aRtOjvrnpcNtADqfNhk8G0VraroGQGmcsSxqnCkM+MhqTgfnPmsIIY/aEkvrJ
         9dFElEquBBpm5S+CFwOHFzidPpUW7fWfLpaND/xcuLhfg1UGSh3MXvDC0NarXd6KUtT+
         dHC3w+2PNrwbjDlnrA3vBAkl0LXb9qPyzV4z6AKWc90eVFw11B9voGa9tnK/talvpbgb
         Wt12ucpOpgJGl5xJsDI6EozzaDjv2GMtg+4dWsLnS+9dLWsuiEFDelo/kqfOgVGhBNJG
         AJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DYEXY0B5hFYJk51zihosshCLsKJqV7W2dSbnFA/pTAg=;
        fh=prAcYyk7LBQZ2PBeU1QLCT/hpa9EVwGiCIQoO6FZLfk=;
        b=mDp4G/oCdEXpGVYTU9TO50KZG9kjeWjR0Ms3iqZU3NrHiIsZgVZxmsw+B4UoWkCL6l
         T8KgRf6j3RbfkuHalJxP+MZ0jthz1KdNb/gRjZsvVxB0IzJwatK3yMSkanlb6+BrAlj0
         ol9k1O7NA6bASY5hm8V1U/KTVSrOtvLyiHh4OJo3FYLdWwlGozcni9T6H8FIFkGF7kQq
         3JskEbulefMy2Fla9eq+iVt01m6fzL1o+7p4PBbA27TRKhg5KptLODn6hbUfwVAfsC1c
         dLiEEyqN3kxINq1vx19kwuxqTtaVMG8AnCDPUrefDbKmUoxiW5Vo2gUnQNXBljEOVX1i
         zhKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412752; x=1792017552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYEXY0B5hFYJk51zihosshCLsKJqV7W2dSbnFA/pTAg=;
        b=lfY1veIkAl4DofviDZGs8oI4gfHKbRnFqWIEubWYY5tOHLAmBoJzEYDxZ/mexzS41L
         /tGOS4p4X5p5CBs+NuYKY+2/RaFOK5cTeelROGS5V8sFyfIUp5e/LIckVI5tDfijg2j8
         xxfiyRdPILw0RG+lwK3pT2CwEs2+Qh+Vn4X5+bLL91dR8/X5edjObiCVlwIdsHcv0KBQ
         H1sYQRB9QUIp+X+gkMvSeDb7q2U4G2N/l3S55NF6wJs8Zv8bKvuJXGm4u91GIo+dm0fn
         eIZ8Gxduw2oEGfiDnMCt5GZg8+LIP/N/yAvoUUYSpzjLohq2U8zzSKpXx48tbfRnTV/i
         QZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412752; x=1792017552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYEXY0B5hFYJk51zihosshCLsKJqV7W2dSbnFA/pTAg=;
        b=kwAHPIJUgrUgZz9wVxd6N19O68MEopipdTC8SONcdYii1OlE4D3yfOjB/guyADJuRJ
         WBiKyc68QAdoc4Ve6PnbkIx6pGIiqAYtA1DbUb4Ijo1nBYAbY0ofx0Izt/6A1zQheVaM
         5EEZotN4ggLoJBJo2mDpjy6GqHDQjZWGHk/JxAyGRCqIT6zHL/H9GthJHXmkyXVLfeOg
         j9SVHbZGvNmtXbCYyq7kJKLV5qgkt2wtZXI/u9VrypB48HOda5ke+OjGL83AyiIQ3X5r
         jDqTKhEaXWV/3IWRkDSV/8GmOsm52FnvUorjpmA7F4usYYrNCsjepBQlHN+OGtZyPV3u
         2FpA==
X-Gm-Message-State: AFq9FYKFaYSo5S5b8nJBQB9YL0frCoBLLAi6Y5hoOqKejvqfkWdi5H2S
	U3JaZrJtCTQjGkTxA3JXRGIS+32cLVapeqYq4vAG737lYPnLoq2r2SD1DFA/VI9825OddbUEG7v
	f6Af4NoZ4lsm6Zr1ztIDAlrFYayuP3y4=
X-Gm-Gg: AYBFou17LZQXu1CT0TKQC3BIX2BoXN8p7Frg8L2yDRDdnW9U/2aHYhxfSXM+OzhOhJB
	3SgSWF+RiU8lmAOYRcr+MEaDJNmhZknUKT4rrLM2sMS3F6KcWk70uqBx8++0M00A154OMEBRThf
	I4UihMm4wHmG5D9DQ2XY/eLn7EAjLy6HPoQ9J99Jar72Z7YVu31EIvIQdJYpQgXu7RwCU9MjQ1q
	T8pajM32xbbStHUL4Alsri/FO93lOkxVY0cQx1lA8SURVJY38P22d5C/hXSjaey1cGdpdz+1YNj
	QNgJRB1Mwz8L4kWfE9j8TDfTU7WOVm8DwYv409ktYgpT5oPOn1CByc4TWC5fA6l1JEvetCRiZv/
	Eivzwd+ec3pSj9+5O2VHzw9dEt1TLj/a61Oqd2FRVnzNHm+78MKCVg/jL+7y6+QpsP3298chI4v
	A=
X-Received: by 2002:a05:690e:d0a:b0:679:a58:163b with SMTP id
 956f58d0204a3-6790a58268cmr1634598d50.35.1791412751554; Wed, 07 Oct 2026
 15:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com> <20261007175957-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261007175957-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Oct 2026 18:38:33 -0400
X-Gm-Features: AclHuK9_coDhnO3XH0BEgQZ_YinL5GPdy0h9l8h1EUlVkCnpmjT-9HARaxV3vWE
Message-ID: <CAF=yD-+ZROFbKoQrgz5kGVXZyCQkvDb_gVv1dLCKTbT31sAQyg@mail.gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to VLAN,
 IPv6 and IP options
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, jasowangio@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Paulos Yibelo <habte.yibelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 6:03=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Oct 07, 2026 at 12:36:59PM -0400, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > __virtio_net_hdr_to_skb() validates hdr->csum_start against nh_min_len:
> >
> >     if (skb_transport_offset(skb) < nh_min_len)
> >         return -EINVAL;
> >
> > Extend the check to account for the link layer header including VLAN
> > tags, IPv4 options, and IPv6 other than VIRTIO_NET_HDR_GSO_TCPV6.
> >
> > Payload, gso_type and skb->protocol can come from userspace, so cannot
> > be trusted to be consistent, or correct.
> >
> > Therefore:
> > - For Ethernet packets (ARPHRD_ETHER), parse from ETH_HLEN and
> >   eth_hdr(skb)->h_proto, advancing past any VLAN tags with
> >   __vlan_get_protocol().
> > - For non-Ethernet packets, use skb_network_offset(skb) as nhoff and
> >   infer the L3 protocol from iph->version at skb->data + nhoff.
> > - If skb->protocol is set and disagrees with the protocol parsed from
> >   the packet, enforce the minimum header length of both.
> > - For non-IP protocols, require only nhoff + nh_min_len. No in-tree
> >   non-IP protocol generates CHECKSUM_PARTIAL itself. They only carry it
> >   when encapsulating IP (e.g., MPLS), in which case csum_start lies
> >   beyond an inner IP header.
> >
> > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo=
@gmail.com/
> > Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_=
net_hdr_to_skb()")
> > Co-developed-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> This doesn't fix all the issues, or does it?

It does not.

> If not, I am confused why we
> are doing this piecemeal approach. I thought we agreed to
>
> a. validate some basic things about the checksum in the core ip stack
>
> b. in virtio, validate specific checksum values
>    and for anything else, fill in the checksum and fragment then
>    and there

I understood differently. That the fixes are cumulative, addressing
different packet types.

I like your approach of doing checksum calculation early, in
__virtio_net_hdr_to_skb. I figured that was a follow-up targeting
net-next, eventually.

I can drop this if you want to send that instead.
