Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661493AAF62
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342260; cv=none; b=OUGG/8v3dCs54cljm6NlI+n/JBwlDQGpuaa/BUGR2VXOh09/yb3NIzoe+X/1uYbtYl7A4k6Ks6oX0IhfRADuGAIIhRCR4kJODQyDBDOMRMDnpXIFBZKQzXC6ul/jGBd4U1JEP/MC3mAmbN8GsXVV8nzadEmcZnDDtCH0Xpx9A7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342260; c=relaxed/simple;
	bh=5YRWzESNup/uJaXwpxZXtL2cnI88MqsveWuEJC0Yp0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/IB0ibcIWG3Omm9UcPetIUXJ3VW0HwAdk2iHEy3NumumIWtVzYQEdtiHFUyul2/0jU4UiiwgPW9184/PxrxiWmH8KoqtlEvbs14is1+9MXMcSg2R4pxSm2eYXoK33ntzI5zBiJt+R0bRRBxZCQoWrCwjQ7hCTOHW+V/Nyn6KUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=uo1Am/Eo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="uo1Am/Eo"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso671358a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785342259; x=1785947059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhhJU7MnTb9qUtSrGFKUek+jSKmzQXJZbHXf+DBOgvs=;
        b=uo1Am/Eo52B9YEe+jwBKnL1orOZiXzekZdEwMuErRGBKVDJgQ5voDtCRakP4kfXqfw
         br7YCyQhFMIZc9I9bc/lIV/tBedFAo5Lyt+66Q52BEgFhKbw7KAARQqERG5JFhanUYHV
         ZK0MH0lxQSY9SiiGO459vlB5pwVB6NQpOHEqGKNjKsxLFb8ndWozm1aaJgHWOMj2YBoO
         8VHsHzywZZyXEvpjwlTqITrFni/5zM9eEPpjeK26HM5LjAcM9bDShQjU+P5Gcz4MNh5V
         Acx5UaVlJzJsfJUGYPXiyoIgcV6tFnNWlgRsSZ6YLK2DeuVKG6nurm56MrojGdyRjZYT
         SIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342259; x=1785947059;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AhhJU7MnTb9qUtSrGFKUek+jSKmzQXJZbHXf+DBOgvs=;
        b=aUMuHPApTxSdNwL1wlrU8c1h3zxWzdAhQy2NBSZixafwHExOAYB5b4nvUjEtKjey89
         1yUUggpTgM3K3ZsV/Z9iKm7RZmXIO43GBgHFgzmqGK3ionvvWu5rtV+fsZqSWLDv2jUd
         2Crjr4RsPv+f7nOZQSLrdN8W1j2XgON3oeLNZBkZS7R4JGxMeZWmf8bBunSxVK0Np7Sk
         gCIgKAssztCi37sGIUXqQhQXJ4Hn3iXw/DO//f6Q20hnAnxLq3SdqqYg3R/Metlom49a
         ax5n2YCLvZspPCeBVn4chD5DT6GQSbU//2fomsWczoeLWsvz/BouP0CZ94jSIEL2412R
         bmgg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4uv+50fpTX82pZnxkxmUq5oY0xICrCElqMZPnqXVgNp5URjSro0LBM8stUd5TUzhI6Sbb8kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBCA2iVu7XNp1LgYpdW7jZsx7cOVpTaxhGV0kCRZc0MOITvNN
	EYTrv6gh1ZnPLYfcr32VrQCdpvsZMUSYM6tpWRbZ8UrovuXj4CH9232443zDvIvd85E=
X-Gm-Gg: AR+sD13ttIjC6KkuT0nOztnYVW9tWCZ7epzoful8ew5lqs2bxpl7OPiz0Eo/fa0zYgu
	WE910ymWT64fuYB0Tccv9r6BwKVmbSfj0/p4CHvTk0uh2EgodhNJ7dWuf3EiJ2BuZm9466cLoY+
	T3NyYLvBEsLA7FnMWoo71hgHMnUjlXVqRiYAxuydi3TwC8oVBQtHXjk1iEJiS6K9I+2iTpmBDWC
	/O75eyviSmEPBOb9m9CDOggc5foJK+/FAZ5Gy3MtKFsp3xQzaVAgg9kwLniR05z6zvztEFQTJYT
	5e/fx1cIBklPNmoBGemfCYvN42hP9J68kakLtuEaeyoRN9WJeLurjg6IGauplZtZ264kd9WY5DU
	sDjbyYYjnbW3dCUbgez5TUDIaIqRpPVi7QkVP+QJ7nnOflfUFJ8aQCh21GVWNMb5PRaPwpUqJ46
	NHEcMLMn1ABRa3u0uggwY0F9tQdysftQfbvnMUFeYuCuZlri/HzEWr
X-Received: by 2002:a05:6a20:7f81:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3c8aafd66bbmr9065958637.18.1785342258755;
        Wed, 29 Jul 2026 09:24:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba92937csm1097115a12.31.2026.07.29.09.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:24:17 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:24:16 -0700
From: Joe Damato <joe@dama.to>
To: Ayananta Paul <ayanantapaul@gmail.com>
Cc: kuba@kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: netlink: fix spelling in tcp_metrics.yaml
Message-ID: <amopMJMlD4uFuM1L@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ayananta Paul <ayanantapaul@gmail.com>, kuba@kernel.org,
	donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260729034147.6970-1-ayanantapaul@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729034147.6970-1-ayanantapaul@gmail.com>

On Wed, Jul 29, 2026 at 09:11:47AM +0530, Ayananta Paul wrote:
> Correct the spelling of "reordering" which was incorrectly
> written as "reodering" on lines 113 and 115.
> 
> Issues identified using `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`
> 
> Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>
> ---
>  Documentation/netlink/specs/tcp_metrics.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
