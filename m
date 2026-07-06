Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EBF3812D0;
	Mon,  6 Jul 2026 05:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316324; cv=none; b=DbdJ9GKVI1tBiy6TNscYFxcyz+lwAKRcPsS9SCgSL9h+MwyP56VxiOMLr2W5XOtq1HmLDIu2MCEL9W+wmD60uZmxqv3PNyB80BpY30ntouhvsqKX8fK96R5JEyXLyYkIKczoaZJZy4cuFXgKGBHntq1fHe/KJS/AvseCiU3125s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316324; c=relaxed/simple;
	bh=IFp8KIfJQFaD5SxJ03pX/G7sKzcitokGMS85gqHLheo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Elh5mLFZJxVRlmJyTGvxP3Z71F5nFlKdOlpg52neywIeBJZiLvJXmg4Ep7weEiclJeOs7Hsr5JDCOMnO2oUwv50YLdMvp4+KOUmBpEv1p8vjIqWdTtJ2AxXvZbf/PLUxxmTTPE/ttro8iU1XV661dP9Q2zXWpOP1hyPr50EF+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=k2dVqGub; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="k2dVqGub"
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gttSc5tqrz8sWR;
	Mon, 06 Jul 2026 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783316322;
	bh=YIeQik7zWpB4jmw4IE+FSK27BQvQ/I/lwKnJtdpPOVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k2dVqGubQeJZ/e19iWyC9GpO7M42DTeclfVQsXzV8z6tiazu50dAOpDe66lAlfIRY
	 j3/psXNvzyrq8HacTvSx2dHO6aI3hcM9vkNdI4CPocTmYhVRJbzJOhVj9tCyOBwCm9
	 VQXTsZsLCsWDuZugDRPBiGyzlwC6BxV+mC4r34bl+18cZ5Yt9MQ4GjZfLNBemXeBG/
	 t1oe0/ZAlXfxV+eaAvyhi0aLYhB6+7JNLtQRySqHZ3xBq9d2hveuL2Sz5jD76bgIDa
	 RE/xP9gr49zu001yR006hkfp9JDTF0D95vsogGjz8WIUTBDQVRzWG4y8dhdSoAQe/k
	 VdIPCLdmHo10Q==
From: Guru Das Srinagesh <linux@gurudas.dev>
Date: Sun, 05 Jul 2026 22:38:40 -0700
Subject: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import style
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev>
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
 drivers/net/phy/ax88796b_rust.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index 2d24628a4e58..5a21fe09bd62 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -5,7 +5,12 @@
 //!
 //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796b.c)
 use kernel::{
-    net::phy::{self, reg::C22, DeviceId, Driver},
+    net::phy::{
+        self,
+        reg::C22,
+        DeviceId,
+        Driver, //
+    },
     prelude::*,
     uapi,
 };

-- 
2.54.0

