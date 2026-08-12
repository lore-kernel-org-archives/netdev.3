Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2717B50F
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520024; cv=none; b=eYhnVDB0XqhNwjPnCAU8o1sVZdNUqY1TuC2bF93zqoogRCDV0mznX3EqeQ16QTDfuTnN6QwCeVhpAhML3ux/7gaDsI4YTU3qDA/JxxiFmXLyGXh2q0Rr7Hf6KtLwnPPi7oR8GdCH8wy3Ddhw1KZo7hNgv3c+BTzdGXz1wpCy/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520024; c=relaxed/simple;
	bh=6HFRuCYVa8KToPTN9G3QlStin0uy3AipFDRCw0hTd7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/i3VyTnvf9fxd8F8ZHVk4iAVRhxsqh9ThOW8hl1uSzByadzqA9fLC0CdjD3EqgjMNQH8H9Oif8q3oHTcvRBN1ZjJ1QhRiRqr7zxyHpHizAo+iAd6LeqOdIuy87QZjW3C+QJ23oynqY9p9RNGmrdATfsZpTm1WtuRYVm9TJrFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImOThz3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImOThz3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299401F00ADE
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520023;
	bh=6HFRuCYVa8KToPTN9G3QlStin0uy3AipFDRCw0hTd7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ImOThz3+2fqZybF98GJMV8/r7J2qW1zv8ubF/WCgoBhrefqWbrxGoJFNMtk91OfS/
	 73y11fr1n/5YmRa2g9NY2PJ37zbzX+GV+dfVIa6hBRVkY+SDrReCQG7JFa61MmBWU5
	 cyOM3/ZjDY3HdVxUFGBC8/VgY5wf3g+en39jSaVgsjH68FN4HIUOwW+SLikdiTwNgN
	 KzqcYuL3FWpDDt2YYvkzk74bWuh1UsnqH6bjCZPsaGZT91ovgr9E7IX9+DAxpTTz1q
	 xFdKKEYiFPo9FQ25Z7TXoncxcUGTYfLpRyIw19RApucGAABv1poaas1qieDzmHuUNo
	 yvcCRSxNkk1Zg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so419653e87.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:33:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrNu0IR8zc7YqAvPkaJzYZD+N8UtixEah0i9p+QmUEFOT/BeNfABf62KF8vPsIBt9tJBMRuEKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdqT2UZF15m3Jykp0wLIAx6J1EuKkgVEYa0cKzBgSsdVElNHn
	vRfeIVhXDmPcKv/zHOzT2cdD0UQEuPSEErjUrlglJAchOwGmXOjUE1HNIQ+kj0lUU3MU9twlE1B
	/QGavdtr83EbdASez8HVANFXxAtWP76U=
X-Received: by 2002:a19:5519:0:b0:5b0:1708:afa6 with SMTP id
 2adb3069b0e04-5b44e328af2mr309384e87.43.1786520021853; Wed, 12 Aug 2026
 00:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811113901.3114169-1-o.rempel@pengutronix.de> <20260811113901.3114169-2-o.rempel@pengutronix.de>
In-Reply-To: <20260811113901.3114169-2-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 12 Aug 2026 09:33:30 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-J-h+AGyRe+yno3aURnfLXT4Z0Z_xhoFF0jepJE4G8g@mail.gmail.com>
X-Gm-Features: AUfX_mzwjjgFMIyVNfc9jAyrrGRJRFAgi63MKRizGD9CxjPUhG4pmNCcUlDHo2E
Message-ID: <CAD++jLm-J-h+AGyRe+yno3aURnfLXT4Z0Z_xhoFF0jepJE4G8g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: dsa: realtek: add
 RTL8365MB power supplies
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 1:39=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> Document the RTL8365MB power rails as optional supplies. They are optiona=
l
> because the rails are often always-on; some designs break them out for
> granular hwmon monitoring and regulator control.
>
> They are scoped to realtek,rtl8365mb: different Realtek switch families u=
se
> different power-rail naming schemes, so these rails do not apply to other
> families such as realtek,rtl8366rb (VDDA/VDD_CORE/VDDIO/...).
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

I checked it and it turns out the RTL8366RB has other supply
names (as far as can be told) so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
