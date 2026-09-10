Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA534EF03
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011112; cv=pass; b=u655nmeqGj/Q6NgnU0yp9d44HZHnkw9n41bj4mnmly/DiSCBsLiOkFqwkzDpPx0+mtgZgX32gYvdbc4lvIb5OrLReglWJ2w0HwASNYjDBhmj1s+0gul2UNnz/OjtBnVWS1UblZz1nWQjkaFLW/Eo9h7OSRHmRuC8VCvlYbz6kxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011112; c=relaxed/simple;
	bh=0qt2KD45sI21gJA6Y8we2ZoaTqnK0eJ/2/8zs7rPg2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr4gyukcrX4Zs9CovdyM5UyiK78W6E1q+34SfnPBbpHttC6znDdqKoVHcZdQDfCMKDGvvE2YWfA8A+oB85aYASmygVlra0h2bCTgC5qlKvwByZ5r7NptmuRP0MFxgzpGztDIcDpAcV5anqrBOrPlVEjC3f9gEmIc5m6WFwZ31es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms/EPLff; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms/EPLff"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a4fc78b556so11213951fa.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 20:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789011107; cv=none;
        d=google.com; s=arc-20260327;
        b=Qlbj7ekMnFPxitx9HqjgDxu+wPYEO90kKFUuMKsmUuFSQl2qU1hiNPe2A8cEcmfYLc
         faVjAFDxI3KxXSZU+fzit9rcDTvRg51ujDLnVwLpd0OIHHqwcCOf7CExl03DsevSDIzy
         9EyVwwrgigQiPY2vqLnXh8ENt26411dm0z16n0edLbyUN/jOKBhRO6Cs7CjwMFMsgFk0
         Wbj42oBuunjoiJkZZYRrBvfkC/THAB6RbhsNREXdTpwX6y+DeSPM6zXOeZR5iKas2yg6
         Fj2ep6NET0YlX7m4Vy1LdjVIlHf3ndT1NiK7Q0RKamS757ypSxRvvZ5wR2dNdGwyJ7+5
         kgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgbYbe2QCz7HfqnzJM/CyQ0tUDugBwRoT9qoRJLbqws=;
        fh=zryw9VIgi16bs5oSxLyGg9AZFnGnyLnKQ96nD/RQldM=;
        b=kXgUK2cTzm4lAiaifjBakjbGRE7afrpwIrG7CJQMzM0fto2BUxsGr8g3cm0/eifHPx
         o+E61EmjemrXT5p2Lzzmnyg9UlwsxEEzuYI/NK+S+2UueZjpLoL1lEEHMFxXNqIOaZ/v
         pxbg06fXwQwdOY55vX6CYLD+K+6oO9UV2SkU/DTmtgTkFZJ3MAngrUiqy/44dxFVL2xr
         DLa3P1yzicnX8HU+mE9qV8CP/57EAHpE1bzEsSG5ye7kNNmM06SAktnn7g7Uv7q9PtVe
         nyZFmG3kpwb7yFoeBNILkvOK5abb1XEkGAYbjSVDB2aLZtUvgBL+xH4wJJ1NlTGp8eYp
         fB3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789011107; x=1789615907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgbYbe2QCz7HfqnzJM/CyQ0tUDugBwRoT9qoRJLbqws=;
        b=ms/EPLffD8msIzR/FUmEaJnrQRF9hnxnPWGpwvvs31pd6RlZ+LSWy1IFRMoA15N/QL
         jTkyQp2K+dZcrjSDFzuWkB8b1sKcc89/skNv/4ttjdWhYE9AdX7CsUYlaH1MpE49VN7E
         0wZntLhmZJQyol95sc79m02KvRwXEW1gkzCMJ7ir9kx/kLUEKwy7D+sVSgNdKTV3kV/i
         GmIh9uomugkXyVar4NrPq3em1NFO87+HrFLFYb8Xcq4DEaIYt007ykC5Mv3tfla7oWQK
         f+BlykiyoVI9DpnrfR6o5cUUhRGvawNjTG8EvKG4I99PtQFPXHRH5DpX5YRH9bD0L633
         SIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789011107; x=1789615907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgbYbe2QCz7HfqnzJM/CyQ0tUDugBwRoT9qoRJLbqws=;
        b=cwpji1zTXFT5ekO8GocbHpcDGIWQyMBoe4kb1BFC37NzQEYpYpAg6+DnQtvCm0GWzt
         5dEbVvWDRLF9rX2OBy1UDp8T2vQIheVLiL30VqTikkmqkhT2meIWH+yETnWK11XpghCH
         v0CLGljw45DKGtD3dEEDW70bqOKU35Z3vjsLVS+XQOdKMUvkJp7jGmVb5fKAj1f4DOYM
         CZ2Ppw1CxRv9dwG3wYv6NlcXznJsaTtDIN9H6kT/YjbwZ72CYbECOb4r/pwYhrkNeSbO
         3yLIW5ScE1W7yXjigkigdAi/U84gFhLahSM0xz4KDyh5Ti+gz2+MbKcPWyoljSjGbO+C
         9geQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJWeDzSY9tOH1iLZpFZL2RbmoBJQTqGjmWHT2o+ewt5KUosDh1+ocS9GzgDd7oQxXGUtVFHsk=@vger.kernel.org
X-Gm-Message-State: AFuF++mj9s5ouwe+o7utHBPI+JwAkRhXjbztt0tsrJvL5kTdnnZfZwyx
	fJEERZuLktYe4FmoK4B7FTstjHbd+iZ+R4cmGRoDRbaWKZilyO+nTbYFfiNww1LF8/GP8qaejMV
	H/OIEiHyxDNe6k0pBsi6QEEHznQ0cGf4=
X-Gm-Gg: AYBFou1LxmXTT/kr75FxgpwLenUXzrl393kWgRjwasWko4rBp0WFU8l5hJ0pblNCuOK
	OvVTC7zgEIcSpcjuwjaUhPLuZUCcxTd4fg//7Xb/KqHfVwtUNQhuFOdSXYIyGXBArZVVoTWeuKd
	0qLm7rqGkUABCESvM582wiFtEWjbbrzF5kYhVA2Pwi+J4Hkiml5E43C0zkPzBtthh9f1WXniHQ/
	Ok7ib1fKu1uSFMXKc6wjlwIBYMpZRwMtxkh6hqtK5ddIAp7rAJiKg8XnrY4gOCpcnwgqk1LsEBr
	aTpuBFlPxtP60rt0osBT+5EZeC2L/maNwVzSi/HYpe7KgfI7KV1bC+0tU/+z6DNirGRjkeUSxGl
	O88VVimqh42J19BTgTpkjvJIkZKjbmeK/AWyaEymvdQ==
X-Received: by 2002:a05:6512:31cc:b0:5b0:eda:de1c with SMTP id
 2adb3069b0e04-5b616f01f40mr7098978e87.5.1789011106564; Wed, 09 Sep 2026
 20:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909013401.14408-4-sigefriedhyy@gmail.com> <178900489529.219967.8506896899151263500@kernel.org>
In-Reply-To: <178900489529.219967.8506896899151263500@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 10 Sep 2026 12:31:34 +0900
X-Gm-Features: AcwNN1WCpzOJ3A2y6-ht_UAZZ89UGnGJrkAmcH1fBbpeWT9y7b43gmj6FiS8apU
Message-ID: <CA+7S2vJuhbghvtYi7T+rpDgkXKG0Ls+kzxYnprZWHMVbYHsejg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] selftests: net: test AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 10:48=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> - [Medium] In the new `dump_mcaddr_l2_check()`
>   (tools/testing/selftests/net/rtnetlink.py) the non-fatal presence=E2=80=
=A6
> - [Low] dump_mcaddr_l2_check() creates a netlink socket via `rtnl =3D
>   RtnlAddrFamily()` (rtnetlink.py:125) inside the temporary netns and=E2=
=80=A6
>

Good suggestion for the test case improvement, will fixed in patchset v4.
