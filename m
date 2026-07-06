Received: from out-21.smtp.spacemail.com (out-21.smtp.spacemail.com [66.29.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7123BE627;
	Mon,  6 Jul 2026 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.159.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316338; cv=none; b=Bzqr1/XwJDdHxsAoKQyXJL1N19DzMcb0nXui2TpPnyXiGa+hOUDABqbPVqrLbzOZljnxDbjR0/mvzPQGup0t20JNQXifckjpHSbWyNb70iFcNoQ0UFxdpbIfINoV3/cMplqf3KNeWNPpu2wrfRLfIjHedqrccM7kT6U/8ptzzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316338; c=relaxed/simple;
	bh=thiPY5S+QBxellP5Uj9DdCyEm46ESuaHvrW+lWMbg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7vqWY/glJIEzJtwfAYcuyJq3fh9HYLDFTH0LPrvVGUtwmmGOuvjABOXQVsHhgdhGHeEF7/L5mDHs41hXeDH376eql2tI0GLPcHm+svLZVIre8hnzPMw6YdJbKTQ0yK2xbbWO4cOPwCwONxNwWnE3zNZID/5Kdh0pBruxhz93To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=Vjh0PgLV; arc=none smtp.client-ip=66.29.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="Vjh0PgLV"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gttSf2yDkz8sWP;
	Mon, 06 Jul 2026 05:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783316323;
	bh=YS27Kixvby6KSWXTt2w35oH9jMdFGUOYAotvdtSmrSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vjh0PgLVGALvf1sy50QH5PEHukog4ONFmMb71bzp/e/F2Omd2bzxozwZaIBPMbOGK
	 Hhs6wr8BbxV9X1EMf6CO5Ymb3Z15cF0ZCQMyMIXyBLSXEMDEAFzf7kRHSW6U/QvIwM
	 LqC4JsaES9+F0Xp7d5nWYjZ26mRPky0qbMiOyPELwrx21cyY1e11nz+3CID4xxCriS
	 XVjJiPjsdPDNdE/6e5TjLFxbtYIucbhlJA2ZhBzicow0I0b267BQEN8E9g9YGWPI8b
	 i05No/XwNgmjtqLf0xAD6IBxUehfygN0zKf67MPqhcH+dhvPPWJzDV3YohkUhMXixI
	 r9ufNJQavScOQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 05 Jul 2026 22:38:41 -0700
Subject: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import style
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
In-Reply-To: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Convert `use` imports to vertical layout for better readability and
maintainability.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
 drivers/net/phy/qt2025.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 470d89a0ac00..efde3f909367 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -14,11 +14,17 @@
 use kernel::io::poll::read_poll_timeout;
 use kernel::net::phy::{
     self,
-    reg::{Mmd, C45},
+    reg::{
+        Mmd,
+        C45, //
+    },
     Driver,
 };
 use kernel::prelude::*;
-use kernel::sizes::{SZ_16K, SZ_8K};
+use kernel::sizes::{
+    SZ_16K,
+    SZ_8K, //
+};
 use kernel::time::Delta;
 
 kernel::module_phy_driver! {

-- 
2.54.0

