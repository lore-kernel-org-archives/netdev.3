Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CD42D749
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785188262; cv=none; b=Gvz1p/L4TCH9yFo57BBz0YjtRwrYKc57YNfebfU0Ker+QUlfS9Gn1FigWGfqeHyPUDEYlDCQWE5vxNaJ+OKQuLvCf/C2GTrxUbPNsVocTU3w9ypw5F888zdA4fRDuwReZMzxz8jpQoGlA4CKtEl3xjcuY4SjAER5NRCUk3xOqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785188262; c=relaxed/simple;
	bh=VT3w60Mkjil2Wc4Pq3E6EvCD5TzpTh7mRqxGBdrIl1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrT0fpOuu4i3MGeZ5I16KT1+BKd0Dfc8wgx0vfEJSCmyrL5iyYtbL6p3WqMptdfnRr59bKe3u4QeAeZIvNS49XHJgFhH2c2IS6axTkDLJld1x1ZRhXvcXNqyM+nl3a5XRRZul5QdMxMC0WTb467E5dZGGqVEUrkB7R5eHx7wM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNYNX+Mc; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNYNX+Mc"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cabfb70501so11780355ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785188259; x=1785793059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mE4JsLVC3nYgbiekjLfPqZ7EyBmWBffBbsxHDCfCkB0=;
        b=rNYNX+McRwA7KsvyDQIP94VmZNm3SRQCqVfecyQwHDkl2XUEX3EmnndLG2suJ4+QK3
         RbHyXI20S5LfFMUdDkuba+ZQS39u6SVTW8+DIrK2f58nZf3hfJ2yPr6gizCDPnAAU6cE
         bREr5GWd4w5Ih+chZLhnNHRdQQo31b2Ex5jJTJODlzRaoB4hkPF3LLkJaO4okGAcTMkN
         z5UQASLZl+IZSFErAX5xxHc2GDYOL/37Jy5rc3pnmxPcanT/4PjTNpeagPnXsDhiIV9Z
         I5Iyy9E0fKwTwqy9JXNjQL4Trbs+OfvZ110cx+GfQ8fQ7hGtqZy5fQz9CIPyTL98e9/y
         sI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785188259; x=1785793059;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mE4JsLVC3nYgbiekjLfPqZ7EyBmWBffBbsxHDCfCkB0=;
        b=G5YlFfAaJoRzhiDs/7ynvl4H2R9jcVk8HFWvluLjJjpY2mB7FTy8X+5q3Rk1FnVSBU
         1xojQGcrMtHY005jNSK6LuJ5EpShlDykkOhSqKCjAFgxQ1tOw+Na06b0aEGmLd7sJy8j
         4PEFtwHq5pG8irbq5YJVxeUxQkV8loZvevKvUzSHuYyhcg/63YrbmrsWGndq0xB2JvbC
         cOhFuAtUdPDpQFE6VeuCe1w62ROr+DpYHpsXrreS31SMgBLldeDssOGk8pgpgz+CU6G0
         VnKWQZglaRqpvyAZIGQnP2WvctrsWRH/inRsUXEQQ860yN432GeOptjts/5AcwV727fo
         URnA==
X-Forwarded-Encrypted: i=1; AHgh+RrJoaV5vc/239ymQyu+65xOSAfzb+BMdEyrsmU5N/Jyeie6g8gyJEzPHqunB5FzvRMBcYb+OAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy930OiHSaXt8jFVHxTsIwJ4UWOSoQEaC9uJ+hOikiq9wdJWC8Z
	XfOMSAW8gHN8qZShk2YWV4JidZNNo5piQkjYzO6dvC43liBagOMsLuoH
X-Gm-Gg: AR+sD12VjWpDSMTPDDUb9HBQ/a57chpCfU7v69wGmo8MvaytvkjDUwJ/N3qyg8Z/M1Z
	n+yHKyi5hi2YHINB4RPgv3+h7QaG/X2OVZqkY3M+VN+pmjKaXxItuQqRt4DexfYBkVlr9gEz5Ly
	1u3WBbIGXsyoTd9U0wIB6TRmDTXaK7BeDiXSlLLocl2tl2DpDA5rmsx/fcmvs3I+L1FoDsdlNNZ
	1hlD7VcaktBZUEtjvTeTO/EsMimHcyRr4J8n5oNXS3Nbzoe2mf//ZQLNBSeQ/07wqEFVC9yTIv4
	CHbG96LdtqtasqcLPq291osEPVN+e6lXeQiEcOeK72EuqMqti3dc8VHgDDMC6G101bwQ4GWPPen
	y4JYXB1oqyROBJHxyEBqXSodVLY3K5q+ZRUeYWr7ZMUBimrldKHn0sX/JjUNQ2iIS8Te+hws=
X-Received: by 2002:a17:902:da86:b0:2ca:bf68:2a54 with SMTP id d9443c01a7336-2d00f3e3878mr9392345ad.22.1785188259222;
        Mon, 27 Jul 2026 14:37:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7fdfb0sm41136595ad.74.2026.07.27.14.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:37:38 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:37:20 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net v2] net: devmem: prevent net-iov / page mixing
Message-ID: <amfPgf3N9qBYcSUb@devvm7509.cco0.facebook.com>
References: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
 <ameLB_goNrMbscXO@devvm7509.cco0.facebook.com>
 <7e424782-2852-449a-9e47-62c299e0236f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e424782-2852-449a-9e47-62c299e0236f@gmail.com>

On 07/27, Pavel Begunkov wrote:
> On 7/27/26 17:46, Stanislav Fomichev wrote:
> > On 07/27, Pavel Begunkov wrote:
> > > We should either have net_iov or page backed frags in a single skb,
> > > otherwise it blows up down the stack. Don't allow mixing in
> > > zerocopy_fill_skb_from_devmem().
> > > 
> > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > > ---
> > > 
> > > v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
> > >      the former + for consistency.
> > > 
> > >   net/core/datagram.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > > index c285c6465923..173b5d97bd40 100644
> > > --- a/net/core/datagram.c
> > > +++ b/net/core/datagram.c
> > > @@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> > >   	size_t virt_addr, size, off;
> > >   	struct net_iov *niov;
> > > +	if (i && skb_frags_readable(skb))
> > > +		return -EFAULT;
> > > +
> > 
> > Maybe we should do -EMSGSIZE? It is already properly plumbed via
> > skb_zerocopy_iter_stream (and you'll hit 'skb->len == orig_len')
> > and it hits 'new_segment' in tcp_sendmsg_locked?
> 
> I made it consistent with zerocopy_fill_skb_from_iter(), don't see
> the point of making it behaving differently from combination to
> combination. Do you have some use case for that?

Ah, ok, yeah, that makes sense, let's go with that!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
