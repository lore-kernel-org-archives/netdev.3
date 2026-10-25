Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918210;
	b=MWEKe94qHDUHh1A/YRKOnflCC6dTtFxMjG9sG7o6PbP3kAXF5Aw3KqZ26b9Mgm8iiYwl
	 jnK/2IhPEALlvZkSEh+Mey0yD/iMMwZc9GqgDeDLnncyU+NNcCtDozf/WWiBRfK4apGIy
	 mMbG+OgWez4s5Z5OK57QadEaAkzmELBv81XPJhx8Y7M5biTR/YSN9fAjO6lsDj0kpiuz/
	 Yqa9dIYKBgzUNbfTe/3m8kWL/t86Z+VvexJuH/fEprhV+EdTm/dhmWfyAf+Ab1GYwqpiw
	 NNzaofA0aPN4NmTiI94oilA/983IpWTo369c/+Yo2hibKs+1Q/VAzSkkYeNWKGTkQUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918210;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Xdee7ulKGFI68bzq8UkOeGOJEGYrdZ0muM6UpNWMrAk=;
	b=DAD3JxKIRexMxV9X7Hj26a6k7IR3s2V8wAVAu7vIwq3nvO4ZSZ+VcOpVl5qJTirXWHq5
	 dc5aPu5XuCqXHIX2BgKedBCjRq912MchTurEbPTFPujqYxVVvZwub2EWtpVz30czO+IYD
	 Ab09ms6tf/tO3d4WtcPjR1QgN5hMISQXMtm2z7IknDoZnE1dyFfWH1bHyFhksPjNjM9cC
	 mVl3x58wlGWyIqck12U9Mt0dkNjgx64yY+80mYYgvvJNixwpqXH/xPUghLvDy7OQ3aeLP
	 G+EMcJhcIBwwAfDni2ZsDzMT3JsFjfNrMkdoccwaJch9E6J7DCc9KVB50S9IAXohhSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SM5oQuSN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RUjQxiMk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86224606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 08:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86224606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SM5oQuSN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RUjQxiMk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792918208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdee7ulKGFI68bzq8UkOeGOJEGYrdZ0muM6UpNWMrAk=;
	b=SM5oQuSNn56Mcj8yFxD9GRfwzWsdaAEt19Q2tzRymvxNno6sLEW+cuOyOHo6gRaapQdHyr
	WYjj76hJXb4CnJXfVy6IsBObQ3INW7bsgsKr4NBjvVVZ7HXti0obtGa2nNjMjB+D/RGBfy
	wLhNgFOpL9j2l4oNNUEc9i3Q/eaWdqE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-hvONW5jcPoqDZUyRENi8zA-1; Sun, 25 Oct 2026 04:50:07 -0400
X-MC-Unique: hvONW5jcPoqDZUyRENi8zA-1
X-Mimecast-MFC-AGG-ID: hvONW5jcPoqDZUyRENi8zA_1792918206
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so1771853f8f.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792918206; x=1793523006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xdee7ulKGFI68bzq8UkOeGOJEGYrdZ0muM6UpNWMrAk=;
        b=RUjQxiMk/GjBSSUCmrZGJTN1LKrN9Vl7gvbyXa3m1l1lgDySn3ZvbFBN133FxRluJO
         gPo1Pl/OrfhUwYCaNKonpSHZq6/GwAPRQtQrFlXyB2t9+rmA+Y4dFIs/Q3LRI2jkv9i4
         Es7U1NsTBLUnBomIDpfD45L+M9vUcVX7s+0qPHC0P9kqTSwFIQIZAnUZnNnGYqV0EsH7
         8fF/BF+eq0TQgB2zb9ObmSQYjARFq4SHaZLvh99xxm+6CMB/Eez6yiV96z+h8vRpeUMx
         0Gwl8NTI8I4QQeUKiZf3sZfV3bl3IAft36jEH0+5B4tSSYDHGA+Ii22+21PCWnnPyO9y
         NrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918206; x=1793523006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Xdee7ulKGFI68bzq8UkOeGOJEGYrdZ0muM6UpNWMrAk=;
        b=Yz/g32DyOAIaC50gPB1Hg4oPaOL0mAn4YhTfuzW7zNdNosTYI+BA4hgYTcHbYB/1ku
         pyun2CcSOUru99c2hrbQvQdAxJdufcTWIWiXhXX4k/gfE+IYgCAFFtjSh9CO6f2f9+5r
         rWBFrnmkBqts6Lcgg4Ww+cCTOs6n4P9D1z3mhoqzXBOoMD6C3RtpYIBfdJr5Opm/JUQo
         7eSmubWotfI7OSkpUYCnam9x5FaZtIEv6oCITncbALVQshKhCnPRoCyyRHdxGt05XZGO
         fPizVjlDLhldkExTmpruoBj0TPzQSGLYK4iYc+mp68PesDw3h8X7IZnti5R+AjMzDa4U
         RB/w==
X-Forwarded-Encrypted: i=1; AKwUvBzYNoEqPRJQgF1oBzbT2y2SX9w5w6oj25o1Z9u6Lnv6AC5ZwgwfE0gKTWy+yHB3g4ZN3lI5R9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN93pDxKNmE/db7fpthpQWPlyZdteY4iA5GROOwRlBRmURyAl3
	qgBPz9W9TeBWrCxOqdjAhZg6CXCMvbN1hPoOX2wuDYkM25rb0H5G/cXvVWeWWrsnbhUfDi5KCdi
	iTGjDAgM06mLUgapvmd6nfXPp7aMcpauwC/q6rW/8kHJBUmuu0KyNtGQhXw==
X-Gm-Gg: AYBFou2bqx/p8/NHE7975n/O99z+dJa5ahyreBDRujtkxZKruPs1okXTxcya61GC8fx
	6I/vu1MA5cjS4NPSG7YcPZUel7gNfByhU7EQ5MwjL36zfvEaHKUctCzS6gPZsJ/gjVJGTm2jYiZ
	Hv/TgP09RSLH62eZIDVO3jO7CpW8HIkWQAQeSk9WCFH4NuiTsSdkpnfr7Q3+w4OTFSP5jO40CcS
	BpFQLK2s00nuTOKvko1UxRlZZU0JV0eCFUZTkUFMXiGIAvu31ZvuKbpol6RXBwpA+8CXzzYD0kY
	SzvPm6KcrkqF7U/Bg2qeNfCbMVm/x2JLXm3okdQRBADjIrZAmYXgZlGs8wvPvruCtj0=
X-Received: by 2002:a05:600c:6095:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4a35ac8bf3amr54538875e9.11.1792918205667;
        Sun, 25 Oct 2026 01:50:05 -0700 (PDT)
X-Received: by 2002:a05:600c:6095:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4a35ac8bf3amr54538445e9.11.1792918205058;
        Sun, 25 Oct 2026 01:50:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48eesm8909392f8f.30.2026.10.25.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 01:50:03 -0700 (PDT)
Date: Sun, 25 Oct 2026 04:50:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Claude Code <noreply@anthropic.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] skbuff: keep accesses through unset transport header
 in bounds
Message-ID: <20261025044225-mutt-send-email-mst@kernel.org>
References: <0bdcbe2ab5ffc86ba7190fe25476bcebcb967310.1792844270.git.mst@redhat.com>
 <CAL4WiipHjseFcNaqaufAf5C7d3J5e6aLZBTsehJuJyR2m7G1Hg@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiipHjseFcNaqaufAf5C7d3J5e6aLZBTsehJuJyR2m7G1Hg@mail.gmail.com>

On Sun, Oct 25, 2026 at 09:18:14AM +0100, Eric Dumazet wrote:
> Le sam. 24 oct. 2026 à 14:56, Michael S. Tsirkin <mst@redhat.com> a écrit :
> >
> > Commit 2170a1f09148 ("net: no longer reset transport_header in
> > __netif_receive_skb_core()") stopped the receive path from pretending
> > that an unset transport header starts at the network header - but only
> > on CONFIG_DEBUG_NET=y builds, the idea being that fuzzers and CI could
> > catch stacks reading a transport header where none was ever established.
> > And the plan is to drop this for release as well.
> >
> > Indeed, under KASAN, an access through the unset offset produces a
> > slab-out-of-bounds splat, which is how these bugs are usually found.
> > But a regular debug build has no such safety net: the accesses land at
> > skb->head + 0xffff, some 64K past the packet data.
> >
> > I don't think release builds are exposed to oob in this way, but I want
> > to make the stack a bit more robust if yes.
> 
> 
> This is not a net candidate: there is no bug in release builds, since
> __netif_receive_skb_core() still resets the transport header when
> CONFIG_DEBUG_NET is not set. The Fixes: tag points to a commit doing
> exactly what it was meant to do.

Good point.

> 
> >  While I appreciate a nice
> > KASAN splat as much as the next developer, making even a debug kernel do
> > oob accesses was never the point of the exercise.
> >
> > Make skb_transport_header(), and its inner variant, verify and WARN,
> > then fall back to the network header position when the transport header
> > was not set. This way, accesses stay within the packet.
> 
> This adds a test and a conditional branch in a very hot helper
> (tcp_hdr(), udp_hdr(), skb_transport_offset()...), inlined in hundreds
> of places, for all builds, to protect CONFIG_DEBUG_NET=y builds only.

Good point. I'll put this in ifdef CONFIG_DEBUG_NET then?

> Falling back to the network header is also what 2170a1f09148 wanted
> to stop doing: pretending transport and network headers are the same
> is wrong, and silently hides the bug after the first WARN_ON_ONCE().
> KASAN would no longer report anything.

But the bug already manifested with a warning, why do we want
also the kasan splat much later? And why do we want memory
silently corrupted on non KASAN builds with CONFIG_DEBUG_NET?


> >
> > An extra benefit is that release and debug kernels now behave
> > identically if an unset transport header is ever reached,
> > avoids heisenbugs.
> >
> 
> Not really, the fallback path is only reachable on CONFIG_DEBUG_NET=y
> builds.

Yes, this is what I referred to as the heisenbug: release behaves one
way, debug another, so e.g. if there's a bug only with header set,
it will not reproduce. I guess it's not a concern then.

> 
> If you have an actual report (syzbot, KASAN, or a stack trace from a
> debug build), please share it, and we will fix the caller that uses
> an unset transport header. That is the whole point of the debug check.
> 
> pw-bot: rejected
> 
> > Fixes: 2170a1f09148 ("net: no longer reset transport_header in __netif_receive_skb_core()")
> > Cc: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Co-Authored-By: Claude Code <noreply@anthropic.com>
> > ---
> >  include/linux/skbuff.h | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index a3ff380d43f0..cbfeb17d86f7 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -2993,6 +2993,12 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
> >  static inline unsigned char *skb_inner_transport_header(const struct sk_buff
> >                                                         *skb)
> >  {
> > +       if (unlikely(skb->inner_transport_header ==
> > +                    (typeof(skb->inner_transport_header))~0U)) {
> 
> 
> Inner offsets do not use ~0 as an 'unset' marker, they are zeroed.
> 
> > +               DEBUG_NET_WARN_ON_ONCE(1);
> > +               return skb->head + skb->inner_network_header;
> > +       }
> > +
> >         return skb->head + skb->inner_transport_header;
> >  }
> >
> > @@ -3072,7 +3078,11 @@ static inline void skb_unset_transport_header(struct sk_buff *skb)
> >
> >  static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
> >  {
> > -       DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
> > +       if (unlikely(!skb_transport_header_was_set(skb))) {
> > +               DEBUG_NET_WARN_ON_ONCE(1);
> > +               return skb->head + skb->network_header;
> > +       }
> > +
> >         return skb->head + skb->transport_header;
> >  }
> >
> > --
> > MST
> >

