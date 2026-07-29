Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7B42B753
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311424; cv=none; b=LC2BU7XLswCshaczyGgn+cfggY7DqAYAqNBc1aA/FVcpv10ZmE5BGwVz/RKYUKJJaqN+hOHgFHMTFccM3s9pbxj8ZJSUc8WRg+bAwQL7ZewwNlNaR8BtBIGCDd4hi4z65injKDdidR9kCJb0IdlEBd6QrZ5HpoeYNyEaHjnTuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311424; c=relaxed/simple;
	bh=pB/iasdouCgv5+/m46LVzlmorsCQMcNvBL6R5iWICCg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l1Yw6scKm2xpfpko8DWC9WrJDDOJ0wDns/jMJTccviIVbR44Z+qQ0m1SmlDzEKPhu49GOlj+OkhevIax8iWOykgU5JBrFwmy4PP7MVq3tJ8bqRWAudABcU8JGBGsgYNBNrQ4MxGp/5xNosL1r9ULt45Wqq7sMnI9CqUqJSWVMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUeHXoaj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUeHXoaj"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8143daf89c7so7330107b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311417; x=1785916217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ArooMk/BeNv3RVej5k9pLl6zc7N9gWRgmh4NCVP0KIM=;
        b=PUeHXoajv0ct1qLAAzu+knf15p8Ny4pI9PwnQNJBe75B+q6jMpheETqFLaw9io5kZM
         wubnwK2qQqu1U7BFTjFj43/4mBb30wbYhUaf7y/q+LYdXde2wzlJnBUxSb+xzrSYlJhy
         vZCd89Gx1u65IgFLONAJZxlSXRQOECh7T0C2b8HF6AO7SRK7IuUAQK83j18mRsTlWMsS
         LnD7YSYuY7LxA5k9oxCEWQK4Zije13LXx99iP7MRDKyf60/buaKcx8KneTQsTO/OlHgz
         RwbIRJ1QySdCAYvaxozc0dfAklR8pJSPGa5/Bj46PQpG/zAFkK8r6fmisTidbgWO/h4D
         2Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311417; x=1785916217;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArooMk/BeNv3RVej5k9pLl6zc7N9gWRgmh4NCVP0KIM=;
        b=Yxt8pOLG32QLS/nvnwniX6m3UFDC53dJS0bSE2KUns6ERSBCBQR3tm8oEqUdDfmVuA
         AcOESyWQJRmaEwKCKZeU8Ivq+62jS7jM/RtdxBTahgUa0JJlP26E9dRsferBXRTL1O9W
         QdapDn1hu/sdxE42CXG38wpRcl65iCZ6yrOyRLYK4hARIr6/x2NYcYD7QYsMD1JebMCR
         xhvB4kA3f+I142PNf5lx8LgZL+LjYS+Q1oQy1m3BQUq9VmH/tPRJY2bpBQzzzZ98Na8f
         QeTuMeD3DyyhT1us8Fngd+83tv+VBq+CSydIEj5Y8huQ2XJ5v2cNQ5Hc/Ql77TvU0k+5
         rQSw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2uTNMHOMpOnLe9nI134/LnsXfeNGTX/IOXx7t7UHpTUbNz2SvtDJm/6WKxWYhNMezx6TBHLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI31g5CcA3XFyEKGeGgxT7AdQrpA4xoX5xlVHptn4M14SK9mQt
	u6D9aQ1D3d/L/VFsxmd2ynnUztu/xjW05ib73AorPopzyaMAAGATjWdO
X-Gm-Gg: AR+sD10hAj+YpbpmwDCIsiyLoQRI/Hlv59q/3gox0Ty1H9Ua8QE8XGSgpVk2/7h0wvt
	wnYGYD31A6Owu4/4OkVqcdYQPFE0qRHz4yZq248YmcM0kvqhbidSuSghDefvNRsKOUrIY7322ov
	+W0VdhVKUs9kyxWtptzbXI6XRxma1YjM6wFSowLtWpoul8JIDEf0UQMBZQNZc4WqR0wuBOy6zeD
	zDk6G/jzGXU5upaDSCEJTL+do4JjvPftF3qEw5qNdaB8Qt0oexkdSUuOlp9htpcgFCcZRgof5fi
	llQhVHznuR1URHNm9kAesAraxCWX+NOOiqm8/1s8rxCkdbki4TFH+KO3Nr17IDXgDVGwf13hHHd
	CyznuxuM0R4sNgtyZkNnjvTKpiKRZ431L104Z+i8GcfqnDGlh4wzHanLvcljv2fuf3zEACrj2ps
	X+WLKmvfSlGkpUSpK2R0fYx7QozwWVqL1Ro3OUQg0s5bCj8RbLKZvt6JfUug8w4mH0uFYmpBWzq
	xvoS29O+ntcMeEbAnJZnvuUVFHSm/MNIfquH5ixsu2mNK8=
X-Received: by 2002:a05:690c:2782:b0:81e:d081:d78 with SMTP id 00721157ae682-81f9941120amr25198687b3.69.1785311417493;
        Wed, 29 Jul 2026 00:50:17 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa2981260sm13507387b3.42.2026.07.29.00.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:50:17 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:50:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3190df0497e38@gmail.com>
In-Reply-To: <20260728160935.4128982-5-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
 <20260728160935.4128982-5-joe@dama.to>
Subject: Re: [PATCH net-next 4/5] selftests/net: psock_snd: Verify sll_pkttype
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Extend do_rx() to take an expected packet type. Existing callers pass -1
> to skip the check.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
