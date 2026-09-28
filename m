Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E14915B2
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585466; cv=none; b=uudeJhM8rQKi7438jrxZF27laUOMAdFD92u/5/KfasyKI6+11YSlR0FsMJdmI35DgrIYqPK34wVViksfZPbeuM8KpXckEo4FsoLKTauivKSccIrl6k9nD/d5pp12bscIoR47lpJwP4fqLXIJuBk9UwttW3UvgrzkcarSypw3i20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585466; c=relaxed/simple;
	bh=sNIlgSlifep9ROXS/554Qy69xsjcueSdy0o5mKNGVPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYrKp51Nn+/vxMAtxV2ZxtgncmWScThrP0R3AUiuMrCUpUAUQTtfIaLfuubrPsbdwsE35/qcQPC0/FqjiTu2qOk5Ax1CDnwHb2e2hgk9Hg3WkNkO0DU8EvZVKvuVH3WDC3EXy9fIRCrSjJTLpWVEHrnz83EKShhyiA6r/dfgkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkhp2vM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkhp2vM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55CE1F00898;
	Mon, 28 Sep 2026 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585465;
	bh=lRBqxHVfhe0eB2/rZl01xFaVlnTJLbF1KdkeOyjxlCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gkhp2vM8YCarqZhhw5QfuaWOXgRFuEEumSulXJYRIsmudQtxLn4XXGAsnFwU9kiDf
	 1UwRwfNfaji7vKOauu0+4RmAgKm799AHf7upHn5JAJLbIyMnF0UjHSAPV1FNulYjJ+
	 69rsp75ctniNAuIVdHSxtBGw+ktVMvGXddM+Iv70KmAaSOSJPsM1sh2Z5cuUW7EM3Z
	 B3+ekPLK65HLR3dT8kx9YzyvSL8FKPzA5/67v4R1+3Aq9Y/c20DKzd3+4NgNlK7gpA
	 1QeP/tVh3QvsTid9rDzl4LaftzBTxLdhnJWoQHf2uLIivMQpcNRLhhhaCgxLOAjXXv
	 SyY4hZgzR0ZsA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:35 +0200
Subject: [PATCH net-next v2 09/11] net: ethernet: cortina: Release partial
 RX frames on stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-9-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

A NAPI poll can retain a partially assembled frame across invocations. The
stop path clears that pointer without releasing its fragment references,
leaking every page already attached to the frame.

Free a pending fragment skb after disabling NAPI and before clearing the
saved RX state.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 258bb44d5570..a7096690e4be 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2077,6 +2077,8 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_disable_tx_rx(netdev);
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
+	if (port->rx_skb)
+		napi_free_frags(&port->napi);
 	port->rx_skb = NULL;
 	port->rx_frag_nr = 0;
 	port->rx_dropping = false;

-- 
2.55.0

