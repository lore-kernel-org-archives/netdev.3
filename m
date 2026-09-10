Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C458FD39;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070886; cv=none; b=BAAPyIp72UW2dIH+QXNVLsemPg5IQN0zf9/ADJJfVUtcxw/jIXuKv5qQ/sNFFo1Ar7gSZwdxLYdtjHYi6iHjHBXmKiD/KWsZh4A+D32KoE7wn+4lL+zUALi+cTSm9SLpfWr4NtFp3/yw1rUUU+c6pVvTQvx1Z/SdCxKmkGFJ7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070886; c=relaxed/simple;
	bh=1S166W08hav/cf72m6GiZgUIfPTgGC3XjugLkwkf5xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWfEmJTvBAwYOpzu+OPAhkuZQ7aersNyBTIAqSydBT9Vm17O34Cxv9zttz1RTmfR5fSCASJSSP5Q5T9LpyqoQxuATEYL6Axsp2uHYNEzD7v5+hw+OkyPDtnX9xOzGi6GpPk/K1uhNJQkhRVYMguWPvtc7y3srhrnd3HKZcLe+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naXGoxiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naXGoxiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57DE8C2BCFB;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789070886;
	bh=1S166W08hav/cf72m6GiZgUIfPTgGC3XjugLkwkf5xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=naXGoxiQpDICIGwkKe1oWiLFaXcnJz7Jv06gKy3gWuhdTxkAFEANpQe6rt7gZ607y
	 q70W2QvYIZ6kv6FZcRAe+c6SiEqUYxRIaC5yTytAPYI5EMwVK++kt49bk8QUyOCkyV
	 /7yCg+DelPPuv4MuH2swkG3egG6sqbeiIEbGSDi48BX24h2k0J64TVR+BRlROOQJR7
	 Ezf9zmm5Sfbpo8sRhSpPnFhtggVdI37VWwHdak7CP3EeSazf8vWwrI/7UiXnqtDoqK
	 +hs1GFrYmqmhJ+8QkZcwkRK7A9ji1lX4KACQXg1n9fNAjmJt4bGJz6Mhn73I0fnjs/
	 LpMm62NI7BncQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380FFC79FBB;
	Thu, 10 Sep 2026 20:08:06 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Thu, 10 Sep 2026 22:07:52 +0200
Subject: [PATCH v5 2/7] arm64: dts: rockchip: describe PCIe RTL8125
 Ethernet on NanoPC-T6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-2-c1b9e5f10cd6@pardini.net>
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=i4GeIrJloVMIhPqbv8MMmvK6rUkQxMcuRPKHm4uxbIo=;
 b=owGbwMvMwMFoHWf/eN7xty8ZT6slMWQt5lO5ZsyY6XfpwNOtGY8b3r97ESAekVrkf1n+oa+df
 nfqdM/znYz+LAyMHAyWYoosaySUeb6tf3XqjkfHZJhBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx0DHmIGLUwCm2iuB/X9Gv4pQKa9F9ddaK/7/iqrdta7LQhiP/p+/qtJ8+e5Jx3TqHGK3Rl3
 d79c99TlbyU3eWFOGB3u/Ji/PN3q6bHn26nLpdTPuKTDUWYX5TQlkjnmzNrO7Rnjjkz/pRu1dGp
 rfw6Luv3/DXm4j/qfhevGWA1tSmb+wNkbdyhWfJTZZoM5YvMko0ebcpmxl07NufQKs3w++fPBmw
 eJDe+vlGtk4VoUqrF8tuWJFusGixAc8Ncb5kXM+XX1wyMfc490qvulWj/zv24WzX482/3yydplk
 0uJHwnrNqe+SNp1avG1dgG7jwvyrR89wRxc2P9Zkd174OyysSCxAOSopM6YpIdh15SZ/DvVjyf3
 XrOqqAQ==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net

From: Ricardo Pardini <ricardo@pardini.net>

The FriendlyElec NanoPC-T6 carries two on-board Realtek RTL8125 NICs
behind pcie2x1l0 and pcie2x1l2.

Describe the fixed function nodes and attach ethernet0/ethernet1
aliases, so that U-Boot's fdt_fixup_ethernet() can fill in the MAC
from its ethaddr/eth1addr env. The on-NIC EEPROMs on this board are
not pre-programmed with a unique MAC, so this gives a stable MAC
across boots that both U-Boot and the kernel agree on.

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index cfdb5c13f8606..550358a756618 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -20,6 +20,8 @@ / {
 	compatible = "friendlyarm,nanopc-t6", "rockchip,rk3588";
 
 	aliases {
+		ethernet0 = &rtl_eth0;
+		ethernet1 = &rtl_eth1;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 	};
@@ -644,6 +646,20 @@ &pcie2x1l0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_0_rst>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x200000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x21 0x2f>;
+
+		rtl_eth0: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x210000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie2x1l1 {
@@ -660,6 +676,20 @@ &pcie2x1l2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_2_rst>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x41 0x4f>;
+
+		rtl_eth1: ethernet@0,0 {
+			compatible = "pci10ec,8125";
+			reg = <0x410000 0 0 0 0>;
+		};
+	};
 };
 
 &pcie30phy {

-- 
2.55.0


