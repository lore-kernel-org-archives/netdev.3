Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1E22173D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338578; cv=pass; b=oa3KMNpwC1dzSowVWqKOxfFMA8uVtXEaqetKTYdXcJyYv4oKLqPdmG9ivD4OAIKlzsPNBBvuW4NsFSE+uXNPHkDRAss/VxFFKBIP6+PC6Z8PS+73/4VhaKs7GbGD1FeYcSWUJ2DOx0gE4EYnwpvmAv8qjr918ABtx1EnS6gTy1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338578; c=relaxed/simple;
	bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIwMEqZg5Uv6QdI7SiR4uidciGTLBxyaPoZFgiTjT8s0d/emhOuusdH+z22tKXwlSjMl1kUR69SVJCtGo7Q9mjrtEs27F+T3UXTJ8D55xEd+7U9FHwoQcPM8tJ6GsSTcG6/tX1UhqHVVy0tNqkFjvyDTEm6HNoykigt/BOEHL2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qze7hzzu; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qze7hzzu"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89fc349b5ceso157327186d6.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777338576; cv=none;
        d=google.com; s=arc-20240605;
        b=VSGh+dQ+PSNhV3MlJ0EjHwIJLnOpNB9D63yXd19KlUKxOJSsYjKLt+1PW0udMlI9l/
         UxS9PpaBAOjS3+370RQca+zfYayApK+GmmQOSuAXG3VsOUWfdETY5k4zJg1/xEZOupDC
         JlVdnbuzSB6OfwZyLHhhcQsXLIGHlR458nPdHp2qevUGHTl5I88AjD/sbHC1Tve36B4W
         ZtHzUh9y4FqWc6QlscPRReMekC+WHEeXxDdJc2u+rO4ZtfQ2gDQYXMRD7m/Osd5Opi5o
         kdKLrUt+UgfyRm4kH2p4iSodU4SSD+thW9bvuBjSAvC7gAHvGrfO8CuTGZIIMw3TOV+h
         U8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        fh=SXtT6v7HMP9h12o7iW3DPQ9VWYm94OzdOeOZ4EywUFw=;
        b=K4VB3DNj4aEKibTXWe9W07H/sBGYP/ddmCBUd1YOqRhNdUQQU5RUiNt2ytjVr6h2E3
         XsyLyviEvee4cAOwdANBrM9AbAqs1nefTs6tUZNkn6Ujlv25jTxPLuHpI1lxbaHk4AF6
         mTDkeII1mV29yKqxJ9txmbb52Idv3NNWXU0UfucvGTMyzgMqgrNsBhnItLTC7vQNMhYb
         F/C5mcQ+pn6BXynMS8qYw9bbZH0Hf3xjRq6nISw0fouQnQUg7LzSxhHQjO+eYz94eWXY
         lNOxWy6FVZnDDUGlJsAJjDGujLTp21f6yLONKyyJsZmTmg0GLHpU0AJpfbejhNGPDNO5
         ehpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338576; x=1777943376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        b=Qze7hzzu3b3wV4C2iBMNQn3N1zJh818nFnk2Mx2e/vip3YQTT9jhSDpHR9CSF/1kbV
         6OJlTcaFn/z438DStQ7/p1It24IOZRjJ3V3R5moZctczwWsxb/QQvyF6+zuP2ZuYQRzr
         Sunx5v0kC363iMwkUMs3RQu9IjE2mZ65wpzavYzzyBWAG7xjp/dAY3xlNpmuaPd42vUe
         e2ewEG9aUpCOw7w1zkxmvRe+kiFvwXVd7+G7ZGJfVRae0hOK/P86Fr35/qTxNrnFAY4B
         NtiNzpkPkIyuT8fzOvXBXVrfecgoA8DksrSX53ILHKKxzbRzoAqo1EsZZiZqG8F3hdoo
         UBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338576; x=1777943376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sch0kI27Iw1ioDljaUdwhBKgz3IvHr+k8dBz6JKPj8=;
        b=FSikc0Gr4aX1510WrVyAScFNSNljeQAQM5aLxcL2fc6eXjsYTOLMWIZ+Ja9kDJZE8b
         E5Co7qGKQa/G30Kzd3avSzNqJ+5fngVrcpaxGrfojYMY9v0RD/RykSx4gnBSxAS7rrU3
         0IUNCCFWtgX10JHACp4jvjzj/KYx9CKFkYXuKWwSs4sdbROFLEmK/ID75DE7xWmyNIBD
         +4TmiZqgb0u/TErYIuz0UkIAkdYBaD/pV15RnZR8J+bXau2QLM59h7sTVlYeJfYFoRc8
         YL7xsX8gZG4uTg1g3xmOCr0Tz6q5D00dBgO4r2rKrRoXXURRTBC+1j4GbR96NpH9AZC6
         hRXA==
X-Gm-Message-State: AOJu0YwCphd+zg5YJfoEEvqQyTtgxl4mHB+qGYUOneSx134nPo67XSdf
	26BjpnWHk+tmS6hEgDAkZ/G6ndc4C6sIM1xIwKIIl+FsfEKIW0rNXE16tgrwNyo+jzznMc0w+dH
	EwJr3MXd60e0kb2GoDFl/4Jlg60Qayds=
X-Gm-Gg: AeBDiesTdgRNmvrsYAhvuBfmxXtoNYwqwf3Y/5K/0mkz5uYc00cZQ/e+/302OOxoMsZ
	th9qziuGhcmiq/jJHyoiXGCmfcy1POudLZx1ZhXj3lrcjpsc6L7fK8Yx5j6isRqX8kRpx+tEbkt
	fh6Id3FFn5Mlf3xOlDcQqfvkbiyywgBgLPwrkJI9CeQVEq8D6+fXqk5mlOYFEfRsPVzGvvPr+kb
	TatnF9iAAdkpyvUDuCgkci/aiamyXRKn2AucE/pqPi1dpNwEcJ0YHT2HzD2j4iX4TBi7WBTZNsY
	yd7Z5T+RIGm65XEc0CZRO8U8Gc8RzpVVlw79JMIaqTfDBw5XpvlE4ihVEdv0ZO+bfAPIloMxPy/
	ENe0=
X-Received: by 2002:a05:6214:5b86:b0:8b0:2b9e:9639 with SMTP id
 6a1803df08f44-8b3e305cf7dmr19913666d6.19.1777338576269; Mon, 27 Apr 2026
 18:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425041816.19070-1-enelsonmoore@gmail.com> <20260427165959.3a294f1a@kernel.org>
In-Reply-To: <20260427165959.3a294f1a@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 27 Apr 2026 18:09:24 -0700
X-Gm-Features: AVHnY4IOutGXbWP85VlfW8A-jXZcwYkaD-ufKnvdMGHabQzeiYY6WGgL79Y-ak0
Message-ID: <CADkSEUjrFBLFQEHBaKaGe3SxdT95GFQ8hCbgNaF7ZgVVB6txLg@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Yibo Dong <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	MD Danish Anwar <danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jakub,

On Mon, Apr 27, 2026 at 5:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> We can keep the vendor as is, this doesn't enable any code compilation

I disabled it because otherwise an option for Mucse devices which
cannot be opened appears in menuconfig, which is confusing.

Ethan
