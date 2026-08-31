Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67743ACEFB
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199873; cv=none; b=Civq/F3TTAVfJSGMLJlWKWHQ8dTMs6cNyEiQHkoaJLvWHhrU46mkyDjQOVUqYzhbYufAfdgAIIjJ5eJN/jj9vq6rapRjq+hwKGvHuT9JRpx7Gx7TiLwy4uAtpJECW8PeE2zPFc4Kn1ghZMthkl4Bpb8PKJoL5z0QLJXgJ6FZ47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199873; c=relaxed/simple;
	bh=VX9aq1/R5RrwRZmL7z7ZO3HDaJciT4M9uo4YXELNbqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=elNwidSxp/lKF9ajMZu7AYTiDKPenkJzYhHGiIvYy/rjjybaa9dKmNSfP7tZx9cFwV2cHInCnNA+xpDFyTzYFwGUNgFcp67q6lVSb0P+Nt5FghBEyeIGWzqeJZgjAB5foaiaVP1TunbA+jBCOHHWSR9NReuV6AfSpw74tjrQ9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fBfCCKAR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fBfCCKAR"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbee846deecso99580a12.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199870; x=1788804670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Wrt3p9UIC2EP+ugVnAYAftXrBkKybsqm1b51KtSzCs=;
        b=fBfCCKAR9qEL2RzDJqdpp8hVecn3yNx0in8YWyfJ2MdIc4Xa3yHrYOhu6WjNAWIAez
         HJ1NAky5+sNAFQsvKKvoIUdSQiAs+dZ2fxaFsdivwomgbRkRk4AFaVI2YsUUzzzxBhsh
         wR4sDoeYlBL8fuRnlWstCEgxWvg1UQCeGiU4CxauGrtDZTIUqjgRPElejWFB9b2cgmq1
         /rRYvIm7grg6NlP6/hjfH2mxFyY1EYSiI8BN+YCtjbe9yfwTX07WPAtisr5Ju8cA1FB1
         4/0Sxeq1gIRWBhCcz8wZ4wiJnnlH63T7yLUrj9mNeA4mEBYiVkVDQoiKS45vgNYZNdST
         F4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199870; x=1788804670;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Wrt3p9UIC2EP+ugVnAYAftXrBkKybsqm1b51KtSzCs=;
        b=T6OivBglTEdaHmLBwv2G+1oQuQhY1uan0j8G8Nz5Bc2MGxm7SP8yuWYihP2kHgz9iQ
         u71VGMNGcIGGw2H5Y/yTy9Ad9rh4p/MLukdVTciADrNyNFkq7hjQlH8GIw2l6Oy/Wb7i
         7j6k0pLpW7fSoQ1WH/8jUmdkAmSSJTRy0STh4Fz6A4X1tm40gv6qTxMGfiDHAttXWRTs
         30x8qSjfInLxQDpcSU0Hr9t/ubZqP+hCHEdDqYVb+u5pxHgQcIbGcvgzUoAcPjfmM5Dh
         QpbQiW6sB4bhHwCFnXwlz2fp+R5GkaGFRn3yQgTcGUF/LIjBz7LiIbV1BbvLisafKMvj
         PaOg==
X-Forwarded-Encrypted: i=1; AKwUvByhQCcl3VhMEgB6gTXPA4mE3o9AVNORqXuL0AJ4kAm+EDOrjSWobjBaVQEoPXI77BXKzXB9REc=@vger.kernel.org
X-Gm-Message-State: AFuF++m3+3cnXCHZ4/ONLPmQ1y4FQ4b5Z5b+d3UeaEHXIcWHXxVjo0LC
	a0nbSGqnL5uVuxic1SxYgF6yVZfr44LvDBceZiYcBaeUO6oTISLr85MNQJP7biesGWU=
X-Gm-Gg: AYBFou3U/4bcSyBN+N+Hs/TSkfWlZKJU3P3G9/W6knKCZPBp6Buo3qNwrSBOMJFC3AH
	lCZ8YAKnn3Mo5VdOBSC46IZMqqU7OW5OfAPekjFxxWdP5eQFGP1oXUMMuaZx9cxCXyTBvSdFIBU
	nlR9ams/jTQODDhK91b7Um5FiBnVHjobRAmjFopvJxf7sELqSJoCwWfIthVrVTdSYA+PN9TKoyv
	yh5OVsu7dQWY7PiaisHdE8AvBqgh9a3kP4f4yrGO9B4npifLdRkN6yCKEDaEs7CRDrsqkCVPxo7
	a3oDxgtvqIvosXNrIkJEU+S9TDqBowf0CM507e8B2Z7w/rmc+U30128/ePxC0dD1uCzOkmZ7E1T
	VdnhjxeFlKMHj7bZpcBlUorRniXOP1fTP6tOhlBcPkP/U2k79yBKfsXPxFFbHaboGcC2Jb+ixYU
	DgP3xGe7WNDAaZoW4jYZ3O40sNkCcc/pN2VkOj51//yg9NX8klnsbZ8fdJWA==
X-Received: by 2002:a17:90b:2b90:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-396d0fce294mr46228745a91.12.1788199870028;
        Mon, 31 Aug 2026 11:11:10 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990d4ede7csm757891a91.13.2026.08.31.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:09 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: nm@ti.com, vigneshr@ti.com, afd@ti.com, aaro.koskinen@iki.fi, 
 andreas@kemnade.info, rogerq@kernel.org, tony@atomide.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com, 
 Parvathi Pudi <parvathi@couthit.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, danishanwar@ti.com, 
 pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, srk@ti.com, 
 rogerq@ti.com, krishna@couthit.com, mohan@couthit.com, pmohan@couthit.com, 
 basharath@couthit.com, Murali Karicheri <m-karicheri2@ti.com>
In-Reply-To: <20260723102041.372148-1-parvathi@couthit.com>
References: <20260723102041.372148-1-parvathi@couthit.com>
Subject: Re: [PATCH] arm: dts: ti: Add device tree nodes for PRU-ICSS1
 instance on AM571x
Message-Id: <178819986914.2869653.5429087561211412067.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Thu, 23 Jul 2026 15:47:23 +0530, Parvathi Pudi wrote:
> The TI Sitara AM571x device has two PRU-ICSS subsystems: PRU-ICSS1 and
> PRU-ICSS2. DUAL-MAC Ethernet support is already available on PRU-ICSS2.
> This patch adds device tree support to enable DUAL-MAC mode on PRU-ICSS1
> for the AM571x IDK board.
> 
> Each PRU-ICSS contains two PRU cores and several peripherals, including
> the Interrupt Controller, IEP, MII_RT, MDIO, and eCAP. This patch also adds
> the IEP and eCAP child nodes for PRU-ICSS1, making its layout consistent
> with PRU-ICSS2.
> 
> [...]

Applied, thanks!

[1/1] arm: dts: ti: Add device tree nodes for PRU-ICSS1 instance on AM571x
      commit: fad89162c71bc2f81f99191d93edc63d5f6397a7

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

