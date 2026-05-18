Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790D1C5F1B
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144329; cv=none; b=sbUwsIUI3CFFuGPuNaPsbQTytqDR9gqwIhxFXzJdLRjeEQBwcGUAZLr0KuEhbsIzpqg7/scOZPR+Ic46Jg37OsTYngILiRyHCmLyl25bKAIB5gvMHHZazNahbtFhSd/5B4bGtqXNIVvsf19JQ9/JpRi1wYbTvYIY1AIZVxRh/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144329; c=relaxed/simple;
	bh=cnniRsLFOk01Z/7XuKrCVPhZkmPa+e2hY1i3r8pNzPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvWQgfgdFJaxAIhAZA+HPXYnC4vUpjNnJma1z+l5u7e4YlMkVKNFT8lE4pXCi2fKM93OYNHyLogu2owSpLjTj8y3+Gy0zGLLrfoJ8C4inC1fJXElpBk/CEkrRpjPJpzd7+qzTb2alcYmuQzAsWtHkny0YvCa2XCsP6exmeTKLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Co1/V7Jp; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Co1/V7Jp"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c2cd216c9so2498012d50.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1779144327; x=1779749127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Axp4LE2NtRnDsArtRdnWVVhQ0pn9hV1WCuEIepOZry8=;
        b=Co1/V7JpUa7SElvKk9OjVbyX4J+c4mZ18OjdvytZH0f2gmlhXqmANCeUarSBuVMVGB
         +zHNpXsVuke68q9/vasDyLZSI7z11/sHxgca+6N3+ertkxcKjaU11XsRZhHbvV6eSVcQ
         uQ3kaVxMJU7sNRg5T5GWurZsan6W/ssbU7n6pvfFBDKvlT/0J76LRWvbIcIB1dCvWs0g
         lMvR2mh9RIy4vdPO05LXp5ZQjM7gREJIpeXMpMg9sTWt3j8jD18YOVjofSyV6O7HHF3s
         mk+x7Ge9nQvcfpIkm89yAjef3HQ+3wgS4qECWmvWPtAgc2axsvwmGllbA81ojJTyRgfP
         TYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144327; x=1779749127;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Axp4LE2NtRnDsArtRdnWVVhQ0pn9hV1WCuEIepOZry8=;
        b=ZCTZ5kk86yyK367YvNhcqLbwc48MzLbhSGJF6847It18D4XBXVNVGJC3sk9GP+mNZH
         eWX8ytSB8JcRgHl/oa1aLuA/9KjrCln/EDXfA0T1qHc5PouP06umv1yUAWoBRJs7ghG1
         8A/1cTqIAJr8Cu3jRVWaJqJ5sv3ptqZ6CmR+D2Z+gUoAeoPRsTdYpssO9Lq/ZWucvmxX
         6EseTiF9biQCqc5lXcP3usLBuGPmI6hfVxYgGlZ+dC0AJFE2zWMtSPtaVeN8nQDrf9dk
         PI63sTyxzjQMVweuRnZd2TJDXmd0Uo3epfFKNQkzxpEHh+oDcf4vXhXC0ThPABaKpY33
         ngng==
X-Forwarded-Encrypted: i=1; AFNElJ/2lF6L3Kd5rUOlIA1xBax0FU1yD1cdc1bQK8iZS6ZBBV/EBCjzBWNXpeoDXvJ1Kz6bS5Roum8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBKaHp5g+fOOIYQnlJ0g0Edy+lMXXen11sU2Cg3TdrFgBBvHa
	3ucS7bTQzCNhRsjBmUhn7x9Ve1pO37PlHtTBSWitt9qeATZvKaz292aKgDNAb0rrhgE=
X-Gm-Gg: Acq92OEvbVkGEypYVcgFHl0xOQ8EujKJz65faLcT1FuddXnXa/WMDvI6pRt0PdLqypB
	IO8f02g+kDURvknYCECJe7W8u7Xf8Yrprl6AI+b/eo2v4Vn+ykGQIIXJJZQ49uNIS5ly+GakBRT
	iHeFP6QbYci5K03xJV9ROGyxH346WZEJBFgQIChuRaZljqRne4X+Q783WJr3aG4MCOBEeuBpio1
	d4iH3M9BPUYnFrzwik5n/uufaZ827FkDIG9MGv3WGHw1aSk2GX/Q5q2mqUgsjrS/RgAGc5PWPN0
	xXxC4Keo267si3lnLBYq6PaspF1GBA8sMA8VsH/HahdOzSzMoFYyXtHj2UPnXwyMt/fYv1/itIw
	nqWsUglmJJ19btY5+42BacY31rmsEjuW4qpUt7vgAnQZttDuF1ktlCdaEtv7ZmUec5e1IG5pfeK
	NYlpes
X-Received: by 2002:a05:690c:3386:b0:7c0:82ec:fe82 with SMTP id 00721157ae682-7c95ab60588mr187569937b3.11.1779144327197;
        Mon, 18 May 2026 15:45:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18d8dasm28228067b3.48.2026.05.18.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:45:26 -0700 (PDT)
Date: Mon, 18 May 2026 15:45:25 -0700
From: Joe Damato <joe@dama.to>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	=?utf-8?B?Qmrvv71ybiBU77+9cGVs?= <bjorn@kernel.org>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: napi: Skip last poll when arming gro
 timer in busy poll
Message-ID: <aguWhSb6/PBKqJC+@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	=?utf-8?B?Qmrvv71ybiBU77+9cGVs?= <bjorn@kernel.org>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518181337.886459-1-mkarsten@uwaterloo.ca>

On Mon, May 18, 2026 at 02:13:32PM -0400, Martin Karsten wrote:
> Skip the extra call to napi->poll(), if the gro timer is armed at the
> end of busy polling. This removes the need for having a separate
> __busy_poll_stop() routine and its code is moved directly into the
> relevant places in busy_poll_stop(). Remove obsolete comment about
> ndo_busy_poll_stop().
> 
> This is a follow-up to commit 58e2330bd455 ("net: napi: Avoid gro timer
> misfiring at end of busypoll"), which has deferred arming the gro timer
> to the end of __busy_poll_stop() to eliminate a race condition between
> a short timer and long poll that could leave the queue stuck with
> interrupts disabled and no timer armed.
> 
> Co-developed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
> Changes since v2 [1]:
> - Fix patch formatting problems.
> - Leave STATE_PREFER_BUSY_POLL bit set when timer is armed.
>   Don't want interrupts anyway until timer clears STATE_PREFER_BUSY_POLL.
> 
> Changes since RFC [2]:
> - Sending only the cleanup/improvement patch to net-next.
> - Expand commit message to summarize original issue.
> - Streamline control flow.
> - Improve comments.
> 
> [1] https://lore.kernel.org/all/f0ecdde3-de16-47ba-b795-fe0042114e96@uwaterloo.c/
> [2] https://lore.kernel.org/all/20260428175134.1197036-4-dtatulea@nvidia.com/
> ---
>  net/core/dev.c | 63 ++++++++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
