Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793322745;
	b=Z0Gw6lmg0OJskHFnlvFDFhkUqWBlydzRLvkXE0nGIyi4R6csNgzR5OyARqKcpM2xWamG
	 WmrmHm/Dx4xyRyalTV51X8EiXYv2QtRHpkkHCLYRE3d0XnWEmlnRnbZK9/SzVZcgZJ6dX
	 xpOrvL8K/WqpIYwoCvTm7cCnw5Dcnut0zD92MWz+LcKwyyX9IsuKhGajYIlicYiBCzyYj
	 vy6TomP5tC9wesIBrhhmRb6hJjWLgxqCjY+UvKygQuhumRIPj884CdjlNRNyGKjcXu6Y0
	 kb13Y0iplvcmG/YWE7KMsj9YZyV4GwtY5+Y2onVMYT83PdPBj7uxA00AQAgsiFXshuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322745;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
	b=Kfyon2mxlQMA9xL6DUNX1vDUeMzzrmIENDpKzl86v7F48Hg8XFoq3A/+HbcczJnRtpg7
	 2eUWqAy54VkQrMyNOzKZ+A71nryw9TkF7fkmQQmx6Rwf0TIugrFfqX3OWfyOfnQw2GNvF
	 DdT0JPsn7K54CtKWDz6mX4xPGueBkEKAerZ6cxO1uVAKL4FzGbP858+VGOXi8BOQzSNjT
	 ACEnnlis+Oas8la8unKQZrKlrec9b2B0f+hVBN7pHoGjfIMkKNPfbA8sZztB8a3LooO9o
	 +QaHVopO5/zHhoyZ7uXufvESErKC5z4vHWrtjsOPLLyrN6UmVUIQrntpZxxCW1NK0Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjFLX0fP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17536606A31F;
	Fri, 30 Oct 2026 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KjFLX0fP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793322744;
	b=fDVsTumCS5jpT9cl3X98D+mKCUdyyeE9+/IEI7P+DkOBwtlKGWyR1ZP+Hy2ZvbfyxMGD
	 ygNB5SBYuGYG6q91OkQMNhe5toquIGyflV2xtabShFnt+lEm9sOHbVXfPQu22QCkFBIMy
	 rwbRksisFvtNltlrnhN7b5nP0aSBaXnefwUS1vlgtLvT7img2jxkPfovY4fHbr+YW5pi/
	 xGqXK5wpeFV4QymiWMbwPsX34QTgxRPVuxWZpmEDgKzPbWZ6ROtjnsAsH1IbtanvaJjoU
	 dteBPdaJBYXcrdWrQuIIYLbKNkNB2tBhpx5Z3/9d+xZyR/wimlzROQd4JoSHhVvNPAw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793322744;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
	b=f/9HjkbTGkfu0ex/ai+GMzXhwhx84fX3tf3fLfzMEG6vZgyE3QMA7ZVuOYAHtvZRMwXB
	 i2kB8rW7fCNiXbelG1FUpGBRrUYrcMLsJsgBvAC4RQphaHWte2gHdildzCFbVaPWloQsj
	 4s9ol2M8KF4DUC4BhNk+FfEZABNJLhF9OaxLFcNbaEuBdlAF2fi0TWz2qFqw3fBmNjYiz
	 jX2dFN0RTXcysLpxp1/Woz2wyngbAlMlv48ZyYyHYoxbLaigxy48JBg+JIKLmP9nKkc/P
	 EsXy1FRXSdC8SFU9yKxvZ5Zp0GdrTbk708CfPiMp4AcpF+TsSXFOGgX0TA3HPDSolTQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 650771F00919;
	Fri, 30 Oct 2026 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793322744;
	bh=MYsYTLL+AWZzeX3KKoIyGEzcXBXZoB0zYc1WsDnRnnA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KjFLX0fPhTG2U1AMiTs1d6cFFCLur3mS92YzWZ61oWZf/x2Xab/2xWcN2DH/sWnDM
	 GUhieDBAGqia8ArEhmkPkN81V6aiDf+XErlkxTmSo7cPw7OlFMQTiWc4GKC27sxJK+
	 quYWO2OtKP76DhduguNimu77DjWJMqHL1DwYnElB7T+lXtSClmceqJ9HOPDxwPQbfb
	 iFqz32ckBgtUxPhDyOlMTSqw1d1H6MeoYNJCm6T/VIVZMUDEI4L1OdFb30LjA+eFGd
	 AXlOkmGYKIQIbreLF7xq2uCF+IiDtvi93IWG5CZnHBXphxjNL5sFWCipZdki2OGAXM
	 d2hgwZ2WVvv3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EA3144306D;
	Fri, 30 Oct 2026 01:12:23 +0000 (UTC)
From: Zac Parker via B4 Relay <devnull+zac.parker.parcosta.com@kernel.org>
Date: Thu, 29 Oct 2026 20:12:21 -0500
Subject: [PATCH iwl-net] ixgbe: fix swapped addr and devad in
 ixgbe_mii_bus_read_c45()
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
Message-Id: <20261029-ixgbe-c45-fix-v1-1-7eb38075a3d1@parcosta.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBREr1Jm7QfTpkW9inTRxLF+kShJ1ULp3
 f3qYhZvhnkLCrOy4FAtyHxp0XsycJsK8TKkkaInY9TbunMW0XkMlOhbOess3d4xcOdD23jY55F
 p9c93hL5vkjih/w/lGa6M09eGdf0A90QNOnoAAAA=
X-Change-ID: 20261026-ixgbe-c45-fix-691ebe84b534
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zac Parker <zac.parker@parcosta.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793322743; l=3232;
 i=zac.parker@parcosta.com; s=20261027; h=from:subject:message-id;
 bh=z0czBdN6SjMUZi5kUnXLmCozGwOhDcYhnx5BsNw9Jn4=;
 b=EkO7qzS2S3n8cCJx6iYzkYCq/lJ5zCgns+YJ+8yxWt/0k1fSpUkEXkCP0PAOFiDuQ5jI/GzA7
 Ku2KhlLJzKVANx1qOaM/6wXMF6PWzT/SwssYmpJwxi4TU54rwuumeeJ
X-Developer-Key: i=zac.parker@parcosta.com; a=ed25519;
 pk=G+DgShRR2xDJFWGYQ0W+5eRamZbUryODJ6T6/eQZeEc=
X-Endpoint-Received: by B4 Relay for zac.parker@parcosta.com/20261027 with
 auth_id=1361
X-Original-From: Zac Parker <zac.parker@parcosta.com>
Reply-To: zac.parker@parcosta.com
Content-Transfer-Encoding: 7bit

From: Zac Parker <zac.parker@parcosta.com>

The MDIO core calls the read_c45 op of a struct mii_bus as
(bus, addr, devnum, regnum), but ixgbe_mii_bus_read_c45() declares its
parameters as (bus, devad, addr, regnum). The PHY address and the MMD
are therefore swapped on every clause 45 read through the ixgbe MDIO
bus. For example, a clause 45 SIOCGMIIREG read of register 1E.C820 on
PHY 0 (Global Thermal Status 1, the X550 junction temperature) is
issued to PHY 30, MMD 0 and returns 0. ixgbe_mii_bus_write_c45() and
the X550EM_a variants already use the order the core expects.

The generic ops are registered for every ixgbe device except X550EM_a,
so clause 45 SIOCGMIIREG requests on 82599, X540 and X550 devices are
affected. The driver's own PHY accesses go through hw->phy.ops.read_reg
rather than the MDIO bus, which is likely why this went unnoticed.

Fix the parameter order to match the mii_bus read_c45 prototype.

The bug was found by an AI coding assistant (Claude Opus 5.5) while
reading the junction temperature of an Intel X550-T2 (8086:1563, NVM
19.5.12) from user space on a Proxmox 7.0.14-based kernel. A clause 45
SIOCGMIIREG read of register 1.2 on PHY 0 returns 0, while the same
request with the PHY address and the MMD deliberately exchanged returns
the expected PHY identifier 0x0154, and register 1E.C820 then returns a
plausible temperature (about 45 C). Reproducing it needs no kernel
changes, only that user-space read.

The fix was build-tested on top of net-queue with allmodconfig and
allyesconfig at W=1, with no new warnings. It was also run-time tested
on the X550-T2 above, applied to the ixgbe driver of the Proxmox 7.0.14
kernel. With the fix, a clause 45 read of 1.2 on PHY 0 returns 0x0154
and 1E.C820 returns the temperature on both ports, while the exchanged
request now returns 0. The host then carried its normal traffic on the
patched driver for two hours at 2.5 Gbps, with no link drops, no driver
messages and no change in the receive drop rate.

Fixes: 308c8ffd5a7d ("ixgbe: Separate C22 and C45 transactions")
Signed-off-by: Zac Parker <zac.parker@parcosta.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index 1e52f6221..516856b3a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -832,11 +832,11 @@ static int ixgbe_mii_bus_read_c22(struct mii_bus *bus, int addr, int regnum)
 /**
  *  ixgbe_mii_bus_read_c45 - Read a clause 45 register
  *  @bus: pointer to mii_bus structure which points to our driver private
- *  @devad: device address to read
  *  @addr: address
+ *  @devad: device address to read
  *  @regnum: register number
  **/
-static int ixgbe_mii_bus_read_c45(struct mii_bus *bus, int devad, int addr,
+static int ixgbe_mii_bus_read_c45(struct mii_bus *bus, int addr, int devad,
 				  int regnum)
 {
 	struct ixgbe_adapter *adapter = bus->priv;

---
base-commit: b7e46a73815485bc5deb94945e50594a8bf6b499
change-id: 20261026-ixgbe-c45-fix-691ebe84b534

Best regards,
--  
Zac Parker <zac.parker@parcosta.com>


