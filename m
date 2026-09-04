Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC54A64DB
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531017; cv=pass; b=ItrMF4AXYuVt9G2XqpcM2lfQg7nMkTbi2IcJTEsL/LKCMhxB/oUxa3CAXLbTe+4oXOqOMqSrF6MOt5212Ldp9XrKup8wqAp6xi704uGFZ1mYUdnSkwUy7ejMkUKzKiRbbh60OPYA+3MNEpvwfUHQtqZWyO7z43lym+JPH11G4rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531017; c=relaxed/simple;
	bh=Sk5CI8+d1P84GeDudvBytEEtU3fNsdyvUlGMJig0vNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Evti6nkCIo2i2EM9y/fxTd9b054tb4w0MtEkv4P5CkxDmaX9V123iX3BbYivMZW9+3ubXRXJCld67PtLiwdilpEsmycaQ1bWN6j/5AUUc0WEtP1F4Rfypij+d/BjOWbOcJxAIptmGGwpr9NvS/2FwWLhdII81m2rVqRcSe/8rd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4PLldLa; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4PLldLa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso171111966b.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 07:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788531014; cv=none;
        d=google.com; s=arc-20260327;
        b=SZRD0rv5x36B2XZg7T4liybgnB/ADcHo8cQskvt6B5JKpmQ2qfViHcpZFzJBtWYjzY
         ISSBBZp7O7xIQxAwdRJJaW1QcS1Ec6xEOZfd0QLiIbGRguMOQmUdTQScn2ALKoxPxYz3
         1teBMRAfVZGS71K/UiPRufKo7qCUXbdVejCw4TVbCgssEYP+ImxKV3W2VlDKDNP/7vsQ
         lxIkRBWspp45Yl8eeGWVmJfjt6E0m/lC7uv/y1427HlQcbqLj9sSaXLoztagDVj/BWIZ
         GAAOloZwzkJv9ID8rmFOP5gaXPGenUR9o/pa7vb8mhG7TmgWoEn01SQTEiGz0ED02sFc
         rIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kOW1YwXhJmmmF7CYE3YJyTz5uHyreBLj2FaSBMO28s4=;
        fh=OB7+F6jCQBrnKx80zuZW3w6/1YG6fQ0s+TzeaKqgpF0=;
        b=G7FeHbNjRwuONHpBSjaMf/aTKfrZNB7SRSqK3S8GgCMqrfOmtBGKQ5C5/ywweEZWee
         LoFdRkFpw0DgUnnRRw5E1FAwjcA8KRH/31yA1XdRM3SZKCZv5MFapJ0UO50YYdyqxOXE
         FeIFjEW1Aj6AoWLr8KJ1rMysqhcBLQwK8T0xlRrKo7G8RcRyVe+xoL7TpWP078zRU+FR
         ObtZpha2iu7f9pPHVfrsL4B6+wk56qIFAMdsPcABzb7kX5AauHFMrSk7kVScdnMw9+ti
         +ayHysOhP4DDC4XxLGvXVtw0/ljL5DliSRsmfYZ0M+Y6zicXMhKpM0rxrCyRiHhxX9i2
         aZug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531014; x=1789135814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOW1YwXhJmmmF7CYE3YJyTz5uHyreBLj2FaSBMO28s4=;
        b=T4PLldLajntj5k7+1K1fR5gif/E0etoDrz4g65iiRVMIlXun7Joo79h/YerYcXV3HG
         hw24GDelAR72E1V2GkbQ52LPbGwdcB/1zsU9zQi0bSLyh702LJFAg9JvUHiC/QR+SLGa
         h84yijgzjM3B6gfiJnYNpIsOXyHxNz0Quxw1Yz2Sx8eASwEXCt1reLLs+fsUhHDeKNZx
         b6yQsNtzKtZ47UArFCF0LMGjBHg6cWyp7dyQULhZV6zzoH19Qa+075gE/9I56GlRyt+6
         MqcktOOwgTXoJ9ZgPkArq1fqIJ7dBUfByXUnKs8G3Odex4VpKbnXDrAwlsvy5vOPrgrG
         nScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531014; x=1789135814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOW1YwXhJmmmF7CYE3YJyTz5uHyreBLj2FaSBMO28s4=;
        b=EQzFnnutR1u6pVsGsZBlAHSpA5x4oOIylvus1L+Nnhz3OOcsiSg0sJoxutPeyhptL7
         UQi641z572mu6sP0e1+VGZoZ5cY+vCJ0pT+Sbfr5GHxBnRv+VZnmzaH7Rrt8wrU9T0k/
         ZkHSXxH47bofryPIEUF+lE8UWnwg3zzLUO/kHglZQU09k3q8aLoWsELaSzQhK0BZVC9j
         dRDkyERb8emxy4SpzZuFbHlOERWqOCYV6emPhmZJIwn4PWjZSB+2wgPC1uTmynnL0kij
         7ZiFQiIO6YxVjQTiYLa/+44J5ml2K2jzJ9lFxjNzvRInqr3zNS+LxLh/EuCL707arITD
         x4Lw==
X-Forwarded-Encrypted: i=1; AKwUvBwTAbAuP537VlUJo+aQU2nCdU5mpr7Jvew0SWO4UjLjEG6sllNuxAI9rzc/PqHu8fZbWGIWoBk=@vger.kernel.org
X-Gm-Message-State: AFuF++kFAL84IVIE/6WgJlr+T2GSZnZuS/FSg4fqq0mcmdhwr4VpjKJN
	CGvHbQZb+wTYDhyHu6qGoDAu4Irh7nzeLvJiurfl/VbFSexxrqeig0R+0RGbOEJMyywTDTSf4XF
	OZ22HZTdOCwntBpagpJH5qu/6hr0gv9c=
X-Gm-Gg: AYBFou3msZiHhzpiVNWepOZ9Cqef+CBLhNOglfKRb5G397SYxBcovvqZJJqQttxUByf
	xbpZFezRETQQIZ6qELTDJBMHTOgp6Nd0TvW2pBi4paXSUeMDuMDM3ErL4Lor5bEiFYmVL+sw44a
	JJxhdptjzM4P4Cu9TV7mM48nFd07+Ta4hxbB40SHFaTmWEk/80X8hKU3Wy0EHiVb/Wca2n48O3y
	TSgLKGsS9Sq74pkBMyV7yznenObOEpq5uI1TTUqJD0h9Jr/KJjyUyO8uUYRUV1d8lIaX5jw0Ief
	d3cYisEYMHZM+iA0v6MNdXm6taERJHGblfg9w0SVY4mcb44=
X-Received: by 2002:a17:907:c00b:b0:c25:5fa5:dea4 with SMTP id
 a640c23a62f3a-c260c9717e0mr505862966b.4.1788531013449; Fri, 04 Sep 2026
 07:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903092211.2922058-1-o.rempel@pengutronix.de>
 <20260903092211.2922058-3-o.rempel@pengutronix.de> <1f2253f9-3368-4033-a091-ce424c08af89@lunn.ch>
In-Reply-To: <1f2253f9-3368-4033-a091-ce424c08af89@lunn.ch>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 4 Sep 2026 11:10:00 -0300
X-Gm-Features: AcwNN1UFpp3H70vLn3Pfq3KcnE0dOYRHTCJ7i67tugilF0HGiYwxPi797DQz730
Message-ID: <CAJq09z51Xajtca=D+ptwBsQTEod+jYrM_UkKMsuFBqCWoEvkNg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: realtek: rtl8365mb: add EEE support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---
     Luiz Angelo Daros de Luca
            luizluca@gmail.com

Em qui., 3 de set. de 2026 =C3=A0s 09:24, Andrew Lunn <andrew@lunn.ch> escr=
eveu:
>
> On Thu, Sep 03, 2026 at 11:22:11AM +0200, Oleksij Rempel wrote:
> > Add EEE support on the integrated-PHY ports, controllable per port via
> > ethtool.
> >
> > The integrated PHYs have no MMD registers; their EEE registers live in =
the
> > switch's OCP space. phylib accesses EEE as MMD registers, so add
> > phy_{read,write}_c45 realtek_ops that map those MMD accesses onto their=
 OCP
> > addresses, wired as the user MII bus C45 handlers when the chip provide=
s
> > them (rtl8366rb etc. unaffected).
> >
> > The hardware manages LPI on its own, so advertise EEE to phylink with
> > no-op mac_{en,dis}able_tx_lpi callbacks. The LPI timer is a single glob=
al
> > per-speed register, so .set_mac_eee rejects the per-port TX LPI knobs
> > rather than silently ignoring them.
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It looks great. Thanks.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
