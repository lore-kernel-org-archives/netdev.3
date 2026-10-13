Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE44A090C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871781; cv=none; b=DOOgxN0M869DnyKNrvApRq5N6pHw9I0SP8LSifQwgV0WjX1GAwYn/PqVuWleYYe9/K2pohlpI9HJ9rGb82awvq8tvdRRlKcMiBZIKqGle1QUMmayIytAnTxnsN0dw665MM9TsSkdh5Jq+/v0daknaxtVW2+5sI7C/Oa2cN1I0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871781; c=relaxed/simple;
	bh=5qUdG1fZIVOpI3Y11JBzeXPhxm8ylKtCi9anh9rDrIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrnq/sCFtDTwIS16mooeXcow7Ag/YxxNYm9FXxysDH3rw4OLWlBo8TvXWle2ZOo5tRBKbi9SDZ3pWWiei1uxIAG/IFbncUMO0ugppApV4RN4/1C2aQAImDXMvot36Bata59cWTX7CrMoYcCP6dgwAKGuk9fH4zo7P+Pzfs7tvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIBk4YFu; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIBk4YFu"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30b6dad2382so6093346eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791871779; x=1792476579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5qUdG1fZIVOpI3Y11JBzeXPhxm8ylKtCi9anh9rDrIA=;
        b=MIBk4YFuH3cS22fMRoU3a1C/Hd+OS9z2np05YcE93fEAjmPPblpu/kmazNCoHtGL6P
         biKLr32QtFqsfZ9zs2XCWvMUJPNhVG0ksnjY4Z0JfKSaZcT1Jk5nFARF5tQKfsQWFZDb
         1BtyFshcZsagKD0yx5r5QqJjZpUWMwC4FCFC8tx6afixW7nfuP7rTAId0q4v8ys/aeO3
         HDVaufOR+hVkGMbu+6hicdfKABe3P1fgQJwRtLiI3i0BAKe46xbhjnBGskalbmNulYsr
         9FNESUx3Hz/SzFmFpuTRKejTe+UIP4shLD5PzTLkVbljVNOaNGRriFdn/Uh+58g1kWS+
         XkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791871779; x=1792476579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5qUdG1fZIVOpI3Y11JBzeXPhxm8ylKtCi9anh9rDrIA=;
        b=AYsWWXm41e3/lGPsbq60u0dEE4A2B6H1FgxAcUQFxEtPHW5XlT17jG99G/RPMhn6oK
         qEcjlb7NdXMK7+1ZEn9nRVQZbP4rKN5AegGF50BTwWBKYkxMmiX44yAVB623JcrqL8bd
         RfYmUGf5ozcfxsYBBNKydlwkVfUYmFtMVQKmF52LcprX1gcGBHh1wN/fIpaobytiB1q2
         7XtEgXlyUhqCiKI3XmT6DdQVTxN5wXKM1Q74UcP/8HGAbG63b4k9fvbkuxIWO9Ogzw+2
         DcSvjTCtgHDLJxY+PuQrT/G5s64SUSJb5UuhAFxdVv8QIMYuJ8ftg8nznd54G4XQhcbu
         JYQg==
X-Forwarded-Encrypted: i=1; AKwUvByhxabE4RSiexoN+kcJ+BdpfWb5l+ngVTBcwzeg7rbDkPwKRNPzV3T0QW0iyrQ3gExe68U6nDs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKssB30febyGf1FaVXDC4ITxx0TgMtjdT6NPKkhe/kLMiizSavQ
	U78KpE4Wq1Y+OoWF2VuDu5SkvS929ZG8vJY9/dQ5UlGzZzqYynEi7PXL
X-Gm-Gg: AYBFou28prtlPAeDNSptfDt7WogDY7vFfbQNrlUd5p1cUh7gAUaXx2v5uwvQUi7/xgK
	PjOcYdFO0ZxAmcXg+Gb74O9A53b7E77X9/Rmux/urSppWcb/lC75zd2ECXwyN8IvcjShFjCYkNP
	5e56qOYQAUbqVZQ75ZL/H5q5Djl21yIRlXLsfjbAa1pbgNfkY/8DDQEG0DT5OfFO5C9SaTWSFq1
	ZToKcygSZnCyj9G4T0sE73KCoDlSrSBeI9OCf87CQPQta4oe5Fk4qkR8u/r7OmW35O3QVV/LvbV
	9HaU//cSV8p34ZYeyf073ZJY54Dbt/wFzO6U5K7ps9hNFENsWmOcI0T7v0AH+e75xS5DWJCRe22
	djT4BPJbfE9Jw1VI1EP/FcwjPe+ZymQbSq7GYD9eweP9qHfK9mrMapEiYJCBG+mg11PDf5b5nK2
	9zbmJqD9tin26s0Thh905kwk5Mgti+BD/tDzLYpv8mXytLmalN66Pkn7NkGURsGl4H9jftt+rQW
	R14LgNN/2E=
X-Received: by 2002:a05:7301:53c9:b0:359:d4c9:6081 with SMTP id 5a478bee46e88-359d4c96379mr8845059eec.12.1791871778652;
        Mon, 12 Oct 2026 23:09:38 -0700 (PDT)
Received: from online.mioffice.cn ([2408:8607:1b00:8:5e2a:b6c:f432:a6f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm39548085eec.30.2026.10.12.23.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:09:38 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	zhangpengfei16@xiaomi.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: fix RX coalesce frames counter
Date: Tue, 13 Oct 2026 14:09:24 +0800
Message-ID: <20261013060924.2777461-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179154446637.2527009.3819979695606095666@kernel.org>
References: <179154446637.2527009.3819979695606095666@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been tested on the hardware device (not publicly available),
a DWC XGMAC with the RX watchdog enabled, using
"ethtool -C eth0 rx-frames 16" under UDP load.
