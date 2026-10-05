Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363F4B404E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212859; cv=none; b=gTgowOGgJ4KVVn6MD5nzrUDuSMNzZ3IQjVa4U91iu04CaZFsBuVKYg1s1gOSIZ5un3BrEhDSJQVGtJ/I3cYnALvQFTNyqofN8M5cdC15Wa4Id1vnj4WmACaRrpE1CkzjwIxtBNxw/qmfSiKSR5LGK7GFqtvT1vwin4o8oQN1ujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212859; c=relaxed/simple;
	bh=T0OXFa+mXAeQ3M8jCXJNmpFI4GDA0qxQngdZvXhQrhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGrGlfuZJ4jz18u2V8QYtR3S6Ff3FZjgUOO4SvJ2sghV8+pZiRytaGN9z7wNdZ4ypUTLNakOyGyFVWFsjDzK1fe746qnvTlNHlM9zkWPRN91sXfYqCF2pVtP1ywnyCvp0M95bQziU5m9vnounv4XqjZZO6KjS5XP+83CzgU7NPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMtV1l53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMtV1l53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2431F008A1
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212857;
	bh=T0OXFa+mXAeQ3M8jCXJNmpFI4GDA0qxQngdZvXhQrhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BMtV1l53yN1bhr6uYtM0QWSj8D+e+D9fcs78ALD068tVhMIe5fDG/NqgDZjXJt62s
	 n/7njLf13HPwDHvC1LjeEyH2Qa7KexZruBJZ0Dy7XUF+z2tbBcbjGvPVv+cDH0wvw6
	 LiWgCM3yLTJXDYCltefoW2WTXPijAuKt4j2eEAyvgvY7DNFUTRE5CAnyDK7RCy2/9x
	 67L0qyzcazsPuaF459t/UN6oBnhRlh9NibtT2PF7dFH3i5ErkG/vYo6P7LBJMdzsXN
	 ZzmTKEe668YNu0BXIGr+o66rWlHI12sIl2DfC8YYpMtGmLXM03Lb72cELQGpVSAk3+
	 QfJfiE3v5Z0dQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e548cd7dso18177631fa.3
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:07:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxTXbuW1PuE0/5Fi5ZpMHocljdIsgxOejQEjsyiXBtaxpbZZuN79jala2NUlpEak4qXf7IwyPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5W5YwL4fck3d+bpeBqChoIpm9iyMWpQqZoiUZKJKSR1fUlNwb
	nL4HOXZMGar5kQMMYU4h7KMV+/ytirNSOxbOkfisYEEbgIb1zHodV/KVmqgXwYkfMlwjgnmuTy6
	oLcVlpFLRrkkoUrGeiujLXHZ+mlOVUbU=
X-Received: by 2002:a05:651c:546:b0:3a7:e737:c401 with SMTP id
 38308e7fff4ca-3a8877acb50mr32070981fa.17.1791212856518; Mon, 05 Oct 2026
 08:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-4-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-4-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 17:07:23 +0200
X-Gmail-Original-Message-ID: <CAD++jLkA7C+jME-hD8wp6TqvHhTuxa4rixet7iUPF6GQqvMY6A@mail.gmail.com>
X-Gm-Features: AclHuK_2h-tnF31VgHYkyk1UVtMgVNcobZTrWTO18GrUR2fIUgPYNk95Uc_bjQA
Message-ID: <CAD++jLkA7C+jME-hD8wp6TqvHhTuxa4rixet7iUPF6GQqvMY6A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/8] net: ieee8021q: clarify the tt_to_tc()
 traffic-class mapping
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:

> Document that the tt_to_tc() traffic-class numbers are the pre-computed
> composition of Table I-2 (traffic type -> priority) with Table 8-5
> (priority -> traffic class). Note that Table 8-5 is the mapping for
> implementations without the credit-based shaper, so the helper's scope
> is clear; credit-based-shaper implementations use Table 34-1/34-2
> instead.
>
> The existing kdoc cited Annex I Table I-1 as the mapping basis, but
> Table I-1 only partitions traffic types into classes; it does not assign
> the class numbers.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
