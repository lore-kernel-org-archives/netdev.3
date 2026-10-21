Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595457;
	b=MFfcEqtweQqtLacgB+R4kqgvT7E6qSeC67kMpK7uOp8IKRcClOJ2X3sN/o1EAXgudGbW
	 Eqd3Ls9nFQ5cdjOp5rrLOCqdV8n/IMkZ3N+MI4t9nl4j8FcKDrnU9j+97v7idsB8d09U2
	 n1Mswd7AVqXnmjDThZVcKt3GnZ7aYOonRHstc5sT3XsfdyzLbM5ChiW47aSt/WxbL5B4n
	 +qlSbUlDsCJdZYfpJM1p9FFAje3Q7CyoDDjZKkzTque8X2gUQ4kWfBblu4RgcQVfUlF6w
	 MghjBIg2k9NwDJqFXH8maGv3+MzkMm0SBsNclofKZ4IKcXc1fstzgdUKv3l47nFISVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zElhJ/gBeYP0l5K0AgzKwLZUvSoCLXMv4Dnzr+BcdNs=;
	b=1xlwnxw7kwag70lO7wnOzOb3GGlmIz1Fl9bthJkrFnAPOIHCwldtA7MwCG+ydTFRIrL5
	 YpC5tBaztFtuJkXQZPzo067948vT1WesXLq98lIzP8dYli3sPOcYu27uA7QkSEd7dvPzI
	 JgxSOWD0e34lHjuP3meKnFUw3Swg6/4bIkVPW34ojFVI9RGStacIvQX8HgLtFS38dpbyw
	 Mc0goz8fLQexMCocZUsdxVX2ZShtV6pv29eSi8QkHLCbBnrr9QAOKGM+ygUQAoISxfv2d
	 bGO+98SahDkJfLNg4WdNlChDOR+rG6OWmVjtf4UhZz9AO6UyavqbdbLwzds78Cm3pDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ORh4C0LQ;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F19606A31E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F19606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ORh4C0LQ
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so465754a91.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792595456; x=1793200256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zElhJ/gBeYP0l5K0AgzKwLZUvSoCLXMv4Dnzr+BcdNs=;
        b=ORh4C0LQNW4RNpzV7/dtCh1N4kOyqj7XiM/sHzDvVFRyNKLdyhX5C0mSPbegLkAk/l
         Lc8/lZsgdA0+/O5HWwBzVb4wzwwcLO1SL4Cq03XuAyS07rpJ/P1QXCgZcri+MwA0g3Pj
         d29hx8m3A4IhPyhtBYs8FcM7B9yFWdnLpFi/On8rhOG18nKs6v3p1CkcW52WNz8hmF1u
         dmq0FzoWePSy1ALVnyxotc0CUaWE6sBZvEFhINopaNHj/yfCVL7u2btwv9wGOQz9rujw
         Tkn3IOtJwwCEznfEay1JDz7mT0f+McHPVhLd7TLD3toeVi2T8+8ei5ow73TI7Jr7/5og
         iu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595456; x=1793200256;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zElhJ/gBeYP0l5K0AgzKwLZUvSoCLXMv4Dnzr+BcdNs=;
        b=Qh6ROIQFOCHyYIqci+MWVJemY0Se1wjR/BObeVtgOkeLv+fCt5yXk0mzRBO1JlyNnX
         nVT2kTvQI7AtolEAn5w5sXIFq2O9ztoLvVMihoEWTeTh5VHVekofIFvcuj6lDxJKmk/g
         nS7YcNNSNIW8/+cb2BQS7GM23zr4FVJ+KdGTK5W0HDiiWEnQRKMHcViIpucYCMIrRRhd
         LgmKJCZTzwa6mmhvLrx8dQr1yxUgZr+Yt8xNEcCcBSoKf8nlyzSJwqDQ5yyOdOI+GiVk
         isssXV++8JlgquC5i5hFC+TyK+3t1emZbhAxnsHJXllxLgOihyvRKEHlGqdNpGD2D6o0
         jroA==
X-Gm-Message-State: AFq9FYI5IBnoF4TEZWbqtGB4qArNyWabMSdxqhsxx7LFdHyCZ/hFxg0B
	+77zEk8CFoKNYJo2KtB0i6YuPHRKz0rHMukhz8gpLop6hK6zA0iKKkbyTd4OWPtWy/5Nxe6+RAC
	DVBrEufo=
X-Gm-Gg: AYBFou2ZrKHiy78QIlaH+uQ1fkEgLFqMdauP1NMRMsgv0kheDHC+G4qS1YsqIhW+MK+
	2NqxUviJOfWOa0wUv9pAHmTcfdt8A/yFNQr4BvKt2ujIkTD4YpRfta7epcalU5IDVns0W6UhoQ0
	K6KAJzdNHTz2XXsFGrznHaSONqyywMRNlW9zrSBtyjy5x6U6v2PYWhLNMZPenu7DCW3RGWncvBZ
	Jj155yrRlMOyrn2u5EqurSzMiW9DOmIDrTz7/QekX2RNAs23RsM20GDCF4FT/GiwfN7xTiA3HmD
	VN5MgY6yjEhUf2RiOI4Aw+7O6pc/Ac43GS6Kp6Yj6ON0zeMqoh95hb7Uo+y6xe8G7d4sawlM3rd
	mi3iBbKo1bj4ZBaS1xJ2PAWtJVkaNPHyuRVSYA3ZiXFVNfabXEfyZgTeNlHXesozZFMw3n5tH8W
	e82u7cAaSFXxBV4BKuio59cmUhKmgoT+lH0Ck1+1ErKBAOTeC3H4+lyLkaexpZEc0ktZ1oaIfuG
	fcpE2awiDK8LIA8yRfMZKsEVhC7nBZMcAB576UuCOTmvTrK70E8HQSTVMdNPiUakkTQfgLIJIOj
	yow3a1HnHuICRSyDVzImOA==
X-Received: by 2002:a17:90b:3d90:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3ad86da5631mr1393323a91.3.1792595455558;
        Wed, 21 Oct 2026 08:10:55 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada47f1b8fsm4178a91.0.2026.10.21.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:10:55 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:10:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Claude <noreply@anthropic.com>
Subject: Re: [PATCH iproute] iptunnel: use worst case buffer for tunnel
 ioctls
Message-ID: <20261021081053.1e4f5c8e@phoenix.local>
In-Reply-To: <20261020120555.18bf4986@kernel.org>
References: <20261020154636.1097849-1-stephen@networkplumber.org>
	<20261020120555.18bf4986@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 12:05:55 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 20 Oct 2026 08:46:35 -0700 Stephen Hemminger wrote:
> > Subject: [PATCH iproute] iptunnel: use worst case buffer for tunnel ioctls  
> 
> Please tell your bot that the correct tag is iproute2 not iproute


All typos are my own..
