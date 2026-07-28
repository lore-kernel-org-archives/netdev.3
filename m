Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15373B14B1
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266572; cv=none; b=dN8bM4m8yRS4Io45d6V9Wwx/tsLCweqww38JQHAy6ghrXCarQeVe8HGaHTZQrZnW9BohwudVGcX6F2pYLGwfhezh860jvIEq3UMpUzzcyx2PkdRWCLMMvPlTqQrO7MnltRgSlVV50aozXYiXQQnSczaZO/snpLVyGGXwUosJLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266572; c=relaxed/simple;
	bh=2D/FRK6IKfH3OlCbpGXwXKTryIfvwjIoDuGgo/L1TQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E42LKMPHlPHmVxol39EGf4K1LkUqqsa6gnlQtXmDA+HIoCkib8neG/44N68V0nJHr/JYhuNFtmxj7NSGlOqSzdRzMpomPHbJBP4GcaNL4lWZqi0BqgJT6qixK7yrHM/Yalw/D68FhScofypK0yhfN9luTxXg1aH4zrNl8z1Wub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=lorJfZJ9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="lorJfZJ9"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84874b52eabso294921b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785266570; x=1785871370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nw6alsg9i/3zFCeIZXaBR9Fk17tbjbQpGkOg3KxSAGc=;
        b=lorJfZJ9XqDmSSPRNQ5W4qKbdGaYDgmBwEy+2VwWfu/X4oH7S9JFC9SNUmYAY6HZMy
         dmda4kTlbOmQP2LHG9Xhkh3EDnR8wvbMJQYBppwk0fkUiA9KhxnpP5/rVn3Iul+TQWSz
         LCiboeXFaDy2oXCQbjjk7FWP99UP65pl9SFP34W8sVJxBcRaM2hAu9yTPqS7kCEySCrN
         1pRDjPHf3y6KGPUTVhjw50LP/UGDnX5G9PTBk1OTP7gSPrJh8gbQFscu4SXVNWUL+oB/
         OhNv6QpH7IJDXhlb/P+sEpoIEPAjGcOrzv5K7ueEmoTaQnHLmjk8Vn5MbiUiGWeJMYKu
         ATOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266570; x=1785871370;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nw6alsg9i/3zFCeIZXaBR9Fk17tbjbQpGkOg3KxSAGc=;
        b=jmznrYx1BCszZIT6TqsCBgDlsvBOG1Rnvex3myCZ9aeENiuQhTk4wM/lSVWMR+OUdW
         3CVv8mqPm9PzDQmAIJ/y3icid3uuYfAH5ArU/j3b8y/NlCWdkCM6ElsQk9jVpWAq0tHV
         KS4+c6V71d7QiAg3pB7unHnj52SKDNiSh0u7XOYpOTQF1hiNjHOWVdjynOMBX9BO581g
         I9PZeE0hWV6eDZxviJPLyDuQ93B5ZnxPnUUT2YXwwUea2xLYW1zMoaPGWvOd7LOD92yx
         Vw0XWUfPqoRe2sOkbBCyu91EAc+s8eMN+fQLvxX93+Y8imddAF97uijl0ofV8k4lVqhg
         6Mwg==
X-Forwarded-Encrypted: i=1; AHgh+RpUUDhXe7ikiifqxgxfbAvuUbVh/R5O2+TQw117N5vnYn9uZoBLwSv01M4yEUoxePRHiIB8WLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRUW6Px3W82dL7D5HACkzJA5/sVfmelJpM2LmXkC+KCv9wh1Y
	25WN+2dt9IzaZ7n6K0swYVLXc+11K6BYF6fGA5cB4syqfADY97ZTp0oI4nd3NzTk7UU=
X-Gm-Gg: AR+sD11V9BSz67YQov56vvWYValZBnbQgt6znU2LPgRTcGNR5uSTtEhCuPH933IR+cP
	93d/6xQ2KcMl1DHUNoYuFwwuXCI9aTzeeYitxLKJ0oeICzvsNez3Aducwf2gVsa8DEojSb350m1
	cJqttBpws7bFYYlTsGjuGyodKUwqb1WHyUR394+Q3oEWisk1ApSUWj6rJniXnxXKCLRPQLCQtJn
	ReflvrcJQ3g4K6EXBhBFuIGhDTYyjD3N5A6/5M+Ua/tx8SZoQGaqGr8fO1c9VqhQiXpLPzfHopl
	uVgKusX0pJPqD34dfPWaZ51794YSnR31toO7s1B2iKNxuydZuxYsIrdkp3yBY2G+KCX9eauaq+c
	701q3+KIu/98PB7kPCCIo2jQgH7cmF4TkI8xaWUqBzFPQa/cA0+2cbPsAOBTPXwmvh++EaQ==
X-Received: by 2002:a05:6a00:1f05:b0:848:2f77:e2e5 with SMTP id d2e1a72fcca58-84e933abfa9mr4241034b3a.78.1785266570052;
        Tue, 28 Jul 2026 12:22:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa474sm344039b3a.30.2026.07.28.12.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:22:49 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:22:48 -0700
From: Joe Damato <joe@dama.to>
To: Will Chen <will.chen.tty@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bnxt: fix memory leak in bnxt_queue_mem_alloc error
 cases
Message-ID: <amkBiJ5V9tgzZcYS@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Will Chen <will.chen.tty@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260728191146.1744825-1-will.chen.tty@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728191146.1744825-1-will.chen.tty@gmail.com>

On Tue, Jul 28, 2026 at 12:11:45PM -0700, Will Chen wrote:
> There is a small memory leak in bnxt_queue_mem_alloc:
> when bnxt_alloc_rx_agg_bmap() succeeds
> but bnxt_alloc_one_tpa_info() later fails,
> the rx_agg_bmap allocated by bnxt_alloc_rx_agg_bmap()
> is not freed in the fallthrough cleanup cases.
> 
> Simply free the rx_agg_bmap in theerr_free_tpa_info case,
> as this is the only remaining error path where
> rx_agg_bmap is allocated and needs to be freed.
> 
> Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
> Signed-off-by: Will Chen <will.chen.tty@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Joe Damato <joe@dama.to>
