Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794556501;
	b=IaKhBZ39C1btBX02OjAp3T3Z4fgGYl9D9DTzSIvlCxAhiOYJXj+xEzT3DeajgGfAb1Ko
	 qw1F4Zk7g/N+yCR8d9rRLqKa17Fc2vu6h6YCTJoN1HlDWq03Dp7qfWqMn9ty6bDLjT9mW
	 30WBxwvkaGzGgFcIk3DkZI+ebJk4CPRiaSdzjYpCrfq0Jl71TpAdophQL5Zas9BSRTjsC
	 3j3aXSPIRTCwNpTmnsBUvaznXSWeKg+tmlqCdaPJOSoc6ofXfyZsISJkBr79Bqy1+SpQm
	 oXJc1Q+8D8SMWX/CY9hFyInXEl/c2pNFSls4IBUC3PbaHKmv3VN577+n5FeEdw+8pkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556501;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HMtANjk4GU012+eLIq+hnR6uBCK3SXj0H4p5cRjiXZI=;
	b=H48bpN2/cgDpyCsDtHotfKL4vR3+r9FN0B5/I9epxOKj8EcnEseQE4jfLBE0/oVASq2f
	 vg3m9J4C1mVaZFcpMq52mrv6K9mLMu1cojNFQy2weyyFrBlDLnKiTM6TUf8j2m5xh4/3Q
	 vC5JJzd2tigGThUGnSS1i3h/+S0DApdPqFESH4O4kc54M54xxPmqEarGux6z/pwWGlVyv
	 rc0zAExNHSo3RhdYA1GTHJ53gNKlq5oG0O7xYJJg5ODJogR1GZbMGzXt58pT60haW2GWj
	 HB71XFnXEvrKI1Z+RfqkkusWOmCOj7ovQAgMpyRMMzXXFPyWFuZKtfUCkgJTGTn97GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnYhmhZI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D6606A31C;
	Fri, 13 Nov 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnYhmhZI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794556501;
	b=wu1EBmDfNJntdmbaAhlRidR0Rubp4j2G2dfQmebacOgIikOpjg9pPM5prGmpv/hxdRpY
	 yX1f9ciylo5GH5j4bH8IhPPyMNa9ywKD1aaXU43+2H+UFYUqgGJt5HBaOt4wOij1eMh7F
	 v/BFRjELgKXsbzlzwGm4My4U8Lyw61YiJM20qjryCDBkMOjaVa3sY9kK5739CrTNKqkqO
	 WN4VMB7wqnEZP/OAQWLQgX/7QkwEQq4657Jk5qeVhIdaGN/7YIG73G2bhizk6fL1BQev1
	 BbD1Dl/wCRD4xfhhkpAjqxWobOK1FwpOwiwtQPpMBSga5fEfxL38F/uB+gdiffWBgZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794556501;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HMtANjk4GU012+eLIq+hnR6uBCK3SXj0H4p5cRjiXZI=;
	b=sah2kNwA/vVr2GDEyS9ZP/xkaL1H2nKrbTCC7GkHmaRBeXVjmgf3VPAHliTY1tlPgdRc
	 uEpnyxoXsb8/6iqKw0gZnF52Q6yMCqPv8wsR+4UkjSl7K2j0KTut8urXX4kdy5fFjXCEl
	 2C5lH9Dx68yOk//wvGzIf2utdi5PSfUnSI/IUsxTHKayMQb+7cF3cS2PpyntEpj1NsbZZ
	 svus0hjvKrJiVGjf9DUFIlnwODe74QhIH2VUJhSZnz0IA3sgppEFCX3DXBZvyYfkae2gK
	 ZbEESrB4MdHmq7RZoUbWqa/+bSwPTFVM98htGZVPQiKAbU5XlTISfpXrBQCpkQl003A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CCD681F000C4;
	Fri, 13 Nov 2026 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794556501;
	bh=HMtANjk4GU012+eLIq+hnR6uBCK3SXj0H4p5cRjiXZI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FnYhmhZIWrZPDd1UGKM/uG4l+uXZeRENKiRvEfbpqkU/o3wOegHcJmPvm5OIG8tdR
	 b/rQy8sMnc14akWUVQeR7MnC3wtxlWJwu5Bgleq9Ty7FbXfWEdrdTFruCeQdEqI/P3
	 MsrBzLC8m1DL3hT3iwDNmKJ3FvOsSB8lE5dkDd69lAnD8sTqUXFMZ2bShmELXqpzQ4
	 Ju3e8uMsWWNSpJ+ASB94u6UA6r/5n3x3N4J39HzMcM6wy7MYxjJpamdLlz4OmuQJk0
	 u8DjTnLLPj+ECTNuIeAERu/XjQyv5O8xtAeMC+xH0lbn+AFHKNEV4rH0yD/M2c5ti4
	 vZsLmkVqSHpPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2BF804764E;
	Fri, 13 Nov 2026 07:55:00 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 07:55:00 +0000
Subject: [PATCH net-next v2] net: stmmac: dwmac-sun8i: Fix use-after-free
 in the MDIO mux error path
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-sun8i-emac-mux-uaf-v2-1-6203666b2687@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX8Xs2TVsjVg9+R6GQ6lbWCPF9IdgC
 O8u4N3jl5n5ZoLIQTjCdTdB4EGi9H4Btd+BbY1vGOWxMKhClUSkMGavBbkzFrs8YjYOqTZanxR
 dHDMsw3dgJ+MmvYPnhJ7HBNUvibl+sk2rc+22ElMfPtv/QNvi39VASHgstOEzl846dWs6I6+D7
 Tuo5nn+AhTscW/QAAAA
X-Change-ID: 20261112-sun8i-emac-mux-uaf-1ba885219fee
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794556499; l=1964;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NA8bN4vdYnbD8Ubperq81cDG9VH7nmrLZlmkjA0DuNI=;
 b=cDtf6HyIYs9kKxz/DU3DMnuaFJxtsme6r42uIwnosHwItkgWxmYMNmK9McP7j2AbGcDRnYa0A
 4s93602poFgAD/01apDkyX9WWqsTaJZysHRMbkXRbXj9Qq7pdJwWsoE
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

If mdio_mux_init() fails after the scan of the internal bus has powered
the internal PHY (the external bus returns -EPROBE_DEFER, or an
allocation fails), the dwmac_mux error path puts rst_ephy and ephy_clk
and then calls stmmac_pltfr_remove(). sun8i_dwmac_exit() then unpowers
the PHY through the clock and reset control that were just released.

Unpower the internal PHY before releasing them, as sun8i_dwmac_remove()
does.

Fixes: 529254216773 ("net: stmmac: dwmac-sun8i: Balance internal PHY resource references")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Sashiko's review of another dwmac-sun8i series of mine pointed this
out. Build-tested only (arm64 and arm, W=1): I have no board with the
internal PHY (H3, H5 or V3s), so the error path was not exercised.

This patch was developed with Claude (Anthropic), which checked the
report against the code and wrote the fix and the commit message. I
reviewed it.
---
Changes in v2:
- Target net-next instead of net, drop Cc: stable (Andrew Lunn)
- Shorter commit message
- Rebased onto net-next
- Link to v1: https://patch.msgid.link/20261112-sun8i-emac-mux-uaf-v1-1-308ae7e6fcf2@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 2ece7ba9dd73..898560e8e95c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1245,6 +1245,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	return 0;
 
 dwmac_mux:
+	sun8i_dwmac_unpower_internal_phy(gmac);
 	reset_control_put(gmac->rst_ephy);
 	clk_put(gmac->ephy_clk);
 dwmac_remove:

---
base-commit: 573af801552999954caa8347e4490b04cf4763f0
change-id: 20261112-sun8i-emac-mux-uaf-1ba885219fee

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


