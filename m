Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240966;
	b=MKhn/HO/SoVX2sxb1ruLpxFD4LQRWMFleh8fIiJPsNFM87DpvgmA9ZmBoTGbeu7inLwi
	 RepSH3Jl0ZAD3lEByDYALwbYEYJ/a6vGRL5u2x4L9fzFFGR2f8WmSouD8IlTNCMcznEEC
	 hl2EqSJu06roxXpOQGyB0zEF+s7KkwZeiwYMLJZ5MLeO3+9gTnYQqcR3F8NHaKBVjlggd
	 ISI3JYMRV2vz4sQpQ6HgG9qS+xEawHA+vhHhf195ONW/OV1qFePKvX1xDxY7DWV9BUasP
	 CTfhmozEnbC6XnJwL2A8+Chu8TA9b3bQWNIbrSNYP5wI/0Q6o/7I82stSD4+gEiIwVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240966;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a+uAUjhXKEApJwrL+oxv5vaGLoNsPevTJGtjjvevzRI=;
	b=gCwdkXX6guRRsxFeGORU5+K9cEDt1gPJdlMZXAu27PIUV+0gy/DvYTxjLe1TB8QoFfZv
	 Rh4/E0CwZbgm3wI3vFqG39oRQ5wPUN0uN+ep0r/Nc3XxIKBUXo2109ZbxD6WXxG/JhA0E
	 I/K3fOQ6tys7KbQxViHJ2VL92YknMyKi8NteSP4RHO0WhxxnrXZ/z8G3gSy5/bpND7cpc
	 Yt2/eZVNT+vkxIpgXp6BBBCAD+53NWl1XjnHRgKcZFeiRdgm/vGD8cQhIz/+o4yzDG6cs
	 VeMnC26uuW+B+9xkGVKxF4xbjM2mrzL666k1nFwwufvshKoOFCMzMHdMyd42PMXnXhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i6au/myG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334B606EE84
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6au/myG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEEB1F008A3
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240966;
	bh=a+uAUjhXKEApJwrL+oxv5vaGLoNsPevTJGtjjvevzRI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=i6au/myG9p4GsOKM3Vi2VV8GPL0M54b1Q0aP+nLEVBGLWzFiIIQL51O1MPCO+TJ4P
	 dOOlbWjxw1rDvIUfDn3HiHecyjD8xeH7auCSya7gDynZpsG6ifrwDgv2bj7GEdYFIS
	 6koTwc3GNJ3y4HxS5QqxvXa+YXh6iYr6A8T2PwO6HCn5shYGBESjwyGMR34m80I3S6
	 RwOdZ0texE0E8hg2AoMGmeS8P3ZBs66cKKylaV0qlfR4zBPdrX44gquG1jpaLHZqWu
	 iVi83j2JSgA+Ktlq/6aFAKZQLOSxJXn2dcRSQ5YbGFPhVhc6rBxkKvUFpemhYanYHR
	 PRqMUgFKiJXFQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8439fe796ebso642789a34.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:16:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFNi9+9th8cA8HF83+pIeIG5iiYSpdZi/3TZIOXQLmVqcu+u424jmtROOT1SwxUx8GFM+6BG0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MU14FNOwCP6J14u5zXBkF2tQahWFv8inJKMiGQVhp/vFXeNEC
	H29lVuUh/SsUYfEDobDG1ml59Cafsbk5J8NyP/F3k1DgsMHEvc+qCAnGgDTKsCIuHdWyrisea4o
	U3JQ6A+ETbGLaZJqwu0QV4ILMkOBo+2o=
X-Received: by 2002:a05:6808:1209:b0:532:4867:8916 with SMTP id
 5614622812f47-5683c9e2ac2mr94540b6e.4.1794240965556; Mon, 09 Nov 2026
 08:16:05 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech>
In-Reply-To: <20260930-a733-clk-v5-3-11175b41cd2d@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 10 Nov 2026 01:15:47 +0900
X-Gmail-Original-Message-ID: <CAGb2v66J=FaqimwrqrbVuBVb5GMuhizp2Hnt6vN7CRMNhiuCFA@mail.gmail.com>
X-Gm-Features: AclHuK8oi8fLMntRJV56LqbfIWbbWAJenIS4kljcKk7VrVTWKVxckSNOSzGxgTs
Message-ID: <CAGb2v66J=FaqimwrqrbVuBVb5GMuhizp2Hnt6vN7CRMNhiuCFA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] clk: sunxi-ng: a733: Add PRCM CCU
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

On Wed, Sep 30, 2026 at 2:27=E2=80=AFAM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
> Add support for the Power Reset Clock Management (PRCM) module found in
> the Allwinner A733 SoC. This clock controller manages the clock control
> and reset functions for device modules within the CPUS domain.
>
> The PRCM module includes the management of three primary buses: r-ahb,
> r-apb0, and r-apb1. It also provides clocking for several key
> peripherals, such as R-UART, R-I2C, R-SPI, and the R-RISCV subsystem.
> Additionally, the reset lines for these modules are integrated.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Enzo Adriano <enzo.adriano.code@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
