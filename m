Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF98421257
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173804; cv=none; b=JWMIwnLyHzXN1Dy/UKkpq7ydYYkPengfJ8A3kN0GPH1oy7y578La66l0BalyD4U46z922o0I24TY5dhudG1M0dKTn5G7Q481ObfCT7wDaEYpHudSGtPjLsdw18Lh1pqkMADMkd3NTb4WkFrSKfJt6f2RHt5Ms+2azlELnUct+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173804; c=relaxed/simple;
	bh=+J+cuQgIc9JNm85Rdu324qY41n+0ptxUvNYurbaGsRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Dpj6NlHMAX7E9DEqndT5HAtnWdUOXvftF5qrJXFsy8CIfBZZWnRNJFjabv0yK0KPv27G3hxt1URyis7aN+aOWDR6Z7HKR7JvHnbPGtJl+mh+Zg+DzHNdT52tX+g2nxJ4Bkr7TK0TcusLCvJcR0Mm2IOE26yEMK3bMCAdL1gvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=TE5rf5Lc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="TE5rf5Lc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caed617615so30792715ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785173802; x=1785778602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1KlH6Cmab6gK0vJk5fRbbbnaDUPzs0mortYt2ymII3I=;
        b=TE5rf5Lcvjpq0Bqx++NktKf4tCeKFzK0fK3mtvs/bKlgwoqT6KwVwTh/2CUJcjbgC4
         3hrvfIe15BscLCNI3R2OGz/jyFluUT/YfzuqJ6d7XddmZhSZQ+x4HiEuPcjB3KnOONTS
         zVJcVvPo3tFHX6rMaZqk17PwED8BclQ0XHyvO1zOrHlKLJL6sxK1nzg3a0q3CIlEZkaQ
         NkKUmsHaR6i7+8L24cezWE+LY4VPq2sNc1Y/S9HzH7oqcMgELUnE/DSzMtX8CtS8NqWP
         Z6FkgaCmoxwaDtjK5uZCNwBct+Gn34wzhPptLmjhFS9Gn92tDyrcBeUP8nelaZufC4CF
         mHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173802; x=1785778602;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1KlH6Cmab6gK0vJk5fRbbbnaDUPzs0mortYt2ymII3I=;
        b=tLflFcVaNXk6jAbIRiLk7WfYn6Y9+30IoMFPAeE7wiFnyfFc9C1CzZBPboxxz54hpw
         sfVnoYq1UbriI0jdiT0w1n9LI9k1f2WOZpBkPbI2o4PdZ6NtGJoo5Ol37HBNr3mOU1fr
         3K398MTPkfnl92Ag4fJMc7VBlOjnrKqQNQTxIFqrKCT7EPo8u01jylxvIuiQyX14EIPs
         AjyQ97hbOBZEfJvNjU8YJQiXzygvK+PdHZFEG4Rk2hYAW4SazWvEIxoRUnJv90o2kcKA
         iiy2Xp5Wi8ro09cOTX5PTx++sU/FPInfnDb+9tBWOKEbrq8H5sjMUmfYTX6rmEV0G5/X
         smDg==
X-Forwarded-Encrypted: i=1; AHgh+RrtHZl/c4x7Fumqf3yFG9u9ujrBh3CVakjgrPklEuxViDeCgE5TIxS3XdI0EVgBYhAMIrp804U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/12ZIBMU1/qLVcSnycvweO5VbqynlxE0rK2S/TXr8V2lBmV7
	PtdRDlTOFw5aCIoVKs2f9p9d4da0EpGL9tqfFClSv7/qcXmCb5E/70LomwHfIvjMkiU=
X-Gm-Gg: AR+sD11Jl3vpQkGUtW1660QsH14dMOG4lZMF27KDBUi+OGz27W2YcyXub7uzP0VTPL6
	vw5LxDhpPbwAMNMl39AHFbkrQz1Z0XhVM1pfxe2hdPB0V9sPSFFEruHQmKw3jRrUpbYMJ9XGOlR
	oYPyyVTTQwIj1gzJ/zct5qp/W2CLcH+IYFzDSXKLIikejsmO9GshGNJupTnFgja7n/tMjHaIp8T
	h2VRmmnMe5Jmg7yzZO/UFc/HwX6HyLseqnDimdeK1NL6+byx9jywZfXecYXiJNLQA7KfrVC+hVA
	7/FTH5wsgVWDoj3Us9Ae9juh6F8T76Ar5N6nfkoTzer4oxLDntFblsrCRqGcK655+qV3ooEOxUk
	HBhh5QXmpfcyIj2iX33RWMQolskAUV5gDMZivDNQQ0URC8TpaIYCDursYt6hmh74Hn95xf8hDJu
	pNx8CF+6KrmEmhJAuTopv++/VvZyWkxfxd3jJgvXRh/a9aArBOa7A=
X-Received: by 2002:a17:902:d98c:b0:2ca:ecf6:9104 with SMTP id d9443c01a7336-2d00f2bdacbmr2393515ad.4.1785173802044;
        Mon, 27 Jul 2026 10:36:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f8e73sm38909295ad.72.2026.07.27.10.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:36:41 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:36:40 -0700
From: Joe Damato <joe@dama.to>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ernis@linux.microsoft.com, horms@kernel.org,
	dipayanroy@linux.microsoft.com, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com, gargaditya@microsoft.com
Subject: Re: [PATCH net v2] net: mana: Return error code from
 mana_create_rxq()
Message-ID: <ameXKCxtanKiNJdn@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Aditya Garg <gargaditya@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ernis@linux.microsoft.com, horms@kernel.org,
	dipayanroy@linux.microsoft.com, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com, gargaditya@microsoft.com
References: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>

On Mon, Jul 27, 2026 at 04:37:59AM -0700, Aditya Garg wrote:
> mana_create_rxq() returns a struct mana_rxq pointer and returns NULL on
> any failure. The caller, mana_add_rx_queues(), cannot tell what went
> wrong and hardcodes the error as -ENOMEM. As a result the actual failure
> reported by the lower layers (for example -EPROTO from a failed HW
> request) is masked and every RX queue creation failure looks like an
> out-of-memory error.
> 
> Return an ERR_PTR() encoded error code from mana_create_rxq() on failure
> instead of NULL. The caller now propagates the returned error code
> directly instead of substituting -ENOMEM.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> ---
> Changes in v2:
>  - Use ERR_PTR() to return the error from mana_create_rxq() instead of
>    adding an output parameter, keeping the pointer return type.
> 
> v1: https://lore.kernel.org/all/20260718024818.560552-1-gargaditya@linux.microsoft.com/
> 
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>
