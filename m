Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C842B72E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983917; cv=none; b=WnGiK+ffFzCzXnjFcpalQiHnM2LMRHOctOVQ1AjEy7UfmzpZS837XmDt25k/podefezW3VZv5pvOROuT5+7XrUCeN48VqF0RL53OFNFEzfFNEqhiNqRjOvOgYzpkmUeX6RdAM8O9dIUhgFt7vTgz593bTbD++gAnFNc/kDZCKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983917; c=relaxed/simple;
	bh=hucEkY6FzXRmADj0EJZ/HAEbbwBUmqqmluPtSTjdzK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffXXpbFaVmuGafWD89AEtKmiiJHgohVLfPeNRNVGii4qj6yLnOfKqY6/Nc/hx1qoJa0Y3h6Ofj1Uup50DmClSNXEKIqt4tLoTCra17PGgHNg2F5dMzZQXoqbE1IqZiNOlCbsS4Vi3cBlQWxCQ0ML2RHiU967dEnqUASlNYxq0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbWiLpgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbWiLpgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0BEC2BD05
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983916;
	bh=hucEkY6FzXRmADj0EJZ/HAEbbwBUmqqmluPtSTjdzK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZbWiLpgw2leygJb7ifJMUR1NZoaXq9aXvL+Aady1XW//joo+QJ2RP0HClIkMzg15E
	 cCIbH1HOjkoFfGy0ypEORhLJalBzPYJqhSpXyncGjErPptQwz9lvitrKTK38pwMeeV
	 vVhqbRQyzlX3hc2FYMaU7fe6EkTEa+Fn/1kgvcvnDXEIPT6yaibha77kU2ZCI9BZ7h
	 vNRUnLOSt6YOy55WZU/KxmTa+tlA4moODG+2C3QbAHINYBZE/FSu2HrAmikYJihh/n
	 X8SZPO57hPPYYVAg88/oQR4zrkVk4Tz/Etsf72sQJZm0RnqRVj0nFTITC3SBmFNr4/
	 USyApfAU0hh+g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a525aedb24so5791770e87.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:25:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8FLzwBRce75D6N6l1nfmuVumORl1Re3T7jmlIEFQeWOKARQ4vMNkMrG6QSI9iFdZexgetyF0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYoNolUktrkRbjdyfv3J2gzP+QJyGCZLHrmbOrtK+j12MWMNn
	ivVoDr2y5FWINqU1gwJjRTEsh+van/YghjMl2wO+P0MHPO3/SD8S2viH3FHrrIqymWFeDWckv//
	Vh4+d9kVfYqrPAYXp8LnR4Ro/nOIa/rA=
X-Received: by 2002:a05:6512:1598:b0:5a8:6cbc:60f3 with SMTP id
 2adb3069b0e04-5a87f1f504dmr1207659e87.34.1777983914959; Tue, 05 May 2026
 05:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260503-realtek_forward-v2-5-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-5-d064e220b391@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:25:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQJ=BYn9ZTKJgLL+7=EUZPcLbG7JGxayZSYcJq+sAxWw@mail.gmail.com>
X-Gm-Features: AVHnY4KXAnb0_m-vWzgFpoqXIZll2_P58lgovM2R3Jg8r_M9Cd1yi0STRsK8m54
Message-ID: <CAD++jLkQJ=BYn9ZTKJgLL+7=EUZPcLbG7JGxayZSYcJq+sAxWw@mail.gmail.com>
Subject: Re: [net-next PATCH v2 5/8] net: dsa: realtek: rtl8365mb: add VLAN support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 8:19=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
> structures for VLANs:
>
> - VLAN4K: A full table with 4096 entries defining port membership and
>   tagging.
> - VLANMC: A smaller table with 32 entries used primarily for PVID
>   assignment.
>
> In this hardware, a port's PVID must point to an index in the VLANMC
> table rather than a VID directly. Since the VLANMC table is limited to
> 32 entries, the driver implements a dynamic allocation scheme to
> maximize resource usage:
>
> - VLAN4K is treated by the driver as the source of truth for membership.
> - A VLANMC entry is only allocated when a port is configured to use a
>   specific VID as its PVID.
> - VLANMC entries are deleted when no longer needed as a PVID by any port.
>
> Although VLANMC has a members field, the switch only checks membership
> in the VLAN4K table. However, when a corresponding VLAN entry also exists
> in VLANMC, this driver keeps both membership configurations in sync.
>
> VLANMC index 0, although a valid entry, is reserved in this driver as a
> neutral PVID value for ports not using a specific PVID.
>
> In the subsequent RTL8367D switch family, VLANMC table was
> removed and PVID assignment was delegated to a dedicated set of
> registers.
>
> All ports start isolated, forwarding exclusively to CPU ports, and
> with VLAN transparent, ignoring VLAN membership. Once a member in a
> bridge, the port isolation is expanded to include the bridge members.
> When that bridge enables VLAN filtering, the VLAN transparent feature is
> disabled, letting the switch filter based on VLAN setup.
>
> The use of FIELD_PREP for reconstructing LO/HI values was suggested by
> Yury Norov.
>
> Fix for vlan_setup and vlan_filtering was suggested by Abdulkader
> Alrezej.
>
> Suggested-by: Yury Norov <ynorov@nvidia.com>
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Allright go ahead like this. Mental not to move the RTL8366RB
VLAN handling down into the driver.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
