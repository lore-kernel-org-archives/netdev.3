Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449F36F428
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919145; cv=none; b=aEmxkMTz7iXcIP+BxPTROZILfH2PZpJu9FdE+8J682y2el21BP9lch4jUCkT/RGkXY1052X83M42oCaaY+P5l4X7u6WI1m9FDi1tTwAA7GZbaMrtj3siePPdXn+zIRBApG1v0pEiLFt9XMnC2wWfFocFmoDl5z+XA2PyWJrIysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919145; c=relaxed/simple;
	bh=5bTDS3v2gtgIU8TWmzXEvizeWJpVyh5UocYpnJ3tOCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfONC0ZQvuhkdO+Vc4OE4y9LYr8BaUZeBRoIgyEdNTypoOsUKGlMoJKMZwMuTk/C8bVKywq/6jjFkFGiXPZWTvsnI06amx9Vmkm6RfHJ7m4KN11fMqdn0UnPFMOx/G+F1FQb9em64zHk2IaBqy7+EJJGK99SYtTy29Dc4ffB3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqwSRpYK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqwSRpYK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485b358552so858220b3a.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784919143; x=1785523943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=24oGoFN2zl/isqkok80/HsmColzBNer4WKN+SGnmBsI=;
        b=eqwSRpYK7uZ2Ec36gG0REzzI9Pz7YEtRfZWY+67MOXAvZ1a3US0gurwXrXKRz6I5ZB
         Gi3rHssse5/fD1DN5ZdfFUjVqXTDNQ5H+XN0hApHdmGEa/uWQmRs+puYDoiOW70D7Ip+
         GHPq1RtfZ8/9AyvXu8RtnJt7gBx/UagjK7X++EiWj77vrjKk5FvjsjreanscHhKNaz1g
         HzR3lrN/67apHJFAYXKU02VJDrGWWyhHqTPSpaqzm9a7Tp7vh0wEU9aU0z+uA7DQhUoK
         +osiBME85xkEapvotKtjFiMFiX0D1T1Ak/SR90TQbXjTkPGpLhuVcm/49NZgwvwtTEAk
         u3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784919143; x=1785523943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=24oGoFN2zl/isqkok80/HsmColzBNer4WKN+SGnmBsI=;
        b=aA7wLnR0MPCnIO1sa+ZTCQlnjcfEDgmr5ADSCbif13/8sxY7QatQuxgF36S8HBMgdk
         aH70Nn7WL3BNQiVIVFOruhNgKN+QKWpx0FDKV28LObhFgWdqXYimUvpuh7e5pYkkIL87
         AIDtx8XQmS29oUyUn5GWYr2BUelsSmjAU4FocVkBQu1di8B2Oy8TzFpMumWqkKimUnoV
         l2BRQCwMBygQ/9AopGu5Uc1PAxJVMZYXRNAzYAImYyHuZbmo0ThABW5bsZUW8m891cyO
         cRO8gSNFkLtDzHf0n155/D82GG1tpn8/4JTndJGfxHUPTUfToOeaJhyF7m+0SiDyPH74
         YEkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOXn061sgentcPuF/D9uJm7CsTIRSZlTam5doPvOfDn6+bTD6usKQ3j8XPakp3bkdqyFkiYq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvStp6Gww4lek2Zp1ROAWbLHX58DlS67/XwwrviIqS8j9dT/R
	+hQ9AQjHDarvGF6EJcbJ2xs510Nv5tfya5Cj9R9kqpg6BM9JvJjeKZEN
X-Gm-Gg: AR+sD11sxJ4oPXcGEabrhWAMVUOaZbfiNiGPVAGZcagE8uNWDbJzsU2VS0bmYGSdts9
	hXVs9t1tCAEh32ez7awXDkinGiOfZOvWgJUNdIHBNlWXhIWc0PbmBPRxIVub+evn90vkBcn1E6E
	p8JUoBaq7N8HH3RaFWb7l14y2+gCUmW5qvW4eG+Y/mxULfKwezz+evC9XUN62yOF4pDvDncmDE2
	Tk9iKen6Kv0PE1moT8gVmD2nXV8dPMAkc6Fdw5eroHK44WOyLbfJ108vZqmPb7ueoQq6Obi0ILj
	Dw8+N9rIhbLlCaPjSaYNknHNpfFACTggnb+RBfCL9Hid09USo/xjjIRp+kOLaVNDL6RDLNqdS4T
	qOptGHTpJYYYE/inqcenBQhRxNE04mjTgQ8DFU/L+rfwLfEcjVmMUkpVOW9KKccA4A59p2frnNt
	tRBncyb/0OCfdsXImQJXVk5L+uaUi6bIdf7g==
X-Received: by 2002:a05:6a00:1797:b0:847:968c:a0f1 with SMTP id d2e1a72fcca58-84e2c1aa5dfmr9294116b3a.43.1784919142967;
        Fri, 24 Jul 2026 11:52:22 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5328180dsm318133b3a.23.2026.07.24.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:52:21 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:52:19 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
Message-ID: <amO0YxLANwnIYLXe@devvm29614.prn0.facebook.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
 <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com>
 <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
 <amKfTT8Z28mMg+qQ@devvm29614.prn0.facebook.com>
 <CAHS8izNtr3U2te7rOqYDyjfkFsv3aSGms4YbtuNidPUWcHYzCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNtr3U2te7rOqYDyjfkFsv3aSGms4YbtuNidPUWcHYzCA@mail.gmail.com>

On Fri, Jul 24, 2026 at 10:26:42AM -0700, Mina Almasry wrote:
> On Thu, Jul 23, 2026 at 4:10 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Thu, Jul 23, 2026 at 11:35:15AM -0700, Mina Almasry wrote:
> > > On Thu, Jul 23, 2026 at 10:24 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > > >
> > > > On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
> > > > > On Wed, Jul 22, 2026 at 3:59 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> > > > > >
> > > > > > We should either have net_iov or page backed frags in a single skb,
> > > > > > otherwise it blows up down the stack. Don't allow mixing in
> > > > > > zerocopy_fill_skb_from_devmem().
> > > > > >
> > > > > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > > >
> > > > > It's true that we don't support mixing niov types and doing so would
> > > > > blow up, but this is an unnecessary defensive check imo. The calling
> > > > > code should not (and does not, I hope) have an edge case where it
> > > > > tries to mix and match niov types.
> > > > >
> > > > > Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
> > > > > may be fine?
> > > > >
> > > > > Also we don't really support mixing different niov sub-types in an skb
> > > > > (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> > > > > and check that it's all devmem niovs specifically.
> > > > >
> > > > > And might as well put the check in skb_add_rx_frag_netmem. It's the
> > > > > same situation on RX, we don't support mixing there (and I hope no
> > > > > code path leads to mixing today).
> > > >
> > > > Hey Mina and Pavel,
> > > >
> > > > I was able to confirm this mixing case does exist.
> > > >
> > > > It looks like in tcp_sendmsg_locked() when new message is non-devmem (zc
> > > > == 0) and tcp_write_queue_tail is devmem, the skb collapsing is allowed
> > > > (though same-frag merge is disallowed).
> > > >
> > > > Adding a mode to ncdevmem that sends mixed devmem and non-devmem
> > > > messages, it can be caught hacking this in:
> > > >
> > > > /* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unreadable)
> > > >  * and non-devmem (page, readable) fragments. Such an skb must never exist.
> > > >  */
> > > > static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
> > > > {
> > > >         bool readable = false, unreadable = false;
> > > >         int i;
> > > >
> > > >         for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> > > >                 if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
> > > >                         unreadable = true;
> > > >                 else
> > > >                         readable = true;
> > > >         }
> > > >         return readable && unreadable;
> > > > }
> > > >
> > > > static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, ...)
> > > > {
> > > >         ...
> > > >         BUG_ON(!skb || !tcp_skb_pcount(skb));
> > > >
> > > >         WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
> > > >                   "DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=%u len=%u)\n",
> > > >                   skb_shinfo(skb)->nr_frags, skb->len);
> > > >         ...
> > > > }
> > > >
> > > >
> > > > Resulting in:
> > > >
> > > > [   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=2 len=24)
> > > > [   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_skb+0x9bb/0x1030, CPU#2: ncdevmem/278
> > > > [   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
> > > >    ...
> > > > [   85.915617]  tcp_write_xmit+0x47b/0x17d0
> > > > [   85.915802]  __tcp_push_pending_frames+0x38/0x100
> > > > [   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
> > > > [   85.916244]  tcp_sendmsg+0x2c/0x50
> > > > [   85.916903]  do_syscall_64+0x11c/0x610
> > > >
> > > >
> > > > My feeling is that we should guard against this when
> > > > tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In the
> > > > zc == 0 case, I think we need to check if the queue tail is unreadable
> > > > and 'goto new_segment' if it is?
> > > >
> > > > This is a different case than Pavel's patch addresses though, where the
> > > > new sendmsg is devmem and write queue tail is readable.
> > > >
> > >
> > > :( Yep looks like we have a couple of bugs in the TX mixing. Sorry
> > > about that. We do indeed need to fix this ASAP.
> > >
> > > I don't think it's enough to check readable vs unreadable, no? Because
> > > I think appending io_uring niovs to a devmem skb will still blow up
> > > and vise versa, even though both are unreadable, right? Or is io_uring
> > > saved from this somehow in both cases?
> >
> > I think for the above case it is okay because if the current sendmsg()
> > is zc==0, then we don't care if the tail skb is iou or devmem as
> > skb->unreadable tells us enough to avoid appending the non-zc sendmsg.
> >
> > I'm realizing this a different mixing issue than what Pavel is seeing
> > though, probably needs a separate patch.
> >
> 
> Yes, you're reproducing a different edge case that results in mixing.
> Do you plan to send a fix for that or should I take a look?

I have a fix in the works and plan on sending it soon.

Best,
Bobby
