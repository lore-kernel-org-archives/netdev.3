Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793725205;
	b=ylRzXVou3UeBD9xnu/z0YSCIxpm7CcJwfsrXhGKmYQlhekWd2ga+HGotZ/jTcYVePvjM
	 GaE835bGs6VGeZo15Fqfu1JAmixeXKpbK49Dc1S4ww8yY+S8tY6mX6Zy5XCQKTQRmcwkb
	 WlFUVbkoj7Etl/v1G7tITKB1EW/kvUKMHexGgGoHaatIkxYeKr4J8IHo3b9jN+RfAO3tY
	 qN13ONkTFFt7OwrdebzTVzpzztCNxE4Lt39JddWnLjeTUas6k/Lq026a7P8dx+lKk3nAH
	 G1P0u/wspajz760/HXJ6pb/LIM+/ofUxCbV7iknx05ckWhtiykWLOy8kG6i9QZDdXZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IwENZntiJlarlvFQZtJA8Hi2kPGzvUj5L+0sjlz0GhM=;
	b=EeQHCJ2TnXHLUsBGT0jkrV6R/VOfi4lDZeKSF+p9V9YjLSlbGaUeeWTA1uoYaVOqR/oM
	 qgxHc+H9KD0JwXrxBeiV1SvsiGrl4mhQrkv3FAEkFWtQ8BUgOmH9/DU4lOMZ6E/N8n1tZ
	 Eu2EYT8lgIIkh1wdO2B6Pa07Zc1Uhr/7dgDbSQmCLcc5k7ADF6stfmW4IcRcdYMM7aBfI
	 A0j8W5U0Wg6itifFKXhEzjlGj53727mBPS2agjWen4k11S3sWlLocNnWSjOsu3ZtgI0QV
	 W68GdhecpEWpJ3KviK13u1TEujtDJs60+5+siwa/exq++UHBewe5ySvwKFys0YH6zBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4H569jS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E98606A32D
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E98606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4H569jS
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67be6030c9fso363752d50.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793725204; cv=none;
        d=google.com; s=arc-20260327;
        b=KWvjalU2JjWK/UcEjNXOz21Bf93j0l3FFpDpljqHrSeLM3h/juishCxPbYkhZJeS1J
         xQTUDyACes582DoDVGzgd849ULPGEsG8Spmxc+LmZ+J7m7+wpKQ90GIxUraXIqOuMIAq
         Xa5YDlAMe3yU8eY0sCId4pcspTvXQVJLqpKpA3c1jmWsw0G8lCL580UAscyKbgW7YchP
         D40knhS+g27Bk0P5qC3GVlDNuIqxtRZQHSRjUvWd0fWtZ31Ncz9pXwg99uO8JaNNuOt9
         0n3BQtIfVSF8BeSeFI9UWPachckUmFFedhrUXlyAtGVvcOsHUflt8qOiylzy8B3sFdlO
         c8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IwENZntiJlarlvFQZtJA8Hi2kPGzvUj5L+0sjlz0GhM=;
        fh=p1lSp+eagMvvtUMgtpOxbkIPRWyyOgifvSXsDvQx62U=;
        b=B4s/2JID42Cm/DikG1v3WW6rcbNmIr6vLhzFRnyRgBJCszdCYa2/u783DRY28U7LuM
         mAuGdN3bAEiY+DU3yo+tNs6sduKotyDNTsJIsOWzh3AipUSb7s8+je6x+J+v5icYYafX
         47AlXMi4bmqTYNyUjbYksNvVMOaa27ZAizbGCAChRuFoRfnOXEvginFItog4HF3gBfeM
         8l5mNKzmEOHJ9NDpY1dV47Ia2kXWPhvMrTpwzUXLK1hvcSf1ZyNAKsJq2vEmtqL1rd8L
         pRoWKjdxrSy45BBxde8BMMBUodr7c7QGTE6FAtauAfrR4dnqXSl2UN1cjkL45MdoP0kJ
         ruiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793725204; x=1794330004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IwENZntiJlarlvFQZtJA8Hi2kPGzvUj5L+0sjlz0GhM=;
        b=k4H569jSNCl7pmw98TBgG0nbexJM78aST+cZIQiq6SpBtwiyvbDsZORQ8P8bhuI0Uz
         ckpHp7quXXbxiZHFqZrc+iNY/6HcmMAy5gh20AP3xQOLYCMxdY3AYEJxfTKfxlHEz7j8
         p6liLVWp9qEzHIIJoV+jkW3mzum+kQzNQ+K6EKG9f1EHL5UXr2tELlypFdr1s9/FpqQu
         /R6q9+4CFmEe6/e9lDzuR7MngJfmG4FFUrJkDRJkS+VdBPL+Tzm/rjXXckE6kLS2tOLk
         Pye+oyypvdm5kKNAorqaCwXXk1GC35JVwaBdS1PWPrRbXRg9LLS1mYu7tkoND+xM1wJk
         RGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793725204; x=1794330004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IwENZntiJlarlvFQZtJA8Hi2kPGzvUj5L+0sjlz0GhM=;
        b=Q7NhkLNG+bYBxyPFAuYDknuta5Hjf2QHk6IYhpD+G+ZZM9WMJWbOqEmL2wKgi5N1xq
         Qi7/E3d6NQUcAUAx3JIxf366gwNv8n+GtAYAfDF5lT8PFN6uoPzZj+VeRdTeCjbTAHUv
         2o5gI3rDNrRWjqZasy/UY3K6EHNTUCCAmZTH4Bl2LDkuS8QuMfzW7VP8kaEWnKs6JiBl
         YVbwn09ELB1W+1KEIluevZ8zKuQSIU94INlfHmIHfpGmyoapdg3utJui5d6tb/v4On8F
         F92V1Q+BjTn8bgSX9v/sEJepdRd2URGv4Qnh4AxOavqwzIz6hRrUUzmj6BRcsf+OsUdp
         MgAA==
X-Forwarded-Encrypted: i=1; AKwUvBzufqj/O66wRAA+Kv/n5W6EcJYkHG6g+xIeS2gibxQBkUFPx+BqlGDCdycjsetnENRh0SqIUqQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TKT19jynPYfaAcW/U9O/a+KHP3AuJyKaNSLy9xu+b/x590KBl
	qAc6K4nolB3/srYAl3TGS77+q91B2jl8V2I9pSA91/38yxKKfMzQ5eK7Rx8hy89XwfhfUwpyhLy
	maxStwabLeB5W5eM5A3dCGDSC1RBpb8s=
X-Gm-Gg: AYBFou28c1AOSFssJVzw+c7dzQ+n5NTmKSfYBAGiJwuKAPXnFCOhNcuAPjeT1qS0SSZ
	eSMf3Zo6K8m/x2/qI9YPTpuseHK04gXi5lYtC/WaiZx+0dKdYk8ANorlyzeYbMITdVGdBoqaq8i
	OC0J9uxb5gruKY9o055G1LHi3tWaVK+zJyY5OheGZlKMbAZRGpxTVSDvC+SjsBDgGlRkTMqoiFx
	0+r5f6IXRXanvsk8KRhpcoyYGiZ90fAnEsomxLFOfTe7aFi5FITSPblklnp2/37w/L148W9+uoh
	LmTG1MM4orkRtm4xo7pFcYqFTo1trW3fpKg169V2+KtMbKe65X7GfKktWtdNVALJCxqljuNw9TE
	/vOazGDvdTxQpfO9ZwtJn4hZ/n0xWBcwYrMNzdSNpXr1ezaJjww6hRoYXNjdog3wn2Vsr+g==
X-Received: by 2002:a05:690e:11c3:b0:678:d394:76e5 with SMTP id
 956f58d0204a3-67ba50b2058mr10515522d50.78.1793725203567; Tue, 03 Nov 2026
 09:00:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_7A270291DDE5CD89DAFFE8A745D094D5BD06@qq.com>
 <179344707641.114606.12665582704521593779@cmss.chinamobile.com>
 <CAMMLpeQKJO52qhba=G-ZudUA57iAdX4SOapOv7YuprBZ3FzM-w@mail.gmail.com> <1793605892000.83333.5506952827930878398@cmss.chinamobile.com>
In-Reply-To: <1793605892000.83333.5506952827930878398@cmss.chinamobile.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Tue, 3 Nov 2026 09:59:00 -0700
X-Gm-Features: AclHuK-cYMiCx2wsZWfJ2YNCFTCxFXBS-_OrcxP7_PfeEMQ65pCJAdArhgcDTmM
Message-ID: <CAMMLpeRtPjuxzJhy-pFe5skx9oUw88NxNi6DfMjoh=+VpGn+jw@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv6: reject wrapped temporary address preferred lifetimes
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: Yingjie Wang <1075151112@qq.com>, netdev@vger.kernel.org, dsahern@kernel.org, 
	idosch@nvidia.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	yana06070@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 12:51=E2=80=AFAM Xia Yan <yanxia@cmss.chinamobile.co=
m> wrote:

> The remaining worry for me is retention. With a short preferred
> lifetime and temp_valid_lft at its two-day default, deprecated
> temporary addresses stay on the interface until their valid lifetime
> expires, and this path does not check max_addresses. Your 90-second
> configuration ages them out fast; with the default I would expect
> many more addresses held at once, but I have not tested that or
> measured the cost. The creation rate also depends on DAD timing, so
> my earlier one-address-per-second estimate was too definite.

With the default temp_valid_lft of 2 days, creating 1 temporary
address per second would result in a maximum of 172,800 temporary
addresses. If the user explicitly sets temp_prefered_lft=3D1,
regen_min_advance=3D0, and dad_transmits=3D0, that's exactly what should
happen. When I tested that scenario on my desktop computer today,
Firefox worked and overall system stability was fine, but Chromium
failed to load any pages and NetworkManager became unresponsive. It
seems that some software doesn't mind that there are tens of thousands
of IPv6 addresses and other software won't tolerate it.

I'm not convinced that using max_addresses to limit the number of
temporary addresses is a good idea. The default value of max_addresses
is 16, so in the worst-case scenario, after 16 seconds temporary
address creation would be effectively disabled until the addresses
expire 2 days later. Similarly, if the user sets temp_prefered_lft to
1 hour (a perfectly reasonable value), the limit would be silently
reached after 16 hours. If we increase max_addresses to 48 to be sure
that 1 temporary address per hour can be created for 2 days, a brief
period of worst-case router advertisements would still use up all of
the addresses in 48 seconds. To protect the user's privacy, new
temporary addresses must continue to be created no matter what is
happening on the network. (With one exception: If the SLAAC address's
lifetime is so short that it's effectively a temporary address
already.)

We already have regen_min_advance which specifies the lower limit of
regen_advance. Maybe we should also have a regen_max_advance to
specify an upper limit. That way, a misconfigured router could not
cause a Linux client to create a new temporary address long before the
current temporary address expires, nor could a misconfigured router
cause Linux to use a long-lived SLAAC address without creating any
temporary addresses at all. The maximum number of simultaneous
temporary addresses would become temp_valid_lft / (temp_prefered_lft -
max_desync_factor - regen_max_advance), and the user would be expected
to set temp_prefered_lft to a value larger than max_desync_factor +
regen_max_advance. With temp_valid_lft=3D172800 (2 days),
temp_prefered_lft=3D3600 (1 hour), max_desync_factor=3D600 (10 minutes),
and regen_max_advance=3D300 (5 minutes), there would be a maximum of 64
temporary addresses at any given time.

-Alex
