Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596862D7DD7
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499185; cv=none; b=tvUznFFeEPz1lcVD3PCe3c6NcVKuFU0ywEusuGIo96hWsg1AiRGV6GvmWgOpOJjRIe+psA15i/2Eyu/ZOos4tZlK/5ZkQxvEiCa80fg/gEY6c2OApJj890ZOWNZNloytzFdT3LhD/nVSu/+weNu4eNZIScz+tI/ovGJ2UpPZWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499185; c=relaxed/simple;
	bh=hxEApRKDBN3eQqtZvQgwtEQk8NKI0BC7yptrO6X+1zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDaDqMPwf5LbKcjA3s9/4qOwu/dCGHTkWbPvfIDFiv1yRTRsg50aFIbCYWkd4ff7NGBkc0SIqMrWVBr36DEAef+apSJKYZE5YB1rT4XwotQBbq6ZMiyst7gru2snA/INkmQY8kQecmSTZh1oI/8z+J704mkCwmrlci/LSejb8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar/arSOh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar/arSOh"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84874b52eabso648249b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786499184; x=1787103984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DpvSiMHFWPGGvTCvJybQfPYiAi3zlBmKnJ+fwsXosYY=;
        b=ar/arSOhwnWBLS3qZGUHxSs0XEmmZ3Il3VcuidUM4mE47vN5JRhnY+lLTXBKYn71Hu
         SBNPH73bPLPMxOyNInf+Ackc+tHK8PubPYiWde16V6bhaZu/X1y7g9fEWNhpV7+M8h0v
         0vd+QsTOgJxSdoo0RRuxC7MOnO1zLdi+YUcU4AzkNTrBGjXNKdzZtStmLZHCw1k7ck5I
         Uc73tSOF3Nd+tl4QeIq+pvzW4EVmoea4ftjzhwDUiLPa/OJqr24NMckZQk+RU89awrdU
         rzQT4QfGen8bqDeLP0j64rOYNn+/BnPq6Fzd5mFKrvb1hKh0myBG6Wk9T+zzNPnUTRyR
         4s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786499184; x=1787103984;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DpvSiMHFWPGGvTCvJybQfPYiAi3zlBmKnJ+fwsXosYY=;
        b=g2Bp6IljPU5ccIur1x5Us+St1tjQqa0HVHLbi/4jKn34lmEaGjPfa2DK0kYHChmlWS
         idCS3YNXURaqDHuNMCdzlgLdYQuP95JsfK7bD2wPdKuFZ423XLaHH3oOdiBqWXuhr1xK
         jUZ71K4gknAN/8Q1eqe8JsT5rhMy5we8ytKaDFflcbHmuS4yU/EzooaJNmjNU6ts1JLj
         KFRakQJv/IMD4stAH6Pm72OyO35gx+Dmsf2hhaKQ1QP6HTbv7GDiQxgM87nlTPazOKXV
         F4tv4sdnZQn8dFcr+OW0Th1MGixd38h/tCjA5O4h3FGAfDtFP/JH4TSFODG5vUnQYjcK
         oRMA==
X-Gm-Message-State: AOJu0YzkTP55SONI9UaZrdVtucbVZ6/sIE3g+vowXzgL5GJfC+mhN+9/
	TRhFNgiYC+Hdof8dziPpGcStv8GDi5+p2d8KSRhzn6EEdG9bOTMmTymE
X-Gm-Gg: AR+sD13D1N+jfFEQrc/ZJxOvReFxQjDw7S8egECObVCNMDES3tq5x8d7ShvuhrEE6cg
	A15g1YRRuHgKxqOr651Hz3cWkhtJBo+srepDrgQ7DfIrVe+71U3Vli59f1NJWQdZO8TJ1dZ9bu8
	smL8hT1x8tdcfGY5r2SwUjQUrtuoJaNBtUis2tMj2S/JMXcwRiCAojLHGgxrsXO33L4Ott9GIqW
	d1SMST/6Ylc4Ywgs6qKA+OAHf6PXW+fTKtQsJM0IGe69P0hCeXOH3iY14lsU6/bzVKMs5CBOGU/
	luUxYMwGUJvqE2bkYwz+E+QMJ6RxzxRZG5Umw1PPMRSx9l8lK9MkmMnwPn1vJilTMwTviEquAMh
	8MPS6+IRGIjmSNU5OfE/JbqqxI0v12f2zJXaNNNIo+ORd9vRXK1rdKH4Wx7Bbmf/KQh46TL/4+6
	70xP9YG8RR+zlcxfYaNQvfY5R/696PPsJ9y0H5TC/H+V0zt7W4q99jgn0=
X-Received: by 2002:a05:6a00:3cd2:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-84fb5594960mr1551942b3a.37.1786499183422;
        Tue, 11 Aug 2026 18:46:23 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d2b813sm388330b3a.22.2026.08.11.18.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 18:46:22 -0700 (PDT)
Date: Wed, 12 Aug 2026 09:46:16 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	fmaurer@redhat.com, luka.gejak@linux.dev, kexinsun@smail.nju.edu.cn,
	arvid.brodin@alten.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hsr: free learned nodes on device setup failure
Message-ID: <anvQaKjaW9JIDQ0D@fedora>
References: <20260808110814.1637-1-xiexinet@gmail.com>
 <ankqCHe8D9y09aN3@fedora>
 <063eb98e-95d2-4d95-9720-08b351fb6e6e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063eb98e-95d2-4d95-9720-08b351fb6e6e@gmail.com>

On Tue, Aug 11, 2026 at 03:56:08PM +0200, Xin Xie wrote:
> On 10/08/2026 03:31, Hangbin Liu wrote:
> > Should we use this fix tag? The proxy_node_db is added in
> > 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)").
> > 
> > Thanks
> > Hangbin
> 
> Thanks for checking. I believe 81ba6afd6e64 is the right tag.
> 
> The demonstrated leak is node_db, and the window that creates it was
> born in 81ba6afd6e64: that commit moved per-device RX handler
> registration into hsr_dev_finalize(), ahead of steps that could still
> fail (the second handler registration, self-node allocation,
> register_netdevice()), while the failure unwind never released nodes
> learned through the already-live handler. Before it, reception used
> the module-global dev_add_pack() handler, which could not reach an
> instance until register_hsr_master() at the successful end of
> finalize, so there was nothing to leak.
> 
> proxy_node_db cannot hold entries on any current finalize error
> exit: it is fed only by interlink-port RX, and the interlink add is
> the last failable step in finalize. On this path, the second
> hsr_del_nodes() call is a harmless no-op on an empty list, keeping
> the unwind symmetric with hsr_dellink().
> 
> Using 5055cccfc2d1 would instead keep the fix away from older stable
> trees, where the node_db leak does exist.

Yes, your explanation is reasonable. I just a little concern about the
stable back port. Maybe add a tag like

  Cc: <stable@vger.kernel.org> # 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")

Let's wait and see other's opinion.

Thanks
Hangbin
