Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F70366057
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153461; cv=pass; b=aI+iKAnLChh0KxnkpooDj7xwo2yytVHzNYYQ5TgGlVLAq8GriWJJtoQQ8Olu9431gzbPCyad8hhGcSVPevEJKsIJJTLE2zR3dv3EXoGjXvM1uslmvEQW6JYZqCrXNJJee/xWXcEaB/x3r+1PZyvnTKdOCZQHBjysDZ4KiNCL4hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153461; c=relaxed/simple;
	bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S881Q98/JmrfvMUiPOuSXWM6EaBfxbZpxgPk+cmdsRlkc8peMpXlI42M1bNha+3TWqeHbnI9J1EllpGq0asues7BUPzq8oFv/kausW8XLZME0Na+aTTLAPctUbs98Mjt/i+N6a1dCmatem8JqQQMry4RtOgaMNZDxzjLTC8py6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZtIpfPX; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZtIpfPX"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15dd4b9132so385296166b.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 04:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785153458; cv=none;
        d=google.com; s=arc-20260327;
        b=WVqoptX0oTUz2kHSIpMVNsKYMuYDDaszJPpfQjYRty9qEpX3Go6KSeNECcL/5GCFNF
         rxwYKQfjVA9iaLsiWrY0WlDie6vux33Cj2iqgHIb2eabv2TUZrtlnozCqJiOtBdANWQg
         IZMRJ9A+mX/AqgxmanlIEyo4mMPi55BHB0eCxhYSuya64KXk0lA189qH1hZ1grbY3Qc9
         cmTc9c7WysX1KXrgaa6kpMzWGXe195A24wpQaeWj8/Lmd+yJgSbXpug2h0q3CLEySHkO
         7rLY+aCsx6jpzuT2taEyNEAy5Rg18zIT/U24SG/Qfo/7y931U//0mGcG6fyW0ZZsLvEH
         yx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        fh=g0XIUMVkV9SYaGLF3VkKlxwcYauthLDIva0rLkuLJxE=;
        b=Ergj9VrCvLfyl5QYVosv3ypYrI/HImESRb97bQGX/tVI2z+EJ5q/8phZh3ZprPk263
         et4v/rF5cb65oftBLZvj+RvN2kYuAqQXG26J1WgWl81nx/ky2mwJGxql4LaABGfUhqub
         JdIenZXpKVI7zMEaJkiqcUhyu+gUhLAgWL8aRnhfvCGb2sXACTnyNPUs9V3NCQjo0oRa
         ryYg+GWxIlvm81iYsf8FznzjfWQj7bbRit8arfzqXLmz8miIy3ZTvEhFmmmB2WrtSRax
         H9W9B3hbMWdlI97DhDjpHwYTzK3/atzW67HYRDAoD49NczNTN67u1Spf8O/Ue6sC49ZH
         IcaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785153458; x=1785758258; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        b=OZtIpfPXTTcaHnGhkDxSZFynofniA5nD8GoqxxI9N6LieHRLhnYkhl1h+62wg1zYXO
         1CNEhOdxBBsIpFaGd+cQxgm+7attBl0knRJ0a6IoNWcmP9tpy7Lh5UWy8i8CVT4iqhoJ
         2VadF7Ww1aMJK0JPQ0dUuRkru5DGuldDq4VwDsgOKMtgQ+HqHw/8lIRevyi5w4nZKa58
         a+CPrKZujkAykRFbCyYjM/N17g8Tzqu1UzMQNqmCqMP2zgncjLH32tidtuP7hMYJxTNk
         goeswJLhtRWJC2rVTcSEVT2RfRhjSG5BMcUz2s8g1Vh32q4Ki62TdriB3gdm7bpu3Gjt
         zOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785153458; x=1785758258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2k5B3idJmT6bC8h+ilrKx0XVLWjKGNXuCUQ2oqNbk3I=;
        b=WW+I72pGW8mpYgIfja6ZDeRmt4gJJ001iZVm38w3eng4/FxPMsTwkvMdfYM2Gq96Wh
         lYyXMIT9Ducm3zlhfAdE9oF5ZG9brCIanBsh4kKZePU4dOHWvAWckaHNLj3hpqxjAIdt
         jn9uSxxwS0xJAVwXfwtUoA09Fc+p2+Ou/q4GBIw3b6hjgRIA9nrtEKRVwXWLhcbaIphl
         iafqwwhUESb047ojCo7OiV+YnFePXHQS1kOQLlx009xoo93xavRd2xvtP0/LwZiRyDLN
         WJ+UFbu3+m0ooF1JyNNAbmsmPz/1T0+vE62P45qm8lfx8bsWt+AvivI1FBP8SOud3hDd
         JrTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbZZpO2CPFzzijhgsmPos221N5KJuJSCJtL5ay/YhvQYT8XU//KbyEt3WMcJ7UtnwbPbqElKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHcusc6jTJOCipY/1TMjD4MAX6Ln1+JqV1W1T+SiY+oNTIkJNt
	PyTSn1aYVZ0T9i5AVlMxA//miGakrXRVQBHhYyDf8v/CpFx5bO91konwCrstRPDhq5rpDmRbXsV
	kaqAMYDD/yjKBzn4ijnKY2hWhtM68NAQ=
X-Gm-Gg: AR+sD10qvETV/NXgyftUUV0yf4a2Yb6mNKJ5O17JXq0Lb4qbSQJy6PQY68Fwhf87RX2
	cMM7MmHHQ/zPbnY4W/4VyoHc229byI+gBDP9Cg7qml83cjG5366O1SCs8sLpdDt/02GoZwruWZX
	7PhtVRQCzD31c5cLbHalrsdeSTcaS+PTbrCWG2/VET1A5KxAoc48NutqP0+Z/5c7mFnebFhICWE
	BdsNrz4IzLOgaL49WQrSENQ038j6IWQH/FgM7aj/lqBvSeYUgqYkwUu9h/B
X-Received: by 2002:a17:907:d641:b0:c15:ca27:5818 with SMTP id
 a640c23a62f3a-c1f1eeaa320mr395955766b.28.1785153458189; Mon, 27 Jul 2026
 04:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026070925-delay-gauntlet-bc7c@gregkh> <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch> <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
 <797773e2-b155-451b-ae97-e8a005fd2d86@lunn.ch> <CAE2MWkmbdDrCw1HUKm17QG7dyihuxg_1VGTUNeBq9v8NVwJV3Q@mail.gmail.com>
 <20260719082223.GA1899043@shredder>
In-Reply-To: <20260719082223.GA1899043@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 27 Jul 2026 17:27:22 +0530
X-Gm-Features: AUfX_myN8vMPcj0vJcxFKIYLNoX74G7CTQydU2TzsiEAmJ7bTFLP5Hg7T5Y7VYE
Message-ID: <CAE2MWkmE3N6q=_bOv7AaMFS15+SizkzVQV-SCMumc-D1rWcv3A@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>, 
	Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We asked to target these patches at net-next because they don't fix a
> regression (the encoding never worked correctly), so they are not
> relevant for stable. Users that require this functionality should
> upgrade to a new kernel that contains the patches.
>
Hmm, understood!

> Regarding the stable-specific patch, in my experience, stable
> maintainers don't accept such patches and prefer to backport patches
> from upstream, even if it results in more changes.

Then I feel we can skip the changes for stable now. Hi Greg, skip this
thread and the changes from it. Will be in touch!
