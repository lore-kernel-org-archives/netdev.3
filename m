Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE294908B4
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208578; cv=none; b=FMve47/NMPeDZl/HyfdWpcTrINlFyPzUu7XUgQSqprQY0cMy2orf+7OdpMLHkAyqZUKEEaSzR1I7bRcW/PGtMR1EElVHhQ/8FD/R8XRtKD0EIUHALXNTUkey8ITRuCzDzMjGLfsNfh0UWuS2zLH/SKwxIMQyhrfcvjeLciY3pQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208578; c=relaxed/simple;
	bh=JWfho7a4h/v5oQQXy2nREW5kZhZQo+AC4rzMKRV9ezE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjuW4HMYmM9iW0UMv3T+z5kRn76m90WKeZNbmgM/cuu8wY8hfrl1+n7GWV6Q/ECvplCgpjn5slBuifEGpbo9ttFVQ5lJ2jfoFTppuz/lkf08SjpvfMPA0fw73H2Qk3hTEj/fDF3WAIbZUmyjRGAhChsiLhx2v9QYMmy0q1svFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUvAKb9q; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUvAKb9q"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso930807a91.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791208574; x=1791813374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcYeOPC3IkRIRj437rPzllUvmUYP5WaI0NjLayKQU9w=;
        b=bUvAKb9qWJf3x0ZiWWua3QhGMwTLzAefTM+Myzxv3RFPO/TiAhdPnC1YMQlO9RJS7z
         9Fh2ABAhdio11y6ghLkRuCelEngki3puIC9b6mFWe/ynjjo+0JK2QqXppYCgm4GBK52r
         tFmioN1uis37WuJ+J2CRDaUQOaKmQgexvrWxeTgp5EXY5GdBi2fZ0wrkMg7pi75s21Ep
         B2r58TVpTIVaC3b4j2OzBShg5W1N/dyaCfN09l8cnR5QkVlqBwzbKBY6atvY+PjoKmdP
         Btz3uEvKcQYN1kqtx6u1Vr7YgYzq51k1Yh7cZjTm36RKUcQwl8+Z9N3ynrbNtSa10PMp
         PRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208574; x=1791813374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcYeOPC3IkRIRj437rPzllUvmUYP5WaI0NjLayKQU9w=;
        b=pdjTK9n63d84aisadiB42vMsVTwZHjtZi8MKQlBVY74MDlEW6qDz/NuNq0SMmj9gBv
         Abv1IfOPQc5zZobSvNjyj8I3LIDsx5SannNlEn7p6/uAXjKoV2dTmb5J4tr/C5Jn15fV
         eE5+eu3fgdU78z2DA+7usbE93bdfl4wT3xgIt/eFrlxHMSFNqarlUZU4w6/JjcvGWctk
         CT7f21GZ0isF89NHGmgzW301p9NqY/LheMoL/qTWAAVmeqp8xaNM3BhTkZ0W6TT31gh1
         ZFvCY194t/5LsvSLlCbsvWNutldqaFoWmZxIBFzL8Gd2kSSnBg+hWgMAryEPqg9D3DQc
         PQjw==
X-Gm-Message-State: AFq9FYLReq/MOCDWvBa0gKXDJMIPboTd7gkjSPPwJJRRTfrScuExgB+6
	i1giPp7iNIJw3dUeV/qglnCie63u48EfuJ2Ynl9RYSbQyNY6tTFfQKSc
X-Gm-Gg: AYBFou3UOMrXvlMdP7mKeRogWhBRRrYkRVcc0/2M9hxzR80wssxWXeYrBHTqhFDAUbs
	Dm7jOPurUHfqu8qZtTQAXZZoQ71Zj5VJ7B6sMYpm7Kq5XeW4P0qQkMjiGK1h+mue6Px+382P6g5
	/RDZ2YyFmKzocdDnhtVKIZ5DPkpqD6gl2IBNII9mb/Bz0tXtuDSjv/sjtYYl4QCpg4ur188Kxjm
	yA4A9Gy5FhjSNIjuCltpHsNDfF+elS8L67vr22QKMXsom4WKaoMUjAuRHUHpwaCJNtFBJ0uthKI
	cwOKOxcPgPYagaDYIPSZpHkNKZYrNO7HruM2ASKhKT7fz9uDOiHIaOIo5+gqUUB4yYqvkrUyyYy
	BvVrDMPEjobqUZknZq8uG5v25EKTPkp5opoKeRJoW2qV4cMgNQikpxDdX1OfLN26YrN82oddDab
	pV5P+3CtxD6ExruPte62h3ikHkYMUpCoSyjyL84R0A7tGVbZx2lnw1jn1mOOdh+io2JB7xNeNha
	mX6fdH6hlDF5rEK7+CPJfmB8Xba
X-Received: by 2002:a17:902:da4b:b0:2dd:c100:7cb8 with SMTP id d9443c01a7336-2e49b6d0041mr92256255ad.52.1791208573773;
        Mon, 05 Oct 2026 06:56:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a55b65a7sm7960905ad.12.2026.10.05.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:56:13 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:56:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <asOseirrkC5YC6qf@v4bel>
References: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>

On Mon, Oct 05, 2026 at 03:50:02PM +0200, Sabrina Dubroca wrote:
> The comment above strp_done() claims that if strp is stopped,
> strp_recv will no longer be called. That's only true if the caller has
> a mechanism (eg locking) to guarantee that strp_recv() calls that
> started before strp_stop() have completed by the time we call
> strp_done().
> 
> This adds a dummy lock_sock/release_sock pair to guarantee that any
> in-flight strp_recv() (which runs under either bh_lock_sock or
> lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> has completed.
> 
> Only espintcp can be affected by this race condition, but this patch
> makes sure no future user of strp can have the bug.
> 
> This could crash on strp->sk ("general mode" of strp), but this mode
> has been here for 9 years and has never been used. It'll be gone soon,
> no point worrying about it.
> 
> Switch the stopped/paused/etc bits to u8's to avoid races between
> strp_stop() and strp_pause/unpause().
> 
> A reproducer has been published and turns the possible UAF into an
> exploit [1].

:(

> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/all/aZLn2Faeg1FB7XOf@v4bel/
> Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
> Link: https://github.com/m0x41nos/RustyTux [1]
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Hyunwoo Kim <imv4bel@gmail.com>
