Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BD4C7555
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603928; cv=none; b=BSIgLOGl40pPkr9WZUZy8o1QfRGNniuwb8PvtCjrPoLc7kUG4KCBVkqVesZTe3IqPUXbYUnSvslU8W6a1g4gFeQD6AJnDMTc3lXq8nJx5SPZ/pzWyXLU1zSR1Wy3c3NP1mlDZ2WZHhXF/wQvCLpPZutXP1bc7IK9L7ApKMGHPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603928; c=relaxed/simple;
	bh=EBWzc4O8yIvlhuQ64n0OVQvegICiNF/2xN6TF6aM+aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LmCZRSwFcizNzqYk++5wJdef5djbvSQZrz9UuWle0sU2T+GWhEw8wo+8GrOF54QgpGBSTk9HsjdPLe43W5KTIXkEts+MYxa4wR5aHvkmNrNHuTr7Lgbjkdrn/s4nwu741S1NiHCrhukjMxZ6Q0vh5SsjmbSi6Cf+yi7FLks5k0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isOzAc/7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyVDZAVl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isOzAc/7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyVDZAVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790603926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBWzc4O8yIvlhuQ64n0OVQvegICiNF/2xN6TF6aM+aI=;
	b=isOzAc/7t2x8jW7T3R0uSg8SKALWIR1VQOjV60DERhmiOks2oeZsrB3r6IzO4YXNb1szvh
	rIxNTiuocVqDXCm7sJFsVLtrRPTG+tScOSNNE4l1zx/rojzi2VC9mLuulh+nzHRojmZQ2p
	A6tFkypyb3gstYrZnIkcndikvvTQkH4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-tXdODK4zNjKE3ENU4Iz6gg-1; Mon, 28 Sep 2026 09:58:43 -0400
X-MC-Unique: tXdODK4zNjKE3ENU4Iz6gg-1
X-Mimecast-MFC-AGG-ID: tXdODK4zNjKE3ENU4Iz6gg_1790603922
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e64b80b94so16694705e9.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790603922; x=1791208722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBWzc4O8yIvlhuQ64n0OVQvegICiNF/2xN6TF6aM+aI=;
        b=WyVDZAVl5rA3lBEzKjUBvdhoQzxHS7x2IexcFOqsqJCicwxoVffVhA5W2RVS4X2JCk
         U4i1n/z9fgP/Cu3So8EUL6DHxaTcXNIb9UWmc2MtCpweKdp41rSg+kZfAeZKuMMDFxeI
         1pHl2Np2UM8PHyqsu3flTdoLfZ6PeU4ateoXWDhWGUFgwVTCTwOqfMqFWNW2s6Kcyvv2
         K9wT3QUqW2w/bDtkLLMSfwrT9DEoq87ykDO1ML97Volx4X2L3ESc81nxAn0nq/+lbESs
         2BdXpjUhJ8Z7Pv5feLsFZ4bx8OTvQ1YEAXD/xxUC2X/rLiFLaFEPtQ0F096Yl0CnFMRv
         VReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603922; x=1791208722;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBWzc4O8yIvlhuQ64n0OVQvegICiNF/2xN6TF6aM+aI=;
        b=SD0Kd8ua+e0CEmLxAtStcFCtUAq5kwgk0Gzzg1hNhr3QE6GJI7M2iPfOKPN6Fyr83E
         M0QITf6nIV12xIhvqcfZ5tJtNSClmpFI5nhRCY3laPnqreR84lcS/Ym+UWB1rrkOpdsB
         PXkcClwNq9uMWM4lm1cQAaZUCvMdbJRmR7mz0jGUDB7PCNIppe+ZhvbAqiU8BS5bDZOI
         3W41sTjuuoyA/uxxzlaDJRfRcMTagLORCF8rBMW1Y6XB/TOMCeSEwvNs8Tn2qUj7wEsh
         h+FGamQwjXSKLVlsyj/VgtsCJvWJ/rI57k9l08NUDJPOAykZYcOT4ZN6MA6AubOR6P+D
         vJVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcDu42Kkq8xjMu7CH3KbLrP6JfGP4/0RZ1GO3eeBlVkCa0iJamJPZ7T49cFJoZ1fqaAqmcihQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mvkPAsPfCyIBpUU3F+Pq956GIZptMduYCgX1T/S6EM90QKbTW+
	TwB2yNFXuNAL0+K2Zm7u53A/tXaU4fmlsu4Ss6v+ILsvQ5dnK1QGWc7JI9CeXcf/kLbbzYHMzGj
	7wZct7VWuvCwITXHQg4akNr1YWd34pitJIF+LB/TDWJC/RP/w0d2XF9saqA==
X-Gm-Gg: AYBFou35xB3VHSHruhQK3zNst5nK6r+/mdcgTrv2bDpAuc4b3c4EHCqQW0vpV6/NHsA
	OjK5vB+RCkdP461bAR6PBQRzvO60COS8izggkocgfaWUQ+hVjuzjsEalmiKWq+5RM7l3iWX7uu5
	eUp5/bM4gljKj9iq0YjIxfWBqXtSsG0D7+D0ypOCHlweT6IFbEwe+SzvtB98oyFHZRX2u69vx/Z
	mgTSqXcURvMoWCtWrAvMK8me77rSXYv2cIHqDffIVAKS70lT02PCHUMfHRhc74jihjErtmhRp0P
	K6aunGvFBhR9PTnJyGKH2ZXNXRmfKaFoGlOR14ZYxErUkjZurYR3pChaVlSrZdgNARmQWBcHvKW
	4WerhkIZfjcJVlfBMFJ+U/G1hVw==
X-Received: by 2002:a05:600c:198a:b0:49f:ce78:356c with SMTP id 5b1f17b1804b1-49fe67023femr226123475e9.29.1790603922253;
        Mon, 28 Sep 2026 06:58:42 -0700 (PDT)
X-Received: by 2002:a05:600c:198a:b0:49f:ce78:356c with SMTP id 5b1f17b1804b1-49fe67023femr226123175e9.29.1790603921835;
        Mon, 28 Sep 2026 06:58:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm27519158f8f.0.2026.09.28.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:58:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 856EDA0FCDD; Mon, 28 Sep 2026 14:40:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kaifeng
 Wang <kaifengw@google.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: Re: [PATCH net v1] net: page_pool: fix use-after-free in
 page_pool_recycle_ring_bulk()
In-Reply-To: <20260925144127.1445667-1-almasrymina@google.com>
References: <20260925144127.1445667-1-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 28 Sep 2026 14:40:22 +0200
Message-ID: <871padlfbd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> With CONFIG_PAGE_POOL_STATS=3Dy, page_pool_recycle_ring_bulk() updates
> the recycle stats after dropping the producer lock. If it just recycled
> the last inflight netmems of a pool being destroyed, page_pool_release()
> can pass its producer-lock barrier and free the pool before
> recycle_stat_add() runs.
>
> Commit fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
> moved this stat update after the unlock. Commit 271683bb2cf32
> ("page_pool: Fix use-after-free in page_pool_recycle_in_ring") later
> added the barrier, but only fixed page_pool_recycle_in_ring(). Move
> the update back under the lock.
>
> Fixes: fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
> Link: https://lore.kernel.org/r/179028939171.2160803.706522228583664641@k=
ernel.org
> Cc: Kaifeng Wang <kaifengw@google.com>
> Cc: Dong Chenchen <dongchenchen2@huawei.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

