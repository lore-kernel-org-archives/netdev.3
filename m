Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9F36A367
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134621; cv=pass; b=csn/C9OpdQ61gfXqLyB5LJJCTD3ZWxYuzQfKt82CTB3761/BzjKXBm0310piubjRZl36MAJMpUmlsOru/W/xKPY/SfVZX/VxnftRw/vlHy65kbAaziW6yTpkOfGNNTWWdr/Xp1KNQWZYDKeMpXDY8vHjSekr80/t9gwJnqmsKQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134621; c=relaxed/simple;
	bh=/qxBJcYhlELi+GidH3qhbk7cum0tkPI9mCj4Z/HQ8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stAxUe06ElBcqIQ0rypKqAAqNJ74BKNpw52gI18pheuvxbph8Ab8Gxe53vfOvdfPcNiVF4ztmLiIIy/Q0loNx5nMUm1u9IjQHHMXirEnWzmozKym7JlO9ghPWB9nL7dkxJ/wesJ9fF6OCbeARe7cK4rtbb7LEc4oWcez2ZpZx4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8gnLMZG; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8gnLMZG"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a49a10ee5aso3108581fa.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134618; cv=none;
        d=google.com; s=arc-20260327;
        b=h3+LUw9y17M+L5auF8fPkf7P00JKeoAbZoSUugqhw1+s8cXTsMB6/AukQDXwkdejEM
         BJS58MdHw97Bc3mXcnzzp6yMOeWs4f4YVQrKqea46FUpfhDKa+FZeaj6c8SEOuhRIMsp
         dK+I21pQ9vysFSS3on8WZyONoxQSz1+ATNyxuBcN9ybDpFeRIymIPcYoJNWwt2iFgMVL
         VnMm/C/J/heyGxeE85OtqE+i6DVkR6Ydf9cmDoDwejfRE0EmhrzhuDiKO9XO4JPEsvcg
         QdpVSoHWAKGMKhTDlr3xTluDP+YCJtTWDorNAeoO6u81cV8TYDW7TeP0J5Z9TXOOLf28
         J7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KKLo74+Yco7BdhiMxFzPPDsZ4m2F2BSHmO+5yWtfCh0=;
        fh=FcDb6IBdpEtq+nrTnWggnISG3zc3yHYFPmomgI/8yxs=;
        b=ADkUb7NZL/nNX8ANZjspNF0eNWvjTrL7NH84D7gz+U5dkvVFmJGIHcz5pZCX3UhcqK
         xP9HtkE2fPzyT1hhN+gzqb9frxlqBzIvmV+mlKZAYKouhbE8oaDNkiv10xaOzMYrDi8H
         XjResESP/0l5mM+CB2+puA3OPN5rC+kFbIcVLuL24RoB2HiU00O3RVcjyZV8rNZzOU+b
         m1p05Xvqh2bYA1GcnzjHak9+dPiByc6n4g3M/9TmTwNg5is1uPUC67GbVtz6M1gbToi4
         FcXR+mwV23tcQcPYnXChFZU/Nix1Xt8ZsCdR4f/TjN/eYpSUQmHvQGtD3mJJjHpkYWLo
         2e3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134618; x=1790739418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KKLo74+Yco7BdhiMxFzPPDsZ4m2F2BSHmO+5yWtfCh0=;
        b=J8gnLMZGJSzKKxfrP0xLJQh1ke+4QeZ+Bi94U9xYJRnFywKkssyoZi6LgEfSsuLrUt
         bSuRJhmsSYR5kMiTGxrihAZMNALUqhgDIGpiecEwcfZtzLLTvEq+wvCwiUjsmwRMmAS+
         PPoDb0XVuQGrVKHeMTyLJtsifoauw7drtuijA47NsCfOZY+pL0/02g0eA1V6dl8O+r2q
         nLm79EQPnuaCeDEIC3MRnF6oJqfZ8uDQWsakrUlYE9ZRQ2K2nX79V6RKoObBtsA5+dju
         b1e8ePaL6/G0UBsxXWKA8IhcQ2OmQ8F2IZvLj/CvBm26x6xrGPXAkOvKrKEZ0L4gdXt3
         me9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134618; x=1790739418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKLo74+Yco7BdhiMxFzPPDsZ4m2F2BSHmO+5yWtfCh0=;
        b=d1vCXXIpiJXe0ybRYZC2w15eXZUZQyIAthjUaXg+Dt+sf1qunoUsY2qeNl0trTDvL3
         txoB8FpJw6iL9rH1bKk0HzrrQbBWYyJItI3bvHxEk6IPEslvPYPAL+PYW+HYhbfND8Sv
         8UDyc2De/PsrNCWjZfe74m5ecuHCNwC0MPGgbd7Vpo2LOxgQQ8otU0hG1d20NW3oeIfj
         LIZjkUUjIp17uWQs7fMYL0ACCZa2uB1lBCUj5siRiu4c43mQYu8jfiB1Ki0gF1rRmO6k
         SqdtLWvCSZKSZOefI7Wek/Ez64zXXhJ46XHFwtwEzI5VxPPWDZvF/39bCR8cSUbgHkLw
         zaaw==
X-Forwarded-Encrypted: i=1; AKwUvBxLnnTuWo/SphfAF7BaKdI10iVgrjRohVPVQikzYNE3aZtqgbgsNVqE0hH5uLm7qvYDuESzM+0=@vger.kernel.org
X-Gm-Message-State: AFuF++k7DHhhcQYa5eHw+Z1dWlNdalP1u9yfN/618j9B8XO+Pj0eRGFf
	0Hj6iE/mNdwBBrX77gc4FwI/SLvCTem3Z+Px6R9raQOyObFpx4XWsCVj9zl6+20hGNtAJdBHb4f
	WUY7mMTjY4r1o5FLxd9Imf5ozrQ2OJqU=
X-Gm-Gg: AYBFou1mgDlYVUIBKnBzi3WZHLEl+Gas8KznHuQ2ReBgYZdd4xaYxS0uZRUqEMjHd3l
	RM1P9HbIY54PRARe4ezvF4oXV8w5RZxOrqhqswH9sY+7RdRFQqBeyrOgbm8KlQcd9RLhK/7UlZe
	CP4LqSnM3HT38RlKO2LTIlcu7FOqj2p1iAyvMjM9BNT7q1dxVjqfel4VWPo1QwxCIHGgBgUGBzA
	4paY/sZBeYfa1aXwQQkRQlpqcLu/YEnqR+K1qxlfNMBO2c9wtxWu/s0GmKQ8HZmX92erl06gqQ/
	Em0h1lXEKaC2RoF5EVVtl3JbKo29nSPy3YFrbaxnc05me/7aqZaBOKUYwRzYZFCNNq51aj51PtW
	X2EqcFDQynwzVQnAwQCiXkSfM5HAz/xsYZLEdhy9hn7SEnQ==
X-Received: by 2002:a2e:a551:0:b0:3a6:1694:821c with SMTP id
 38308e7fff4ca-3a63058afafmr2505641fa.10.1790134617663; Tue, 22 Sep 2026
 20:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921235951.3214-3-sigefriedhyy@gmail.com> <179012275019.2160803.2891956767256297440@kernel.org>
In-Reply-To: <179012275019.2160803.2891956767256297440@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Wed, 23 Sep 2026 12:36:45 +0900
X-Gm-Features: AclHuK-zDvybSnCH8-kv7q6WcLVB5cerfLjhFVuKxLvzAY4a2aHZ-j22ZbzjjFM
Message-ID: <CA+7S2vLXOO7+KJUnBFK9++TxKBtHgVdBtEaqx6sQpuqS5ZYsQw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/4] net: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> - [Medium] dev_mc_dump()/dev_mc_dump_dev() resume a paused dump with a
>   bare positional index into dev->mc (ctx->addr_idx / *s_addr_idx) and=E2=
=80=A6

Same point Nicolas raised. I will fix it in patchset v7.

> - [Low] uAPI vs netlink YAML spec out of sync: the patch adds
>   IFA_F_GLOBAL (0x1000), emits IFA_FLAGS/IFA_TARGET_NETNSID in=E2=80=A6

The spec update is the next patch of the series.
