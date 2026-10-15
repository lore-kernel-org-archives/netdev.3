Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D05326B5
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074394; cv=none; b=sk2yMyXsbOk9Ly5udYyAXRxapL5a2VPetmfPw5ATEIqcCUUWzJjOL0zZr9PCh0NQ7sYImKYU2btjhdBYHL9ObmXiIiZ++3ty/25/cu7bpz48pV0XwdLtr138WamZZ8HOkCRxapAitX+afj5NoQ/9zQEdZRi6+vDVCsDQ9R02ZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074394; c=relaxed/simple;
	bh=3be6ZRrkuwe5O6MvoCJ3NJTdkt/zK0OZYHzR1WryNh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LS5+BRlzuTNl8sN66SLAnLoF48Ol8jQNdak05QNybnq9/BYJGvglxsUHPEFzzUDhHsTLvnX6bsf3ES2B9xGYYnZut+qkwAD8XGKPtukr6TLM+wnP9Esb/lrGBRHmofjI2deRLw/2Uv8VE0VmEu86Qna9N4CdpDtIkdgJH7A/Nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FwjSPjvD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b6QGq1BE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FwjSPjvD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b6QGq1BE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jhhg1956076
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IE79JMn0wPrEDgdovegTuQ5M+CHvyEMAVwZJre8pogM=; b=FwjSPjvD7W2PMEe5
	Jhgvf42cxtSO7T1hqxcoWM9lmq71G57eUJzUPFYtXqaPlv3X+VOyFEFikHXdcacd
	Zxl++rFEoG+Qwv1Hi1KpUhXcPVkRjbT3alg7JqHIFnbsXFx6ZxYbyLpoED70rH9E
	qD7Q+kQp2NO5EKdmTCWHV4GL06v9Y7iWs3rvKmwusLx3YvK5ESchEPbC+NRAUEeX
	ZruNCfvaac/F4rmPfUfXDKtXd7QJpnbTjyukC+Qnb+b1KQhS8jLWOCf9/gQzY3k0
	SmFX0UF/jP8Hb/wdU3t+dvAdZRfGFgoYvHoOSAujVJE72GMFbTUVP6fx5DCq/0Fx
	c8Ixng==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdeubh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:21 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cb6dd9d07eso410935137.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074380; x=1792679180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IE79JMn0wPrEDgdovegTuQ5M+CHvyEMAVwZJre8pogM=;
        b=b6QGq1BE+4qLOl2AeQdlcAdxNLLlWd9g1P+i5nHlDQ2zMzt1r0ohbn3TdnpAks+Kpx
         Av2SLNvihIXhp/d+cUBLcl4yaGkhBmCgzynbPs7QRHljtJrhAkUetLYJ0nLNVOKaEqB1
         T/pSColhPJqvZsd57qEAKXNNHFnufrE6P3gdv8u7O5mvkJr1i0MIdJcgprjmKV98fVEr
         zYj09I2/Ov8yIO5eWFLdWhRtew3c2Kmu0XPaztl1NJ6072PTWSEoNDXB935xa1GuyOax
         KzK5UKjkQdHtYMDux2P2Szk1Spcbth5gQ2cpxL2hyUzKPjH/KObnGG3JX2yf/0zPV7Ra
         uIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074380; x=1792679180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IE79JMn0wPrEDgdovegTuQ5M+CHvyEMAVwZJre8pogM=;
        b=gNbttDZgLsLCh6qug6ABB24VH2PA/SP5Z/6YI/wUVm09GAAKDkahMPXuMbJVRlFU5D
         giFlyGBHC5mt33kcYZizQiFDFZYE5hzmuWz3/xFrHX1nm3gKrA1PqAZJAypzg7CGkCRl
         o/+SXPkkkW7r8IvsbYwjR7/s8arCMGU+imyI9cYvYEXw2+fIfs5rMNYggyPoTV/pn8Kl
         x1OpDpE6e8sTtsQFkPoHYMaficTuv+oHLAEx07jMtjKB/aP+ODNTQNY6I3Kc75OATTEy
         ystfCM7zTImJ6JLYiG2WZMbSR9LTeiX5Y/bcCpdkLxNt5aEl/opq0z5oWvfoyFd7bouF
         4+qQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOxc5ywi9nMKwnzpjNtHL23HlvtEsmieo97spdGdF+Hwuk6UBvzgu4zRLRAeRQ91oLLiOmmB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjYuu5MPJqofMuq+ybctqY6MesN5ijubVif0OmQlwzE9CoZxcs
	RU2S3W/tF6Z3OoPPhKQFs27iLpBVRnGMuJhYDVAFbIkpY5lW4haCvqNDRUbHUQccixVj2kvUO3m
	031Onu3J/Adpyb7rsrKYVh7cXWWpbJeeM4ESo7b9ShRzOEJVUuLK0QNBc8PM=
X-Gm-Gg: AYBFou04ZT+nPz4XgrSCUKI5FV78HlRFjaaNRdaZyq5DSYBZF66xnsmbMvnC0OZSlb7
	zy/GcjUXIYjfbdh/9N9RopgyQblYSjNCHcnEkp+/BCdWRY1IUqpOx4Kl343fvUyGxNNiB84JSL8
	AvyG0lV+jym+n+NCqyIq7ntQiMX4njZthzvWGcMwby/7MTRDR6NtR1zcqcxAnegwlE1hdubMS+j
	NZgvvsGSG+CtBKQd4enWagbARpAKnQ46rIIVYLqW4IEaVSZYl3arTDRkKh+hQzPBuZvEonX0ndg
	OQjfIEbmmmxN8b5fdxqNNVB8Qx7Ciy4f1GbA0vxaXTbCRONRn5mIQauPIguqJFYQgDSrBUj7TEC
	dzh9kz54H0p7OUZd8VGpHin1U6RCqi8VDWwcsmIWnWr+gYcA49mNQb+vzjY/GaDBgeIt7RxCLAP
	WWBcQWR4Wyc6Qaay4Z3uT5EwCjh9I8C3QF9C5/jNvc3+4IjIYY/So=
X-Received: by 2002:a05:6102:5cca:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7cb37317ab0mr3850171137.19.1792074380082;
        Thu, 15 Oct 2026 07:26:20 -0700 (PDT)
X-Received: by 2002:a05:6102:5cca:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7cb37317ab0mr3850159137.19.1792074379260;
        Thu, 15 Oct 2026 07:26:19 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:17 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:26:01 +0200
Subject: [PATCH v11 2/7] block: partitions: of: Attach partition fwnode to
 the block device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-block-as-nvmem-v11-2-f890ac74f87d@oss.qualcomm.com>
References: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
In-Reply-To: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0e28d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2ffTNAQyBkxXHBiWhEgA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: tgPvzFrxWVYOPpfLJA5bYb73Fg7gY0xg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfXybI+fbIxCnIW
 908rbDpjYkj27p8gvtRaP+BKvzoTRMUn2renTs8Y9D5zC+adLH7g5jzPX/DM6hLgL9YuhL61NUZ
 dFQXfOhnWh7LAOpFPRk/ousACiBWgzXkYnB87p+yA5lSrf+QojL50knRx3otJtWbwuwQ2CjPIZY
 FmadjVH4J7ZTbEafPMIs/bXfIbaFP8uACo6Om5x0NuwKvsGKPlqCT1BMHyLQrmIXzxXypIjfgeY
 mi/Ptqg+bdVcXksvX29uXzCacTD4Z+uT9PrtMPPM4MOq85K6yYb2t2UIdR5q7nmMJ2g/flwvP/T
 PKzE9bKDBEY2+ns1lad4sIAVLjLT/oik1lnFGrCUztp4p3z+mKjMaJohdejE1FDvsS6g/0JdJRd
 QWQKmMindJU5ZRiAUAFCh07WYCt0cHHWwBwZMp6AtU+LT6D9TvqmL7ztmFIuvrlI/g0432+9Lvg
 pwhfZfIJHJG50tsay8Q==
X-Proofpoint-GUID: tgPvzFrxWVYOPpfLJA5bYb73Fg7gY0xg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX0nE42eWMdfUu
 Od+naCNBzUoPegRzWyVx2BirlMEjG7RHJcYxBH4qVZ3e75eC8L3mloD9IXHQn3cCkaNUrAuSEgm
 cM9AWUxnVKUqIhjaS85O8u5NID6opus=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150057

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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/check.h |  1 +
 block/partitions/core.c  | 20 +++++++++++++++++---
 block/partitions/of.c    |  3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

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
index b5c59b79ca7cbb28d4d93478ee1c80908f76ee9f..eee954df1ac6ef7dd4f02ad5c9d49aed778bf015 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/property.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
@@ -110,8 +111,17 @@ static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
 	return state;
 }
 
+static void drop_partitions_fwnodes(struct parsed_partitions *state)
+{
+	for (int i = 0; i < state->limit; i++) {
+		fwnode_handle_put(state->parts[i].fwnode);
+		state->parts[i].fwnode = NULL;
+	}
+}
+
 static void free_partitions(struct parsed_partitions *state)
 {
+	drop_partitions_fwnodes(state);
 	vfree(state->parts);
 	kfree(state);
 }
@@ -139,6 +149,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 
 	i = res = err = 0;
 	while (!res && check_part[i]) {
+		drop_partitions_fwnodes(state);
 		memset(state->parts, 0, state->limit * sizeof(state->parts[0]));
 		res = check_part[i++](state);
 		if (res < 0) {
@@ -247,6 +258,7 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
+	fwnode_handle_put(dev_fwnode(dev));
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	bdev_drop(dev_to_bdev(dev));
 }
@@ -294,7 +306,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
-				struct partition_meta_info *info)
+				struct partition_meta_info *info,
+				struct fwnode_handle *fwnode)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
@@ -343,6 +356,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->class = &block_class;
 	pdev->type = &part_type;
 	pdev->parent = ddev;
+	device_set_node(pdev, fwnode_handle_get(fwnode));
 
 	/* in consecutive minor range? */
 	if (bdev_partno(bdev) < disk->minors) {
@@ -449,7 +463,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	}
 
 	part = add_partition(disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
+			ADDPART_FLAG_NONE, NULL, NULL);
 	ret = PTR_ERR_OR_ZERO(part);
 out:
 	mutex_unlock(&disk->open_mutex);
@@ -564,7 +578,7 @@ static bool blk_add_partition(struct gendisk *disk,
 	}
 
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
-			     &state->parts[p].info);
+			     &state->parts[p].info, state->parts[p].fwnode);
 	if (IS_ERR(part)) {
 		if (PTR_ERR(part) != -ENXIO) {
 			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
diff --git a/block/partitions/of.c b/block/partitions/of.c
index 53664ea06b6540e3d1155141adaafac7286f2d21..4fc7c80c407de42b2b31be2c82e0e6bc2a30c9e3 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/major.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/string.h>
 #include "check.h"
 
@@ -62,6 +63,8 @@ static void add_of_partition(struct parsed_partitions *state, int slot,
 		partname = of_get_property(np, "name", &len);
 	strscpy(info->volname, partname, sizeof(info->volname));
 
+	state->parts[slot].fwnode = fwnode_handle_get(of_fwnode_handle(np));
+
 	seq_buf_printf(&state->pp_buf, "(%s)", info->volname);
 }
 

-- 
2.34.1

