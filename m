Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC69B3DB63D
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561876; cv=none; b=hM5gKxh+e2oUp7+VEq9Sih3nkpbpR5HTeMZNF+cQgZk+jaKdPjSoNHzdnpYfHQihrSl3JYW0e+POhXs8ZqT1ls/SUGocRrXo5cOMaZ8ZcxVSJJi1UqouYMWuRbLTwMA5tfr2mxz9qJRp9eJeP6Sv4Qqr5qnn1ds2XHpnJof5fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561876; c=relaxed/simple;
	bh=eycwb80GRPdzJqSiuHxtVNsrmJFCiAJPjZJsePfY7RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaoBC7UO4GAtTk7M9dqrtedbWmm1heLpv3bCBFzf9F97mRSFXgpx00D0DRDvpk69hP6Vmlyg1TVH5MzKUpFlbTo7E04FStFfjpRybvCnJoSI5YTCq8JqfkTWGL8dvzybzwODZFyrXGf4OBUFcYHdOJNhEtmfE0Qk+z5qnuyFOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYLCUw75; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYLCUw75"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f64ea07036so1572808a34.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788561873; x=1789166673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4vl0CV1KiLa4KMsh3ZdWy1IL1A4UgMhQyPsKMFr1lk=;
        b=ZYLCUw75HAElLG5r8h2G/OSS2GgX1TG72d+hyISqCFG5S66pRqh8VZmyXFgXX15PcL
         1MQGTbUjhKNvGFF6fsRZpSBm6OVc/y6YI7C8GZKIacJyoBNaEs3uMvqouz4sBJ0LsT7J
         2xZ9M7NBmiDWulF4JwWzLAh2QRnr0vHJ3DgwB63oLj81y3jrAunhGeaxDtZZ1SHHzmQD
         /DrcJVGuWJec6I1QuW5EofK2RdfyVplG2GHmATwN4Nd5k6e3PMYA8rnil4G9Xi78xi6k
         f2GmAGqL0qfC1CwmMXKlORgKyYLGg5VfOIyG3jr8T3uYDy0+bGzj8nPDJQe+Nlcn0rnH
         A/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561873; x=1789166673;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4vl0CV1KiLa4KMsh3ZdWy1IL1A4UgMhQyPsKMFr1lk=;
        b=ianGR+Sw2v80tqDTkKQqOysdnBX/QLHq6mKYyXsVgR3Z0RY4nEBfYwpjrw0wqS6L9G
         yuJctll3ztn+jwjSPcqHKkxlqlGc0EqvUtESyLruz0cieNAmcinoNbARpcQ612ytWf9V
         mDPsiyS7jlzfVp116zV7WyehDrJoLMT9JjSMJs+t1TfszgUmzm3bl5kvv+KmK0Srr/Wp
         eRG06Onus0QNBO3gAjx/F8RfGv75duXoPiTwW+5wTCbENMstd6AudO6cVMQOSlLrNYbB
         lfNjHjWTBXUIHag/3s8ENK12eP6Lyx+JhWVwOiIG7GKAPwSDkTWWBan2wCMAUyQpXVwp
         spLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBg4sbp9mgM9XU9zB3/08qO0OgmLp/tl5Wrlhb1aBl9bnP9kYCZVhAe/CIUVmM6RQMv//g7sc=@vger.kernel.org
X-Gm-Message-State: AFuF++mBzDK85Typ6PrLfjf7f1N63N+omQ0W3bVPNWvm7IhiRr6eznM0
	BemSjeJoiSnPb3FSdVs0Mrs2prOfaQF5wbSZhCtavHOHs1Y9MCjdXmts
X-Gm-Gg: AYBFou3tz6d5R3bRloezhp8ckoSRWqzhbHwFuUNsjit+TN/6PRstKgpXh6N7IN8PD/K
	GAWyUAec5F6qfjlJ3+2T3s2Y2ufSGyFLnOp9hVbrtKpDD7nsx2n/zudKdYIw6CkmVPYQqTRA9uJ
	ks/Qu0WYZOI6Ym12rdBqnbFULYvjGEHJ87zHv8vNouMvuFTVIUQVTWf9vDEE4Htcw+vPpE/9Rrl
	e6YN1M8NUmDHrK4th3XMlH3einUEP/hRLghIHZkNUVE6xv1gF2Xx7atMFVOtVGyoFS7vxcnAAJ5
	LU4eGxTxa48Rg0dPeCqCAapYmKDB/41DwroHSN6AIKhsbdLVqzz3y9muiTJx9OyhEU2QOC7qHq/
	nuA5bRkAL14oawQZi60NkORx+ZtOyiw932t2gqGYnyjgV9zbvuPa8VtXaeuLRdDLEvAV6pOoNeG
	lOp3d8CVd3geSyFbcw5cqogeTd6UNpQYHxrbgXsUaB9SV9GQmZ5SKQjd8lv8O6I01I4H0KK9/GC
	lgWihgExw==
X-Received: by 2002:a05:6830:67e7:b0:7fa:5c49:5250 with SMTP id 46e09a7af769-7fa5c495568mr6198374a34.23.1788561872439;
        Fri, 04 Sep 2026 15:44:32 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f67947cbsm4319996a34.4.2026.09.04.15.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:44:31 -0700 (PDT)
Date: Fri, 4 Sep 2026 15:44:28 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next] tcp: devmem: only pre-allocate tokens the
 receiver can consume
Message-ID: <aptJzJ5VtKsb06lo@devvm29614.prn0.facebook.com>
References: <20260902-b4-net-next_devmem-token-refill-v1-1-81d8990e5e17@meta.com>
 <20260904151146.602c61a4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904151146.602c61a4@kernel.org>

On Fri, Sep 04, 2026 at 03:11:46PM -0700, Jakub Kicinski wrote:
> On Wed, 02 Sep 2026 15:24:19 -0700 Bobby Eshleman wrote:
> > Testing on a CX7 w/ GRO and a steady sendmsg() flow of 1MB per send, we
> > see a typical RX-side skb touch upwards of ~32KB. With a 4KB recvmsg
> > size, probing shows that ~75% of the allocated tokens are not used.
> 
> 4kB seems unreasonably small. Is there a real life reason to use such
> a small buffer / read length?

I have workloads now that deal w/ varying sized tensors (<32K up to
100MB), and data send/recv is done per-tensor (with the size/metadata
sent over a control path via normal TCP). Right now the application just
safe guards against the small tensor case by receiving anything under
32K via regular TCP, and anything over via TCP dm. Figured might as well
try to lift the restriction. To your point though, I don't expect a
consistent flow of <32K to be the common case. Could be something we
shelve until it really becomes painful.

Best,
Bobby
