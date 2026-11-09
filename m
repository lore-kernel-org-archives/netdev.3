Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210020;
	b=HEwRgV9bJK6EP5Kye4Y/Cx1cmL5/lBGY4aVZdC76eWZ3I45HkPNRquU14qej9kF/3/VK
	 tmqEPBzcU/uLWNW4DTt67BHGEC7gyDTSL1JkJ5jQMZNYiSXuD76mTgD5Ky+jwDSLW/ltw
	 xCLZMSEtsCKNTr5y716/QV9xUy1i+mBbJ9xGnLAvaNXfuddFtla2Gct1hvMwHOb9uML98
	 Ji1CGUDPx3v6sERYVo9a7YmdOKmfNhWYf512YOC11floebSLDAIYf/Zn5rwuDhJBtFmh1
	 Ga4taopgeXF3ssPC89EbFr+WfCFYOcKArxF/A8gBnV62vm17LKfIRyEA4SLC5AjnZ8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
	b=m0N3Wy6UV0X6FwO9lNeNkK5eEU4AoiZwTMvOhjcdmc2vFUoMVkEtFMN1/NXoU79+xYRY
	 Xo3q9muQwZg6f/qCAX6prgb6slUfP6ziw8x5nJWO66860Bbctx4hVko6JyZGtTdTFz6nL
	 B0EPI+IutAU+ph013R7XN/GeXHyyh1ySQQdavauBgUTfx5X+dwhy28j5RfW0YDDV8lUAt
	 ZYsr3ntvxbjwmjA4u9K7NCDfv/ZcTldPDWiBoqsmxpwihoXU15pQQXurh5BBe2b+ADVUo
	 xbtVccbZPyCoC8q7OHFgSdd2Kpi7d5MBnNdhO6zOXztlw0iu3o6h2PU8R95wf476VAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25E606A332
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D25E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so228660a12.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210020; cv=none;
        d=google.com; s=arc-20260327;
        b=rtXsDTaXda5PV68gJZ5F1AkfMq3F5fd/wq385D/lKUC03pSe1ROVFe+2eC11WkLZmc
         FG68OE5+EPrCJ8Fl+LmLnKOikYcAOLY2vnEnvefbXnidSYN89lTuouDVDfTtqME1oJga
         FNUZ8Rqtdr2LbAncpR8VBqC/kWD343JmUXQTxRsPlCRSFBHqCT0ebwWfBjE+L69skbP3
         ooVxFMS+5K5EuduFuaC8LQd+iaBQGYxTW0V/NqMBe3+eTDXP2Ua46yRMiISvaGzXAaZQ
         qYAHw2Rfom7NoM/ldtZNhBs41k7Ebj2+Dk4RT3O2QunMbf5IYANg3vvpwpdOCGtrfUXB
         BayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        fh=FXH4cH6E2Ju3S1KfXjXKwF0ua0x8kIl6xxkxoSm0YZs=;
        b=slm6pOSkyjl1kTLjaZ13ygD/JjHsWggQL/r+v+aNJSiocoGJznG75wjXTYByKhcWUx
         NptohUNT/ickLKi0p7zn+3gugkr5p80lO0TXChcVSs61zKxrdmrATjSUJFlUJly2oo4l
         vcWV2c1v4bU4foBZRxKtIv4WV06OY5vrRLTppj+K1d1w3soGN+sIL3hbJNaq54e0ZTjG
         K3hlG43XrJFh9/rmQDnpA/i4MTTtausXaDue0p1Xg7MUZwhUntpy2GuYBmxPPysYQXbn
         vKEK/Y4jZ1RJFSPfATf9f4GLy4TVUXpu74XaE/N986NHk78fB7sTjcJMIhznOqRFVqt3
         sdOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794210020; x=1794814820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Fw1HJ3eBrEG+YcG2OfXIKNyXLbtxL6pFyShNR64xnTBicLVJTLcqI70PP7XlmXPNx6
         VWmQ662eksYGc8vJo+lcMpjTIaYcJB9aokKPIxavS8OWhjpOs8W89bix1ozwYvKeb3b4
         M7C1Y4n+R7cdsAeFDh3I3fT0WNvzf0CnRZWDlQZYC+5M2rSyX8wMQx9uS+vQs8QSo0d/
         2FLip2Uo0zLuYIubK7TNTBZ4sl8ZrZ+JeHk7SDm/ZlHHFtWu1M3YyNEi+YttPBGWC2RM
         X/hXAhXzRlZNf20NwByFmIPl+GnzmQCqAB4nehLzmm3jWxLA5k3xC+msTg/JbR6XvUqv
         ep4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210020; x=1794814820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Ge/PmiRSecw4gDuPa1NZwzsTgyYRkf2iUkUvDyqTLHnyeiEcLLRw9MDIfQ7qUKjmRX
         SFupMcgkud601b2X2HEwzdm2RCvmIYQpWigprT/7CJNneUFWmKMBwMfRMY8udwJdobo/
         NijUYcBtdua5YTUq8qMTW77cHXVMHS9VrfdPFu6Kxk/25cG7pTfujR392NPm+1TSNKsC
         dnk0roraOt3uppkAdg8iIChsDxTTAzVifr1/9XUaXmYsjqUYxzPHxGNBDlUJVIx7i+2E
         Jv1Bhrn4nT8fIvlpcq6IllmlVdEMP/K/l8uBMYgHKIdn8sx2Y1gIziKPMznRg2PzP9zv
         tb4w==
X-Forwarded-Encrypted: i=1; AL+hErG6a++qHheFtX8QD6hPDGG3D/Kf5w+SxspZZYP0N77C/Hk68yvY5SboP9bIn3YAjEJBe/ya/v0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+litZKiU142slvg5w58h64jZ/Jl3YwuVcQhmRmnc9d4VMgwWi7
	GJBL/eAr4hZcJvelK+K1AG93ewh2agzeVsnnXze5zKfEiImRsheoCFszNwf526No+sXMjj0doZE
	mxqnGrjVntYCX5WeF/avH6KnGa4teZso=
X-Gm-Gg: AYBFou1NOdwcOlci4+LblenV5dOLoQ6TzrWLFRAhKhBXjD4nFi3xDs+R3/YuzzcOl6o
	utXk3SP2vnbFFdC4ZjuHZPxgWYPrQQYpaMCGgc+g/fZnUaEN1bhxyqcXL5M6VtOxji8PGilYaxI
	gjvUDanV9NJ20WjfLIfEF5+vM3F+NhgF8VqTbwvaza6PtCUQzXFuq9fDOnJtt5zVQOvj7m5zlzy
	BM/xdSoLrFW05D0zdGK2NjZzA7qg6CseCpMBJRh8gkhqqmuvBFr/NvBxXStFKpR3mrK1cTamx4f
	UtccUpd5FhatzZz7TA+V6dC2k12j0PP1Hty2c7XxD8Ohddi5vEANuGXa4GHNN8VRDj8pdzY/dv5
	XzUUNDr40pcxu36GqYkbqoq8sqYvz2gpOt9s=
X-Received: by 2002:a17:90b:384c:b0:3ad:a270:a623 with SMTP id
 98e67ed59e1d1-3b12d107e44mr3364118a91.4.1794210019701; Sun, 08 Nov 2026
 23:40:19 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org> <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 9 Nov 2026 15:39:42 +0800
X-Gm-Features: AclHuK_dnPMk52UN3-2_wspDGRy5a6s-cwmnh8paY6ZY-G54Qz5KZ0bygsAWCVc
Message-ID: <CAAfSe-shr1+0YpxEvf+4k+DyGe3==PUiD72CwjE+RC4gX-ShiQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 at 10:39, Chunyan Zhang
<chunyan.zhang@linux.spacemit.com> wrote:
>
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's =
a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yam=
l b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > index afa551f6185f..222d70baef1e 100644
> > --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -47,7 +47,7 @@ properties:
> >      const: 0
> >
> >  patternProperties:
> > -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> > +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
>
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Following up on Andy's note about this:

Please disregard my Reviewed-by. Even though I did look at some of
the other hunks, given that I'm not familiar with the other hardware,
I don't feel comfortable giving a whole-patch Reviewed-by out of
caution. And since I'm no longer the SPRD maintainer, an Acked-by
wouldn't be appropriate either. So withdrawing is the best option =E2=80=94
sorry for the inconvenience.

Thanks,
Chunyan
