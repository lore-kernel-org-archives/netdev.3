Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9131401486
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552718; cv=none; b=bAzMW3U6+yEmuLL9DI4hstyYkLS8I1lIJ9sastyMEFlK+GvK5RT3sfcD5xEhktONee6UASpJpSluKlaMMBAL2eJXSPp/a9BjoFD9oKWdMOYMKZrxrYsETMYIdL3a2smYouDoZ/4FtIQkwuDKpzVI/L91NTvODTboW2nfhKFdr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552718; c=relaxed/simple;
	bh=tTB85Akg23e06lVcRDLDOFesDp67PEjl11pUuq4rjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpuTlTXN18ky9A2lfWtG+LfrDSviw1RguPBz+cLOGFwLwzrJIo0w7THSAKebGZsIIo6lAfbyU77VaTRWUjjy+NuA498YztoT7levuhvS00wyJLjMHBJoy9AXu98yds86TeDFvnTfCsQuhT5L9Omp2A6X3szmIUtCH0/944UIF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=f+Pormg0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="f+Pormg0"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5b048375so49315485a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786552716; x=1787157516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPcSO++aLadMD+PhAcYNjZTJ5cORSmb5CC6MRR2Bwvk=;
        b=f+Pormg0fOwrkb4FEsjvyT42FCVXKx7dyhlyqZVmCPLCz5tdHTLFe0Y+9vrzPgj7XA
         80xmaN/mdwuPdvBVqNsvnxKSRzkGXrY3YB6VQ6ehGiZ7qYtM/xqFi/eRHc4t6kx39c05
         pNnmdOvGvc8f7dQSa4baP7CeOANPXcj7L2oDR4q5jGQeDWL6v8CZ9FtFAiObLHmdqyeu
         YJig4AE16mx5l4DKi94QOsZjn07pGc/K7izRSIeHgDZ42DFEwJbHqSLBKN5aoezEwSUH
         Ygw354Jg3ycKGETJDAIUrFJBdByGZ3E3Eti7ob3LSasIo/ewP8mbR3zoXpz4zdeCimVD
         EaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552716; x=1787157516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPcSO++aLadMD+PhAcYNjZTJ5cORSmb5CC6MRR2Bwvk=;
        b=aUlGm0s1whjulzyOulr80YG2oHmcA5MflSxdoaOL0yaeAn548fdiefJ9aw5TF76TCn
         RHGUutIS2//SzWgDJH0zjAHy5zQsZhE97VYvQQJJ5rG0gFaVEU40yo9hhx2skvuXCeX+
         faXGg2D+ETOo2o9hTAMMCsc0bwC2TVARRQiGgveYWCYwJv9VrmbbxTZG/bofUZl8/unD
         wQA5OWx73LUJl+xgNo9DGMEfWv/7I6HBOGvzK2++NJdrwuAhjRgnaI9Ygw1BES+IeBkJ
         WYgXzABLiGSHL8xA7zz80LYhmE2ip+7IZ7ShgFyqsOkRnq/RwzHytaMNDiZZHpj4m404
         Mk/g==
X-Forwarded-Encrypted: i=1; AHgh+RrvSW3wumqP1hjYeXJtRR7zpCfI+XXv4FLwfWmeGkJ7K1j1efvDcVJaWkHNb1jcZ+1I8yfKJNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8b6rbkUV9XK0sr9pF27zhholfdszUwJgOvKU7jqUanH64oqMK
	7VPsmnVwnUWFhkGEc7QyJXz1dA+fk3tpaxov4y9Bysn4/SEl3yUFDqKTOdAhiDWz5Xk=
X-Gm-Gg: AR+sD12kJ93entc+/dYmMn7E+I7nGHsfGckU700LQ59y0Nr3v09D2hPy3JwPpjBJu57
	dIAYDXUc5m+8lh3TiZeuwkbNeX6rt8p5fiPpzBe8PklNkmLDPBgPyaDodF3PVpDr3gNy+UgWBML
	IYFhZE8x/9NOaU4SMBQ6qGbpfB4Er2DhxmVPglM1IbVLw/X+NZPupoZxZhO2qN+TnV1EFmNQ7N6
	md/nSECSW9mRlOZqrqHaFeLC9c4fZ33YJx/jMXArjkjk1OgKi0orMpxqMkQGGsI06s6rrydHBok
	S83jmYR+qsv2UIFQnNzsA7qUNcitYuXC+zkxAMffXnfd9H9ab7EIdfr66RJbP/L4u+YBFGTkn44
	+97Swz3O9vOoNZQd0N8Lx+H0y2JrKQhaAPJEoiZMH56DP5fjp/x+mdQGSYODrwaxoHwBg8+DDvF
	lBhx91royQuAtTS/ySeeBS+W/7REzXHhbWmOaDfBsiWTke0zzKlpAaF9MhUAsqR8+M
X-Received: by 2002:a05:620a:7018:b0:931:3ff3:30b1 with SMTP id af79cd13be357-936b3a26859mr553359485a.4.1786552715597;
        Wed, 12 Aug 2026 09:38:35 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5dd3d4dsm166040385a.3.2026.08.12.09.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:38:35 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sashiko-bot@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: stmmac: DMA address handling fixes
Date: Wed, 12 Aug 2026 11:38:29 -0500
Message-ID: <20260812163832.271742-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update jumbo_frm() (implemented in both "chain_mode.c" and "ring_mode.c")
to ensure DMA errors don't get lost due to casting the result to an
integer of the wrong size.  This was a Sashiko suggestion.

In addition, add explicit calls to lower_32_bits() to DMA addresses
before they are passed to cpu_to_le32(), to guarantee the type of
the converted value is u32.

Maxime implied that a new version the first patch could handle both
fixes, but I thought it better to do them separately.
 
					-Alex

Here is v1 of the series (the patch):
  https://lore.kernel.org/lkml/20260811192703.1765416-1-elder@riscstar.com/	 

Alex Elder (2):
  net: stmmac: use dma_addr_t for DMA addresses
  net: stmmac: convert DMA address to lower 32 before assignment

 drivers/net/ethernet/stmicro/stmmac/chain_mode.c |  9 +++++----
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 15 ++++++++-------
 2 files changed, 13 insertions(+), 11 deletions(-)


base-commit: 5e6de6a2b522f659defacb1551d0465ba6ce13cf
-- 
2.53.0

