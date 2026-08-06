Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABB439F90
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027130; cv=none; b=Wc5GWEnWXUbOrenPUjWEJd3i0QXe7LeWblIyyysvLiAuTKk1sDbDn29KsR1pNYbDsj5LGyQwdPff/dMVi58gXzVWbchMFgS+zJjBcZDKdtoPGN7UBYQFElUoL/3uTbmPFjQN0gMF4zzWXrdmJWwm8wLhvlXuYvgCN1BUutIUZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027130; c=relaxed/simple;
	bh=Dbcp21AtdduzCnfwtnGpBRqMSrLBUlOfVvNlXE8wpqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oZaP2GU3RqX5HuTCuMa8+koCR6XxAPLjr0joi38UB/ftTx03804AkypKelKw//glwuAuxJABxW/5R3XQT1dTXAlZS4djihNDIWs4ffz3Ukt+qRazlwDkJUToyWThuw6MgnQ2JWj9Le92QGmscnCbshnLHu9xUuzkf38w/iHFhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjcgnDjD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f2aQZR3P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjcgnDjD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f2aQZR3P"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhiO1876524
	for <netdev@vger.kernel.org>; Thu, 6 Aug 2026 14:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KOatdI4aMcMRWWupN6j4vS
	QEII+iBiMgRDvmtcwV5UU=; b=RjcgnDjD7rXq621tdLNp0nqLSaOMdz6o3MPcdI
	Iuf3My0+UGmRS0A4DFicF4P4snOzYSW0fBws4JUV2NJth8tRFHcIxyWSaeydEykc
	Wz/cur26D/Ti8Aa3LQfw6c/W9zoNs8QAFIo+8Us5gXXlnK02aH+yLhr+XsjjuxDC
	oqLtmB11Y+SW3b2MndVmlYfAT8IfSsclYbF0qnth7S8rJhu47aM6975plUxNqXhP
	DpxZz+/Bfz1zLXjHWcvQmNWnklmOyh/MTR4+UzaSoeELtG04uqDbfjmFE8wJy8BP
	FLAP+/gwUz9Aomz4qxaTptDyyVgv+pYEWEN5IEY0mVhr9Hmg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjucjqgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 14:38:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c19493ac2so25444401cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027127; x=1786631927; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KOatdI4aMcMRWWupN6j4vSQEII+iBiMgRDvmtcwV5UU=;
        b=f2aQZR3PCMJyogteoDG8Y0sYSPKqkLmkmJJoXss81ze9QmhdeCQjLoqLJFszR+Z8Dz
         vaaGoBEB/6RdNMazB9b8gOL8hQL83lRgLeNumf57nSWWBqHip/zirGGska+fw0QNHwA8
         qF6BpxpltYgoM6uuAYr3WA9LQ5V4l+qBgnKhDp4oVjmJsZrpoNvhRsMakL9SMWr+UQHi
         LVVyGN9tesZgyTkUGU5nMFiWVIW8qRKSHtvt4bd1iN/uP2Bq5rjJ0wV2eBWW4DJRqKt1
         Oa97ixZcaEE68iwW36t5S8zy1BerYeJZUQj2zvSst3MTpeCMkkbHQiM0Zy2UvepWhaL6
         DFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027127; x=1786631927;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KOatdI4aMcMRWWupN6j4vSQEII+iBiMgRDvmtcwV5UU=;
        b=CLZyXgrcIInLDeKsdPwYjYyUcGs/8LE2XuYXUlk3d6b2E6XLl/5V7M1EvNgZKud13E
         pAfaU7+QoM/jXY+DaIFilrmefJ8gxJUMfzOvwZcO7T+a8jS7f1PTlDseuWbgxmUYVMva
         Nk3QtJleZO6eaeADcSgekTfM4qRNKnVk/MNNRU9dvMh3MZVEnJs47zJ1fjh2Kw1d59Er
         oeZa2n1Q9EVU8KrYASv8tO0r8YK5YlIzA7t/hREIfHvtTlX8l1rir80k6AwaBAz4A/u2
         zex/W1nak5OlfpkRnSkSwvhMXyJJVBYnlgXLe29fap5/6prP1/B7rQn67N8FnWzsYCuD
         VPGg==
X-Forwarded-Encrypted: i=1; AHgh+RqKZewoaOW7x7ay1Y3D1lLdvIQ/uBSFTDcyhhg53JfnkiLbELcd/oJOGvjzdzjP0rPD5tRLRBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4iUl0u5ZNcQD3J2TU86tDOryYyzXPIuHBySj21mOEA74Swb0
	CfjhnizYdta4Tp2gUcyQ8SqL57kkouGG43NQJ36hKRWUmRahAAXYC71OTcq61ZudbW7zhy0BQZ2
	aTKnhsOUcvrx4sHRvBlAo5SGakxxzrar+zr1sRooanTe9wjrE20ie2CjISTOnuQggzE9hnQ==
X-Gm-Gg: AR+sD10vbG2G0zgaWtfMtjkASXsgJQn1GuFaDTSluCmdhEFekoMs8/Iyst5iHCrxfy+
	sUktgXErLu5JtQkIyzOBTYF6G3w/8E+J7bUDjUo9XSAlMgSilSw485LG7I8MvwcnODfvCMXw5Pk
	A9yST+ahuk6GPShrXwvsFnbo40j1rmFoTXFOTSxEB4XgjQ9r+YcIIlmowWzb3C0s2r7LDAstxr9
	S8p1Ci6lLrAkXpAGr9kLov5aOV3YaSdpW4IJl0tug1W29aluO1Xmtc977mvOuE/Emh9MPeZReg2
	OTwLEvKxPuzs2rgmBS+7OcXtY2qDCDdcUKbInxbluhiPpXbtmGo+e8nZQyVhW+9oFnMJpy9p1GJ
	xZZSr7lI+jtfgzuhkdI4rLYWdxqyB7T0tvLD2S/af/CmG0Z4zwJP6+Tnp5CXaNdt5P6HbHVNzIn
	2l+VLfFUZkT7QdEr9wbT3gRYx7Ea9eJqBTrAmUhELiOpazSfZRFg==
X-Received: by 2002:a05:622a:13c9:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52ce5f44c7dmr149088891cf.5.1786027125958;
        Thu, 06 Aug 2026 07:38:45 -0700 (PDT)
X-Received: by 2002:a05:622a:13c9:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-52ce5f44c7dmr149087731cf.5.1786027125394;
        Thu, 06 Aug 2026 07:38:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v10 00/10] Support for block device NVMEM providers
Date: Thu, 06 Aug 2026 16:38:33 +0200
Message-Id: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGmcdGoC/3XRzU7DMAwA4FdBOZPJcf458R6IQ9I4rGJdoYEKN
 O3dSXdZpZCLJVvK559cWKFlpMKeHi5soXUs43yuiYDHBzYcw/mN+JhqgSGgAYWOx9M8vPNQ+Hm
 daOIqSnDkYgo+sProY6E8/tzEl9eaH8fyNS+/twar2KpdahUcuAkJJVktPITnuZTD53c4DfM0H
 Wpgm7jiXdFgGwWrErOwlJIWUlFHkXfFQDuLrIpD40TWEILUHUXtFd8oqipKW4FkIuJgOoreKQI
 bRVfFa4J66pyzh45idgq2s5iqZMB6kzQkZVJHsXfFgmgUWxWZySFoyhBcR3F7RTaK2zZygSTGP
 Cjf+2m/UyQ0it82suildsKmmP9RrtfrH1naay/kAgAA
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX1KwQq+YVxzQT
 jj2t/cYY+E9c1hPR37xfi67FKIcPISP5VZUtBYhcinbiM7PyoeK2sb8RSVEEA5I366rfFs4TfMG
 bQMQEDzF/uI2GMEeKNuRv+aRZCBeEos=
X-Proofpoint-GUID: f7I1xc6GAsP8CXHgrSlHmKzFZTtrpnoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX2kXJD5OQpWKa
 +isJA/Mdvvov2wO6SD/sFHPKp4GrzvVbTf6Qs2kuTuVN8L2EzYh0K8zkrIaF3KTXPF4HmyDH+Jg
 8AuAjgt4CrDDs6JmurABZ0yhXYd3TRNDlScUSoHBTwQdgm3Uw5wQxGO7p/BGzf8xplP6n00RYTc
 JC9Ve/swNCDYoBSm2o6Jwd699VN3Kpfnv000YztvSETe7TvEFvC2zRym24GATZpGy3INHcyDJfK
 QY3pF6gOtomqe14Gr+dwUge8LuOrfxDz3t8PTDRlDd/SKT1zaHsmQxsueccodwUulZpuy+LIldC
 dI9ypu1N2BZU9qcC+oKW+zE8Q4bOQaEFmkh/49bvTpGxlaXWvTWkl2iZ0100aT54RyXIFPELp0C
 sLKsqHfd3/WjNz8mEQs4tHLzYNwEpk5Xh7GIUwEk62igSYE3XCYpAaOc7ajK5vT/X0+YX6VmozA
 ojrNAWFJRZ8CidAYW9g==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a749c77 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=tqjjm0btxrnhZIKebqcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: f7I1xc6GAsP8CXHgrSlHmKzFZTtrpnoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060114

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v10:
- block/blk-nvmem: simplify read error handling (Christoph)
- block/blk-nvmem: verify dev_t wasn't reassigned before reading (sashiko)
- block/blk-nvmem: drop __free() cleanup for explicit of_node_put() (Christoph)
- block/blk-nvmem: init static nvmem_config fields at declaration (Christoph)
- block/partitions/of: fix fwnode ref leak on skip/abort/error paths (sashiko)
- Link to v9: https://lore.kernel.org/r/20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com

Changes in v9:
- Add nvmem support for partition blocks, not only disk (Christoph)
- Prevent concurrent exclusive access to the block device on read (Christoph)
- Add comment about nvmem being a side channel for block device access (Christoph)
- Link to v8: https://lore.kernel.org/r/20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com

Changes in v8:
- block: Fix bdev->bd_nvmem on registering failure (sashiko)
- net: of_net: of_get_nvmem_eui48() now also rejects all-ones cells (sashiko)
- Bluetooth: mgmt: account for HCI_QUIRK_USE_BDADDR_NVMEM in
  is_configured() and get_missing_options() (sashiko)
- Reword blk-nvmem KCONFIG help text to satisfy checkpatch
- Link to v7: https://lore.kernel.org/r/20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com

Changes in v7:
- Rework bindings/dts so that the eMMC boot partition can be a nvmem fixed-layout
  and not a child of fixed-partition. (Rob)
- Add Support for fixed-layout as the nvmem device node itself
- Remove "block: partitions: of: Skip child nodes without reg property"
  This is no more required in this series and will be submitted separately (Rob)
- Add missing linux/cleanup.h and linux/device.h includes (Bartosz)
- simplify nvmem_register() error path using dev_err_probe() (Bartosz)
- nvmem_device forward declaration to blk_types.h (Bartosz)
- Add hci_dev_get_bd_addr_from_nvmem() kernel-doc for return value (Piotr)
- Link to v6: https://lore.kernel.org/r/20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com

Changes in v6:
- blk_nvmem_add() returns int, error properly propagated (Bartosz)
- Redundant if (bdev->bd_nvmem) guard removed in blk_nvmem_del() (Bartosz)
- Size guard changed from UINT_MAX → INT_MAX to avoid signed overflow in config.size (sashiko)
- BLK_OPEN_RESTRICT_WRITES removed from blk_nvmem_reg_read() (sashiko)
- Link to v5: https://lore.kernel.org/r/20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com

Changes in v5:
- Fixed ath10k binding issue + extended commit message (Krzysztof)
- Moved blk-nvmem handling to block core instead of a class_interface
  This allows correct/robust integration with block device life cycle (Bartosz).
- block: partitions: of: Skip child nodes without reg property (sashiko)
- Link to v4: https://lore.kernel.org/r/20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com

Changes in v4:
- Fix squash issue (dts commit incorrectly squashed) (Konrad)
- Use devres for nvmem resources (Bartosz)
- use __free() destructor helper when possible (Bartosz)
- Fix value return checking for bdev_file_open_by_dev
- Link to v3: https://lore.kernel.org/r/20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com

Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Loic Poulain (10):
      dt-bindings: mmc: Document fixed-layout NVMEM provider support
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      nvmem: layouts: Support fixed-layout as the nvmem device node itself
      block: partitions: of: Attach partition fwnode to the block device
      block: implement NVMEM provider
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Add NVMEM layout for WiFi/BT

 .../devicetree/bindings/mmc/mmc-card.yaml          |  23 ++++-
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  32 ++++++
 block/Kconfig                                      |  11 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 112 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 block/partitions/check.h                           |   1 +
 block/partitions/core.c                            |  25 ++++-
 block/partitions/of.c                              |   3 +
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/layouts.c                            |  13 ++-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/bluetooth/mgmt.c                               |   6 +-
 net/core/of_net.c                                  |  52 +++++++---
 20 files changed, 370 insertions(+), 21 deletions(-)
---
base-commit: 5174c725cd98c717af2a4fabb7615a11b3ab4b9f
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

