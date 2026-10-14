Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CC4FB9B1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981443; cv=none; b=j/Wszk3pdJihB+zxI1wUDZqNabXMFA4eXxQxHu1MINLo4R9vZTuk8p6y79akhg1rl1JcLwNIBZFfJx5tIURjTYkr3Oeh7NFCZsloEd29OVBN0QGT5aQNJzgtjZE0TB9xA6x4A6Zo6PnbaywFmZFdZQUA/n04fQ0l+ldiXfRUDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981443; c=relaxed/simple;
	bh=kqw4gb8apOiVp3CcayV1NpfyLAXLAzYoPSPv7h0hX18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uH/qlJxhQ2Xd20PZlFpFA+Dzpw1Fjelj5TD+eTYHXSD2hIhpMjy+rBU/nFROBSud36sSbihYzkfyAvfxIjYiKconqGKOKThoM5PozpJc03F1AnsRdJz3T4RTf8LfK2AICzEWdP2MHGRQ/hvIXmPFehx2bXF8rG6ujqFvbIZzwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MmkUAop9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P1Yzm5oW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MmkUAop9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P1Yzm5oW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EB5eja3952148
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HUUFLBAcLxOP3+OVTyoEpsSPqEGr/1sOU62oPMkNAZQ=; b=MmkUAop9sci6+WWj
	wN5lcHy+iw/DsXVUsVl1mSBuoCvqhQh7otgrOJOZz9BJdNQ/cx9xZRI8j1Mg9rvz
	HuSi1IWFMc4/jayAjhHBo/yhRMUixl6klMgnnRBRi4HrAD+mtUTHdME/vdACf06N
	9hRquTMLNrL9EAutxwLnMRgIzwWPTo6jpiLrNt5fqiWscuTwKpQ1b0Y0EfaMzcqg
	bIJGwLAHZTx9hPeM2p0hId8FU8PcAxI0lG+1HNQvZ15wSJ0sVZAdHytC3wuc/qLy
	bPyHT0/QhdO6L0d3ttef+xgFjWePTUlw6JzYZ7G+jvo8zEJeAhfLFq9m0I250fn4
	KRZ+0g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p1kuj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:37:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91430af782dso90666826d6.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791981440; x=1792586240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HUUFLBAcLxOP3+OVTyoEpsSPqEGr/1sOU62oPMkNAZQ=;
        b=P1Yzm5oW7C+XBPfJr4CX9nnC9tPumV7bgkxh2400gnDix0kq+jPBAJhmEBzZZ7T/pl
         9d5uBysQtPFAlOV9+LonGtnh5rGbldK3/e+vAnif0V01NaQ2ZkTVU5o48qs9wNXahlxh
         /l4tL8e/krp2uvYaJjgVZ/7f9H0kUXoqBlziREzfDgS4zcdkuES0HQziJGzqXMWGkQ70
         WYSrXpgOEjD238afLYRnQ2zneKvt5kRUSZa7p/zTjcJ8Fe1NieztaSadADln6nHY7rhD
         olTbh1OyaOKz5gBh3PVavlibHY/k+gLxS0iQLcWFCi+ThY39ySgQcaXTLAYdy4urmsQz
         7Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981440; x=1792586240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUUFLBAcLxOP3+OVTyoEpsSPqEGr/1sOU62oPMkNAZQ=;
        b=VeOIjOv0TVfxd+3c6FXa4tEBjGWjpx+XIpHC0pH7NnLd2IyEyqrvgFoxbZM6/qLy/g
         S6z3jxizzeIcqFYWQNpQJjPKosFOiPmWrmJ6yBWtA5YRSyzzicPNutBqIPe2AZa2XPmh
         LipQeVvkvFXVW2pe94N6W5u6FpsXeaBtO4+e5zI6iq6NXhNIWe9Qsg54wRwYH2887dTM
         9x7buKQM6ncL7vrzUeYczAS/ghq+9fbdspxUjWavMJ73Txlkc7zMBaFHgYBEnizlgY+2
         cZ5SS9wOdn4XXXqG/G0mt3P852THeQ/fY7OYGoCSk7bWyQmP0vl/3YuxddRMGUxxOB0F
         ktYQ==
X-Forwarded-Encrypted: i=1; AKwUvByvP+19D8ZNHX0zUKB3km2DGubn1b6xwVL6fgwrfpXEJT64VwH6aJP4rzdAhvOOsdL+Dzohtx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeffGyWfYANrMAgeDY/CGx2Z2sSFBLrSLAwg4ZoX654KPZLgNS
	vOU3hNgUSkd4hq18PY9kDljMdhr09TE7+kgJ+c5ACAjQkaP36X/QLFuPapPI+xxjyzQuws8qRwG
	kkZ076LtuB6d/6eK4A/Iw59JpUs0N4sCrh2p5DRdQc6NnMDboVYp7heswEaY=
X-Gm-Gg: AYBFou1SVycVNKkSYAXv8f2ejathCQrWtel+rZtAGSHrhIj+44SBvMiM/qRgcGm7YU4
	pX1jeuWarGk6Ck20CxxyyCoCtvlqjngAY+DbtIrptLN2zr9KMyaseeyJYPNv/EDO5ZxdLraAaio
	5a5kBcXiZUHd0bI2d57JMMsuAG4xZ7h/ZmvkcvYoalbDpHFEqGHiwV+kvJsROV9lJfvz4Mz1BrU
	fdo0rUbmw4eqkJe2wXuU54QdyCW/+CmjylShjdBMEuJ2/Gsc4lnKROgqkva15/Cwjf8oheRDZeo
	r2CrOnDHmeZXBSEK2qwh9fyzjDzttaKAbdinfxGAvf4GpwQfKVXwqGPt2p090DarnYGFvW9EakB
	qvUFx1ucmeGcmWY0eRaRLbQPmDMdA
X-Received: by 2002:a05:620a:4709:b0:93b:d7a0:d9e3 with SMTP id af79cd13be357-93ebd259161mr2675133085a.61.1791981439708;
        Wed, 14 Oct 2026 05:37:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4709:b0:93b:d7a0:d9e3 with SMTP id af79cd13be357-93ebd259161mr2675126185a.61.1791981439129;
        Wed, 14 Oct 2026 05:37:19 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f318c31sm206122615e9.3.2026.10.14.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:37:18 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:36:43 +0200
Subject: [PATCH net-next v16 4/7] net: stmmac: qcom-ethqos: update phy_mode
 to the resolved interface in mac_finish()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-qcom-sa8255p-emac-v16-4-0266c2ead980@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=kqw4gb8apOiVp3CcayV1NpfyLAXLAzYoPSPv7h0hX18=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqz3dpe3YUAPOTSmHWHwKyO4Gn0NPJB7SEy59Cl
 is1k9W4sI+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas93aQAKCRAFnS7L/zaE
 wywlD/9xJCp9lL+ZiMDkuKH7qK8YrUboTI36b+vI3x9ZgCGsyNs7Zu2oaYFKMGti/G1ilAPuR1L
 bmWs6jWD0sIinELld63odrSoCeoYY3SAWY/XZm1U3dCCKvsecfhS2xOYYpR+U0crYDrDg0YmFhw
 VgIZ1TZnO/ddLJ4duxjFjEHcgtJ1WniYm1mfxQKljV5xhOhvTfKVcUhvzH61qfLuhiOxhqov6C+
 GQxz7sMayjtyPJxQvhjqMVvLCUAJHQvd38hOsXjngHAdSRwejgsY/3BOnJFzlsUbm0A99THLHmP
 1GsX0tIYaAH3J1AD7jGg4/HLC+itt97RLPdtmJOF1Viby0GUJRtAVQRuiwMWmG89clvousBBhbj
 SbguvN8nnpnhY9S8RGdkQwTIt7+v37de4B4jWXrYaDaxOlAetyLSkqW2ERHMRu2Yq+JD56Xmi94
 U+DiOjn1TNjN5mpKYqPJdXbXaUrrZWxHMlURaX6ElZQzpz1cd4E4hNKaqoGCvVjCQa0h8n/BfuZ
 +WA+GJEmWxOuugQ8WvHz2stN5YnA8k0Ib1irjQeU4kYxC6BQHhLH7XjmjIXwbPoKfnskJh57Gq5
 7sL9rGWQsWoyF/vfr+MLW4JBM33XUIfxAjBfWKVJ2cMlf86Nq+au14uzK9m5YAgBZvn3lBaReAn
 W45KXwiaON/5o/g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX3w4zUW7dV5Wo
 aFezj5UGT3/G2Jo8xeQn6YxglyIBjfqhuI3bpDBo9GjrMjO9dQFhEI3Qpw9d1pocRLEphTLKNuQ
 IeKZhIxFn6gKtZ6Es1X8fr+vCi0rgCA=
X-Proofpoint-ORIG-GUID: 3Lv8V6a3quQZu_K9OrmdV_AaDS3mW09S
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf7780 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=FCP7PvUSyU9qYmcNpmEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX2OcaSSekcM8B
 0rhV0wWR6FqURb6JBQi4lkLMBX/xGCfy/vCH9X9yYIvYhEb0kNwiOyuhn1QmuZa/62BqgEe0pxf
 w44LEngcK6lvTQEyRY6M5/7FQDbJYozAVIfeC0+Iuaku4h3QvLyNUXJaePou3JYG6D1qJZdFCuQ
 V4d9RzXDFigJkWhF6XnxMoEfPdj+CjBtaQbDPEsCRhtthHyj09+iZqfi7e0FH0t5Vym0pBa8rdP
 FuPWYu0u4ua9s6yiQu5Q9KIxUJkMgkT0cofEiQkOfFf66Pnix/dFX51FrQMb38rNfjiAqA1MXjm
 4BtR5+uK/1l8IYDeBe6jhCIvUzeqJNUa55B9lRir4jVzjM2icLv9rp110uPF1RsCRrTvCbTVhGo
 bA/jNDKkA00bT8/1LaQKbynQ7wHJytiXKM/TUrKDiBrH9ObjhJTkn96wouYv6EkozmeSotfM3lt
 Qpk84RxGa3SHPvLwydw==
X-Proofpoint-GUID: 3Lv8V6a3quQZu_K9OrmdV_AaDS3mW09S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140050

ethqos->phy_mode is read by serdes_powerup() and
qcom_ethqos_set_sgmii_loopback() to configure the SerDes and its
wrapper for the correct interface. It is set once at probe from the DT
phy-mode property and never updated.

phylink resolves the actual runtime interface and passes it to the
mac_finish() callback. On platforms that only ever operate at one speed
these two values are always the same, but when the interface changes
at runtime - for example switching between SGMII and 2500BASE-X - the
stored value becomes stale. The next serdes_powerup() call, on
a subsequent link cycle, then reinitializes the SerDes to the wrong mode.

Update ethqos->phy_mode from the interface argument in
ethqos_mac_finish_serdes() so that it always reflects the last
resolved interface.

With that, we now update the phy_mode to the runtime-resolved interface,
so any subsequent resume with a 1G SGMII link skips the loopback setup
and the DMA reset hangs. To remedy this, extend the guard to include
PHY_INTERFACE_MODE_SGMII.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index e2e611a4d2c06bd567e9d5e353b3a4893623de6c..f7cc46d86591a220a183529a8f89456f9153385d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -190,7 +190,8 @@ static void
 qcom_ethqos_set_sgmii_loopback(struct qcom_ethqos *ethqos, bool enable)
 {
 	if (!ethqos->needs_sgmii_loopback ||
-	    ethqos->phy_mode != PHY_INTERFACE_MODE_2500BASEX)
+	    (ethqos->phy_mode != PHY_INTERFACE_MODE_2500BASEX &&
+	     ethqos->phy_mode != PHY_INTERFACE_MODE_SGMII))
 		return;
 
 	rgmii_updatel(ethqos,
@@ -637,6 +638,12 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
 
 	qcom_ethqos_set_sgmii_loopback(ethqos, false);
 
+	/* The interface mode is only known once phylink has resolved it and
+	 * may change at runtime, so keep it in sync for later
+	 * serdes_powerup() and qcom_ethqos_set_sgmii_loopback() calls.
+	 */
+	ethqos->phy_mode = interface;
+
 	if (interface == PHY_INTERFACE_MODE_SGMII ||
 	    interface == PHY_INTERFACE_MODE_2500BASEX)
 		ret = phy_set_mode_ext(ethqos->serdes_phy, PHY_MODE_ETHERNET,

-- 
2.47.3

