Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DB459AC6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856246; cv=pass; b=JgCPIERdzC+wzBUtaOgRyqwD/2kqAKgrjdxACFxcqkqFj84BZTzRI4yeCYZFwLp+ceox8JX+dkFofN0HUEi7NKJIMWbb2TOJXNd7bs5efVjnWIuo42iqohzu6714VHoalJB3C/Jy5Vp2akZf1H54XfeOPTTiOL6whmFhT7C6fIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856246; c=relaxed/simple;
	bh=xQHx3qdg2OB8eL+HZPk/PaSCwM5pfSflhLtr5HLqtts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly4x7MbA8bIkt/qW1Qi7/LpFjAt4URvj+22CCWoFiQOd8KomWm8dZ3QnbbwnoSkndLSKnTsYFPL7YhTvWdV7uyomKoUR8KDv54UFOJuQTPZiMtjWOUy3m0hGSbTjFX4KU44YP7QPzN9o6YVPLVUnx44AmMNFYYctlYHL+GeS4rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWNZJJO5; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWNZJJO5"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-75609e844faso5451137.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785856242; cv=none;
        d=google.com; s=arc-20260327;
        b=K0vt8Cd6hBHAxHUXp08jBR4tWx1nW9x+t7MBGzWLLe9GoItJnpslkdZOi8yTAEJOZE
         bktZUxVuh80gKKqVa1JrhBqh6Bkvk7ChupeTOnEkT4RA7AfBDAzyw2l0MMrPAc00EAVN
         +2XV2FbphLo5uereBNkrO7vxK7r9If6tGInenpfXXS8cSaPRvEc2kl0NJqg8dKSdRtj8
         e1OT+z/HQBhL+M77Q8nGnDuDhuLQfhDylVtTa8uGxm9ZNx3R4z1KbYt6ZUpzNq33XE2k
         NurYUGD20epNLUmThLq3JQHmsYdpc9N58W3izE9ns4mJSWiCR/iSP4KyShKcV9kQjV1R
         0aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0T8R/JfTkQUvAYP+f+B/Xqjff5brUSAFh4e9c3jkVBQ=;
        fh=xUDO0CDRPCWhVN4tCeUw0L0+HNwh0kdi3bzNSUIABgw=;
        b=kXae4lYU91i586uscv0foq2dTlN0HKywCOi3U2tCEIoQ2VZTzhtrGQqaSoW3bO+x0e
         zbwW2WJoS2fZ0vYtKR+aUDew6fsJGYSHAcEbOWVAAJkDCSNpIP5HprBH6gXEPmC5gh3B
         Z+2mX9JM2X8g1dmqrFQy/NOLlmcR3PKlzVGdt2wgy4aUVTGdo/qVpzX7ztdfyslqS9un
         m77nWDhX5bK0e8JND8++ZHzFEYoIUKGkHhFDJmWUzg0uBVJnJRRN2GMkQpNsupXqGQSl
         BbaHl9LukhJETSONl3VaASkOEf0rqgFC2iCVpq8guYYsgErX+ee1pX0xeVMvjMHiBemp
         /FPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785856242; x=1786461042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0T8R/JfTkQUvAYP+f+B/Xqjff5brUSAFh4e9c3jkVBQ=;
        b=rWNZJJO5ff3sSM9HODqOM5stKGfvICmMmj+/7WzLrYIMkoKDSfkLY0UR4smODL+f2e
         dDp+w7ExYhM18aaMQZDisBSnZaSt1/9/YL9RNj0Tmd1s0sJzsIN9dvoSByJoeuovN0JJ
         a2iTHG9HRS3sO7lKrCIqMjfLoGcgnuqZLlBRJPbvklWNwry02JZcXMTpQNLlbz6Yf5bj
         ER88YwfDzWEy/ywXU1Ww5BAwr1NVMDz3wBnhBaHs7U/iCMjwu1B92Jnqzz1yoLytJ0nu
         8uIs0jPRxiz3sDHaiARSx3DVeLE/4rYqoyA+4CzFR9PRPMVOoMb+Hmj1vZHl7b7zF4Sx
         tjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856242; x=1786461042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0T8R/JfTkQUvAYP+f+B/Xqjff5brUSAFh4e9c3jkVBQ=;
        b=YIpd1y1VWblVu3R2cQqGJeNTt/vS13znrqJKzNTKKzMXwAJfAI8uCERIS5jNuSET6t
         VMRNFdXfdActRnRRGOrzSnqA1Fu5NbYvQBpPUAuQy5gnBnpAJSR85xOprllCJzo71Kxz
         W8EIk1bTKVEVezuzD/GdNG5lh3N+jIBlif5uqKNhEjGJ5Gyj96ccK/piAedgP6KgqPMC
         vA1KNrkd/6jb6ofGGEqyDzT/f6JJolBqBIxNvE5QiewqgHNt3dXN0rVpAZG4IvC1956L
         7y4WXNmnM0BaXZBlfemP2apPYbdZQ8RugrE7K5xtfwzHWAiRtUrD0SHQhM5OqHTYIrCn
         qUaA==
X-Forwarded-Encrypted: i=1; AHgh+RrMIALG9WLWeTiD1pG451wERUjuLdGVVLiX5h7PzJ7/Fc7oz96CjSemLai+1Ln5TrwhV8g+0nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAbgjFa99jZjfx0RmV+N2Z4zY3jSO/rNXkMEsueFS+VyKRlX1
	llH93RH2LhYDCKbH7MmgwhdnwCNoMwA8J0xABnW3UF1jHLRBSMvR2/XjOS8XEEx+dcpANGhKG00
	W0RGPpImDnKIRoQoEzFPAD4w05FsF+C4=
X-Gm-Gg: AR+sD10EDyFKO36nZxfsTNzboBJIBJbnTMrEmEZtKdcd3j2pC+ORVo4ttX0TJv4Tv4r
	ralvxDdqHdRxUMn5n45JxP7t0dCkfYDvxjrZDT7Md4SGzCmSPeFTwYES4bcuiFzdjUZs1t0iN99
	jwgjCYCHV0vIb47LjrlVsAcekN2rdm/xkwdKkiT//vgrRCFshVTZ8wpgQHPohYnqaeb+bOD/e3h
	vGbi6dbFqX+8eL5424aufJ4g029anl1agLebGosZ0fUzfJvX0mnd62BML+v5GZ8Oew3AKsfPPwW
	yqmOUVZuqqYi+JBdrtjRudIKnmMOhHcebd/OH4lv6D3Gdcw9mHhcsEeYFO0E7u/MK9llQ1rz23u
	MrS6fdbKtvy4SvuAlEg5rumJEsAtvyTBoI7qDkIscTnJVcz9hKQAT7VG28WypdkpC062as/opwx
	DuqHo0i/UI2BtmcxsEU5rjgdM63pZAhVEOJYifvPJevqw1kvU=
X-Received: by 2002:a05:6102:578b:b0:738:394e:a595 with SMTP id
 ada2fe7eead31-75f758f90cfmr1181484137.11.1785856242009; Tue, 04 Aug 2026
 08:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
 <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch> <CADvTj4o+B933k4TUshgcvZ4tENDbit3fHEBtwy5ODpsf60osyw@mail.gmail.com>
 <c6f001d6-b9db-4434-8468-4705d62ffdbb@lunn.ch>
In-Reply-To: <c6f001d6-b9db-4434-8468-4705d62ffdbb@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 4 Aug 2026 09:10:30 -0600
X-Gm-Features: AUfX_myEkwMmILqoz6WhwBFrVnUN6AKUbAAhMRjZZlDrp-P41avXbKl8LxYfdPg
Message-ID: <CADvTj4rA5QaeccDvSP2qrseFKv+7MKhj=pRWdSnNzKKjMCdK6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > If this was a hat on top of a SBC, with an EEPROM indicating what the
> > > hat was, then maybe DT overlays would make sense. But from what you
> > > have said, this is a fixed PCB design, nothing hot/cold plugable.
> >
> > Some H616/H618 boards have the ethernet port on an expansion board:
> > http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/detai=
ls/2W-expansion-board.html
>
> I don't see a list of pins which go across the connector. Does the
> MDIO bus go to the expansion board? Is the PHY on the expansion
> board. It all looks passive to me.

Pins are listed under "24Pin expansion board interface pin description":
https://orangepi.net/wp-content/uploads/2023/10/OrangePi_Zero2w_H618_User-M=
anual_v1.1.pdf

I think it's just the connector part that's on the expansion board?

>
>         Andrew
