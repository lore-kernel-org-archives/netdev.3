Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431A39B968
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714151; cv=none; b=f083jgHxUtnsaHxTq5ybP0rEY88Vvb6+ClLxoSpLXoGXCsbFBdNL05E6HWDYRQOw4VR1Qzi6uTw2sg+hebyGxVbQqYDBMs1/SfwIgfH00P2EbmwQ/7MZM1ul/D1wd9uKp3jYIyoDCZMvBtpdnhBskv8RaKQUN28WeW0CgCHskxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714151; c=relaxed/simple;
	bh=QYsDAO4cTFaw1BQ8xQpgh4ascM3Lw2+Du0hXvtOGUK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEY+42Xe2S4IuQiiRUw+FNZWIuBKJ6VaKoJlIxGxZK7Khsn8AP5kWadnWRHNaSwHJGfOoZXJ+xCTFpOc5zuITJzIYzvjlCxArP9vh+JU85G6iTjqKexx7yA90rNN/tyfPuvQgl1wOH5IEh6sMWBQthF08bWwspn0tqfuoNClfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSGBL+Pz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSGBL+Pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3488C19423
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772714150;
	bh=QYsDAO4cTFaw1BQ8xQpgh4ascM3Lw2+Du0hXvtOGUK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sSGBL+PzJD9pDLBK+BpAbW60gXwjn6LeO3ql1l4clj8LF1tIsoYnYTb21YJ08+qT+
	 Ch+o8M1BcofKabnLC5Q7tbhACjuCWdA+BoKFczsuPQrpBcnRMryjk7gLgWKyfgsOAS
	 wzVgfTX2Sj5zYo3QKoZ4i056R6cIKVL0hry0UCoC2w4i6Uy/pKPd4TABRyKW77XFg1
	 N/jvgLiNZAZHJeu9fCgMKrxyPVsQCjxxDMfblAS3Mad40O5+ceTVYXOht6208s8Q3D
	 wMyHH0UbrJwQxScGOKxjB3Z3XrhL9Yo5KiQJPxNVRPIYtoP7VhtMrr7Y/LXb2DKQCp
	 peeCJKjnGvglQ==
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64cb577e79cso8346251d50.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:35:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPqH8unkCsHZQxy3x1GSpPFm4VCNKm78qzM5fkL7v13k0tRE4BwhDvLw1pzPGKOBxGDGO8CRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgiCNF9ElpMh2n0cjRPFNIAvh3nlIzfqMEMaEhhOVdcsdWrSd
	m4eP+aM/wd1+qfzFleksRF9BDnHEbEbA+wAhzQbmuzjY+EswfKhK8i1Pb1kPnKUmZhBR08vkURY
	IlljX6g27mDh238sFnbJ18yrSC0b/41I=
X-Received: by 2002:a05:690e:140f:b0:649:eaa9:f252 with SMTP id
 956f58d0204a3-64cf9becd23mr4953724d50.53.1772714150075; Thu, 05 Mar 2026
 04:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1777BBA64A3D0F97+20260304105215.536399-1-xujialu@vimux.org> <815AD68AB84E0ECD+20260304110740.548318-1-xujialu@vimux.org>
In-Reply-To: <815AD68AB84E0ECD+20260304110740.548318-1-xujialu@vimux.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:35:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLme1FQsFBSnm5wv4sGz6rKu=8RPELCBKaSPsM6Y0XkVjw@mail.gmail.com>
X-Gm-Features: AaiRm53HEvefjIJ21IeyJXjS9e796eov08LiPI80EqQhJn-Z3TLk-6WhTJvpD2U
Message-ID: <CAD++jLme1FQsFBSnm5wv4sGz6rKu=8RPELCBKaSPsM6Y0XkVjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] nfc: s3fwrn5: convert to gpio descriptors
To: Jialu Xu <xujialu@vimux.org>
Cc: brgl@kernel.org, kees@kernel.org, krzk@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:08=E2=80=AFPM Jialu Xu <xujialu@vimux.org> wrote:

> Use <linux/gpio/consumer.h> instead of <linux/of_gpio.h>.

Talk some more in the commit message how you do this,
and add your Signed-off-by!

With those changes:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
