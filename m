Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657B2472B6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604341; cv=none; b=hPmyq6O3yYiUdCTVUpSAvyZpnUAnFk/8OSF1z+qvwOEpRsMAicAlk1QTsu0aBVt/xdELb9sYl7pHC3/ED5W/1uWdpu6G+SMN+wE+qsiZEN3wrMKxU4aLz+b1gQ62Xgwei3rVzG0OiTBfmqpFyqHl4r77tDOmvkCLty6cetsMQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604341; c=relaxed/simple;
	bh=V5mgaYuiqmd19pVeUJ5dGhbcayqpVw+iFC/75yHxxBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikMPiZDv9+yMQ2w+xGPjH97l0ZDC1CG8wbwRFSZ/NIuwI/bawtjYmpdoO6h0gXkVlO6p1R+9EBKfbp+6e/gDlpOQemymPitq/cH82FgCXkWcmGvcZgHW0tvJP1dxxTpOnlmPKA1eTkODt0c1VO6n2Btch0gUFuDwRcZMR7nx6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik7K3Mhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik7K3Mhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646101F00898
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 20:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604340;
	bh=V5mgaYuiqmd19pVeUJ5dGhbcayqpVw+iFC/75yHxxBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ik7K3MhchNjzp7oJzyeWYk99BT9TlVXzAWEyDT8EH82JB+UMH/vHBhITSwqbwupG0
	 Tzv58ZEzIrm+JhjvsY7CwbEyagNEWSKp0T9B+24ZRSzADZrE6WJa79fKI/sFvFIKIq
	 l6C4ut98mVF7Kw6wney7K40DD4PLql+Q9Aq9YprJrsQp9DuF/HjHl8gkLxvJheHbX5
	 4jV38iAX38+8axGVZ0SmTsZF4WC8ZvXKhE59Ky+bxYYO4JpRGuRAUgT3vuGxGUUKHI
	 T9UoZ5ldhIYUxEjHHx9MA6/mT0x7mvA5vdgWhzuXdwgzRaUaTSjaT7WsIVsvr+08/+
	 z+sdRHNEcoCvA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so1339679e87.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 13:19:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxd6PdwHlXi8HRtoOskvivjwiDTRNbQSjlTi3YFlQpPPbLuRaZL
	zpblhBrxm+WFyv+Z+n8OITicBFW7uWlhI4kq22Bp6Tli2EiNEMnkMtVPUu+g0Ugo0/KMzOoI59e
	jloCuyMHn83Bjecv4HbJyOctMEEM9RrQ=
X-Received: by 2002:a05:6512:618:10b0:5aa:7129:5d43 with SMTP id
 2adb3069b0e04-5aa87bdd16dmr62668e87.26.1780604338984; Thu, 04 Jun 2026
 13:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260603112011.230890-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 4 Jun 2026 22:18:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLnQ5QcQfFTs1BfcksCxOXEqJytn3vzk_T0EC-_xxfL=NQ@mail.gmail.com>
X-Gm-Features: AVVi8CeSPVpiXKe85C9yVyyXm1naefk2QAZFsVkjRKVNOeDlmCJdQwlc-XPTnpQ
Message-ID: <CAD++jLnQ5QcQfFTs1BfcksCxOXEqJytn3vzk_T0EC-_xxfL=NQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: realtek: Use %pM format
 specifier for MAC addresses
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert to %pM instead of using custom code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
