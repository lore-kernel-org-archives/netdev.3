Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354447C0F3
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628922; cv=none; b=Jg9yBr/474keUwp4dtDUvtwsphYfPaxCSw8M1vq/YDY2QIwpOIMaYqlsNmEIfWVa7vThpHwgFQNPr0+ORNIbxflYOXhXpNzdFCyRzWuhCSJxp2skQgQXb5rm6JHQo/1lPstArWgoHlzuNWumOW3aMsA9w4a5b7t+TgpTBZppxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628922; c=relaxed/simple;
	bh=fQRTehV8CGvInRDeTZfSW2KH/zmeYIa2G7vVDgqcZGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KejJCaRUA7Tvlyei1k6HYF6Isq3Re65GqFmVUy3LCqjL4r+FILoS4Gzv+bLNafifXXc30+eUTU9sM1UQLPY0NjZTg0/h1o1ZnaVITPvmXTXO5oji+a21ZVTi3KOywnPDlnorCQxDTKR58uQLGHiYE0eRdvO3gF135He7io9siWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpIgR1Ni; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQ91inPN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpIgR1Ni";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQ91inPN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60UWR1211709
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EucckBjq0ZAUvNX5HMtokHxW375byZlwFwCAHxjfgdA=; b=VpIgR1NiCpRlmKhi
	5gYrJOnz8dVlQUVKTR7VbO5aQi3F1v7JC+N08NDf0MqoQ86bohMeSVGY82q7RFi4
	oJgOlW1BkHX662DSsCp5220jJQ82QBws/6yduN2v/x/Qz22LMF3VxaCtKYtqW5ee
	7Zb/o9MuCiw3em4NzThvGOUq7kS7H6rL4BDzJjvgd9985fPJKF4hzQtWOWcLnpXC
	0RsPtZBV9WPQfjOU9Vxj1RzcwaF0PdpajZjU9MBMomjyp8wgaLIts0OC2cB92N54
	h+kUSEmedQp211e6RMiSpq1QucgWciBol17rtKlX22mCEuUwMYUsHpL6aeqKm0Qg
	9Mz5zA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxayb7xr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:38 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-80497c6ec88so950810a34.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789628918; x=1790233718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EucckBjq0ZAUvNX5HMtokHxW375byZlwFwCAHxjfgdA=;
        b=dQ91inPNFv5A7KA/V4x7cT6ZFTdxbrmaL7zmU6yhgOP14D0p8mvftHDeau2Hk7tn9G
         hhtN545IcHL9VoL+buaUYnHEwajJFjYHF1MOCk/Koedcdcc+lRZQdpGmPbscleIFFuom
         OrtYQcAWQkDNvHCYThws8zCvNmSmsalt5od41Fq7QSL5GUMdKWiKV4apjBw0UwIwD8qL
         kXYV0ElngmVROpg6YalSwXJum8zut7nliO1FOcZYv6U5YkogzLdz7Y0kSwMdRZSNP3PR
         pztt1DUzPKzM4cy3uM6MPunLiorvG9vjYghaF4ZDyEPPPeke1qCzNQyxNF/I+rNdv8Q6
         J4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628918; x=1790233718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EucckBjq0ZAUvNX5HMtokHxW375byZlwFwCAHxjfgdA=;
        b=Q9U95w7wM4rlZ+umdIZsYXaZfv8U7hFrWjp5+zY0mz2yHK4t/0ppabaphs2Y7HfP4L
         dEy0/UA5mIv/tlZ67wXZcilG7xMFPQ8/SZ8RbEjABexR1xK5VKZ+DdtYW3Rf4YAqDK5+
         1kSYGhNnW8pJUK0kB+aq2z1O6ogaENYZfptS1973nXilekukJZQmIoj2rRu9dhzdU0bI
         Pbo9Nl3WCQ8vokrQTkNcDhyQIf31KR+XSx0pIZwiBR20ByRnfX12kPCcCLJmm3ggryJh
         qGbw9vxvqVz5CKZopEQmG/KOWfP+Xly11IZmAjelWDLlE24MdNwIaHEMjhH7Yga61lDq
         jpSA==
X-Forwarded-Encrypted: i=1; AKwUvBxGVMAXECbzDr4DNBch4xGBHfSGDBY9sGvaKxaUsTiq47zWVoyADjowacg6PR3TmPHIRe5lsFA=@vger.kernel.org
X-Gm-Message-State: AFuF++ncuqNFYFskRqnbcC4BlguC7WDj8gycrnSFnoNA/BD0NhqfObGB
	jdEo8D+DCeI9UeMD9UYEQq/41+vdQLBTjRY0MPR1VQJLbhD6RmkKG5iuogRIzNID/VF5aEue3Jc
	DyNTS/U+Hl8CbHZyU+hhDvZ1qvxkViGjo02JyKKDfawxjV47S0AdfB1NDqsI=
X-Gm-Gg: AYBFou3foSS1kh9xr5NeyDsPPk/rZJLC1nj1RSZ5fZPm5c0YRGehSjU/adPNtgvYgjh
	GT4DzljOH/Oo0LRiZZ6PFKRJKbSPCFCoediFveqKVZtmjyXE4rVqRb0CApxkDO4ly0uFTk5wK2e
	KmLqerdOVgNUIT9Go0V/GGyUbUhNEL97i8q2gQMzI/MTFjV0xp3v3ooR6qVNiQ2VStl4YqwddNX
	UUVPAWIzhwgIKCJGXao3XwIuSrNVCbYBs240nxkiWIUZ6bvgO0Xv424vWyHPfZS3yS3842UjSF8
	9SfyZVgsadULc7vnSSbAcVTKnpET2uWq+NrVB29ISeyBRf4VXdTbbWFJ6RaplSfyKKSKfNvBtX3
	XQMDS6GZlxSYt246ECMywj3Ea7m7J0D+N9IY=
X-Received: by 2002:a05:6820:2010:b0:6be:47ed:f3f8 with SMTP id 006d021491bc7-6c7ce737ecdmr5130337eaf.0.1789628917600;
        Thu, 17 Sep 2026 00:08:37 -0700 (PDT)
X-Received: by 2002:a05:6820:2010:b0:6be:47ed:f3f8 with SMTP id 006d021491bc7-6c7ce737ecdmr5130313eaf.0.1789628917092;
        Thu, 17 Sep 2026 00:08:37 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm13280835eec.15.2026.09.17.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:08:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:38:03 +0530
Subject: [PATCH v3 2/6] bus: mhi: host: mhi_phc: Add support for PHC over
 MHI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-tsc_timesync-v3-2-6826d5d2d527@oss.qualcomm.com>
References: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
In-Reply-To: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628904; l=13466;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=fQRTehV8CGvInRDeTZfSW2KH/zmeYIa2G7vVDgqcZGA=;
 b=ai4fr621DQxotey/YzDMDhoijfLkFfHkg6p/sW6HCp1lk+b4/RJtcyzjD6NrVTlzj8EVSwR4S
 c1D3neTJoTkAf30dBHG/nyIeN/0tsQQD9saqnvo+3n6ACVnMCD4ALXG
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX8aZWh1ixYrTo
 TwAbXqEoxe2qhetIXPPdTRDI3VqnHLPrjWlbA3IKBqfTQUnFdR87KdS+yFHsiFnakzcCugEvkBS
 e8qALL6DA8fA4phkjGdF8CvD44Z7k/D6ggOXWqPZCL3KEaQtOJDv12fvNbB+jEh6rSgw1Sg++hR
 34NnDz1cU9Io5fc7tk2o+olJQcEh4Mj0va1EcHSJ38P7sako9Djiz4Dnq28m2M0QdUuPe7FTmlR
 TxQRgPkfKEOgFmaP29TEFAlyMRP9GnAA6A2rKrPwgcDvbx8+H6Xije+8Yzw9AGyyD+oM37BtoQL
 DheFK8wgawl1F/Imy+hnZuRfUTcm8StfCoNfATyvx9kBFG7FO95KvCyZ6QwtJ3a6Q1zAH/vNxfu
 L6e7sS+pRoQfpc8cKcKG3WZiIzE4s8H9GDgNLx8PN6wEbZKY+BM2Y/kSygbRvA5Ev9XJXCIgQVD
 T3RAq2Ut6g7595S6r4w==
X-Proofpoint-GUID: BMCZPrgO1ImsH2288RMuZvJDG3of9HTK
X-Authority-Analysis: v=2.4 cv=EoJHPicA c=1 sm=1 tr=0 ts=6aab91f6 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=nd-n_nVWBVQei7lK5GYA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BMCZPrgO1ImsH2288RMuZvJDG3of9HTK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX1xpEz4kOr7Fa
 8U+/pdYb4gkPymjUcpBb7QFVMeWXo64F88pd8d7LpooO+7a8vwvbw3n5vXIiyN0KO9gs6S+lObZ
 7hhyYio+TiFn7k7xzRCBNWueuCN7gJ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170094

Implement the non-posted time synchronization mechanism described in
section 5.1.1 of the MHI v1.2 specification and expose the device clock
as a PTP Hardware Clock.

Discover the TSC Timesync capability during MHI controller
initialization and use the capability offset to access the device TIME
registers. Register the PHC when the device enters mission mode and
unregister it when the device encounters a fatal error, enters a system
error state, or is removed.

When userspace requests a timestamp, keep the MHI device runtime-active
and bring it to the M0 state before accessing the device registers.
Capture system timestamps immediately before and after reading the
device timestamp, allowing userspace to correlate the host and device
clocks through the standard Linux PTP interface.

Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Co-developed-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h           |   4 +
 drivers/bus/mhi/host/Kconfig       |   9 +++
 drivers/bus/mhi/host/Makefile      |   2 +
 drivers/bus/mhi/host/init.c        |  33 ++++++++
 drivers/bus/mhi/host/internal.h    |  31 ++++++++
 drivers/bus/mhi/host/mhi_phc.c     | 154 +++++++++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/mhi_phc.h     |  21 +++++
 drivers/bus/mhi/host/pci_generic.c |   6 ++
 include/linux/mhi.h                |   5 ++
 9 files changed, 265 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index 4c316f3d5a68..64f9b2b94387 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -118,6 +118,10 @@
 #define CAP_CAPID_MASK			GENMASK(31, 24)
 #define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
+/* MHI TSC Timesync */
+#define TSC_TIMESYNC_TIME_LOW_OFFSET	(0x8)
+#define TSC_TIMESYNC_TIME_HIGH_OFFSET	(0xC)
+
 /* Command Ring Element macros */
 /* No operation command */
 #define MHI_TRE_CMD_NOOP_PTR		0
diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
index da5cd0c9fc62..7609768c0efe 100644
--- a/drivers/bus/mhi/host/Kconfig
+++ b/drivers/bus/mhi/host/Kconfig
@@ -29,3 +29,12 @@ config MHI_BUS_PCI_GENERIC
 	  This driver provides MHI PCI controller driver for devices such as
 	  Qualcomm SDX55 based PCIe modems.
 
+config MHI_BUS_PHC
+	tristate "MHI PHC driver"
+	depends on MHI_BUS
+	depends on PTP_1588_CLOCK
+	help
+	  This driver provides Precision Time Protocol (PTP) clock and
+	  communicates with MHI PCI driver to get the device side timestamp,
+	  which enables precise time synchronization between the host and
+	  the device.
diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
index 859c2f38451c..f16b3195a03a 100644
--- a/drivers/bus/mhi/host/Makefile
+++ b/drivers/bus/mhi/host/Makefile
@@ -4,3 +4,5 @@ mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
 
 obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
 mhi_pci_generic-y += pci_generic.o
+
+obj-$(CONFIG_MHI_BUS_PHC) += mhi_phc.o
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7ca2fe48c9ac..caa307c71890 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -497,6 +497,32 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_MHI_BUS_PHC)
+int mhi_init_tsc_timesync(struct mhi_controller *mhi_cntrl)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_timesync *mhi_tsync;
+	u32 time_offset;
+
+	time_offset = mhi_find_capability(mhi_cntrl, MHI_CAP_ID_TSC_TIME_SYNC);
+	if (!time_offset)
+		return -ENXIO;
+
+	mhi_tsync = devm_kzalloc(dev, sizeof(*mhi_tsync), GFP_KERNEL);
+	if (!mhi_tsync)
+		return -ENOMEM;
+
+	mutex_init(&mhi_tsync->ts_mutex);
+
+	/* save time_offset for obtaining time via MMIO register reads */
+	mhi_tsync->time_reg = mhi_cntrl->regs + time_offset;
+
+	mhi_cntrl->tsc_timesync = mhi_tsync;
+
+	return 0;
+}
+#endif
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;
@@ -634,6 +660,13 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return ret;
 	}
 
+	/* Discover TSC time sync capability, if present */
+	ret = mhi_init_tsc_timesync(mhi_cntrl);
+	if (ret && ret != -ENXIO) {
+		dev_err(dev, "Error configuring TSC time sync\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 7b0ee5e3a12d..ca50961769fa 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -9,6 +9,10 @@
 
 #include "../common.h"
 
+#if IS_ENABLED(CONFIG_MHI_BUS_PHC)
+#include <linux/ptp_clock_kernel.h>
+#endif
+
 extern const struct bus_type mhi_bus_type;
 
 /* Host request register */
@@ -24,6 +28,24 @@ struct mhi_ctxt {
 	dma_addr_t cmd_ctxt_addr;
 };
 
+#if IS_ENABLED(CONFIG_MHI_BUS_PHC)
+/**
+ * struct mhi_timesync - MHI time synchronization structure
+ * @time_reg: Points to address of Timesync register
+ * @ts_mutex: Mutex for synchronization
+ * @ptp_clock: associated PTP clock
+ * @ptp_clock_info: PTP clock information
+ * @mhi_dev: associated mhi device object
+ */
+struct mhi_timesync {
+	void __iomem *time_reg;
+	struct mutex ts_mutex;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_clock_info;
+	struct mhi_device *mhi_dev;
+};
+#endif
+
 struct bhi_vec_entry {
 	__le64 dma_addr;
 	__le64 size;
@@ -388,6 +410,15 @@ int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      struct image_info *img_info);
 void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
 
+#if IS_ENABLED(CONFIG_MHI_BUS_PHC)
+int mhi_init_tsc_timesync(struct mhi_controller *mhi_cntrl);
+#else
+static inline int mhi_init_tsc_timesync(struct mhi_controller *mhi_cntrl)
+{
+	return 0;
+}
+#endif
+
 int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
 		       struct mhi_chan *mhi_chan);
 void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
diff --git a/drivers/bus/mhi/host/mhi_phc.c b/drivers/bus/mhi/host/mhi_phc.c
new file mode 100644
index 000000000000..783f05b5d144
--- /dev/null
+++ b/drivers/bus/mhi/host/mhi_phc.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/module.h>
+#include <linux/mhi.h>
+#include <linux/ptp_clock_kernel.h>
+#include "../common.h"
+#include "internal.h"
+#include "mhi_phc.h"
+
+/**
+ * struct mhi_timesync_info - MHI time sync info structure
+ * @t_dev_lo: MHI device time of lower dword
+ * @t_dev_hi: MHI device time of higher dword
+ */
+struct mhi_timesync_info {
+	u32 t_dev_lo;
+	u32 t_dev_hi;
+};
+
+static int mhi_get_remote_tsc_time_sync(struct mhi_device *mhi_dev, struct mhi_timesync_info *time,
+					struct ptp_system_timestamp *sts)
+{
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->tsc_timesync;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	u64 val = U64_MAX;
+	u32 hi, lo = 0;
+	int ret;
+
+	if (!mhi_tsync || !mhi_tsync->time_reg) {
+		dev_err(dev, "Time sync is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	/* bring to M0 state */
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret) {
+		mhi_cntrl->runtime_put(mhi_cntrl);
+		return ret;
+	}
+
+	guard(mutex)(&mhi_tsync->ts_mutex);
+
+	// TODO: Disable ASPM
+
+	/*
+	 * time critical code to fetch device time, delay between these two steps
+	 * should be deterministic as possible.
+	 */
+	preempt_disable();
+	local_irq_disable();
+
+	ptp_read_system_prets(sts);
+
+	/*
+	 * Read the high dword twice around the low dword and retry if it
+	 * changed, to avoid a torn read across a device-side rollover.
+	 */
+	do {
+		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
+				   TSC_TIMESYNC_TIME_HIGH_OFFSET, &hi);
+		if (ret)
+			break;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
+				   TSC_TIMESYNC_TIME_LOW_OFFSET, &lo);
+		if (ret)
+			break;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_tsync->time_reg,
+				   TSC_TIMESYNC_TIME_HIGH_OFFSET, &time->t_dev_hi);
+	} while (!ret && hi != time->t_dev_hi);
+
+	time->t_dev_lo = lo;
+
+	ptp_read_system_postts(sts);
+
+	local_irq_enable();
+	preempt_enable();
+
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+	mhi_cntrl->runtime_put(mhi_cntrl);
+
+	return ret;
+}
+
+static int qcom_ptp_gettimex64(struct ptp_clock_info *ptp, struct timespec64 *ts,
+			       struct ptp_system_timestamp *sts)
+{
+	struct mhi_timesync *mhi_tsync = container_of(ptp, struct mhi_timesync, ptp_clock_info);
+	struct mhi_timesync_info time;
+	ktime_t ktime_cur;
+	int ret;
+
+	ret = mhi_get_remote_tsc_time_sync(mhi_tsync->mhi_dev, &time, sts);
+	if (ret)
+		return ret;
+
+	ktime_cur = time.t_dev_hi * NSEC_PER_SEC + time.t_dev_lo;
+	*ts = ktime_to_timespec64(ktime_cur);
+
+	return 0;
+}
+
+static struct ptp_clock_info qcom_ptp_clock_info = {
+	.owner = THIS_MODULE,
+	.gettimex64 = qcom_ptp_gettimex64,
+};
+
+int mhi_phc_init(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->tsc_timesync;
+	int ret;
+
+	if (!mhi_tsync)
+		return -ENODEV;
+
+	mhi_tsync->mhi_dev = mhi_dev;
+
+	mhi_tsync->ptp_clock_info = qcom_ptp_clock_info;
+	strscpy(mhi_tsync->ptp_clock_info.name, mhi_dev->name, PTP_CLOCK_NAME_LEN);
+
+	mhi_tsync->ptp_clock = ptp_clock_register(&mhi_tsync->ptp_clock_info, &mhi_dev->dev);
+	if (IS_ERR(mhi_tsync->ptp_clock)) {
+		ret = PTR_ERR(mhi_tsync->ptp_clock);
+		dev_err(&mhi_dev->dev, "Failed to register PTP clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhi_phc_init);
+
+void mhi_phc_exit(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_timesync *mhi_tsync = mhi_cntrl->tsc_timesync;
+
+	if (!mhi_tsync || !mhi_tsync->ptp_clock)
+		return;
+
+	ptp_clock_unregister(mhi_tsync->ptp_clock);
+	mhi_tsync->ptp_clock = NULL;
+}
+EXPORT_SYMBOL_GPL(mhi_phc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MHI PHC driver");
diff --git a/drivers/bus/mhi/host/mhi_phc.h b/drivers/bus/mhi/host/mhi_phc.h
new file mode 100644
index 000000000000..263574ca53da
--- /dev/null
+++ b/drivers/bus/mhi/host/mhi_phc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _MHI_PHC_H
+#define _MHI_PHC_H
+
+#if IS_ENABLED(CONFIG_MHI_BUS_PHC)
+int mhi_phc_init(struct mhi_controller *mhi_cntrl);
+void mhi_phc_exit(struct mhi_controller *mhi_cntrl);
+#else
+static inline int mhi_phc_init(struct mhi_controller *mhi_cntrl)
+{
+	return 0;
+}
+
+static inline void mhi_phc_exit(struct mhi_controller *mhi_cntrl) {}
+#endif
+
+#endif /* _MHI_PHC_H */
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index b636e2c23b4d..f47867ced1d6 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include "mhi_phc.h"
 
 #define MHI_PCI_DEFAULT_BAR_NUM 0
 
@@ -1123,9 +1124,11 @@ static void mhi_pci_status_cb(struct mhi_controller *mhi_cntrl,
 	case MHI_CB_FATAL_ERROR:
 	case MHI_CB_SYS_ERROR:
 		dev_warn(&pdev->dev, "firmware crashed (%u)\n", cb);
+		mhi_phc_exit(mhi_cntrl);
 		pm_runtime_forbid(&pdev->dev);
 		break;
 	case MHI_CB_EE_MISSION_MODE:
+		mhi_phc_init(mhi_cntrl);
 		pm_runtime_allow(&pdev->dev);
 		break;
 	default:
@@ -1491,6 +1494,9 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 		timer_delete_sync(&mhi_pdev->health_check_timer);
 	cancel_work_sync(&mhi_pdev->recovery_work);
 
+	/* Remove PHC */
+	mhi_phc_exit(mhi_cntrl);
+
 	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
 		mhi_power_down(mhi_cntrl, true);
 		mhi_unprepare_after_power_down(mhi_cntrl);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 8616bacd8675..e994ca4f9810 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -23,6 +23,8 @@ struct mhi_event;
 struct mhi_ctxt;
 struct mhi_cmd;
 struct mhi_buf_info;
+struct mhi_timesync;
+
 
 /**
  * enum mhi_callback - MHI callback
@@ -341,6 +343,7 @@ struct mhi_controller_config {
  * @mhi_event: MHI event ring configurations table
  * @mhi_cmd: MHI command ring configurations table
  * @mhi_ctxt: MHI device context, shared memory between host and device
+ * @tsc_timesync: MHI TSC timesync
  * @pm_mutex: Mutex for suspend/resume operation
  * @pm_lock: Lock for protecting MHI power management state
  * @timeout_ms: Timeout in ms for state transitions
@@ -422,6 +425,8 @@ struct mhi_controller {
 	struct mhi_cmd *mhi_cmd;
 	struct mhi_ctxt *mhi_ctxt;
 
+	struct mhi_timesync *tsc_timesync;
+
 	struct mutex pm_mutex;
 	rwlock_t pm_lock;
 	u32 timeout_ms;

-- 
2.34.1

