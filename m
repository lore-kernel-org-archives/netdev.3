Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031B37CD2F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939776; cv=pass; b=U8hwG8VqYXqnUume+vyG7mA+MYwHfKDDPewUCY0UKBe7CVXULCjWFAf6HHCoeNYiQaLrRqTp7XnSn5dgXFulf85d/QURJmq8rLzJS5YMZOTi33CWedMUAnG7FYLEg3p8GpVEPeHDs0vZUGs233GFzA7b8ASmejBz9tH5UQXVho4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939776; c=relaxed/simple;
	bh=zoqyZIgm1EFWmYCKlkiSGKUErGHHlemelV0Nuq3FxEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf8nx7TgtxD8UVenIA+fAMq7+pjlZEMMKisuFWXCvHm94Ulopjih19I1Kwatkc90dHxnvO3E+LLB5W7UsjGrFXwLAFkUiAtnz6WSdh6iKQiyylPiL1ZbDbUX79ZSjtDCnzbfe/eHknu4zJsZa7jZljgR3djYJuBICU4ZAnB1RiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQwVT5OR; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQwVT5OR"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee4f586632so175074a34.0
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 07:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785939767; cv=none;
        d=google.com; s=arc-20260327;
        b=R++bdrPoQh8KF3aweSMnjUNwo3E7NqD/necApTc18YzQ4Ln14LHn6FORYR0v5C1myR
         /g6N2Lj1jGIyBK6lHoujSh4h/u1gx4QzC0imyhByNfX8KYvpQy7qNTyqEHd1vOjg0KpZ
         mpv8sHjE6L/7o1QU3h3CcW1sFmxH2JfOS2aj402TDLG2kSchwBeEbvOK4+A+kedAN4ih
         kBp4zoLBRj8pN98JOK1E8k/C94wRNWpbd4Sel75A+rxTus9O0lzlU6Fd+48zE9ns+x/f
         sT4G7fO0lEFStqVHuS9+qV9WOuo4bkyq/W+dUVr0lETDq2a70EivRC2WOvXunAIXpx00
         nUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zoqyZIgm1EFWmYCKlkiSGKUErGHHlemelV0Nuq3FxEs=;
        fh=6cSalOzhWzNXelggsnG9aJv4RzzTN/OxTg8JZVLzgWg=;
        b=EUXJQKX/7VZYN1fGRLN3IpsEYZY7EJ3dgtq+mHF49bW3zjFRT8LLLQKTtgHyKfYLMb
         GVUcoMxXdlPtwbHdjfs71RXMTgjbdbdNW3tPzoM9zll09IvujyGBVeND0f3RT4eugGRL
         ZnU5x26hs/xiKh6iBC3MK6CDBUue6oKKEd2nOW++GMK7xfN17aBA5sWIf+RjwKjNhEMP
         5ctcD9pBS0t8HtuPC1pM3kxdV0UdWieRyRWluVvmvy4TjSX1aUw5HrJ6AqRwnsV7BHXl
         ENRGdx8/w6i0F1ci447j5YcRgBDPyOyWSKo/Yk3RFtYqi7BP8BZWtvtEXx7Yvt2mBtzs
         9bjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939767; x=1786544567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zoqyZIgm1EFWmYCKlkiSGKUErGHHlemelV0Nuq3FxEs=;
        b=gQwVT5ORXPSasdlgoeUPyIFhbf+eZF8lXaJan2FaicbvLqcuboK8qE4gssjPxJjI9O
         dK6kNZFxTtq3MWxBdkFXqartCeMFBmAB2N1rlZ+OX6uY78AZN8BNwHsny+mOxzZZtSO7
         lkMYKDH6Ca9ERWSRn9JvEaTMqAn7tQBMWZ3KGNlNKcblDap2o3/oNa0a6oWrpc9a8xQR
         bx0wsPYswBin6EoKhcmxJ1/R928VYU+QsPcerXqNZ97xNAfWB6RytYLTiA+DX1NF4zTR
         ZIeLaywpQ2M+VcwH2NATK89hHccpfW32InmOTcWqdowrkXjCevY7o5asEawcK7WI9dbO
         XQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939767; x=1786544567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zoqyZIgm1EFWmYCKlkiSGKUErGHHlemelV0Nuq3FxEs=;
        b=iP20Wqv9ZUFXTcwH6pJUCiXdee0pow0dLDx7l/wlEf8l2axWoe9zgcU08KEeuZjDiJ
         GENWV7Hwp0ESwFrIxe0eQznBS95PnOpDfxmX4quadMkA48BIsDYmO/3yCl4S5G4t4Hek
         6SgKnqsIgrYYBQ+Vo8UTQzXCyxdKClKp9Tv2H8HGfQUHdfzFqxkXQdU/hdW/A2PxuQBS
         7OZZ5HfaFAlB2CoWXHlRMQWpZIsloZgYHabiTcgxDFxrId6ltXRwNgvOQZUWP8VU4cw1
         lfiU9wpkX413iAnIlEoLKD0s/sCdxkd2cumKDhbtfwtbkyG1WevK1t/KmogxSMbDnBN3
         QebQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMP7ea+HX+OYSbMokrqIoD2NZFyN1Gil45xZCGC5tc19OTTqly6sSJ+DJ5QZRWQ/AmPHyPXR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDCgP18XmCY1Uf1M79vbvkPsIFVyE2LD9SazS5QoQiPKC6KU4
	QmHHaJO7d0LlIndrPpECkpTh48gzvKVJmjcUJcYtaoRKnyB9MMrIfla4HtYo+KRra0+A7Q9qeAE
	BWzY+Jq6LS1x9Jtep4HTBiFwMG62fY1w=
X-Gm-Gg: AR+sD12kpWRmffy9P8S3mHdkm8/5fuOlmO/OCEC/Lo6NXvhCjRTOw4k1j9XwcN0nyx4
	FFfWbIOYdvjY+IyWy1OzXl43ihYTpgErtKWOgnHSbeKtQOI0tSBEa1piOX+AhfBzSl4BNx/Fjuc
	V6N2wahf1tn1725UszqmvMP8wklGKjFRZVrCPnWioTPvIEFNYuar0raBrS4IAglwalVNJ0Wiby3
	wimFPKVUFR0gMKg3mmGqCi+yTk/Jwbl3l4icwphKn4L6aB1bj8KOgl0onOTyus/SGac/FAEYuqk
	148orvI0T0/2ztS9xXxl63PAHXhoj4b6S/t6t+bPWuperO5G5/nvhJm/IeZ8
X-Received: by 2002:a05:6808:50a7:b0:4a4:ade8:a27b with SMTP id
 5614622812f47-4afadf34316mr2545848b6e.1.1785939766818; Wed, 05 Aug 2026
 07:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-netcons-userdata-rcu-v2-0-c5e80f6a7a46@debian.org> <20260805-netcons-userdata-rcu-v2-2-c5e80f6a7a46@debian.org>
In-Reply-To: <20260805-netcons-userdata-rcu-v2-2-c5e80f6a7a46@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 5 Aug 2026 15:22:35 +0100
X-Gm-Features: AUfX_myvpD_v6B0dSVMW2yccuOyWTBeIMYT64tQPb_nOAiYzeDrWrNVWBqp2-jE
Message-ID: <CAGSyskUmNJQy=vSb5-zbMfsC5RdMp-P-CkEa3_kfRAHUsns81g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: netconsole: add a userdata
 torture test
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:59=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The userdata payload is rebuilt and republished on every configfs write,
> including while the target is enabled and messages are being sent.
>
> Add netcons_userdata.sh that runs random tests with userdata.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
