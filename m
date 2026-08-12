Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94038E8C9
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559866; cv=none; b=Y98c16lKrZMiYKVND+oA96VkGmFWduMXFVfzOE4oKEIJeUBeJllTwAL3mLOkWdN92ayFkFGj+3U2DS40JfeS76z/St/V9QLzASOhYQIVwxtpLTozqgEj5AMB7/xHecKrvqG9JYwA/nDDMIpS5vheezsQq0jbQDxZZcHPRcQAdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559866; c=relaxed/simple;
	bh=eiB43M6RV0ZtwdWJtOZdf3pFwoJ9mOlgfQ1s5tJsXO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkCyaVyXZoodcs3VQTL9MN/7LURGJLWo69SG5RPQeCPpMq+CVpVC9CdBlcnOeDlH+RdgIBGuMkiKJioSrj34LMuikuijO2z+hSkQei2dF3JK8C8ut59hWkyeRMHv9AhuGeaYGmOe4y3JlnuAbR+ZrhwyE1XkUcAorC7Mbnhx0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=w53jgDsp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="w53jgDsp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1742097a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1786559864; x=1787164664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jJc3qveMT97K6NIgVFVS4ssSY1dc+qhfAcx7owlBoP4=;
        b=w53jgDspVUQdvC6Rou9fIyHz1vzGyEnO7yEk8IbiVk8+AwXZgLlV+90jP8OoyOtJ97
         qnTYzNS5GRiPNGjsaZaQzZwx/7xi0MIk8q86vH0Z/acZKE6NoxpW/3hOIt2VmAHdiVUE
         T7owKToqoAULDTP3NV5BNBf0GeHGE1MBj7BMVfftwiup6+GK6zanjqXH678NxJN02r9T
         5iUpUTkwCKiARr7LAF+bVdpFzMBhyWltjD2Io+6LYeLhBQCA4jiAEFFY+6qhvmv8bKqw
         nbHIG0YyfzZoYmqwunhISShhpqXO3TZkmY3/8Rv2dtPggG4HZ5TM/VW7OxXSgDPwW2vt
         T2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786559864; x=1787164664;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jJc3qveMT97K6NIgVFVS4ssSY1dc+qhfAcx7owlBoP4=;
        b=l9HhDkAneZGZG5bqGh5XYBnK5S33z79wOjOEGJAp60Dp7jS61Vf8di9s4GIimfehOv
         lJW/eGt+/fl9tRq8+LupDfJZXJaXHz6q7nAL4Dpugwwgs7D/6qg3X4+jaG7jQbTBdDsl
         hlAR/ccR7M7b5FVo46Q+2d0y8KOmCmxpu5ssTlFJpwC8diGrnjtsFw7sQhp3gpw5j1An
         EwOKSQX7A7LxO8PP193ay8TCxFYfLqvW6O4HjIhsSu+CdOYvie0CGZ5geGv7cbgBpPZ0
         eYW9bLH0fihC8ZtzDFiIiAQ7DXo+tdpXXbjBIkX/P8t+SO9I0ev6yFEQdzF6LlY8g4Ys
         tuWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1pF1c/MYRJATdg85CSGb9oX3oTFHZbR7PUDQtQaa4YGAee1ostG/dy7WgpoOInTcd8LajNWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vmihZ2HTkIeZv+hcr2AczttfVpovFCXZcG+PEmQ/S3rFmJdG
	Er9PMyfzjS2eGYDKJ56B8TKFyBKmFfMuh+3VDZ24v/ksaoHQeK7MHJV36+/3iZydG2I=
X-Gm-Gg: AR+sD12EcnkhXJL1vA2V4dqxC6LJwrmj/WMs14bkf2CeOiLkINNp9dOs+yL9rsCKVUm
	ye5rn+yalT58xHBr6L01UQfWZLMwrzbLyb4vxtAJpllUsiX+dlzwobSprS38VHm9D5qsyV/GLcF
	b70nw0+1XKH8YZMngNPJKbIB5Jvv1PCI9Kvj/AgK6CaR7YrhUmwK2SQzUz/mv1YYQvVg/lS+Zcu
	ismFjPLH22tsExCwpYKtGnXFZwOJUT5/V4r41DXvN1pjIoYsLFnkiz/Oa1ddQBjHZrb1Dp66Oue
	ss/mbMLzvMpWF8vlrrdhPm6powkZUeVkBBNEVE7bEOm1wHE5Xe3Vhhc4z3vla5FF6sa1/qs67Tg
	mq2vc7LMYu4cJbcWbH8qzRa0qR6rlwjfYX3qhijtJTNHhFKo4/gBEpwckYkBqSMpHM/OFb5JTHE
	iBYUauMoHdpyLK5QvNjuSJL6hhAYwoGNyxXQWVpI4YIA==
X-Received: by 2002:a17:90b:33c6:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-3931e298274mr193559a91.14.1786559864270;
        Wed, 12 Aug 2026 11:37:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931db13c3bsm67114a91.3.2026.08.12.11.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:37:43 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:37:42 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] ethtool: tsconfig: reject zero-valued tx_type
 and rx_filter bitsets
Message-ID: <any9dja3ZPSIJ/7H@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
	vadim.fedorenko@linux.dev
References: <20260812162230.1837788-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812162230.1837788-1-kuba@kernel.org>

On Wed, Aug 12, 2026 at 09:22:30AM -0700, Jakub Kicinski wrote:
> The ffs()/fls() guard in ethnl_set_tsconfig() was meant to enforce
> that the user selects exactly one tx_type (and one rx_filter)
> at a time (off / none are explicit types with non-zero values).
> However, both ffs(0) and fls(0) return 0, so the guard passes
> a zero-valued bitset through.
> 
> The subsequent ffs(req_tx_type) - 1 would produce -1, if user selected
> no bit. net_hwtstamp_validate() catches the invalid -1 downstream,
> but returns a generic error (-ERANGE) without telling the user
> what went wrong. Return -EINVAL + extack instead.
> 
> Replace the ffs()/fls() comparison with a hweight32() == 1 check.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: vadim.fedorenko@linux.dev
> ---
>  net/ethtool/tsconfig.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
