Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0113812E4
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454794; cv=none; b=ISeqT14TJx0bz91llrmg3mpaEMGNJ6IIgp5BjsBDAubx+U9aTaBcIGNBEv6OGzbriGdkIMF00ymuW4IeNmpZaa3bR4J4sNsRjk/BM+7ArwNrMRx3G9hiBUwcNDFIMIOpTvz72i9Y9cNpkbIMMRhfRQYSp5JAeQD6wJuCjn3n3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454794; c=relaxed/simple;
	bh=yHtlU8jqhbeMht/7li4LI+DevJ0jrN5fWFWiOVMNcwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7X3UVWKMme1lgKu5CXahPGuwJyrJQXPfhEhLLEvS+UVEdBDm00aiD3h/BzlqTDvLmQ8NVp/IUW5SPeMBf7PH+lW8HPyme+BusOmTYprD3lUa7Zake8gte8d7oXUf7YZH3G3c5D1059UvMUO4jmNSj86rvWiNgWOacAYhymSWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA1phBzJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA1phBzJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493a6258788so8399805e9.3
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 02:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784454791; x=1785059591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JD3ZJlZlIgNN9I/5Tf0EF41vSuXVTcGu+pQrhKCsY9Y=;
        b=JA1phBzJPXWZd4VRSyCNqIjznlTP4HN8L5ljS2etQtvw40hZHPN/uHTOPMpGw+UYG5
         DNY9eJdFSU05Ejmjo5pXi8AZByPfvZQGcBqj7ywXnQ2Mfg36TsJgjw3TYefpIgqc+gs5
         GRU4E1yn0NtEQGDrbhinQzHLuadM3QHli40K4vwGtDDSsE5doRWJXyuVrqcMt5UuZQSP
         JxQYGnWdO3rTvnb8s0lmwLM5ECjx06hnb7wX8CtZzG80YgmrpQIF5vXHncpU3nxk4mV3
         mXOJY5WGZEqVkoLIh/C5uFtZsXifkOlFcEGLvfmNx+DYzmNEkxmMXgVIlTuyvMDTED3X
         4qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784454791; x=1785059591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JD3ZJlZlIgNN9I/5Tf0EF41vSuXVTcGu+pQrhKCsY9Y=;
        b=kV6v2Hu9foMjZ58eGpQ9nHr4q+OgPFQ2hiJ7+95mZPuYIdeuxMB8PpBHx2uT8YqbXr
         Pu0WjZN7/6pcIB91SRwbuNH2hTELTLwIzWtqCtxKJ0Fa0Pw6oOhbp3X/eeTgqi4y0927
         Sz+HvZBvAyNIDvzPCP7pIwbEQQ6s8NLNrv3pVWbWLHqyDa/7gJtWKtRm+NY5SRavP/bx
         FQBf7OtcUa/2HI9ccJvR8vsIHqsFOQohbVvdnSGhA3GPsVfZLpeA11rdiBGGg7VpCX7H
         xWLDYikepyVixR7DGWbmODtl8rGajEKXkHLkmdUO9NbdCUoHlfW6SeRNq8M0eUBgBL8d
         4gGA==
X-Forwarded-Encrypted: i=1; AHgh+RrCVxz34B/tQ7q2rXeXR7/bvcT9gODEOxh6+wOffsXV9o7ZuKgZ0AafQHt15ZjF5nLJSiG1VEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yzWrqxM9tnChZnCLflIHDDSVGSPGy9yUeP4tTs1rokXLk53u
	PO1Je6vYSd/cymALp7kurrtDxgiujlrA2r9zLnyPRofmk6dATZrdvB6x
X-Gm-Gg: AfdE7cmFbw5J9WUifTXqcGmMAHelXnqy12vh3CORNlz/nGtXfBkDc1ZVq0lo7h8ct0/
	7FwUEPpZ2wYbx4Pa+Ro6S8QroqpS8kX7vMGjgcyOyEnPnPCFWFRYricDcN3nIuIxGhJN3cG0mVl
	qFlhhQpjUH7eZWFYM9wwhIMMeanYRK/TX1sA5tUoCzuhFxIOfheeua7t4FiiWp3SYMPuFTdJo9K
	MwFPqMyY/LyZYuo3voxyd8W4fQC2u+JipphvFdZveIPoo7/xcBF61zwjzVXX9o3ifS0KYH3k74x
	DZ+eSURFIQW1b43YX0JUsq15E3Sc7JiLwXF0yYPTXod1h1Dszyd9Zmp7R8zffXM2hSkA7qSHX01
	pGxlQrz6ibnC6p/dF4CUKAUYKZkN7PQXXA2RR0p2mqAu/z22+njLg6Wlw1TXu+8TWqDjX
X-Received: by 2002:a05:600c:1f8c:b0:493:f7ca:bd6a with SMTP id 5b1f17b1804b1-4954a50d080mr65281895e9.8.1784454791047;
        Sun, 19 Jul 2026 02:53:11 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:a8b9:5a2c:9df7:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2f210csm207556925e9.15.2026.07.19.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 02:53:10 -0700 (PDT)
Date: Sun, 19 Jul 2026 12:53:07 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Cedric Jehasse <cedric.jehasse@gmail.com>,
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>,
	Christoph Mellauner <christoph.mellauner@joyned.at>,
	Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp
 fixes
Message-ID: <20260719095307.hwtnbrqdkjxntrcr@skbuf>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
 <0A7B1CC8-F5F6-487E-A14C-1F0C2D5ADC84@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A7B1CC8-F5F6-487E-A14C-1F0C2D5ADC84@padl.com>

On Fri, Jul 17, 2026 at 05:47:49PM +1000, Luke Howard wrote:
> 
> > ---
> > Luke Howard (2):
> >    net: dsa: mv88e6xxx: embedded PTP timestamp support
> 
> This can be improved: there is no need to extract the embedded
> timestamp in the PTP worker as it can be done directly in
> mv88e6xxx_port_rxtstamp() (provided tstamp_{cc,tc} are protected by a
> spinlock). DSA can deliver the frame normally, similar to
> ocelot_ptp_rx_timestamp().

ocelot_ptp_rx_timestamp() accesses MMIO-based registers, which can be
done atomically.
mv88e6xxx_ptp_clock_read() accesses MDIO bus registers, and the MDIO bus
is sleepable. Fundamental difference.

Your hardware only provides 32 bits of partial timestamp, so
mv88e6xxx_ptp_clock_read() will always be needed one way or another, to
recover the full 64 bits. Either through tstamp_{cc,tc} or through
direct calls.

> Deferring to the worker can reorder frames such that PTP general
> messages arrive before the timestamped event messages, which confuses
> some other PTP implementations such as gptp2d [1].

True, this is a caveat, but event messages and general messages can
already take different network paths, especially with PTP over IP where
they go through different UDP ports (even if for gPTP that is not the case).
The PTP user space implementation needs to be prepared to handle this.

> This optimisation of course only works for ArrTSMode because there is
> no MDIO read required.

I don't understand this comment given the partial 32-bit timestamp
limitation.

> Luke
> 
> [1] https://github.com/xl4-shiro/excelfore-gptp
