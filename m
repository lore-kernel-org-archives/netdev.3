Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F084848BB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586453; cv=none; b=QygztX9ZsxavAd+MoO9glRS8Cuu/CvJkvqNVV0eM3IZZWBE4xxx6GCOvc1NuyHyfHp4LQ51Esod0UG1JVQphY/E1cR93sJV8PR0OU5REBrfxmeAxpzD1c+tpozx98F0/KAxJn5LUjjesJScTkyI3lzWtpuNkF0/ooKWrcBmiOXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586453; c=relaxed/simple;
	bh=/UOt2uQedRWESXwGbSKU86UuVwTsi7dZ0a3Fu6uoDIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy/hl5sn/iI4XfZoXOvLWICoNZFE1nfEx0NuNl+Chkh8rzWV/OO9XJRNzp5pgUqRwywIsBcOV1kvYCz/NfpeMrk+9RdKXaNoEmLIwMJ4bdOBA2SYDfurX22BB/y+59zXTtCLYKusihclzqwBpiy9hsoJXmxc5WbYwb6aC0nl/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz79uTC9; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz79uTC9"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1253266a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790586452; x=1791191252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1E3UZQSwjVkE3KiQtoKSXUNXEPFm/KrSXgLHxhaaSo=;
        b=Hz79uTC9fqLR5/sRG2dzYwYx0B2dd/+82gEON3ZBvZXwDUG+RLXyJSTL3o9vEA3pxa
         4xyCqzQhFQeygMO0RUQr3u0XKCiSe2pW64+mwPhsSyr3WLgjOca9De0cm/S/pa7DkXRd
         tO2b+xIb4rMu2cocVPIcAhhy55hJn3MRtFQnVKgQy1xenbv73fKz3cEDeyhMPeudL3Yn
         7b+gVur8AmdwY3mafQJW3FzhBLrqDzPHXHy8a2ZDsfZInHey7WkQnodz6n+2lw16wbV2
         1JBMA0FoqBR7drGIjh11flx1V4qp0VPRwg3JxlVjtoPvdRxRWT6zNh8J1EA5AA7Cx262
         UiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586452; x=1791191252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1E3UZQSwjVkE3KiQtoKSXUNXEPFm/KrSXgLHxhaaSo=;
        b=tJ8JLs9UpwKLk7ik3jPZ6W/k16hHWFMETkjas5HYl0JUnwQgOV5YLpZRQ02guOPdW6
         NWh3MZ7yRqxlPrV509ywAedDr8ytqQZFeMwFf5dXqTr3SwOZpTcnoT+ERvArIHuHmkFx
         W/YVx7qtHJRmtNzoi1xt1UJRQyE0tZt6fl26No9+mbqoh9m1Uh5A1zTin/Nepny/k9Ul
         SdXxh/LTebKzt5uhHVysJ5olnyOE+BZvXCOrPXvBJ+/A0MrIxXBvefPlKOCycQzi3cvm
         oBOaFYvpCpdIvNCrFtKejrLr/3xb7N9snClLYPXD7SGRwRDI8ZCCdDncG3VtDERbq/PE
         z3rw==
X-Gm-Message-State: AFq9FYL5t9Ti/RPe/CGs/TWd5Oo2yicdD3mt3+uoRsx2A85ntoZVg/C1
	XmplTY8v5Rd57OpZlV+B6iFbX6++3HvJrp8g13fo4ME0LCUDcM0RQg3adpQE8Q==
X-Gm-Gg: AYBFou0zxvpatQO4YtMQswLOLtBrRVoWslMD0i5oOtgIzHT6QptHhVasTwZif51VxQX
	BeiQLgnSsFsjA8VOdpfpAWgINRIKeIS/c5aSQ9HrdJkH8SMjhiKc/sKz4CAGwLJckLB/jSrDbdw
	HLAQy8P19awQfj+GxUcEMtJNMhP/8/ZZKGo67rLUxgnNd+9OFSaokDN05IbDiokdQ8z0OlIT+PD
	6SF8fSA3k54N9IFANiauDAsS57mG3KCk3Xjgk0r7k931PrOUwHi05+G159h1T23awZ4wSgsKPfo
	c4EIUZ75uaADooOW90pn8IcHFhxxV4Jt+dVatR4bxTNcL8EGy24JwVe6VzceuBg/4vtzZcfakQE
	uWKD7kIrPTfs2cx+4+zi5VtYHKnSKde29HgDg6WUB9WDDrWtolQQfTmodr0gWBCZHe9g8fBOhiv
	4xxlW8kiR+wyPhL2AzsCENFWtyQZ1mFBTAu/WN2I3FB/Z23wrmmrqe1pTi5LwiQK0ZHjZXXn+zx
	5u8w5ehq4RYlksLAgA=
X-Received: by 2002:a17:90b:1c06:b0:39e:135e:130e with SMTP id 98e67ed59e1d1-3a098570ff3mr10665304a91.3.1790586451842;
        Mon, 28 Sep 2026 02:07:31 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7a975b85asm1715527a12.26.2026.09.28.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:07:31 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:07:28 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <arouUNg5BdLRg_9Y@v4bel>
References: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>

On Fri, Sep 25, 2026 at 03:51:58PM +0200, Sabrina Dubroca wrote:
> The comment above strp_done() claims that if strp is stopped,
> strp_recv will no longer be called. That's only true if the caller has
> a mechanism (eg locking) to guarantee that strp_recv() calls that
> started before strp_stop() have completed by the time we call
> strp_done().
> 
> This adds a lock_sock/release_sock pair to guarantee that any
> in-flight strp_recv() (which runs under either bh_lock_sock or
> lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> has completed.
> 
> Only espintcp can be affected by this race condition, but this patch
> makes sure no future user of strp can have the bug.
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Hyunwoo Kim <imv4bel@gmail.com>

LGTM. Thanks.


Best regards,
Hyunwoo Kim
