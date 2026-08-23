Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2E350298;
	Sun, 23 Aug 2026 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481421; cv=none; b=IcMzN0k5C6Tcxn09xNzLTfcVa9dQ3q3Sip6wdFosyi6lk8yEl+3zKAlOJTMF2c1CxekKN2AxX1TwhfAGels7DUUiytIyte6NEVaL4Dl7Ck6/7LmvUTT+ruTVIspnfZWTqOvmD2KKrvTdsEWYk3neHFr1+ef7xQ7C4HWmHjValVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481421; c=relaxed/simple;
	bh=Bt35YDTNe1J3R3aTFw0oILPtPRPMYgT3/37Onb5nM1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gc1VXwkEVpBjaVEZnEYSA8Tks0P3nXB6jfvLw4VobEb5MwgSpdkjYXXD6D1cNEvs35VOD35HJRl7tj1g4ITEPiVmdKryusBHoqrZGbnsPVTq4ZpsRInvwK0ZntxLxWDyFl3trKS8N8xESDX6LlX6cp/nGmI7QGK1DUxvEZfBchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=UsJ4c7OR; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="UsJ4c7OR"
Received: from localhost.localdomain (unknown [106.120.124.5])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4afa29b3a;
	Sun, 23 Aug 2026 18:36:45 +0800 (GMT+08:00)
From: Chunfeng Song <springbreeze@stu.pku.edu.cn>
To: rust-for-linux@vger.kernel.org
Cc: netdev@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>
Subject: [PATCH] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Sun, 23 Aug 2026 10:36:44 +0000
Message-ID: <20260823103644.342849-1-springbreeze@stu.pku.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa02e31b57e03a1kunm6e454d191f3261
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTk1CVhlMQkJLS04ZSxlIS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS01VSklLVUpJT1VOWVdZFhoPEhUdFFlBWU9LSFVKS0lITk
	NDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=UsJ4c7ORp6DvJUGfFhvBeMx5UaTTuUCzFy9YZrAKrt3Df2ITn7NeCVX30sFL3k4fALaOHtd/dBD073YXSmp6ebOCFPRnrA4ts4E1W/nANIipc4INdYU35yvw5L5FriBfBQhsVQ4Jq1k96CwJ7dxN53CRRgx+O/LlPOJ0OKvzu10=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=m0t7uFzbYqioApTUqkP+aY2qbFm2iSARbuBYE7Uv/T8=;
	h=date:mime-version:subject:message-id:from;

The hand-written bitfield offsets in is_link_up(), is_autoneg_enabled()
and is_autoneg_completed() are all one bit short of the actual layout of
struct phy_device. Counting from the first bitfield in the unit
(is_c45 at bit 0), the C definition places autoneg at bit 14,
link at bit 15, and autoneg_complete at bit 16. The accessors instead
read bits 13, 14, and 15, i.e.:

  is_link_up()           reads bit 14 = autoneg
  is_autoneg_enabled()   reads bit 13 = is_genphy_driven
  is_autoneg_completed() reads bit 15 = link

The official ax88796b Rust driver uses all three accessors in its
link-change handling, so it inherits the bug. On genphy-driven devices
is_genphy_driven is always 1, which partially masks the broken
is_autoneg_enabled() check and likely explains why this survived the
original netdev review rounds of the PHY abstractions, which fixed
reference/aliasing issues but never verified the bit numbers against
the C layout.

Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
Link: https://www.spinics.net/lists/netdev/msg951815.html (v8 cover letter, where the bitfield access was flagged as needing a fix)
Signed-off-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>
---
 rust/kernel/net/phy.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 956cda573ddb..99ed3dd168df 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -130,7 +130,7 @@ pub fn is_link_up(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(14, 1) == LINK_IS_UP
+        bit_field.get(15, 1) == LINK_IS_UP
     }
 
     /// Gets the current auto-negotiation configuration.
@@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
+        bit_field.get(14, 1) == u64::from(bindings::AUTONEG_ENABLE)
     }
 
     /// Gets the current auto-negotiation state.
@@ -155,7 +155,7 @@ pub fn is_autoneg_completed(&self) -> bool {
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
-        bit_field.get(15, 1) == AUTONEG_COMPLETED
+        bit_field.get(16, 1) == AUTONEG_COMPLETED
     }
 
     /// Sets the speed of the PHY.
-- 
2.43.0

