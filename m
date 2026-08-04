Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1913590AE
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827024; cv=pass; b=Mh7TVOl29OlC2goqCUC94x6oayyhfmrKDdfVBqRORQ2D/g0hUhHWzpfzkqt6psPdfuLX0V/4RTJbRpgurGDYpays6TaVG41uJWwpzmAFz2Jb3hvTk6oKIfq4C/lVMrlZUh7909mcXp5pzUgnY7oBibDnwFAHnfpQrSs18lRu/2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827024; c=relaxed/simple;
	bh=ZNJUk2nRrzObEtviaRtuFIa7gMgn0ltnoTKLXgd9BRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O//mTBv8Mk6QVN2bLoyBmz8zEMWDBp+qEP1ov0MS4wgJr5MYGhAuGWwZ+LoZAiCvR+OQidv0izh6n3NVw5z4/0SQ9gPgt9ESWPnFVwFzsXyfRpRA7jN45F7c5Fm8dugbvbx46pc0Dln9RhfIwea98P8992InT4UlCgka6+0QnVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT3LVSRw; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT3LVSRw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c167aa9500dso545556866b.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 00:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827021; cv=none;
        d=google.com; s=arc-20260327;
        b=NTK7fq4NCYJTg+Et7QLcyo7tW+5YYbHZ93lCkp0lUpWrkkFjKm1vNeIMlIVQZtY/H7
         f/ZytMVqOqKRxCr0Ab8pC7G12iAprWaEyzhauk0npbHYmxhbBzh0+mBDQgaOa1wXi6oq
         /aubksz9zgRu+bPJlGmzfgUcODJp+UIcSo+WBo6bdT4c1B54zXYzCpIcR6t0KyRLpuw6
         J3BHUGD95FPzmqOp7n1KmkQBN63OexttlBCf+AcKktd9vluvWEyC9+NaZFXJbz4LN1+6
         JngU0TMkuPGaq18KdR33kprIb2XvHGn0Ylwn/nujyZgRCYh3tckGhHZRJCPL7o4/4sCw
         jA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZNJUk2nRrzObEtviaRtuFIa7gMgn0ltnoTKLXgd9BRI=;
        fh=Vld2zxj/xZjnE3RLNH/H4EIU4fJXydtO/ZAYYhaOfNE=;
        b=lcgkgi/2kWvQZUe7IaX2SMjfrYjmYGYiaIDTq/RhgluVbvCfU2bOWTdEF5MT+gqRLQ
         d+z3A5UJACKSW9Es6VK3RABK4ryXK/JotX8pak9lYqG/W21EJz4gvc+4BNstqz9EnhMh
         8L4LFexDUxVjyUBBBEg0ZiZn31YHtoYY2X6iUEQUsDN4Nzr5FNa9vMXf79R5zI5WXzNe
         ZMaxQgUlv407r02qubnNLYIa8BTGTh7vaPqYHMdE4wOOHgNi2C7nFndXlivdWWYinEjS
         DaTJfznBAnNu2yRN9kMJoYNp1vuosQTmzMVswmvvNyXgV7MuXNj6Wz1ddmbyFUxtPvgS
         sF0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827021; x=1786431821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZNJUk2nRrzObEtviaRtuFIa7gMgn0ltnoTKLXgd9BRI=;
        b=LT3LVSRwj3FxxasrlxM8Wt5MS08zjqoKFznF7CV8qW2SFFidsvrHF17QpCr28yeBKm
         QxX2nLlAvqzVDtSAdXnnnFYsKTeOKAt3za8op4AUEXFAjcq6SjuAwP4+j8868hMlFUns
         hT6Q6opFDUskV4+Rsd2X4B+ZaKGobGvDca/FLhnFRTd42CPS5LGPptVwhTVZo4mX9atb
         nhqA8hY/XFeyEF5ppVSKAEGGybAbwp1eXSM+4/u51kYwYegfXlBLUV3xFNdguM2QOzsv
         OtsErDKxM9yU9+DZ5jTFpa/6Htd/8SrpZYxUL9U8eWXyNIJzj+CTiuPvmtiZv13TTbk6
         +LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827021; x=1786431821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNJUk2nRrzObEtviaRtuFIa7gMgn0ltnoTKLXgd9BRI=;
        b=Dg2SGopoBf2GYubuxp2IzIeEoVNblFRjlr0VaTrJwEmTzofe3ye69lBXHo68DBOogp
         faJddU5ulp3IB4yWUxE4dYA+xdAhO+HlciErnimTmoAUC4SGfXQdYUS206Y7v9x/aEAT
         l3ndHE6mU0jv52Tro2bsnFqGIO4DfWDFO15EecrVVOYHwfMzLEZhAVKDCQqtFxgj2j7g
         LvOdGlgApTRUWgftyQiCplwlYmE32vT1W4AbCX2a4akaojCkZ9iuvOVI4mLAb+/zvGO4
         i5KsrM+Ac4bS5o1lLhKOSsps3M93fBjZ4WDhzU5OUumCA6bFgqo4hynf2a1sIH0TsUeJ
         diog==
X-Gm-Message-State: AOJu0Yz5A65R+9+DR5hNOflpNIHA1i/aYhBHQqFHylIO7SQP3oVg2HCq
	weGpp+4wM4UZdqv/PGYqt1I5P/BQCdvsNjYVDDWw3HCU3JwdEetCDDQPQWpQGnTgjLl2wSWaerf
	2dfa4z3TLzUar3gP1et+N5aLwLdM8HeA=
X-Gm-Gg: AR+sD12q5qUWxn3CgeMXfaph54pHVKIkrvLGQ6bK4F6sJFa2lcG+IQY6S+idZ0S0wwT
	X5wp4zRIw85QW40yql7J667DtMc90BG9k3R9o7y3x7Sy97FzjAHsnxy71dlBISpGG4MtICg024n
	Phz+UWX/h18qBE7/fzbokWvKB+ER+XUaFKAOH+7VcSPASX+Z3moRWF8ri5Ma4qbIhgWpczE2CJE
	AAS9kUkukUnWjJj5uGg8JhrNuHzoRgYO0D5VmYl6nX0oJK01jcEso/25YxuI1HwRDiIR5tt7x/s
	FSOUiIGM1M9DrFuyJq1gVHtpbWw6ifIg1PhfVM1nVjvhnA==
X-Received: by 2002:a17:907:1610:b0:c07:43ed:1b3e with SMTP id
 a640c23a62f3a-c1fe7c4b08amr1219576666b.0.1785827021226; Tue, 04 Aug 2026
 00:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101734.270821-1-a.shimko.dev@gmail.com> <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch>
In-Reply-To: <94fb1a6e-71d6-42ae-b221-cc03a820d2e0@lunn.ch>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Tue, 4 Aug 2026 10:03:30 +0300
X-Gm-Features: AUfX_mzjU-s1fA2NyekVyKJC1mnZ0UCZTD8jrUkpV-OMMlFmqFov532uxYaWRGQ
Message-ID: <CAOPX746ZFCE1XwXJ1H0gEaBvdvq-4GAiPTKkT-3XvZi0n_f73A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/3] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Aug 4, 2026 at 5:32=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:

> Is this a random example, or what you are actually using?
This is actually the configuration we're using on our
hardware.
--
Best regards,
Artem
