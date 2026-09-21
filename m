Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14D491595
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006525; cv=none; b=TrpuJv9wd0P984h8bzwdbiAoZ2Y6o8ge0W8gI22W7SOY2j48uDeTjX1O8k8Ng4Apa7848t7sK2/GJTae07qd1Sx++i7Td1GxLfGuVcufF9JlBjsN1W7frJygP2wy8SXCgcje8OaZvb/NTjmiM30KiKHWg9j0TTb28bKUJz5ho+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006525; c=relaxed/simple;
	bh=Eyf5HB7rWUuykO/B4yjrMsebEOm1V7kPMebLHZRCWQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAjdR9Nyl680iuUEPsA+2kdOAawJ4tIjV6orvzL2zbwRZhYJ2JB+L9+4vpcbv2mhOtv/8YTBKHIk2EIcB+7Y3Jfmt7+B6Jvz5/axAL4dJ4AijQRcom8v8suQCnrS6cVtZZ2AB8q6rzhXoeCbiARsF6e4323vUqXwQDtKz9G3Q1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHVHrTUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHVHrTUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4602F1F0089F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006524;
	bh=Eyf5HB7rWUuykO/B4yjrMsebEOm1V7kPMebLHZRCWQY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=MHVHrTUhgy8RLJSB9PCb96C+TwYoxk9OPxsY3WYUd2k1pUPyfhn1jxqcnLx12ZXbI
	 C0zH7D0SYWucL6sTXnsFxG2XnRXG505wid63EKjGDRqyp94l78SpU5yfs9I3E9s5nE
	 WXbF+pUOvv4AWZMdfjgwUSRby/OgOgpSqHRAX4SKAvSMpyq/zbOFoLZ/kYDzgMjRgz
	 ugE5ZMnEKTcPpmROkZHM0DRhibmf7XlTswHDYXcMj4LvmRsBFPTpqMURa/KDisRLaW
	 zz4Rlsh2QivIdiY/m5H9SAaOTlKAURKON3hAb7WOVVqnwGQhoDyprV4XVucAJ/LMi/
	 Hwii7b6VQc6sw==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a36de66c0dso30742211fa.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:02:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwPlqaT7Lb8U4X22FORkPHsGW2SwScNWkVogA0Yy3JJ0VwBdGQH69KJ3ofrvv7dBclKQKzosDI=@vger.kernel.org
X-Gm-Message-State: AFuF++l0/vMvVcqX7sQx2Y2DTPA1WBwtY/rNOltI0IJrnraksbWVj6dT
	A+m1hjevEiiY0UZfdPHBYrSTyBdsDVgjAZ6jw70PvMhKydm6sN5j4lsKB25tX78FCyRaY/WItIH
	Fn27If4B1S6lmY2X+cqVW0yRKseGV18A=
X-Received: by 2002:a05:651c:1443:b0:3a5:afec:9cf9 with SMTP id
 38308e7fff4ca-3a5fbf36939mr24677701fa.7.1790006522575; Mon, 21 Sep 2026
 09:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-a733-clk-v4-0-9c184ebe9ac1@pigmoral.tech> <20260921-a733-clk-v4-2-9c184ebe9ac1@pigmoral.tech>
In-Reply-To: <20260921-a733-clk-v4-2-9c184ebe9ac1@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 22 Sep 2026 00:01:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v66wbv2W1mcZ_WzKnkgiSYYm89LGR67gYAgsNgSFYw5mfg@mail.gmail.com>
X-Gm-Features: AcwNN1WJSlHI-NjxkeeWhPwtNL0p2-F5vEq-B0J5BRudScG0IjIZ4ZswOa7ekVg
Message-ID: <CAGb2v66wbv2W1mcZ_WzKnkgiSYYm89LGR67gYAgsNgSFYw5mfg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: sunxi-ng: sdm: Add dual patterns support
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

On Mon, Sep 21, 2026 at 11:39=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.te=
ch> wrote:
>
> On newer Allwinner platforms like the A733, the Sigma-Delta Modulation
> (SDM) control logic is more complex. The SDM enable bit, which was
> previously located in the PLL register, is now moved to a second
> pattern register (PATTERN1).
>
> To support this, rename the existing "tuning" members to "pattern0" to
> align with the datasheet, and introduce the _SUNXI_CCU_SDM_DUAL_PAT
> macro to provide pattern1 register support. Related operations are also
> updated.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
