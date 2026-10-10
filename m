Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648ED38B158
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672055; cv=pass; b=OnXfD8vFN2uxBwMmJ7guVgwAeSw4JgA4l7rKUdD+kFDFZDyYINJWEbhpv9cp5ibI+dz1Y5CIZ8NojG8Poi5uoNjFkN6gL6PAiQ++OWN4Lpdm5hGHYh0TfKtmjOFNsF9ua2OK4cx9rxDGZWsHZ14RZEzAahB+wUJqtFUPqkdy55g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672055; c=relaxed/simple;
	bh=6mEGm2u4SySep02ssBb6cSOg0RdAq/up2Jup45p2V48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVT8Wt+CleTf0vwWupfKJD5Nbo4TovFnB99LTyP+a+0tWmAtFv+jN+UkWR7Uv+sxwrSSERUTakH28f8tPhf2ds5kjqS4X7gK8E1iFmIA4H9v4Lr33YpAOY3yPZliCoNXrAx9WQDSnf1n/9O/+sik1+f/QmOF2cDmYIZo9lMRv+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hTbDXvB+; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hTbDXvB+"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6793ff3d53dso520594d50.2
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791672053; cv=none;
        d=google.com; s=arc-20260327;
        b=AWXQYVqMEs9dvYJ9R59cpQMlCHZ+KdEFBKe2MCsoS3JyR/DWAwI5tfrAZy4pPl4ay3
         eQOOlZpYRhymvVh6i4dcU7VN+6T6C6tJkk3cZmjAkF4AMOxV5RjvkYkADIodDVj/Yvxo
         c7JGK9yPScN3OBypisn8u7slYihClHeSnk+razsFYVXyv58Z0XF+DRXgwbtm9QeDheYW
         UmuJSPFVVLtEPyG4KNzRVzAo0Ec2JRzDPYKBvMT/SwVtyyP/h85zzhqlR+5oH3O6rM+O
         gzkprD7jMCq2/eLT9+koGqyQKTCQn3WvZjkk27lXINZ282CIHTwl8xkTZsR3DdCmyz4M
         rOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6mEGm2u4SySep02ssBb6cSOg0RdAq/up2Jup45p2V48=;
        fh=K+LRXeOunBi+2aEUULneAJgowTe3VZ9y1BEYzyqZcOY=;
        b=rw2+vUEWfbQVnVcCZmBgYsFnk/jMhOKf2uGI0v6GkEw5xQ/BLRo0xpQmDU5XzBm4eu
         5N6sUx4mEu/kODndVmovZiq11O/9bCWzdMacdVv6iXvspjyWioCEHAkcPk2JX3RmQ+uY
         rRkYapfivrbdKR6yS9lIDLRPpSKpAdYnewO3szjFNGCkjzRwdtWW8biLit1+JYXjZkhq
         1MMs5rXxFLRXZA+n7d/Q8sHpUlBpMOyJZFZsAaUOocI0bsbifLv0YURx9zh9YWE5R6/a
         7I12HsLOCXHeZZOpjhIE4Kmv782l3j3f9M1tdggcRxAG5AvZLWVkQhbmJu96N+0SHd0s
         txZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791672053; x=1792276853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6mEGm2u4SySep02ssBb6cSOg0RdAq/up2Jup45p2V48=;
        b=hTbDXvB+EroO1FpSn6zCPJhCbP3gFD8tCYQk6spnV04sD8P4ZB7CnAeyHnUWZY0brJ
         CCNyb+U8INcbxlctmvPP1Fbl6QShI5MLkUeZ7ilq1+Jm4jcXWXweJogVeYRJSMVH9vWA
         6dswFz9Har+uvJBV1NG4SDnf1ChzqAbMIrT01MvyOVt9oHrK+a8hpJrwsTYwlyT7kJ0Z
         lnUnFgGmqCa2VjrIWZtdwTu1iBtDOlq8hs6gQKKLJvIZwGEadEyALFWyPsZLUHEkVy/S
         9g2uf/C6Gaz288AxUS6rajoAcKVRYGRoFwC2bcKY+B90XfYhiOR+R7KRCrnNubF6KV6Y
         pqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791672053; x=1792276853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6mEGm2u4SySep02ssBb6cSOg0RdAq/up2Jup45p2V48=;
        b=Hg3T4KY6hJ8/6UMPr6QXOmSUIRlPeymyBmmyfbIdDO86MrrUT17nQRp42f7OAM+GOm
         7cPgChfTEK4K1x9miS2+dpwA7gBj6G/SfUUtUujR0LZWL6akci6JqeGVLOKOJ6w6bS5P
         6SGVATgL8WTgxxOY27C4EiyurrL8rfsKMURkeqCUIfRw0UYefKOfEAsG0EZnSeDJ0UmQ
         3GpHx4ZAWgBqvi9hQURYr17fwcPz+RLWF9Bx8lYsc6piHITWZnMCk/HFJT+q0MjHW+3m
         WD2g2nmM4VWMHDuFexiLLA8+asQOxDcvBBwQ70lpqZz8UBTHF5JJ/ZoPqaJ0hRZGPz5S
         hYcQ==
X-Forwarded-Encrypted: i=1; AKwUvByN8tHBdTshV7YuYUFAZ5Vx5N/oLGk6LSUvLkiag5IY+SQf+v3kO0S0H34VYGrY1U16AqRbA9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPtc/vuWnk5UqUNAk7aW0ZYyJCKiZRTFXK5IqKQeLvE+Pjvk9r
	E3b8IggAonKJTz53DSOMxjFIX/7+JUUuNrByBCpN8iyIaUGpeBGuphTW4TcAZdCzrvPj4q9vbT9
	unuR0yXkX9EbhzKRynQ9FpBDRBx50V3U=
X-Gm-Gg: AYBFou1E+do+6zZJa3p32K2X5sAIr1JBB/QHgukjV/i0GiEsrr4l9zspuzqE1vF+FEt
	y84mGONQ8ERnq3lITvU3XdAZQIOUw7BV/+GA4IYXXywvqNDotaxF0uCVbY6j8Lhk6dz3fHIdaPR
	fskefkuiAZc6htN8ZIefVAQNKxtsz16Flhsfr4k6FR6s0SlR9DexcF3dODrejjpk8uuD9mlpdAk
	VQiuPUHRlfUzHXiVKM+qwZuhIgwoMl5YsFY7urEHO9rx4+Drzj1DMy4WFEOlmNfPqgy/+VdkDtN
	pxXZVyS4jcx1jbNUbrLgbROVS2q7BSMj3IoLHn5z7a7OWQPEJ1iceKNQf9MIrILdHspzQidh+La
	3YJolCu0YpNkK
X-Received: by 2002:a05:690e:12cf:b0:667:e855:ecdb with SMTP id
 956f58d0204a3-67935edbdd4mr1914994d50.3.1791672053242; Sat, 10 Oct 2026
 15:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-4-tanure@linux.com>
In-Reply-To: <20261010105900.247342-4-tanure@linux.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 11 Oct 2026 00:40:42 +0200
X-Gm-Features: AclHuK8sus9eXHW8D0kCsjiICdQbyK-pql4xQRfUyDiKVkCN64EjzyryJR6PDrA
Message-ID: <CAFBinCCaAT8+YjSwg0=aFF8mbN=j-MQ=oWvfwUakVE8O-eu93Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] net: stmmac: dwmac-meson8b: add support for the
 Amlogic T7
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
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> wr=
ote:
>
> The glue registers on the T7 are laid out exactly as the G12A ones, RX
> delay field included, so the T7 can reuse the G12A settings.
>
> What it does not share is how the controller reaches memory. That path
> runs through a pipeline stage with a gate of its own, and no other
> device has any use for that gate. Nothing claims it, so it is switched
> off as unused and a transfer that has started can never finish.
>
> Without that gate the controller cannot do DMA at all, so it is
> required rather than optional: a clear probe failure beats an
> undiagnosable hang later.
>
> Assisted-by: LLM
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Lucas Tanure <tanure@linux.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
