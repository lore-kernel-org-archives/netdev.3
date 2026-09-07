Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88B3AB262
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812690; cv=none; b=bBDEQNci7wJZn21dYuDDXIKaxjM8Q2qEnv8MqaHvG5m73Nn2i+smQjc5wEm3WUUGwK9BpCKEie/eTQmtgmEAzCQ5u1YD6cfuy5pGkOx1gK4q35wWK1AACgF3dnKDfjFQyr4lvcgGLxztBBMa4tsOXY+o1SgqdppIdog09c5NJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812690; c=relaxed/simple;
	bh=lnIs5iGMJ1/TyrszL3HdmC9OvNff74ciWiwlTO04duY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YO+ozgCT6D6kpuESua8NsAoyb2I4t04zGvAOpWIBNCAlk4iE4TNO9xYm4SF2YgscSOemqVZeDMc+7ZPnJHbPOHWWASjXJtBpFYH3Mm5/vzjmCOQKlaZtnIUIdQYHZ17B7OGRIg+hCUM76m8LwCGaz7BrkhkTfWLOljkshRqbRc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XfBO1OeD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VObA1KbF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XfBO1OeD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VObA1KbF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687H7mb24061938
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 20:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+JaG7DKTSi7xhDFXHxjPdAJJFng2xHhnPLV5SDhTiMQ=; b=XfBO1OeDaI8C8yE0
	nMeDOlsvy9eWugwFQNl++ShzxFd/G/y2X2kxXGh4JfcPlC/gdaPLdvswvM5S7iKD
	XDpEj7k9esOziJqN3xCslzyTcWCKh4gTyGJhSFOXq8Jj4VTFzVBjgiheDjCtMpQ5
	IazvdXSZtSj67Uo5Oe368CLMrXbUh3IybztdeJ2vYQ52WpoIfo9MWPnidmQBFMN+
	zxewce3cJaZPR8z0j/CNABPngsvr9KxGgNr4HMfDuTJl55heBScAealMO0czB5dX
	2n0HHdotg4BLQiMPraZMkSRYqrD/pYkq1I64CQzbGiw9VPkCz5iKvWqWXALfMpIQ
	ZBusoA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj077gsp5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 20:24:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3b126c9fso27798335ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788812684; x=1789417484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JaG7DKTSi7xhDFXHxjPdAJJFng2xHhnPLV5SDhTiMQ=;
        b=VObA1KbF60AVm++QDTG7YVM27UPp1YUI+9PticX4boPkVUQm8nQge7m6gyTVvNwEJR
         pQbYJ/7eO1BKq4VqVAGTuXIN6rH90QK398KgvNVSS52sq23ezksmAvABYWpaDBJb0Pyd
         /9mh4DkNNK0BIq7a+J43Z2FZ7dp9Ej3w6LbqFFcD4SPp/JV1njisQC/jvkAd9t6hJxC/
         sbsY4FKGf0ji77NUrvJjZmCpFtnudzf9gMvT/gcJHLyZ/zxE5iMDAdLy0EXaagHEwibH
         3Ph7d7HujsPqa3ntz6sUdJvh3BpYq8rDd8DX7eYvyc1VTNWKTiawogBNDiJaO4uCkFJJ
         CmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812684; x=1789417484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JaG7DKTSi7xhDFXHxjPdAJJFng2xHhnPLV5SDhTiMQ=;
        b=PRbLC0GakWPAPNdVONOM7L6LnI/QF5BDHUf37jO/3KBVaZv/CKgpnro82Jk/8o5+ca
         z+j6RmmxS2NcKUrebeUJXliIKd48eegcp/YkYIyWS8kSctD41Irjj6AIyECgPcp2a+vO
         iTYM2aoZbeC+zKg96nIEblncj4FWUk0W295R1POUT5Tnb4vyJqSSYpgMCLkX0LcF56zx
         2NaKbzV8XhpQSFaW7q1a0yaR6199K0qmEQ1lfAsV1TKNT9VKx9Sflr/gwZZC+Tme97VT
         i3ZasfTiU7O3PhtPyoztP/Q2robYBUFGZjKuhPhLxE6j/Vv9lB85XmohJSgcVhgGPlk1
         tD6Q==
X-Gm-Message-State: AFuF++k8mdeL1sZNf3bJfHdEUS3yeomPX2lpexNj5a/8C9SVl9fYYJr8
	oys1CSyubv7n5WQ1EDzrCSbq6AKiQj2k8IHQTk8HGdAemV2kryHhq1+9BOkAqhw84phw5vlDLV1
	xFB6ZC5BmYnif8ILNgAXhZpDKvzru7kWQWbiL5quga34f86klteo/0UcvKp4=
X-Gm-Gg: AYBFou1C6BbwHdVvMXhvgAiHfi2RDtks43X8rmSnBo3xfwY4rrVDHPz7BvZstkHVWcG
	ZglEwXrbgFVl3fzgrtfg/eqMm4HlKLf9JPLBH0ricIgJlnW+eO6IFHXyAWI6LRsSm/ON5gEl952
	jMh7xqGVqQVYKCg8qFmxXnnPNTKO2sFAUN3xeb6WNOZYr0G67ZFpNb2dggRM5zV1B/udCCTWh7L
	OOUIQu3j8pThjfhV89E70NvM5HYiXEzylYQVuVXPzQbmcAc0u0a/70DgPd6JrdDW9ybmTq6rz7d
	Fnh22re3AJVW5DIMJNRDya/TeykWelxrZlGx3nnObNe6jnJ57PI/QsUdMiQ8TUt9h0BgGlVTkm6
	5N63k7ODykydkzhz5ESIR/MF/5jiEbQ==
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2db1235721dmr345681715ad.4.1788812683829;
        Mon, 07 Sep 2026 13:24:43 -0700 (PDT)
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2db1235721dmr345681275ad.4.1788812683356;
        Mon, 07 Sep 2026 13:24:43 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm30482259eec.19.2026.09.07.13.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:24:43 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 01:53:19 +0530
Subject: [PATCH net-next v2 7/9] net: stmmac: qcom-ethqos: set initial
 RGMII link clock to lowest speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-shikra_ethernet-v2-7-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788812616; l=1202;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=lnIs5iGMJ1/TyrszL3HdmC9OvNff74ciWiwlTO04duY=;
 b=PlfItwBPYCNw7E604PKTJ17SgNiJIFuqKR0zm4aGtFG1ZqfCDUXoVzeUencwPv+khFYTEm8U/
 eKLk0dGU4CQAJ1XjFA1wGqgeMRDsFUVkiV43j1CRG6ATflSZwIqafK4
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfX+V1H57R52fuO
 qhmyK1CvUKUe0B2A1UklNQQvXtWd8Sb16YbEg97SL8QKy06kFuMQhKZoRTSM5ZlTdWBHfxLh/Pe
 XvU8qLBeH+0oF6HM4wfMeEOukeA69LHNvbDArOXFrI1EPzyyYiXZVKzaS8QMH+NLrXT56yuAaje
 3Uh5643RmpOgMUzIe+ueY+S0hw+PqOJGgjhV+JWEA1Xl9JxfcpQqPuHScll6UThbLUBknLf4hjX
 ssP7yI7seo9Nvj0uFcqzbWxb2MPLfgqbDKrpF0kJVUUua1ZJ8xdWS6By8CJJJaITyOj/5sUUG7U
 LsZBGdEDt+GC4Ohyng+fY8Piyvt66Fu7/9bujDf3+9sH/A168lv+tyvrZiC/v5abL3s/sFkkW6/
 sXPxbE/TiUQLLxVHK1GCzchfnsv/3kGTMT90IWyMoZP0jpZvt1+6zyZ9dNVyBLm7GhCU7MLGobg
 zLlW/9WiVtx8REx5PKg==
X-Authority-Analysis: v=2.4 cv=Xbe5Co55 c=1 sm=1 tr=0 ts=6a9f1d8c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=oGeBSM6iGANWI8Y-5VEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: emMPfTTw7v--4ya8qke7S0zKwbOP9T7X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDIyNCBTYWx0ZWRfXy27cIRvDeK/D
 myeUKdcl7V/YBXjadvBU2QWOexa/AOBqTDDAe/e5rOmOIYvU8pwEe7/4V8cWUoZAViO3uxcxu5V
 n9Xn9wOWG/F2bxpwMNmuWbA17d1TJuA=
X-Proofpoint-GUID: emMPfTTw7v--4ya8qke7S0zKwbOP9T7X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070224

On probe the RGMII link clock is initialised at SPEED_1000, which
translates to a 250 MHz source clock even when no PHY link is present,
drawing unnecessary power.

Initialise at SPEED_10 instead; fix_mac_speed updates the rate once
a link is established.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index a92bf4a6a2dbd987893bd4a3890df770bb7a7e56..2471871562ed9915398614d5c88d1c6673829db8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -814,7 +814,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 				     "Failed to get serdes phy\n");
 
 	ethqos_set_clk_tx_rate(ethqos, NULL, plat_dat->phy_interface,
-			       SPEED_1000);
+			       SPEED_10);
 
 	qcom_ethqos_set_sgmii_loopback(ethqos, true);
 	ethqos_set_func_clk_en(ethqos);

-- 
2.34.1

