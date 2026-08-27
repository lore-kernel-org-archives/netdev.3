Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645A26738D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814204; cv=none; b=gw1piCH4rcHRUjmx0MSUvk0lClBRPtHUx+ArhnRvTkCCIm4gycfrVarKtg7Y5K79U1os8I+hOzli+Pt7DMHv6pdByHgbLbJIIU9EdxNRd9kusV4aKAafgT7YGZKVu4yYl4d5GAqrDQNBZFT41mfxkVXvewCaKH2bBR7RNuDnchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814204; c=relaxed/simple;
	bh=W9nnWcgoWlf1wj4Ru9lPZhKoaI/HWiFsPFG1d4YLYUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEBrwWSmzvzRwplIMtUQuH2PuSiKmlAFExM6KkSvEqI3jWQ1DSlqOYX1wZRAkfJv7xuHiJFt/cA0Uo2xz1RKabhJ3OA3zlxKRocquUICSTNzngJvf4d3OC4QdtsAL12lGU8ojwRNDbPR5TMUa9YQyr49jtQPqW7XUVszwQ66t4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1slLTVK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1slLTVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0459E1F00A3A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814202;
	bh=W9nnWcgoWlf1wj4Ru9lPZhKoaI/HWiFsPFG1d4YLYUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f1slLTVK5sOuTkChpV90e3DKl7/kNzM1KMBwHGZQZoUyyqJHbNTt7MGeP1sZ0F8cs
	 KlPAXd3JbinXyNx3rIbZqPVU250WgGTFTVZJr5T754vN4fo8XJVligXsLwUBkkVIYJ
	 MppRFWD4osfzNVlvQlKiFCbB0p0U5YQ70ILiLBKlWEcg0TUzPhM6EIvTwnqYfFG7KB
	 F9f8bqudjwaCsUT4aekgCLh7HuBlHwwKWSYiTy9Cy4rC3V123cwjv/M1nSCweoD1XY
	 srY3qAbdk3maGHb3o//bAzFX/fB4t5xHp6Q4wZTzBX3Jj6iL3JHqsSiUOnSGcCjU3t
	 wFyjWCsT7qXSw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so350614e87.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:03:21 -0700 (PDT)
X-Gm-Message-State: AFuF++ljjHL+wqUgnYwBR1ge8jgJv5rc9iU9n1W7i2F5663wNxoRd1OB
	4KRunTv1LFq1PWmup3Vu52ET/9flVXG+fEyr2rC8FgjPtmang86bNq7o57aFpSfhd9Ge+s6xmHI
	EAGeSuKW++LySHp80625DR62gPPD4bXo=
X-Received: by 2002:ac2:51d1:0:b0:5b5:e263:dcc7 with SMTP id
 2adb3069b0e04-5b5e263e266mr28670e87.5.1787814200712; Thu, 27 Aug 2026
 00:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827013634.167932-1-rosenp@gmail.com>
In-Reply-To: <20260827013634.167932-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 27 Aug 2026 09:03:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=8OfNw_uBoJNphoJXZvu7ws-9iUBYy-Z9=YOp0XA7mqg@mail.gmail.com>
X-Gm-Features: AcwNN1WGux25MIiGrEnw-amtAQmQ3YQ-7vY1ZVAQBSZKJAotasia4tMjWPJsinA
Message-ID: <CAD++jL=8OfNw_uBoJNphoJXZvu7ws-9iUBYy-Z9=YOp0XA7mqg@mail.gmail.com>
Subject: Re: [PATCH net] net: ixp4xx_eth: handle probe deferral from of_get_mac_address()
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:ARM/INTEL IXP4XX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:36=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> ixp4xx_of_get_platdata() returns NULL on failure, which the probe convert=
s
> to -ENODEV, discarding the real cause of the failure. Return ERR_PTR()
> with the appropriate error so callers can distinguish cases such as
> missing DT properties (-EINVAL) and, importantly, handle -EPROBE_DEFER
> from of_get_mac_address().
>
> Fixes: 95aafe911db6 ("net: ethernet: ixp4xx: Support device tree probing"=
)
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Thanks Rosen!
Linus Walleij
