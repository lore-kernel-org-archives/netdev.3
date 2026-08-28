Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72037A85A
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886012; cv=none; b=uGKt8v15J71Zwu2SZ/GtKyUEUWol3U6OtIZTNu7kbr1j4aaMmrFiRo905ItoVALOH7ytX87zoNs8WjV2rCZm5hgL5Q8jLgFWzWoXDy4ySa/bkA95Smr9e3BDKytS2WLli+H5itWmylmTHqmdnMK+ZFiwiZsVpGNcjBBRezEOhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886012; c=relaxed/simple;
	bh=kaIgm9xItqVDHCw3IV7XYryNu0fKs/pvEeq3wEYycFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/IEOAPIWDQD4PTkABErf01OZ49gEvEO4sfnf5DIyjltw31HHJU5c+fKTYBh5ashAuft/der4xcY9WpUoa59mnGlIE17fw6aPK3f8qSTBRblKheZ4yuc8RL4arfCsC0e/cQtkzgSzmeRyi3vkDrsXG7mQ7wVl7M/WQ8Ddb8PB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2pvPgDP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2pvPgDP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc891373e0so3726355ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787886010; x=1788490810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaIgm9xItqVDHCw3IV7XYryNu0fKs/pvEeq3wEYycFs=;
        b=f2pvPgDPjAQ8KDj2m2/vroYny8rFIZBZBF4zz1dNspSNLL7BhV383OlKkr+Sl3CoyS
         1THO0CYIq2hkScVOnTUcFG/ULJQLYCkRZMyG+1WGhuTv9vi9+NSYtfpRgqxlPbtQqFTO
         RsmxDuj54KNUd+uyWnQjGZDcZV5D59JkDK432TDcBE7o07Uy8kebJTMl/PDkgti2xYt4
         JwGaV1jdvFnPzBLxhHkVdWAiSYkTbosz3sY78I8OsHC/yyLagETetMVw5a4xEVixNkDG
         LcqIkbVdcWAe/u3oaAEyBtopIc7854FFK6qkKaaqfhzg/bI4C+hvtiosZNKarFd9mGEo
         p9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886010; x=1788490810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kaIgm9xItqVDHCw3IV7XYryNu0fKs/pvEeq3wEYycFs=;
        b=jktDLk1Y2dm09uA/ZnjuUEMyF1mShrMISsHFgyAqSR8gSPjy1y8k0QDD67emJ0jx00
         mxM1lin7QPtWX8XLlgpN8XrhcqjjtC/fZoP6f2+XpktIKwxTinHmdtnpk+3zyCasMery
         LYb87SsA8UNl5yZssbEAez/n69/XFkwzBs/W7R0iAjfomeF8+TKtR250DqHuhwjCcwbi
         yQiXTIo8Lxx5B+oE91VFNhYbxKowM5rhBasNz+zdHkSznu2xQD6NjaH5ZFPhbXLNmtol
         /yRAB+seFhBeG+4iCylYMqa60vnlUs/Z5fxs0f47WNnfmaSxROFZOL/pdc8eszMeXB7V
         qXfA==
X-Gm-Message-State: AFuF++mBcngJVAY8pXFYph8hMn2KC1CM2KVDhBCl6acGY9qnlg1xJgQQ
	wphM/TxGMRGDkpubhtfI3Bsdbiy/GzRXoaLuFfZ1j8RzpzUwWs33sxVQ
X-Gm-Gg: AR+sD139qTmKWSSWUw7VW/4/k845lQzsHN+S8CGE61yzATa8UE6AUCIJG+nLko/ut+P
	a5DbXIA69LyCvZ94fsaMkMqYdmDKCUs57GnL18IZaXFoR4U4whf6Qhkwg/0lOBtZyfGB+3UvDz3
	Ph8ulX5l3+1KeeWmvSYcO1qigqlAeLRi9+zZU+O9nuzAdS/jHKmci809kgO1GrDoPnBdct5nPww
	U9+NRSjLu0YXJiU508/LeE3orQfeucKr0AbCEtaJwIB0xX5H+hcyHOm75UjyzsqqW6l1Kc4qSgD
	KB2e+Qyq83D5h9fppM4vUCeGjiLtnBV2OrlWYDTGlF+AMP2KM0wXHIGzVoxNspe6ygVJlCVtoUb
	JubgUGVn+5nz4bGeYy0RNfjPDrS9dyqVgTvBeEKUYEY9LLwjEXsU09/mzNiaqKNvuzn1AoaFCSE
	0LtTOkFXy67l/+dBIVr5CZ99qoWGcjHdvX7pmcvXVchzA88yjG16lDvojmne1lY7Vuvw==
X-Received: by 2002:a17:90b:4b05:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-396d0fe2140mr7009774a91.10.1787886010175;
        Thu, 27 Aug 2026 20:00:10 -0700 (PDT)
Received: from DESKTOPHOME.lan ([240e:3a3:9304:9820:f4a6:931b:cf31:308])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd55a4sm5237878a91.7.2026.08.27.20.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:00:09 -0700 (PDT)
From: Ziyou Xu <xuziyougm@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: air_en8811h: restore LED GPIO output after MCU restart
Date: Fri, 28 Aug 2026 10:59:55 +0800
Message-ID: <20260828025955.412696-1-xuziyougm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827083319.391122ea@kernel.org>
References: <20260820141034.1400439-1-xuziyougm@gmail.com> <20260824185043.2701718-1-kuba@kernel.org> <CAF2gcSXK6H76A5Z6-k-D04VaCR4QXNiWLmbQmcCBpsW=L+Hwyw@mail.gmail.com> <20260827083319.391122ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will do.

Commit 03b4702fc5e3 ("net: phy: air_en8811h: move LED GPIO
configuration to config_init") has landed in the meantime, so the
EN8811H path is already fixed. I'll send a follow-up against the current
net tree moving the AN8811HB GPIO output setup from an8811hb_probe() to
an8811hb_config_init(), mirroring the EN8811H path.
