Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DA3B6BF1
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380182; cv=pass; b=atliaDfPtpyJ8Wd5pZqWFCuehJnvmbxo6QMhnFxjVX+PilRiXuTXl4suOCdCuR1GBDLaQF1M4z5+VXZUS3FO0NJ6L6jdIIZOsMYM81qOEiRWEg1x5dmjVDAmdOAlrs510rXzyulTnBnOMA3A8wAkkO8XzwW99Eg61A6mrup+qBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380182; c=relaxed/simple;
	bh=X8UYCgmRSd/S74rBcA7BLikNmBhdmEtIgctQKY56qBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEqurutK4wekn+jSeCGwinq31s6mHB1vnv7uJPB+AthaOSjrSOZRFeeRV3UdaKga1Yxgo/y2ZxxkFbPWDf2Ca0sQXB/6011Aq18kcvvJ2g6n+HALDe4rCdI2fRoS8xJadoH6YidPCfadvTBotqIPmE8HBlKtt9feHZ9pigASI90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey8dGutF; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey8dGutF"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso229267166b.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792380179; cv=none;
        d=google.com; s=arc-20260327;
        b=ewx2cy3NAUDOPrV4YGMFd3llBUVGBmm5Q8iz91UiKJ+glH27+AKzoQ5MC/xO3Vj3ac
         dhpttLd0IC1SNM5n/rDmhXwf1QpWBjVqhbDrGme0/Lyyo8G7ueEuNDwR4f7tYxWdTt6W
         yPd1bzv9UrlQkmjBSEtAYwDlevysivO1lY6LfR4xT60FkbtzT0AZ03AeKP+MDFxtg7Oc
         Q/qfMEKJuIckl+ig72nLEHRyOZ9YBaoRFDtwQMJljT3CcgIcNo4VxCQl9UhVpkxkCvub
         gFxVCSs1XDETcefZx92hY4nroS0F4JHnig1be429E+0xSxbQpK/rh7/PqZ8IYtDoHapV
         /Hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X8UYCgmRSd/S74rBcA7BLikNmBhdmEtIgctQKY56qBY=;
        fh=WaNhqF1NVaVbe31szC6fIxoMt1u4Y2sQLJoRiC4wrJo=;
        b=kJbiXVFLd1o1CiaUVtIOBLNn64I2VKa4w9LFPlqLazS56txRnPyzkJqqng0d/8eGfB
         GxUNu5rpWmRSLg2zbhPUj8EeE6Rv4yC707evgTsuYFhkfuw9bwBYLDsCNwXGWsMw63+V
         yc5lP7pLkhOfg/eEXFjn0j+C4UOLjJRF5OSxdfulwB6/ljz6x8T9GXGrII8nZHfXJ3rn
         VjulrXOgjd/mBEMSKyqgQNnTe+4u0PIe3n6EerrQVdm8sNShAaU4mqFFXd11wKmbf6oB
         JW9VHekBOKhAGhogOU1Wfu7ZuSJnIg+/yc969TV31Ef6d+jVT5UAGyHBUb2fkM1HGd7A
         7sfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380179; x=1792984979; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8UYCgmRSd/S74rBcA7BLikNmBhdmEtIgctQKY56qBY=;
        b=ey8dGutFhlYGuCzOB8nsogdpcAKhYJuVI9R41VUjSS+T2ZCEO0wAhQanXLt+JpFqbj
         c73P+yiJLoyVW738WTfP/Xq5rtuRkdXekrnqCF47OhumfCpbCzzsevOvUTHnSgtu7lLY
         Mqn0N0NbXupX0HZUtLYOyKt+86IFfHbwwkKIUnNzhHyVeMpRrVVtqTwu1OjJohqgOifJ
         QMYiQnEvg0seDpdhHL7j5bkxBC3K7ONv5hvZ9Krj/ZNmsS/10q8Tb7EkIGDm4HCBl6p3
         I2bx18kXIuEwxNwLCYkXtnHTmjsPg8JrTCM1d7I7I9cIB6jmBJVGhjGVQXa9hdq0fpa8
         cV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380179; x=1792984979;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X8UYCgmRSd/S74rBcA7BLikNmBhdmEtIgctQKY56qBY=;
        b=tBbNOgz+Ydo+LRAplDwnyCEPWm2EnD5OzUU+JmfuNcp4laquWzidZWpeLXiARSFNck
         76mARDn/E1g8Gqlx5SIAV94R66IOab7TR9zY/2xBcJfl+rC465qE6KkxqsFThjwSusp5
         wrDbDwi13r75YtxULM4jYVYS+i9CvoFZVKVlCs0J1CRQQFhHoFU6YHXMk0qlmZuw5Hil
         5voe8hE02P8zKEVI+Il5bei0fqRJ1WNjVHVwoKlof9NgdS5vrmXDhjI79qQ9f9CAsu4x
         m2/cclJLHqsZf9UkigPsHWXfJXx49qSD5kGIxbBsQrqBVkBUOeVnGurWjromdzrni0iF
         k/Ug==
X-Forwarded-Encrypted: i=1; AKwUvBytw6OI2f1RgmkzfxizoN0o4/edgx/JISawZk/T8LpH5Qt3O8Y/RQTZiSEo7/UMrSi54m4w0KE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI2W+ArT2BcM504Y/04DXkcu1IhSKqOPN6z/6ISgUk67/2OTPK
	CI3/MP7Nr/cgkfz/GCAbGqc+gcb/LO1wOn++xISpNUASQM3JBcLq8rnEzewrbRrn9Z9dXOCaDeh
	AaMvGIfF2fPAxaFaMs5w1807gO5etg/oscCDSf0ZIJQ==
X-Gm-Gg: AYBFou0dFDATyVtrjvY2AeEiz+y+hT/b3gM5FlkhrUuYn30ozWykKicFO4EouDh1Zge
	FPOEw1H1PN+9zB5ji81nOdaqBT07BMHRGO9zTN8mHN6Nn3rLAKOdKifpX9iFNjvhKVkfchvUii0
	UsH1GFLzUAn1ScF1A7OPAHskEW/KLTI8PNRughxcZIJmyCewYYxH2mGepz4AYdrFaUxhaT/J/GR
	Ztm2XTsqAq9v24YkngHGJyOuKA4jj8WSV8CXvQcopa6gjvVwM24L8gwCSv9LL7TnL/blxquk8zL
	jLOP3cdraq0nZe9xHBIs5kT+St8qyaJEWifJPddnZLQUoKjOk4pKCDAIO5GyxEsBUBoNHoZYUTc
	8kDYmwZWEdAKEfEXZbPUCfw==
X-Received: by 2002:a17:906:c103:b0:c2e:3b23:1468 with SMTP id
 a640c23a62f3a-c41a0cd2aa0mr418234366b.48.1792380178629; Sun, 18 Oct 2026
 20:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-6-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-6-o.rempel@pengutronix.de>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Oct 2026 00:22:46 -0300
X-Gm-Features: AclHuK98fG096I_kHqarkQnfuU-ZnCrJiV3Y7LamgWacbZNZdujtbnhCv-KJfjw
Message-ID: <CAJq09z7+1abRR2qetn-_Cd9sZUuiNKpLA1yaP-XdBC7GDepifg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 5/8] net: dsa: realtek: rtl8365mb: store the
 egress queue count per chip
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Store the number of egress queues in the per-chip info structure and
> advertise it through ds->num_tx_queues, following the ksz driver
> (struct ksz_chip_data.num_tx_queues).
>
> The queue count is a per-chip hardware property, and this driver supports
> several chips of the rtl8367c family. All currently-supported chips expose
> eight queues, but keeping the count in chip_info lets the QoS code that
> follows program the priority-to-queue map via the ieee8021q helpers for
> whatever queue count a chip carries, so the 802.1Q collapse is correct
> rather than hard-coded to eight.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
