Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF573C4B85
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690139; cv=none; b=fzZ/0yoD+RKWFtebHIJHCjCtnZBwLvXVNnBwMGBUCJnzuRK4QWMO4s/oCui7soSJfziQhdkseZaVb7IpSqTkSK2NnDaNjgPgZiYRMqC+Kaxo27XSmz4Rb+IMuCR2AbaPUhowzYeO1ldu86yEPrA2bI1Vg3hw9FcJ5mszbaNdu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690139; c=relaxed/simple;
	bh=XDrz+dFmPnRs6hfiObnwyD8/s7tk2XKP0mFc/3BTGDs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oHFblmYe5btf8UHmJJ2ULen7kGMQiz38VLSxK8dFrJsuo5ErS+UpR+W7aMW2kuymZCxhQFtYpL3wH8l19NNNGJf07R+CBFfuxN7GViEObC+RmNUdSlnK7gDvbGhuR2YrAwBo54H+MvNURdyhu4/fsDOKDExZgU/soIjxAUU2hO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMKRMi1L; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMKRMi1L"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec449cf976so688562866b.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781690136; x=1782294936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDrz+dFmPnRs6hfiObnwyD8/s7tk2XKP0mFc/3BTGDs=;
        b=IMKRMi1LUzRiFD33B/e6RsViOcDk9pmKOhwuu/e7ix8A1iuLzKdnYdWW+0Vlx6/3Pj
         ksStYcHoQYiqae9i1jRP5KDzU0UAMCk2Y2wQU/koMzEjqyawRxTfYy6gNuO+sPjiOqs6
         o3ukzAwkMUdaXDwLOOwV2p5E0eQyJzIElQ84xiCIJRYSNK99bc87pMyCQ48hq3cnoMyp
         TcSLU+e13a3QCF3adRK4rGRKUvq17+hDvWdFKeUVTKy+igaKQxZNlRUZixJucl5lSiGL
         zcdw3LwXE0dI1vRzOq28kuF7gwWrybvGdrqJSH94kJclhRxQtSLZyLSI8Qhfby3t6PhA
         OgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690136; x=1782294936;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDrz+dFmPnRs6hfiObnwyD8/s7tk2XKP0mFc/3BTGDs=;
        b=RFzglnNb4X0NB3mR0ag1fBWh2QEyi5WiPAdbnDP/M6Es6s1NYrjhmdFdr+UNqBglKG
         QNW9UxKHKpFE8C587j72oEfbH31m8jp285T/Nfke3pXp5BNTr5xTbbiANgnGlizsCQHo
         8QfFY+BFt+tpKoczCYl8Z9/4frPoGfGzP+oTHYfdSSimS2PzBLLnu4Q6bsGEiJhs2Qr/
         lY4/Ml49myN45IA4s0J1eYoCx2maqNju/jX4oSwAEFrQqephwKKF0KKGvLhU5YgJdA6m
         6LY/T7FnzBVAxyQpmT5gU/Sm/0t0joscJQOnKx/Gr7ggulBDt9LZ61qZPUvgMO6aOvOq
         Dg9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/sq/3T8BPoiVZwTXZF4ESgfkrpX8qpIwJsrMR9gN7+1lwVodMw+HrV13J2O1IDeCHGAK8xh+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk56a0Uq/Lt4upRbXsqbYUc2svG+w8c3bvVtI8RElAk05oV/Oy
	n+AIpOYdhM9s6PdXcE+JvTa8rEYe0k5VcfZrDQq0+CawNCNCiKCtHYzc
X-Gm-Gg: Acq92OFU66nmGjxWFQjQpjcRompyyxLHVWNRbkwM3pk5znE7z+FIH+lhMVtPPSXFGTF
	TZZL91PHoirKSUxRNBqMK715LFoMDeLbZ9+TUQeJfx1pCcNLQtCWaL2jC5eSnzkJoQ3KcPn2xw4
	cGaY3wzYZa3vHw6cao1+F4un6Wbmema63/njX/fwHwkwxh4d6dTP8jrM3rRPonl2uvkKbbgmh+b
	HhvJBsV5SeliUWY2EfvxRWin03uUdQbB4v6emE46TP+Rcq8+bHFpgjVPvusrji4cFCEgNdrHpAe
	BywkLVwIEUl7PDoVhC44PRXAfnNqvWihXJpO9F9q7nriDUL4n1FKsTLADp6+0DDRdHcmG8ziULP
	LLH0VTgkDd/gRn1x4ag5qMHOmGZuqccytF1S0j+SeYp2U+qx9lnUjlbSz2LUh30ijCtrJTMAbVJ
	+G5PC97k/PVtLFFXKTpIdRa5HrsHcku5EPXhtwp4R8/Ls9ofBwGS2JEj3tPxVCFwnmjdU5n3MEl
	jzhdWN55fAi13NGfTUT4lfQkA==
X-Received: by 2002:a17:906:8458:b0:bd5:1482:930a with SMTP id a640c23a62f3a-c05d2a4bb57mr124647866b.39.1781690135973;
        Wed, 17 Jun 2026 02:55:35 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f13a:1701:b918:4041:7c7d:eb1d? ([2001:9e8:f13a:1701:b918:4041:7c7d:eb1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4420570sm772705666b.11.2026.06.17.02.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:55:35 -0700 (PDT)
Message-ID: <d0e38019-059d-423d-b415-a09e4acdc1e6@gmail.com>
Date: Wed, 17 Jun 2026 11:55:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kory.maincent@bootlin.com, github@szelinsky.de, corey@leavitt.info
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 o.rempel@pengutronix.de, pabeni@redhat.com
References: <20260616184220.72d1b814@kmaincent-XPS-13-7390>
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup
 from MDIO probe
Content-Language: en-US
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260616184220.72d1b814@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

just wanted to point out, whoever continues with this series, to take
care of an issue I noticed with one of the patches here, see [1].

Apart from that, I'd really like to see this move forward since the PSE 
driver I'm currently working on would benefit from it.

Best regards,
Jonas

[1] https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/
