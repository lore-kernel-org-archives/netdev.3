Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2551E458
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984181; cv=pass; b=Iouu2rmtsETI5wsRQH+hu7G9cHp58iaD7T9t/5DfEWJKwnitJgLzzkDVIHPOpZRKpUZFh2npJp1gyyvk9EY8Vl4jSlZCDNCoQtD/aePOK4LcnoKlzxdDG9xQBGzqpXAnbqb0rtj96jXZDZvS3AcM4FyPI0hZckp8KFy1QKN7z/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984181; c=relaxed/simple;
	bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKQ9BlVt/RUgxtx6htdoih2N2ok2wVIGjk7bN7GlDp2XOnpAXvI3jAbUl32IWyfMjtTLOn1TKIgNQsHygGlbhCKlO9l3pG//j1SPe9i1Ij0mCjpncnO4T1V/MJ4CFe9PpMmMnWkzFZuQRl1Zv0rNz2kjMLBKmPsNMqTRsuKDaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J61v5yps; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J61v5yps"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso3691695e87.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984176; cv=none;
        d=google.com; s=arc-20260327;
        b=L04CCqiQD3CUi+f3y+BJ7hqXIis+fX7NhVsNAVfr9mPcwi/CfPXyO0s1WLUwPYsXY1
         ZjODCZx3pb7GJnbnQbPVxplPBZiPz/tLTFfejYBWDxtt/V7kf3KCoD3Hd247TwCK16EQ
         PNV6kLEiAO0TC/150jYoBRbTd12ixZxirZz9AjLr19M+0vc1dLOcps5zmX9NN5OrUKbE
         KjlP3GWFrz/VwhxbGXxbYoDwQ0Yl7UQCcDZ82nktazvk2amNLn7FQKUndhvBdKK5Y2dZ
         E4RBTM6NhNe47EDo3FAPt/LMTbjK8Fo/+HBoKllZ86Z0cF1WzctZYWrvXX7TsY8ORgKT
         avmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
        fh=o2XU+QqyMwoeJGcGY7pQf8FQaXWD6uUVIixyd+hNxsw=;
        b=D5QUNTfHarQVmIqpWTocxfxHH2ETi1hJZFlZFiGFbwMfHcD3/wjsNFz4YDfgUk1YDm
         gM2kwz9WpGx+wRKv5fr0sL+wehnB2bmaw+Yu7EMW6ADAWbPdXdVTVZwiCKdZpJzEzHfV
         atW/bkp/w12EdW0ETMJSWcaK6jPhCZHHeC8MXb4cgdSv4wm0OI8wiA5yecAuU0NLpPiH
         4Ch4MK10cAerZaprJP41hN5EUV0b3dPV2ZAcGL88+ouNOVWIDAWSndWIwZqhb7D7CR1G
         mynJbEWTswCKnvocDD3envdfaOxU/gWaMAJ0dhDcCSaGAch+EIUu5Mj7zetJbf2M4MfP
         KUiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984176; x=1792588976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
        b=J61v5ypskIS88w0cB4ewIfhQRL90OmfqKQ4h4DvaLaYK8JDgi/I2c3uInGEcgeRxuK
         Ysd+KkoAQbeXeIB5GX6rk7pNQ3+ibVf+jY5zDVRnwnta+FrdZseCAykos19ieLtKmqsZ
         gHTyUhVcMR63qZk97wzBCxftedd4nUNZSQrashIQM44S6dkg8n+F79IQ0VLOZDWK+cWH
         /gb+Fb4I7jwHN1gwRjw28DPuVGBjjt64g8p/riQWr+30iEwhCeInwZZ6Ioc3uaLcY+P3
         Wc4s8QA4GLJ1ogiTNrdRw0vs8Di2kfBqqsp9Lt4fLorh1nCwOtLCOqkp7XeQim3QtYvo
         677g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984176; x=1792588976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sx62d86u+TFaCg/f+CExTaHz5XyZuk82UhxVFxnoojA=;
        b=DF6REP6FV5qnT5Res6VHlruVJg6aqM6TruwEyq3oyyn9IFqFS2J1wFozuKP+Gpelua
         NZfaigIfafLNV1w3y7h9mbdF3W89ozf90tVSLFAyquLHWnE/vlqyUXzB1eP2ohxpzCzF
         olsdc4weus4YdlxrqutjNy9157Mt5slMeeZYhHDeQElZ0DsJ6dKopxkc36tYc2/ewtWp
         XfBvhcusM70I3ZJWIm0AyAh9GWiMWLZ5mUjVfRNIIT4fhVtysQu5ZyEFLWkpmL2Lsjum
         2wehzAclfYbVziRNPaH+xezo9lUBkoVb6h9+y0RjlDO5xHFoY6xz8k+yMOoaZ80kxjPi
         0wKw==
X-Gm-Message-State: AFq9FYKwt8MNYxbJsYOSNoAijXpcxJQHrhTCPYymJjTEQlL70jSRe4ZO
	AQ68046Swhjd7ZbyedC0HbwDBWfby2ABXsYOIQDH28WPNd/YjDKi2Q56VTF0/Ww1jHL4XBzab3F
	m2iQnMB//5t92C+D6vmIurkEzyyspe+g=
X-Gm-Gg: AYBFou06uGlR1fnd+YokaW1JFygq7CbXhCswgPBHUTaZAqp6ZhqNVWkaUSEmdRv9uMb
	4Yk1Uon+b+Os5H0hZmx6/VnlGG/XokAIQlTcwiTUPLkJhyEgnVO3zbFV8VzcxVO9wSdFjejNNnJ
	QWXtLgMGDt9I1jSZRbsPTN4t+lsqVCf57lnyZOh+s/DnypxjT23/knAcM0jnWGAfJt1Uj2d0AoG
	K148eFWZ5VZH0EPQi+fXB5a0Jo6j4cykoqm/qy/2vIUVsvpOSh0KE6gZrKMadoxiIfBrYfL6/3K
	mSiDj8aUK/eJhgsJIaBBAVXNIgCU4XUJ6wr6MWhq62GkCilDT7bORAeyzGA7/hkoq2CjM5cGBd8
	ApoXKojE6dErD3bnktHHNPBWyDy7udbKcfECydc8z0VBKZ23YFrqGwDHVFEg5ICSx4Be1Wuc=
X-Received: by 2002:a05:6512:6c8:b0:5b8:edc5:c9f4 with SMTP id
 2adb3069b0e04-5bcde6b4009mr5690761e87.13.1791984176053; Wed, 14 Oct 2026
 06:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
In-Reply-To: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Oct 2026 21:22:17 +0800
X-Gm-Features: AclHuK_CZ8InuoWyy3gcmsKZkLS2hm7xv53f53O43urLI2AeK5PGKE-WHdvjfa8
Message-ID: <CAL+tcoCsz08UKVci6y0BDsEbfhsEzn_F_C63pwSNh8GwswHA1A@mail.gmail.com>
Subject: Re: [PATCH net v3] xsk: freeze deferred pool teardown without
 blocking unregister
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:38=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
> not frozen during system sleep, so that callback can run after a
> device has suspended and gated its clocks. Use system_freezable_wq
> so running destruction finishes before device suspend and new work
> waits until process thaw.
>
> Keep assigned pools visible to NETDEV_UNREGISTER independently of
> the socket list. A released socket has already left that list, but
> its final pool put can queue destruction after workqueues freeze.
> A resume-time unregister would then wait for a device reference
> whose release cannot run until the resume completes.
>
> Track assigned pools per netdev with netdev operations locking and detach
> remaining pools after the notifier socket walk, including copy-mode pools=
.
> This also covers leased queues without scanning pools from unrelated
> devices or network namespaces. Remove the entry on assignment failure and
> normal teardown. The deferred worker still owns the pool and later observ=
es
> the cleared device pointer, avoiding a second driver detach or put.
>
> The lifetime problem was identified by code inspection of the deferred
> release and system-sleep paths.
>
> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from=
 umem")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Admittedly it's a bit hard to review the complex logic. Thanks for the work=
!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
