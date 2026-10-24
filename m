Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862804;
	b=P3kl41vK9QlJxMk/ky6L9eM4hP+XmypwVZHRNLHsP1ILUsAe0iIMFIXDxwjwX+W6+jta
	 yAUwRPyZAInMIt4rQLQEAqgiW7V/EGtvaPeL5YcxkWkdChF28U0PcBC06HKylmGCMg9vz
	 uaaFxvwF/+LygVbiR81WYHmYZenFWm72xS3HwCIEY1R89PyFLgbdqVePAnqf5EiCkQb4j
	 rEozuB7b0Aa1/uIQ1njrhkrfSez134lJquTYeqKGDY0tHOdcLOP/bkZQBckbUTkJEN1iU
	 h29jSFuw0fBCO0CjWBVfxQ77aUNWSqyObAvzWSEKON8fb6UeZmPvHy/KHu7omM9lIeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5IEfUPj0lQJIMSOkZQgfZhL+oHN0LcRkrBnrV7cp6Uo=;
	b=CIXRaVNsOED4uNQSF27ZjHYAjhfIMlHt8USZ/SNr5HA55uGNl81AUaKY94elmQEcT+uf
	 UJkBUPLGvI4gDkled3AxfgVexqbnSSqCrgLUrXJpjY2hNpVBy5uIGztFcoZ8X3eUAqmk2
	 fwCneUhNxKwYRsP/ZilKvlrect2Yv+pztA+KSJezBF/HR1vrxi1au8c5vgD/VP+OyG0KQ
	 yQ1Av2HqnnqPbv+T9TCLEGf+UR0qwwS39RML3VH6N6sVtsJXWCN+V6eWtO6RxVgRiZ0t9
	 JLkk0FLkJrUEV77xOJcPxFFPsz6vAnsywsA3E1idAsJL91EcxRjOY5Ox4S70oinc9xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ACtaH1dt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741F606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 17:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B741F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ACtaH1dt
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso869204e0c.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 10:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792862803; cv=none;
        d=google.com; s=arc-20260327;
        b=oaYOzmfIemDn3DsJr1RQFeXUc+xsqRfdCY5DGwyZQabvNMEB4Qt/+Fmw4NcBhozbf/
         GA07rECIsVA/WwzhlMoPlHu347f8mm0t/3mCA1MKdeJdujcgAogZGw8YrDNlfxhe8jji
         raFzIW+yslPm5v3iOgXXALHOWCVPD0bFGkAI4aifB2TZqqqwMeq4EkI6hy5f5eCRyW0y
         4xJ/hdFeZHtl+2i8VBB4TPa/JYKRQ0xc7eSqnpRDbX+G0m8D/6c4U0oJgD072I9Qsn82
         crHBX5A6aWRgJim662mjz3dRVn/6j4FUZQlj2R9EX1CtMn4vK+chpZ4my2OvTMKqB5t1
         CgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5IEfUPj0lQJIMSOkZQgfZhL+oHN0LcRkrBnrV7cp6Uo=;
        fh=eTNRdxAIKcUsa5WGJjzZ2v9u23rTp7D5chzwFNDk3aU=;
        b=TTRbOrN0muz7eH4zYtGYi20ugu35OJA/bLXFD2JLCpRKH9Z0+MGpglN7vOt+M0g3Bo
         JazyqXpwHeoJ91nrTgty2LfVexgwnVTp2iHA8HiRGTsfnYOHjSskA/UrC+2X/UfmioTf
         RralACdANCMXTxRcmYtgSHb/hb1j6dRLNSRy9sRmAYcZ1P0W/Lt6JhdSOfWs8yQ9c9mm
         CmVh4acffejNGU40l5N5Llv6jeCgt/8dHJDwsqnULV6n42NVw93UrKRaUkzC4X4rlu0I
         Fchl1mvtI6/YbFlIUG6PzRVN+1VKCKd2GuumC4ih4tCkrqYmhx3wNPPs/MihXnl5nbXZ
         gtEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792862803; x=1793467603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5IEfUPj0lQJIMSOkZQgfZhL+oHN0LcRkrBnrV7cp6Uo=;
        b=ACtaH1dtembb8zVHVqXrLZAppQUZoQBqtJfgFUoC7UK5sK0LXbEfgYn0LWPOQINzGS
         e/xTP7aXNlpsdNXYzti2DP/MdF7tSKvI36wSLs0l7LKLIMxjIvzFu0FacdWwqYrFTyg6
         duwS2DjAfupVIzlidmpRpmewsTUqmvKOTako5aN/lBuUvG6P9xqnNgH7tovxWhsqCoth
         WP8GB77SGN+vH5H8ENIuXi7iSPkIQSGBHtWoChW32xbZJOSO5xxlqijOYRdeTF3uu0m9
         tzlzKvlrRUk7OKXDniNDfdedNp2gNJoMlRJNr/CjGrIxXRlfC5I5C2WPA8yAu6KoNVgf
         BySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792862803; x=1793467603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5IEfUPj0lQJIMSOkZQgfZhL+oHN0LcRkrBnrV7cp6Uo=;
        b=tJT3TKwW9g4LVs/WaTCwKn5CoNzN7zVBYKGgMGouz7noqk5bBhCyahko+EN7dUZQB1
         1pB1XCdmuMYLqkvw0CgRxSPi72Ws0oBb6ctz7S1QICMOT3rBPMBLGAILweWhlua6Mivn
         7OXKtY82ZzlVH0JEKeojTRJYEKcau8AdBQ4LKYSBKiUJH7CyUMUto4a9T4kbCoTcUPyv
         hJAP62u8b37VYTPlgXkuji1RXlzASVXoaOOzyUVUsd8tyMSfEtabfkIH8Kh7wM7vxlu5
         S95DVJfSIqBQMrao1rikpeE5MZuijgl1me575zKf738Un92Ncs4qCozIG2XyimDtvRvb
         CrOQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3WaLd5f1NUIgrFf2fq1+n39rkLkCzH45ga1d2FWh3gqio2sM/uENXd48jAEuXtmKZ9c1/I7w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMCF7KqqqRj9erArN5IZRD23NI63RbaxDuTa2UTYoKumsEMlER
	QIhGa50UNZyf/etuUpoC1UzhgwFfLkcMlx+1gwVNonfee62Eny4elh7J0zX/v6RDPVyZ/sw/zrk
	acoY6hta/qVIYx8InhRea442LMkdLe/Y=
X-Gm-Gg: AYBFou2oWoB5jjsuFAxPXDmYZ9EMvSsvVyGmMoOvZ9PBgqyT9tYiMhoYnwVQ2rxyrhP
	RlVFQIPrQWhkK27rU/KChlcp6SpD0+Knw2O0/9J/AsyJ0xv8RiVZyksOYjDCcX4Lzg7dCqRcevw
	YUvSOjNk3MZTVe3N8K5+N9qaY4NXtC39fj1MhjFZrHGNJvpad1+CJMweO27Z0v5y7gyOxUTB3Wv
	mgCeFQJsdaRSHt+G0JM37WtyTzykfphOmrD1yuv4HAuVaY/mg4UcjBAhQZeEFidh7ZfNpYqyrp9
	xAE5ZXcl9SY6J6lB4wHXFjcuN8eQVyrhNCgvw1MAgjwsSv1GLAEKmAYyVdvVMl9vzgA2V6vNRF9
	5sXIW8wixImbXXse5gkNMzmZFrldg8VfSyb7IZQ==
X-Received: by 2002:a05:6122:d13:b0:5ea:c120:4514 with SMTP id
 71dfb90a1353d-5ec232b574fmr732517e0c.15.1792862802726; Sat, 24 Oct 2026
 10:26:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-rt-nexthop-spec-v1-1-9c586edf86ab@gmail.com> <179261871862.3135.17495304986227666332@kernel.org>
In-Reply-To: <179261871862.3135.17495304986227666332@kernel.org>
From: Demos Ra <demosthenes.ra@gmail.com>
Date: Sun, 25 Oct 2026 00:26:30 +0700
X-Gm-Features: AclHuK9inJxb0sYxgOsoIpCH2EcJ8IofbgXvFsE5f1-XpxddtLrszS6fSKcVvkk
Message-ID: <CAPtXtrkggxtHDGrC9jDRVVsL+=pd-pGUV+6EQy=mNh3moErdxw@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: specs: Add a spec for nexthops in rtnetlink
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, donald.hunter@gmail.com, dsahern@kernel.org, 
	idosch@nvidia.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 4:38=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
> Will C users of the generated rt-nexthop family get parse errors when an
> RTM_NEWNEXTHOPBUCKET notification arrives?

Yes, the finding is valid. I reproduced it: on a socket joined to
RTNLGRP_NEXTHOP, ynl_ntf_check() and a getnexthop request both fail
with an empty error message once a resilient group migrates a bucket.

> No error message is set. __ynl_sock_read_msgs() then skips the rest of th=
e
> receive buffer, and ynl_ntf_check() returns an error.

One correction: __ynl_sock_read_msgs() keeps parsing the rest of the
buffer. The call fails because the notification arrives in a datagram
of its own, so its error is the one returned.

> Would the alternative offered below the --- line avoid the problem?

Yes, the fix along those lines is here:
https://lore.kernel.org/r/20261025-ynl-ntf-bucket-v1-0-65aef308d62c@gmail.c=
om
