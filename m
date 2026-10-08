Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD83B38B9;
	Thu,  8 Oct 2026 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482183; cv=none; b=JuSXYkjEG1yunPJQAgH/Mmh/jqTrcXBjeujypJHTYNGmde9VDa6J5Z5hHK9tD3NbhqRj18AaYw7hBJV6RN98w9BIwXUtx0DHJ1EYLliWj8Bs0dwzp5BwQFf8EyTLVUTj5Ut7rGGmpkahwEMtWrE4/I3M7Tey8sU6aie8/HBSVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482183; c=relaxed/simple;
	bh=edzsBnnHxbYxOo3OoR0PdT/k6aGpP3sirb68mDkhhgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEFFQ5MCpJUF7UtGnQ+dP4HrozJjBZN+7VK6fuxqN2BgJmhqULQ2S2bWzV8nnaI+Abd5RAv+2hr+HcYp1a96sEVTm9VEGfB1Sa7HL/lgoafHcaA5rpkXZfaZi1rkIxm9xLQ3hRqeZ3z5U/o+aTVGS+m2wEXl8H3sbIqHrasyiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnsD452cdqBN4PCg--.12700S2;
	Fri, 09 Oct 2026 01:56:09 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Daney <david.daney@cavium.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mdio: mdio-mux: fix device_node reference leak on success
Date: Fri,  9 Oct 2026 01:56:12 +0800
Message-Id: <20261008175612.2748920-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnsD452cdqBN4PCg--.12700S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWfXFy3XF15WF18CF17KFg_yoWkGrg_Gr
	n7Wr97Cw18GFsFyw47Cr4Sv393KFnruFWxWFsI9a98J393AF1UCr1DuwnxJ348CrWak3W5
	Cr1DJF4UX342gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07b52NNUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAOA2rHpfV2UAAAsa

mdio_mux_init() obtains a reference to the parent bus device_node with
of_parse_phandle() when no mux_bus is passed in. All error paths release
it through err_parent_bus, but the success path at the end of the
function returns without calling of_node_put(). of_mdio_find_bus() only
takes a reference to the embedded struct device, so the device_node
reference is leaked for every multiplexer that probes successfully.

Release parent_bus_node before returning from the success path.

Fixes: 0ca2997d1452 ("netdev/of/phy: Add MDIO bus multiplexer support.")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/net/mdio/mdio-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index fe0e46bd7964..fe752120e27b 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -240,6 +240,7 @@ int mdio_mux_init(struct device *dev,
 	}
 	if (pb->children) {
 		*mux_handle = pb;
+		of_node_put(parent_bus_node);
 		return 0;
 	}
 
-- 
2.25.1

