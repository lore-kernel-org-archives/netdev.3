Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908B424646;
	Mon,  6 Jul 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339822; cv=none; b=qZwVq79IJ2hpm5Sb17Tq3c0aJZADsW7RmUjLgyzsdNQjJCuaqT4JZ0oDU3ya8eChV4qvNTxEDDiTToE2qPF5i+IQ+bqxjQ/v3M9e3eUbcFhZWODWFF2s3KlgPev/aSZ77uBuvXtAy4mJVLHrjx+DnOrbt0T1arbmDkwkNtutqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339822; c=relaxed/simple;
	bh=u7m2qzvclRAzlNrWaix85iarwUBHiqdv5gkpU6O85Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGZglFORmsfdOKwRAGKrHSXzs+GejF1O58TFaKprmK3c3jBwu5ISjCkKUz+HAO6PjgVhEt2tQ67acR0pXrCsQIik+BB0ZSsRv2uE1t9EqaDBVmDSLMLfqLZK2wj3RI0SAWff1GKHPRSLeNkOejUBe9ukp97GMQWCFR8rTDfvP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKuYd+/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKuYd+/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A311F000E9;
	Mon,  6 Jul 2026 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783339821;
	bh=ViFJ6MkpwlGraymDHAgjHWv2vkb+kIiDjPSo07ICBaU=;
	h=From:To:Cc:Subject:Date;
	b=XKuYd+/DQP5R0dYOY0+xqTfSja7yCavH6spNts94Okaf+ATb4/BFjwwVWsiDKsOk6
	 PmnVaZjr9bAI1PC6NLu6Fgi4R28yWs12TqyICR60niRJlj00AqdvzUj6SlCQCqyU3V
	 FIKhNInNdBnf1DDJlPica+WPLR3BU3Xh/TaZxFjcZhfLwiKuf6Bxnz7EYOTzwxhkJu
	 P8RuMvV2PrsZgZhc/P3tfQe7PA6Qo8FI5iAndl+2Z69Y1p7uhi+ue/8SPVIaptgKsH
	 a9OvuSwRKUIIES3bH8QNmZzZuR9nKcDZgqoW11MxjuSaBi5DsQYToYTItppF7YR73C
	 Lf11DArYn4RtA==
From: Michael Walle <mwalle@kernel.org>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net] net: dpaa: always set a valid mode I/F mode
Date: Mon,  6 Jul 2026 14:08:44 +0200
Message-ID: <20260706121011.1948906-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before converting to the phylink interface, the init function would have
set the correct mode in the maccfg2. After converting, init will just
set 0 as the mode. According to the "QorIQ Data Path Acceleration
Architecture (DPAA) Reference Manual", this is a reserved value. In
fact, this will prevent the PCS to establish a link to a connected SGMII
PHY. In turn, mac_link_up() is never called. Fix it by setting a
non-reserved mode; mac_link_up() will then set the correct mode later.

Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
FWIW, I've tested this with a Marvell 88E1112 PHY.

 drivers/net/ethernet/freescale/fman/fman_dtsec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index fe35703c509e..566921d3a884 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -402,7 +402,10 @@ static int init(struct dtsec_regs __iomem *regs, struct dtsec_cfg *cfg,
 	tmp |= MACCFG1_TX_FLOW;
 	iowrite32be(tmp, &regs->maccfg1);
 
-	tmp = 0;
+	/* write a non-reserved mode, otherwise the PCS won't establish a link
+	 * and .mac_link_up() is never called.
+	 */
+	tmp = MACCFG2_NIBBLE_MODE;
 
 	tmp |= (cfg->preamble_len << MACCFG2_PREAMBLE_LENGTH_SHIFT) &
 		MACCFG2_PREAMBLE_LENGTH_MASK;
-- 
2.47.3

