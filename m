Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7D489888
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785819842; cv=none; b=lxdyYFRCw9w4kmhZwMvWXERtXM4QHy8gK/rRzGKdj6T+a9KAzHcrawon4d3R/sdShGNXgonxGuPFlMaHtZKkxenIAaJySbi8yfadWSTTvJRnCyWXAsuQi0Qdy1Z9KhTSAWTzf0r4ypvOT4RBX6EwcSett6QHcmeaQhTJzYcYwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785819842; c=relaxed/simple;
	bh=FSJlrY3I3aNh7f4zmDrsNnt6kg6s2wYYb9KmntktFLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBwsPNhX0Y88pG6wdogamW0xSZG+zhh4x3ZQBz/xkBr5CFzkuIwCC4IaeIqU3EFexDfxWBQRHrLhYD/FOSQ+nRcdRs1Mz93MLTjpxDpeyX+P3Kc+/20gPgqdNSU4FvsaEC9sHUIoBk/U5rUTCqurnxYCONgvsNdesrUb1FKoV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crj1fG+J; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crj1fG+J"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1600d040e4so82579066b.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785819838; x=1786424638; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0K5uL+ffxmjOwUEwo70igju+6SeZRlmphKolSxYy0o=;
        b=crj1fG+J5oDM9i1p4hnCN9tAlKW4Wzr7aa36BqSYBUrbVvnDr0hEQTPkY7KYKjcQSk
         uSyrLVOjDvoF6tBgydwGHjjANKajC4p/09c1zkcRAnMKVzhp1BQOGFKZxMMjMJjhI2MO
         5qVbGeBoBoNXx7dfYEcj8NVEikkHcy7/y1UC5SS9jg6f7bfaDfFCr44mJuo1Ix2XFgYx
         hlHtWWk8TeFUtj83fLgyVQ7HQ3qXYyAeuygzU84vYM2w4jU/TSXQqqrfiC4yxOlzMXh1
         oXuzoL8d8j2IiGlEBoLvGFfbklhbJwIU4++kgCJlRuaayBCeOUOlzvdiajMV/7K2fIHQ
         srow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785819838; x=1786424638;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0K5uL+ffxmjOwUEwo70igju+6SeZRlmphKolSxYy0o=;
        b=jCcOVf5ECTUrN1F8CF5YxTAVpSFqyqMuOQ81bLJSC9iMJuZJlbpNN0SdUnubAEdhBi
         BAKXJXrRsLdIguHlr5F39myVvrNiZ8uMOFSzfyLYVInIao59WrqYwgU+VN5O1rwtedSF
         tbJQb0ZM4q96yZygx5utcYR7CnDkzhX58JT8RfStiXhVZfKaKNpmtfqS3PB6prfCKYmF
         KQ225PKbrMZ08qC83etPgHa2+5I3evycNyhZEGCBvDrdnWwrdbjxoHorE4MnAkkcwYrc
         bekd9cmVsiIJUUpOkLA6Lf/LREuvRCQpJznAhtCyc0Trc62BfhIQIfF+cJC47rL/Ej7C
         R4Fg==
X-Forwarded-Encrypted: i=1; AHgh+RqXvaiQCiWK5Y0zejf8mgpj/W7S/jbVowT/rzMGS1Gd/bMk8vFZe3mpdpgteAyUEIaiw57VUHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdR5D1y7acaaAAhuOHLyjeOsyInx7Z/3qXZCmAfJJ9BBDLvG2
	j5VNDIVF4Vbll+GRtngzmqunBlrS8QFAfA6oANykhYLkmmMBAkxJFHI4
X-Gm-Gg: AR+sD13216B2+09oB6t1AGvZtEQpycKzSGqGOydDZ0wHl6jQbM27O/S1bN/v7ppvlOS
	EmLjuvxbHor+rDkzQq/TUBVyZoiPdjGgI0c6vXBykpHeqtcVIgOyMbDBJCuop3xtAmYbXbancXi
	ohZd6qfMIX+n3XzYzxbT7HUXlQwn5iV1PO+I3NmUAsThPIPd5MtmvkP9r3f9aYnmZi5UldqblQ6
	slyVqpOFG5jZUwffKxTSoQQMvC7ZYFHGI+318Rqms4XVZWTZ6LMdzW2BMu6a33/jr1jve/dVBCH
	9G5T6c3W/xtDWIIqlQg+MIK8SxOXCq46pE6YHk8VbqqHmQA9HXW18afP84QIjDn5wnmfA9im96i
	9xkbf16VayDpvNBfsIbVEX+8dXtPpZQYzCfGsx4QRL99XCu7nTEERcQE14+P5kT/hlo4joonhf4
	HPGoz4jGAUL8ejggdI/Z3ZYUPvVIHR0T3WzbjS2zdvn1+JzYFBqiaug8I1PDsBE0fIXbQy8a66x
	M/uMf6kCcwM8d3Kw/Qj3MRdaM7fai0RyY3neimXfcshe4nIlCcwboEArGsMlLkNndBi3FJGsHyr
	L3W+wcyMp1NIulz3HURAlVFYkG1aN8ZxB92x1QQZKLsPc0aPtQbpgWqVO0y6SWi1IUkxjoB0440
	cWTMfKePbmcEqrtT12HFivju62bAefxH/vELetsShkY8juS7O6Fs4vauZv0EZLa0SZqAGm/T8hW
	UlwLBoipa3IyAT5ESVdbA=
X-Received: by 2002:a17:907:3e07:b0:c12:3cbf:9f6d with SMTP id a640c23a62f3a-c20244fb9a5mr217102666b.1.1785819838130;
        Mon, 03 Aug 2026 22:03:58 -0700 (PDT)
Received: from jernej-laptop.localnet (APN-122-65-17-gprs.simobil.net. [46.122.65.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c90739sm627034766b.14.2026.08.03.22.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:03:57 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mfd@lists.linux.dev,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 00/21] net: phy: add X-Powers AC200/AC300 EPHY support
Date: Tue, 04 Aug 2026 07:03:49 +0200
Message-ID: <AGtA6uUwR9yJMX3xYVDz6g@gmail.com>
In-Reply-To:
 <CADvTj4qCYjQHOQn1jRTHNNL=xeX6z3Dgc-PLwOBUvX34AU6cuA@mail.gmail.com>
References:
 <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <aaec8809-8218-4412-a60d-931406dbf287@arm.com>
 <CADvTj4qCYjQHOQn1jRTHNNL=xeX6z3Dgc-PLwOBUvX34AU6cuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 3. avgust 2026 ob 17:57:15 Srednjeevropski poletni =C4=8Das=
 je James Hilliard napisal(a):
> On Mon, Aug 3, 2026 at 7:26=E2=80=AFAM Andre Przywara <andre.przywara@arm=
=2Ecom> wrote:
> >
> > Hi James,
> >
> > thanks for sending this to the list, but as Andrew already mentioned:
> > this is quite a beast, and would need to be broken down.
> > Jernej and I created some patches just for the AC200 PHY on the H6,
> > which Jernej recently revived, and IIUC, wanted to send to the list.
> > This would probably be a more workable route: start easy, then add
> > support for more SoCs (H616 depends on the WIP PWM driver) and more
> > variants (AC300) later.
>=20
> Well, I wanted to validate that the overall driver design is suitable for
> the H616 which has to support both PHY variants at runtime effectively
> since that is the most complex use case, I also don't have a H6 board
> to test with myself at the moment. I think being able to see a more
> complete implementation like this is helpful as it can better inform how
> we can tie the different control interfaces to the link PHY in a way that
> works for the more complex H616 case.

No. AC200 and AC300 are separate chips.

Just making some artificial connection in DT, because H616 wafer is once
copackaged with AC200 die and at other time with AC300 is not correct.
Let just have bootloader properly identify copackaged chip, enable it
and be done with it.

I'm working on proper AC200 series as Andre mentioned. I researched all
functionality because I don't want to miss anything in DT and to have
good arguments why I did thing the way I did. This series doesn't care
of anything else than AC200 EPHY, which isn't correct. Some things are
even not properly modeled and it was already discussed in previous
reviews. For example, MDIO PHY node should reference both, clock and
resets.

I plan to post AC200 patches with at least audio codec included,
alongside EPHY. TVE is also working but it has more open questions, so
it won't be part of next submission.

>=20
> > Which also brings me to some attribution questions: If I understand
> > correctly, this has been written mostly by some LLM? I think you would
> > need at least to disclose that, if not even add an official tag?
>=20
> Some patches were, sure, my understanding is that it's not required to
> explicitly call that out but I can add more info if that helps, this was
> tested/validated using a heavily automated hardware in the loop
> testbench setup on an AC200 and AC300 variant H616 board.

Yes, you have to reveal AI involvement.

>=20
> > Also I wonder how this relates to the patches floating around for a
> > while already: https://github.com/jernejsk/linux-1/commits/ac200-v4.
> > This branch is relatively new, but the ac200-v3 branch for instance is
> > much older.
>=20
> Yeah, parts of this are loosely based off of some existing patches that
> were floating around like those, although it has diverged quite a bit as
> well since this series is designed to handle both phy variants.
>=20
> I guess I should link to some of the earlier work in the cover letter?

However, what bother me more, is that obviously a lot of AC200 things
were copied (even if only by LLM) from my WIP AC200 branch without any
atribution to either Andre or me.

As Andre mentioned in other response, let do it separately for AC200,
AC300 and detection between them (best in bootloader).

Best regards,
Jernej

>=20
> > On 8/3/26 07:14, James Hilliard wrote:
> > > The Allwinner H616/H618 secondary EMAC is commonly connected to a Fast
> > > Ethernet PHY in an X-Powers AC200 or AC300 companion package.  The two
> > > packages expose the same link PHY ID and largely compatible link-side
> > > registers, but require different control paths before those registers=
 can
> > > be accessed: AC200 is initialized through its I2C MFD, while AC300 us=
es a
> > > non-PHY Clause 22 control endpoint.
> > >
> > > Some H616-family products were shipped with either package under the =
same
> > > board identity.  For those systems, this series uses a SID NVMEM fiel=
d to
> > > select the control provider at run time.  With CONFIG_OF_DYNAMIC, the=
 link
> > > PHY enables only the selected fail-needs-probe provider, so an AC300 =
board
> >
> > Just to bring that shallow discussion we had on IRC to the list: I
> > wonder if this is the right solution? Alternatively I was wondering if
> > just patching the DT in U-Boot would simplify things, and also help
> > other DT users like *BSD or U-Boot (proper) itself, to not boil the
> > ocean, but just allowing them to follow a standard DT description.
>=20
> This can be used either way, CONFIG_OF_DYNAMIC isn't a hard
> dependency with this design, aside from adding CONFIG_OF_DYNAMIC
> support for mdio the dynamic enablement of the correct phy control
> drivers is relatively simple with this architecture.
>=20




