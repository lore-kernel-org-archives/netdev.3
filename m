Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3848F03A
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990718; cv=pass; b=GGkJvf6RIvTHNv/nTC9oc5QZwd7e3HijhRitFSIQE+E1teYgZZLCU2ium9Cpk8mXRGPBEk5/C+5cbIWz+cr9BT/2AryzFQYMlIctqSoqhO014raQuHKNBfBs68KAAVurJVdRtN/ZOeefGhY0lY12yPJc4WRsTxJIHXhbCgR9itc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990718; c=relaxed/simple;
	bh=Wdp5fa7wpUtnmnOPRUiNG8VmwpeuTY/AN0sHfo1zbhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MedE3D0U8nUGHrtIsC7E3cuEzyttoLIuLPrnKEtHOyNstlabXW7FZgO1gMkLJpLI97hqLISY+lpfGCjcjOwLY+62tyxvaN0uF8TN2GenbXJOeUNisnHNWBFh/MGWuT0BWs5jnuYASeLeCciTEApE1BK4sPyQX7zAP7tCtvdh7ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY5gWOLD; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY5gWOLD"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a30eb3bso1758598b6e.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 04:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789990715; cv=none;
        d=google.com; s=arc-20260327;
        b=IaXWdWabIZqFqF6YqRHnrh+hbU2zxMp+6eQKA/z5Im6OGy9lac3CThCvTBrb9pEzWc
         RyIqJXcb7I8P+AH3mE2197N3+Oy0YlYwrdR8TjyHiTbL5Xq3lfIBtJdTKcXeGChNFRe0
         5sinZBzLdaqHFGvhUvcyyaTsy9pNhTIe6G1q8dOPGe8pWQwaS4DY56/10qmSgYK4c6fM
         U6Evy6VF5YBdkbco5E2jB2/vZcViAJdwvJCBaxGf6kRistJU//N5OTsZXALMRmHmNnnd
         5y9ilX6yOdxdyM8OplmxUxqXJqA3t9AehydzrF2lrmx4v6j5bxZOETpJavIeV68Y6oTb
         DLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9sNrUr+jad3Tl28tFEmsrKuGEDrRBiHkzmqFkjdqgIw=;
        fh=U+4a7sg/TWuL4BVEFfO6SUlDKzsa+b9UhsFeBUNGmSg=;
        b=Q5UWizV0uPZRqgI08p9TWsHBCSqW6PSxbrryPWnCdjfEAmKhXb3JSdb82PRfU/b+Mp
         0bSYrE1y9EDi9vvCj2qjlEJ+JjbPFbXhZeXpzXH5e5zKuy1mv51oBDA/6J4qBVlNKcUa
         MdDH1/ppMyLqPoygDCD3cxISGECVJsYVOscfYHdH7CQ8Fzj+pJ8QasZskQ5Wfrt+YRyI
         SS1HGFnb3OsJYuTB4Ds0/PLqJ6hOQXzZJB3YnZUuxB/BdBkK2sWu2l0uNhylkwnBXEyB
         M05DjdwxELVZuqLY6equ7CuC/n0iiRgVUpjypPCo+iyba6xYVGgceD5R266eryWOFXH6
         VZgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789990715; x=1790595515; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sNrUr+jad3Tl28tFEmsrKuGEDrRBiHkzmqFkjdqgIw=;
        b=NY5gWOLDbzEsAYjAAFHaoq2pSBopWmZB1M/pL8mjPV1nQAjtuH9vs7FmJSENxkNKiZ
         /Me2QtGjtLafcQymFZy7G0+sDXHB/dTSzlhiBXzXP5pc+eVuA/3R+spwvBc73O6h89ex
         CY+8fxNKZ8nUo1vmaA8FKjA0HqPnSQJsK+FzduLyXK/rqaLDwxZ2ek9w2YLhjZtiBVNn
         LrN98r9vtQszmSIh2w/i4ApaDrid+RaUEKXqKvUHYvXkRht/Ls8T+FzGLNty8iTy3aqm
         f/Yhbaw4u1z53ynL6+dwULxvTBkZNRJ2KgXxBwqMX1Zti0eaKcJN6XE4N9ZlzQx2H1mS
         0fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990715; x=1790595515;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9sNrUr+jad3Tl28tFEmsrKuGEDrRBiHkzmqFkjdqgIw=;
        b=ax+eSqKDR3FTz2wazAura0ar/JnT44R2yQ7R7fqk/TwQXn/ti0jdIxAlcjQnUht/Rs
         sXH5fLRawlIZU6nxIY22P4zvZ/1SklIofiImRKsxrTw1wsQdnmEoyiGCAy5MGZmhP+/K
         jl42v0F7Gm1Kg45CFBs1nqGpdNEOVX7Gc6xm0mBY/cbHVdLyT5DuOHbwYM6dyND20wdj
         7q+osSnBsGhsgermeTC1TCQmjW0idGKTZ4OG03aVxJ4r/lGCG1Au6fHHVxi+SUuMHLom
         Lq9RX/3Et4DvR+w6HST0c8C42NZiRmJvOKSYYmZRfrUU/p+AvIHVnSgSsuhFHct+dBn5
         pWbw==
X-Gm-Message-State: AFuF++kFaaHDMrx36rn/aFr9XV8Y0dTSUxCTJU55QDgGRc1fai5/Z78r
	IAJ9EkfJkI81sLr7iI36TE/f2UEjrqHeBeRVRQvS3kKbDPhQOVcECji/0ZiDwBfZf/JaxBFsT+E
	OTdm/9ZxtQZZSy5XaAqAjGOOqWV7Mg1EbUQQR
X-Gm-Gg: AYBFou22rIu2xNbcZ5eW/iALrP/T9HlGOD9cucxAJ1eP54eYEbjLcB0HMoSXr8Y+833
	KOMbLdy11J7ICLfKkU2WhqU43+gOygYslRsSlrKwsNurlLzh+icgdLAecfxzvg4BDXPKO+zUXZE
	/6QvQ6ESTYBth4+PS/hzGa1p2S9pGRrvwHZI3NkbR9xEyfDAGOPdXZs2KASo9NUMBf9gUzRQcpb
	fCxQ2QIUidqcBSLZkm7EkqlMAlQWKd1/9FlEq4AbScuO29ChsQBMTzDs7SgCoQmg/WH6cyA0tWQ
	l1ooB3RLYXpmI9N1+t3N3U++iMyBy+2ZuQiXPXbUg8rKEBCO0/4cTQF7oA==
X-Received: by 2002:a05:6820:4b86:b0:6c9:80d8:a1f5 with SMTP id
 006d021491bc7-6ca9cb5e01amr10711323eaf.50.1789990715296; Mon, 21 Sep 2026
 04:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>
In-Reply-To: <CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com>
From: Stefano Sasso <stesasso@gmail.com>
Date: Mon, 21 Sep 2026 13:38:23 +0200
X-Gm-Features: AcwNN1WjT8KPBvzATRlJSg-_sEHzX1wCRTtWTkB2fe-R482GL2cs_EN1Yg8W8Kk
Message-ID: <CALtE317EzDwKn_Ny8O8wZCFi+OAH4jsXzBBEDh==D5ubObOtpA@mail.gmail.com>
Subject: Re: [BUG] vrf: attaching a packet tap to a VRF device corrupts
 skb->csum for packets from L3 ingress devices (Udp6InCsumErrors, packets dropped)
To: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,
  I would like to follow up on this, since it seems I got no responses.

> Attaching a packet tap (tcpdump/dumpcap, i.e. anything that populates
> `vrf_dev->ptype_all`) to a VRF device causes incoming UDP datagrams to be
> dropped with `Udp6InCsumErrors`, when:
>
> - the packet arrives on an ingress device with no `header_ops`
>   (ARPHRD_NONE: tun, ip6tnl, gre, wireguard...) that is enslaved to
> that VRF, and
> - the skb is in `CHECKSUM_COMPLETE` state by the time it reaches
>   `vrf_ip6_rcv()` (in my case because conntrack software-verified the checksum
>   in PREROUTING).
>
> Stop the capture and the packets are delivered again. Start it and they are
> dropped again. Capturing on the enslaved ingress device instead of on the VRF
> device is harmless.
>
> IPv4 should be affected identically, since `vrf_ip_rcv()` uses the same helper.
> I only tested IPv6.

Please let me know if there's anything else I can or need to do - or
if the previous mail is enough and now I only need to hope for a patch
:)

thanks again,
Stefano
