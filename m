Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483D313545
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729526; cv=none; b=o8CnewLy2OplxVmqeMH40nEqCc+pknPIec1FXKrtxlTK6hAp6X99hKSA6ZsXQtdn1GnToySBLqTGgykSTKxsY/XM7b84ILNg10mG4DBbJWgkfvv4Cjf4sviHzPIdwRFy3g9pcw08SeoSeH/R/m61gGBa2HN9cvIahRaYZyPY2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729526; c=relaxed/simple;
	bh=fJS378DGchuor7MNCnATiG19ouASGxvH3cO7Me3U6to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPbcbayJG2Hn16opKURqFXX4B9s7yEKAC7bLkVR3NWyorrYZWLvlkiyd5t7SAZyWzW87z6YlYIuzVJysLlKlVSyG+LA+ebvDdE/W0MZgmEof3mXr88/MCjk1kndzn+uLaWr5LxooCf7qsOVVfsO5AFuN05zVOF99rwMxkh733Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=yCqOphej; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="yCqOphej"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so2610453a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790729524; x=1791334324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5FicaOCCyfmXlLrOHDCaMPxUTYXMK90aVEmd41VETg=;
        b=yCqOphejBI9LSDXmf8R7kvXmYJaCRiugXG4tYycw7Jpb1ScKxcIEbSLFRWjahYFr5/
         Epha9cfrbJNcuKUCGdal4EqeEM05zKGJvZdIpZp1wKK8+6AWb43GWgwuNvoaTwGycWPr
         M4I7jXb3nkbiEmR01RiPgkLL8r//ij+/NKFr5fBr/xJXkFDvcH5x6La6K02Ane9a9f9o
         i22YigmUXKYbDmzu8kTfxxUdDItvj62pZ/5SyIua4PLOkHhDtyVthqlJ4cxdxVrRy8Pa
         jiOv5n3ND//uwvvvC6SEo8+ozhHoIO3G9H0ZRaW5KxSVJ9SePyqdU0TNSb+DajFUIcpj
         +lwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790729524; x=1791334324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o5FicaOCCyfmXlLrOHDCaMPxUTYXMK90aVEmd41VETg=;
        b=lB7ZQ8qkgw2dWqCTYMr0QDYgb6dWVzajHHO0fdlkiWh4umd6HQa5jsHamq7W86vTOs
         cfY4YBjDBouaVzUVCEOXlYMkXGI9s4NFs24r+DZgykSv7E/hBuDk9z+Cn2njsBy5DTOD
         HG4AKJm4ccn77xKtSd9ZQO9rZBWpppZPUB8MyZE6bBKD/u4P0A6Lh/qhJo6Q5azEOhl/
         aEHR6CwlJcRMgHU0jurmBuEARyoDNO5Mr9eR0uq9RnsMrqOe1akDdtMZMZjOqokCAtNm
         PCIQXHlIi5gk8/KbVbqU+wzBeq7o84j80onuQ0dY2Uwk8p/f9XKj37WURMWRPifnAm+o
         L4Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxyFFg7u4zDIiCDnE6EqUiYPUTNsNyIZQFgRXFXzE4JYFpOHO+KwMknoodTGy2NGIcfLuuRLsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ21V0EC7hW5bEYN0ZE1hDUuoP2lNct6Yti5xZhU5iaL2l2if5d
	wevaxIIlL3k71w6AegoVqy9eHGFTklY1EfQDr4ldc0GoZrtteRONuhEncraA9wvRlCI=
X-Gm-Gg: AYBFou2U8TUMbLRsJCYGVjBLlfbv0YPQOq8OFJfOZqHA/HR9uCL5fUGKfDi9xTSsfGC
	6BIX8R0+W9jKLFGhY3+wd3B9VnwBNdVpDM2geBU9LLQpr+WsK22qeH6M0W3xDoabdi8eK90xh8j
	q//aZijye7ifuHfgxlQ9kUTHuey90LEvywkw1/6Ud+cRFKQfQCpp2oeFr+uUhVThLMiVMRbAM/1
	HBD7RNoSFyAXY/97csJPNMcunKNXa3tiL7wi6wgViLvFgUddQH5vJUJ2H32amfQrDZSODrpyMc4
	/ckPZ5Tn7/LWPZ+pjDy/u2ELINDXJkYYOYs7Pbrb8XDIezIS9ntm5bWD+YbrrrPRnSSsmB+f+B6
	XssaT5ShotT7bfnZ4wRPbjWxv45TDEHOZqie9z4jlVzC/cuYUc2D2ausxoya7QPR0cMXPOKOFI6
	WSp+yjqumrYktHeoWte15byzouyxYA9hnL9EFvMJ/Tauhs0uH5Y131UhPaxTQ173LcLvZv23GWT
	nXFxLvvuPbfD5Svh5ZoyuU=
X-Received: by 2002:a17:90b:2803:b0:3a0:c621:74a with SMTP id 98e67ed59e1d1-3a4bfe50b4emr880690a91.35.1790729518808;
        Tue, 29 Sep 2026 17:51:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cac328c6sm418676a91.12.2026.09.29.17.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:51:58 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:51:56 -0700
From: Joe Damato <joe@dama.to>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Aswin Karuvally <aswin@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] s390/ism: Zerorize dmb at allocation
Message-ID: <arxdLDluRpwizKDC@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
References: <20260928114741.4135978-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928114741.4135978-1-wintera@linux.ibm.com>

On Mon, Sep 28, 2026 at 01:47:41PM +0200, Alexandra Winter wrote:
> Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
> uninitialized kernel memory to be exposed in the receive message buffer'.
> An ism dmb is receive-only, so the data is not leaked to a remote peer. In
> general the smc kernel module (dibs client) will only push newly received
> data to userspace. We still should not have uninitialized data in a receive
> buffer.
> 
> Since
> commit 750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")
> dma_alloc_coherent no longer required the __GFP_ZERO flag, but when
> commit 83781384a96b ("s390/ism: Properly fix receive message buffer allocation")
> switched to folio_alloc(), it should have added back the __GFP_ZERO flag.
> 
> Add __GFP_ZERO flag and state in dibs.h that register_dbm() provides
> a zerorized buffer (dibs_lo already does).
> 
> Link: https://lore.kernel.org/linux-s390/20260903143746.A5CC41F00A3A@smtp.kernel.org/ [1]
> Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer allocation")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  drivers/s390/net/ism_drv.c | 3 ++-
>  include/linux/dibs.h       | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
