Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C157F3043BE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771039; cv=none; b=ArlzEYTyubAoPk71/BAibIYsMUXKNXoC/UiKa2i+KtoryAho/PrCtWPVvWChAP0KgoMdC6qelB2XQMjcTGY2wT6Fj6lElQXEDaSNmtMUexiHOzTIu/PxMzJruDcUnLysGtWahqn7s0Elze2yxbJ/HHbXs3ViGSJOzptS7zCQ4Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771039; c=relaxed/simple;
	bh=Jkt0CI5EuCxCpLKM8YEGGaFGwkakTl6hSnTK7Sz+CcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rh6FoFClJyGk1EoedBTMHd8yHHF1Nw3LzG5hp0zpGNSa1kr60elvYlCJQnpu8thdK160WaRhdv0b0lUEpfIP9ASAAB0hkqAW1dZy3lHseF/G0J4Mqi6gO7gSANF2Bt3mPRk/F2dZXpPskNR8l62fXXOfQHnFZFd4VvO0j1KVolo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB82fXs5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB82fXs5"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e08baf860so112424a91.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784771037; x=1785375837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WTufOXWvACFic2l9ZCjyM5s9M1424nsnl2UpoTDMQGE=;
        b=iB82fXs5o/e+uk6ww/SOfIasyzJsx2fhXhlaTQyin5C6emzSYkLGLL0HUyPRDC2Jdx
         FskWq563q7TpNCSuamOIlrV7Q9lmsr3hL0IfVwohJ/nKYn1k3aps6BOr6McEp0kVcYeP
         CEwL2rllC5IsAnbsqwGPS+XJLxbpNoCH1DQuwZjqDAyEzsQ7eaFOPFxu654G7pOIle8S
         lpBAMoASYnYCSoVT2OtfGRhzEqJLJj6QWVDhcz9kxFSL0iUKz4nPXnkHPHZEAzk7hma1
         6EHkuFNc9/HNC/iTIl8ebTq2u/p4AdQAZkPBBAUMCh0MQrAj27rexzCMlDgpXZksnV/3
         NRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784771037; x=1785375837;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTufOXWvACFic2l9ZCjyM5s9M1424nsnl2UpoTDMQGE=;
        b=P7YGwkYl2QGDoyyu/zchfXSCFHMyG7nVRlEHpsL0ngp51NaCWUuGlRRQX6hfv79xSw
         GtMDzynCAmCq4BmV6oXw5XTXWRVvGrU34GbGjmDKpMATNc5S3P0JRAaLMKRTYNvE/hH2
         nO2rqlgwfnaFfkL1EP+KW50lDWaIxgB0sfaAvsz/g63f+xXPNrCFfdrRckj8P6CgTiWi
         r6EQyJWXmLQ12vRh+pQKyCXRuNr5phVSVcYpeofoDrGHDKZnqV4NOpL4KcS8jisVvNsM
         9UEzrRfXrd0bjUVUaPGRHG9hTwISxy/7oZeTNOCilh3CcIKsFpJv+ba05c7SZ/GfT8IO
         G9eA==
X-Forwarded-Encrypted: i=1; AHgh+Rpdlr2QpuNjkRDHvlaOkY2d9rXSI9bSRYPNHxcqWYKmjtpODinK+y4lmd33BGLs6mbeRIj+1J0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+NwumOIidWLIxcZIFcSJoD4zcVvZ8yMyyrPBADCDkn2Y7xvi
	6R4if9T3jX2T5OtReaQDz6awWEV8jLBivSr496G5ws6AD7kiEbXCi056PsGYdCBf
X-Gm-Gg: AR+sD12ylvEMhc8SqhtCR6G7tBAxh5uFoC8PdXE8VQp9s6QvOxA3YilhjqQoBvKs6bZ
	+ewbBrCJJwIoHt1RlzCNBVHtlnqQNnvh4J6Ut6qC4x5zYlcnY1O65CvTd6bUhXy75oAiOedKWPW
	5UGAKtY8X0hW2QoRE/hvRowk5S1o3c662EnM5aeYGtBmIqIyU4jrVrcNrDruWv0uxEO8/8wwNkW
	Gr3smlJ7FLKqnHypkIz40pC1CvPBmQjyPgztlcQGwAI2HUyiYT333malzU+86SiuLu7OZMg6kew
	Hfg5d3XWVdqbtFBuSRN+xJBylz0xvtj/qy9pFy8PMPG+M7/Ka8XlI/gYfzGSe33S8038zl2o7qV
	2AX/1fra74UvrugtOmUIRTuGgQtllIUNpWQdIecI2LESAH/7994CWJOjHVTchN//YWG3p+AfIfk
	Klp9SjUeY+oBe+qUK+gdYT1BxGL0Vxg/rDYW8=
X-Received: by 2002:a17:90b:1805:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-38ec6454eb1mr1040670a91.6.1784771037028;
        Wed, 22 Jul 2026 18:43:57 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea5a5961bsm1145539a91.4.2026.07.22.18.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:43:55 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH iproute2-next] ip nexthop: support fdb destination port
Date: Thu, 23 Jul 2026 01:43:48 +0000
Message-ID: <20260723014348.1249-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722151904.GA3022830@shredder>
References: <20260722-b4-vxlan-fdb-port-iproute2-v1-1-45199b1ee240@gmail.com> <20260722151904.GA3022830@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 22, 2026 at 06:19:04PM +0300, Ido Schimmel wrote:
> FWIW, I don't post iproute2 changes before the kernel changes are
> accepted. I put a link in the kernel cover letter to the repo where I
> have the iproute2 patches.

Thanks, understood.  The kernel cover letter links this iproute2 series,
and I posted it here only to make the userspace half easy to review
alongside -- it shouldn't be applied before the kernel attribute is
accepted.

> You need to perform this change in a separate patch. Example:
> https://lore.kernel.org/netdev/20260320140847.1730633-2-justin.iurman@6wind.com/

Done in v2.  The uapi header sync is now its own patch ("uapi: add
NHA_DST_PORT"), matching that example, with the ip nexthop changes in a
second patch.

> Missing update to the man page

Done in v2.  ip-nexthop.8 now documents dst_port in the synopsis and the
attribute description, with an example.

> Assuming we go with "dst_port", you can drop "fdb". Only the kernel will
> validate that "dst_port" is provided together with "fdb".

Done.  We did go with "dst_port" (NHA_DST_PORT) on the kernel side, so
usage is now a standalone "[ dst_port PORT ]" -- the "fdb" nesting is
gone and the kernel enforces the dst_port + fdb pairing.

> The convention here is "port %u ", not " port %u". I think you added it
> like that because there's a missing space in "fdb" above. Fix it while
> you are at it.

Done in v2.  Printing is now "dst_port %u " with the trailing space, and
I fixed the pre-existing missing space in the "fdb" print above it too.

v2:
  https://lore.kernel.org/netdev/20260723-b4-vxlan-fdb-port-iproute2-v2-0-9012ac01b49e@gmail.com/

Thanks,
Jack
