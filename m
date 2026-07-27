Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1F037A48A
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155196; cv=none; b=InKrKfXsTyHeFR/wOB4/4TvKe1w9KtgviH723QbtO1tzgtpZwknMhzKqOVMwRH6QJ3+0awG3iQPCncpeT6/d/ZNfymfktcJLYiwxmWvv+mtSKbqXnthlOt3caUKBNelPPHx/4cnsjnIdkagXP6KOvtqsxq5uR85uZEd6mCHljx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155196; c=relaxed/simple;
	bh=4e0rDlWWcckfXYAf8PLxJzabzDYjuD1wfzoXVrVetsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfckP2e1KJnayaCX3skh4haUW7eZU203cStrN3i5NzGycgwG8wazIRnCNjDbF5HisxHncrEhSB6DhiYX/b+j5dqg0N8476f8CXzS6rig3Tpmb+jE62fvYQl799w7VIuulWpzXlcOPpyCzhYNheaTpapben1JroiPHKmY3whczkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSiA8RUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSiA8RUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99C21F00A3E
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785155195;
	bh=4e0rDlWWcckfXYAf8PLxJzabzDYjuD1wfzoXVrVetsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OSiA8RUtQNepL63bvCf6h3IzGOMjml0PJFDVgnRk6ZmnCB0Xhn38VeMeK/Cxl2vrZ
	 rNJIocn0dZS5h2F98Zth3BsLReVDAy2rZxvL3+6hEsOohpj+Zlzd62H7V+qSWBOtzL
	 9Gu4EfpGYiwBjlFgmaPfDl2tR10rtssr1N9w9FBMta9IaS4hKwSCLxuKEFEl6XpaPR
	 zdPHk3RV9GrOZnZz4WuQnr9IV8T9RmlaOJd5D9o0F8UFLDyDKIsqgeyXhTTKb6tbIr
	 th+28mX+9S68EXdmFOA0x5ixRLltM4STs/TL3IbUJC6rQrhMgPhTWfvzQUVcK2+OSG
	 lWNdqxyRn66tQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aea0fff535so2836377e87.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:26:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqYIisLT90rEJ7UtWMo5qTJzDj/ouB6iAN5F9eO9RwnA+H/DJQZ9IEPVUQ7C/FvncN8E2osaPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRCEk+KUYri38BAowe7TMA8PGDObbhXCMUNBJT9O2aFRa+sWw
	5lUtcKxFpurLeWZ31LzI2sPi79bkDPzJV/QDGUP5sj8bzO2LeCTAdtUOt/i4GITtctM+5Udk4r7
	aXGZ+TIJomVdvYLzfEXuXznREBF5GZLE=
X-Received: by 2002:a05:6512:1590:b0:5ae:bf3b:c98 with SMTP id
 2adb3069b0e04-5b2c1affa21mr1358000e87.10.1785155193700; Mon, 27 Jul 2026
 05:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 27 Jul 2026 14:26:21 +0200
X-Gmail-Original-Message-ID: <CAD++jLmfQhZ1gAOJm+puqusW36dLtkA9ZrtBTJaJV1HknC9KsA@mail.gmail.com>
X-Gm-Features: AUfX_mxD_adXGqm9kTA_bHrkO1nsLCITkaAYoPilWftIxGnpurTvXZcPriJCPtY
Message-ID: <CAD++jLmfQhZ1gAOJm+puqusW36dLtkA9ZrtBTJaJV1HknC9KsA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] net: dsa: realtek: use devm_mutex_init
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Rasmussen <mir@bang-olufsen.dk>, Florian Fainelli <f.fainelli@gmail.com>, 
	Mieczyslaw Nalewaj <namiltd@yahoo.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:56=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> This series fixes mutex teardown in the Realtek DSA drivers.
>
> With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() must be called before
> the mutex is discarded. Using devm_mutex_init() lets the driver core
> handle that automatically.
>
> The changes are split into individual commits based on the feature that
> introduced each lock to allow proper backports to stable trees.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
