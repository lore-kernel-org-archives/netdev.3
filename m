Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545864E50B1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981430; cv=none; b=hO+84V9HSp6dX7IWyGxALzW5g99/Oxn35gqIlu1R5NSdBQJYXXiZkBEZaUcmK49aDoHyN6rfrqCCax2j04FC7iAOIwj8nkicZMgwYG9Nkoj249hjt/YaHw30WoBPQ95N3TNLMspmaqvmE6cFiMtp/O++fd7InnticBQUYIvKHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981430; c=relaxed/simple;
	bh=2sBp7G5mc6uJL64UNxM6dPPb+46Qh7eHGxK9GvyQ9M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i98lRp3afr1YFq+uCDTilDnCd5/xxnYuVXAb+ISxl6kJG6O2r58Jm4kNhmUOIS3XruIDYHnc0JtzyoO0+logsrL61xd5UXAaeVG1c9UuCvE7vZeLOelyAI9Vbj1vyoepC2dJo5b8ZY1rpPHgRoCRcqX/U1Ggd/e36gkX88a+p3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AlfsYFZZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D5ldz6Dg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlfsYFZZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D5ldz6Dg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAR07D466149
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rewnoAte/tJ+Uf3m9Ci2S88OVFipQXBWInPmr2cUEoY=; b=AlfsYFZZiHLF5rCi
	wGlfXU/2kSJ+RvyjkPXizaFvhtZcX3+soS8b9X0bEtpg2jMZ1/KehuZctksYXhy4
	w9GsiK/7mhC3RvdEaF0j0rqYO4HWDnEm7ERb2G+36WyxrWGnY0dE6DebcM/ugyeB
	jcWDmG/3njb5u1KZ+SCDCpOEG3IFdeBR9BKxj0xw1uOjuPDUzMhV27+gBwH7VX28
	69lITh8sNIuvikehQB59dc4gYzSmSRJLtNZ1wxtF94p0evtDy02VaTKHFKw0NBeR
	WsIqoCGxiZowXFKI1j+zcpye3M52Ah7lbkDzsUaoqMPSQPZSH1LDw32zKDvstXIp
	qoiYLw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80crey8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939c30aa9a0so35556285a.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791981427; x=1792586227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rewnoAte/tJ+Uf3m9Ci2S88OVFipQXBWInPmr2cUEoY=;
        b=D5ldz6Dg5LKKrSnDzU4CIcqxmRF2JfGnKaIo/f37wa3lutC92+EXA1VzQ1sz+ehT2m
         AWXYxUYUCTHJyzxyoMxmz4EuGIu4I5p48PI6tm1M3A4JnaRexVn0w8UXfxOTct8HJk5f
         1nb6FtzqLd4bhDRSho2YwZ65adE+tp5/PaE3YzogFX+98v5lyQDONHx4gdrtmwKglKRE
         F5mUU5r5K5iWLCnHNs5b5NH5yzAONBkttM0Y2GxlZ40gGowFmpUSVkDqZxf1SfFxbyH1
         sP92IxFQZUdnhBH5eDxbPYe1d0O78VYRFlTikyAM0rT9IHeGriZd37XsWNuJDueN7PG2
         SopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981427; x=1792586227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rewnoAte/tJ+Uf3m9Ci2S88OVFipQXBWInPmr2cUEoY=;
        b=UCupzLd9upkS7Lv4GGzHhJJQP6QHL0QBUU+U+wZyqjWUeMXGvH9QEdFTNAKxCzkEnU
         pfCe2o60M4v01v/e68yl2nHQICcdatvENRAcIIElKlM6nXeoS03vSAdeO6VKtutfGPUx
         8F7dgd7nWclkqrHI7XQ4ZNFlMjF1LsxqGHvLHPQfugaKkNidhMOR/YHFRB0YS5/TNj3s
         8C3ASm3kA/Scap52g84TcZ0j0ZOsuzDqU5hkaVq1u8Miyz35rvrFHoA/lf3FOztm8/3j
         sAdE70YND9mp2ivS3lJ8EN7fU9AnXUpC7bhqFf5aFKVt2ZSv/JER66vrvzfl2YAS6aWq
         3YLw==
X-Forwarded-Encrypted: i=1; AKwUvBwjfuH3fiJg2/do2EzHyPtLeArEBtHfyOAU+Thxvouj5RnAdj4KQcGiV2nHrgHIF0unYY81mtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3GXfaPnYjfPONV/mxRp/GtnlLaYPb9Pn5VAdi/0uCH0eNJ1pm
	ewU5KSrJbwuLdCMNfNKd4c89QHAntacMajEVJRb24wc1tP3dBMRdRRE6Ar+Oscg6//T5giafPfu
	o5+5RZpgtKJqF2i8n5ecAbTpF4bLdfIkxz8pbyQwMxdh/gd12BgK4QSXSKfs=
X-Gm-Gg: AYBFou1NbGp3z3EkdzXDS68cGQI/Bz2eULDSsi7kbuOrJDlzbIrl0LTzaFwRoc8MNOX
	dbYwy9YYchWrYN1+FL7f6n8/ZQo6JKvBA8LeEBAiyYVfwItImgYbpQ3BdbiYfDbKHbgxe9OEPFX
	joS2WUIfDyh1eCFHfM5mogVocP/LzU9olzfcNbAPa+12vsy9n/mc+gyK8FTBjR17kNzygbYlhVr
	qdvW/48OtQ0M+en4O2u++svmznBOeXIqsFubMhO2BeIkNsOKmwX0EYNDiY4n0gjgWogQ9XNSk7A
	ktrcaAbRC1XURZERHoGtjSclkOV0scwyVxajk3hKZ58IeZRmiz25t6J6kpAnu9X8kU31XT6z3l4
	UQGeke7yQ+TCd3pjwVLyWDUUKxZYE
X-Received: by 2002:a05:620a:44c4:b0:93b:d7a2:dd2b with SMTP id af79cd13be357-93ebd282089mr2546071385a.59.1791981427382;
        Wed, 14 Oct 2026 05:37:07 -0700 (PDT)
X-Received: by 2002:a05:620a:44c4:b0:93b:d7a2:dd2b with SMTP id af79cd13be357-93ebd282089mr2546067185a.59.1791981426847;
        Wed, 14 Oct 2026 05:37:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f318c31sm206122615e9.3.2026.10.14.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:37:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:36:40 +0200
Subject: [PATCH net-next v16 1/7] net: stmmac: dwmac4: don't program the
 1us tick counter without a CSR clock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-qcom-sa8255p-emac-v16-1-0266c2ead980@oss.qualcomm.com>
References: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
In-Reply-To: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=2sBp7G5mc6uJL64UNxM6dPPb+46Qh7eHGxK9GvyQ9M8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqz3dl4m+qpuql2x9Vuhi+JubZ+193cRWj0/Vsd
 rhj3qvfaZWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas93ZQAKCRAFnS7L/zaE
 wxR0D/wIXdjVmoAyOQeH7rB9q9+tq0uz6+cpOevgEQPFym6rHDfDydYuv+Yx0TwmDKaVxqZEqA9
 jkqxQdxY0HzAlkxLaSYJL9dSajCUAOaQizKey3sUqyZ7gTnQDdYKJIM0saQvyScb+N+VM1CDA8k
 nCOaR4A1ZkyhRe1eaRwXPwqDRV23Y3dscokhHny/y2qlzPrjHUcocoY9Pxz2mKFyd/1dPshepuB
 ALhQTHp2qyGnx/sbNa40NyMyYIxUSOqLNpg7MPPZ/eHcKYgkGdFKBuvD2nc/aTbpFGHG5jyxLP7
 frCLl5Xa+7k1cT8qg4UPQXAjT5M9VZGOy0QgPZLiQMJdI7DjYAqQCNwAjEPF6Bdmm3tpaZetRLC
 XgnGVlbnhs/uZHx/2whbV9/5bXedTCMQikDfotazCFTGCdTIo+U5ShDYDkAFqkFxFAMdt1Q77RU
 FrTnQ/+A4OMvVXId7/C5hRBwuLsxeyoEqwLXi7guVcuc++nVFS9OqFGBV0mCz2L/Hv3+M0qQ3SK
 5kDrgaYLzvgplw4JYzqeNct7wnTR6M+0AxpMQbSCzDQKiIXYKo22NyVVXf8wZNCzpQ3j8Wix6vp
 14Gpzo8HiHXuQp4PsyR+VZQ3zaYmSmsJGP8CN32EV6T2d1AeDhgTNRKD1oP6kJRByraeJ6rRevV
 024vzSVRofGO1kA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX4c4//6dQTWj7
 16G8cSibkvNKga9+JfExk9VnR8wqrG9rRNNPs7TvRyYExL+hQpLQud+UdwUVgywOCkosWKi6IQE
 BZvvbMvkn+Z6AZuBIvJKxgM1mnhU5bU=
X-Proofpoint-GUID: sJPvocDYbOHgePBFFW2thUHPPv84ROJM
X-Proofpoint-ORIG-GUID: sJPvocDYbOHgePBFFW2thUHPPv84ROJM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX5Soj4NFV0JIl
 E9kquOOtmdIfwpAMLx1BmeQ7apdwjzM0TYKkrFK65WM6RJRmRq+ymEOR3SDCwQZ0v7wOSod9b19
 qICWpYz1ruzpxpN2P1znsvvMLuMdkKOwuVsepwjs04kStrKspgoRAbd3DHm6IhwytDi/+Tg58+m
 A5ENc4F7WBNJzS4lHeBrM0ssQpOhVv1dD1cZ+ruLjp73iXQFtLqS5M0UEyuMDSKwF1iFgVqKgKh
 hfk464eYFe4wrkTBi/fQFsfYV8faqM/8P56pR+hInSt8UwAT1NNRHnAkWdd89MrwF+cosy703IT
 jaJyNwLrBmo5kj+CurdrO4GntAWcQsK2q6xIJA1O4H8EgfcZmFuISIGXT0wO2HLwJmq1csTsTQp
 IRguM+zKikhMtO+LVuOCM++77Q1n7tUnkdkm5n266uZeSGwTmKG4ZhWiJyIJhMyMrr4QSzx5S9s
 rnsX+4on/qTmkp59ZGQ==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acf7774 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Xm6EMxWvXKbCXn_Kg3kA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140050

dwmac4_core_init() derives the TIC counter value from the rate of the CSR
clock. If no such clock is available (for instance because clocks are
managed by firmware and not described in DT), the rate is 0 and
(0 / 1000000) - 1 underflows to 0xffffffff, which is then written
to the register and can break the LPI timers that count in microseconds.

Leave the register at its reset value when the CSR clock rate is
unknown. The RX watchdog conversion helpers already cope with a missing
clock by falling back to clk_ref_rate or returning 0, so nothing else
needs to change.

This is first hit with the Qualcomm sa8255p ethernet, whose DT has no
clocks.

Fixes: 68f5d3dc2808 ("net: stmmac: qcom-ethqos: add support for sa8255p")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/179052656185.2160803.1751830002645522416@kernel.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cd6c5d6f42b5445918f277a2b4168d8f473bfca1..259e2ebed8c14dfdb9318da9be03c5f1dc9b1284 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -48,9 +48,14 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	value = readl(ioaddr + GMAC_CONFIG);
 	writel(value | GMAC_CORE_INIT, ioaddr + GMAC_CONFIG);
 
-	/* Configure LPI 1us counter to number of CSR clock ticks in 1us - 1 */
+	/* Configure LPI 1us counter to number of CSR clock ticks in 1us - 1.
+	 * Platforms with firmware-managed clocks may not expose the CSR clock
+	 * to linux, in which case there's no meaningful value to program.
+	 */
 	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
-	writel((clk_rate / 1000000) - 1, ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);
+	if (clk_rate >= 1000000)
+		writel((clk_rate / 1000000) - 1,
+		       ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);
 
 	/* Enable GMAC interrupts */
 	writel(GMAC_INT_DEFAULT_ENABLE, ioaddr + GMAC_INT_EN);

-- 
2.47.3

