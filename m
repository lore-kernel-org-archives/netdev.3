Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407932548C;
	Tue, 17 Feb 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335056; cv=none; b=r69WjHBAhkuUEJx24hGPwt7lP0Urugi897AvQ37eNHm46ztcUPWEfpRLZn4EtuoLbjidZFDotUzpS+cHX+vWTqR/jqrIep6Ofe1ugTDkJGksT56hnVXCjsWpEtAtBFLpTQvoqPsW4J45PXY7lMtnbc/wprltnRNx3NOCDYTGiqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335056; c=relaxed/simple;
	bh=1rLFpL4Uwtqdb0H/T/vGwCmqj19wxgLIAnLHuOiEYYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bH+ZFOJL77t5gMbeZZaE2BMNtgYYewwu7mMPGcX+75ig5hWNsPh7xhgDTXd9R6lgtFP2nH0Hu4phoEaINdJ/BY+njeSxma2wTacwFPKfBmjK1xTA1TO3vPHIZf9spPh1h7fxRJdtX9WfRM2Bh762FydyjvdoTZjdGphVDQfWmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsPVwg8s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsPVwg8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9032EC4CEF7;
	Tue, 17 Feb 2026 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771335056;
	bh=1rLFpL4Uwtqdb0H/T/vGwCmqj19wxgLIAnLHuOiEYYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AsPVwg8sUL+ZtiB3njQKqvHKKv5g6f4QzJNhk9yyUGPUEZTredmyyklYdLpYuU5Km
	 9mJinBNjaATj6AFJmGl1kApHrVCVWzilolhsqUQr3jH6czdON8qg4kUuK3lYAKLOHO
	 y2rZ0Bo5SDgv42iakXO1L0lvmPC1I9NOqTH87BLuoAObp3JPmd4A7nP9aFtwMAK5oi
	 juXG9iOX6e7roN+wRZ+t9s+V4u8xvrx6v4WW6gZbYVyLxiYZdCS6SOSRwKY6sF7yTg
	 PfD5ix4CTPFfhKr3A9HuDIs8p4PHhcb5PUlMS6VzDzBV5Af6K4ecpBHReGEgK0sbbl
	 FDp6bdH8T24rA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 17 Feb 2026 14:30:33 +0100
Subject: [PATCH net-next v3 3/3] net: ipa: Grab IMEM slice base/size from
 DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-topic-ipa_imem-v3-3-d6d8ed1dfb67@oss.qualcomm.com>
References: <20260217-topic-ipa_imem-v3-0-d6d8ed1dfb67@oss.qualcomm.com>
In-Reply-To: <20260217-topic-ipa_imem-v3-0-d6d8ed1dfb67@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Alex Elder <elder@riscstar.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771335036; l=2618;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=d2RMINvOV7bNStCWiw3Bqaw/rVPWmmHqQzpiKgrBtF0=;
 b=YhXT572fSQ1ifKpMECPi9DOcNowWYxzl9/N77/ZdiYnT3LMH96pNZoXk+IuHQ0Gdowx+otzXg
 GPDT5NAuR6pCkZZ4bHpCzjHvUd9Zayg+Bz0MYj89gKE+Hj//8KA8gV+
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This is a detail that differ per chip, and not per IPA version (and
there are cases of the same IPA versions being implemented across very
very very different SoCs).

This region isn't actually used by the driver, but we most definitely
want to iommu-map it, so that IPA can poke at the data within.

Reviewed-by: Alex Elder <elder@riscstar.com>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/net/ipa/ipa_data.h |  4 ++++
 drivers/net/ipa/ipa_mem.c  | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 2fd03f0799b2..5fe164981083 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -185,8 +185,12 @@ struct ipa_resource_data {
 struct ipa_mem_data {
 	u32 local_count;
 	const struct ipa_mem *local;
+
+	/* DEPRECATED (now passed via DT) fallback data,
+	 * varies per chip and not per IPA version */
 	u32 imem_addr;
 	u32 imem_size;
+
 	u32 smem_size;
 };
 
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 835a3c9c1fd4..583aea625709 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -617,7 +618,9 @@ static void ipa_smem_exit(struct ipa *ipa)
 int ipa_mem_init(struct ipa *ipa, struct platform_device *pdev,
 		 const struct ipa_mem_data *mem_data)
 {
+	struct device_node *ipa_slice_np;
 	struct device *dev = &pdev->dev;
+	u32 imem_base, imem_size;
 	struct resource *res;
 	int ret;
 
@@ -656,7 +659,23 @@ int ipa_mem_init(struct ipa *ipa, struct platform_device *pdev,
 	ipa->mem_addr = res->start;
 	ipa->mem_size = resource_size(res);
 
-	ret = ipa_imem_init(ipa, mem_data->imem_addr, mem_data->imem_size);
+	ipa_slice_np = of_parse_phandle(dev->of_node, "sram", 0);
+	if (ipa_slice_np) {
+		ret = of_address_to_resource(ipa_slice_np, 0, res);
+		of_node_put(ipa_slice_np);
+		if (ret)
+			return ret;
+
+		imem_base = res->start;
+		imem_size = resource_size(res);
+	} else {
+		/* Backwards compatibility for DTs lacking
+		 * an explicit reference */
+		imem_base = mem_data->imem_addr;
+		imem_size = mem_data->imem_size;
+	}
+
+	ret = ipa_imem_init(ipa, imem_base, imem_size);
 	if (ret)
 		goto err_unmap;
 

-- 
2.53.0

