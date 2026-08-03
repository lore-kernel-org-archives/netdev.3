Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DA427FA2
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778343; cv=none; b=aw/9TIE7GVdk4kDMRz6VZSPQPFV3BemQuEMDms7RS6yBlZOEFGj0W0IY5xJpriUcNntr0D5/I+iMAr0FXBqhlmKlrSFugFX3Bmlkkd4HoST7bn3AffK0ZGWcQMae0+Nj83LAufiXSzXKsVk0nC6GBzf0eVDBQcK9to9e2f+DiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778343; c=relaxed/simple;
	bh=EX8uvH9BeVQAkFCLzO3hLwoyiGO09+5Jw4xPTKtpk9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9lXA4HO8hWWszMD/UyM5z/yBFfNnyxeoNOtABzzto8Uk5sA5Xgil98qdDklV+QLm9mVRDBc/svD/Y00UMNykb3vQbOA4pLodLyTuc8bemG9mIb2mterPD1Meg6mk0DYxOU36RaxPVY0CAVjsIYQePd9GzsAyMoNtIC32D4SdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYifMGBb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYifMGBb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceb096e675so43495555ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778341; x=1786383141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RQTMIRdCXsVsCde5cKr+42MERUQxQLSc7sIpOyCPFdk=;
        b=rYifMGBbUTkcKTJVF8Sky4+4ZcCwwiZpiLgpzmmkZggMV4BBqIeLIP7S0U3Pe2OGtA
         39Go+2UOQgW4YaYOnqpw/tV/3Z9PcZz71tELxz53o9wAM2ysnzIRKyVBfOaTddOHarL+
         ViS8jvBDuSJK5Q5bA1tJAqbgoTo0JTsy7ObHmM+i/9FHPHPigY14qUDcw1uqFdTYR6h0
         /JhRCB3I0OZ60RrT54B3oE9+mtlzHifWNjbHwLWYRrhU/oor/fV6zhJcxs0wlD0XT1FK
         Y1PrgT2ToHiG3WlkvEpasyQF46g7dtRoUEgeA3w/3loPZbXqkWhOvNN/feSVsdkmJgIA
         +neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778341; x=1786383141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQTMIRdCXsVsCde5cKr+42MERUQxQLSc7sIpOyCPFdk=;
        b=RKPQ1J9KWzbfLimSeiZl73/+BgRnw6H6/X2Cg/EZxYeiiI/KzumcRkaGuyT/Cwt0MG
         aL3mtJGiqwPIpTR2iyO+kPlicOxsh4GcX2Bq0e85/Ept4W4Q9KAH2vQTiq7F6vPNRda6
         ymfmfNTC1QkVtZPjtm4exo1GdwekI+6MENmV6yaEtf6g/SsXYKkuags2UWbnsrRVm7OM
         X8DZoPe7pfD15m1mJWzeHjMhvOrmR5XAA1yB/J/8LvQc+makbk7WdIZRU/K7c6xhC+Fj
         gQ4tAVQSGgtfy4nkBxyI5gp1P2R7PO0AzKZhVLIAbbAebHorkEsYRZ2qJRhoHeGq11g+
         RU8Q==
X-Gm-Message-State: AOJu0YztXvOzmhEvtvZwloMxUUIdMlA904FaT417v1pyqzDrTBerJwLk
	nSbqeGVDcaVAaCDcddjJnQ45siTt6eSv6M/N3eUZOoQca5WFeo6Qo3oz
X-Gm-Gg: AR+sD11U9EIkpPCcAoOJpm7Kf7mj64K6PI7LkT80vz/MEATVu4DXI+4DDNZz7JqXcQK
	5k1uRITWP0Q7c/9G9BbfEo0e2g1i908uNQsTXTDVVMwTYF0TRVRNIPdTxVQW6OLt3C4vGU2g9QW
	GZWvMMMRr3zBOkB2HYGyOFvjUxKlFXs4rJ7H4BfnaY/3DTWJsBFoPG6oVEQkfiXxa2jYrWeZdep
	ITtL97Djd0CQJ8mGlxss949rXZ0EYHY99EeTgmIKyGTJeieRC0+eVkL7QQKTWDF6PTB0amqdFMe
	RXpZIfcH55aCblO7p44ezcfF+pWCF5otSs0/1T0oEzyeL/KNDkAauyAT8YB5PMhCJeF4D6p/bCG
	tU/XqFdmOvfq6ayfgrORs1F3glat8Xv8tWi9TVCgKyIq8QvIQAExDnnvM108oN6Vkr5zf9URlxk
	TCsAAexSg+j4m81V0P86001QhJamUKX/cmkU2oEFGPkqb20is40SxtJ4yU7ULvDbsXXxmHnBNjc
	cWPEutjpA==
X-Received: by 2002:a17:903:3c23:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d0521bbfd1mr106788675ad.12.1785778341319;
        Mon, 03 Aug 2026 10:32:21 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea002sm41300535ad.49.2026.08.03.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:32:20 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:32:18 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, bjorn@kernel.org, jiayuan.chen@linux.dev,
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com,
	sdf@fomichev.me, fw@strlen.de, Neal Cardwell <ncardwell@google.com>,
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net v2 2/3] net: devmem: return EMSGSIZE on type mismatch
Message-ID: <anDQon4xaZ+lDCOc@devvm29614.prn0.facebook.com>
References: <20260803171441.408014-1-almasrymina@google.com>
 <20260803171441.408014-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803171441.408014-2-almasrymina@google.com>

On Mon, Aug 03, 2026 at 05:14:40PM +0000, Mina Almasry wrote:
> When a devmem payload mixes with a standard page payload, return
> -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> fall back to creating a new segment instead of failing the socket send.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  net/core/datagram.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 173b5d97bd409..6f8ffd61bcab4 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -638,7 +638,7 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>  	int frag = skb_shinfo(skb)->nr_frags;
>  
>  	if (!skb_frags_readable(skb))
> -		return -EFAULT;
> +		return -EMSGSIZE;
>  
>  	while (length && iov_iter_count(from)) {
>  		struct page *head, *last_head = NULL;
> @@ -713,7 +713,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	struct net_iov *niov;
>  
>  	if (i && skb_frags_readable(skb))
> -		return -EFAULT;
> +		return -EMSGSIZE;
>  
>  	/* Devmem filling works by taking an IOVEC from the user where the
>  	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
> -- 
> 2.55.0.571.g244d577d93-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
