Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384439;
	b=CSfPls0WTkxNRJrszzNSXYIhkvrjFhHurmSUaNdws/f5u0uobsxRf8nOFupLXJQogf0h
	 A8bgezVXiHmp3cY2xiOyEs2ZmDKXPwqD7uG+3OUwZoMbMedBBkLJlBwuGtz/P4MI+7bET
	 n1JdMKryvpFtEQt2I4cqNgwz1mjqqH/kn4ppOpXQlVi203L+tqY1OgQcyc7e5aFVfKf/8
	 n3UymSTfKiozSPOIdD3lWEg+4ADv+g2AtlLdP2lsl3VmWNE4wFPGaTxixnTAJ3UOErgUB
	 2P4o13Y9ggOthW2oSzmqdGIfV1cL89wyd8TGBQ9W1WZNIGN9UBcGZh3cw8LnUAaYKOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384439;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fTFqFe33sWuG4oVgvv3FHCshoq1fMcluiyt2XIknOEg=;
	b=hPCXuoQXI2mwIHpjO2YkMy4FiTbxv6ZFygeIE1IHXUD1iAHNQHeB/yHCrkHBaUi17/Fv
	 XG2LjumBcvrXknd/bpEglsG7bLXZneLnOd562BMtupqOPgvRGF04J4D/Q5jYnSHpZzsyS
	 T1ZEcwVNZd9D3iTN1jAd+wIzugj1jAztVkMsb9S5Fu9lmk99CmojSBUFiR3+jQiWNjUGj
	 X0d54IQElKwHFi28hqig6UbvDf3PkPQv/yg0GJM2DL1kPjHE0zkbVxxKr5r5vISez7pNx
	 UssT/xHnrZ2aerwrdmRprssu0kL4KXBpZWOzOXabOY16CgAbqBo2e5P3quULsvv9Ijg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d8DBTodk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OujGsPCn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6121606A338
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6121606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d8DBTodk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OujGsPCn
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KExB863510
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fTFqFe33sWuG4oVgvv3FHC
	shoq1fMcluiyt2XIknOEg=; b=d8DBTodkOGrbjOV4mUIoJT30wKpjBx/cLjjpyk
	+f5zH3y0vzKwt60Mu1YKvEK8jFpm58nvZYwTOKDE+4LK8htVwg40ZztLsjxff2ue
	s6DOIlJpXtKULGKceuKYh30YAlehthqlk/um8rH71vfVkEezXW1HNBNLEthdlnPm
	xcN1b1qjaPfClG4SCsQc8iXy2+hgJbcKwH2d8io2DXrv79Z+UiHBjrEZz5lkl7Cf
	drgdndICMgz7mS+ZuXg86fO8uFN6ca9qShCgXZKtbyyg/wvRsxlEm0Htk5ZETtcz
	J3v7vubjAa3F5gHUXq8xmgsIA6jLmZnU2D3U18sCebuYKsqQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawh5yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:07:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36ecd5db581so5159701eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794384437; x=1794989237; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fTFqFe33sWuG4oVgvv3FHCshoq1fMcluiyt2XIknOEg=;
        b=OujGsPCn1vdyCUmON9Mea7aGSgBUcw3VAs+2J9h4Ai0A80AP29frDm9ynYlyESHq9G
         jhLylwRSFyXIcHSk28xAh0Kc4GjnQvMcM83wZctqly1es4R7WPfqLuFNuj/YpOVABoxN
         G2Ky/YRv9dReUFg37IMVoegLbm5SXWuPoVlwsVDzfTSnNBmzhBL6erhk6xU1b4UXHIGB
         v+NkRhCMQ1ueCikAdj7FXEgkmPPkNssMH3bmqbrJUDOpfovIt98l2ch+ghIiNelTCi8D
         6ftj4H61sdhK1NBuomxtBtB8HDWDBXjb3D4tOd6Lik0mg4ZiTSemtuXuJyZFOnL5CZ3j
         kgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794384437; x=1794989237;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fTFqFe33sWuG4oVgvv3FHCshoq1fMcluiyt2XIknOEg=;
        b=Un6yqWcego6org6EjlQ4TCy/I6iU61wBIRkZKSAFTzyMUuNbAkRBcG8Poew2v5BU/L
         0T+Ftnj65uaejLE3DFj9CQqBEZaU9RrfJfL8YDabGJjNz9LcUbtrFa5pcFRw2wwJuwTt
         2sGlPpAhUY3uJRM5kMmhxwmFfn3t1auNrLqaChl/mRU3soJ1XnzcZXWu3OPSSzl6jqaB
         1Xvuop5iVZO5DTA1rflsh6jmV83NSWH0Z7Jsg7bP4cgms13jxfX3vZnqHreXb9PdelHd
         kQxFUpUkJAsTvv/N8VS0ipSEYRUeOsRr9iaHwnharU6QZmUnnyU8Q/QsdT0niHDJP8NN
         hhCA==
X-Gm-Message-State: APuU4Z9g8xDL20l+05bHDx4s4ee3h9K8UU6QJjHSTFEFa143yAb7nWfA
	JX8aLi6MHCyToOKg3cP5uetsPvMQUJTk5F7WK2Iu6WI+eG8lYzlMnug0xtJz+kkxiZ2qIBrsUla
	6/FZ6e59DNWrhDqsrxBAH/C4zIYECREos2SYhsH0n6ke+WtDFdLJfwG3SBnIpxZO4EkM=
X-Gm-Gg: AYBFou3H0Oipbrw+pk6KyG9Cgf7qqatfd+7YtVlKBuYrGAnTxccv1TWutyaC/A25npW
	a8GUF2j0bvLMWzs6ICAY38jJaBDWjMTfexeaIGQDN4JPmsnCLDSduvHg/remCe2REk4Scw7ySD5
	mhmpY0EsHOWsxDvffPe3btHDgYu0gwkpDbXU46jSTC7hudXucpc+Y2toVn4l/fJYOQC2Llnv5Vr
	bePfq/jGuNK/a0mjUv+h/p+hv/9gB0r5nbEaMDgYahEoI0bK8cGuW/Krp77rCiV0NlAH5doGElg
	Kh5eH7kGq3v/t0ERy8UNRpxeD8gLaFtfaSJ/WmL8GtqXBSpdhyK9+xp2qnjyoHIOo1/83OQ0InD
	9YylUUDSMJDxBoF0baVdhREb5xIFvY+Fzv4BYwer9rwe4zWv2tk8O3g7D2kgYZ+/jv8hMD3j9tE
	puPqEShXeKQsoyHtp74RB8t4wDO6G4Pmna
X-Received: by 2002:a05:693c:8954:20b0:36e:53bc:4681 with SMTP id 5a478bee46e88-37687213eefmr2204245eec.37.1794384436887;
        Wed, 11 Nov 2026 00:07:16 -0800 (PST)
X-Received: by 2002:a05:693c:8954:20b0:36e:53bc:4681 with SMTP id 5a478bee46e88-37687213eefmr2204233eec.37.1794384436424;
        Wed, 11 Nov 2026 00:07:16 -0800 (PST)
Received: from alfred-sh01-lnx.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512b6asm12733263eec.10.2026.11.11.00.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 00:07:15 -0800 (PST)
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 16:07:10 +0800
Subject: [PATCH net-next v2] net: phy: aquantia: Poll global status
 register for provision ID
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-aquantia-poll-global-status-register-v2-1-b602fc7e80a9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC0i9GoC/42OUQ6CMBBEr2L22yWlakP98h7GjwIr1NQWu4VgD
 He34AXMJptMZmfefoApWmI47z4QabJsg89C7nfQ9MZ3hLbNGqSQSmh5QPMajU/W4BCcw86F2jj
 kZNLIGKmznChiW2mlzFHRSbWQq4ZIdztvmCt4SuhpTnD7OTzWD2rSSllv+1wR4nv7aCq3xAovh
 dT/wacSS6xEHl3Jozm0l8Bc5KRrwvNZ5AW3ZVm++cEQu/sAAAA=
X-Change-ID: 20260923-aquantia-poll-global-status-register-d8966a46e56d
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>,
        Hongmei Xu <hongmei.xu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794384433; l=3635;
 i=hongmei.xu@oss.qualcomm.com; s=20260917; h=from:subject:message-id;
 bh=CXDq6tmjkOW3HYr8JFux4YYxO60qWfpgAK5Zd4KXNa8=;
 b=KFS/WoxPBcGDavqYC29OJuFMh2HX/6VTMIhiEkJDmTXdXfFnO9AQ6JbYOuvyIG4zbukQuvECi
 UujVa3i1BTxCYVc4wPRrV7h7h84nsXTlDmARYizB3r3gGCKI0ZWlx7W
X-Developer-Key: i=hongmei.xu@oss.qualcomm.com; a=ed25519;
 pk=8J3IzbyuOOHSwLvktng8AEQIdStEQDAGNCSOlkASmk4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMiBTYWx0ZWRfX0qWVi4Q6ubEb
 MUtxBmbCm5CZxIA4s7oBl3w2GXxkJZaAjUJT+iqoQvngu1l8TQQlDbND4SXpXlnVT3PlzjKo9KX
 Tad8LoCRzmP9VemMWbtzqMlIwfuTT7E=
X-Proofpoint-ORIG-GUID: l6qO7J7soXatsYEYh_0k99mMPS3JA2Fl
X-Proofpoint-GUID: l6qO7J7soXatsYEYh_0k99mMPS3JA2Fl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMiBTYWx0ZWRfX5Aan4IGRVyH3
 mSeNKVm6xY8cYjdm3J0mP6T1p5bDonv4NpI33zRG9YFFeLITeNQJeBkcoMqGc6dPsVd3OxHP+jN
 SDFVAJLfqEKz4Lh6034ul9HmXBRNiC8U7Q9P29ujgA/c2hIAe07nmugmiJYt0HELBPgwdnt8wK7
 3ix0FEQRmH/NcmsO4TG2td2az3qKqLyG19Cpu7XsM9e07f25xEdH0pA05zgjRUbPFqxZwk+QZBt
 iAFscYH+KMaEpUSmF1YwN9JBirq5GJtiJMKlSdsutiM5lfobPnQcVy35s6/lY2szzl8m43VhoNv
 2wliIMOzU7dKkpdbDHNKf/4It1ZzRFysNs447oYTlMxd7S3MzhxL4FEpY8hjCF19aIMjGfkrgh9
 Y27mft2sqexHYauCG6X/pDY+sOrWmRSgqDUsbT7gNgYFaGEyvbJTHvxNc7Gxc5MNIoSxRmuzsVW
 n++Kp69C3N7djYPn4ww==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af42235 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=bE3ElnuJEPo-UkmYN9QA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110032

According to the AQR113 PHY databook, after firmware reset, a 20ms
timer needs to be engaged to allow the supplies to settle prior to
allowing the PHY to boot. The working flow is:
  -After the 20 ms timer has completed, hardware state machines
   designed to guarantee PLL and band-gap stability engage.
  -After the PLLs and band-gap are locked and functioning properly,
   the processor and digital circuitry are released from reset.
  -The PHY image is then loaded through MDIO boot-load and the
   processor boots.
  -After the processor boots, any provisioned register values are
   set, and the PHY enters the provisioned operating state.

Starting subsequent firmware operations before the provision ID is
valid leads to steady link failures; this has been observed during
AQR113 PHY bring-up.

Also the provisioning ID is a component of the firmware fingerprint
used to identify the host interface mode for PHYs like AQR412C. When
such a PHY is provisioned with MUSX firmware, the fingerprint
determines whether the host interface should be reported as 10G-QXGMII
rather than USXGMII. Without a valid provisioning ID, the fingerprint
cannot be correctly built, making USXGMII and 10G-QXGMII
indistinguishable and potentially causing an interface mismatch.

Poll VEND1_GLOBAL_RSVD_STAT1 until the provision ID field is non-zero
before returning from aqr_wait_reset_complete(). A timeout indicates
a hardware-level provisioning failure that software cannot remediate;
the warning is logged to flag the hardware problem, but probe is not
failed since not all PHYs require a valid provision ID.

Co-developed-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Signed-off-by: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
---
Changes in v2:
- Change the log when provisioning ID poll times out to hint the
  mode mismatch possibility
- Update commit message to describe the AQR113 databook boot sequence
  and explain why polling PROV_ID is necessary
- Update commit message to explain that timeout prevents fingerprint
  construction for PHYs like AQR412C with MUSX firmware which in a result cause mode mismatch
- Link to v1: https://patch.msgid.link/20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com
---
 drivers/net/phy/aquantia/aquantia_main.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..bed891cfaaa1 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -702,7 +702,23 @@ int aqr_wait_reset_complete(struct phy_device *phydev)
 		return val;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(phy_read_mmd, val,
+				val < 0 ||
+				FIELD_GET(VEND1_GLOBAL_RSVD_STAT1_PROV_ID, val),
+				AQR_FW_WAIT_SLEEP_US, AQR_FW_WAIT_TIMEOUT_US,
+				false, phydev, MDIO_MMD_VEND1,
+				VEND1_GLOBAL_RSVD_STAT1);
+	if (val < 0)
+		phydev_warn(phydev, "Failed to read VEND1_GLOBAL_RSVD_STAT1: %pe\n",
+			    ERR_PTR(val));
+	else if (ret)
+		phydev_warn(phydev, "Firmware provisioning ID not ready; "
+			    "interface mode detection may be incorrect\n");
+
+	return 0;
 }
 
 static int aqr_build_fingerprint(struct phy_device *phydev)

---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260923-aquantia-poll-global-status-register-d8966a46e56d

Best regards,
--  
Hongmei Xu <hongmei.xu@oss.qualcomm.com>

