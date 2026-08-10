Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3943786F
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386931; cv=pass; b=aqZ9JBgnJwOTWJreDwVUTtpOzH2shZuebLMoQdJY+e2eI6wvlZz7gWbX6BmF98Y00PqOI3uppyeeWXaaUld46MQpNoa7DksNm1RfjI4wScg5qeuPkl2zpr6+5n/iI95Q6dmkafgE90PSxgXrVnwdXoU5C7AaiWVDtKJRAP5n5Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386931; c=relaxed/simple;
	bh=Wox4SmnmHxu/27HeJto1N+/iSgRCWyixQRAgle2phfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsEJggqzpBglusIN9A5lwTKf1o6e+R/iLd4hef4L3XnReJpcb7o/Dufmuwm5aCq4IQe0ds77h16ZeAP6EPtdKi5hCcZpWwaQeKY+g0j1q6VYYdNkr8Rubq7xdKvm595PJioLv8Kv6S8HgVzMztWT7K9ul6ME7cbubc4WoU3OU9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdwJqnQz; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdwJqnQz"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8eeb4508f29so13156126d6.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786386928; cv=none;
        d=google.com; s=arc-20260327;
        b=UEEidYWOntCo4mnLQt/YnVc7szveL2/yz2Fzx1Nm4n6PeAx27jf1O/P3paI4iApvsg
         O2C3UTAz/5wzhzXxf+RIpHJ6F1nU9Hh3hZPcN/e/ETIGUn2nEe2JMvRIZiPuVUH2tBRA
         2/vbdYVsdJNgRXghUVB5he1y4rBGOR1ipu56nE65RfVTANMkXx1f9O0lwYTr+P2/1PNB
         ynL9EF5MTMTJAuKOtqsFEA1VOYybjR9k9VF3UTVf0ZBh9MfwyhUOHX51wFJNteSpv/u3
         YqI6IXhpdQguwKonkEeUIkcwDDmgpne0Of0GRxjtAanXJWRD0bGF0Dpd2WX5fICTxlOB
         81sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wox4SmnmHxu/27HeJto1N+/iSgRCWyixQRAgle2phfY=;
        fh=Lv+9o/gm8Vufjawr2jZJ8s6xaUjCD6jzqwS5G6C63+w=;
        b=NrbIemDMkkkHxh17QJVvIMKgMMjqds69hHusnUpXgHoj3kSSo3X7KCyjjSVPqek2Oz
         bMPNIP/qVCnb1CcgDhzRNNZShHbf4zuAE/eQu0utse22NGrSh6H/LAIZs/IpsseD6nPf
         yCwetXHFjy9FrOxTJc9+oWFWei0IQiLprDjeI9TkIhmykbcFkeQEtDDDLjIc4tvcwqz/
         TR4R6B/f4OdzNwSMZ1UefVQnE0x4xUDe6nO6wUHBgVqMOqMl2dU8wZBhlORgQAYk8W77
         Izej2B5OMZ/LO3O/pRa8Ez/OkKZQyHe07tT7eh8a+UCFTIj8+QsaemRCooYj1cLA8fOp
         5TEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386928; x=1786991728; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wox4SmnmHxu/27HeJto1N+/iSgRCWyixQRAgle2phfY=;
        b=BdwJqnQzfdjkJuHRQDMAJK7OkLiJV4pYTlTDxGNtpP8dpL54QXDtpH0+ryGCmMLk2g
         7CubtdVaqLWPTMtrGRo6xHDJLr9zBJ5k3D3FmXacWA5RFTQ8Yx2GLDhQuL15pgEw4gNB
         DA4un7/FUN7MDL9bgPHK3tScvsv0cKhB9Sfjloohm8yyCWQCRZu34282skjeYbVF7qkJ
         CQUDYO/o0Kzab58xiXSpULObhpR/wSOxP0aNF2L8k9KjW0AK7KKWSrJ7PkAMWFr6CclD
         3Apu6NjSPfUzptQu36GUh892ifzqfeRkcBDOFdTIuu/f2sl3G4t5aVR60l551nJJ8YxP
         4aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386928; x=1786991728;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wox4SmnmHxu/27HeJto1N+/iSgRCWyixQRAgle2phfY=;
        b=BIDAKTXL/h4OYUU9WVInP6Y4yfNdi7B1xbALnsqAtmjQcE2/iY319uPD/TFMl17RKc
         ToAU2qWDZwa1YbTSukGPzfmKsFuGxa8RB/7Ju4P0mtenQwBWBgNfpvm5cHGRVk0/ArW3
         J4wtESOy7NtESzry3wAQh6iH614BI5cz+B7N/sWaBbmZSjxKF7mQXGY0lG+wsjb8tSg4
         sgyxS0VT0rc8PpbsIF3nUhOwuUCZXWtTFLbXBWVEpcR38E8ArETvQxfVZDIVaqutUTAZ
         GSjg8Gvo2CCg0beQuO0NJDY6J2b8R4t0J7Ch1pSeIZ2cQCiURLAt9p9JzuEfCFLjTvrV
         t8Ag==
X-Forwarded-Encrypted: i=1; AHgh+Rqo2jV4RicNBxh6DgQHKoBtCweBAzA7YZ/dptd0QuY+UbgfHDKPu6C3yJ12kct6sp7NSK3Iarg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsf8wxji2hpjUCaIAlDRQOLLFLdHHbcyLRzz99ZZAqq3FiEJ4s
	P68KxxoFlGQKhCQlW9cuj9GzoNYimYiBXuXYU2GNbJ2LoxJGj4ETokkVT9PbNk2XezmokTqvhun
	XyevwL6Aiz7S7iMHDbxQhgHEiBYiN/yF/xw==
X-Gm-Gg: AR+sD12PM4PYZl9llPoa0jpZ+BuOKE+sav//j+X5FFXsv3HPQP1vsRgH4Ds86z9uJ7Y
	q5hVRtC2nO1C/wauKQW5Gz0BV0Ntcp9XO/Yd7B4X0tDKxyyIvxjEDM9IMfMF0+49ddGbE6gWhuo
	aqRV8HoIP6f79bISHvx6BkRtQ8/xBi+7KM4I5zQqJBAk5OpRMIRc7FF36dfKIV0dWHWW13ZLUFQ
	FPJzUFHacxsqBBjViKycuirLNo63DeXV8eTcJSm+DF8dC7e/7kcVr8LpLzUL18+NPxewiWIuJL2
	W9amcd5RN2h+s7sI+XJy/8tjqznu35TQgfoFKrxOrUAO8HANiKal
X-Received: by 2002:a05:6214:529b:b0:8f3:ba0f:e7de with SMTP id
 6a1803df08f44-90a5df77e4emr44190446d6.11.1786386928374; Mon, 10 Aug 2026
 11:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810143740.652804-1-ansuelsmth@gmail.com> <caa0b7dc-7f99-48ca-b65d-5d62c0203045@lunn.ch>
 <20260810113006.25bc0e6a@kernel.org>
In-Reply-To: <20260810113006.25bc0e6a@kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Mon, 10 Aug 2026 20:35:15 +0200
X-Gm-Features: AUfX_mydcuX-iAqb46vgLNHb_3w8r2qK8r0bTPmNGZiQHtvAKztKwrOEkzcxjUY
Message-ID: <CA+_ehUzu=VMRGzBdqU6uG7o7MnyW-3O2=pNxoWbSsqYtruBVqQ@mail.gmail.com>
Subject: Re: [PATCH net-next] MAINTAINERS: add myself as QCA8K maintainer
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 10 ago 2026 alle ore 20:30 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Mon, 10 Aug 2026 16:53:33 +0200 Andrew Lunn wrote:
> > We normally target net for such patches, since users wanting to
> > contact Maintainers are often using older kernels.
>
> Very true. Tho in this specific case we may take it via
> net-next to cheat the patch count numbers in the final PR
> for this release ;)

If we want to increase the count there is the PCS series and
an8855 :) 30+ patch
