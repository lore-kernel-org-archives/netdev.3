Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727D37A847
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194695; cv=pass; b=l1Koku30o5wRPSndX/vPWjUwS0X/4F9hZI3RqSN9QOyysVueI5xeBVzfPKVf6apifzHk++5BE9Mht53WYSysqk5/KIUcQDjclC7b6flFrnbsCzelJcX6Dh/r2JoJDML+rv9smSET90Amkbw95fm0j/CdReTjFYNJe4q0zn7XtJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194695; c=relaxed/simple;
	bh=yRNnhU3+AjyWGZ4kdhDStl0Ap1HuxD+DVwZzVfpOulc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2lAqmlOMkt1blaSd3TrIgH/iJJpY5xug6RWxN0Aw0+OxjrX+5dx82c+iqcS5qLDgUQ8uS3/bOJm8F3Kk7pIhRRbEKb9xRfg/2gInNP0jXIf2+hLcwyGUH9VkCTmg3DFoukGrNqMyAOsgTwnvjPKLpIaT0iNbAicg6zm/+8QbYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qj1i9LAK; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj1i9LAK"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-495efdede87so211448b6e.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194693; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2QgtcCp7gZofUXHgvDleTQABHnRO2ewzIPtgxzOvtRbc5bj6677bllBYamIEd3ZOL
         Sf3jMY/X2OKvIIhRCQ8b8Ou2b3uTKSERzLelYBoRUmx1Oy8s05dpnoxhTXdykqS3U4HA
         73StEE3t+QHpyi+Ji4Hs5onJzoWquzljutt48Us/MLTgCGh8p4n0ht/2PEmzEn0ApMZ8
         Zv9GEn2Hpx/XuvXlk/a+acovV6OFtAir+EidwBg45jpdJhrzTIL3QvYbKFoHq0cUPL0U
         Zda+g7uDCcEYbPxzA+UGCSSb5PEdDCv10uPf2pKn4CQXQKQvISVrhQcgQQLBSGRabUUm
         ZKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRNnhU3+AjyWGZ4kdhDStl0Ap1HuxD+DVwZzVfpOulc=;
        fh=ABOEaUU2RkMynEI6HYGDAsHEr0MA7h4sLoP9dUdqomU=;
        b=XXzpLgqqwgQCRtwbMAS4WAx2VkDrJbSMBRyOWSL1g36vvB2h2mhGnhR/t7eU0zr7dc
         cJFXhxKzcq68Y+n0EmD+r3FD3qVxT0A+MPBFQUI/s3ZaOmU4RhunkCeF64lkmFsgjU6v
         139CEa3QjSjR+8fDUsVetNHUG80R6sFL8jpujvdbHlBXxmXrnLHQq1up7Hp9f/VBucry
         MgH1c2Qtd/9jGz3Ugc3MTg+GVhzrrWiiMnF+e6YiXmYTavkz3NlJOm/eIWNBWch+s/hn
         KmK1YjgdkDvenpb6DATrs1rAAWgVsWNsZlgaFep1xYg/09hAndkAv7tKsstOY+7B2C02
         Skvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785194693; x=1785799493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRNnhU3+AjyWGZ4kdhDStl0Ap1HuxD+DVwZzVfpOulc=;
        b=qj1i9LAKe4ge1KStwtC2r14+xgQKC9+Y6jF31386UcuvjEIGbQw5lPfgsmEA/q1bOQ
         HERxnKeSNA5Cd0drqmzFqUaepoC4qrwC9KBGVd52BnsH+DfwTGDCK3mcjfsBUK+bWHlx
         5BPk+N2akqIB/C9zKLft4nCBWDPOPAVCHU2b6/98avivFD/eL0EZJXZ1pNEgqeO68ai7
         KiBUP5+eIQgOcY4SroN8gP5IAK9oam4KzQCpKlHeBKa7TNzmlQ8wEiSBUtTsAaN8zV02
         /jbS5drZ4lg/3BoymLjmu/egmGfP/HtCNtRpwbdCodBpWVITrW9bbS913tormal9tXlo
         rr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194693; x=1785799493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRNnhU3+AjyWGZ4kdhDStl0Ap1HuxD+DVwZzVfpOulc=;
        b=WR/7e3dYMDtRFXlig2alslGvomIyx7h23hAESI7Q4zj0JPmoinA8EcYtOQWJnAWQ0O
         sntGAOSIC7eknHG7WXUo+kI2lUcJq0tZpnAz0poLAUKdUsfl/PvLBzQKRCSgADlvWIg/
         nca/yaQ/nCHGDbuvgXwGUkotrnZzFUs6Kj00JICG/YlHUwRmCnKzaaWn1cdZM7+8SIlC
         /RFRetD+l4/Mu+rLLyutkyPizG2k9P9+Tcz0uBHqvYe/5OGrbcih1SPw4FWy/hNlrMmq
         7JhZy5s1Iume5V9/eJJzgEv1hLYo+5BGIdjRe/stIYAMBSqJ84A3RnQgTAXL4vvv2sM5
         kwUg==
X-Forwarded-Encrypted: i=1; AHgh+RrZYOF0cCwIdXASkeV5cYf44Z66kKnGCIEkukesU6zJQ7qA/kXe5pf9QM5tigHzHkL6iu3KwpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyllHhYKDigkqDyqX28/5TNz8is2LvbrIorxYNobGCtipxyr/gm
	1eBSs0iZFvm5onFblWyuFzofRc1omrUlSJnyyBXo3SQXIXXqTORrrhz03lc4Y5uFT30v5yv2S+8
	YFI5yo0nQgnZGsc706/FMcIjYDl7d+Zw=
X-Gm-Gg: AR+sD10mEImLNnDKITnKATnkw8Joaikt0OP82u5ROZ7rWuhWM3/a1196g1H/U1jd7n9
	u5Rt16MHRMoMGh2aBQZMa4UED5M4CgnTIzqB0QQn/cleoNFDYvJ3FbQl1yamU/sz4qMgi3nSbVe
	xBQSDo7nQuRd4dM62PPLEHHHbOxGcGAuX5L3DI0nK6tXRpM2Sm2FKzoori73udXN0AWQC12ErnB
	Le95mNh5zeFEySrpsx9g20JPXdp/22yDIDDUB7v8rbgemFs8zUBUMD98MMhtllIZcrq4/Ude7am
	vQ==
X-Received: by 2002:a05:6808:2512:b0:4ab:3192:70bc with SMTP id
 5614622812f47-4ad52f5610amr1451713b6e.5.1785194692992; Mon, 27 Jul 2026
 16:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-1-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-1-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 28 Jul 2026 00:24:41 +0100
X-Gm-Features: AUfX_mxMCFDG4aETfQfgugzJVj94VJUgLbN_hSnn-SHja1w9mh25TcQw2lfVogA
Message-ID: <CAGSyskVLJShtgSkUk+iyHXaxA5aR__068NVCSqBrxJpijjSchw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] netpoll: export carrier_timeout via netpoll_get_carrier_timeout()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> netpoll_wait_carrier() is only used in netconsole, and it will move to
> netconsole.
>
> The carrier_timeout module parameter has to stay in netpoll so the
> existing netpoll.carrier_timeout kernel parameter keeps working for
> current users, and we don't break user compatibility.
>
> Add a netpoll_get_carrier_timeout() accessor and export it so netconsole
> can read the value once the carrier wait lives there. Drop the now
> redundant timeout argument from netpoll_wait_carrier() (its only caller
> passed carrier_timeout) and read the parameter directly while the helper
> still lives here.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
