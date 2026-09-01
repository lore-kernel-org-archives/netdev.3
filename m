Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8938655B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266837; cv=pass; b=rrTAgdzeMIwjyGULI8YBLEXLjzncLw9jLj/Uf5EudJhnftEgLgjxK5Xa1N1EFV2RwMEIRuBv8Efp/KWtFNc60i+Cz3+bmmnqpRwRmMWcbrPg17E/dmUj8gzPxzpITTmLcMJRGikoJOwhzV4Y/7jaoVyprm8S6iisU63aA2UgODI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266837; c=relaxed/simple;
	bh=tSHTd/P3p6GYKtX3WQgUaDsZrGoJS+1kuOqNXUg02HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwFlxw0JaghDqYp9ia5mz/grpT3RP1J36SG7E8p587ZQwYOeKC3MMzQCe0WfYiJbYG4qPpuWbS8MRLUwqnnQAXcJ982PoyxlMpgfEu/A+6PblhDctRglQVJKQsLw9Eeul/DPvdmlOr3M6TwB/wBkLhcZE4QW9J7nIfRMViLYSag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMV+ztTB; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMV+ztTB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cecdc24b1cso4242255ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266835; cv=none;
        d=google.com; s=arc-20260327;
        b=HQGtJviJUxUrsLzMVpq2+H+GRiYlvpv1xxJt1cK+JY1rha7IQ+tox6/ED1tENQYsTI
         kvOwjIDxKg6u7a+47F7t5BtG8viHjeWS36IEB31hB6VdI/iksPSehz/9KuAkLv4q68C8
         FYydXtBaVF5yph1lBpg3Ll89x3D7As4HYuv3BmJt7/+nwYMBKnMNDRrlSotGFOSIn5mw
         vRiQxUUIwrMlvmCqCCB3/jqAwDIhXlD648fItHUpA04p8WEy7XKVptP2YAk1VY7e37E8
         PkMrbF6Khdqh7ypQtniVRnnhmipjyoYYYX2xEPOwC3AfrOY7FFEOqLRzZIbQwRRX2Pfm
         Q5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YY7/nqCIyRT979Xza7vq6CHGCQir1nfRHMiFD5zxFzg=;
        fh=VHG9PuWfV6d1Q0mOUOuQR8lc3KhSbrel3KGdeze7RVg=;
        b=P9WpPDwEe58xQ9j8yXzOj3rxxOxySgN/Xsy/NzYlm5c4yro3uf42Hwo8iPNTFlGiM8
         rBsX2rbMfFXpjhKimw2VE6X5vlf8yBQXpgXmRfUJ/Xcy55bGFmDcF/EG8KHjskz7rGrG
         432kriv3+o/rrfK6rqR0tZr4jrmCb6+WBbzxMNXapR6f/RL0goNuhoDEUFOWooewpoPk
         gURtYDZECY9ELNGk9wgDLRK+YG/XszBQW+J/fi39h++eIg15K7oL3pPsJ++hsi7qmCXW
         f5OcayarTmmBR3Nc3kLGiOeouLc+lkm238pxC6VosI5Jg7UmoUjXT3+wU430gD12gnSq
         pzYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266835; x=1788871635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YY7/nqCIyRT979Xza7vq6CHGCQir1nfRHMiFD5zxFzg=;
        b=KMV+ztTBbp+57dWhCB8ygIGzr0sDdURpsksWI3HQgz9rdwNtzM2s5YhHihvwKfq5Qx
         +VgwI/6sxKEpTCe7EMbExfq1MA5O2LS0VxPnMnJfshI1mFUa0rgAMxvUJGCS+5MsUr/4
         8iTUP9qqNXURS4He4+Mq0S0DZaP7Kjc7Np6547qgjBsa6R8/PWCdAca3nAEsdsVqFNRT
         ZzNR5SGWQ+olkO2qqrisWpHRsOoxso/pUK789kgnKJrOAif1aeJD3w9FVbHH20gXmpGh
         1MxTuWOtHcNZL6cSY+sjBsbUg2sUf2cNlr8PRrKL2aMvrLSjAEdeKrSoaBBSNwHe5EYK
         A5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266835; x=1788871635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YY7/nqCIyRT979Xza7vq6CHGCQir1nfRHMiFD5zxFzg=;
        b=o/F81IBaL3rbkVSiH5x3GfTJsKy7ms85GC/k3khd85RZAYzYGwnU2Gs64yYILuwMdK
         WvwP3Nc4HfWvrgUHZ/Q07bY+pk4H6+ZwFFrmJdKhP4KTWIe5DChwLYEkfxs5STR94Iys
         4+pQktsf1o1b6uwEZ8uYP0tFdwdxeNHwsi2Kmhuu7OUvN3TsMcmfZDYZAFFTkIdDaXw0
         EXhVHKInhSTCf0Y5UyAs8EUrv1e8V0vHNvfilCMrFDeOJ4/mqbLYHE1V6X4xvxBO2MWO
         U4ptwl3JludSpRuZ/52wGeNucUCQSzx+GaE1mhJDNK7mfaMCrlacvjiS4PeElE60F2rn
         OxJg==
X-Forwarded-Encrypted: i=1; AKwUvByvOlwPVSka3kziKQlTQOBDxWCzbkSKaQIjLtJZ/ekfOcrtdo5Ac51UCRcKUBaho8lixs1DkhY=@vger.kernel.org
X-Gm-Message-State: AFuF++mkpcIBTd1Z8qonF1cJj5E9N2Ej6hh31byQLrcGhJN+U+fN3LLt
	zdyWQjo3Hx12Qf6y8/3rWmb9zH+67VfKtIjZIBDQKhbk0qQSfBeLyqD47BcWiLDe/iiJ9Dpg011
	J0RD3LqmoH+Iy9P9WkVLFA1wLhKwWhEE=
X-Gm-Gg: AYBFou3NYb9zRdtABeaqHF1zoyNON1rmKpDD/jDvjW0XHIn0gOzLHAKo9vNZEwNlq0X
	EaCpEM59x8B4+VdNduOaa4sIlTcM/KIBIAVflDpcXhlSn9xGdPG8QsP1GgyW5loFZrWd8cUh36H
	fJJ/+jaoREYImdMc4xiwUVMuwV4OCmSefUGBQjhnw88fsY/zTMxtJttX8H05QcaObEe75uhWQC8
	RaC/YnST6BRvpPnQuM1R5xEz1S6LuP/PkdnxFVNzpT3xhNtPKvOiFIfzGE7pu56VoYe+GjMFl3B
	ESgZnIBIRK4fVs6Zwej1A1J8HeFl890FXscefRPiV0oBNKcEAyh2b9fVqJ3Yx76JTxEi03ENOlD
	FZd9XLgy0gIYNRGVrzGCuMOV7ZybmpBnmVE+1btHmevgEyWCxmHL7bsqRPTnc
X-Received: by 2002:a17:902:d4c3:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2d74df1c3e6mr300904625ad.2.1788266835323; Tue, 01 Sep 2026
 05:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn> <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
In-Reply-To: <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:47:02 +0200
X-Gm-Features: AcwNN1V1Jwuvmj9QXGIMvnAzaA7Q6RWpCPniGM_AD7qCT09U20JkW5qZV4zK2EU
Message-ID: <CANiq72n0sgSPQ6SmUbK+tv9S5VZktA7g5XMjHOBOFNYLo2oA2w@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Gary Guo <gary@garyguo.net>
Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com, kuba@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:03=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Might be worth mentioning that this is change is only possible since this
> April's bindgen version bump.
>
> This is a bindgen version that we requested
> https://github.com/rust-lang/rust-bindgen/issues/2674 and available since
> bindgen 0.71.
>
> This will affect backports.

Definitely, if the patch shouldn't be automatically backported, then
we should limit it with a `#` comment, e.g.

  Cc: stable@vger.kernel.org # Only 7.1.y and later (requires
bindgen's raw pointer accessors).

> IMO it's little bit awkward to have the comparision be inside unsafe bloc=
k.
> Perhaps
>
>     let autoneg =3D unsafe { bindings::phy_device::autoneg_raw(phydev) };
>     autoneg =3D=3D bindings::AUTONEG_ENABLE
>
> ?

Agreed, yeah.

Cheers,
Miguel
