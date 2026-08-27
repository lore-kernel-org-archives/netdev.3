Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E03DC4D7
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822009; cv=pass; b=lOMX/xl/48GLt07yRsVspzGGMl9LBP5VUJT0OjWFPWfXuF5sVxM2b4+4r6OBsP7xoxQLeJlERGlKg+DDHRwADkvRs5dSovdS08ZYB4n1PqBtcX+HBlV4HWbSFvCF6w+PB2nH2fdEXNfv/4v7cRrpzywLnRRPKNUrkL8oMBekcMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822009; c=relaxed/simple;
	bh=Ld04QgHnuQtaTldYHRunEt86jN5d7aW7NrQ+RrkqBZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8TCExE5OS9Zn0SMLuL/TSDijVMVyfDjeADfhI6D/YiyBQrejjVn6V3oXQSdmAz84REoc1uetg4LJ8PKXDmbgAci+MV54EKT5zGadhhbDafmVeeBtojh2wgsVO6F+n+27t4ED11YgqsnYYyjad5z58bs7iSmiu05itneTBIN+os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml8w3APq; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml8w3APq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6efd73032so7187605ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787822007; cv=none;
        d=google.com; s=arc-20260327;
        b=f3NuP8OcvCLjdnX47WsevWjJfX7wtQ+6xWsvoMA9ntngtBM5Zi6edu0K9WhHAImO9J
         jThnvv2Ku5DHPk1VNB4ipg7ONitRRT+/BpLuqqa+ok6b6qAmEfk7urFQdPiQs6QEHK89
         KHtru0pZgjxoPjxr5WK+S3+HhvSFlBo9k/uAv+UTSnSLbTV6p8PsVBLhjH2WtAOamW+W
         MffA+enY+G+iiVpRzl0HC5EFqkYkHOvb/bRECacF3O7EugQ1cEQaoQLQhyFOR91K2LrS
         hnhu7maOwUezU56P+iljG9TU7sM8XKIXiru44FZJ/Kcdt37EC2b8i61VCNllHloCgzE+
         WDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ld04QgHnuQtaTldYHRunEt86jN5d7aW7NrQ+RrkqBZs=;
        fh=1YNkgkkrrp8sexM6xMrELjAu9BKg22w7SFgV1G9lLSM=;
        b=BFzCtlEZSEbm/ftl542IrPQSwGWegrK+/kPqV6cr//J63PmmmjiA1RdWwwPOkOwoqA
         QAlOG3Rl4HjY7742oezdLJtqSanq37Gtx0qqHAZfLSaInZGCyYZomQY2KId+bI9V3tgT
         PBQJPmJV8Pz3SFdY+/F8xcevMmpVH+kF0K2HE+Dwe0SwnjiNQj5jycj1ae6aqIunWIxF
         3t4nOk9BcUYAGcx0r3HxzbkYyMkl3X133KvDOowKDYxg7LAeIeIpu7EidtsywR7+gRj5
         6bi7jErJGpsZhY62+lzmr30s8Q22UFl5hKVmDhGRSfm7WONU2ZvlMTrR54HlENaXT95S
         EQlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787822007; x=1788426807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ld04QgHnuQtaTldYHRunEt86jN5d7aW7NrQ+RrkqBZs=;
        b=ml8w3APqBckVikejRjUSgLmPxghuk5Er3MZp9jNyGufE90B0tkilzRD1CrBlHm2vik
         CQp4PsUW8ngM97/hIjrhRqfZtsoe8r56e2U/m5kt/Ld9TfguM74ycKt+QaRDBQx9s6Qf
         8kF2oEpMW3E8swWAFcPsPgVarxvCxQ3gsajnNrja5iC9w7cZkJIP40bpjUsR3L40PI1s
         CZsWDkrSiT1hsnfY5qgMQIlux5jwHSS03NTEwpUwhkBjQi1YvvptHXXt6oh0B6+8Gl+m
         eaqRMX5CT7Hi57p5q6QxalsIH/DY71CVBOq5iP/7lpV6giEJBteSS5LdKWle0PT58/Dd
         o92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822007; x=1788426807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ld04QgHnuQtaTldYHRunEt86jN5d7aW7NrQ+RrkqBZs=;
        b=HtkUiYDjnLeFT7fXRKFupTIXxRGf7iYdqTKQp6AoF2mw+IW+xRkVoyFl117RUfBHqE
         3qNnYd4YCgxrnXTblZOhGJYFRJF4HsWH+McbA809u1w70qacVJQIMDVGBRn5jUAI/8C2
         mUrd1rWtZUyE6YHbzdggYEmIZJLIBsiS6wTvfX8RFh/Nde5OYxXxXbACTjcVgmDC4hQf
         SXKtft1qSyTTtP7vVnQ2YBVHBO+VL6Z9ySiFpR/i0c4ZSyGQ5n3Fp8gmKSPFeasNIBuz
         Wfu1WsgVXRI4KevbSoJZiwE+iAgjDAqU7vEZSGjaLP1j6EUkA+6ZkHjNBmhuu4F5IW4i
         sUXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6BMdOJlxzSWFIaYTdmLpMjAO3off/9ll0vC39eaIQy29vlQ4vW/0/Oyca0A1lBXizNsaNCag=@vger.kernel.org
X-Gm-Message-State: AFuF++kDI7TWpaYe28i0/XnTaDsemYwlR1parinjGmeqsWm1mOIR/Jb7
	XZsuf2X/SkN4d+LRjX/tjqmV/0kmeEudvGMCk2kTcY9zTn3qZWJDr5PjspivocoGno0dq/ZoFrZ
	mKmxY6Y1470TbQmW5LakAgt8xfHnmPG4=
X-Gm-Gg: AR+sD10JeMcTTMm+ejVPreFmhyEfHYloZpGn5xk+v+/aScr+LrBqwafvfuj6mKlBsH6
	v4ZcwZDjO/ZI9Y89m0JdBmzGd5a7skQJJiol/8eepF+u0peok3ZHHGMmu9CzBU+Obbj/X2UybuU
	pAg9DnvHbNafQZdHxvxagkxpzY+1uZ7EUtepgk5vN+LC+BNFIhL/Ol7AEgv6IHt/DHAX90gnYou
	g/19U13TIcT4p+n03AQ7GpbkyJjpmyK5JoLaDrAj7vsmc/sOrTDh7MkdZOysXp5Krc8/oAww+lW
	iWXhs0YUBEIKbRILVs6dlTUZyfPBOumg9KRKQxrh8G21ZYARw0ycCkEkHnBqnNggEFYs9PbhERS
	MhyELf26SC3v+MajyrEEJEmZRdk0hJilEwq70uc9YnUcTA+sUBJkpQ/5Ys2mt1A==
X-Received: by 2002:a17:902:ebc4:b0:2d6:f80c:6ff1 with SMTP id
 d9443c01a7336-2d726784320mr62363205ad.9.1787822007483; Thu, 27 Aug 2026
 02:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com> <20260827085533.2a3ocp6llvhzczps@skbuf>
In-Reply-To: <20260827085533.2a3ocp6llvhzczps@skbuf>
From: Patryk Biel <pbiel7@gmail.com>
Date: Thu, 27 Aug 2026 11:13:15 +0200
X-Gm-Features: AcwNN1XkdYMffT-zVIM4aiQ2Ta4r4ChtvNMg7ZZdnyQSZTDvH24EYnxG1cTB2ow
Message-ID: <CA+DkFDboHq+fw1bYdQR_2M9hM+Vp6W=jR0VYCO8u7KXWVq9F4A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 27, 2026 at 10:55=E2=80=AFAM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
> Furthermore, you don't need such a long text under ---, it will be
> discarded when applying the patch. Fold whatever information isn't
> duplicated in the commit message and drop the rest.
>
> It is acceptable as an incremental step because logically, it is a
> different change compared to also supporting PHYLINK_PCS_NEG_INBAND_DISAB=
LED.
> No matter whether you also submit that or not, they would still be
> separate patches.
>
> I guess the more important question is: do you also plan to submit a
> PHYLINK_PCS_NEG_INBAND_DISABLED patch? Any problems there?

Yes I plan to submit this patch also, however I'm still working on
disabling in-band autoneg on phy side as the procedure is not clearly
described and I'm trying to recreate it from vendor's sdk code, and
it's not that easy as the sdk carries I believe support for all their
phys.
However I also have one question regarding
PHYLINK_PCS_NEG_INBAND_DISABLED on the host side. I planned to discuss
it separately however, since you brought up this topic here, I would
like to discuss one thing that is not clear for me and as you are the
expert in this domain, perhaps you would be able to give me some
hints. Looking at the lynx_pcs_link_up_sgmii, once the neg_mode
differs from PHYLINK_PCS_NEG_INBAND_ENABLED, the IF_MODE register is
explicitly programmed with speed and duplex values. I browsed through
the manual but did not find any similar register for 10g-qxgmii. This
may just be due to my limited understanding of this area, but is this
intentional? There is no need to epicly program speed and mode for 10g
qxmgii with in-band autoneg off?

Given all of the above, I just wanted to add that I'll be on vacation
for three weeks starting at the beginning of September.
So if you'd prefer to send these changes yourself before then, please
don't let me be a blocker.

Best regards
Patryk
