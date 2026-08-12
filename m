Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71478395243
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560050; cv=none; b=ODPLoNQNvna8RQxexeBaKTVzhzyHN+vNQ9+vsGJxuC9rzWPCQx8wxRSeQSvvHmh/Y2u6qjTAq1smXuj5diUIpC1tZnvC0tiFK6EWx/+rccqFtx0Ig2lZxNSYAz8mUaT6g++cPa4AZMv9cyelx5hqeFcySUS7BiEvZifdwbYqfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560050; c=relaxed/simple;
	bh=AJ0HFagxwXLhWGH0bMMMUlIBm8aIOuEXdITySVjzsno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac0m0KcbFEef6cPyLKii2KDS1hS9mlWRgnTIFHe+hIGLFMwNFyQ5fo5nDRpXsJPeQtE3dC27AwYmWfp19CWNyUEav+KbzaHz0xZisNSA7FI2uApIHFD8K686Yz/tTCpIenWeZq2eIti3aIKfFuGAEmO1srUpdQuIl2/xnq8S1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=JxHPyft4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="JxHPyft4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so17409105ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786560049; x=1787164849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/r0/dZU9327lVW9vWBLzNVNNVeObkOD7Ru+Xu9UxYCw=;
        b=JxHPyft4xlROG9XMIqAKsYFr6VfhrA4BUd+4aSqW79K64FcH5ZbQWNXQbGw3GiRCHE
         ceo460PvN0k6m364nNzscXZVbadh+iwQRXLNvV9I54QOAtDYJGBIhJAn2UrxRFKukJDw
         NwsGveaoC96eYJ35eE6afO0kI3Yw3MEfrMcpSr8JEWmXg2BlvG+yRFcQDmJL8nxLKfNj
         NPRV7Pw//qqEfHNngv2DcHYS/uD6pAIDPO9YZrMa4sJEpkxhskDgYxT6lSw4wZmKhS98
         fTg3iz9bUPCTygqiwXLZbiIVVPpcr7FabEbZlK/UYLO4HUPfiGtJ8DyFNaK++JUth2J8
         PrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786560049; x=1787164849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/r0/dZU9327lVW9vWBLzNVNNVeObkOD7Ru+Xu9UxYCw=;
        b=I1c9s7NAKV/ytbovOuVEg8/Uas0+W2zhDqOqai7QXLOzKoAH5IfZiyrgozLJnLz6Fe
         zLHIkRvsrbXDKUwOTAa6/9HAP3uIsNIQWaT/XlnyGzlPZzgbquqEvH6OhNFQRD2plUR0
         TES0DVq87XTdqb/NIa729JIdNurSC0c+aqjR8adWdVsH0V8ALAy7NBt/DNQNVXoBWBqu
         3f/L9GeMzqtPA4yqyNfDrZicoTP1tWnECHQzNw+5PqRjIw11AFYls9qJAj6G6r+TNDu6
         zkBbfhOGGXcy0pUPCX7P6G4OPjlaXlSjUYFY10sIFrhQmxxhWiRR9euG+TQ8ORA7J3iD
         dxjA==
X-Gm-Message-State: AOJu0YyKFGe6A1eRgrrIqU5CHzwPS3yxTS+RL3ES6lO7Hy++2KtIULgF
	RO1hnUFYVg2AU/CMaxvK3n5u8jcHzwPE/s4lx/v2fvK3TKxhsYtaCBT3HqSp2Kl/zQ4=
X-Gm-Gg: AR+sD10gCRFzu66+RxN+ZIBabbQLcqW6VVIoLvwxCiiaHfNmMZ9g991lUiyl7vicDwC
	9CbctTrD4bhcvQSLYjFlGn7VxCgZ/t6LQI0OLsvlbNclCiKMKKhxaTcvhzZogogw5vvSe7h1eHM
	ZRSIZ1JDBtdDPx7rzwfcJCWWcY40NIXUD++hieLGRGfs6OEMcHWBE/D+uATGhyjnwn8cf5+i6Y2
	ul9gf8KwGfLc3rCgqP+7XIp4XNkXF9DYqsNuWjkNhjZNogo3eGm5uXt1qum7hDKUqbe/n+HuEIR
	q7voQ6eRHKLZ0hGfcYmxMI5d+l8SA950ODkbCp6Ad7aKvikm32nn2iANaD4pP2eY3poYj9BfAqv
	jo9t3d+L/msW7b1m/zAIWYfl8kRP5TrJn+vvIs/ztf1grMxRQxunlbWxwpQ+Uh3LfrADUdByM6O
	SI0zBUzRxNHMBOqd5eajEebY1k84NTxeevIsucTLDWfw==
X-Received: by 2002:a17:903:1d2:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d37d57393fmr130535ad.7.1786560048672;
        Wed, 12 Aug 2026 11:40:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c413294sm593745ad.51.2026.08.12.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:40:48 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:40:47 -0700
From: Joe Damato <joe@dama.to>
To: Kai Kuang <kuangkai@kylinos.cn>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
	f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
	kk47yx@gmail.com
Subject: Re: [PATCH net-next] net: dsa: drop explicit NULL comparisons
Message-ID: <any+L0W4g9I+MrZ1@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Kai Kuang <kuangkai@kylinos.cn>,
	netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
	f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
	kk47yx@gmail.com
References: <20260812060644.210997-1-kuangkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812060644.210997-1-kuangkai@kylinos.cn>

On Wed, Aug 12, 2026 at 02:06:44PM +0800, Kai Kuang wrote:
> Replace explicit NULL comparisons with the boolean form to follow
> the kernel coding style:
> 
>   dev->class != NULL  -> dev->class
>   user_dev == NULL    -> !user_dev
> 
> No functional changes intended.
> 
> Signed-off-by: Kai Kuang <kuangkai@kylinos.cn>
> ---
>  net/dsa/dsa.c  | 2 +-
>  net/dsa/user.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
