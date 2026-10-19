Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5974D9F6A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407187; cv=none; b=d/T3DHZA8ejirT7Og+wfX1DZPYLTYYs1A4zsCDHL+YCKtUa4mW0oY17KDs4v5kDuWEnblr/vQxhWD047Bsm11vrH9HbvjIyQG+V0P6DLRHBDfPh1JVrMxjBJnGlemP/TKlUkTzahtpgdTic/YPU7z5TnBRjnRLB1acuNKmXgU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407187; c=relaxed/simple;
	bh=mXqcORp3c0k/JI9vRxkWcWM/ra2RqgtpfC6MospUu20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNkDLp5HQ8V7mksLE+dztBH8qCXIVHnkOdkLFTkJ+x310N/J/VbzV6RLzIGTHosmiS+Z4NsD5yL7TL1QFKHPodst5IjNAsrE/mzbSCqFnglUiB4DSGlU6W3hJPchAfKCeg4BuoYW4DreyzWYSxCgl/TZzqnhSZ8h0AE4IQNFWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=vs1EWY72; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="vs1EWY72"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4322d310e7so139713066b.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792407182; x=1793011982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXqcORp3c0k/JI9vRxkWcWM/ra2RqgtpfC6MospUu20=;
        b=vs1EWY72TTdEmqgg9GSothkPq2obVMv8QC9r5XAdgkoE8NNuIVDDGkwXwbb8pnktXI
         TPsn8u+s8YshT6XpfsSzVPU2XlH8qDLgrmozRU9K5RGxC+Xl+xKb5PSrmoZ3lFQPiZ1T
         SLGWiDykt9+w4f8Zfe63tOkfymqgy0Hqnu4m1Mpqy28VLNDU+Ea48Jrsjc4vW/VMJvsR
         tVLbyPAiTgmYFno/8wzKpoMjmVeN1hyhYrQyrYV8mPSOIrm/30esG/yaoFgSD+t2BlaQ
         m8GWYN92xHDGGy0VIeucD6mvNjf+VhWPcj/f5fRqfSENVX+gQf5iiOumNicfYKl+T7FJ
         hKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407182; x=1793011982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXqcORp3c0k/JI9vRxkWcWM/ra2RqgtpfC6MospUu20=;
        b=2G33d1iCFEzuoObBoXJwB28D5fDy5MKp6Y82vSox/gC4TDnIf7XFwQM5+b2xMUtjyw
         n3of+GaqGuN5m54ErQAPz74fA0rxgzEuvrvBOpbECZ34vf6bF9LIeHJRaHqfw0EJB3Zi
         CSkZ3rwFbpxQCcBROvCez0meffSYB1M1frZ/OCtxjAj1bT677ZLvhW8q7RBmOK3N9Cxv
         jrV6r8mNoyGd0EGWeIKs+jlagivnr4SoBSaEjkb1klmV8CuScUff4WrxP/Ffczjoi1xc
         pQq9TpJB1oTKkh8mRURfwc44oK9+D7QhizC1TytY68Pt+Ksi9KEQuAvJdZCcV4XcUaae
         aX5w==
X-Forwarded-Encrypted: i=1; AKwUvBznQBtBuQCjgD48JzIA34yA+G6tc+qAgkvOgqveZLy6zkLxDFb/87WjubALQJwQBZd5Vz9GhT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaowYsOdBIjHjjrlEJ3SUeWUyJobYW1lPZd4RT4liXmI5dyz2Y
	et6glhux7QcjCEAsFEQ2H1j8QjqiPacblr5FX5gPa4SAQbKvDJ9nTTteNwBXlh1H/A==
X-Gm-Gg: AYBFou1aALlWNvw2oK5S9w2kkBKqskEGHoTRcqyf2SaYBee1zDeVKvB0yZDNP+X9YQu
	lnR8+24HLCerFo638PBhRyEbkf8Y0J4U5J2nmRqnSfe6onkjtf4nYubO54twLv0TLRPeSIIdRGW
	qlIp9fUK7Cm5j9jU1S3Xnu5azvEs/9F4zCcAHwIUVjDgTf7ZQlsXU9HHJ3ZoLPnPrfpeQ4EAs/h
	ZoTt4pQRUvaS6mlfF/wNM/Q/BlZ7gmWZpiVzvpYkzAsDidn7ZkZYpBXSluHXPm1AQKFuFve/YeT
	jo2kiyPUvo+ozLD2pQWlJI9Mhx0Qua0TATJOzz49/OBEoR9qeLKdVc9wjvh91ySrZtAub4oK1Kp
	0aNAfIyvUCn9N8FukSwhd9UUnnz8VHnPAEvyWKO7p7YnEpQiamyfTPtLkU4j5hgKST0DYMwIq50
	1BWBRh6qavYa9aDmhYMvCVmVnbv1tMZJQV17SSvA+pmXARLeid81062WRulwtrLCCLlD4eL+nvI
	h9qp867eXs8O/NZcyhIwtVIOMN6rV1DgVjqot8Gf2k9nKJ6x0iOYzf8fiYk9GNDuhJ0o8tTJgsb
	EtSCy8i6J8THwMToYl2QPiiKruDJbLHfoAngEqfrCgf6UyVgVXZ8/XejQa286o5K0br5EUjyxWg
	Pds9d9gC+QEcO65Tv1Kj5/bOTzxVBVmUOghrQurXHhPL4qsDHpcS+iu+73f86D1l8tT9U7HWuft
	QXm5tW1eoulgbXFz0L
X-Received: by 2002:a17:906:7947:b0:c29:22cf:b0f5 with SMTP id a640c23a62f3a-c419f122235mr458126166b.33.1792407181819;
        Mon, 19 Oct 2026 03:53:01 -0700 (PDT)
Received: from Desktop.fritz.box ([207.22.61.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091fade41sm345091066b.82.2026.10.19.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:53:01 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org
Cc: netfilter-devel@vger.kernel.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Subject: Re: [PATCH nf v2 1/2] netfilter: flowtable: fill the vlan key from the outermost tag only
Date: Mon, 19 Oct 2026 12:53:00 +0200
Message-ID: <20261019105300.767810-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <atXxYLFOijwbFXqB@chamomile>
References: <atXxYLFOijwbFXqB@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026 at 12:30:56PM +0200, Pablo Neira Ayuso wrote:
> There are only checks for ETH_P_8021Q in this codepath, no 8021.ad.

Right, and the commit message gets the order backwards.

> Why this new check for tuple->in_vlan_ingress & BIT(0)?

It is wrong. It drops the vlan key for PPPoE over VLAN.

As agreed, v3 will follow after the fdb series.
