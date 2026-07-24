Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A838F624
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920081; cv=none; b=VqMuHVxIh3YhA/JZU790lTE3edG04l1JNSwXqSgKH0515hiMnegDeGCa+qftVeXM6kinR9EEry3weBHwVigB49YKYrRxsRvnxJqyPhwXDLc/Puj8mNgG2+dHKenU4Lo0kYSA22AIuLFfwGbWw2ybCSjExomppxOxi6DvAR+vzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920081; c=relaxed/simple;
	bh=wmEQeC3U6EAgZb2VeGpRrLhqAsT/rtsLo19D18RCp84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS5kBHSxLLb+zrErAe1Drruj82y6BztdlhLVcIzEKSVn51yeNoEEQYep/KvVPBx2ezJmV2b2JDQx1+KahicbMHe3RzY4SKQfSfwCUZf2kYIFKJfmZMYHVerilDCdL/Sx2rAkXWsLOSzUpw40+NcqHpIudu25gs430lF2n4zISzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwrz1ytJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwrz1ytJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so788100a91.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920079; x=1785524879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZuz2jxA4iPK1iUCm1iaWXV5Y3XayQN4FtdyVm0LdE8=;
        b=cwrz1ytJAlqISKnpYEYC1U6Gi0iG1+8l4KaK2RN1guXMO17ga+Twto7QPSPWLsQ2AP
         l9c4vWca3O9EjdFGwEpmK5EWqlaHvDJeLgOPBV5zvdmHpKmG0/7fmXJ/tNDTYrQ0Pzc/
         P+AcedkVjdfzCBQzYjoT03BEnCnv8iEdyXv6UGa69E1ri+NhVxuGiyujMxeHLPFeOH+C
         pigZxoTbSf8e/aJ8T1XTQsqEV8t4sBh2YEXG4cPmIIVzBS5OZmMkxlylTz9ImuZj6pge
         DKO+9jrtD/fBz+RVIZc8aRgWzAq+SG0hsGKS5NU/PwLenosiz2eQXkf9lhqdoCNZ4170
         ewfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920079; x=1785524879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZuz2jxA4iPK1iUCm1iaWXV5Y3XayQN4FtdyVm0LdE8=;
        b=X0XraZZW4CQSytHc6z5GAYGXb73A64zCUV0ZaLga6kYFkVGiFnJssOzHebH8tSev8u
         8iZZFwuMgtBTpv1G6gjgOdFvn1v66H5fNlzvH7Z6215oNJxyRNlWdnb1Niu8RnMh8t6i
         u2EpHtGLWt0X224FG5yZatyCs1vmwmYDyO/X5OoUxUOecllTd0lsEYlPSb3+LsCJh8Z9
         3VIa7HiMiMvO7ijeKzrWlRDllOc6Rx2d7JbzvhwamqA33KpeQyVXPXtKOPDWb/V/2vkV
         Cn3/VPvNpoIc11NZvANguGiv74yR4fzrnkxlqIpP8fOTy37UHId9boZDIJ9dW3Bq5jim
         n2zQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxwX3dQVb8f1y/HPlQNBEOXGWK/5QZST17IlDMNhimtQ264rSRbQV2GIxLRjVh/ckeVYu9Yp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JnQkDEP7QK/NEMCBDyUVQ7Abc/i5bQX8n1f7wmeKv6CWhIz3
	8Op0aw9+AcbZpaxkeGkTTSZ2uRd8BnhW+8MSxOHhAnHMBizctexOJd4p
X-Gm-Gg: AR+sD13yJgTD/FHhfvfVXictqj/mJO987aCurA5/n/F3cqkvtp8/lF9+bvzMGm3+Ykv
	+iDYA8tB9sDMgOLAGjG+akwr3ON+HuFvpeCC2Zf9CljjvMWAUl+0PiEPd+ZEdHZAaCX9E5p7SLX
	8JNipdXz5vJUgBBiPbsQdl7Oizog5dR4lC99ec8gONQGlusw/GaC2tsNwq2tGPrajqmMbkyF2Ye
	yK744wp0J3rY2r49i4p/3EAjS+70K88ukxkxbjP4PEG+00XDb79RTnwkAgFjS+T4zn3G0A0XnHA
	nAr0iF3aXMwoKM1sg/fpzCDEgmS7fGqlZsXIOPvfpJbPB0nT2Q37vz65N3VaZkgQYlc66FWPd7C
	1Fk/j8+tWiGFnamPpW8IcTT1lz1lAq/+vV9GvOklZAVjK/HJjaGrrGkzVPomakN8Q2xn+/gUsmT
	+polziEuLjClN3m7LYsMY8UmU=
X-Received: by 2002:a17:90b:2cc6:b0:38e:7f1b:efa with SMTP id 98e67ed59e1d1-38ec64a5e05mr8660907a91.11.1784920078877;
        Fri, 24 Jul 2026 12:07:58 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03c4ef4dsm2011110a91.16.2026.07.24.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:07:58 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:07:56 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
Message-ID: <amO4DN0oAzkt9n18@devvm29614.prn0.facebook.com>
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <amEE7qImKgy4sWKf@devvm29614.prn0.facebook.com>
 <5c3c34de-7b34-4122-a792-e91b48858f2f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3c34de-7b34-4122-a792-e91b48858f2f@gmail.com>

On Wed, Jul 22, 2026 at 07:58:27PM +0100, Pavel Begunkov wrote:
> On 7/22/26 18:59, Bobby Eshleman wrote:
> > On Wed, Jul 22, 2026 at 11:58:46AM +0100, Pavel Begunkov wrote:
> > > We should either have net_iov or page backed frags in a single skb,
> > > otherwise it blows up down the stack. Don't allow mixing in
> > > zerocopy_fill_skb_from_devmem().
> > > 
> > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > ---
> > >   net/core/datagram.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > > index c285c6465923..35febc1c25fa 100644
> > > --- a/net/core/datagram.c
> > > +++ b/net/core/datagram.c
> > > @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> > >   	size_t virt_addr, size, off;
> > >   	struct net_iov *niov;
> > > +	if (i && skb_frags_readable(skb))
> > > +		return -EEXIST;
> > 
> > Are we trying to hit the -EEXIST handler in tcp_sendmsg_locked() so that
> > we start a new skb? If so, I think we might need to plumb this -EEXIST
> > case through skb_zerocopy_iter_stream() too?
> 
> Easier to EFAULT. It'd more consistent, and I don't care how tcp takes
> it specifically.
> 
> -- 
> Pavel Begunkov
> 

One socket is allowed to queue non-devmem followed by devmem, and EFAULT
will break this case. I think EEXIST is right, just needs to propagate
up.

Best,
Bobby
