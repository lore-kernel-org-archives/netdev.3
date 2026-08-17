Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323093F7895
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964335; cv=pass; b=It/AMKB0iWR/VnjmO5wc0rkY/V1pHbkaxEdhOd2VFN+uM+Mava7/nPqyPzOIKJ8PxtTyYggLZlu8gfmNtFU0vUxE/kea43sgNHfhdJ+Yvrn9NT8i0q2+dVLSNaijDUL7JRrD3Ze2oInWD05QibA3qLS5E4L+ko3rNcWltY+YBBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964335; c=relaxed/simple;
	bh=IMtbHlQWJKJmSSFhTgw7jWecL2Ir5wM0QgbUJG0kDxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/stgSAhusvqDrnTUTE6jh2LUvnXCC7xABKA//9PQ6mQkxmk7mx++BTXdytgjLuEkqV1+g2NN9EIdMkFvTRE+dcqnAzeo1o+RJWXuIEky6Yr1i7Mah+Z54qXQ+J4DeJ3nAsWJ6C0W5ND+veLzOLzWKjNypY3UnhqLByU83OwZcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9yr17vI; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9yr17vI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d01663d816so28028925ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 03:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786964332; cv=none;
        d=google.com; s=arc-20260327;
        b=fQjeqidtYAZjd9hwRiUXD+7v/98nadi/zvwSS8Pbwufe3U4O0NAMVyJ3O9ynNQoydp
         NqNuAoWSN3XWuwFGtTk0nKWfCyAsYSeccSgrFPyCr9Jhw6TrfE/U79Q3jBCd3agIQqtt
         xM4rPQubzcJ0Cf6B4aArl/YiGIiUqa5ttZ40UxRO7of3+QURZ28mfJHfMv5n7qFm6P5M
         QyWIef6HFdazvnMgw862yHjZO+XQsmDd3xZXZa/e7wDDo/3U+j6o5nek4oWN8zveqM6T
         9dnNyQJciTUaRbxlLO5fEo1MVRi8P2xDX81n6+FyHPhkYAynBI1P/Y3llvMwNkpirPBz
         6SbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M+b0jYgW03A+vd4O7ObKACxl7REgd1vcuWPPdy9fTX8=;
        fh=+yN/7i6EooBJac+JdFMyu7PyewN/j2Tfwf8uLQHEOxk=;
        b=WEV7EsXMcMq8QMCkqlJEHWO/1uqE4rPedfAuFSNDiyG8ZXSwwSsWl4Tue2t73tqj5z
         MjfAYolNcYCJfqjRKJQLaT6IAen/F1SotKOkT7h4KsHYHws5HwDvlNtOj6tGmxWLGep2
         AhmzpAw5MGIDuUL/Xb6+dEn5w9c+xTeT0ycSAZOLdLf6hwt0HdWKns2w9SWI1d298XeA
         vV+2SV1Ac8/q1jXDOGD/eXZch4cvAhEhnHnKuZVuiOXnIEBnZmEt13Kry750/4VeRrrj
         3j3oT8ETcKpV2k9bUWckg3cCwvKOZ4Xn1bfGyXuuwq69eBtG5QfL53YLRBWcifPxD1gI
         B22A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786964332; x=1787569132; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+b0jYgW03A+vd4O7ObKACxl7REgd1vcuWPPdy9fTX8=;
        b=e9yr17vI3M3HjjDCmY95nLusd9hC7IJRh3QyNiCH19V7zrLSbktDCJS7zWKT2BSkfN
         AVQ5zCpBMRNKuHEt0eCOhdYrT/y1NrzsPgLcGLfjgCLnxBu8knJYVMKgZv9kxXS5iiHq
         gVIKmjruALQlLWIYWVCoNvFCmLKRIDRImf/dtDT5IG7ar9lt1l+B10bR1e0bznRpi9ID
         y47aKX3oLA37wGZvmGNVpE9UxdzryYks1y/cChiEg4fB42ZpassE8+qblGPZvS8744Zk
         jYhzkjvOXU73Fev7umfAJePtEIToL8/OJgDw9Yb5RCvdJzll7plZq8sWFOKFx+27t09z
         zoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964332; x=1787569132;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M+b0jYgW03A+vd4O7ObKACxl7REgd1vcuWPPdy9fTX8=;
        b=Z7EVXwnQuU5viDDA9reuj8Ow1Md5hv8V0wmV5BUBCtoZDEPjOxX+RV7yuQUjxFdih8
         Gw7BB/OaLNizG+CYOoTRbukuvYsaRi33hyZGE7Vb6IRFdEDE2nfwAFO+HeXZzKpc44HY
         2yp1kIk6P0YQT/Eg6Ur9rZhyMXfWP3PRs+IxYcsEyMZW0FpeKf0L08Vb4MDjsk/ZCOyI
         1g61VerIfMS86jW1MXOmPQ3Ffc7fb9NnFGJ7mCNKYKEz3h1VjDt2HCzOim3s8bfs5Kyt
         KhMYe1//gMMGn8JsGHQsFxN+DeOzmT0dwVT0tIBqEmqyv2zcjd+vUd/j/GJ+EKv7R7Tf
         u8Mw==
X-Forwarded-Encrypted: i=1; AHgh+RqRzf3qYSfOAWqTJo37UhdYvPQLkCEEQrcQ8uN0BIiiskWaDKWDfvuDLhLy8pyb0Sj5XFWD9Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBZB2LUHGwrvRsaKcL+URJ65q/eUlCx0CQT5B2pTo2I0J7fdD
	4VZjwXKkaRokfCZ5xS96uzRx+DhOW1rp2/vPA4B8149RrmF5+aNConte2bMnBp5L0R/AnlRTds9
	nORYnhdWJ2/L+yJNUUN7drZvLpxHylwc=
X-Gm-Gg: AR+sD107C35YEu9LXAhwWB3ADcjB9Hq7dt5pVAZMtZZrxcetIBligdsyOygWZmIlYv8
	cYwL6QQED7wTSE1hlMDI0ysPQ4rXxJHmvCwd3AQQb3gkSoNl2zHhVKF15CMVdE5OfZKI+cwohVP
	JxAB6TuNsIBLnbRVjjmrhl2fgkk6pq2k18ZAMHDF19q7Vepb6uWsI2V0X1CGmJkaFSRYBaBPa+M
	px0ycM1Nje44rcp7hG0aH/7XtRZONKBK2i8wVGogkzZq9A5LwOJMgntacF+13JF3npFJ+YpwLTi
	iPWdIlowVlR+wk8GIgyMgXVNqVNvwuoZKPR221cl8IpCYWtZED4E30naFDkdjETW9dzi/2S01fI
	rrH3paOmKnB1usyF+KiSbDWo8d748hMHEz6m8eWQXHcObpmVZhSOFEC8s
X-Received: by 2002:a17:902:d4cf:b0:2ca:660:b1d with SMTP id
 d9443c01a7336-2d3b0d5eccfmr247797795ad.11.1786964331843; Mon, 17 Aug 2026
 03:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813042012.17631-1-phucduc.bui@gmail.com> <20260814170001.GQ265046@horms.kernel.org>
 <CAABR9nFxfzf8QP-wq5iaJRTL+HG+a+tNqqX2daj-=Cwp46hPJQ@mail.gmail.com> <20260817082119.GU265046@horms.kernel.org>
In-Reply-To: <20260817082119.GU265046@horms.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 17 Aug 2026 17:58:40 +0700
X-Gm-Features: AcwNN1XKH4dVb_0RJE6LwSHqmPfYDPdjDqVmlca3ZOszbhsVaf-YGJmUq6V8L8g
Message-ID: <CAABR9nEX8Sc3dSO+XfA5tQNjGeaRKikS3ijJ0Eaf0pAKq87LQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: xilinx: axienet: Propagate errors from
 optional IRQ lookup
To: Simon Horman <horms@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

Thanks for the suggestion.

>
> For future reference, I would suggest including something
> like this in the patch description.
>
>   Found by manual code inspection.
>
> Others may differ, but I would find that helpful.
>

I'll include this information in future patch descriptions.

Best regards,
Phuc
