Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6EB33B961
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848212; cv=none; b=uJhhqhzAHuOBICz3aVYOTHtO1INx5ke+wBlRHj0TI/VteJn6TnjVXYgXI0bfo4N1ymNaklhSmq6uGnBjqNfWXuMVtCyhgbpEESaL3jDgsrMBHreLIFbp0z4iM4VYgZEI4d19bUaVJplRWhsXjPRVnw9fhD/mgJ+4cPccIPIJ0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848212; c=relaxed/simple;
	bh=+MbfV2IZRnXGivX209NxZjnwJuAQEzHdvMAIkTtfTdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFaXohCh+9SFXUnrnXAEcy4u6/KwR9oLRiRhp6dtQkcsIOvkEprJmXVPHpMi8z5RVg3HJvnajqvUAUaSI4Ntkv8bQ8PkhFqY8rezSPmGfP09nydAVSldSwLTK92VeBHrRezJqcLeJ//HD5iWGr2FY5/NLWzmK6yOh7hfNljkR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaWOmqlX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaWOmqlX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbb7926836eso873008a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784848209; x=1785453009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WfGUnnI+OUwLVYHyK6sxbrCeWCvR20/bopHmKd+QZEY=;
        b=DaWOmqlXUncNKGU+8pXmqyrAAfP6+6WzD9HFepkSd96cRs8EdNSnrR+OTbnpQriWJ2
         mTmTSuKS2I+wepbuRf57k5V7K1btlukK/4GrkcQazHD+kKqKmmXczggG/gQPyzpdBgc1
         HFHhD/HwTyuha+2kfVc8yoLczMKQ0BbGTUsMcy26nx15AYbEWH1HjXK71h2dNYuSBclE
         xMKofp+ho14L0fc15NLlIJhWftKSea1C9LPlRJz+hRkAsgT1m4fHsuO6w6VpG2m7glYz
         miVXYZ9YiT9vB7aP3RpcUlZo/ln+A4J3KNuIdmovi1T4/FuutLTQyOSJKrnVCIv82Vno
         BJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784848209; x=1785453009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WfGUnnI+OUwLVYHyK6sxbrCeWCvR20/bopHmKd+QZEY=;
        b=f7PPP+qKO7jHV8GylyoamYTs49oPIftDAj+WLQCJkR77bRB8Dk3FvkAkhYSUKLzXxy
         HPKqnNemOusXzzJjMuEON+e7AuY/lLWoTo4uSVYa/TJCDv8uUO/DcRfA3MXtDGhvBNOC
         E9MEpo98UF9ZzGXeWX0k+12T5T0oGsdJNr7peaUFjYykS7aIYgl80jABbtGlSEIMKCYV
         jMgn/pP/yx2HCmPRiQfcCP6Y3vvqoc7pH3s8KzFAnfnDmxaRCCDGjJNsj88doEXqA1aP
         hheIJrgzRe0BRBEU/5KyqHrDl6zQS4LCnb+2GmNVhOtcNRsEo4LyWEHhtwsXzfDbEDm7
         ZffA==
X-Forwarded-Encrypted: i=1; AHgh+RoF2A7RC712MuGjnr2VLa+T4176QaIlIIrxgVeBD+MQnzeFoamrt3lpuAu7q10JVD8iCoXU4j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwVikrDfoLaKUSs+lsAS7l2nh/BuuVvSCg3FFyV7SK6nE7p+H
	wwGs7c8khsvXhAplvtNo+pEIOvrjPIhjwFq+aMaXEN/vYRAyAPFBtdkR
X-Gm-Gg: AR+sD13LZ/+2xOuVXedpBplUySazYpHjaymCkT226/uF8FuserctyCukPrbyPH5u+VG
	jF1uPZIX6wNQFF1d8q6y8hr0RqDbXO0f8yXn/X77xpIXyW5zXOExmSgfUda+YBqwKivkvUObCcJ
	la63J7XH68oK9lDUE3aDLdgpBmlPTXK6URzLPVOwbMkQYq/3K5gYZlWT5YDBiWI4cnwESKSqHZN
	TspaT2vtW8pxw1lV20jDNfbgAeIR3CLkDw83fV1iRzCV0+hyqwvFcOX9IRwkPy+ByPzhCiCGLTI
	Mz5Hrk3Cw/CCb+4OJyvii+AAq+j6F9MFLbNypFOMPMbIYbWi2SZlvOmEG3E3PNJcMsl46DXxPY9
	QRo59A8ImLBvWMgpSw2KbTNT/9Qvf5f//XYiO7dbkIYJdUdpK1Ru3TcSC5qnou4Rt69dWi+TgDm
	JA/brp7TYW1X2ez6DzT7dfhQ==
X-Received: by 2002:a05:6a00:e0a:b0:847:8f7c:fa10 with SMTP id d2e1a72fcca58-84e2bb25180mr5743925b3a.35.1784848208504;
        Thu, 23 Jul 2026 16:10:08 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17266107sm3792220b3a.17.2026.07.23.16.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:10:07 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:10:05 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
Message-ID: <amKfTT8Z28mMg+qQ@devvm29614.prn0.facebook.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com>
 <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com>
 <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>

On Thu, Jul 23, 2026 at 11:35:15AM -0700, Mina Almasry wrote:
> On Thu, Jul 23, 2026 at 10:24 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
> > > On Wed, Jul 22, 2026 at 3:59 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> > > >
> > > > We should either have net_iov or page backed frags in a single skb,
> > > > otherwise it blows up down the stack. Don't allow mixing in
> > > > zerocopy_fill_skb_from_devmem().
> > > >
> > > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > >
> > > It's true that we don't support mixing niov types and doing so would
> > > blow up, but this is an unnecessary defensive check imo. The calling
> > > code should not (and does not, I hope) have an edge case where it
> > > tries to mix and match niov types.
> > >
> > > Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
> > > may be fine?
> > >
> > > Also we don't really support mixing different niov sub-types in an skb
> > > (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> > > and check that it's all devmem niovs specifically.
> > >
> > > And might as well put the check in skb_add_rx_frag_netmem. It's the
> > > same situation on RX, we don't support mixing there (and I hope no
> > > code path leads to mixing today).
> >
> > Hey Mina and Pavel,
> >
> > I was able to confirm this mixing case does exist.
> >
> > It looks like in tcp_sendmsg_locked() when new message is non-devmem (zc
> > == 0) and tcp_write_queue_tail is devmem, the skb collapsing is allowed
> > (though same-frag merge is disallowed).
> >
> > Adding a mode to ncdevmem that sends mixed devmem and non-devmem
> > messages, it can be caught hacking this in:
> >
> > /* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unreadable)
> >  * and non-devmem (page, readable) fragments. Such an skb must never exist.
> >  */
> > static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
> > {
> >         bool readable = false, unreadable = false;
> >         int i;
> >
> >         for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >                 if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
> >                         unreadable = true;
> >                 else
> >                         readable = true;
> >         }
> >         return readable && unreadable;
> > }
> >
> > static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, ...)
> > {
> >         ...
> >         BUG_ON(!skb || !tcp_skb_pcount(skb));
> >
> >         WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
> >                   "DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=%u len=%u)\n",
> >                   skb_shinfo(skb)->nr_frags, skb->len);
> >         ...
> > }
> >
> >
> > Resulting in:
> >
> > [   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=2 len=24)
> > [   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_skb+0x9bb/0x1030, CPU#2: ncdevmem/278
> > [   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
> >    ...
> > [   85.915617]  tcp_write_xmit+0x47b/0x17d0
> > [   85.915802]  __tcp_push_pending_frames+0x38/0x100
> > [   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
> > [   85.916244]  tcp_sendmsg+0x2c/0x50
> > [   85.916903]  do_syscall_64+0x11c/0x610
> >
> >
> > My feeling is that we should guard against this when
> > tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In the
> > zc == 0 case, I think we need to check if the queue tail is unreadable
> > and 'goto new_segment' if it is?
> >
> > This is a different case than Pavel's patch addresses though, where the
> > new sendmsg is devmem and write queue tail is readable.
> >
> 
> :( Yep looks like we have a couple of bugs in the TX mixing. Sorry
> about that. We do indeed need to fix this ASAP.
> 
> I don't think it's enough to check readable vs unreadable, no? Because
> I think appending io_uring niovs to a devmem skb will still blow up
> and vise versa, even though both are unreadable, right? Or is io_uring
> saved from this somehow in both cases?

I think for the above case it is okay because if the current sendmsg()
is zc==0, then we don't care if the tail skb is iou or devmem as
skb->unreadable tells us enough to avoid appending the non-zc sendmsg.

I'm realizing this a different mixing issue than what Pavel is seeing
though, probably needs a separate patch.

Best,
Bobby

> 
> If io_uring is vulnerable to this as well, then fixing this becomes a
> bit more hairy because this is a TCP fast path. We don't have bits in
> the skb header telling us exactly what the skb memtype is (only
> readable vs not), so we'll have to check skb_frag_is_net_iov(frags[0])
> and netmem_to_net_iov(frags[0]->netmem)->niov_type to check the exact
> type of the skb memtype, and that may be a lot of cachelines to fetch
> in the fast path. :
> 
> 
> -- 
> Thanks,
> Mina
