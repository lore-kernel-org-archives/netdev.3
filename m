Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E033DED1
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791669865; cv=pass; b=ikwajywrxKzVd7Ezh1q/0VCwFa8h57urwDMkmgWNHDPEJ8zULZKY0yzMuS1bs71npjb+CAemm7qyal9+xa6fq3I0leZXiU/pnxNFpfowa13/60MT8AoCIU0Glk4J3YrbcWu8+/VuWbssXdpd+0IYEnuFhBGDz3RuNuHlrOcD22Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791669865; c=relaxed/simple;
	bh=BYcObbLCaSgU0tk4reE6Oh6GJ9XtFYK/QOHixm1CUkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRMTGCaRgwQMi0lWlh0W/swZI5KRW7HC+/TmL9hFdyIlWTBGuqz2wZhrkfcfWWFJcfmIxBfsvSnvFk8WWWDvY9LTvvmobyOVvaGwWYkHApPFpNKdu/Hw1+n3OgaConTiQs4KJqVZA4zGFK49lW8HgUsjjcPY3dl1JPQKJo1DXrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=p1O8tu+j; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p1O8tu+j"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6776efd4ff1so502592d50.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791669863; cv=none;
        d=google.com; s=arc-20260327;
        b=M0GIeRFrZCmSDZ1z/QxaYHmwP6I/xyoW/+UTvh2+CnPOLmoj/uWL/0Ff3S45j+80AT
         VAQqkpGCcSjXwPaGkXHsejZu6Zo1PT9ZJ5/wYKaZ1G81qEcTcY/hc1cfpdCt+tqGlTDX
         Tk1/9V+JjvpK7gmXQzcmt0oUAPXrrcnnp/t1DhR8EdSBrYxF+YHCvYh6GYobjKf6ThV6
         3VcCmv5GE+5LQQujlrjVc3cQL4sl2ZpcOvx/hmXqj6HECDJfoRAuO5z5JdIqmjhgSeB/
         Rd0B4bI73Ywzm94Rt4xYItqOo3zBvZSsak9NLVXyKBPZJqoE1cII5o9obGupnvaADnR3
         OVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nD84KsrwDgkTBQQV+472E0SUuRjtbi5qncXpaLstElo=;
        fh=ADLn0VFIyqnAX83XpXskF16FsjN062Gim3ArOBa3HRY=;
        b=CNkz+vJ/P3Qg6hpH2iaecik8rELJ6JyDiPMJ1QgltCYazfHSvfnqz2Pxv2+sLk2OfW
         Qs3y/LjH7HRWMCoCoU9WyN96ckwU7D7kARsCsXr9cE+M7ORb/gMzdflnqa8n4vsp8gvR
         07fAoYnYsyaFg+3e6fNY4YggPZOD+64iUnumYYhUwsw8SKjAjyJ3FKgfEVuEEmfEiwSy
         phrPxPsWYWxHM32mutfI/1ziKx9j3Rr85Rorkz1mGbpVxXDJnmA7E3Gym+S6SYIDM7nd
         xL5w4gmGvTNl+RNDoudxZOKv4PiN/Zow4z75aUworA2Exr8/v+8KhmWJjzrlnLdUUu5I
         X5LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791669863; x=1792274663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nD84KsrwDgkTBQQV+472E0SUuRjtbi5qncXpaLstElo=;
        b=p1O8tu+jIHXloojYJcntAerl/63gaJIulBPFm0UByRTVmqXvIAJ8HJtZgddJxFBqIi
         nF5h4mp6dj23uHnsVS36bQjBHKmd63qWW0gad61dzh2TTLSF2ZVGYBUlum3SX3qlgcMk
         SnSFMCyFDXFX+gE2H8Nwej9Va8ZAbGQZticmu7pDJjmsi5cdyGj7HoXT0rtsP3Nx6J92
         ftCPAwnl7vex6uvBvtHwF0VJZaXZghBmode6VuLHv+jgzvB2m0/jCci3hL3LV3tv01Gu
         z2BoKqS1TvFdVFs9zBc4ZLPtlFWwOOAJtqAMFDzc/XkFz+zDHS9S71BOrl8I7dCwR0jP
         Lk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791669863; x=1792274663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nD84KsrwDgkTBQQV+472E0SUuRjtbi5qncXpaLstElo=;
        b=tpDq0EB03vuhYIJ9RaQdk2zeXqlw3JCbEFmeYwV40BwoSmo4FvKlZDMFfAQ+anWnWZ
         UAhQJ6O43g77ZRBvxN0T39bt8fhG1L0g66vpvQ0ixMrwllG34kINHdiA0WpJ300RCi5Q
         YOSUQYSzqjQ1u9X3QzUQ1UYfutzbrJbeavZAAuXwOXBR4l9V5ga+01OvFCLZjIcjTA7O
         ueSOv0oCTfD33rERMPySktLSknYfNvMg9WcMUgfV5NgKB+LJtKzZCxZ94ZDTQYiS+YNZ
         eqzOfBqQAQR+T0pjHIldhDyb4Bip2dUihwtPWssupHBriFhWbK8bxhNt5zqQ7tIon8s5
         +eag==
X-Forwarded-Encrypted: i=1; AKwUvBzubiq7/GA3dEHDXtq6eqQjn3igoLk0+MfuCO9gmrRoTxJNIR95lPCnPSa0JxeZRFCD5FqFr6A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7GvXFNfHI1RVj1TXnYmDjdUkMTpho8cDPt5nKcy0FwdBk1hfB
	O8S2eblhvOzGtBsTQSntAipG4Q+370Yf2h+K4C03NeGPXjm8+nHG8GHo722BE/1NqWqB2OSIHSR
	SQypjD+R578qxZaP80VvkuKP3twI4Fsw=
X-Gm-Gg: AYBFou1ohqbikun+5QQwyK2hZ4dEGf58Mb2SWcBPSutOgf8xMaIyQyQUQKJTDmOckIs
	vWmj5qAzmjuRFeViAbgiLTbBwvC2vtpXqC4omYmO6gUG8gubfd+kazwsm+W7pIdX54wHrfcvtvA
	07B/gmSnTlIAyp7BAVtJy0jd+2+2v1s0Y8p4ICoLzwwr20HbDVE5MXQasATebzrC9y9So/ROPfC
	L9bxLj7ZUQ21C+ua9qTgpIgoBP/QSeO52hg3LMBaJaDj7YyboW/aL0OyJjYT6AkI6KF4SF1So7r
	lBNvergf4GQV7mqmY/griSBz7qH6U+ZdnpVzhMTW3d/ryvyrPCeHViVS2lagYEB3uRgDhf0auZt
	fvoWJQFzMijDEFA==
X-Received: by 2002:a05:690e:1407:b0:679:24b6:fb2f with SMTP id
 956f58d0204a3-6793678c7e0mr2255529d50.12.1791669862784; Sat, 10 Oct 2026
 15:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-2-tanure@linux.com>
In-Reply-To: <20261010105900.247342-2-tanure@linux.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 11 Oct 2026 00:04:12 +0200
X-Gm-Features: AclHuK9eVPsrLu_8xG98kzx45q0ow1wl_zWO8WFmOGBNd_k8l5MABlydeHwbbRI
Message-ID: <CAFBinCAejxmeeHyDy+vMSg6dBm+9prhEo9qZ7FAsiWNB1W-HXw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: net: amlogic,meson-dwmac: list the
 compatible combinations
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas and Conor,

On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> wr=
ote:
[...]
> +          - enum:
> +              - amlogic,meson8b-dwmac
> +              - amlogic,meson-gxbb-dwmac
> +              - amlogic,meson-axg-dwmac
> +              - amlogic,meson-g12a-dwmac
> +          - const: snps,dwmac-3.70a
> +          - const: snps,dwmac
> +      - items:
> +          - enum:
> +              - amlogic,meson6-dwmac
> +              - amlogic,meson8m2-dwmac
Meson8m2 dwmac reports: User ID: 0x10, Synopsys ID: 0x37
In case it helps I can submit a patch to change the Meson8m2 .dtsi to
use "amlogic,meson8m2-dwmac", "snps,dwmac-3.70a", "snps,dwmac" - then
we could move it here too.
That leaves only Meson6 with a single fallback compatible. I don't
have any Meson6 boards, so it'll have to stay that way.


Best regards,
Martin
