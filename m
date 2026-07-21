Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DA435518
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620211; cv=none; b=bjpuqqoOMEhQZ/Lvz05rltKgQZ0k70ImN+gmLgFVXccD3JQ/keQqJ679FzbhaZEuMSJbTVPX09qTXJQ+bYvl92fbP+T8izKLe2B3DcjykIDQtE0/ekIcArTabYLHSWCYQ7sBLg2pAlHNgov5a9/ahMiH2YiUGeuLr97XdnIomcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620211; c=relaxed/simple;
	bh=xkJHITvqX1FWX4L63OpNnz2Qb0aVsri/wXqI3fsoexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnShyXKIic64hNpIxpPKFIkttU4X5WO0IukRNK0Q/iD/B+wEzbZhzUAs8Xdtprs917uiBkn4N71m9gv0vLVWVfXmhYrXbvFwghv8anYJQ/HWHHAUQI0np/ZqXdfSbVZBK59Q1rJCKYL4ngWF9IKoDEzV5HWoDGKufyEqgipJIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoFPW2OD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoFPW2OD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C49D1F0155E
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620209;
	bh=xkJHITvqX1FWX4L63OpNnz2Qb0aVsri/wXqI3fsoexw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eoFPW2OD7s35Azw47YLLuikvix+UDF0w3sqdGWpfkJOeyiK09Fda4d0fyk9jUl7si
	 OWojPo2DlQjfjcU4fw+RMJIn4/Mp/2FOQKFNrEZPr8Bs8aZ5Fi1z4v3Z0lR2IdXJnO
	 eInAya/5/1oriC49/F1qvT5uA17CEP+nNEKuPD+czMZp574V2gfluiK1GzowZK9mxu
	 FJVRlvUdYUGS1VVhGR4beeQ0F0qvp2AB+hVkTh5Pvs4d1kfmIM7mBCD6gPVQTUJI/a
	 kh5kYFcyTFomZrO4NCQNzhcExq7n+5tplAkoF7WuocSAUoEgJsX6J2BzGVcfGyTqce
	 ltFpvhJfr/xUA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b159850b16so7284961e87.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqFWiQAkpWyM7W0AlDULY8quh1mXlxjbGNPqdxPaan0u9rliXCSzsKdFKp89WKalDVwLCaephI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuIfyJR+CHisSAqFDCTQ4TF2ss87zBsW447bZXgE5l6DygcYgv
	EeMxGXRgfFOxfyCHKFxN7BeieOwIDSsGCa0Lig9RZNjho0JPPevMldB3U8+EgB/i+VvSZYBIgVl
	pEJBY/71Cp8dS2J3Zohx99KiS9yrsDfA=
X-Received: by 2002:a05:6512:b83:b0:5ae:b5bd:5e72 with SMTP id
 2adb3069b0e04-5b28fabb816mr3793719e87.59.1784620208288; Tue, 21 Jul 2026
 00:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721052859.171341-1-manikandan.m@microchip.com> <20260721052859.171341-8-manikandan.m@microchip.com>
In-Reply-To: <20260721052859.171341-8-manikandan.m@microchip.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 21 Jul 2026 09:49:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLkzDDC66KjyMGommrC7T0L5KW3TA+JLKUmNf_psF-eRuw@mail.gmail.com>
X-Gm-Features: AUfX_myAPX-Fx-YYXrqqVAT9emnPnmjb3E1aTj_6ToEx3OEbZBmyyuGAfe7f9n4
Message-ID: <CAD++jLkzDDC66KjyMGommrC7T0L5KW3TA+JLKUmNf_psF-eRuw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] ARM: configs: sama5: enable Microchip/SST SFDP EUI
 NVMEM layout
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, srini@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, richardcochran@gmail.com, 
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:31=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> Enable CONFIG_NVMEM_LAYOUT_SST26VF_SFDP_EUI so the factory EUI-48 stored
> in the SST26VF QSPI flash SFDP can be used as a MAC address on boards
> such as the sama5d27_wlsom1.
>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
