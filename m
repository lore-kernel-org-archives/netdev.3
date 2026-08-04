Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9A1A6809
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811546; cv=pass; b=K+D3XNBxySPRdxrBqTwjpNr4WzpMVYvdsJrxJ85icHVQFEpv6xbEmfBTtsIdgLzFcEUm6puNvMpVHEYaZeRjf9DGR+WcBwIA/gsGvUrfCSEmGuS10ZDlPZXio3cBHAaipT+/BZJ8k6+vAsSsh4lb3rLuFuowH4kbxRcBat3/7No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811546; c=relaxed/simple;
	bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBJ1jP/KV8/tX6ttglngJwRaU4y7sG6AbS8PjZM7VWSb8TKV4iB6wJbSk2JxJpB3Xa9qkvhiihNYvrlO3ql1SyFsq+TmuYZ4UP7AP4CCRyNRg1iu17da2GQvk+PQm8+ktz+tCfBf2vnKNB4OxSY5C8wMQ0JFwH/7oGdijee3mQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WgErTmhf; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgErTmhf"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81ed2a00f12so58825457b3.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785811544; cv=none;
        d=google.com; s=arc-20260327;
        b=mEMFWoOE7+HqH/tNcIH+mVk1I1WLm1/A3r43FtO2yz7OkZzDLsApar4Ce2RHmjdlsc
         wpvfiVN43xJSzWICVewaY/8ZyqrBHwIoqR53RDSYHOts4VQ2fec2kQnz98l5jgwM0gcp
         8y4nevivhi+AxVSCvuPZddMGb5/p8IxpyJAt3CVkml7/EB2KMRxgyc97uF+IFuO+iykg
         evaYIIJkmFF6IffGk13XJ3QSaekXcNowXHJPxcsrrbITF5z2UqKMPJ/NxeazhsPXOt8Y
         YY/MvLRRSHWVOzXKG85ZkqBAYOlVANBGlCd2PquzDMx3wPlOTe3sZ3grxcOXfszPLo4w
         p27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
        fh=1CXAzTNPOq3Xvji7IcZ4I+zlCLVBF12S0ZZ1pCkmcjY=;
        b=jDKGJoS3o1NP9lYC+BEBuhh+kUTRd3kK75WwEpqapfI7BbZ9ZafbUM7EY1Huk7ZCwp
         Zlfck2EXxqDfqolJTq6DD2wNdKlT+OtXuNM7S0MyRv9Uk9k8B12vdhr6znZIIneFc29k
         Wci3H1YJBFiiUeLAxRUZz9gcRB9rgBBVeZ1Gqcogjl92k93gx/3Bm1PJ1s97RYjDfam6
         m9cGy7Dl1Kr8JzPoRlXgZCyLG19Y3jSWq9zuwnIzK9PqTw6ras98xwIDepIGZNuHtKEO
         bE02s9X1Fez6e8/xZljJ6FdfcwiH127CWRCw2LKOfpGpYsZvmLZaH1pXfnBzKAGmZyqj
         RPdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785811544; x=1786416344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
        b=WgErTmhfNRjNzhJhVn1FMcCJZc198tvCR2mywUwTerla7mLgodvReQHOaXBoMRh2Bk
         p8MDcwBiF5wgNmjRtmlukA3PGBxMXvSt5GJiP1wFZBfBNFTjBM+fYDauqE3vPQ5+4u0/
         w1Sc02oG6DtdJNiQG2ebax7JXtN8ewys652WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811544; x=1786416344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUHZK43CT/N++9FBcUl1JAIfA+cKuOObfqC5yDHgHUM=;
        b=IHG6kqfdcP5iP6vCGn3gT+IfEid9XFlUDxym16fXkB/Dszmbp2vb9LJ0ks+D8Wlx4k
         l0fxUmuDBxYUH5M84DiwMiY1MxI4xzTWGzirOAl8Fk2hOL6kV2uGtMIF7d63Dw9WfuL1
         N/XrFvEo9O+e6BHHrJ7kKteYLWDxbBa2K1RC0oosgXgM3ZW54PiHFLMZK1iW7KoRs2UQ
         y1ZUsK2kH05ak4fPflzn9B0hqWYW9km1aHTyEwiGh3xfxqc70F8AIZ4WS6CDPWC/UcAK
         Edib4ScMvB2nzRikNCEyJle+h+4bwQYWxqPF2/5t6tA3gI6nDGWTvhhTAxOPrO/5W7jd
         22cw==
X-Forwarded-Encrypted: i=1; AHgh+RrLPaeoTjo9vnFTNeW16OY6JgXOJS8N/jsv0q4Q1ClkUL1aQgoJB6zrAns2QeplXJ2UeNVHKJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2d1FEO/8rSaauh2sjyNvwxiYkSUZgbf6McarwgF3j9qPp5k6Z
	0CPnqa6v17f1TZvWS2Se6mRpOjSIwsaKtor6SY3E2dvzeFttDk8iFfIcanV+NMQVjxd1VBwBuQg
	c2t5fMywkKQ/zev7/is7oaJLc7TBjI+5ekztT03dr
X-Gm-Gg: AR+sD10Ho/BZOh0GvT19HVMmDw32eVUQwiLZIhNoSFGVcTf/VBPBVrXvKemIA8BByep
	JK0VuxL4Dd+B5KlfDvwvUEmSTQ26tU24bB/g5En1hA5QMM/ThZd6DNL02P/XZEBRE/tLuDabVir
	RvieeA8BJuYOpEHnmm+PhYXk6FJ09djMrGg4NDcUeNB4z9sX1PGXDU20UOkwg5nNSD5OCfjTN/T
	A6tQr965ihiWJYS5es5vI0cWwy534/+bEJXuRdbYI6iKq5/wOtfiGRxfYln4qRhVqPUyXXQPlXQ
	e1quOKF3CUYjZJaEZO7hNH2zsac5HHvpcG5Qw9q8IeqGgFA=
X-Received: by 2002:a05:690c:6d07:b0:81f:27f8:2de4 with SMTP id
 00721157ae682-81fd4a04799mr160372987b3.8.1785811544182; Mon, 03 Aug 2026
 19:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803141659.559129-1-akkun11.open@gmail.com> <20260803141659.559129-14-akkun11.open@gmail.com>
In-Reply-To: <20260803141659.559129-14-akkun11.open@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 4 Aug 2026 10:45:33 +0800
X-Gm-Features: AUfX_mwLcNdgKSX0dY1YbYf9cwLK9DsvJWUXl-Ukek71RJiEJ4s-l_75YEo7Ku0
Message-ID: <CAGXv+5HRsFFhzSYPdk-zmipLTVwxPkHLbuFP=wn_f_D+3ejAMQ@mail.gmail.com>
Subject: Re: [PATCH 13/32] clk: mediatek: mt2701: Switch to common
 probe/remove helpers
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>, Haotian Zhang <vulab@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	Miles Chen <miles.chen@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
	Sam Shih <sam.shih@mediatek.com>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:b|_)ptp(?:b|_)" <netdev@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:18=E2=80=AFPM Akari Tsuyukusa <akkun11.open@gmail=
.com> wrote:
>
> The MT2701 clock drivers can use the MediaTek clock framework
> common initialization sequence. Reduce boilerplate code by creating
> struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

For all the subsequent conversion patches, please try to mention _what_
led to the converted driver being able to use the common helpers, i.e.
what prevented it from being used before. Was it the PLL, or PLLFH, or
something else?

Details matter.


ChenYu
