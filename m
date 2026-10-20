Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504028;
	b=UHQP0c7LUTLqgOoIxGKLU8MXdj4rv7xd3wV98x1PzMqeUiRLbw+opgdvXN+dJfGzQLx2
	 5aJ4+Em3rk89683FPhIvtAJage23+9JGxNP/vosipDuRf6+ECuuvzzDspiGWuIokl9LFj
	 iqDDPMnZIXR5dHgl1RXsWTkJ/CWosMhbFk4lGfy+p8nOc2KDpoojimukUb3AdqkRYAZtz
	 Z1A7ryfnNY1sUFU7lMwzln0LzJ+tBmxBqX0PITvLvPbd7o2JuHyyZybwL1dyA2dOc4cAH
	 qkiSuap0NpM6YZo49muiHN7aLIggFOnY0TnCffH91IvTWFxqzn/KCLlwpCqvksPCvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2kCP+NrK9u0l64HrUhPWiPnv+LrjBBVOpvFV3ymku6E=;
	b=1tR8YOL0kIaigtUn1uHov/caWr1TDT7SrNQVWCpgrL7Uw/Avxm9xhL+hHoQMLjrV3X/o
	 hGxlCncOcJkIAmr2y9wD73gk3EJRtQZpcfYB67MLM4r4a3cQgHhCW4g/bbBve+dUgolAO
	 psi7UlNuboACxixnZ3WWnvJAqeXeld75mifxB9BD9abFl164a/KY+BIZp1GpRct298Ow/
	 NfBujvKt26Cdp1q3VVxOL2BEvNXgAbqiOho/F0KJ1mOSCVlXsNNnS2s6q16uYE/+YYbGu
	 C9iZwi82brpglOkjL1CclroYo7w0qcDtoTw9Su1I9JtU/pcuWc2zUuQKMfUnaBUL3mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B6PJ+rk1;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F573606B66A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F573606B66A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B6PJ+rk1
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so1000812137.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504027; x=1793108827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2kCP+NrK9u0l64HrUhPWiPnv+LrjBBVOpvFV3ymku6E=;
        b=B6PJ+rk18ylLoxkPCJ6F32NV8IjBP+Pb/tc4dc9syOL0SREx81gpcKat3KPjeZY/cr
         NrUgbbF+SfbqXVptEQajnq+74clZgXW1WTy6b96nThTXO0mmAOP+u0mIdI2Mt+blYPMQ
         fUhfg487puTajHVCeLlhZxcRlj+kaBfe4otbqXg82ETYO3D5nYaCjNycND9npASccKq/
         AG0XaDIkLzscaxFsR+KeFC2HoDyPhKtKWSMgnFNkSJrkZUhZvVsw1+GvMzTCIQ4Z+DvJ
         rdD8QmS4G1I+A0YUMmpC1eWvNB+VUjlTFjiJODyK3LW1btbWgVi6oFiPk8Iv0R2reA8r
         tEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504027; x=1793108827;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kCP+NrK9u0l64HrUhPWiPnv+LrjBBVOpvFV3ymku6E=;
        b=2Vg+cCWpHyFnkiTzCiIfZ7IrO1KJ/Vczo4A+TW6X5tFdHvD9Eno6DE/aYIDw9sblgk
         a/G2InYaiHI62TO1mnytleQOjurz2l5n1LYq2mw48Xtdp9u5B6qM36T0bHwj97XvE3S1
         l5j6lU/lhgiL2GRxDuqcgjq6Rd/U0+/oECXr9L5UgUp9xdy4daQ+gU/5MQ1y6vPjjviw
         tSF8kx08QAKnX9++KxnjjRcYXY39vzhOS7I2SFX1/MCmyzxO8sQzyP4Tkq8eW06E4zGl
         Y8MR/vn4b1YuVtniDBQNTA6pQfFgVgnk8Rsm4O9dyJ+tHbQ7sxBBXWvZiSm1UDRVRUmr
         hyuQ==
X-Forwarded-Encrypted: i=1; AKwUvByuONLdOyPJqogj2acN9L6q5Ipa3Hhdjg7rWE74SBGEq49rP9fHMRvkp6FC74sHbjKo0p3bO1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYInpvj/vZlxdn9oQlqe3Vz7r2GEXH36Vd0TWkC7mX8sWeoAh0J2
	MLJpW1+N3sI92QbwHZBxBibrvKybyRKsWxbieQ+ZTvvN8KRrVttVpkZ+
X-Gm-Gg: AYBFou0XklqC/3y4tHT3MF9omXZnNC6cdXuyXDdRuWulh+2G1OXj5q10ykbZUdVPjxI
	YE9vvkxdgPR+b3pJ4YcZy6kziuoGuBC+BjFyBFe9AnYNSKovB5gF30cnAt4UCSvBWLX0nsKcZUV
	JQbocR8y3ze/t5sTUrop/KdpvBSsNN6uEYdqtw1CtK8KRgPymuRDCWWuGrhwDH50Pr12Ca61xRE
	6A6oEIjdYg78tpfNS/7Llprr3u6+pKpu5dTMnmfzdALmmG5o4x0m4+PBxbViiqknjuI4fmAD1M4
	n5os84IrubD4CaiFtiCSHIEQxkgVCjQ3lB8M2wLXv5L+tYQOUgpn1Qc+OKIw/Ag4rpxgvbxZYrW
	t9vv8CFKDxp0cauEnPfryUg8eCWowxnfKW+1d5bFJh0j2/lZ+tlYtFBxJXERBOQ24qRn4EuyNYA
	ubLfUJOTDgNgKFE6eoEaVW0RDTsxW+r27qud2jtZ54dESJxG3y0Upc8EgU7bP8kJWP++5PTlUGe
	gILgztp4W8vFUB/yRzs6LbStmziRga+FbFIumu1tSqE3qRivXdpKMpXmrQXTpKkWhR1s6zC/PYS
	rzclLf4ywITQodErNMyoCRM4+dMF77SGvehQlw==
X-Received: by 2002:a05:6102:4193:b0:7cc:1942:c156 with SMTP id ada2fe7eead31-7cc36a827aemr2659157137.31.1792504027212;
        Tue, 20 Oct 2026 06:47:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc7722e6fasm2724111137.7.2026.10.20.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:47:05 -0700 (PDT)
Date: Tue, 20 Oct 2026 09:47:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 netdev <netdev@vger.kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Stas Sergeev <stsp2@yandex.ru>, 
 Andrew Lutomirski <luto@kernel.org>
Message-ID: <willemdebruijn.kernel.1104f7f83e0dc@gmail.com>
In-Reply-To: <3c77f88acff5b3c2617b22d64faad15f6212619c.camel@infradead.org>
References: <3c77f88acff5b3c2617b22d64faad15f6212619c.camel@infradead.org>
Subject: Re: [PATCH v3] tun: Require CAP_NET_ADMIN to attach to an ownerless
 device
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> =

> Twenty years ago I made creating a tuntap device require CAP_NET_ADMIN
> in commit ca6bb5d7ab22 ("[NET]: Require CAP_NET_ADMIN to create tuntap
> devices.")
> =

> The idea was to allow the permissions on /dev/net/tun to be relaxed to
> 0666 and thus allow owners of tun devices assigned with TUNSETOWNER to
> actually open it and get at their devices.
> =

> What we missed at the time was that persistent devices with *no* owner
> were already essentially world-consumable, and anyone who could open
> the device node could also attach to those.
> =

> Even then, using persistent devices with no explicitly set owner =E2=80=
=94 on
> the (false) presumption that CAP_NET_ADMIN would be required to open
> them =E2=80=94 wasn't an egregious userspace bug. There are cases where=
 it does
> make sense to separate the creation/configuration of the netdevice, fro=
m
> the process which shovels packets into it.
> =

> Since then, TUNSETGROUP was added a year later in commit 8c644623fe7e
> ("[NET]: Allow group ownership of TUN/TAP devices."). Its commit messag=
e
> noted that if both uid and gid are set, both have to match (in itself a=

> bizarre choice) =E2=80=94 but still not that with *neither* set, no per=
mission
> at all was required.
> =

> Then in 2012 commit c8d68e6be1c3 ("tuntap: multiqueue support") allowed=

> new queues to be attached to a device from the moment of its creation,
> with no way for userspace to close the race between creation and a
> subsequent TUNSET{OWNER,GROUP}.
> =

> In 2024, commit 3ca459eaba1bf ("tun: fix group permission check") tried=

> to fix things to be saner: only require the user *or* the group to
> match, in line with standard POSIX permissions, and require
> CAP_NET_ADMIN if neither the user nor group authorised the access
> (although it put the CAP_NET_ADMIN check first, and would wrongly have
> reported the capability as having been used even when it was not).
> =

> That fix was reverted in commit a70c7b3cbc06 ("tun: revert fix group
> permission check") due to allegedly causing a regression in an selinux
> test suite which *expected* the attachment to succeed when authorised
> by none of user, group, nor CAP_NET_ADMIN:
> https://lore.kernel.org/netdev/CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNt=
pt6dakXncUg@mail.gmail.com/
> =

> We should not break UAPI. But we don't have to consider an selinux test=

> case which deliberately exercises a security flaw to be UAPI worth
> preserving either. To which end, I have fixed it in selinux-testsuite
> commit b2f894f0016b ("tests/tun_tap: set an owner on the device for the=

> relabel tests").
> =

> So: fix the lack of CAP_NET_ADMIN check on devices which *haven't* been=

> assigned an owner or group, while leaving the weird tun ownership model=

> as it was (user *and* group have to match, if both are set). If someone=

> still wants to fix the latter (which wasn't actually the reason the
> previous attempt was reverted), they can do it under separate cover.
> =

> Permit attaching to an existing device only if an owner and/or group wa=
s
> set and the caller matches all that were set, or if the caller has
> CAP_NET_ADMIN. The only behavioural change is that a device with no
> owner or group now requires CAP_NET_ADMIN to attach =E2=80=94 precisely=
 the
> loophole we want to close.
> =

> And put the CAP_NET_ADMIN check in the right place this time.
> =

> Fixes: ca6bb5d7ab22 ("[NET]: Require CAP_NET_ADMIN to create tuntap dev=
ices.")
> Reported-by: Andrew Lutomirski <luto@kernel.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Cc: stable@vger.kernel.org

Reviewed-by: Willem de Bruijn <willemb@google.com> =
