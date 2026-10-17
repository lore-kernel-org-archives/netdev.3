Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810981F936
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230346; cv=none; b=BAwvbLaeL8LwVQkRrwjPE8SJsVlT9N5hm8osJOa70bp/K+FS6vMCXUSbrIpoPSGHUf1WjcXEyazPSpeTkmkF2MB4LiU0cVa9U7diuGjZUze+VmJD7Hmhh44ZBIOcSadZeo5zloJkh7ijzlJiqvy6LkM/Ct4pyh2nqWnd5jSVMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230346; c=relaxed/simple;
	bh=WVSHBlAoKrJDFHjSHgKUOHwT3ILmdd9Bv1++uwfX2CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+ldJofAr8g1/oWLNcJoEGodR+CIB3ZL0Lj67rCt1kEyYd0s00NISAEF3yF2VygdEZCV9dbo5CMv5tpnp8wXqoZTyHuDkkusZBRws4h7L1yCuJWscxs3IG2wiHgZaVcOocmw5UtBn/PRdnu0OsyR+d4lK5KyxFShBr1fk2d1luE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=is91o+ea; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RgGFWfrg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="is91o+ea";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RgGFWfrg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6nui1389357
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jzE/Q16vHCGMwmevYtx35ZN8QzUMpEh2gX+wjYeXZXI=; b=is91o+eakQSvu+YA
	41mkYzQVs3UllcmUPE4QHpGVa5esOKREV7CLOZPkeeChuCtbLE3qqAg3Yu687bac
	UWV9ZbyDMMVKkI7z37vW94ZYuDCqc2v5jDC8bb40/DUXa0wSfc5P49314X0T1Bl4
	I/kvJppeQ/ic+wEFefBC2//GJVsmQDvgjTvyYJAUWSw0AbhqqGgZfAPCn1AcrsoF
	dXsmUYW6/E7AMC3K/ha9dzBgsBSwSYrzJYnXnwfuPctCyRKlWEI7yWw49JjRoyGp
	1sQDttekEU8l9euXMadYPIE+17QXZ530cnEfC2CioXnpcgqty00HN+dzq9pK20Zi
	KgY2nA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1838mj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:45:44 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-152d1363a29so2688109c88.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792230344; x=1792835144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jzE/Q16vHCGMwmevYtx35ZN8QzUMpEh2gX+wjYeXZXI=;
        b=RgGFWfrgIZjlrHhsZmaTCX5NDiJxmQb34abYSEpRI7U2y1k0Q2RcxUY8nJyAzjA19c
         yM3QA+nzzborSTV3m/LNynOycRatGwrzFmcJfpwguiNMKAg9y0OZ+JyV4XvDAACr24iQ
         nMvYAEhRziH2SnYXOHGBu3CAt2GogfTQig6WD7Wh1qYZE6gvVed8Xgo7I2bHhf/jv20z
         MSZ//XtaGfhP0bToke/0bu0/pfSFCT0rmCOEH0xhdtKqL3koTBQ8hTgvChlupNxbjAmG
         Yo5BgY7aBg8AU5x8VVutklilSfl3+zqyAnMcz4sBLqcHehGu5ckWuk7CySOZV7LnHHy/
         RPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230344; x=1792835144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzE/Q16vHCGMwmevYtx35ZN8QzUMpEh2gX+wjYeXZXI=;
        b=F5/ZrxfzgEy/Oibww+2enejCkxXNZRjr2A6Py7DnG54vH1SxH0q9daJFUos6R250Sb
         sx7iRh1394OVUcknBPtXf6y385RGr4GFKbW3UL0c6+fQ2PHN1ZHQgzvpAhMgPhbHA9pc
         6+VflI/m7yMMNErGPbVYk4L6fEvatU5daZjIionTNh+vRm7x7XnXhTH1TG6G4ZW/mqz3
         oKiuV3uxEx0VE0IEW7rmuyQFCEmN5bxEQLSUMmptB0CFaZkBj2Q4wvzpWnArVmWeg4HQ
         GRUvk4vrWQt/DLJiQjzIKndGoiCdbyN1MyEAFwVFfxNSmBmqtdD1xr6I+wr8Lfxrq/NZ
         ma9w==
X-Gm-Message-State: AFq9FYKtCQtqohI4dzJUlb+wwB0HIULeeQSNlc7lOigGazDM/lzkVZVD
	Bz00Hrm1ofR7mE2wmN0po83W1krCwwiV6oCEKc8Y5ueBxS5GzMNFvnwyk8MOo7QgrPYx03q9hjT
	Jn4+3Dvro5DitgMAPFQRR/KRvCWlvOjWpOZPu5SFt8sQJ1wvcSQVUA4uNl8I=
X-Gm-Gg: AYBFou28mpz+1FQrhn+86D3QWuCgdVLunTcbN/LFVc4nK2EiXKW6UUQ34A/Ys7Z67wO
	/IMy5I8LAgRjWt+FMOEXWZW8/qH9MwkbvFfmKTsdSql3Pf2IkOdz9MiORraeWwGYLuun/f9U2gL
	PDjlhpcDgAcUxkOQjkOHfW0RT+jrrH8wbjrGfEHDYHWgGO+OFMz+qDga+eyFW80amG5lso4Gd02
	r6mwzLknVsZb2iB6CU31vicRVRYAmkxKu7E2FLg0lIBkE5/Iaja2K1+oiqweUbmuQOn5qe8f2ed
	sTs5U1jM14uBgSYS/PNQFF+bsl3zYyk952xVV67b4TDguj0ZeUWI5TvN1Ef6KhgbDpt6KyFTlXX
	0zXhBRKjHQlO8tDCW4UZu+yd3TxUzww==
X-Received: by 2002:a05:701b:204a:20b0:14e:cc3a:9f32 with SMTP id a92af1059eb24-18511ad88f3mr3460855c88.7.1792230343712;
        Sat, 17 Oct 2026 02:45:43 -0700 (PDT)
X-Received: by 2002:a05:701b:204a:20b0:14e:cc3a:9f32 with SMTP id a92af1059eb24-18511ad88f3mr3460812c88.7.1792230343061;
        Sat, 17 Oct 2026 02:45:43 -0700 (PDT)
Received: from hu-mohdayaa-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm19450327c88.11.2026.10.17.02.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 02:45:42 -0700 (PDT)
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 15:15:12 +0530
Subject: [PATCH net-next v3 1/9] net: phy: dp83867: add regulator supply
 management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-shikra_ethernet-v3-1-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
In-Reply-To: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792230324; l=2447;
 i=mohd.anwar@oss.qualcomm.com; s=20250907; h=from:subject:message-id;
 bh=WVSHBlAoKrJDFHjSHgKUOHwT3ILmdd9Bv1++uwfX2CM=;
 b=UQBsoFxKJfv5tbLctgXh4QAgGFocXPnjAeq6p48mkcMMGBNr5pjE5YFrDHwIxZnoEKYFdwpl/
 C2zcyKxXDyeC2ggJgEVgQUe783OQ7JesLTnG1GO4YI46rkrkIm9ShMT
X-Developer-Key: i=mohd.anwar@oss.qualcomm.com; a=ed25519;
 pk=7JNY72mz7r6hQstsamPYlUbLhQ5+W64pY4LgfSh9DJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX0I0QUrzzze1I
 XaKKs5BaslpFHQpBRt4F/9C2IolEeBedv2VBitUuif5yWvdzWgM2eb5euDhuuCbuY09F0MSX6Xg
 zb7nTrByhAonMnHX3D0t+hZ3DqBcjNY=
X-Proofpoint-GUID: LZFzUEGej3DUB25XjRGtPfu_d7uEG_rY
X-Authority-Analysis: v=2.4 cv=Bu8IUoX5 c=1 sm=1 tr=0 ts=6ad343c8 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8 a=uuhe7hOpKvpPPjRdXc0A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzOCBTYWx0ZWRfX6ygH41/yScmp
 tRgT8SXUopeeW1WqoCrdaHoiXgeFeW1gkM8tm1I/TKKiCndrmwdrA5bZTVw9AsVun7iic/Cle9O
 b0LvAp8jP4BY7LKTFBMmkWXSvtq7BmnIYzOM78idrAmzIdiCukDETOLJnQknD0XSjXPA/rUHtlY
 F2GnDFvD/ThNXGsNKdV+4Xd/NA5WEnaVK6OQZQoaPwz4RYcnZgCeyqKxj3AqUbeKGcSlvv38KpW
 6RWNs4GH6a7xV99LkZD6ip3CSQao9zC9oBHbneXuLXp7gpsiCEH4Q/BrozqrSeuT72W9z6qUhab
 T3wvpGlq4ncPqaH+ShZ4YrJIBtfIZHX97N5IckLzyUsdVLMAFswg4l3aXSWKROinskMObGES1zJ
 Qq8V3ncJ9ufYbvGBHxbK7hwVRYQ1FgyQlBC8p7CVwSlhxBmjz2GdTY0YuL2Aj6nLE0ZWv3i9d3H
 gbLaPmNbNptWrtNyVsQ==
X-Proofpoint-ORIG-GUID: LZFzUEGej3DUB25XjRGtPfu_d7uEG_rY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170038

Some embedded board designs use GPIO-controlled regulators for the
DP83867 power rails. Add dp83867_power_on() to enable all four supply
domains at probe time. Absent supplies are silently skipped, so boards
that do not describe them are unaffected.

When any supply is newly enabled the driver sleeps for 200 ms before
returning.  This satisfies the post power-up stabilisation requirement
mentioned in section 6.6 of the DP83867E/IS/CS datasheet.

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
---
I have kept the Acked-by's since the overall premise of the change
remains the same between v2 and v3, please let me know if you would like
me to remove them.
---
 drivers/net/phy/dp83867.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index a3cd5cb11ea0ac108219e05d990b378483b67d7a..092bc68bb9bc6561e2457f596206453dd84e56fc 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -16,6 +16,7 @@
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/regulator/consumer.h>
 
 #include <dt-bindings/net/ti-dp83867.h>
 
@@ -730,11 +731,42 @@ static int dp83867_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83867_power_on(struct phy_device *phydev)
+{
+	static const char * const supply_names[] = {
+		"vdda-2p5", "vdd-1p0", "vdda-1p8", "vddio",
+	};
+	struct device *dev = &phydev->mdio.dev;
+	bool supplies_enabled = false;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++) {
+		ret = devm_regulator_get_enable_optional(dev, supply_names[i]);
+		if (ret == -ENODEV)
+			continue;
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to enable %s supply\n",
+					     supply_names[i]);
+		supplies_enabled = true;
+	}
+
+	/* Datasheet section 6.6 suggests a 200ms post power-up stabilization */
+	if (supplies_enabled)
+		fsleep(200000);
+
+	return 0;
+}
+
 static int dp83867_probe(struct phy_device *phydev)
 {
 	struct dp83867_private *dp83867;
 	int ret;
 
+	ret = dp83867_power_on(phydev);
+	if (ret)
+		return ret;
+
 	dp83867 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83867),
 			       GFP_KERNEL);
 	if (!dp83867)

-- 
2.34.1

