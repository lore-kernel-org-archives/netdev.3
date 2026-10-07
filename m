Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE035E1AA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413562; cv=none; b=PL15mIsfz2QaPXdoqIZyLV6vqsXOYCFEUxzn2e76yeIePODtmC1Z3sO/D1ZWS2GMUY5j45ppmX88QF7fYYdWj9ZE20fHaiC5JKBk9/22/EVqUnkicWzmouSlHDKxtA56CIM+yMMHESRgpZUyj4WSXOy9GF4NdcJUTrgYGDh8yG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413562; c=relaxed/simple;
	bh=rHi3QOGQkYBiLmi/4UtGxCYcsTa4jm8Ha2wYxkNQU8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8XjyYbYX63XCys0jU2Ltgu8lu5+getlQu3uv3vLh7jYYh8AR1mXUtrtsxD6uewGLlHZN/lKzR4ZDbHzVQkVYIbPTcRzgBRYyyHtPnd2lm45p1Pn7x7VJaBsdNMCl2M4jHNriLQywMVb34mU02CPfdJhbWk4cVFLUIHbqhKwRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPxc8jHx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL1Qkuc1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPxc8jHx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL1Qkuc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791413560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mn5JR5KJeIzW0pIEO9S0VftR7C9/Cp2du3qx1gR204=;
	b=JPxc8jHxZYGRyP3G+fjvGcmPQWHys6RE7k8pFgqXWLO+oJT2eCdNPLd9K1iJyao0FB2G06
	5YUcfddOf77clO9GO8t6LtHm9O9Q2GpBhNY7QIq09o3U3GM0TrjgC3X42FvQ/suy1RV9BC
	KKMyZNAQlZMn1Z0Xc9tS0EeB6cuVQ2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-6rq3Z71WP-uvViQxXXHyAA-1; Wed, 07 Oct 2026 18:52:38 -0400
X-MC-Unique: 6rq3Z71WP-uvViQxXXHyAA-1
X-Mimecast-MFC-AGG-ID: 6rq3Z71WP-uvViQxXXHyAA_1791413557
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so3217665f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791413557; x=1792018357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mn5JR5KJeIzW0pIEO9S0VftR7C9/Cp2du3qx1gR204=;
        b=VL1Qkuc1C6fG6lbEPQRfmre6nzoWkcSnhAJe4+ZPE1vJT/8JHsCGKda+YHHUCrMGTu
         OKf3fBDTn7B0x8DNiE9y+xmUueldW3aussUT733QjMmCWaFt74iksJmpdQuGHrATFA1X
         q4NpbiSlbIDexemHU2YzwYcgpeZzaQafKq2egfCyH8GDIIF0ETIwZ93JRUZTCHMppbPL
         /+jAHbRWLrx14XiHXoiuU/Brlhna9k8VXX1Tqzv/GYvVNfCb0kcL+HmdxrLJdMoYX+M3
         XyunupYlynqDpqgia9EGbB9Q5zESG33MHVafWx+tzivkSYsWTpMT7KOid+hyy5hqNfjo
         hSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413557; x=1792018357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5mn5JR5KJeIzW0pIEO9S0VftR7C9/Cp2du3qx1gR204=;
        b=GxEQSJ8BD2gy26JDsv5NHi+/LJYpzq4DZxMmBeK9UcSPEDI0PwF7AFJ1/Q8Y5mbNcP
         EUomRt4rsM6gzdm8iY2ikJW4Ia0za0RKCW7TiApoTLcIKYiJAA10SFUSR4IBxGCj7tlF
         86S20MLrRnC1DnDmBUzmURddMsG1OUMdq4hy1v+OeHTzIdxHLEzbo/EkZjQmxwH6FTk9
         aG/2nrMlXwETMhWp2Xn4IDUTSMv+Xn0WXU1y/2UJWjuAdlJ3mNEWcRsBp0P1mTTYV/Gp
         pl0gj4LB6HldtcJjmRdwL54TS3XqOOhMC/fXDmu6WQ8hzNyknVoFF1c5egl19WiAkUtL
         nt5A==
X-Gm-Message-State: AFq9FYLdPSF7HkdKQ9s7TjZ7X6tD+ec3yzbMKtMny4FdbECH50SIA018
	V1/pSwh6bJnTOkPksu+Taq8N4b3REVlWeB8PhnKdGg/ZU9h/Wo2CMoHNmADp5cveu8AQsZEm1OR
	OPXA1ZqmxS5bzVl6cxkC6nkSu3aIksGo9LeQMkSSN0t5q0fcoGoy7IzREJg==
X-Gm-Gg: AYBFou3+6YvOQgGIktRWfZsZbhVFImRrJ/o2WUgb+aA5XgQmA1y350iIj4Rv+pnVMzY
	SudgWT9YGaC2G0b35Dvb8zwyUtof+JiQc7tmTNHrFVD2UwWS5bhGrbF6oviB1bmger6c2gCHyzF
	2MfnZp7eZ/0ns3F+ZgXVLvRWn16EPh3uBJxKDDKqpQtOCsoQ0nDA/KcxFUZ6HcTGeLySTkIHRqA
	sk9P4a6uGcvRoJilsnga4Za7p75K+j8vucooW6+caYXegh8Eg8KeCjTrO1yA/FF2KTWba1HsiPL
	3WJCXocJAlDBidB/tGu/ck9V4/7G1WbI6UkvKdUDCBCZKH01etypiXEDCMiVeEI9nAniLdE=
X-Received: by 2002:a5d:4102:0:b0:48a:f511:e418 with SMTP id ffacd0b85a97d-48c7278b9bdmr5753305f8f.38.1791413557448;
        Wed, 07 Oct 2026 15:52:37 -0700 (PDT)
X-Received: by 2002:a5d:4102:0:b0:48a:f511:e418 with SMTP id ffacd0b85a97d-48c7278b9bdmr5753292f8f.38.1791413556945;
        Wed, 07 Oct 2026 15:52:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d3b502sm8196092f8f.52.2026.10.07.15.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:52:34 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:52:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	andrew+netdev@lunn.ch, jasowangio@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net] net: extend virtio_net_hdr csum_start checks to
 VLAN, IPv6 and IP options
Message-ID: <20261007184354-mutt-send-email-mst@kernel.org>
References: <20261007163819.3041710-1-willemdebruijn.kernel@gmail.com>
 <20261007175957-mutt-send-email-mst@kernel.org>
 <CAF=yD-+ZROFbKoQrgz5kGVXZyCQkvDb_gVv1dLCKTbT31sAQyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-+ZROFbKoQrgz5kGVXZyCQkvDb_gVv1dLCKTbT31sAQyg@mail.gmail.com>

On Wed, Oct 07, 2026 at 06:38:33PM -0400, Willem de Bruijn wrote:
> On Wed, Oct 7, 2026 at 6:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 07, 2026 at 12:36:59PM -0400, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > __virtio_net_hdr_to_skb() validates hdr->csum_start against nh_min_len:
> > >
> > >     if (skb_transport_offset(skb) < nh_min_len)
> > >         return -EINVAL;
> > >
> > > Extend the check to account for the link layer header including VLAN
> > > tags, IPv4 options, and IPv6 other than VIRTIO_NET_HDR_GSO_TCPV6.
> > >
> > > Payload, gso_type and skb->protocol can come from userspace, so cannot
> > > be trusted to be consistent, or correct.
> > >
> > > Therefore:
> > > - For Ethernet packets (ARPHRD_ETHER), parse from ETH_HLEN and
> > >   eth_hdr(skb)->h_proto, advancing past any VLAN tags with
> > >   __vlan_get_protocol().
> > > - For non-Ethernet packets, use skb_network_offset(skb) as nhoff and
> > >   infer the L3 protocol from iph->version at skb->data + nhoff.
> > > - If skb->protocol is set and disagrees with the protocol parsed from
> > >   the packet, enforce the minimum header length of both.
> > > - For non-IP protocols, require only nhoff + nh_min_len. No in-tree
> > >   non-IP protocol generates CHECKSUM_PARTIAL itself. They only carry it
> > >   when encapsulating IP (e.g., MPLS), in which case csum_start lies
> > >   beyond an inner IP header.
> > >
> > > Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > Link: https://lore.kernel.org/netdev/20260922030310.8684-2-habte.yibelo@gmail.com/
> > > Fixes: 49d14b54a527 ("net: test for not too small csum_start in virtio_net_hdr_to_skb()")
> > > Co-developed-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> >
> > This doesn't fix all the issues, or does it?
> 
> It does not.
> 
> > If not, I am confused why we
> > are doing this piecemeal approach. I thought we agreed to
> >
> > a. validate some basic things about the checksum in the core ip stack
> >
> > b. in virtio, validate specific checksum values
> >    and for anything else, fill in the checksum and fragment then
> >    and there
> 
> I understood differently. That the fixes are cumulative, addressing
> different packet types.
> 
> I like your approach of doing checksum calculation early, in
> __virtio_net_hdr_to_skb. I figured that was a follow-up targeting
> net-next, eventually.
> 
> I can drop this if you want to send that instead.

Yes it's net-next material I feel. I don't think I can implement that
today if that is the question. But we can backport later.

But I also am not excited about very clearly UAPI-visible changes
landing in net at the last moment like this.

To me, it seems highly likely someone has a minor
bug in userspace and previously it would just make a bad checksum
and it is dropped, and now it is suddenly failing.

And if we pile up change upon change then what? Do we commit to erroring
out on bad packets? On specific bad packets but not others?  It's UAPI.
If we are not in a terrible rush, I'd rather we did it carefully and
fully.

-- 
MST

