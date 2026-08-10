Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82F2E738C
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786322580; cv=none; b=uGVSicCdsiKgRtYPt0E7wsodtxQjIbKUKEmDkH9KWo1MRJz6YpKk9q645Tbt0gCLUT22O8tVWx8qq53JO0eqYzhNndWd+n9Nr2cgKZ7B39iJJ/teIGh2joV0gOBWFHKG1BphEqRolnLUBxGzuPEZHl1hiqiuUs1mz/tTSH8mK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786322580; c=relaxed/simple;
	bh=K0xhdbcV8f15MrEXmfkAVzMxkKUqSFfeUX+zbSfJSTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3d3uZ0pJj5nsCOlre6BgcDikt5n4bUWcBz2RYihtbnueQpcObpS5Payj/fuXbqQ2f24aZf5IZJa1vzOQyADwBq7uB5cw6NsiiWqoV4ifw/8waN0ZH87HFaVSvaYa4q4xxRUl0QQ+2svEfSgHtfcxdA3FdOUzQ/iPaYur8gdTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEgCORZK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyJ/Vd5I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEgCORZK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyJ/Vd5I"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679L6j2Q4105757
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G1l3MDiShpxrow6PKyv8R7IwJ5NHEgCniW/t6VXsK64=; b=CEgCORZKvRKFQZBH
	g2Wf62rT1DEbr4Kv9mqHjh0EdyEzvEx5VfKqDy+fgnwMQDx4sD8b0f32/Lx5oOSd
	jlz0ooHgq8QsHxIwixmGXD78hnZaWw9OxbopUuObz/rSj6F2bTNR/10hWkQg9cx3
	48LUXfk97ZWJowI/X/nsygpkEa9OEZ2EfCEUSrcVsFqbWJLzwNMB+2oPE+8DWflc
	m7BJu2b88CDGjLZJQ0QrDAa3Bilwn7CQy4jfEcCzlHXZlVHdYL4GVKtRGzyQwQPV
	lDkAV0v/TndZ3OXv35BbBA5HmulifUPG8hv3N70A6dtwBVZNH7wER3C5VpX32Hnr
	ZJPnPQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bwgn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 00:42:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so25727591cf.2
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 17:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786322577; x=1786927377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G1l3MDiShpxrow6PKyv8R7IwJ5NHEgCniW/t6VXsK64=;
        b=CyJ/Vd5I1jXO2sFnO/PW3soE41A5pNa7mO3cLqDh3gCmBJ/4SrxFOgDQ9UInPISwse
         olIcP0+gyvbAsZUC/82wPrpmm5i9C4b4KllNpMfFA5O24LQjl2dBZDlZEPV0qHMZhrar
         InTgKBDIf/DTcarzY1Maew5n/cYA9D918MfNEOuoKD39FzImWbzw6Cgr0j5OB8qcq+Cw
         AF8Ipb3ZX5c44L8HOtekWxsW6H3c0nwm/hWvbY88VDl9vGFCT2GJD5itm4gL2Hai04Qx
         qbmPpWTQhKxtFmvYVKusok13Ho8uMqX6AjFm8lh2KMWeBSU0UpkIAqadQyffHqIIiTwI
         vYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786322577; x=1786927377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1l3MDiShpxrow6PKyv8R7IwJ5NHEgCniW/t6VXsK64=;
        b=GQZ2Ju6a9TPvsl6JnMX0HXB+990oFgPtyd98qJnFR7fh6XsQJaqZKdREruhNFVx6Ag
         reOToVcLd5s9EST1liYo64OruU1PEok6gOwDz5c9882Tk8wTnEppiRp2OkqnH9UWwYbY
         b6pg5kZxeNb5ik9o3ou/EWuLUbvJvUGOZFQHVj93TG6pqDt2ALFCaeV7385t7TvnVlQ+
         xFNmWIGsyXADOcrjKF2SrJSzUvJd26upsAFRx/A2wPfN7ERSHqf8YDrdncUnX8tTDQ1B
         BkMmOmB1fbltNMhXTlEvYwpsw/TdiRpoKVvArL6v7r2DPXY3YQJIzwPEdGWLCKED1kJM
         wBtA==
X-Forwarded-Encrypted: i=1; AHgh+RrRtP791DUalTr1Tjm2aNuMj74Jle4bNKsSNjh/KB/NSjLHwdW574XDcDopV1Ylppfc+SBKwLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWi7sLo7mf79Kd3AKohmdbodTP9Cz6b7DajOPDZ0/oSbkjiYf
	Guw8BF8k1nJzItxpUPqnaNzVjdQgt+SZ9rhxcD+M2cSsB9fjjiYvyFVo4e889OSPHeg75MJbsOt
	qpoLphMm37/opBvPRpfItqcUe/AspA8883BY0SfUVGtuxT4EY/2c4v4T/D1w=
X-Gm-Gg: AR+sD12WpA9fLxFKfWTAhxvPwwEvnH6zqCt0Jf7l774+1/uNNdkGALl84HA9qUkgz26
	4Xdavsbpu4TVeSYDv0o3dBVfqMCK/E9to5tHd0L8RqP3cyZ9U8KYx5/uHW/eYlR0/FWLimT0uZO
	NaA4+42myeImoo3ypzo0PR5WhS5s+31OXuaOrpgp0pUVcu41yZn0/VzdH/cKiDNKzAkR1/CbN9Z
	/ImGwNQutuZg7iEhYEspceuOrNfyVXg8XB1iSS6V5fBrkR65UTUilQDXMDdGsagWCBPD6a4JRrj
	VukFpebae8zCrKdLA5qUCancx9GUaQ2MKaI3TEvR8gJXghjE6bj0kxp2dI3gYaF7raP3n0f+yRh
	LXoQakZBDABZy2pMhoWsUMw0buPt2SxHK9ypk5DtpFh0HVFfOXk1gvZTGDKZbq1jP1KyjZX/mm9
	Q3HyPrNAN9eG5AlA==
X-Received: by 2002:ac8:5a87:0:b0:51c:51e:661c with SMTP id d75a77b69052e-52d0b19318bmr258978541cf.25.1786322577127;
        Sun, 09 Aug 2026 17:42:57 -0700 (PDT)
X-Received: by 2002:ac8:5a87:0:b0:51c:51e:661c with SMTP id d75a77b69052e-52d0b19318bmr258978291cf.25.1786322576788;
        Sun, 09 Aug 2026 17:42:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3d56sm1679742e87.69.2026.08.09.17.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 17:42:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 03:42:36 +0300
Subject: [PATCH 5/8] usb: misc: onboard_usb_dev: add support for the TI
 TUSB8040A hub
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-msm8974-onboard-usb-v1-5-08a805768328@oss.qualcomm.com>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
In-Reply-To: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=K0xhdbcV8f15MrEXmfkAVzMxkKUqSFfeUX+zbSfJSTk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeR58D/ndfRsy95/9gP2EdtFp/W1Wokjyw9hwc
 eQbWAQCTeSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCankefAAKCRCLPIo+Aiko
 1XgHB/9DDtbPLcGqnEyBGrxSqBkCPLRNfWX2GseAa0TGoWXsjpyyzl6iynlV9FHfVFVlmogGao9
 1OKHc/ouTkPAUsv2raM9104FMeffu76Ue0OrJEbLsiUGDVvfJnwUbjttQfnI0jDYCu6QQD6Vk84
 4YN1qnDIT2xHboTnzxBuy7RyWcmma7aGiS6+bfu2cEx84pwmOWI3oR+OjnGWmMhwKfVLYqXnPTh
 iCIKBm+XA5p2y54olnBifJRduAaCm0MeZ5RQ2QWvOrVyqB4+UkCTN3O1o/ExGyj3wA5tTNr1Tl+
 fCZoQZ+lYJbVFVDobdG/cLSnMAvX6GOuqtVwr1ZVyJQXVQqx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX/fscNncrDDeN
 eRuYhat9IWsZ6OIyEDTzhSMwUCL/u+oJCRhl4nqLd20s5/Axzj4yaoclEGrqV0Or/9XykZCB8mh
 hdkLAED9xpeLTVUv6zT9ot66qtz9kXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAwMyBTYWx0ZWRfX9PU5L+g5QuH6
 Wfcii1eG01+DxAImO1liQz4zOSHdy9j4hrvMkQ34tzTQ6IOgzAw8XuzOmPkSYqwJ38e9K7lLy0f
 keBsXeEBs88j6LQ0IFyGgOqwQzzrEqvMQTLW2BPX0GbxSRKKEjhvMHiLAnVHvQPmKR173deSzsM
 aJ+qDJ1W5N4YydB+CckB/S47zkWv0ELV1AK2QKgJtAN46LVVYF5VpEvoWg3v/D6Ji6cOPaxnQCc
 lKRvxzdDAA4NLEkHr25n5h4Fc+vFo5aR3w4n/oCIPpxGIGYWI7GCdwM0IbGZqVNdbgYTY+PZisM
 JuYNwP5+Z5ERJ2lMMNPM3e5h9BkYv2gs+6nNBCQEkdC5oYuoMHV1H3eovPaSvzi/ZJvnPlfhdhn
 vgVdcqUBosIwUuksVJ2XelgHH5GKBN0jTOT0x/E/TwzVqqp6FBE3BFbp57BnEOLrD/BupVlWXab
 t13VHgbbHrvEmZn6YTw==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a791e91 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=9pHVgPPIkr9paJOtTCMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: OlKHRu5PPkKkz8G9V61OEHfsm4aiCGFY
X-Proofpoint-GUID: OlKHRu5PPkKkz8G9V61OEHfsm4aiCGFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100003

The TI TUSB8040A four-port USB 3.0 hub has no onboard-usb-dev support,
so its reset GPIO and power supply cannot be managed by the kernel.

Add the device IDs, reusing the TUSB8020B platform data: the power-on
and reset timings match. Cover both the datasheet default product IDs
(0451:8040 / 0451:8042) and the EEPROM-overridden 0451:8041 /
0451:8043 pair used e.g. on the APQ8074 Dragonboard.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/usb/misc/onboard_usb_dev.c | 4 ++++
 drivers/usb/misc/onboard_usb_dev.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 11508ed4df25..37ebbccce35b 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -681,6 +681,10 @@ static const struct usb_device_id onboard_dev_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_TERMINUS, 0x0101) }, /* Terminus FE1.1s 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8025) }, /* TI USB8020B 3.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8027) }, /* TI USB8020B 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8040) }, /* TI TUSB8040A 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8041) }, /* TI TUSB8040A 3.0 HUB (custom PID) */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8042) }, /* TI TUSB8040A 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_TI, 0x8043) }, /* TI TUSB8040A 2.0 HUB (custom PID) */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_TI, 0x8440) }, /* TI USB8044 3.0 HUB */
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index 3523f8f8a149..7961b9ffa99e 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -143,6 +143,10 @@ static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb424,5744", .data = &microchip_usb5744_data, },
 	{ .compatible = "usb451,8025", .data = &ti_tusb8020b_data, },
 	{ .compatible = "usb451,8027", .data = &ti_tusb8020b_data, },
+	{ .compatible = "usb451,8040", .data = &ti_tusb8020b_data, },
+	{ .compatible = "usb451,8041", .data = &ti_tusb8020b_data, },
+	{ .compatible = "usb451,8042", .data = &ti_tusb8020b_data, },
+	{ .compatible = "usb451,8043", .data = &ti_tusb8020b_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8020b_data, },
 	{ .compatible = "usb451,8142", .data = &ti_tusb8020b_data, },
 	{ .compatible = "usb451,8440", .data = &ti_tusb8020b_data, },

-- 
2.47.3

