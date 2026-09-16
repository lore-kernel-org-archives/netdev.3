Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FC3BCD13
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528361; cv=pass; b=RQ1nVFx/Vobu/dsBiXM/C9csbdChsDpu/jZB6hIrW1l0iinxGgHnjsKc1jdss8FJDQKwFskZsodSCP8ZS63Dfl+P4Tv/KLNjhaNSrFpciRbJ+B/DaA6keAICu7zKVZBU0l+0X1nHBdOtXTgH/u5YnTNwBs98kEldhTrxyVAkIQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528361; c=relaxed/simple;
	bh=rOA+W2OAbrZJ/yGP7NnAmIaJwzKfjJWJXYt5I5goVnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtfsCrgR46GAj/3y0Zsb2zaM7oIa7PK+YUEY7bxSpAdu4E7fYlvMO3Z8T2jlxaLhtg/SRcCZB6Sn4UuKs/t8f3KE+UWISfcKAJdJ187H+0ay1UeSV+BYOFfQqWEKIhNcPqR9bHFU4S+qmdsl5Oo3kj8+GWhBIkJAb4vOol6xpuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6bxraIy; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6bxraIy"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e53002bso256339e0c.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789528355; cv=none;
        d=google.com; s=arc-20260327;
        b=GUNL4iw595s4CxZT6ygNV1qg+qQuuvXt5ZQhakalUe8DvFYYL8XuMAXTztmjWzMnF9
         zfSCevw+Pdza/7FQMBaswrtJvLij/Ysv5ijJ2oHXXuomsUGTyFvjzBowPupg9EYd/9cw
         f0+00bCGZyyhbJwy7QfR71M2fCRgrNWHwqjoU7983HI1qi9MI+aohJrlL532g1tMxUta
         gO2dudQpCTD1QmfpdECAOruCCymgI7uMq5h1xkPZkjRCNt6cKkNNz1c+bVhRSOTqleuI
         gSPlPPrOCCsmvhTEemALxfFym1i0z3HI90itSooxyJHfuzpcw5yiZYwXJyM+JjvY/k1C
         aC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rOA+W2OAbrZJ/yGP7NnAmIaJwzKfjJWJXYt5I5goVnU=;
        fh=c7r1d2us13W43y//yvz1r3j4l6bpIDFE8neO1W9Xtqc=;
        b=I6N/3PgxQQmZOTp8H4Qr3o+CbkA3inJrYNcnXjhOiUXsVRQ9QLxWZpYXH4f7aP4TIm
         yJBbHi3VuNxbAQ+GdajEWZFg87FFoVqDwkK7XO9MuKYQhjR1Z79DyYTRyI7AjQmnGVC6
         1dxRbEYRqzF4H/fGM+Ev+XK9DSpmbhslK4SilW7Nn2YPsas1gA/f67khzGc4ED9AEh6Z
         D0Wic7DEQ8a1/pDx+z6yc1DHmgcDtY90NloxIxLh/iDXLTFrY3B5sTgPAWG3aw2E5Nby
         qX2QNlUgmx8qdYcmrfJkwCreZiiiLp8xDNZgDb9okfgXmP3JVCbw7B0oeeSlrBmtc0Ic
         66Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528355; x=1790133155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOA+W2OAbrZJ/yGP7NnAmIaJwzKfjJWJXYt5I5goVnU=;
        b=m6bxraIyTcGI9du0PoSBP2t6QxvgZ9A02mIlBBD3zA0gUDm01z653PkvQFqEgiLUYa
         nucedVD6qrIk1Jeem3rRD/YUqYsonICn7IHpfsXJS4SvPHNet9CG4u3dafStbV9JFSDj
         oKZSIbMxwrtqbj/fsEY15fJQzs5yq7ftsONkHFcddSN8wwqAe91vi7fK29ycnd9GYIFi
         dqciC7bFsFnP8PXZsGkPsIu2c7fvAAt/lovDmFbyi5Tl25pRAmeqoeoiV5LPRzs/qQT7
         GU/Z4F1TYKSYIQxP690pkto6rFnNDCV6YBEdfPx4tM87g8DGE8/sLzD8FeC58kWG7AKI
         aOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528355; x=1790133155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOA+W2OAbrZJ/yGP7NnAmIaJwzKfjJWJXYt5I5goVnU=;
        b=nAPotZ0vp0GFKEUGIZ6C5qPGMaXW6KIkrO3xKQ4Mqm/T60UcLR0XN0ia38Cf6btMkV
         hmCrIy2AVfrtzzy8aEtUeVydBadkJpOVwBwaatvOn3olMyvB2IK5fmKOaUmYwNYqAn6Y
         BC6fPjqVK7g9AFzTIUVrgbKF5fVM6OzHT9bx5DgJkdayfsAPJNBPiPwxqcUrovSwhQTM
         j3kU1Blp54NEC9VmjfTFkA9+NGj9X2+EQUCW7Oi2J7A7ZUSQXelQhgIgio6gh1BK7BMc
         ZvI1wtgyeudDZ5V+NR/c9HG/ld9FUHKbW/d/yAdi+qECGhy+LQ0UAjRoI7ShQcZAvTPR
         Ankg==
X-Forwarded-Encrypted: i=1; AKwUvBwa8dvESDcrdL5rNrq3xOzC89OKHYyQ4QUUqsUo/tGygGWzqUY8o/U917qcx8yWQG3g3ARAMok=@vger.kernel.org
X-Gm-Message-State: AFuF++kZtyIcE++fWvUyTprZ7DUTAE/h+6FITwH6iWaXnyZDmsXWss9k
	nAcZFR3228JEGnR7R8513sCtyWJCoLTVCi1zQNpcyXTgxsvU44sPKjX8+GqgBhKixTVIHCcQGm7
	KiV0ukXYsu+Uz6/v8pJT47EffqMW8miY=
X-Gm-Gg: AYBFou17puZbjnQn15UFJO1WQ12DHV7N5KuZ+/2AfpUb2GF6PyTf5qWylIdPlO8Bu6U
	gM9ONwwWIp6aYNr5STdGGqDa2tT01syBNh3yIBA2XJMpqEyhN38gFwG7pimIpilTJ53zSZGW62O
	I3vhbVSieIWGMq5dWl2p5k3YRXoAMLWA4o7IgeABPMEFui6LCivkUXv0q+RCtdGGs6lFNrjdtrV
	6WWuphDMTRPQIV1IBEhlBC1W0dnm0SDFVglQE0uvgxzoOCFgeedG6L6KJKmZKD95HFQxfAsqqVf
	OkoimvfZZAWDiVab/4IZRFI3dSU0caErW7L3gVKL8zQxliYO6RqcRYHsLZ8fVCQ+jbH7ZdTlh0l
	go4QP3en5ssLWcWV6oojYDR2gOu+c/c/IZRrsmDEwVCZPz84ma9J3OofoJugPPZYhj6kNigGJDh
	wDIx/daKPHGIsK+07MAcCieATngbEygJ5opJJzYFc4mgX3
X-Received: by 2002:a05:6122:8b11:b0:5c6:64ac:d6f3 with SMTP id
 71dfb90a1353d-5c99accf34amr894249e0c.3.1789528355167; Tue, 15 Sep 2026
 20:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-submit-h616-emac1-v1-v1-0-195de0bb1f8a@gmail.com>
 <20260915-submit-h616-emac1-v1-v1-1-195de0bb1f8a@gmail.com> <5df35a3e-d2c6-4576-868f-d3194de3deb0@bootlin.com>
In-Reply-To: <5df35a3e-d2c6-4576-868f-d3194de3deb0@bootlin.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 15 Sep 2026 21:12:22 -0600
X-Gm-Features: AcwNN1VnOu-2I6GbVq8WQF9CNqEg1e8Y093roZVmrwYp1oBZ-wfj7f7of1XAwLo
Message-ID: <CADvTj4p6RRcr7jb5hJCveeniHC81gkzHxLrPA0T53+VVUrKAZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: allwinner: add H616 EMAC1
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 2:33=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi James,
>
> On 9/15/26 21:03, James Hilliard wrote:
> > The H616 secondary EMAC uses a separate system-control clock register
> > and supports only RMII at 10/100 Mbps. Add its distinct compatible
> > without an older fallback, since using the primary EMAC clock register
> > would not work.
> >
> > Constrain the PHY interface mode to RMII, matching the hardware. The
> > EMAC1 clock register also retains the three-bit TX and five-bit RX dela=
y
> > chains, so allow the existing Allwinner delay properties for this
> > compatible.
>
> I don't think there's such a thing as RMII delays. RMII has a single
> clock, contrary to RGMII that has a TX and a RX clock with a 2ns delay
> between clock and data.
>
> I think it's just a leftover in this IP from the other variants that
> can do RGMII ? You should just be able to drop the comment changes here,
> and same goes for the dwmac patch.

Yeah, looks like most but not all vendor driver variants had RMII delays
configured here, I did test and it doesn't seem to be needed so I went
ahead and dropped the delays in my v2. So yeah, seems to have been
just a leftover config.

>
> Maxime
>
