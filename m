Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80747466B09
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461451; cv=none; b=jeYjFriZzOblLPptQImSCe1qDmSk3KVCSw1jTp5DEEOMqoz8YBtyJKeqQAv00JdIAFK74elAKGAyg4P+gdVrgCmE7PmmvRYewiVD5M8dDanBQomVhGH2F7vP+49h5SAmPnRJWM4tB2pJpzM9DDA/7DMMAYqSJn3smlV3GTGd47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461451; c=relaxed/simple;
	bh=NCAFl4XPMCYrs4fKuagLXxsg5cGxwoskAL9BfX01ffI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuHmtIgccEbE2HbQ15PhXa7HAsWBEeiFPkxKpgmTr5XjSskH+4Tbvk8o6SsPX1CHVmGt83yahYOQr9AganOGbfh+MbwwzB30BkPn2VBk1ZlzaMRkWfl4eGBl1sNNZyqilxGhC3lmGndsjxoIk4tdCtGJ98WcrmZuRomGVuEmjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO/pv2LT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO/pv2LT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257551F00893
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791461450;
	bh=5M+wbih5kSIfUQXAkU9+pcZ+XbDVds4HTI2IfGAuSyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WO/pv2LTlBIrR19qjbPt+IvFILIMd4maXwOFdv7n9d8v5HkY3kdIC2tvznUSAvkSR
	 yco6ynDhfh9BnrdvCHR1oH1taqbJYmvP1P/Y9iiHa1G6tg/tRuVXEX/FEvV49TCcJ1
	 z4LUESkujxePfChzr2XS0H8TD1vAQZTHqS3QHv5JDkYmFHXTAm/MCrxUI8M3REop/J
	 0XYRshdXh/w1lIUUzmV7COYt7rvLIYx5PHgY4r1BwrI04ahQDROdBRaIv61QiLyPYR
	 fvqhsvE11jYxqCcQ5+3TwwJxts1Gi4cfNF3dpD+Q6+jTW53EPOYLEdQKu6TQz7uoQx
	 +jjkKT+K5X8bw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-483d290f398so1576000fac.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:10:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNzu8bb0S7/d2tdKRka8lJ6TpsUc2zEEdnVtZidMTVIqo3v1vxJtAU1wCy/hAtm2TyvgNEWWE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHkzlg1Up1mtZGt4DNgzqDXRTHJ1BYV7UouiYSLDbGw25UHCkO
	w7Sp2fo3AyNtY91djBT+dNaOFmRku5pXipErgF60MiA8iYxrujKe2ViW+oDaVhuGTo61oJYFqLe
	gA9YZm0e5MnzyrEO9y59jfKFgaz12bHY=
X-Received: by 2002:a05:6870:14cf:b0:485:d31b:7767 with SMTP id
 586e51a60fabf-4a2595a2e98mr4497840fac.37.1791461449503; Thu, 08 Oct 2026
 05:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073027.459868-1-edumazet@kernel.org>
In-Reply-To: <20261007073027.459868-1-edumazet@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 8 Oct 2026 14:10:37 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqsQ+EyXqLXWCQt2d7Gvge-k_N9Fc07SEjnXAzejK=PVQ@mail.gmail.com>
X-Gm-Features: AclHuK92ULhdKuLS81Io-gPvy16IeUU0M5f87jvp-T9SSZCYv-ZzpUywNo0MTJI
Message-ID: <CAL4WiiqsQ+EyXqLXWCQt2d7Gvge-k_N9Fc07SEjnXAzejK=PVQ@mail.gmail.com>
Subject: Re: [PATCH net] vlan: do not insert the vlan header in vlan_dev_hard_header()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	sairon <sairon@users.noreply.github.com>, 
	hitchin999 <hitchin999@users.noreply.github.com>, Stefan Agner <stefan@agner.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 7 oct. 2026 =C3=A0 09:30, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Commit 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling
> HW VLAN offload") replaced vlan_passthru_header_ops with vlan_header_ops
> unconditionally to avoid lockless data races when modifying
> hard_header_len dynamically under RTNL.
>
> Prior to that commit, vlan devices on top of a real device capable of
> HW VLAN TX offload used vlan_passthru_header_ops, which never inserted
> the 802.1Q header in the frame. vlan_header_ops was only used when the
> real device had no such offload.
>
> However, vlan_dev_hard_header() retained its legacy path:
>
>         if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
>                 ...
>                 vhdr =3D skb_push(skb, VLAN_HLEN);
>                 ...
>         }
>
> With vlan_header_ops used unconditionally, creating a VLAN with
> reorder_hdr=3Doff (as done by Home Assistant OS / NetworkManager when
> flags are omitted over D-Bus) causes vlan_dev_hard_header() to push
> an in-band 802.1Q header in software, even if the real device supports
> HW VLAN TX offload.
>
> This is a regression for r8169 users (Realtek RTL8168h), who report
> transmit queue timeouts (NETDEV WATCHDOG): this NIC stalls when asked
> to offload checksum and/or TSO for frames carrying an in-band tag.

A V2 is coming, addressing Sashiko's feedback.

pw-bot: cr
