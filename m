Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248961;
	b=YjVtzLl7SSuA0fOlzCatDkKNmBlmURP/wz7mZFqu5w3l94lao8hfCn4jDEa2yDHzkkiL
	 JQCalEkzv1JTNp7cxE1cmvxIiRjlEpWLOKEu2fb+/YjdjRtDOXJFDQOnE0ChscMNE8g2o
	 Bw1DGuV8xnTgxHskepGna9FV9iiZB2F1txUHD5Z69soIIy15hSYc2/DEk3DiDSdvnKEkv
	 hGMCzohLoSQAeUNbZzVCtvsrWRmXn6WR6LRs4E3AtWFKhkGop/9ZUV3+4cpzJMBXcV0tx
	 3xsGCJJBbRqScXQZXI+A9l7X1KMO2Y8ks2kDlZWTrlyfd06Yn/DUHxM9z6om38m0l6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:In-Reply-To:Subject:Content-Type;
	bh=TyNlOaE6r53YabDf7NgKAHxeTjKkEmLPqy6LNOwpSOw=;
	b=i6o10nCBTEcLncki7g5s9FZq+L7NEscBiige85mLmNZNKHMj6YrIrnVX6AbL7SWH95eh
	 g6CRU+RfRUVQeo177s8zy787llwewVVkI9KaHPMuAjvEoSFCSmRz4BU24ibXU3X6ARGlU
	 hZ7xgwYojgUT1jLEptTAtwdNmox5gLBsJARRZKoGEIyVqxReLHLXfWsHUrNfkcfsoo99W
	 MXCw0wtTvkJ0e7woUreeWrbcR6LMywMUlYYbT+wkI3d38UQ/sIzomUeiwg6d7MLBpTilb
	 Tam9wW3gDInSuFAA4Fv1XbEf519AKVjpHJnOSEIMJxJf8xPtkx/KnhzR92QbAPBJwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVPmauA8;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF36070ED0
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 18:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBCF36070ED0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wVPmauA8
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so721847eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794248960; x=1794853760; darn=vger.kernel.org;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TyNlOaE6r53YabDf7NgKAHxeTjKkEmLPqy6LNOwpSOw=;
        b=wVPmauA8OdLBNUi//iUcElADcRibZhBlYmRzMsqGWZwocRzhlB8pAEZUyTVONutmzP
         YHGl7m7d5gmKZ+kHy+amcdGR0AdGQnPC70uqhqLev+qT0zS5gLE0OQedk71PD93HuDHe
         d4AmF+8Op5QqLeFTRnHezx/ld31iyUN1GiwdR9gI83FoQB/p3kN+M6POA5UihECgoHE8
         nuCiIhx0et4FR8tdMwbyimQJYCdpUxlrmR1+YMHy6otayeUpxcz8AVkru0zzf6Ais/I4
         VVUtRfQ+Vg5feQX7YYsyKpySiIOvAMZA1iGgR5VhnDI5k3Uv8f3/btggB3XTDbZErZLZ
         HL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248960; x=1794853760;
        h=content-type:subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyNlOaE6r53YabDf7NgKAHxeTjKkEmLPqy6LNOwpSOw=;
        b=vkmFouhUYZEDwMmExgzA7inbjJnN6Tjyc+fxq2yZtEEZThzXNdLRg60VorgPLLv6kC
         QB1XyLDSF8EL/w227nRcEvsMj9FgsmyoHjz5sF13ljqLwYT0MiX2QTOUb625I4a4CfGQ
         ntwthoB69FobF7aBA23GglYUlrbEhJnBNGr3SBWgddI+GF3jiuhTlOs0Im98Wvnnu8qU
         2zz/yHuVtHB8jmNffE74Gaid8DijYmSW+/FuaCpL3QpJ56Bc/GGCi4exv8WNWY7wLwUq
         GRXUBlx58hNCrzKZK9LO/ZithK+t1RsQvOYo/AKABQbLHnjjtQYzLqcocEjLP/TQqQoF
         GuXQ==
X-Gm-Message-State: APuU4Z8tsfli/jzitcnTDmMuPh+gfEusZtEj2JpIW4Jpxwy9KNwDdNiI
	Ru152AdX8valj0xsVA9/FU1ljBScZ3bnyFCgKhD3frZdcz0tov/7xrjd
X-Gm-Gg: AYBFou3m/UrzRdeClV98Ks0XM3VFr4OAVPFhKgq5gZTvh/vEHSexGi3J0EQe3TttQcg
	G3SVZTuO4kwdd0bWi7h1Y2D7nOUJRU9ABnrTm+952ChUgCAhRPXwj2jCQalYjpDJPcufG7EPmyc
	t0Y9qiG7P4zKdoDjPtu19zvqxAvb5jfZbKVifKQDx5G2wZlqqS6eebgtfc206ecT4e7HoZQPZLf
	eMKPaO+xMo58iphRzyn5x8rq1q0tW7yGB5qHIJCUqu/Oq+hB2EjZ9JWfm9JTGtxAmP3crIMZ8eU
	17EopzCiXrtXE38LfiJ27zEkCG3eXMijpph307wvJsF+IzRNOzxQ4MmOr8SWTLNkf99i5xYPq5l
	foUer9ZE6Dq7McPBOPbfJ2Fao9AbzoQ3+Cdn14EPdeZ5apfNvg2PgZTPS8F9KdrHmNrGN4SxZNE
	tkSEg0h+TW/mMoV47IZ4i/v09Qs+ZOLWlDbRVokcuTbfj9mmO/sVgUL6ksWobDaEzevmKAaW3a5
	OKsbVmpaydROKfUfcxV5r61AC+q1Y4n2mC6ISfzBrquBma5M+YZVSDZqjkZVfvLsWMTCAut96Pl
	xlyM8jbieerh3zkAUsnkIEQ=
X-Received: by 2002:a05:7300:e9dc:10b0:36d:3c0f:cc85 with SMTP id 5a478bee46e88-3751c82b5e5mr145592eec.5.1794248960011;
        Mon, 09 Nov 2026 10:29:20 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:41::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm99440eec.12.2026.11.09.10.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:29:19 -0800 (PST)
Date: Mon, 09 Nov 2026 10:29:18 -0800
Message-ID: <8025f6aed4bc33298e8be50280ab72e4@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 sdf@fomichev.me, dimitri.daskalakis1@gmail.com, almasrymina@google.com,
 dtatulea@nvidia.com, bobbyeshleman@meta.com, asml.silence@gmail.com,
 daniel@iogearbox.net, razor@blackwall.org, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, leon@kernel.org
In-Reply-To: <179418738174.994134.464817117967884735@kernel.org>
Subject: Re:  Re: [PATCH net-next v3 7/9] net/mlx5e: lift the netmem TX frag
 size limit
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

> [Severity: Low]
> Is U32_MAX really the largest length an mlx5 data segment can describe?
> The commit message says:
> 
>   TX data segments have a 32-bit byte count, so devmem TX frags don't
>   need a size limit.
> 
> Bit 31 of byte_count looks like it is the inline segment marker rather
> than part of the length:

[..]

> Would a value that matches the hardware, such as (1U << 31) - 1 or SZ_1G,
> work better here? The commit message would need updating to match.

Let me switch to SZ_1G to be 100% safe.

---
pw-bot: cr
