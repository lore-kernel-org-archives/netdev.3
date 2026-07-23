Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452D495518
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809583; cv=pass; b=euVD+UG93uD7I4RnuFh6AnzUAFgB3Qx8b9R/GgCsMlpFioHOfkKPX2ywhyqGdZ6jC/RnL7Pc1OBETMRA5yYrn4MrtlimHT5nAYBU8rW3ErpV1KBcnq1K3EhxdI4135xtZGqXbbI2NR2Wy0+iUSN0MsDmTPBcAp+fR4mMNXQX89g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809583; c=relaxed/simple;
	bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdrUtDx9H7tFmUQhyy27g8Ri+Q05cXNpzDq6P5u2Klu0IzAA24oXA9FRUqE0xSccggNjRycZNi9e/buophAL/qbZ45d1CbfiZs3EZB3tg7l0zUPtvBMG8VESjjYGOx5nyjb33ytKATAWEj7Le0Ix86ahnjTM+5yKaBqLEozRuW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCtYTs4d; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCtYTs4d"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ec29f1d07so4477077b3.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 05:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784809580; cv=none;
        d=google.com; s=arc-20260327;
        b=tCPq2+KlgSuFUvYOsMLRV3DzFrXD2DClD+HF6AUM+wlKRU0qvdPmIXY7oM+5BR/EoG
         //V5iPT3uWd3F24O8vWGlz2Vk1OPAa3FChkJX5sz4O8Vo6ftPGRpPN56u5LByGa0kcaq
         fVVLQ2lVEU15mBmpy+7WSC2lliFnAFMZ+Xvuee0y+8Azi1VXrz4SYy9vsp8mHbyhSZT9
         p/rPlNJVKJLWMbgNHpmqqb6BY+lLGoCx0mpS5aDp4M73Q6jGhbwnwzIZQb9zxdguqXbP
         +dNGK1iSn/JCD+SQn5OCpCr7Ki0w2+OMuRAjaI1pa45FCBM3GISPmmaqFOUN8sKr9k44
         7zOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
        fh=GtZpi5K7EmB7w9JWx6jz3B3tKIXsp2huaan16/SltXU=;
        b=brtgEVcOd7AceVQH9LJi1ILSQ9PYGJdfytpYpO3USmkZSAKJaQqtus9XR/ulJH7PsA
         fDE8JD3PDE4wda9+0FfbGXM2gc8Sxxn3Aphgd8Zq5xFbcbTXCmTt6gkjJt/2DuuWEGFU
         BQxDXd5ZXgplj5QmKQJBMdhsyklYnF4ddBurtphJbR8PDOpLYe7+eOAmy6kRrR1ln71/
         HeNEoJRnO7+59axzdFvuppVGckKfsKhmfYFscGhJbDckA4YGKtzoMcX0NwkHWbf/Z1Mk
         8PU6hTa0BudKHUkCD5jmFULIIVuEack4iF5XrJiUotc99XrhqHCi1Ni3yNAn9rlHlUxz
         bS7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784809580; x=1785414380; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
        b=RCtYTs4dydqp7Ui3YGAFQ3uRrrGuWMtq9BQOysBnJXJqr73M+WR/X9WSbUi5AoVl6N
         9jTPT7mbRumCfhaw4uPEPPDTHHgAuzmZNaf3Q04wWrDND+fscj+3pDX7aJS78K66ljAf
         9iPZewlW006qQUuEM99/qpI0tgrtr2ywAa54hOfQunnd+noq3SUOnj4EFHo7T0Xhy/n3
         U2JH3g8YIy5KGwcGaF9PPTSWiTQekqfvih+gw2LfI9Qn5bqOA92LeZ0PZ9w6hHMbHYsU
         ok6wANgIufHaA8Ol16+aeHgdg6NIo3YI71Ffxdjr6XjziCgKkKLjaw3VBl2q3ArtopHM
         uemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784809580; x=1785414380;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bm4DvitUdfbXcw1YiUDoIAk0s2etPbKEW6IUc3kOwkc=;
        b=b5qZyHKbclZc+pTJlqmtC5RfeJVwerWQUh6PieuTc2ryYSlR10h1crkf5xwe7ojmqh
         DC/OQdRIOxoivs28/Ia530PBwSOqXZImbK96v2foIZUF17fGmvHk/c8TafAjLbCR4av5
         Zan1U8rgHY42lsyRcC8i6AfnOge4/EQvNg/b27EYIPq7hfOaPGTNm0+cyketLXDkkLiM
         iyGvcLA+i5N+PS6pRD5HvqmQ9DToQ+7S2rDizXx0ja+XKMHPyCr9hsboiLbORyuYHjnE
         sxK6VTB6aMyGrpphskEQqExO/zpAOi/xBCM7tAkv7JfxYlbgLQucli1zW/yP4zcmVsnB
         Vgpw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7M7t/JyyTJSR/jWCQ+SIvmfKHRS7h5NlewOhFZhtWOw3SYj4dc1SgPNu6zNdQdRuNQsZ5G44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQV6oMug2gC3Hi3M+k8F/O+0DARErllV6bQCV4j/YmY/9Yp+O
	I85U9WA80D8jlPQgR1VSfRzfbfW0cXQzWptIodVWmjJdntY/VW9jl6Y7OkhV+QtEm8yP9yK+JtM
	foQniY6xsufXpu05a4qX3XcUR8gnU34E=
X-Gm-Gg: AR+sD11PcZFnKprXbLc35rrgvouwNN7WLpQMA04K5bbGzI3k+NZbJsqY2fxexk+xF2F
	PsDRtE+vcVcWkseoohjOP2YJkdeyo0PjrX2eQQBjzE64hOSc1wHu4SZT4mZwTIa/1vJd1V1Y40a
	RYbHpPSW/UpZvy2pVOLPGs78+Unf/0dwRChfQ4IEoaofbnX632RykwL8p7ZQAwB7bM/oBS3PUs2
	0BzYjT65Fwn4ZndDlo9cGuMcu9dRzJBk9L+CLrFVegPoYH1Nf1yvoOBZBjkkd1EOuZVJOh8ug==
X-Received: by 2002:a05:690c:c4cd:b0:81e:69fe:a58a with SMTP id
 00721157ae682-81f4c3b05a1mr8095877b3.67.1784809580672; Thu, 23 Jul 2026
 05:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722041326.75199-1-blbllhy@gmail.com> <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <amHuIvHN1zY4wYpt@boxer> <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
 <amIGs3ek+0vOp5cd@boxer>
In-Reply-To: <amIGs3ek+0vOp5cd@boxer>
From: Cen Zhang <blbllhy@gmail.com>
Date: Thu, 23 Jul 2026 08:26:09 -0400
X-Gm-Features: AUfX_my9rcfIsLY_uIDVhxM2dZNQpjWSfMOA2YXk4NqsAsUSFcmPLjtGDnliEA4
Message-ID: <CAB8m9WjVdbq4Nr4poHZ6nP761rSFS8sQ=rYe1PNyEjS_u5sNtQ@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime validation
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, magnus.karlsson@intel.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"

Not at all! Thanks for both your suggestion and Stanislav's rewrite!
