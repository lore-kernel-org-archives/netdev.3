Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793164BD79F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212714; cv=none; b=H4lW3J4fm7jFwiOzqJA+RdKCntpkI0S2iVyUNBwIiZUJThZ5LlYzpOsJNjkxt2i8i9DVkDQQxNI196FJr2q5Op8ysCxFUO71Rz17Yc5Ei9umNB1Ssqwkj3z047DmuDJRAEt8rEsfUY1tCU0fpCTXQCKV05VoQCfOghHRnD8eCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212714; c=relaxed/simple;
	bh=xFKS5db6FJARUVZwub9vg2Ho3lvPbwx9BtDaIgasIxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML/mousSPL2V9aDOY5CP30cccaQjZ6K8EdZ/iouf52trlzhI1g47EAIxLR6cXg3Rsxw39dWBYhz2FwoElNhEeKaYF9uFZsRWz7gbfF/lcd+WWkPuKvmoWM24XwiXllfC8GpMlKbFDtQhEpUa7nlS7eokBA+oSAGfinxwiolU9WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0vqcfHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0vqcfHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B5D1F00899
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212713;
	bh=xFKS5db6FJARUVZwub9vg2Ho3lvPbwx9BtDaIgasIxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=F0vqcfHBIQXIO76oeYHHsA1ZYC4zVdggtVE16EbWrQmhKsjGrVNwFNSgEmCaknjmU
	 5pCsf4UeGMrxd+M1QE7vg48lb3gebGlBFpRIjSPLSJa+GeF3vZr5GkAU8xfZAf0oCP
	 tnJaGY6DMQB8PqLCjEY9QpS3HmVlrO5nGHJvPnYsXkpDAlGC1Z+48Pl/pVVk6Z5qxo
	 AbtwCTYOARfOpaDIdGzhAgsWlI7VUoTD2NkaaYsADoc7mp5mo9UUAIDgNdrbpEzG64
	 sKcOZFcPgq9hIeCKOW+0e321CCqkVR8yjHO/X7mgS8hraxx0rlxpPyrC9Asvwv4MCH
	 nh+0TlCxlRdTw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcbb82dbadso416370e87.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:05:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxqOq628ntKFufwjbtbk/PqEalo4rH941M/z9MEuIntzxymWu0I+6Tcw2CWBlX9YJU4D5aQYA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbXD1BLnCKpkTTrXlD2YyjsNpIvenqQ1XB0E+J/EquboEg+DPX
	6zVh3q3Trc95p55IUTffs40HE0SVAgk0GnPH06Dag0uTb5IBw64zWrhUEMwfYrl3Zguy8Z9gAua
	weHLDVt+XI0J1koR5dxeKuE5tfi01w9U=
X-Received: by 2002:a05:6512:3b24:b0:5b6:1a7c:aa24 with SMTP id
 2adb3069b0e04-5bcb5478631mr2882588e87.60.1791212711924; Mon, 05 Oct 2026
 08:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-2-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-2-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 17:04:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLmpBidVbFqSTDp673G2gQNXJ4EWjp+Xo07ha59mLJ1qrQ@mail.gmail.com>
X-Gm-Features: AclHuK-bY4nHdnZR6A07ZKd_LnLCM6ydThaw99Alm8EJguCM6N1_bOHpgC5IlG8
Message-ID: <CAD++jLmpBidVbFqSTDp673G2gQNXJ4EWjp+Xo07ha59mLJ1qrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/8] net: ieee8021q: print traffic type and
 queue count with %u
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

> Switch the out-of-range diagnostic in ieee8021q_tt_to_tc() from %d to
> %u. The traffic class count num_queues is an unsigned int and the
> traffic type is an enumeration, so printing them as unsigned matches
> their types. The print sits on the range-check error path, which still
> rejects a negative traffic type; %u only changes how an out-of-range
> value is rendered, not which values are rejected.
>
> Preparation for the inverse helper added next, which follows the same
> convention.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
