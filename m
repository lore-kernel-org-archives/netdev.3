Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EF42314B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666172; cv=none; b=ANTtnyy+r+k2pWwV9/z+X2q8boOuClBUs1kI5YP/jMr0kKm4g36SpQJWk6W2BaoO/HpVg6ZXVK0FDCGZd2+kViVibbqbTHw62ntrOraxZg0PClJQrH2HdBSX4ztCgItU4Jp34yBqBipJCGNoQOf+DBdsFlzEuKpUv12eRu4RPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666172; c=relaxed/simple;
	bh=8urvMXkl24OSZEB0wpWz9ry6TWKjiahjJExaXhP1+c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9R3dyxVgSvPtWFDEFc8BEFUosJDvlR9e+isTSkxZp6n2+/DnxqrVX5Bg+1Nd78qCUabW79QQ88YOpVplhuZu2udvaGBNFGANLK3n96gOc+leH6z++OlEIRatdL3vNxoeEBFtL/iVn4jNsfajtOCqWkiQWPhQz7bw+T6Y7zV5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnDC7fr4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnDC7fr4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3650a628473so458533a91.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777666169; x=1778270969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9efDW0M+5+xCAVk/QjLEYc7GQc94XnH8yiFV36Yucj0=;
        b=GnDC7fr4mCgs3WLus0hMXkXLcgMjItLxAOBAxo8KSQhgZ7n1aHBDiShJPfzyXe4GeH
         imv/FQi/U1In7yp9WDCQNP89HRi4XJX27q+bwjiMHKewHgYZNEmWWnmcFVicwmFsKZ8I
         iCbfuNToL9tQB/Rbvftwn9W0OgTgHMX/mjwhJQ2LHzMBRDCJF5iRDqbinKCFcFTDsrz4
         3F9x417kEV3NaSQEPx8TF1qePG0wxs6uoNwudx+P1IfOcjdZZ8YwiRgnw5wbM3lpltxA
         Zvn8lp/HFxlBpZNsxFjLpr2J3m1DMCq7p95J2l/1IJLHg8qD9T4ka4OgUtKp+RAOJxEy
         RT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666169; x=1778270969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9efDW0M+5+xCAVk/QjLEYc7GQc94XnH8yiFV36Yucj0=;
        b=Rg+Rg3sp8Yz9F3LvXNHcCJx0Lw/TzsTayuXZ4BBs5oWvo9PY0EG+enbk5QLWynW+tV
         jzHJG8wPo170Se2D1kOzvYgpmuJyzVPYzHGHmQsoDYuVz6x/mtLq4K5iL6DDwFwIdGm1
         w49P4Fy+b8wltLoplVb8JC4Vv5Rj5W+vghdRwgJYfXvbJd1oSB3jrE3ivIZqnOTmGY3N
         V/dNpWrJTs5wzMSC1Ib3XpCYsgqHB3AvaP+ZM8GIIZ2LJIxhoV6yOJ+yFeEjnd4k3WHz
         LbHqw8oCxeFXVrgtfjE+DLxsIuBii5mYCM5+6SQO111weKKxMpEbLPfCr5tTnw+YI7mj
         6+7A==
X-Forwarded-Encrypted: i=1; AFNElJ8fFJt82f0p6uap1d++H2oVKN/R1vhX7JjCxBKPi0F1TRPgT/5Op8S1VEsGwhbPzZuQFOYBIl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkhjlbCFekkAvMpjHO/G+XVTx61Lts+0YxNcUaOK8pkEU1T5Z
	7hvuMNtPI/t+5phWvXm1F51+5qB3V+voIr3D6DYTmf9o7gmDT6tdWW1X
X-Gm-Gg: AeBDievn2AvridACQRzBk3nEnnRuHsbCFRhTvwdkwOXRMlr82GksGugCrhZP31bY+Bm
	wU3/HZUBkx84wnn3c5hoVzuSG75HNu8e2mGJDMTqLvEoaM+RXPKwEW7qdJxvqXpDH76wT1Ar5DZ
	AT4+DUSn7boP48Cw8nkF7R5gQDFzi4P9O1kntc8z9QNBsXDkKcT6FXOfmWLsmve6hpZQLF7Hqhs
	6wwuFbqwkU5IIJculEy3EIBGFL5EZNEVl4VatZL0eRtKLR9iuZN5ABD6eVkK61npa9SmyIhzY2u
	q66VkV6zzqg7tWMxLcm6yiN2i+0jZV8Wq3EGZUFpm52jlQvOlCHHRfnG3Mrf6A2wI8Li9BfND1A
	YKBNMHhiBM1/0zUJIfVZIGqr8dDNO1AnEcSNzGZvYJauSdlzAEkVXq1yOKLP/qmwneGhfj7DNkJ
	PWa/HzUS/rU2hyBjBgoznzUica4XRBRmRBnykdbrDT1nV7pot8DkmRaaOh6JTdVdRDHGErUkZB
X-Received: by 2002:a17:90a:d444:b0:364:74c1:53b7 with SMTP id 98e67ed59e1d1-3650cda5d5dmr628144a91.2.1777666168755;
        Fri, 01 May 2026 13:09:28 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2ac19sm8253866a91.3.2026.05.01.13.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:09:28 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: stefan@datenfreihafen.org,
	alex.aring@gmail.com
Cc: miquel.raynal@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Sat,  2 May 2026 01:38:03 +0530
Message-Id: <20260501200803.3371428-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260421073259.12345-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260421073259.12345-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stefan, Alex,

Friendly ping on the patch below.  It still applies cleanly to net/master
as of today (verified against torvalds/master), and Miquèl provided
Reviewed-by on Apr 21.

If you would prefer this split into two patches per Markus's suggestion
(one for the leak fix with Fixes:/Cc: stable, one for the misleading
error-string cleanup), please let me know and I will resend as a v2
series.

Thanks,
Shitalkumar
