Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEB449B16
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482960; cv=pass; b=mcjO3sOiCNj7Ux6V4aVQimuPZ2o9upztTSn7paGmCewLAit0HPqK1JIdrjnV7MuaUtcOlgQTyHfvZ/dYauh5ki4kZa2FkLa2U5GiUY0iNalkqXZZEnPocGLPHL0iqisk4yXVuxoQMS7kC9en/Y09HEWbfYfkwA1LEvZjZZH8OIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482960; c=relaxed/simple;
	bh=KxT4Y9zsXQgJ59xrv3sKm7LdhwIRRi7xOKRS1oy5H7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8YITRVq8E2HKmr3qVjBD4gHBJKxDWta2BNPwF1vNegqpj4/REdsvFGROKRp/ILm91L6jFPDVUn3Oz88x1i2UtWQ8Hwehw/4rbCh5p9tFGRbdk5GW97Lx7OcFw4LN6HjDbLXrPKGdfeO6I89/o9GF0immnxwkzy8iRaOwP/HfN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQGHAgkI; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQGHAgkI"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a9787a14ecso40572381fa.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791482957; cv=none;
        d=google.com; s=arc-20260327;
        b=eMQY9/xQjLzXUgqix5MmqP2SSkbSXu8NWftDIJxJdzcGAZ01ucbkfy2/cZN/flEcYR
         RrwshyP8hJl4ZvnXMgCnVPpaGDvBTEUUYAMva7D3wjtrGS43TfeCapfJCs189616tnZJ
         lQ3jYuSoY07O+wgkoWYeulL+RSCxbS1zIfxOfuE01bo1oITYzCXAdpQsO/H1dI1nms6e
         /oyQJT2FYtJXW1BeN6/upwyBenpbmiTLFBmH6mOcsz81mRYwH+lhYl0G8aKbG7jmv4SW
         5w5c9JNt5GWpgfqbF8AsGIoFcSFGbYiSzt5pCs1L3oPyUlm6360cF79oVLue7nAvfgyA
         QNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPxkcZCoQwWe8FOKls5JzyPuIfhWZh8MaKmpG5RE1mI=;
        fh=u7J6E+XUdUUf6s4LG8IM5wpPFmtJGdLFE3aWTCLkTcE=;
        b=niiGbGhVUq/LukFGRX+X3WdSAJd8zim+HmhuSUajrQ0TzcJupagld6rbfsnSjnilf/
         EJUjsqRx1bH3Zv/T5nKgtxszlPQzD0ra97Q/2u7dmt3TxvAouHPt7kZrqNPxj73ovBSa
         kDS7Lx2SU97CyshB0MIq1ifGvxQVU3KrgIzEet97gEJT813b7I4s4DKgZg7aCGZeTXA5
         YRT3E7mUHeqqV3k97jY8jzfAR2VOx9fqXIPPLmShPw70NB1WnF9FRYRhRQm2/GG4NdYw
         /HfkA3yzRoLcx8xHhJcnp12ui3xdi5GfmCtTNkPVhaBVyuiffpGoYe1ZoF+N2xW8QXsM
         HryQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791482957; x=1792087757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RPxkcZCoQwWe8FOKls5JzyPuIfhWZh8MaKmpG5RE1mI=;
        b=LQGHAgkIle+871IGi/V9SrdL7Uuy2mrMUedtxpb6ii9+vHWLxVEZIMmzKxeLlAPwBW
         a2+39MhUtsUQqjCKo3P4c5WGalRsTxGrcwEoJRWUq95+Hku9YmyDyGVm0FEurjupGEgp
         ZqgFxExiOYdAEJKkfbuN9BFv+Vy+vGhpq003c/taWoU9Ae2ERHM2UVF05hIlleQoGbE/
         ZVeI6MoqrgwNh8rRRjh7suEUzWEH3/ocNVAUXBXist5w2l9LHLHye2w5GZDe6uDEV+tE
         lMHSgPKbo8BD93vaC70nDTM3e/DUns5I2rnO/P0HVJOd3gFvkfayzuHpa20xhn4CYBb8
         YKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791482957; x=1792087757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPxkcZCoQwWe8FOKls5JzyPuIfhWZh8MaKmpG5RE1mI=;
        b=nPLdbpmN8UXG1tcuEFe3bo4fJFgjmTXkQ/2YyYq0zZJQWlsxhf5oUKbToPBHKWj80l
         qAz/SphI4DNCYeiclYQlgfqTBVLbiW1LYoGEG/wx4xj3ZvIwaXh0OB8dQL7WWK5+7nEA
         YlhaY0zO7V7LU6nTCO5u8de7tbN0VZcRMw7lJKZASPDqixg1WZjc4bT5Dd8dUgG4ycgE
         zuGWeefPA3AT3w+rq5Icpu67+x/Hcjj+eMG+74D2yE03R6Iz1i1+0kG9mKWRl/a8agiw
         rhciASD5mM1LYm8RwzRjz7HfsFaLy79XsC5xEw5zFJ9rfHDHqpyQX/U7SqHkhS3ql1KV
         YJXg==
X-Forwarded-Encrypted: i=1; AKwUvBw9DlQzcLknZs7nJdZatvY7Te1pEV/oA0+7+hars4NXZbZFHkNrQKw++KPsIviBPbw7FSdtTFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgxYb6kMDjUR69ajr8daIu0+2JR2yHRfiHB5jnFGQj9UtjDLYc
	rFifMyLXsuyItaMJFgeTA9Cz99siUT9RKIhgHmNzdl99fd2OsQgwGOnYlv867/46xWjxIsF7xtA
	4WCH/uQGyS57X5lJ798rza3f3PMy1zbY=
X-Gm-Gg: AYBFou3TISyU9b9GcmX7AJBIOPLRMrjVzwypye3rYnNdxccDUQPHVgOed8UPantMVWB
	xPP1g1+c95+XJnp0s17BMjvcyxor2QKSD/I6G1OBu+iqDZ9QVTiSCWZaDDplSq8eeBVTB4l2LBy
	g+aR4o2Pt/4Jqz5CCA8+VAoyarECrvc2MJzeDiPsq/PeAKK7Y+tclYkcgY1IzOHMcJHVGKR0YBE
	8tdOLBD7bb/R+0CZ4WhX1luGyGdSZWuret3uM+PI4UUITgyq+fd2aVoXUJSScVAoqJ+2onN5tPH
	2ffEZGo84qd8TG1RKuoK9XjauYFO10uDwl8jyqeT4JOTQgcz1CBiipnmS/8CoC480FY=
X-Received: by 2002:a2e:be0e:0:b0:3a6:772c:2763 with SMTP id
 38308e7fff4ca-3a9a2a7c465mr14671291fa.0.1791482956655; Thu, 08 Oct 2026
 11:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001090250.3395779-1-anilkaushikwireless@gmail.com> <20261007161806.5fa99d43@kernel.org>
In-Reply-To: <20261007161806.5fa99d43@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Thu, 8 Oct 2026 23:39:04 +0530
X-Gm-Features: AclHuK8xmUT1LGXE2WjcPTZEqVRcu9RuW3ne0HEDBQ7q3YatP4qwo-Y7j2eoXtA
Message-ID: <CAG0Mgm8xRFOvRobAV+fRwyiZ66Jcv_L2-UN5scTKQ8dpMWS-cw@mail.gmail.com>
Subject: Re: [RFC net-next] netlink: specs: add genetlink-legacy spec for GTP
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jakub

On Thu, Oct 8, 2026 at 4:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  1 Oct 2026 09:02:50 +0000 Anil Kaushik wrote:
> > The GTP (GPRS Tunnelling Protocol, user plane) generic netlink family
> > has no YAML specification under Documentation/netlink/specs/, so it
> > cannot be consumed by the ynl tooling used for user-space clients,
> > documentation and selftests.
> >
> > Add a genetlink-legacy spec describing the existing family: the PDP
> > context management commands (NEWPDP, DELPDP, GETPDP) and the GTP-U echo
> > request (ECHOREQ), the GTPA_* attribute set, and the "gtp" multicast
> > group. The spec is derived directly from include/uapi/linux/gtp.h and
> > the gtp_genl_policy / gtp_genl_ops tables in drivers/net/gtp.c; command
> > and attribute values match the existing uapi one-to-one.
> >
> > This only adds the description; there is no kernel code or uapi change.
>
> Do you have any plans to use this?

Yes. v2 adds a self test that uses the spec: it creates a gtp device, adds =
a
PDP context with newpdp, checks getpdp lists it, then delpdp removes it.
Writing it also surfaced a real bug in the driver (the get/dump replies put
the family id in the command field instead of a GTP_CMD_* value), so v2 is
now a small set of items: fix, spec, and the self test.

> Why send it as RFC and not PATCH?
I used RFC intentionally, to get feedback on whether a genetlink-legacy spe=
c
for an older family was required.

Regards
Anil
