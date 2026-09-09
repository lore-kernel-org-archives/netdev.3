Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F63552940
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957033; cv=none; b=P53HiFxzaBMSuhcYUXYL1VAM7a6NxXlFDQ4uVcIR9CmhUADOHQTd4wRL3xa8Kw9oaZrAGX19mcfHzbjO5fAgkHLm0iP7c7qVyt9WLGG9gcYs2a2m7luqY44FAV+FyjnDzgM2UzGwTw0ot1iyDL+a7slMKNVH55Rqvp1poSlBPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957033; c=relaxed/simple;
	bh=Q62aGpTiVW4XYJsbDvrAMc7X+wDBqwqw18bgdCN/+iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9QbGCvCOYEtqiGTEJXWEbE9KP1KA0rXVmgLX795kvlx4aQurdIzBiEaTZZMo6Cpe2Tr7HcpNS7GqR7eHTAb/B5YSi5ec7WB6Iuj8qWxebuVgUDY6smGq47M2Q/dQ2dSb692N44R+leWknSrhQzx6RVYkehIgXiKq0eXvap19Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SohZv6HJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SohZv6HJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A537D1F00ACF
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957031;
	bh=Q62aGpTiVW4XYJsbDvrAMc7X+wDBqwqw18bgdCN/+iI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SohZv6HJiX1RLYidT1ogBnh4p5p9+OBT0nOEij5d+C8G3Ns1GEVINNOmN3X21EZIR
	 b59O9XFgfiKEO9KPznp4H1uPCka5ibaCGE/ygkCB6XHyhHj+kB6ISKuG28I+PGZ+Hn
	 COhO0sUSdMj+oZpLFapa6ttumyf2BkpnosvNgKW7lmYRLja2aqNBJORHvSjbT0mBeQ
	 M3Y76XpUPtRAhKA0JSKmENSrb9StwZTncHxSgBE3MllDL1xnNpEhSyF2dg6uzQsPbP
	 ezCEp93PAqF/h0lV+SntSX64gp0KoDYkVQn4W5SbI1WmJuxxFc+bl2gyEe9Nlt1fwS
	 frcLq9+QorrlA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46aef784ddcso2241138fac.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:30:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBycqh9OA3tXD/5aqInEVXy30jxwb4FmRHRkbGt93vNLdfVZ18DR/PCg7YLdz88HqeO6S+jkoMY=@vger.kernel.org
X-Gm-Message-State: AFuF++kyAP/78jYQ3kPz0i0RekYQhC1LjiPsy6KxW9Ctei2EfYXBJCgs
	O6bStUrw3kOKz1NmrrRC2mXq+6eBl43prD5tbfM7DcBHJJsUQ2N7UBqhgPdzZoXs/+CEj39C7VY
	iEqsM72OA+yaz9stqimtW247m+TSAN90=
X-Received: by 2002:a05:6870:450d:b0:43c:44c9:b87e with SMTP id
 586e51a60fabf-47550f21cedmr22056135fac.3.1788957031012; Wed, 09 Sep 2026
 05:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909120825.33350-1-kuncy7@gmail.com>
In-Reply-To: <20260909120825.33350-1-kuncy7@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 9 Sep 2026 14:30:13 +0200
X-Gmail-Original-Message-ID: <CAD++jLm4KOheiTFeJsBNABap4vMa3NhfYaX-rWAiNs5VRTOJOA@mail.gmail.com>
X-Gm-Features: AcwNN1W2DYoIkPvzSX0TVbttuF3jrcW8F65nUfzdcQual4KBLp4XXAbykoWfifQ
Message-ID: <CAD++jLm4KOheiTFeJsBNABap4vMa3NhfYaX-rWAiNs5VRTOJOA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dsa: realtek: rtl8365mb: wait out the
 full chip reset time
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 2:08=E2=80=AFPM Stanislaw Pal <kuncy7@gmail.com> wro=
te:

> Realtek documentation gives the chip 1 second to reset, and the driver
> says so in a comment, but it only sleeps 100 ms and then polls the reset
> bit and continues as soon as that bit clears. The bit reports that the
> register block is back, not that the chip has finished its internal
> bring-up: Luiz notes that older parts such as the RTL8367R need
> noticeable extra time after it clears, so a driver that keys off the bit
> alone is relying on that margin being zero.
>
> Sleep out the documented second before touching anything, then read the
> bit once and fail with -ETIMEDOUT if the chip has not come out of reset.
>
> Probe therefore takes 1 s on every chip the driver supports, not only on
> the part this was found on.
>
> Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
(...)
> I have deliberately not carried Linus's Reviewed-by from v2, since this
> revision replaces the implementation he reviewed.

OK this works too, I was too quick in endorsing the hairy microoptimization=
.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
