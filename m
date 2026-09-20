Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524F47209C
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789931468; cv=none; b=AqR+Uph+MpSwt/tj92700IXEIe2ErR7q42ukGU/oCMgWZsYM+fbkkWZVeG82sWbmrPAQ1+USGpHvVvEinXPC9bssakk19pBnbdgajlSPdhp6MJQY8ywnp3MDsiLoLG0QgXthYSH0s2CLne93YiIq+zk+rmm4ZO0EZPHD36YRCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789931468; c=relaxed/simple;
	bh=/iK0Gs6NwyFsMQI3jnf150QmPrlYyVsEEpsTC+sIIk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coLb9frl9G4CfK1cV7gMF3hQaf1lZ7qcWmB28/3jj5xWfST7p39t2FpX/ApxryAq9yft36GNL9qZvMLRcWi3LrrAY5ldA6xfdGGzvjUQW91nf2MustR61xM+FLjiUg/fd5PdWgS9u13kJXZpiejlBDodS8hSBB9uKWCcA4mLCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbGC+9NM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbGC+9NM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727071F0089C
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789931465;
	bh=/iK0Gs6NwyFsMQI3jnf150QmPrlYyVsEEpsTC+sIIk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UbGC+9NMdrBSZ0ww0vVmCyzviQjfaxpOY7Y9CIhDubZBEV0P0AtE52Qf1LpyL03xn
	 8L7+xaTQp+93uC03JdbDN62qIpC328X0SxPzeTRXrST833+mvYTVOFVMNUpEFLsrI7
	 cFSfLJaYQbq0z0ysjGsV28FN65VmvcAWYYHeX77uNsyh5pY49S+CP76Ym8oN8Ji+4U
	 Lv4cW4weyCCFuRznKqnu4Fmvy/Sp2Pi7GfxAQqqbl/XQVCq7r+WaWFnuC8zIwy5yT3
	 qoXpeJnTTtceduTUD5oaroSfwUtLEIld4wxKokdqmKfHAV1n/zWuQGpQkXdszFQmGn
	 RnWUm1744Lulw==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c9954ccbso800363e87.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:11:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxF3JtMr0ykVrW9lEp5s9GfLah8rXtSK0vevfqVCLwlWIQMh05/nyd96mnG9EYvS7yUAcY2NF8=@vger.kernel.org
X-Gm-Message-State: AFuF++kVQR+CyQhlG06Et75TwMZ8eQEe1gVDAmn22x3dL1ek8N/0enQ4
	FGNxE2xLUnzv5cK1OtNO2Y9w247HLQ+8Yli2o+YoPuMtXUNhAjru8ThN+ORuVgR312bbGslhtAE
	O9Ewe2GUI0sTnsMPTvTgMJV6eZHtEuhI=
X-Received: by 2002:a05:6512:3ca0:b0:5b6:1a7d:5539 with SMTP id
 2adb3069b0e04-5b8c19766f1mr2578175e87.64.1789931464136; Sun, 20 Sep 2026
 12:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917192835.58126-1-mhun512@gmail.com>
In-Reply-To: <20260917192835.58126-1-mhun512@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 20 Sep 2026 21:10:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLmbacE7go5Y0sGE+bZoQMAX5KAXFVTxdpiimTJLjmrWyA@mail.gmail.com>
X-Gm-Features: AcwNN1X9_5IhszzIlEYDKCauIiXNs7gHNMzBl-slkNJgbJg3EyuhXhTi27XEGhY
Message-ID: <CAD++jLmbacE7go5Y0sGE+bZoQMAX5KAXFVTxdpiimTJLjmrWyA@mail.gmail.com>
Subject: Re: [PATCH] net: gemini: Free the shared queue after removing the ports
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 9:28=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:

> The software free queue is shared by both Ethernet ports, but each port
> remove callback frees it. The parent also frees the queue before its
> managed child devices are removed. This can free the queue while a port
> or its threaded free-queue IRQ handler still uses it, and free the same
> allocation again when the children are removed.
>
> Keep the queue owned by the parent. Explicitly depopulate its child
> devices before freeing it, so both ports are unregistered and their
> managed IRQ handlers have been released. Disable the free-queue
> interrupt after those handlers have drained, since the threaded handler
> can re-enable it. Only clean up the queue if it was allocated; it may
> never have been set up if neither interface was opened.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethe=
rnet")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

A good patch, but there is a better solution!

Replace the crazy freeq queue with a private
page pool.

I have been cooking a patch, let me test it on
hardware and send it out.

Yours,
Linus Walleij
