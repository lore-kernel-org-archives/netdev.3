Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055C3161B3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114554; cv=none; b=HnIh/GO8T3/HJ1Q28fQnBrgGmA/sZ5nG/siAHRinsXpzkopu+4JARcrJBfh9jPrdDdXSOZQ5ILc1bsBlpxka8WmhrGIhJ/CFjhYBoQYqfSRRK66BPI0AP91FW0gUS6dg+Ha5FyORV5msUed+h5XAR4TummFWzWKc03jOIRYwro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114554; c=relaxed/simple;
	bh=Q+5e9H+HdmW0C0So/yqRSBMoljj7hMcdRxROk+ueplk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm5QrT38LAUJ82a2f8IIqCf9k0oX0Uw/rWDnLjyPfMc1+qXurMrXmj4IC7/AYLV6V+g4PCOiro0besKnE7ulsc/eQ/lFqmfa4weyRxccl5ZFTkof5I0IF2lkO4V+jfMXW2o8RVJy7ORlSmSShhp3HetsReA+7aljPrujz7iGn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F24AhbSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F24AhbSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244F1C2BC9E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770114554;
	bh=Q+5e9H+HdmW0C0So/yqRSBMoljj7hMcdRxROk+ueplk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F24AhbSMXSb+bs5HlaRJRtIJQT1DGvnTYTfhcTFseQfrK4Q0qMpeH0KON7R/fMVfm
	 33d3Bd18TTQthQRyMN/3UDCNJnwugN88QNmNQ5mjltGhVETesETnW+z5Fh1WzhE7uR
	 dX/zJEw4oZ/G9QFaWzOIbihL1YHrA+eNxzCTJB50t6iykO0z0j8uqK3c7lN6mzRbKo
	 wSC5ANYviuovTedHoBLnJ4CqLCFxnCw019wmPfteEa8x2IszmNTqyAk2bGYTugYJIY
	 xr7cO3AvLz1ibsiDYxS7A15S8Iq2anTJqoMA4ytPuzFCQicUHyc9QBHfMQ3sKCDpre
	 L0bDGRfMsBJvg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-382fceabddfso42334301fa.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 02:29:14 -0800 (PST)
X-Gm-Message-State: AOJu0YyTVIewIyR1dTHjuLsoFs5sUg7LYnaNNlabcR6rQRWZjkJ/p+Qc
	5oh7w37BhRQcKtlk34Y0Nu7dUI/px8P7xx7o4XhEw8XhbZcewkZiMDphJKJ1cKLsgTB1nAuUlnB
	BCp3ktN0FVsfG+XOc8QTmCAJp+CCg/BLCbgwOW5A9jg==
X-Received: by 2002:a2e:bc07:0:b0:383:1b75:b9bf with SMTP id
 38308e7fff4ca-3864664349fmr58136261fa.28.1770114552731; Tue, 03 Feb 2026
 02:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202214634.72738-1-rosenp@gmail.com>
In-Reply-To: <20260202214634.72738-1-rosenp@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 3 Feb 2026 11:28:59 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfwuhrUZiFp5v0EjbMJw0fYZTfznqPN_6yuMWxnD4ircQ@mail.gmail.com>
X-Gm-Features: AZwV_QgLNfV5BZ3zJuOTz-WNprPtSMlLj8pGW6PWOOP1hYOcMu-o4WnUPVCBQ6c
Message-ID: <CAMRc=MfwuhrUZiFp5v0EjbMJw0fYZTfznqPN_6yuMWxnD4ircQ@mail.gmail.com>
Subject: Re: [PATCH net 1/3] Revert "net: ag71xx: use devm for register_netdev"
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 10:48=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> This reverts commit cc20a4791641a1cbd1525695fac0d4725dd72509.
>
> register_netdev gets called after phylink_create which has no devm
> equivalent. phylink_destroy must be called after unregister_netdev and
> not before.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Can we just use devm_add_action_or_reset() with a callback calling
phylink_destroy()? It will surely make error handling in probe easier
and avoid mixing devm and non-managed APIs.

Bart
