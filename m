Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6272C1788
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576832; cv=none; b=ZDv5a3oc/Kds0H/I6xfa2zZzutw6rX+dNEcSKFOGOUoRw/kubkqapEeQKsc8r2fMn+EMOH8K+zIrSRq9JhtvJOSOEXrFvXV1cS6ulF4tsE5e15+V0UCJM+2enn3OeCuVK088QUMWi2PuPYXMlunCXCAjl44idq9wIMJQNg3M6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576832; c=relaxed/simple;
	bh=cwpGuMn1KdvSvNgpU8S5spu0pCHspmC3uPRaHcV292A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeGcAvbT03v9/674oSQWXNYVdWX77Dbang9QD7Eop/x9HTWIpVgeDPB7R93JLjeTVsRHS72mma9/9XAYM4eVSFnsu5GNvj0Sd3QvVPekzkV4Cy8PcbUEJVgC17Bv5OcEfNiAHB2zuTzGAvaxUW+2r1z7tWFqVGX4M0mIG8PFOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbD6US+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbD6US+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9541FC2BC9E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771576832;
	bh=cwpGuMn1KdvSvNgpU8S5spu0pCHspmC3uPRaHcV292A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dbD6US+35B1DTaFeHFhukPBKZRCujlyRinsXovTJj8scp2d/lRVJK3BZQUt9i2kw1
	 xcPmrgkZ6ZRFkZXNJxrYcHzQgOGZ02pYN7g4Ye7uugq3TAHrFi6ipTsh+5BseQJV1b
	 UMQTOaDmUpowCwuiV3zabeAStnYsp4VC6Tfqwc29R6K6Pfh2gb7dxnhQENHL6T8TDx
	 Fe3IV/3GUMef5Y1wYbRMaxq1y7HFG06kzQanOlcbDKpjjqjRVDBvRRpIe95I90Qckx
	 HO0j270rX1yLYD8hqMm2n9qOYhpvdMXRGRaHge9ZNOFGNO310quzMzYdmWo+p+0m73
	 rKW0nIWlpJtcw==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649b1ca87ddso1536937d50.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:32 -0800 (PST)
X-Gm-Message-State: AOJu0Ywsryo7zdrD2Ju+WQv33Zfp86jnyan/+JGK/zMZzmdtEA/JGCQI
	JniWr5yrsP6zUWU1gN1QVE07whe/zmFKCAPaH5Blh3xccYAvKAjnwy9vYR3yZal9qpFLp1PSNuH
	0HX6YB0KmBpStXQLPP3dEj8XMq/dPofc=
X-Received: by 2002:a05:690e:1444:b0:64a:df3a:1533 with SMTP id
 956f58d0204a3-64c555625c5mr5986104d50.19.1771576831717; Fri, 20 Feb 2026
 00:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220021949.40817-1-rosenp@gmail.com>
In-Reply-To: <20260220021949.40817-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Feb 2026 09:40:19 +0100
X-Gmail-Original-Message-ID: <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
X-Gm-Features: AaiRm52J3bhw9AXp2v83yIbHN0n5WyPOfRj4AQR_C4rA1PoazwTXCOblWRlv5eY
Message-ID: <CAD++jLkZJLsayzMnV=vTZ4nNMB5yWw6oogtbOjnj+MNUMJ8PEA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: ethernet: cortina: support deferral
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 3:20=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> When using nvmem, it may be necessary to defer probe until the specific
> nvmem driver is loaded to get the proper MAC.
>
> Rosen Penev (2):
>   net: ethernet: cortina: use devm to enable clocks
>   net: ethernet: cortina: fix nvmem mac addresses

Net-next is closed so you will have to resend this:
https://netdev.bots.linux.dev/net-next.html

But I like what I see :)
Reviewed-by: Linus Walleij <linusw@kernel.org>

What I actually most of all want to achieve here is to support loading
the PHY as module, but I suspect that then the ethernet driver has to
be a module as well so modprobe can do its job.

Yours,
Linus Walleij
