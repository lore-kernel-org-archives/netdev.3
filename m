Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305338;
	b=Bwj+v1mKJcHRm8h3pOhLQYHh5IWC8updbP/hym4K7Uh+D7RqqspOoonPmAk0244W6snl
	 /6Xp/KspOsX7s8n5uVgXRUWAPjJFT1juks5sJAlI0eihdVMHPlBZyyhUQd/iunC+/MJK9
	 N1F2o/ynEG8Hn0icSGRsVl7uaVfbiPm4VIIblXTP/icGCTqGmGfUnSI0KFSGk7dwHo7Yg
	 F0dANSURD7v8BJcU8kHhUI43OnVwBBwdWtHki4UOlCB3yhOMsSkhQnr5jL0Gv0JVAc9GI
	 OyldCI7RBa9z/qZv9OA/3puImGb5AGdFq0ZsrJ3N08uZ8SXIL1PpAMK8Ur4muA15pIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305338;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gbyyxf8uWozu76g1DlG1FTKkvc6uMXZetFOUWZFFywU=;
	b=SBv86/15QGNVgc6G7CYfV1SsLoh7pUxs/5SjJzH/9o/RJsyrSpC011oxhxm73khpmRyQ
	 o4fcXI0daxhYdIawHJ8Vc09fS09j4PC3qHGKxhRORCuHxpzHd8NrFDM1pGGpXA4XEB/r4
	 j5schmdRrcOEC7IOuDmQvu+5NvpoYUK+Fg7knERlMqHwaXIPOfpIMxEYX+j3CFg6t2F5a
	 8aXYyyLA0iQ5hQ1nRA/a6h1Fp/PvmLsKEmiI6SgnBXez0KdoeN+s6B0NUIeoAP1XsevZU
	 n8m4y7ysh900hq/JZM62PnhxLorNof/0qe/bs0UCYw8mkRMHAqIt4fvce0FSvPUj9LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQEcIIm5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C060710A2
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQEcIIm5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074AB1F0089F
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305338;
	bh=gbyyxf8uWozu76g1DlG1FTKkvc6uMXZetFOUWZFFywU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TQEcIIm5uSvHVYRO5/HJgp1t7AX6bUuWJhaYIF3Kcex3e27e8EwhHQqY4M23+yA4i
	 wL2GQpizNFa8Of1WkxTcCsFJxzIBQIjLYvKQjeBuSvEJHDct1yhVTqKcSpO2VyPzn9
	 ZLsRm/5fLLyuc1b1Q0mCvMgByQH/SRFMjlkZm95X68ECdBxiOLjFsCMkt+LpWQlgeR
	 y6RAy5tWpWZRKL7qSDqgD2KxMqDayiaTm2+mb7D2pDCHRv/EXzvzYhgqUwc72PxJaj
	 H5hRaL8VCFhWcbIHFcBHeM4HRHHOA9YaPjDQQxKov500AtHZLjhoT5z+cumX7qUA5h
	 MLuo+OGkv1w2w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso1183146e87.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:08:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGfTHi04VZvVNmzol6yV1bsijVMNF7nGbVUePSdpRRAdp2Hu7XuUNewnjw8qz6b8cGzt2GxWsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jj1KRBjKucPDb4SMcOv86kY54e6/iitG7uXUzbt9bcEcK7IHb
	bGEosOsygpxtnDPVkTm6uKUW+UmF6DU7KoYodLg+2bz3k0/dSxhJoWsIOS9sNpy5zYtN65ntQce
	bueeAIORbQjWFuG6M/jbVb9xVjoYk0OQ=
X-Received: by 2002:a05:6512:3f0a:b0:5bf:d60a:5c60 with SMTP id
 2adb3069b0e04-5c156ee2615mr731259e87.55.1794305336791; Tue, 10 Nov 2026
 02:08:56 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-gemini-ethernet-fixes-3-v6-1-c4b5ff8a65d8@kernel.org> <20261110011611.1733276-1-kuba@kernel.org>
In-Reply-To: <20261110011611.1733276-1-kuba@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 11:08:44 +0100
X-Gmail-Original-Message-ID: <CAD++jL=C96Zh0vNMnAjSQELMerZTvkmo=gTcn5Qj_ybiqdmVMA@mail.gmail.com>
X-Gm-Features: AclHuK9S2bNVBTOMO0NPvMUxlRLJTa3NNcYQOtpep3gpLfuGjNKjABfy0FIhvOE
Message-ID: <CAD++jL=C96Zh0vNMnAjSQELMerZTvkmo=gTcn5Qj_ybiqdmVMA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/15] net: ethernet: cortina: Keep shared
 free queue parent-owned
To: Jakub Kicinski <kuba@kernel.org>
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	pabeni@redhat.com, mirq-linux@rere.qmqm.pl, mhun512@gmail.com, 
	edumazet@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:16=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> [Severity: High]
> devm_of_platform_depopulate() unbinds both port devices synchronously,
> and gemini_port_remove() ends with clk_disable_unprepare(port->pclk).

Hmmmm the bots nitpicks in that we need devm_of_platform_depopulate()
then find that this causes new hard to predict semantic
bugs .... OK rinse repeat I guess.

I'll get to it.
Linus Walleij
