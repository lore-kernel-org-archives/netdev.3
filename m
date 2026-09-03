Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C63C3F4E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424232; cv=pass; b=OYQcEmnevtTZIDaLXzxDfPY7LGbW9eYFpNfUdjgAznIxb/6ekuw8x6z/lykLSOhzSFAOdpleuWhFjBhD4Tq0YNvF61wwIK5OPI03IqJfXh2BsiIKLUYCm3axKjMCN4E1uhaVYbm9wT9YawvYxpWwuW5gqAAWhPlOTAy2Tksf3M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424232; c=relaxed/simple;
	bh=hn0WLeOkducLxX5DUD2rMA0WIaKGSnRJ9/g4ZCpDsv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXCQEwWndkQScyCc+T6jmfJoy0eVeKvMK+QwsiJQ2uFKQaOqLwPYmZnW6FDlcpY2zQfoaF3KvhOao0uwddWoQT0mBjpvQ8XTCoUsZf4GhbhqnybqnLsbnIZ8H0lXTHLN7CQNaF55Ciyl5O0XPn3uNwlBjkf9pkIZONe2MLZ9NSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPBuZ7nS; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPBuZ7nS"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66f984b263cso1374713d50.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788424230; cv=none;
        d=google.com; s=arc-20260327;
        b=PjectTo6wqcLhMfFrgBEE8+SP/7IGiZKlCTVBuQ+icaBkazBuGwPsgHnCAo45BxvHE
         LVwxHfkP+zpSwQYjJ9r73OVXFbWzYtCX18yiFcLcinB+iPbVGgFaAW5x73h7NwVtl1pb
         SnAKA3D8yAZosUCFmO8WmZlLXd1c4E7friLtACfFlNItt0z32+c4QHjwbLBvmSO4kk4c
         rdc/95KpyJVkIoQi7WAh+qGHOjPqTiDhdDUAMSIzEBl4vUJtQ1VAZFKKrmHUQpJA/0mm
         tG61Qy+07uIuh8SzdcARR0DewkEWDSmlQYnyXUx6h+1ZtMaiKtLxrzjgTMD8BYw0Ah3J
         Jr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CSM8HgfWcwCLhljkBbqPoU/dLbgOViI/BcAEfVLKIz8=;
        fh=UmX2aVQC08WoHhLGKlk0vFY9Ea57uijKwB7ppt7cbMo=;
        b=UbZxHAWdKUaCjLKJX18lzG10OXBKbNKTynGk1FF1GFILS+LcAk3JRbw18ZulzCYgbX
         aIHEa2QS0gBZ+NoJsT4yuWtf2fGO46P4M61Om/dY/mzaOKSwTeYZOLPHBWYOML7Ld7Jz
         QhcOT85hseS7wTXEOOydGtA1IS6slupu/bhvlei4rhou/NQ8qsb1wPi4Ex0L7j8Bo2tK
         O5qoaJrXm+izY2D9rFsVLRfn7GuWv0LiP7Txp1yKf+J33o9Qk439YpK6AxzXrdvCRrAk
         ahfF00H9kud6aqyGr+nC8v/pwxdnP0dMc+yi/aMle284Pph1O/YMRji1F7T2Qw9FPQDI
         apSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424230; x=1789029030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CSM8HgfWcwCLhljkBbqPoU/dLbgOViI/BcAEfVLKIz8=;
        b=hPBuZ7nSrTTTH3eocMvyniwCQ3WLNcyzHJaV+w3lllwsYaswwb1q0CZSsfiVfYtx/M
         y07wQx62tWJX8MfkJPx2A8QYBsMMeZi0Fvnigtejo6fBFzlGkSQjZ2ULnRQV10MfFySX
         i016BWVNO7WruvVdtVgApfw/m0FnDseXHolacm8oUr1rOGDcAlpTQxFQfION2L8ooWK/
         r4M0NFHxNDg2zqkR3W4KiFJyySt2NGasPQ93iP2EiMsyMpGo256XM/Fz21ifQA9UGH+X
         EoHNPJ+m4Wj9e4P7z5nct4qV8Oa4oVQ1ebf8mzxT9Q5hHNQn3M4W3vTZHX3FeUpDCp9b
         sQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424230; x=1789029030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSM8HgfWcwCLhljkBbqPoU/dLbgOViI/BcAEfVLKIz8=;
        b=avnt7Js5QEC/gbQBvPq9isGR/egrRu7QFeytlsP0tzlmah50Sz7BAlk4c1XANE8JLu
         7fYiSjBCj/VnSyF9PO6hu1pSsJKT592JpT2xgoTNurMZbKPIGOzOqJlsGi8z1zkmxThA
         WNNCAQfITUVVg46KSqaz9dxbrfDtJ363RFXY9YsBIHMk+mgWLuyjia4jJhqU2cpeIJ9Q
         1sRZQ3UiFoQ9HI6pCm2UiigReKnn9yLA7BJq8iigLZFUVRoIbYRDibQy8qZNENkRYxxi
         Z6jFyjEpKpC8ib4FSHl7/xDCWfUSputyjyWwU6ZKsHeQqv4BaxfL0hh5OpUL5+DkcZIV
         G2+g==
X-Forwarded-Encrypted: i=1; AKwUvBwDkJWKzUvUYx3TgwHnOqQtgoNtWmbcsfzmq9zgtGvor66NFIUl6kVqyXSilXxmWfbGJ03+rSY=@vger.kernel.org
X-Gm-Message-State: AFuF++nqSZeT6w88mjUeOvLwOMSDfMG/a01KfjtFTMIJiJTNQvRns9z/
	Vxve1Bv/qqwF3SuJkAwoOi+WBKHbIhYmHsh2efnN9sxKmKExOtMJlIKg7SyEt+zPO5Ee1QehdI1
	u9fVgdWE/vvtekTYWAm1Uu6w8Xn18+uQ=
X-Gm-Gg: AYBFou33Vo7VGpuJ4ziyrXzFgyaaBb4kkMHucc4tkLCIiEIRSbPHZ8HJvODN+QO2Urc
	qWDrQf/kQOAZisSBaMz8taFtOtDJkdD/mYhHFQ7ZZRhH4/wDI00oL6apq384PfN/bJf39iScZyJ
	TvP+bxRoGMHUZz2kVnruNJauuv2arMeFsJ5vD7bMV+Cs5Bb0EJnZBN305nuN+sDguXq4S5yKzKu
	CUOpw5F3u9pw+4hywi+oQRDvqNhghpMpuNUjDDHesYtDuKy+03VCSEGmNWxTHaH7qRxCHiQvObW
	xHHfbmNMyaPc/bGaOapRReYvjHNH7v5c750yIWUNSm7y+XTCCTzYrr9hslkDtH9sgOfQWoGXz6I
	0kaa5Y73YpTm2NV6Hy7BIpNQK5BdHEdQuVGsHpOA+I8k4WbfbHkmxOwK3NUDfkLdF15bAhWezHY
	sa9Stq6+5V
X-Received: by 2002:a53:d9cb:0:b0:66d:28d7:c33b with SMTP id
 956f58d0204a3-66f9bc4229dmr2733116d50.40.1788424224944; Thu, 03 Sep 2026
 01:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903032611.3000029-1-kuba@kernel.org> <20260903032611.3000029-2-kuba@kernel.org>
In-Reply-To: <20260903032611.3000029-2-kuba@kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 3 Sep 2026 10:30:11 +0200
X-Gm-Features: AcwNN1Wo2zAuwllda74AbKGC7jcYYLpR8EiCm1TEFREkOuVb790fpoN74HNjJjw
Message-ID: <CAOiHx==U0escjaYZrMqJYaEbnYPm=eqfiNq+RbUjL3TN=KWNuA@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net: dsa: bcm_sf2: bound the CFP rule dump by the
 caller's buffer size
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> bcm_sf2_cfp_rule_get_all() walks the whole cfp.unique bitmap into
> rule_locs[] without consulting nfc->rule_cnt, which is how many entries
> the caller had room for.  ETHTOOL_GRXCLSRLALL requires no CAP_NET_ADMIN
> and the ioctl sizes the buffer from the rule_cnt userspace passes in, so
> once an admin has installed CFP rules any user can ask for fewer slots
> than there are rules and run off the end of the allocation.  A rule_cnt
> of 0 leaves the buffer pointer NULL and the walk dereferences it.
>
> Fixes: 7318166cacad ("net: dsa: bcm_sf2: Add support for ethtool::rxnfc")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: florian.fainelli@broadcom.com
> CC: jonas.gorski@gmail.com
> CC: andrew@lunn.ch
> CC: olteanv@gmail.com

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

Best regards,
Jonas
