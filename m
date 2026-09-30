Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF394C6522
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766010; cv=none; b=l6z8UL6ddbVomBDixj9KE+fwIa/3dhWlZEQaOoEktqYikKQy+Wtfvz97wmaO6/8WIWB/vOtuqP5uJRtvOmoSxSj66DKfMxXssjqL3EMuwvz9Z3yF+KHf8DqnSU/4eUxdcTbhbqAK2Ss6x9CM8bIg1QTIh8VXL1BVPJuBPVr6F7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766010; c=relaxed/simple;
	bh=WxqaXI6NzOHElAB/Tvmmf5UFjpU2Rv2vkCVKSdRrK0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhLz+lytyppDxn672s3GB6jQ+e3dV75bxIJvokfUrPz3tQqkOn2Wax+EtnjRNt4tF4dCuNyS7O6dzwg1lD3Zm6Ou6q69VhQZ10jd0Lgnui0IuXFCuk6EY6XDGu0Ob0ulX/L9cmx4TTlPn8vbD8MtDEshDYuX1MpG62jETTRRPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSibwi9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSibwi9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7994C1F008A2
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765988;
	bh=WxqaXI6NzOHElAB/Tvmmf5UFjpU2Rv2vkCVKSdRrK0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CSibwi9KkWHDFa36qsp/1desF2hiYr27clC+u0BhJWdKYjGOKvRyb2ri2/ntTPAAd
	 09/F1fKkSrIVeRShPcjdFuYZ9g2uFCZghUuuiEVgZUYubboAFkwP3I33T+vFLxD2Lf
	 ZpQKfNLBU7La1h292/V00SuiXYgjmvcJHtLiccng7ehy/7sB9b+8Rjygo43uUyOa+Q
	 1fqS6xIQ4rekCOompD/PUCfmqVr/lpLooIBK5N1ER4WdRT8oVgp8/WTD+hj1XHR1gW
	 eT4Mv14DKK67wvapaK5XpVViZAFFOE3qKljrAAXe6t1lQ/+tO2ncSHYRQ16GKc7vPM
	 /EiWbl1ljLJWA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d90ac37so583860e87.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 03:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwyb3RuvZPnCJ5kFE7Y9I5U0GYTW0mGvCe1yq5C1lenoS3Yvg0J3dX5QqUuPioe+24Ats3jI58=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTyR9w4FYEmZ8mlZUfnndiCzFf47kvj/k9qC0RXxhqFmYFQCl3
	WjK509fr/MYZAVivqc6+j3ee8VTcKexo5ns16iL86y4oSBZOZflJI5mbDbbw30gM93qg2aLHisB
	AYNL2ph94zMFvenCsXwS+Cwc5ofNNmrY=
X-Received: by 2002:a05:6512:ad0:b0:5b8:f211:123b with SMTP id
 2adb3069b0e04-5ba403e9340mr391957e87.20.1790765987204; Wed, 30 Sep 2026
 03:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929092007.1184843-1-o.rempel@pengutronix.de>
In-Reply-To: <20260929092007.1184843-1-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 12:59:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLm4dVX7z2QtBKjdeSv-O1zLR4C-i5cKsVNasEoW=z3efA@mail.gmail.com>
X-Gm-Features: AclHuK9DWmfkl4SaawFEc3CEB22e4ITUV56JaMVLgf3NI18iy6TKTaELAgYA3hY
Message-ID: <CAD++jLm4dVX7z2QtBKjdeSv-O1zLR4C-i5cKsVNasEoW=z3efA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] net: phy: realtek: add MDI-X support for RTL8365MB-VC
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:20=E2=80=AFAM Oleksij Rempel <o.rempel@pengutron=
ix.de> wrote:

> Add MDI-X configuration and status reporting for the RTL8365MB-VC interna=
l
> PHYs. Without a driver hook genphy cannot reach the chip's crossover
> control register, so forcing MDI/MDI-X with "ethtool -s <dev> mdix on|off=
"
> is a no-op and "ethtool <dev>" cannot report the resolved MDI-X state on
> this PHY.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

 Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
