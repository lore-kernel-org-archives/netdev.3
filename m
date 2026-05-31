Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77116265620
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 05:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780204752; cv=none; b=GkLS2wZdgWTJxNu99mk0WrjPXrVG492qn26xI9cKQRftos9iEAtu4C9ybyw0HA6ZExJfq5Z1KH2eon1XLRZldGq2xrvb6YA2nyxH606GukE+BUcc/4C/YApsrZThSq8G8Ayv0VY7SiXdlE+ViDNSl1d1mx0gWa3zAb+GAugbASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780204752; c=relaxed/simple;
	bh=5YP5jApvSsQhS1zAl7EYN1vNdsOaW+ijBhhUGqpj3Fg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UMIHD0dUpDfpzz/VX0d164VhkV5RA/Jg28uPwLOI/8c/0uyH7EwOv5XtdaFNn13COn6EzueBkdTz4y4nMqPXPwb3oFnZat0hyhuNGYKHEBMrls7ZaZePMUbaGT8i1OJywzXNsPCNfGQxEtU2O2gjtH0E8Jb+ygA3bip+EgYsbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kZJbJqcl; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kZJbJqcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1780204748; x=1780463948;
	bh=5YP5jApvSsQhS1zAl7EYN1vNdsOaW+ijBhhUGqpj3Fg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kZJbJqclaqPgmL5KkXHHQMNarWibg5woRKJkwJr+1rRWi9m8G4CEY599+2lrn6G7f
	 jlQVCO0wHtLPmEIJ9RAOyUvi99BoGwemmW4bCa5dFJE688nueIObBdhHvjE1pw4XBD
	 4wUVuN45s+4MokFyY2y50cBBjV6G402DlWqSLIhLAl7wjw/E54TU8BgHJq9WsXGhdL
	 x2lMCgkgEsXMoLjoeVPz3xWTRshG9SwNCLUKh1bzfMsJYMsj//EvRy+vIlHNVLneaE
	 61X6rxqxK4rVpHJMuxv9YSMoQskZgLjIYF6XXpXrUtqqYUC02kobvBfuxMc4lFxD29
	 O/jd7gY9fMYqA==
Date: Sun, 31 May 2026 05:18:55 +0000
To: netdev@vger.kernel.org
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH] net: macb: fix ignored return value of clk_prepare_enable() in runtime resume
Message-ID: <20260531051841.55311-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: 4b989aed9c341e1b41f02b9284338125aeed274e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

macb_runtime_resume() calls clk_prepare_enable() five times without
checking the return value. If any clock fails to enable, the driver
silently continues with potentially unclocked hardware, which can
cause undefined behavior or system instability on resume from runtime
suspend.

The existing macb_clks_disable() already uses clk_bulk_disable_unprepare()
for the symmetric disable path. Align the enable path by using
clk_bulk_prepare_enable(), which atomically enables all clocks and
automatically rolls back any successfully enabled clocks on failure.

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
 drivers/net/ethernet/cadence/macb_main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index a12aa21244e8..85bd4ff0e4e6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6185,16 +6185,19 @@ static int __maybe_unused macb_runtime_resume(struc=
t device *dev)
 {
 =09struct net_device *netdev =3D dev_get_drvdata(dev);
 =09struct macb *bp =3D netdev_priv(netdev);
+=09struct clk_bulk_data clks[] =3D {
+=09=09{ .clk =3D bp->pclk },
+=09=09{ .clk =3D bp->hclk },
+=09=09{ .clk =3D bp->tx_clk },
+=09=09{ .clk =3D bp->rx_clk },
+=09=09{ .clk =3D bp->tsu_clk },
+=09};
=20
-=09if (!(device_may_wakeup(dev))) {
-=09=09clk_prepare_enable(bp->pclk);
-=09=09clk_prepare_enable(bp->hclk);
-=09=09clk_prepare_enable(bp->tx_clk);
-=09=09clk_prepare_enable(bp->rx_clk);
-=09=09clk_prepare_enable(bp->tsu_clk);
-=09} else if (!(bp->caps & MACB_CAPS_NEED_TSUCLK)) {
-=09=09clk_prepare_enable(bp->tsu_clk);
-=09}
+=09if (!(device_may_wakeup(dev)))
+=09=09return clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
+
+=09if (!(bp->caps & MACB_CAPS_NEED_TSUCLK))
+=09=09return clk_prepare_enable(bp->tsu_clk);
=20
 =09return 0;
 }
--=20
2.54.0


