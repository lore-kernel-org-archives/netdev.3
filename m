Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4D409623
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981460; cv=none; b=QeLaie7gwojYfwZ51lw5SEOYLtl8egXGtp6K6o80w6yUYqpEbZ1E1Jn/ozfwfZn+YKCW7wbG39E8HBYvASrsP3PpvKFxGUdHpqNRNQE13LLDiJyfnu+ns+NQLM1rc2ypfTNTsPUNrMYKLP/n3vPDixofL73LhRsKc1oJid8nNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981460; c=relaxed/simple;
	bh=gOQOw/xrz+QT0S0/+opeHzOawNx941Mx3/ry05TRdE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH/qBAOluH2XzxnDvv2B+TOXje2T2trXtW3vnv360TIVMK/N7QzJqMRrYSFIM4ISHfXCFqley0XuXK9FVrJgjVSHgFdEAIaSnWaSolTuU38hw0+iqw8k9fcVQWfmDLu5YiZNeEFrvIM7kikVquBlKYq0/Ej74L9NwyVHKK9PiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv0cxc3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv0cxc3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414F11F0089B
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791981459;
	bh=j21dN6c0qoNwtm+yxDfxql6IMpEARNX7a33Z2hJ/T28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vv0cxc3xgZxCxDgEzqhoe6OD3DcTCWpxs11+K+72JwQ4QqzP5t9nKFeCiBeql5/d5
	 NaimEuS9K3UyhfAkNshBDyPGHhGNU4ENn4ovvh+0FJBgY/7fTkd6LqFZmakCTeR9SP
	 k65qQDhJMoz2R5tRkTi1bzpDvHRir5ueYO8W/Iu5V6H3WK6YcnqwtcrTp7TcbDSssJ
	 4pbEQzhF9o28tev9vyifmVG0QUf3VIVPqNS2lFo5OADeNpyDwUOsKs0F4IkHQTRaKQ
	 mNN/pCBh/xIdIVMBhOkaHIbOhSqmKWCqbToDESJPSYFqhCF2x2H1dK8P861bd+PbAg
	 6g+ZoLgqCWU3A==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6dcf573c429so2603768eaf.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:37:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJcSz/CQNjp9A7JXPoTCrfDUCI6LXjLTWbFktohnYR9z03KP0uS7dQZgWlzB/mNIEZjOWTc5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/pMvlM0doaHbqBY+eIl3N31M6zY+TGG4YuHS9uC6zVnUQdKIm
	izAHwms+P1UVth6YaqlcS47u57QGetBA2rzRBGyIlj83FkL87Ip83YQrYhWnQMDyBEvxf4TKVwQ
	o5KHdpYJ7K5YFpKADZ3cqRa2X25SnVw4=
X-Received: by 2002:a05:6820:c8d:b0:6de:2f20:ed8b with SMTP id
 006d021491bc7-6ef0e0f8846mr11711585eaf.37.1791981458600; Wed, 14 Oct 2026
 05:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013115022.1043024-1-edumazet@kernel.org> <179197875524.434549.17569544478935275137@kernel.org>
In-Reply-To: <179197875524.434549.17569544478935275137@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 14 Oct 2026 14:37:27 +0200
X-Gmail-Original-Message-ID: <CAL4Wiipp-F_hXw7YEa-ozbskJZeTZqYvr2s=oEk-QSt6SEdjiw@mail.gmail.com>
X-Gm-Features: AclHuK8UFziX3Zdbpb01Syoq8ivlMUcL_BCI8Th1fgflZRoVrIwlKsRqaj0W44k
Message-ID: <CAL4Wiipp-F_hXw7YEa-ozbskJZeTZqYvr2s=oEk-QSt6SEdjiw@mail.gmail.com>
Subject: Re: [PATCH net v4] vlan: restore HW VLAN tag insertion with
 reorder_hdr off
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, sairon@sairon.cz, stefan@agner.ch, 
	hitchin999@users.noreply.github.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 14 oct. 2026 =C3=A0 13:52, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix does not cover stacked vlans (Q-in-Q) whose lower vlan
>   has reorder_hdr=3Doff on a real device that can insert tags in hardware=
.

Thanks. I added this case to the selftest I am preparing (802.1Q vlan,
reorder_hdr on or off, on top of an 802.1ad vlan with reorder_hdr off,
on veth with tx-vlan{,-stag}-hw-insert on and off). Tags are duplicated
in all four combinations, with or without this patch: the new branch is
never reached here, since both devices see a foreign outer protocol.

With tx-vlan-stag-hw-insert off this was already broken before
447cbe95ebb9, since vlan_header_ops was used for such real devices.
Fixing it needs changes in vlan_dev_hard_header(), which v1/v2 showed
have other side effects. I would like to keep this patch focused on the
reported regression, and address mixed protocol stacks in net-next,
together with the selftest.

Thanks.
