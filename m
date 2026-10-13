Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2963F5BFD
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791854737; cv=pass; b=cdrzL7UUXxMn02YDFbKWVW3bXaoXboYnSQQ/+eRXonh3//lqtug+sRF8RhMpCmCnC6/6QbWDh3jVvly3oU4cZ/JplEoBKpeDVy0KD8B+Ef/9iORbFIHM8VV8mNNSEP6GLtqpmW8zjQ4urWreTWD3vsOaenBPG6ZcltonoD7TxPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791854737; c=relaxed/simple;
	bh=SHeBaCwVAStHftW+aJiHVT19v4gRcPyL5AAFSFX0GQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAr6vG6tO6yGzjoXJqMvTkaAlt2uIsm8H400R8MH8uxfrSGxWHvMnUfJ6pJo5INxavkkiVEhAjloIOSRSokz5n5DIRg7MPqmbeW2IbLyOgj6h1bE2Ib5wf9iO0EkgZce7r1iPfcuOUwS2qqEYh9AiCygspMAy84N0QamblUSHmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5jP0yDf; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5jP0yDf"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1260927eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791854735; cv=none;
        d=google.com; s=arc-20260327;
        b=F9ejzbpxZZ+9NaTjD+iwdat7MCODmnJuHSGdoGiicKj/Q6HQ20GAoX53WfR2rXAlqb
         vsZxtdMVugfwLsQSgP0MJD3bmD91bYHCjAebnwqeFN2GjZEMoNMy17qA2BWAvEmndVJF
         qIzpVZbZ1oEvxRqWjz8hdYrLJnrkWiudupz74MeC1ZIQAXwAIb9vv8cZhs/BEkDcbchd
         F6WH5aKV10avXN7Bl7s1xzDyciAtBZZp4IJKcpJpE6OLtb12cNrNE0uNnD8Ywy/LWHsd
         HtJBBPtvi32zMK/qTNUOvivv6iOQZwlyo8qGTJrk8Fe49WLvkxqTbvgm7RAo6jhCUh5N
         BVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHeBaCwVAStHftW+aJiHVT19v4gRcPyL5AAFSFX0GQQ=;
        fh=U/kgE+e2ZvRlfMImw5KjeH3I6PAHlcoo+LzGUgDY6aE=;
        b=W16DyoM0IRXOw+evl+RxcEPoRjxXxN8Oo4Ev2ywOxHF4Fb1MWqP8KWxurVjx8fvtxh
         8dzPTMK4nUE7ldWi+/TI5pHpTGLOoG9l/YCYbnlFg1QCyQgbybtsa6ARArgEw91+Y4lm
         TgTcMoOXnzvwFDHVvV6ePAs2JmfxF/i9Ivf37OJlMCiRUSd3UhQCj9IyIGOlHcwmUxAm
         MLn32XD4woDV0ChtDu7aobfVos4Qi1zCe4kTyO8MYTqpIgBQM9QJGdxjpF0deJe7xi5f
         5oOYbEHN+DR+hyVxllMiJrDXSGH3Po3zMro4IEhENNySuhjPtXV9iKIqI2E7S7IorsBg
         r2uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791854735; x=1792459535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHeBaCwVAStHftW+aJiHVT19v4gRcPyL5AAFSFX0GQQ=;
        b=v5jP0yDfztdfNukd8CETA7sQvy691dGcfi//fUxjqBf7bKifWEH0+p4MIcB3SuQYQP
         Quaa+l1Jmu4Shh1Js9MxcQxULCGiMSxpzze+5m0O/t1eaQxKgjv3Ppg6kOvlKzcK3yy4
         X1txcbBUNOnOZfMKHDV5bXMPqsN+N9AOGKZZBFRJAxs8ca/2H8kxHNmoyBj28ZbG17Lc
         Zs2+5jj+fgSUxl1wUxrIjLTiDKQYttysYZJodjI9Y+DcuxQ7M+J1twbvUdTHdUXpoZdm
         I1+rj6/P2kPGwKSc1ePrkO5Wo44hRXKqwMk5P+SiauWi5G5ybKwXjEmiJx5OTOcRDMFd
         yRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791854735; x=1792459535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHeBaCwVAStHftW+aJiHVT19v4gRcPyL5AAFSFX0GQQ=;
        b=bxZ80i+/uDHdl++K956ubLGWSEK7J56VWB0hhjst5UgFOXfzi5SBOvh0U3fk3wLCL7
         QCY5ZfGaKZjcStuwzd/QvHY0VW/lJoX5Ol18Su/2MGBwZzeCkNaXoirtjza9cHJbfxCS
         Fk7IJsTBKQn5g6FDo9B9+1VihpE3w89vW9QE4Le8QMvrMgw6l+/1G9f4mCMKxy9VBAms
         FGX80g3cxSrsgZoaCRLp8YSreDJaMlrP3+UysVLI0wqbraTpjcj/gRoqCGowqNW0uj1f
         jb6HlNmvmc1c0SFGFim2xDyGQ2IzdUL86MJ7yWIGv1IoLzmH7pRfsMug8bs5JolYONTC
         dLVw==
X-Forwarded-Encrypted: i=1; AKwUvBwZNC1k4OFL9+UfLC0eYQWwAPVqE11nnVesFOjBX7MoGT4Uuf9rxHNsxwf0V09jT/uH5dhBjOA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJijHiKePagT5EBhq10dKhr46N+OPunB3Pdi5V4znEl8ZkI9ES
	RRjt+zJxUvglbA/zOL06mM064cC1r7j4sVBzbuZnCf5zJBSlAyp1WiZNVq4e4HtebzFcppRrQpa
	lSPfBgH9t+6LazexWiNMIqJ8Yu79GT8+UH+tIZmml
X-Gm-Gg: AYBFou2YZgOIeRytrkynnIftaGOJ4t+kSViqIKmKtfLPyQpGRaJ9dEJWaeDL1t3FY6Q
	xypMZ2uc3oEZae10BjbltKJksr+9b03piPwv1NPsW7oCQVoemS+QvaCqVit6XkqeKHIoFR7FHh7
	Voo2/5QLe3fj7HhatQ29QVo6hq1PK7bMU9Rxr2zpmcDEVMlmEHfK+EW2tOuMMkP3LRey5Jot+Sy
	8Zk2WbHUd+qAxOyPldvEE4XzxYTWCjSRPAuXcqKVmelhtydpmLXpakw19xd/pSsOCONzk7kr+IK
	ylxqM9+zsFF9grMm+iSNfKaGi1ER/3vHrBvgSz3r/keKm/NVyjnApZ9l5o7nRU23O7vwNgPVds5
	i7lAoxR5J6iBKHk0D6W0NfRHGCNFj+S3+UwLsL0fe4RumaJWkiAjS79sKpD2FEwlYjXB6HMPgSC
	DuIkMf03+3dAdBCOng8ujCsHXl
X-Received: by 2002:a05:7022:7e07:b0:15f:6789:2c2a with SMTP id
 a92af1059eb24-16a645d22eamr22042751c88.36.1791854734287; Mon, 12 Oct 2026
 18:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012101029.927296-1-edumazet@kernel.org> <20261012101029.927296-3-edumazet@kernel.org>
In-Reply-To: <20261012101029.927296-3-edumazet@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 18:25:23 -0700
X-Gm-Features: AclHuK8XocfABkl3uIKia_ekQvW5oEb1BgdvBc-A-6MnBhnKHsj5O9gqjbpFoNU
Message-ID: <CAAVpQUCLCzPCR-unHjYvWPmhd0RkY9mbvvXoHSQzx2wxL+tdQQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 2/2] tcp: use the echoed source route in cookie_v4_check()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, 
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 3:10=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> When the ACK carries a source route option, cookie_v4_check() routes
> the new socket to opt->faddr, where opt points to the options of the
> received packet.
>
> ip_options_compile() only fills faddr for options given by
> setsockopt() (when called without an skb), so on receive faddr is 0
> and the lookup is done for daddr 0, which gives a local route.
>
> Use the options echoed by tcp_v4_save_options() instead, as
> inet_csk_route_req() and inet_csk_route_child_sock() do with
> ireq->ireq_opt. Read them after security_inet_conn_request(),
> since CIPSO can replace ireq->ireq_opt there.
>
> The route now goes to the first hop of the source route, so also
> refuse a strict source route through a gateway, as
> inet_csk_route_req() does.
>
> Found by sashiko while reviewing the sk_mc_loop() fix.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
