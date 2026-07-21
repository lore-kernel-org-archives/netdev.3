Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A71FC10C
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638934; cv=none; b=aeqGlZbACv7xJyqczu16gmKqjtfWN1vJTYXyg0nlL70YzP+GYOM64xbo4dSpsTvjRDuPPa8ORgqrUrSlVI9IkhsMHO/7mEtKGpj0RcS6Oac7Z3INzjTD6ShfT4OAZ8Kkpt2ZqORp7reAGp0BOXLYRrqBI4XdIysKBkw/FzcWkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638934; c=relaxed/simple;
	bh=+DCrHFLSoW0VYsNZrSU6mj0mZzAaljdKnrfDGbIg4pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVWBfXGUoMZ8GVgxpQZPL3baj1qfPSieiZ4/x1W9wjKF7csp8TZR45hyxMqtkDTdlmuZtTtcwQtSHzd41/YHud/r0SNhSuj8MN/HUVIkJcZ97f65CzXhiQQiFKNZdxs0lDegNDZpD578WCjJbsIoOdeSNcZgT9T7ajfV1bXYzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=x3SnENyN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="x3SnENyN"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso7201146a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784638931; x=1785243731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xj5Jk9L5vRk00naBBfj1xpmzt1sYizYOkTxM4/R0a/0=;
        b=x3SnENyNx2zWVsQYe0z+GEOyYXMxJ/pWAohEkrBkyQ61dQMsTUzr4P/d2inciBG7XJ
         ij+C/7DAmF++qHLvBUk3c2mi4aNR8RbbNCc+ONZOzoNn/wGnJawz7g3n043vhSPoZ6Op
         68gAbJZmyUnXrNSQacLILquqfBw1xZsYRgHS1gjNe3CvtPCuSJ8FnpiL1V9AGv3FAZIg
         zYVfkHiixuV7j18YY0QKUVS7t9yoqzfhLb6FH9f9G/7rFJYE2dlsOJXHEACuy9NXpW8a
         lYNXRuc36H2v+AP4YVor4tnFuDN/lgWPy4plpKO6FdZDVTy8oU3zUe8PkfGGfoz/Vve3
         HzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638931; x=1785243731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xj5Jk9L5vRk00naBBfj1xpmzt1sYizYOkTxM4/R0a/0=;
        b=n0vSnCb56rcAdCactP5lDIpTQlVnkvapm6/W7DPGntVBAwSBdFMSQiRYiwLDQJ3iG7
         us2kYxn4AcA9N68dRea9IpFr1CimeJfJu6sKmfnWczL28qyHurWZLI+FwjYhiorEWG9B
         uvMogEQH+qZH3aMR+1TUzzxgOta2cjI/s61qiRwZCm+U4aLLc81dqx0V+xSKU3QGv06I
         KeyDP2fVKcDOREDs2t3znngmCR4hPdp34dAGCM+ovxGIb/6INqljOfXXlc0h+K8ll/w2
         osXTMQ7Q2wHlD5nrR7buHKhzagiR+VXuQVbODY9x1QKJshJBy9wRl3n4uD3I8MzjrAWK
         fHVw==
X-Forwarded-Encrypted: i=1; AHgh+RpxE11mhBUSOo3eIjNyMUSJ3QbFN+qfXU9Y4AVuHQJSig9Ju/qjcyWcD0G/KYiFWnUN93X8Ehk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZ7Us+ymev/aCCTvYAi8VJ3qtKfLo07/Wns4M5A3TWKlFk40E
	R3Ee/3hPhZ4v+gFmGhr70/qTC4Nioz1ooYT3s3i+smcvHSAfj6DBb/MBJeFGP+gk+Sw=
X-Gm-Gg: AR+sD138q5gdvXYKpnzzDnQRUKkl/M2L24ZUIXg5EqsQolKzf2ksCEQyfTexxEFPTSt
	NbKEL9RFBQM0dhiOl0yuxzp5NTrckUpMmODAU+CdjV7vyS3cs6LiQq1tHb7GD5NrnFF1tqEgbaA
	PqcSaX134zVtmjKug0zTPzA+ZxrjTPF2FK9F2mTgw/uy74wCUVjDrzQUbHLuXjvSwM9yQOzIgFK
	810zo2cDzolnCnKDyajZ6b8BRdgvT/5Wp9Zr4/YfIKmlCaOcslbLMAVqC1FY5EU9Qduncl2nQGe
	VXo23c+QAf69aTINV8wTPdMZRbN2Q7JjSiY2x0IhxwMbsBgmvVA5fwUMN6BG95tV1aE8yjCTXOm
	3so7z+bcLzkF8UnuFzPKJV4o7DI6xaOtaJM2YXbsnvBvr58lRS39cZnI1sT/yQkzfdbg4try1B9
	k=
X-Received: by 2002:a17:907:9625:b0:c15:dd1f:f2d with SMTP id a640c23a62f3a-c1692413dd8mr998381866b.25.1784638930437;
        Tue, 21 Jul 2026 06:02:10 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:26c8::3dd:26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c185c59624dsm581676466b.62.2026.07.21.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:02:09 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:02:07 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf] veth: convert frag_list skbs before running XDP
Message-ID: <al9tl_YzWmPXGweT@matt-Precision-5490>
References: <20260716100605.939654-1-matt@readmodwrite.com>
 <87jyquj5wm.fsf@toke.dk>
 <al3oXdjTYM_PziJp@matt-Precision-5490>
 <al9Q8yPOfQIVxvp1@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9Q8yPOfQIVxvp1@boxer>

On Tue, Jul 21, 2026 at 12:58:59PM +0200, Maciej Fijalkowski wrote:
> 
> Hi all,
> 
> I had an RFC that made veth to reuse generic XDP code path [0]. Jakub
> commented we could have a common pp cow check on both sides. My plan is to
> revive this work as this still causes page_pool issues when AF_XDP is used
> on veth.
> 
> [0]: https://lore.kernel.org/bpf/20260509084858.773921-1-maciej.fijalkowski@intel.com/

That sounds great. I'd be happy to test out the next version.

Thanks,
Matt
