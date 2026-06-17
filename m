Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859D3F7ABE
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699036; cv=none; b=E3boqxFuDjPsWTEH+PiG7IqzKx4tY6UHkUWXv1/SDzIQA2reBJZH+oS9TyrXH8DPuCMzhqXmm9qtkTTRNZwJK1335tAKdylw43rQKXuHRnD0MWVaI2KdL5nI998aSGKwO0jykRPmkPa8itYIAjyzK88M8SxKuf4lI5NXSawfVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699036; c=relaxed/simple;
	bh=b1n/4N3C358uVyJqJ1vfqnKIQYA7aHhI29s4Tc1s6u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHi50HzYMYiwuh7dNh4U8aEKu4q+tuI0HTSXmYpJctK8cWuBYizdSAxB6sGT+pNjTUkF3VAC8FEw+AluTusRHU00PDexuZIwMO6LDO05K7bbEr22OU/nIZwHkSuthyyaoeYnzlOU4IID/QaIgyYTKrAi6IM5Bwn3sqn4I4RNdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aro8gjpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aro8gjpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E01F00ACF
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781699035;
	bh=zXGxmsGCmABLfDzWTa6O9EWCXvTTRqrj37BqPEAmtYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Aro8gjpR133/hg/iJL3IyR1zaRqTjFN0ShhBWZsVAdoRi0xTTldAsyubocdVsAHYG
	 NZogQcOGkK834NKvtosl5eLbiFNWZRLOFJktTYpPSsS9csXVtbPkWgoHMTaVZjQ2YO
	 b824z5oKBc2XGQ5Z68dspkO4FWt2g1jQiJvBY4NK11iDbQE2GCq9IAto+oKIkeWy+5
	 cBxejMSRoXP9BAbCepcLs5yZruD/eKSp4eHMauVM63W/VMD4RKeZxGO5VQO/B5G7o2
	 kKVd4J1bmO1ATrxQMVWVhZokN98DFQ9C3O5jwZnO0XFLWlyGbMh8/h1MzE9l5Cjf/+
	 hH1P2Lt+MmdSA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39677242021so47427871fa.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Yem19Q0DgIMDY+6a0epTvwHg7mdouapdhg6WAZmwWCd0ZddKJMWZ82qJ+QD79xQvNkodeH2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKqGlLt0Dqgyfk9tEMu5vjGZlCwfbCrqkjen9+F4Zj9i8fZjn
	+o6LnT4ITNOp2YDIRkCxV/k13n+DUrl8ueNL57wer4OcS25OLb/xlzBqi2uPetGx7664pC+laAm
	Qwrav721+Qa6PpyAWzxnqw//pvkphVJo=
X-Received: by 2002:a05:6512:244:b0:5aa:7aec:4952 with SMTP id
 2adb3069b0e04-5ad47019a44mr675345e87.34.1781699033429; Wed, 17 Jun 2026
 05:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org> <20260616213728.xhja2net2vbjmgzb@skbuf>
In-Reply-To: <20260616213728.xhja2net2vbjmgzb@skbuf>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 17 Jun 2026 14:23:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLm7tvbB2RBV5FEo=mAkPpmUJEMemXV0+mhTvZ0oX8O=+Q@mail.gmail.com>
X-Gm-Features: AVVi8CdYdgQxLKBl-wiWdmt0jIjNRdggRxTkZchlwbCPbpeZxt_yOxSJ5S_hKWw
Message-ID: <CAD++jLm7tvbB2RBV5FEo=mAkPpmUJEMemXV0+mhTvZ0oX8O=+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, "Chester A. Unal" <chester.a.unal@arinc9.com>, 
	Daniel Golle <daniel@makrotopia.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Fang <wei.fang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	George McCollister <george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>, 
	netdev@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:37=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com=
> wrote:

> From my perspective, the tradeoff between pros and cons is not so well
> explained. Consider the following not mentioned in the commit message:
>
> - Changing the kfree_skb() convention, without any mechanical obstacle
>   preventing the backporting of patches that are written assuming one
>   convention down to trees expecting the other (obstacle like a failure
>   to compile, for example, which would warn people of their otherwise
>   silent incompatibility), is an avoidable experience (at best) from a
>   maintainance perspective.

I added a terse blurb like this:

NOTICE: Backporting patches to taggers (e.g. for stable kernels) after
    this point cannot be mechanical or they will introduce double
    kfree_skb().

However, usually we do not consider obstacles for backporting things to
stable to be a major concern, c.f. Documentation/process/stable-api-nonsens=
e.rst

> - Has anyone proven that a real problem exists? Because dsa_user_xmit()
>   -> skb_ensure_writable_head_tail() has run successfully at this stage,
>   so we know that dev->needed_headroom bytes are available for writing.
>   Because DSA uses VLAN as a tag, dsa_user_setup_tagger() will increase
>   dev->needed_headroom by VLAN_HLEN for the tag_8021q protocols, so
>   vlan_insert_tag() should not fail. I've looked at this function at it
>   seems not to be coded up to fail for any other reason.

I guess what you're saying is that vlan_insert_tag() will never fail in
->xmit()?

If we decide to keep things as they are we can probably make a patch
to the Sashiko ruleset and tell the AI to explicitly shut up about any use
of risking double-free when calling vlan_insert_tag() in any DSA taggers
->xmit() callback, but it seems a bit hard to maintain this way.

> Otherwise, sure, it seems cleaner this way, but the way I see it, it
> risks introducing more issues than it fixes. If maintainers feel
> different about this please go ahead, but given the fact that I don't
> really have a lot of time to do proper review during this period, I'm
> more on the pragmatic side on this one.

I am a bit in love with my own patch but I'm not married to it.

I'll let Jakub & al decide on its fate, if your stance is neutral.
If things explode we'll revert it...

Yours,
Linus Walleij
