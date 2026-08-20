Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4A377A89;
	Thu, 20 Aug 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245718; cv=none; b=FYk0rnQDi3BbheSAmgmFKbo3sQ8qzydcCQ/y/Io02e5gwIT0MiT3DJ36JY/in2hToy6ztw4j8RasDZ3kltJFXCni3g0VbM/HKKgKry2ZcWNO7BkOVP9NzZiN0lwDS6wTi+dLWx+bl9Inzq0m4jeQRNaqc3+6Sdvsc9aXs1PTldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245718; c=relaxed/simple;
	bh=/6XecN2DmS4xKr1UJZlfI9jzGJkLFaSUG3AtT8HN3Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qUDdU/4l4ogZV7tcc++W5BRppt46gdynkV6SiKslkOmCfrq/IF92SmvF2W/WPxajAm2ozGlOYxKhRNHyQ7t7GHomg68BA4GeVsSARegU/CtZDaIs8uVz2e3GwqwKJHNMYU0ujdXc3elzhknrKULLRhxKQzcotJIAAHz85gwbIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ifGDEo59; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ifGDEo59"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C4A04E41303;
	Thu, 20 Aug 2026 17:08:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47DEB5FF59;
	Thu, 20 Aug 2026 17:08:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5C8511C7657E;
	Thu, 20 Aug 2026 19:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787245711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Zl7XpgL7IsU1rsJqdSdz+OpQ++RgZb3yWrsLPojaMt8=;
	b=ifGDEo59aYXoUSy8/fQH2++dQ4p2eaQprcDVKAGn7XPBEzmgtsZt+Nav7IMPxoA0mHgXpw
	VeD5PX+V+QH0XD6e1ZxqX3MwAG56gdTQmSyT+Iw95bdL6pDQIqbec3RzKOqokbcphDmlgS
	EdX4nOTVVzCL1o3ho33+enItIyXic9OrICLpLYmdDoUy9cVtBC8q56TBjCYHoL020GuzVp
	NutfTDSSCJrsPMl5UOvp0kRTjUeA9e8dZF74gxHvLNuTzsXlRxwCs31k3bGLN11DmtrdWf
	qja8N59OeUFcrnZ3IohaKhD+giIxqc2zcCroxZCK3igqTptC+myM2KA21hcO9A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 20 Aug 2026 19:08:20 +0200
Subject: [PATCH net] net: macb: drop CONFIG_OF #if block
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260820-macb-fix-x86-v1-1-b2e7c902104e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqDMBAEf0X22YOYQhr8leJDcj3bK5iWRIsg/
 ntjfZxdZjYUySoFfbMhy1eLvlOFrm3Az5AeQnqvDGusM94amgJHGnWl1TuSePWhG5ndRVCVT5Z
 6/XM3JJkxnGNZ4kt4PkLY9x8CwmP8dQAAAA==
X-Change-ID: 20260820-macb-fix-x86-eb78a1fcc63e
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Fix -Wimplicit-function-declaration error on CONFIG_OF=n builds:

   drivers/net/ethernet/cadence/macb_main.c: In function ‘macb_probe’:
   drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit
   declaration of function ‘macb_alloc_tieoff’ [...]
    5951 |         err = macb_alloc_tieoff(bp);
         |               ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit
   declaration of function ‘macb_free_tieoff’ [...]
    5973 |         macb_free_tieoff(bp);
         |         ^~~~~~~~~~~~~~~~

Error got introduced because functions are mistakenly declared in a
`#if defined(CONFIG_OF)` block. Instead of moving functions around,
avoid any future mistake and drop the block entirely.

Change the module content slightly on CONFIG_OF=n. Previously match
tables were ignored. Now they appear in the resulting build. This is
considered trivial in size by most and is the common case:

   ⟩ 18 out of 254 OF net drivers reference CONFIG_OF
   ⟩ rg -lF 'MODULE_DEVICE_TABLE(of,' drivers/net/ | tee /tmp/a | wc -l
   254
   ⟩ xargs -a /tmp/a rg -l CONFIG_OF | wc -l
   18

Tangent: no, of_match_ptr() does not imply that the compiler can
optimize out match tables, because MODULE_DEVICE_TABLE(of, ...)
unconditionally puts the match tables in the binary. It is only meant
to avoid undefined declaration issues when match tables are hidden
behind a #ifdef, as was done before. We therefore drop the macro call.

Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across device lifetime")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
This is a fix to a build issue present on net/main (91ec20351349) and
linux-next/master(7079a12d7506). The problematic just landed in
net/main.

Two fixes [0][1] were sent previously (both the same solution):
[PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of CONFIG_OF block
[PATCH net-next] net: macb: fix CONFIG_OF=n build

Instead I'm suggesting [2] we drop the error-prone preprocessor blocks
and do as everyone else.

[0]: https://lore.kernel.org/netdev/20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org/
[1]: https://lore.kernel.org/netdev/20260819040913.109367-1-running910@gmail.com/
[2]: https://lore.kernel.org/netdev/DKT4CBU8YB5G.2W0766H2NU6Y8@bootlin.com/
---
 drivers/net/ethernet/cadence/macb_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1476bce77f34..76ee4f506033 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4926,7 +4926,6 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.clken = MACB_BIT(CLKEN),
 };
 
-#if defined(CONFIG_OF)
 /* 1518 rounded up */
 #define AT91ETHER_MAX_RBUFF_SZ	0x600
 /* max number of receive buffers */
@@ -5754,7 +5753,6 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
-#endif /* CONFIG_OF */
 
 static const struct macb_config default_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
@@ -6267,7 +6265,7 @@ static struct platform_driver macb_driver = {
 	.remove		= macb_remove,
 	.driver		= {
 		.name		= "macb",
-		.of_match_table	= of_match_ptr(macb_dt_ids),
+		.of_match_table	= macb_dt_ids,
 		.pm	= &macb_pm_ops,
 	},
 	.shutdown	= macb_shutdown,

---
base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
change-id: 20260820-macb-fix-x86-eb78a1fcc63e

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

