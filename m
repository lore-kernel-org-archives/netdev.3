Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670D41D22D
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111865; cv=none; b=ETxdgYzqDdHPHLXyd3p5CCZkJFQ7u1GsEL9sQ76eh/sCLMFbR797jdhGDFslmbuLZDmo66QNWOX3tb+2qhm88O43iSbv3eNbxBbkjq8jkoOKnX9ufMtToIoTSVVb43Pn9Wo1MeaCge1XDocYD/Z/wf5wWzn3xh9hOiUggw5h5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111865; c=relaxed/simple;
	bh=4+5J5Wk0O+uOTKnZfw9tvqFIpDGg/5JIdr6gLxye25A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3ORB6877Gt4L5HmKcK6ymu7jpakGh622KfzLC7jYxq0RE8tfbbF1SOoavRhLG9ySShZyBYlFhMlNGGQtzLIOeh2UdHD4MyRP7pgsN7bslo1X5kqCYr3ENT0Xwhkw1WoaBcUP2sQjACZmSj/gZhXBOCuRauU7DvgkEidR7UhJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBx0WO9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBx0WO9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6A91F0089F
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791111863;
	bh=4+5J5Wk0O+uOTKnZfw9tvqFIpDGg/5JIdr6gLxye25A=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=SBx0WO9CxzsArV8P/z64gCOTXQshWfg8Uror7eEDwZdi5aZTCJBQL8qoqrANfEksk
	 mvFOanfmnyco6OyowlaaJ6TrfOtYf6kn93SwgffFfhiHzHcnwssPbFTsfct/AKoqC9
	 /tGCWkevB7fcn9D5aV3ifilhLKt6YnxujLcPJDxbNW9G5cugUjaMIZ6GMLhGATypyK
	 iqGteZb4k/JHXCi9yls6xnv3sDbCdjVeFone4PeJRkjLI5DJ6X00Ch4zN76r6Brsmi
	 YV7SIyDgrEUfkX5W1HMPNv2zitYX60sI+FIRCZx2k5woXVy6UjQwwXaNCRteDbNw+H
	 nP4vpqJV7v6vw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a980c01033so2904391fa.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 04:04:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw2OB1inyDTOLhQWKf3qSSZ5tTwE3PPxi6t7j/gDQ8fQwiAlNiovBVJ1JVl628EGYfJIC85d8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2tRyGmeYrmGDp+degQmdYYdfoJ2FTrJZtGEuRpFLOWoxrJqoL
	cQNdPLdZU8xqdUlRtpg3t+i5N/gk3OYQQz6+vt2O2Mwk3j2M1OehqEnVKMOlnkVUvd1M+MJjG1a
	riNZ99GlD/0Jm1FJuDjQNu/tb5GeyHl0=
X-Received: by 2002:a2e:b8c8:0:b0:3a9:82c2:ec1e with SMTP id
 38308e7fff4ca-3a982c2ed98mr3375891fa.15.1791111861878; Sun, 04 Oct 2026
 04:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-8-11175b41cd2d@pigmoral.tech>
In-Reply-To: <20260930-a733-clk-v5-8-11175b41cd2d@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 4 Oct 2026 13:04:09 +0200
X-Gmail-Original-Message-ID: <CAGb2v653CS4jFNAo+p=-_7wspObh=Cd=pUaSnPA1vu1hegsAOg@mail.gmail.com>
X-Gm-Features: AclHuK_0n2_x4qIGHT4NpCYNH-L_cZ0FJ47BSqio0LkXDY9BAqYTPBXGwXZuSXo
Message-ID: <CAGb2v653CS4jFNAo+p=-_7wspObh=Cd=pUaSnPA1vu1hegsAOg@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] clk: sunxi-ng: a733: Add reset lines
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Enzo Adriano <enzo.adriano.code@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:28=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
> Add the reset lines for the Allwinner A733 SoC. These reset control bits
> are integrated into the Bus Gate Reset (BGR) registers, typically
> sharing the same register address with their corresponding bus clock
> gates. Integrate them into the main CCU driver using the existing
> sunxi-ng ccu_reset framework, allowing the CCU to also function as a
> reset controller for the SoC.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
