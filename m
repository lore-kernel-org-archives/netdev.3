Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97B451998
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350144; cv=pass; b=pWO6ovTp6fQJcFNsMA1fzgxxLLl0NwoxZnLE7t3k5VPYyc8DsaRxWWr5QmEdRO/J71rTihcwhs7pLNL2hpQCUZ1dkQGMWsw+9Qpd/2ZvwzgBPoVusCS+kLNJ2NnpWnShU4+mYPLvTG1QT6TI1M+AeUjR9312BmAu76O+HOrqc4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350144; c=relaxed/simple;
	bh=K2A46vodldr3zjhnPxMOzK1lbcWwBnk2RrXrRQ8CJ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9rIYqIVyLtEtnsLWQ2f+jVIyUarsLHq8yWIAs43V3Oo3zZPd5a6gKhkM1SJZPppICbqOC9a81T+0gex5FQhmV58wk4E+vi2Y8ion1nYMWzLUNKDZdlGcd4x68ogOdEy+Av1hFq6wLbXa/QYdJqAm0i16ZNTdZ/y8gSnNFgnfLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Kh/dTbeo; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Kh/dTbeo"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc97653887so15767025ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785350142; cv=none;
        d=google.com; s=arc-20260327;
        b=d5IbmOaYE7bwWVI6oxgp6pGzVpOP6cH8mGdFOWu8W7Exfphaw9fsFg1s16RmVGTYU1
         3CFIswQgLrtrATdS26CDtCX4TOhxXA6jQyY61QKPvqgZFoc43rrLutR6uGIzYKOVu+AE
         1c0KZmkrI0C40RdwZFhXCD1Sf8GvYRESrf1uAQOmTzMIrnY5zxrzNKTGoMp9LlOtZIFL
         xkl2Bj5swlowIGTNti2G5W9p0LZKia7YujQoyTYwCIX5tL2N6QNsAfg/uCGw+tLW0hSc
         xlH8Nnss/rj8T8S+VLB5ENUSQNWujF50Ea7vtt0wEbBrPS8hTUqpon3liQKFfUQr94O9
         RZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7iSVz7fWxSoJFFYtPwP4JmU7+OsMyUeclTGP9uHwFK4=;
        fh=jvfkrwy9hO5fMs7LxY4IvxOijmHWHvnpejx/V/4Wr1E=;
        b=KaS4zm+CkzQMjeCCz2CjdgHykRcJj3K3gOUsRTGyw3OpT5/746YbbwLao8mF6GooLV
         PeXH/ASk+HD2bSF/EgXv9Kx9y+jks5eNo4rSrdkErJycQ5vXq7ERkv27gPic6nUYFb6i
         Y7qN6/VJftIl6KqbXb3nNuih4FMALML54Bgpah/ImBdzXwmvd2spNWYekas1AtSov8KC
         6lOGscvNSjoPBYT6nfIcunEXZNy8DtzTBGzqJWl6zjU0ua3IWJtHoHtylMH/6G/8y2j5
         jC3dkqj1G22EVogViFAx1kGIcXMup4kkPR8vCnlCns4AF6Bj3f0tooBJjdS61lEfWkWU
         oeCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785350142; x=1785954942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7iSVz7fWxSoJFFYtPwP4JmU7+OsMyUeclTGP9uHwFK4=;
        b=Kh/dTbeo/GoDGBqVPzfJNNlt+Krs+CJUMULfVHK6dso+hnWiClyLFAedxOiPtEyvHE
         3/itALgdyhlTHmGFzi5WB6WtrK0QEFGYrIp+HuhfPVVB/PXmQSvMfgs8iPX6KMbIJKTz
         AI+ZLGLVn7loD4mT8M7MHjDvSRG+wqv8O1Ah9/x9pvVffCaoGu+RyZBAWr/MpWlVtJ+3
         bIC2ymxkCDmEnyTagu1oztZmelrqCSbwmLaRWpOK55q9bjhmaoBxdCWbWxM2GXRbgKHV
         8kApX1S4OCPog3FG1I6AfxCmgXM+qsb/UkLo3vU4vzs/HHUlXHMitVvx5o05mxg4xv8G
         wcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350142; x=1785954942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iSVz7fWxSoJFFYtPwP4JmU7+OsMyUeclTGP9uHwFK4=;
        b=jn6Qu0hVNFBJcmKUblVWyGLH9TIGSuHCgX68OitVI2ZwLz/tLuTGbf17wt3ic5VKvy
         f+Vj7xyMC28mOUNiYwJEWrBeHdD7mBNV+86BIB+eMx2tHUrh5VOWiwy2TYWm8fgePhdU
         jG/mVT6wvbI3y7oFm3WZ3CmZI4ipDTha5HW4jw6RXpJBCPl8+OtvPETj1EpUkw2XLvE/
         2CsK/aHt1zHdzai9loCovp3HfwwuZi416CEOvQcwP5yUklxDt4XfO4fmYZBfmrd/Wtfd
         Cf/vrK1ur09w1//yZNm1sEFR6H8rhukqGE2Q10xArKjQ6QSEmXIMsKw555t3e4e01csS
         JIhg==
X-Forwarded-Encrypted: i=1; AHgh+RrNPkQpmueNHWGfYdtznXzAsr49J/0jXZdqzfMp9z5zjWP8iueSr3UFKyxRRLoOcTCQN8xy9lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPDb0+Kua6nn7/UqxGrJ3W0VrHU6e2y6c3tc54+gWRAjhRDGI
	csPvADjyTNHuCqTkHH76RZZ0zag6CPFg9VrLjbqxwGCxAhGpEMBH66BndRer4W4QmOj753kn2gS
	UjW6tsQzTk2GCi8vGIf0egui24ww7VyI3VNKJrKel
X-Gm-Gg: AR+sD12gecTr2I8Vr34pdU+ckioBgmTdYe0fR323ZxmCzP2k0P85HE5Zs39uxxW4FFv
	g3iDgHGdyL7M39o4nNXrXzUNOUKHWGzPfq6bgkfNuvuEBy7OCCVNP/vXYsBm1D/7W1yXIuJT6Qy
	qT6GHG9yCTzVRsa633ojegveRHaZEUxmN/MzeepKX2kFVY1zNqiUA0it6wjTnidFCEKB4D5jPb0
	E9vc6S7oK1cjE0IIGxkeYzoeyjJ5qJVhuFbBtszZ8idfFzxNK5wTBZb9q1gmsmT9egxFU2KvcyL
	M9mBYSoy8GxLQkFQKJ0GiOC2WurI/iZruBpgrzK8UiaWFPAf+KptKPKBIKozCJ8+BzJvRA+7RWx
	E
X-Received: by 2002:a17:903:2cd:b0:2c9:97a8:afe7 with SMTP id
 d9443c01a7336-2d015dbc94dmr81644895ad.42.1785350141726; Wed, 29 Jul 2026
 11:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726125447.32244-1-doruk@0sec.ai>
In-Reply-To: <20260726125447.32244-1-doruk@0sec.ai>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 29 Jul 2026 11:35:30 -0700
X-Gm-Features: AUfX_myaHLdCv3Lb2nOE4bSyNE__oMa_IdcLJ0A1PBlz7UZEyVJYRX8bgvK47PM
Message-ID: <CAPpSM+SScNvoK-RNo40DWe1_+5WnVZN8Fwp5KGJ8uXBx5Te8JA@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: require lower-netns admin for shared port settings
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, thomas.karlsson@paneda.se, 
	daniel@iogearbox.net, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 5:54=E2=80=AFAM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> A macvlan device can be moved to a network namespace whose user
> namespace does not administer the lower device. The rtnetlink
> changelink path checks CAP_NET_ADMIN only in the macvlan device network
> namespace. However, IFLA_MACVLAN_BC_QUEUE_LEN and
> IFLA_MACVLAN_BC_CUTOFF update macvlan_port fields shared by every
> macvlan on the lower device.
>
> A caller can also create a nested macvlan on the moved device.
> macvlan_common_newlink() resolves that device to the real lower device
> without rechecking access to its network namespace.
>
> Xiang Mei reported that a caller can set the shared broadcast queue
> length to U32_MAX from an unprivileged user namespace and grow the host
> backlog until OOM under an incoming broadcast flood. A fixed numeric
> limit was proposed, but legitimate deployments use queue lengths of
> 100000 or more.
>
> Require CAP_NET_ADMIN in the lower device network namespace for shared
> port changes and nested macvlan creation. Per-device settings remain
> available to an administrator of the macvlan device network namespace.
> This matches the permission model used by ipvlan.
>
> Found by 0sec automated security-research tooling (https://0sec.ai).
>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Closes: https://lore.kernel.org/r/20260706212556.3199234-1-xmei5@asu.edu

Hi Doruk, it's a real issue, but it's a different bug from mine. Can
you drop the reported-by/closes related to me?

The two cases differ in who the caller is. Yours is a caller who does not
administer the lower device. Mine administers everything involved: it
unshares a user+net namespace, creates a veth there, and puts the macvlan
on that veth.

I proved that it's a different bug by triggering the same crash on the
kernel with your patch:

```log
[   15.527061] Out of memory: Killed process 156 (exploit) total-vm:1044kB,=
 an0
[   15.570960] Out of memory: Killed process 155 (exploit) total-vm:1044kB,=
 an0
[   15.581119] Out of memory: Killed process 154 (exploit) total-vm:1044kB,=
 an0
[   15.586159] Out of memory: Killed process 153 (exploit) total-vm:1044kB,=
 an0
[   15.590773] Out of memory: Killed process 152 (exploit) total-vm:1044kB,=
 an0
[   15.596233] Out of memory: Killed process 151 (exploit) total-vm:1044kB,=
 an0
[   15.604532] Out of memory: Killed process 142 (exploit) total-vm:1044kB,=
 an0
[   15.610991] Out of memory: Killed process 141 (su) total-vm:4508kB, anon=
-rs0
[   15.688053] Out of memory: Killed process 130 (init.sh) total-vm:3992kB,=
 an0
[   15.723989] Kernel panic - not syncing: System is deadlocked on memory
[   15.725438] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.2.0-rc4+ #3 PR=
EEM
[   15.727084] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_=
cap4
[   15.729530] Call Trace:
[   15.730097]  <TASK>
[   15.730588]  vpanic+0x6b7/0x7a0
[   15.731311]  ? __pfx_vpanic+0x10/0x10
[   15.732133]  panic+0xca/0xd0
[   15.732793]  ? __pfx_panic+0x10/0x10
[   15.733602]  ? panic_on_this_cpu+0x1a/0x40
[   15.734510]  out_of_memory+0x121b/0x13a0
[   15.735385]  ? __pfx_out_of_memory+0x10/0x10
[   15.736343]  __alloc_frozen_pages_noprof+0x28df/0x3350
[   15.737463]  ? srso_alias_return_thunk+0x5/0xfbef5
[   15.738512]  ? blk_mq_flush_plug_list+0x1a5/0x6b0
[   15.739553]  ? submit_bio_noacct+0x270/0x1630
[   15.740520]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
...
```

> Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/net/macvlan.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 9a4bc99dbf53b..22f03b206c718 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1483,8 +1483,11 @@ int macvlan_common_newlink(struct net_device *dev,
>         /* When creating macvlans or macvtaps on top of other macvlans - =
use
>          * the real device as the lowerdev.
>          */
> -       if (netif_is_macvlan(lowerdev))
> +       if (netif_is_macvlan(lowerdev)) {
>                 lowerdev =3D macvlan_dev_real_dev(lowerdev);
> +               if (!rtnl_dev_link_net_capable(dev, dev_net(lowerdev)))
> +                       return -EPERM;
> +       }
>
>         if (!tb[IFLA_MTU])
>                 dev->mtu =3D lowerdev->mtu;
> @@ -1623,6 +1626,12 @@ static int macvlan_changelink(struct net_device *d=
ev,
>         enum macvlan_macaddr_mode macmode;
>         int ret;
>
> +       if (data &&
> +           (data[IFLA_MACVLAN_BC_QUEUE_LEN] ||
> +            data[IFLA_MACVLAN_BC_CUTOFF]) &&
> +           !rtnl_dev_link_net_capable(dev, dev_net(vlan->lowerdev)))
> +               return -EPERM;
> +
>         /* Validate mode, but don't set yet: setting flags may fail. */
>         if (data && data[IFLA_MACVLAN_MODE]) {
>                 set_mode =3D true;
> --
> 2.43.0
>
