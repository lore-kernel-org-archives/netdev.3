Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7041F5ED
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469671; cv=pass; b=tcMnH3w5ztwB/GqPFmMO0ZeTWCrSS1mdyStyn7bdk1iKiReyNavrAVoBhxPr3Yku0k8a6O7ZZ6MFdHmJPRXN418O5JKNXs1Sgdkrlh3QU3iVdNwPRqUrAyaeDUEr164v4VDmymQ7zjgq282NsTz4p3awOCeA3z7VP9aA76l/eTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469671; c=relaxed/simple;
	bh=tnkWXtTOxroBqg2brq9AdO3L8QlGxs6b1NY/Q/BKuwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmKREql3/AH/7gkH+nf+I0TbBD4iRaX5ig11NQKYjvGAYkdsT4N5nZusFTYqTB2ZEpA8HRC+zvynwWmbKFjyB2q7lSyoZ3Z4+oyIEdinW9YvvNJPl4SRftz9YvRkj4NTUMc4eXHJVTcaCHhjPmcUv8aOjB1JFrfNLD/6OlUKSe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTYVwamf; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTYVwamf"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-459281bc13bso1918400fac.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 10:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469668; cv=none;
        d=google.com; s=arc-20260327;
        b=K0dX43X1oE1e7ePzQsmgrODudVtdOjdFLiWUh9H3iQRYrBz1Prsb5JajyDf41Xkwp8
         5Kek4BT7h7VUK8dnoL6lZqac/HWQsB1kdvcYVp1OYYVYCxLc+3jezGlAEq1/kw5YL7xO
         tD/2qknP8AVmtr2Chh3VmlbBbOmR5Q2Kh2QMjrwyckGMy0wqqbRD0PVx2XpMURmYmWaK
         daMsF74pzErCbJKc1KgA0tRRKwEIThbNTVuLFqd0s1IiA/qTIl9hzKYdXW2CY6ZoAQ8U
         PsB6mT+saizuadzfMhUgk+UhRgH108Rx0qubnXWzzXWaV30jMlAdsKW6J0d/rI1cXrY1
         BgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tnkWXtTOxroBqg2brq9AdO3L8QlGxs6b1NY/Q/BKuwU=;
        fh=Y0PDYh+rGrFAKI85JTjQ2T8ROZCNRywqMWoA2YX4txs=;
        b=U59Ab6np1vg7ETNObx/VM2mnHNDN/l0izuzaydXPN+cRVwII2KOs3a6EI5/47ChX9b
         ex4kVl4XzBrVwT28nsS++nFBerJiOCC6gD2nyXccM5Wi2yo7+VtACLhq6pbz6K04nNR6
         nWs2dQj2b6P/X00ng5dv+dd6Tcdyw3DXyhBKblMx4nRd2h44Cb3ncY0zetNtMoh1vkiI
         4585A0YrgdLasGcPB/ssYQtzQ73Vy+IBCZAJMoCJgIYtEair2L73aM0Po8xjgcPxc3pQ
         UI+YuTsDvi7JrAx+95u0zyUf11QVDExD7T6J2lwz+hcvFTosA+zGvKZOTchSBAzN/SwS
         id3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469668; x=1787074468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tnkWXtTOxroBqg2brq9AdO3L8QlGxs6b1NY/Q/BKuwU=;
        b=UTYVwamf0HxgbyOraQ4hgqAcYs9Yc9/8PYBSAmijsyqFWuyDprwIgk0UE2dpcks8xE
         E3/vZUZEdcyqJV3DqvBGZTJdsXvld+PA35cqURUNEYVw64ArgEU3yrTWZkveBMh3nqlH
         +D7w2D2QliYIM7X4ir9/9w4on3rTm6y+hWw13ziczO4i7jNmNbv0BLf3df6zmy0myq0r
         jW+q86+I5sjr92FAcwBzRE2u7kQtji3ZD0F1QuDGt9vtnQVG3dNN6FhNgRZLebvr/s8X
         W8dU7HR8+l60OWh6xWemf+HMY5LPGZoAE/Moxt2Bwm8PcNX96rgEYI1lDwpDRRDi0nx1
         Wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469668; x=1787074468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnkWXtTOxroBqg2brq9AdO3L8QlGxs6b1NY/Q/BKuwU=;
        b=iBU03C02WsrDTBU+IDTzY09PEbNvv+sk5iLNGiEPSxWOC7nYZjfTcjKRqCb5ry7njJ
         /CkD8DUfVhHUriD30swjl97v6iWDjV+X2MsQrRoz5f34018vfAbLiP4jQERZgSoxgFRK
         tpdzz2/pfsz4irjv+hD60B+0rGNW5OyFqF9lp7oPDpbQZh8MDljtXRRyijYn8UoV6q7k
         7rDAjkiLZFOMuX8e19O6YIckLK0vOt7XNEnd7cLOFf3NhUhev5HPUS4eu51OKWVxKLYK
         ddcZAjA+k2PuJxS22H5F2ZGmmahaGAOKLicjXF38eZlKEo0NyOHtPo82YmqfvJ4ELuXr
         6sAg==
X-Forwarded-Encrypted: i=1; AHgh+Rphdg3Iv+KTifeowiE7NPhndg8fL11guU/FOkla8GS78ZVjzfsGiSaJCl2Ry6nF7NNWExvNo9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3sipln8Cg+rLfewiAzuWO8yT6ZUcW32ocr+Gzc0dx8zM1yyy
	4fDVUaD+l9IBC7Wsfb7IR4Xe6r+7pP7+V6sqmUuCiTo1Vc250QEfGx7VyGZYGribDEX1vZm6iyY
	RYz/kKcPDQAXFGer6Y5cS3Dg7n1iZlJ0=
X-Gm-Gg: AR+sD11rMaYP9+akR/y1LpBALURLovooACni9JQQ/c14Uj629BwYTWt7AshCROnCyx9
	DteVxJvVNbbKZbBYZvHVCbmE72m9AWUFjFzpW+OnNZqKv+CsXxUf9KdjC+d813MxuFI9J5dCRzA
	fA785zOawQuQsTLzvHR/A69JCpHs7qU8HaYE3c3FiBUpXlW3KgrnQq9pw8C2D3giyLO8i1XfVLl
	JUetASJQP7gqyc+t9rwLbXtofNfh3lOBxWiM+rRFmWkB4w/1bdh+I7ilc2yZGSupBViZvkfIUGN
	cfIhupaSzPdpZumD7HnWr09LqNYcqwFFDBsyhE68jc7tsw==
X-Received: by 2002:a05:6870:ac96:b0:417:4888:328b with SMTP id
 586e51a60fabf-45e216b92camr3614027fac.20.1786469667774; Tue, 11 Aug 2026
 10:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-2-admiyo@os.amperecomputing.com> <7089dd34-18e3-4b84-a01e-361a4ce6cc43@amperemail.onmicrosoft.com>
In-Reply-To: <7089dd34-18e3-4b84-a01e-361a4ce6cc43@amperemail.onmicrosoft.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 11 Aug 2026 10:34:15 -0700
X-Gm-Features: AUfX_mzPlm-WvccCq2EA5quLqPvF8UaSr7_mraA5EsGjloTJ9JE3Kh6bssjcOpE
Message-ID: <CABb+yY1R7E8WTv9wHMqu1JSA9p8oQXavncNLi7m0bWH52h68tA@mail.gmail.com>
Subject: Re: [PATCH v45 1/7] mailbox/pcc.c: shmem map/unmap startup/teardown
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Huisong Li <lihuisong@huawei.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:59=E2=80=AFAM Adam Young
<admiyo@amperemail.onmicrosoft.com> wrote:
>
>
> This will have to be rebased on the changes to the base PCC layer,
> specifically to add the signature check.
>
At this point I would think you have Sudeep's ack on this change to the cod=
e?

Regards,
Jassi
