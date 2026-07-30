Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10044A72C
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427259; cv=none; b=Fi42zJzJP8QSEWfUCdzFQ0pNsQ9qEhq+DN0iNcFko/155IogeQ1It3pffBs8DOrpJuqxowfmcJVQDLwpY7bCR9VtuLV+Z9yZE7pjkRMk04THkyO52hKUwVh4H0wmn3C8xLFszazJI3cEdPh9WJ9aPAZodMOjEZ1Tpq44eT7GuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427259; c=relaxed/simple;
	bh=OvCoQyRpL0+LUj08qznL6Vpg7APY+bJUr7eTwyvn2XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CN4OoHBKIuDYQOJyBJZTFUixGMg9FZfi9fkqq8Q1IOUtBu8Vpg1KN0zoQeS0j/kwsXuP7nluAAXXl2nY2fFQtalQUfEzkFyC5pBWXV8NcdrZOfll1IBdNEapFrBcO568xbg4fLr31+ZpyeLrzs19nrRNMfgaD3yjPv21CycdIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxeULNSL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IbzJdenJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxeULNSL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IbzJdenJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQtfv1490255
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9PMz+dnble1GdL5feeV7xmOmc+UN0QuRZbXG4cK1sc=; b=dxeULNSLUcRNcK9i
	MlZ9849Moe7IBN/zZB4WyHHUajMW4KVHBCd4FW3YxgDE0NsmY9kJUlZEtPVQUcZB
	j68kbNcmPEQ1eCvdAki3GxBSRLBXWp4v2hg48LRqTrK2RR2BizZ34wuhaa9xwFJX
	toQfxEaCnq69SBpIujR9AmX1qhiahCDP//gLTMQIgScSoszdg+zsf1xr5iyyUkKd
	EE2VC1HNWGg4tuHr1FPQ5x0E8IA/zG3DONT10tKWWFKBpcOv4iT/C+V3vsC3c6nS
	UKdMhdwayjtfgMkIUqnERhu4Urj+QmpJP73YI1o8rqST8EOnkE1EuA+cuqQ4ub4V
	FhlQtA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8md0dq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 16:00:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9309af14fd7so229685a.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427255; x=1786032055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9PMz+dnble1GdL5feeV7xmOmc+UN0QuRZbXG4cK1sc=;
        b=IbzJdenJh9Jq/mW8neE9GWyE7oLwqvysd/JIuKjrHxVMqlahPVeRFNnXjhyiKFyaTH
         xPvhq6f4LZmkKSYETT4vdOVXLst9TVZXUV5XwRoTZcCpPse5F0WfOLXGw/53+y7+Lc13
         d0iJ4bnVk/xLJW2VM4n2K4YDr98MmresVNVPFAPDW2rdtG1zWjlgvN6EfMqHTOrQadLq
         hH+Zr7sqme4w2GaPEecUE1ypGkuB2LsGIrhC4QVVDGez7BCfXYF9Vnjed0DY2M+XRr+j
         Kpib/RMglEeCDyKoJWJ7lfCTZEaJKMqngdiFROaP7RznGlMl0n4ZWFEhE+Q0f+HOJwun
         Z03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427255; x=1786032055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9PMz+dnble1GdL5feeV7xmOmc+UN0QuRZbXG4cK1sc=;
        b=XC/sEVnTzw4CCEaudlGfIiu5G9XZfeUTEaC71FFnBe1b23iUXLpwfw/eoKB1frKkoS
         Qt3Aj0nrY6bgkLjrfhMg3Gbmh5x6t6Y4gBNOcank0Ph+Mpy6rqeqXnVADlztl1tmon0a
         kDUNkuHucFSq0CvDi0A5/2xHLJkeq93sKyhID1suWiPNOoEyPz7njVBfmHKosignyA/R
         oCTr3fF85x2jhc7eir+JVgC0mF2lvRYbfQ0dXCuQBwiW7e+KCoGQtIJ5YoawlO5RXEf+
         jywbyNMkqiYj+WdaOP8L84FgTv7ZKeaYPebw46VGX4UYcsylBOpctmoL59isQk/T//yq
         8Knw==
X-Forwarded-Encrypted: i=1; AHgh+RrsSiZgqYIXPfG+GnWG8Ue7/kYIYWD2gUsDtnmh6CGo85ZRy9ZEXo29XgmzBsj1fP9A8Gi87ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7y93CLoZMEf0YX7g0n2XW+pyW0qvSIiZcXvOHP4hNp3Q3JATi
	kLJ5w+egqCiJND09/Ne3/ez8HeSJZ9cuc+Ng+QtQJ7/oD9MWhspOrJadtzXg7PzqdHwa8irVenV
	LXNsTDiMb7VUqA3b1Y0bTTSeNTBBbACsyRCBDueNx/BT9XpfxHPVlbTPd5Ws=
X-Gm-Gg: AR+sD11/gF47tlfz2J0J1WK5J5/ZTaAyPhQs3xg1EXm0NhV5NBrXp9oga9bO3hmQL3G
	z9O0/gpfnfGLAtib+ULUOxv0NbB0yKCh1pezLhJngqU4FTrp7q0ue3WLEWVIsv2EdT28XoAVHTy
	3qx8IhZGel0zXsiIpMQmoswVPhs0fS7qPwB7etakhmctlBD5W3e/15DdC7/iT57MMJPZbB8cri7
	dP2J10ovvnmzHv+i7lHT25P6qOJvl1RmM5mQyhNTetb2w0FmOK+8HxBQpCeQAdOsNWHT3XqN1BP
	19MZyBOhXKReQ6BO5/voTv4HKbdl1soEmAXDbXQCWcLJbeIOpR1W926WTYFDHagVkzn+haz8T7e
	AxMtxnUaFLarfNP5DiJinjkqkDDvb+pwiwxQSnIp8L/+QIIgCk8MUlelGBUG/HJxO++P/w8SW/c
	OcYM4s4/RmBLzTIgLrmflJIiLfc0/quye/DaPRJa6FwO9SqSfbpbe1
X-Received: by 2002:a05:622a:591a:b0:527:7d0f:863b with SMTP id d75a77b69052e-52b385fee43mr34234131cf.12.1785427255252;
        Thu, 30 Jul 2026 09:00:55 -0700 (PDT)
X-Received: by 2002:a05:622a:591a:b0:527:7d0f:863b with SMTP id d75a77b69052e-52b385fee43mr34232291cf.12.1785427254055;
        Thu, 30 Jul 2026 09:00:54 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:35 +0200
Subject: [PATCH v9 05/10] block: partitions: of: Attach partition fwnode to
 the block device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-5-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=UZphjqSN c=1 sm=1 tr=0 ts=6a6b7538 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=2ffTNAQyBkxXHBiWhEgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: fR6tGwfaIb6fdRP-u1sxPoJDKuLeJ9mS
X-Proofpoint-GUID: fR6tGwfaIb6fdRP-u1sxPoJDKuLeJ9mS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXx1WEpqHtfRMx
 NQmYZRzF4VM8Pn13rDPa46lzRgNjEf+fCSqClKcz7igS+PSzJKjLBz4E8dChWMUFalrDh2Gn4uo
 gcXsC1/54d2nnWUkVFhdczNV/DW//0w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXxoydy8Ol//OZ
 pTgF2GByNhs/Wnf5Uh0g84oEUBERWBFt3r1OSMpcEb42fvf/bRf1/mlo509zeNTYgQx44yCfVl2
 zTGW38/fHPPIZM0CblqP50M/rBpKIPDi7lQYZfxEaqR3ak2bxD3tS1ENrbl71ADArnuCosvat9K
 zuWz16Exx3HC8M78yUOmUpuoV+stZYpz+p7scid5FHqtWUUkspnAMEqq3SdNbJoteRX6cVnhTfO
 d25jeio5BVJLS6xfcoFNTW6sWe5nKbcodDodCtPqPm50nwh9ZfUDBh2kWDCwMqY6zMqszbW4Fqx
 5VmZjk7jYp44MOeH0CXVu3iyamNXhOv+cSqlcRLScgDTR6F9X2cKUSLM6fUcGTaTCfCacbiKJf0
 T2JygSTNIyC4qeRlH/j9nZl1ij0j6IYUrKDY0vw9oZ2RJNxTH+9yNp0MiUQG2ESo5rE/EnwA2wW
 hE6cNpZTKUIavZEI/Qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300120

The OF partition parser reads offset, size and label from each
"fixed-partitions" child node but does not associate that node with the
resulting partition block device. As a result a partition has no
of_node, unlike the whole-disk device which gets its firmware node via
add_disk_fwnode().

Carry the partition's device tree node through the parser and attach it
to the partition's block device with device_set_node(), mirroring the
whole-disk case. This lets consumers describe per-partition properties
in the device tree (for example an NVMEM layout on a partition node) and
look them up through the partition device.

No functional change for existing users, partitions without a matching
device tree node simply get a NULL fwnode.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  | 10 +++++++---
 block/partitions/of.c    |  3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index b0997467b61a54a8a621b9c155c8329289649460..326081499d9a6be730dbd659c110449cfa06921f 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -17,6 +17,7 @@ struct parsed_partitions {
 		int flags;
 		bool has_info;
 		struct partition_meta_info info;
+		struct fwnode_handle *fwnode;
 	} *parts;
 	int next;
 	int limit;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b5c59b79ca7cbb28d4d93478ee1c80908f76ee9f..72f435dfeffc63e897913571f319e5edd8e7ba88 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/property.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
@@ -247,6 +248,7 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
+	fwnode_handle_put(dev_fwnode(dev));
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	bdev_drop(dev_to_bdev(dev));
 }
@@ -294,7 +296,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
-				struct partition_meta_info *info)
+				struct partition_meta_info *info,
+				struct fwnode_handle *fwnode)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
@@ -343,6 +346,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->class = &block_class;
 	pdev->type = &part_type;
 	pdev->parent = ddev;
+	device_set_node(pdev, fwnode);
 
 	/* in consecutive minor range? */
 	if (bdev_partno(bdev) < disk->minors) {
@@ -449,7 +453,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	}
 
 	part = add_partition(disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
+			ADDPART_FLAG_NONE, NULL, NULL);
 	ret = PTR_ERR_OR_ZERO(part);
 out:
 	mutex_unlock(&disk->open_mutex);
@@ -564,7 +568,7 @@ static bool blk_add_partition(struct gendisk *disk,
 	}
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
-			     &state->parts[p].info);
+			     &state->parts[p].info, state->parts[p].fwnode);
 	if (IS_ERR(part)) {
 		if (PTR_ERR(part) != -ENXIO) {
 			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
diff --git a/block/partitions/of.c b/block/partitions/of.c
index dab36513eba336344c9558d486a8915624b0fca8..d4016f9b77ec078eb1adb32923107c012ca4a751 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/major.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/string.h>
 #include "check.h"
 
@@ -65,6 +66,8 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 		partname = of_get_property(np, "name", &len);
 	strscpy(info->volname, partname, sizeof(info->volname));
 
+	state->parts[slot].fwnode = fwnode_handle_get(of_fwnode_handle(np));
+
 	seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
 }
 

-- 
2.34.1

