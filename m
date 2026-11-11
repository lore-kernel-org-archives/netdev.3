Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434468;
	b=vzN0YZ2f2WZ9orbHRekcRzO+pMUXztvl5pkIzH2GbC8DLMZ91KUzFDRkdYyNtZ6N4ISc
	 jGn+px6GHz1jX41l4tFjaK4lEhY+WxPeNIXr8l8/wWj+ZYnutKQfefuIwKj471dyhPnjp
	 s/srgC21/MtMd0JasSLwHkgYSu+35jfahkLp7Z3a4Hs3zmypbY2Hgw10mJXmAGDg477BG
	 NIDUVrfi0+DOnygyTdMwBtcpmVSWOATe9qEJVHSkaMfiEshCrqoL/SCa4epcI1B0pyIOd
	 oSkcCUqf5EKXrG4Er8yHBoFMTocQ5pMgAQUgpAI6YfGDt8QvCim2bmTKbvzUWGAJ0+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Zvla0mu+gfalLGz1DoaFw8Zr1EDQonu9YPsE9DkMK38=;
	b=gIoJGIpEvvG1l02YS/Vir8SkPPKfx+cDoFFU/S1N7SzAY9MM0C9nm2fwm9CjY6VaRt8Y
	 fb+3AV8SyzIpZfJ8vsq0/c2hwOUObQriEh4/eZPTp8q/mT14cnhmptetnQ0H7s9q+ax1U
	 TnRIe7HqPScvfGxDYg6yPczeiYf4IA+UFeQh3cRRIARSwgUQmVSki43HGMJpOPvSFb+fV
	 sKise66tSPaxaW6ATb8HyKdGYGTXmuv1xajUs2/vHpyBz2GWPf/XMroqBG6wuDbmB5rQz
	 AMG1zyr1eJpYOCbHjMfbR4IDyZ2r/vDOEYrizU48LHxUIGkoZadJwIyGCZBgHMVgNbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cg8I5xL;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288660A2600
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C288660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cg8I5xL
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so4312063eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434467; x=1795039267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zvla0mu+gfalLGz1DoaFw8Zr1EDQonu9YPsE9DkMK38=;
        b=0cg8I5xLzPahs75tG8wMvhSu37KYhsedNAv7DqZGaIcZgMM8lIFxc2xuOfqhTuTYNs
         O/WlNCgGu3/ZIDKniCHFeZSOTwhFSnjZ1oFS+FI1EmXuwe1Epk2qo2k5/wJkwvPQC3iF
         zAB0S/5M9vns5/aPBB6rXDh/+e/1cl38jTW+NglzoTOorCqH+HQDB4SnXYoJ/h74kQsF
         H3bPCteWd2jd4F8HZeDuwchIn0vxQ9uAx2Y+i9aYRJgBQTkge84ghgEYT+9TSgT5T9OW
         JCrBfnA0ZbtuB6jOY7FSBTIKriH3xZ9khvD4RqXyWKporOzqv7A8iX9TH/NhK7sqauS/
         6y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434467; x=1795039267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zvla0mu+gfalLGz1DoaFw8Zr1EDQonu9YPsE9DkMK38=;
        b=Zml8o+MAWCHgPxW+BKI/FFBelTInZeXjJaQNBJMarVrbh+R2zhNy0uPCkQt9SkFu3D
         PYK6psQcVyvKjfELiVhCBSdn6vzcqLCAX18RFU6tzdvw5GIichZll6Rw3vNB4Gjeq+T5
         bFWe590FA+tLPJY/x8qf9EY0AVU2RRVuVA9L2Ey4HdRudd8jkP4Pbpb7MuSK0bZv0VQt
         pY/2vzkxFhYmqnAzpMJwGeR75WpZHearcSTuC39urQzia4s+ry2krLzwoS0CQiLbvRcZ
         VRezVJceT1vTnj54dUGRaaNBXDE+k1bcAWbjm0uH69Ft6nUrQM5hfuWeN57+rzytiz/q
         H9TQ==
X-Gm-Message-State: APuU4Z9IpbTRM6jyx60LFI7gDAYw/inzDRegljM08wQ4WViEO0Epq3T6
	ytr7EKYwyguszDAbQOyU4olkf8IjyglDwdGA5KvCmFzFSCN9PEIvuxkG
X-Gm-Gg: AYBFou0Plx0xw7UyWaVBwMwtWB4IjOB5s3YJci7AN9HZBoY9Ugkd1o4ggQZ1S976W3X
	eNxpeJ9SWd2HK2anh1XEY1d+0Yg/tjPZJJ3jluDVWjezhuWD4bMfVTfmXYks7kaEdqs8RPRtYnE
	BcHZFpIz0Ghn0F3qd8ErRoU0lqDj0nxjulofxG2CfWyqCdkUmOao0N7oeyJrZ/IW3ZKR92xhiu7
	2hEmgplVpY8hQ6VrAt+zf3nUxvuiZhrljlEU/L1KjgcnCtabIbuzi8mLqGgYyitQDNwakjf/Xvv
	RHtoZBrTTuQ1fVpVURaIz0oEPMo2295R2o4hxudi0A6f1wBLNVBCCPFEwbwGOfNjf5i1BHzb0Gq
	6WjzrrAi/903/PvUoQFY2OgJQjoxuI3h1n5saqQZ0WRIbbU89AjGNmJYD2EXHOGXjBkee+itVS+
	V9EaY2R5PZdz+6XoYJSfl9P4wnurkTtALz70sBOG/rEK6kbpLZkVwL0HnVowSbb3Wh/S82wTpK+
	lQMpjmRYvGt/32z6zVvGE6ROMCJAgOngcFKAvoNKCGEv+mmHHe1sE2hmSeuCeucYLxU9k5kLU2l
	oN1iHdzrZwynj/qTlEeBToI=
X-Received: by 2002:a05:7022:e21:b0:195:e4b9:d326 with SMTP id a92af1059eb24-1b3c02f09e4mr4677986c88.12.1794434466726;
        Wed, 11 Nov 2026 14:01:06 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:62::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm20535169eec.27.2026.11.11.14.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:01:06 -0800 (PST)
Date: Wed, 11 Nov 2026 14:01:01 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v4 2/2] net: prevent mixing frags from different
 memory providers or bindings
Message-ID: <avTkuRVZcOuYlu9T@devvm16445.scu0.facebook.com>
References: <20261108013838.1454450-1-almasrymina@google.com>
 <20261108013838.1454450-3-almasrymina@google.com>
 <avIRJ3vdIj6Jr9zJ@devvm16445.scu0.facebook.com>
 <CAHS8izOxvUxCND3R18_HfZhB=2RS4_RNfAmx7S=Ex6b5z_CQuA@mail.gmail.com>
 <CAHS8izNodRM1Bx+FT7okpdeDfCeyJVP5QoyxhSMJWXpGuwyL4A@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNodRM1Bx+FT7okpdeDfCeyJVP5QoyxhSMJWXpGuwyL4A@mail.gmail.com>

On 11/11, Mina Almasry wrote:
> On Tue, Nov 10, 2026 at 7:54 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Mon, Nov 9, 2026 at 10:33 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > > --- a/net/ipv4/tcp_output.c
> > > > +++ b/net/ipv4/tcp_output.c
> > > > @@ -2692,8 +2692,9 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
> > > >                                    probe_size - len);
> > > >                       len += todo;
> > > >                       skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> > > > +                     to->unreadable |= skb->unreadable;
> > > >                       if (lastfrag &&
> > > > -                         skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
> > > > +                         skb_frag_netmem(fragfrom) == skb_frag_netmem(lastfrag) &&
> > > >                           skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
> > > >                                                     skb_frag_size(lastfrag)) {
> > > >                               skb_frag_size_add(lastfrag, todo);
> > >
> > > From [0]:
> > >
> > > Maybe easier to not merge niovs here? Add '&& !skb_frag_is_net_iov' to
> > > that 'if (lastfrag' check? (or your new skb_has_net_iovs)
> > >
> > > Looks like it is tcp_mtu_probe path, not sure we care about merging there?
> >
> > I'm guessing this is not an issue with pages because they're
> > PAGE_SIZE? But, seems maybe a bit lazy to just hammer all possible
> > net-iov coalescing? Is there a slightly cleaner and more generic check
> > ( && skb_frag_size < PAGE_SIZE or something) so that we don't add
> > net-iov tech debt? Technically this will be an issue for hugepages in
> > the tx path or large folios or something.
> >
> > Also I think it belongs in your patch series maybe. That's the one
> > adding the large niovs :P
> >
> 
> Actually, this comment made me realize: is the optimization that you
> did with net-iovs here (that's showing so much better cpu) also
> already implemented for pages? If not, is it possible? I don't see in
> theory why the userpsace can't pass in a contingious 2MB page to
> sendmsg() and the stack could keep it intact in 1 frag up to what the
> driver tx supports, no? Is it worth it making your feature generic and
> apply to pages too?

Based on [0] I'm thinking that I'll drop all per-frag enforcement
and will not add any special handing to tcp_mtu_probes. Looks like
the drivers are expected to handle large frags (if they advertise
large tso) or have a [1]-like segmentation fallback signal to the stack..

And yes, regular msg_zerocopy path already merges pages so this is
not niov specific.

0: https://lore.kernel.org/netdev/20261105222058.944293-1-sdf@fomichev.me/T/#m169832053b43604b0c5df7f7b1d04e9d4f390cbc
1: https://lore.kernel.org/netdev/20261105222058.944293-1-sdf@fomichev.me/T/#mb6e882ab1aecd6c15552773653301cc235b987d8
