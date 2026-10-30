Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380016;
	b=WGN96CZFX6mbTZQO9scMuLRmCOsLwevkltq8L9XUHEf8xwQPFO30NZEk4gltGZfTbigs
	 8aDKk64KD8m9RaQYnMf7/swi6dy3+YM6HHZvXzUIIZ3PSNCcziVJh5CIZqH1MTPAZPGfo
	 J+FHzLhKQ7muIA8PYmzg8L9QWNoEiEw/g+pO3ginzF470h0cQZC8bGSgHGyTsYmTrB27a
	 cjdxE6GB+Lt/kQoldYTXx1re3Wb9kKnBWmzLZ9M6g38z9gv8nhj3CF/BPUgAZRyp2zy2R
	 YkDg3nspFWT3JTwL74Cl76LwrV6b46nUkaVyOJfZqM8gYVIRcKxxaA+u8JNm8XenW+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380016;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=;
	b=EsM7dpyzh9+aOr9aVw2qYI+Ursky5NoN9NN8l8tP4UlM7aVhh4jqxpi+lur4/QAHacZX
	 01fPNKbMU/1k80z5Qa2ytBdMa2lL5NPxRHdcZStZ5pyfJqvDEPXaQ5ZANFlNNkb31G3S+
	 rHuoGvSDGoweDqCVobpD9GVWMJcHqqH8CZqo8IX8xoAaUvYnAVqVrHCHbxf187QzyZrMC
	 5y67on6p1NyxvIkWRSE6mn+5JLvyOsNo6s65R2R8p42iAmKZzWJlkxO559ATQEuuqGkxB
	 KQE3BoVxlReHyYKBTYqTPkSl4Vz5/viZ4FU0WP20Rxi3zE+LhJwOmKId2+hHNliWadw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SuJJaK4Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRGII9Xp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE2606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EE2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SuJJaK4Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRGII9Xp
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERJmH4141730
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=; b=SuJJaK4Zqg0DHe1h
	SRoGJjGUkObm9CxiFqWw31uBdcK3DtTay6zqM6fd70EdrYgdP9pN4IuYJM19eShP
	MS8c9a3JC3AQZEiFTKZJe5TbBkLN64Vr8JQQu/T7eotTUOD7FJ631OoU/W1D7flU
	JTxT8utX687E0yza46RPsPRio2KlZGfLY85B3brnZwxBflS9K7Qxa8oJnxYQGEsV
	vDod39aMyq8ZP9IQQQZXgpv3G8mlEU6wt8gvddnikXm6LGhPpP2CFcYVVEGq8Vem
	pd7NMRa3usW3xAXneXnbOippJNNFEUY1i2XaGaIYYQtRlNDcJMtsZauJhKDnVdUx
	x7w7/A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qv3aa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:06:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so7493805ad.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793380013; x=1793984813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=;
        b=TRGII9Xpc/FuBnDSjlOm4t6fD/3SGKWe5hlP8ctru6WibW5uoyyQcldlBKYPp4ryrc
         Dk39lcx5aRp6p6hRmhk3jN+LiJLTysEcO2cSeKSBtOO924zJM8oN1V9IieHutPusBlfH
         TPfq6n8ieCkO2spGR5WcWXbDYIlKZ6L1E7avd2LQbWpV0H7E7z7O9kkvZIMIf3U/o53G
         CgtuSg141W7T0oUYMXtMAgS0oU+sbeU5Ja5coGXL2/Tr7AqXqOWZhzlMikurcuIBi8Ha
         /eoRxMnBTofTGPfu7yvvBoJCyJCdq/6LPB4w8k17V7kN9c6cOP71utoYZ2OrRb04XzsA
         0Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380013; x=1793984813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+QjOGUHNV6g3mx0sg1Jrx3XtV4BRZaSsgv5wHeNG7Y=;
        b=ZInGJTnAZScrLEZzSA90mbJ+hKd7VBMQ1RUX9JRG0tS7brKYv+YFB6kN5BnXm4RgZa
         vV9qa04EG6OXj5OJUm4YilH4Krux2zBSMdHhWpSLeLYCAiX3ALzXh3XUpeJ5oFe0z+XQ
         DfH17vEpbOch6h6mea96UieAf6cQBh4U30CAhYv1Qy4TxbSV2XrMTlS7ynDgq3VdP2zf
         PlhmI0cxRxxyOC7Z0WfFN+5h2Dc0If2eTcco3VMJB99cJmSBPToU7cK7Frxp69D4NQhD
         /wFcKfGolVPzjSs7GxOKRnOfmVEOrjxdcstfwtizLOyqqmdE9xqxu29alzUU50Yoh6fi
         E2Ig==
X-Forwarded-Encrypted: i=1; AKwUvBzzqmBQ3J7j4wuhaCYo29YsH1+Bx2bkkj5aDIJGSZEI4Y0k+Vo0EGnh1wYh96h/ukv8Y6+xaJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7w5PDJS+Gjtw8U/RKOKKBM2kO0ZLzJ56U3hlSVXNO/eI8oUtJ
	bEX1uNt9Juw+8/Amz1fqXmNpyCivZjY2p8WCanuYEmMVNmmavKHu62ThtaGSxBk1ucb9n/16qYU
	OxPUYS/l63cxPZygUhhsbouT9ULG+hDxQK7JV1ZZkpOlIh1HBy61WJynnVJ0=
X-Gm-Gg: AYBFou24gOfxgdNSf3qAoz2OE57BNCKfKQu5S9W2HU5Q1WnXw17H/UW0MBXJHg+P3Ky
	/L+uKnqM9sCjpX6OdaXJVdzu4mHvwv0sZClX1OgfqfDDppWcCZoyOayl8JMVR21tUwIM+3ap9tH
	BpNRl2OOIEam/M0uMlWveGG/i1LqNwRQlolM5sESF6/O2aizRjnGJ9NBMd+hYXkSk10GEvoXp8y
	n3Kxk1ruNqbtVgBXh967MFa8M45G6yJ4xkMJD22axkvc1A8eTfAQ0nVjvq4ponvtVsyvtqDn5ed
	yQ+BL+T9iGkbfP0ePSmRxPEodr0lxkYtZMPltVH91tXyo398VE1eBLhVhR63wupIal5WuMf0ClZ
	RLk7M0n1hKazB+2JkS0Owyd9HoliD72JCj85qkVHzbrtkmNGA/LzU3yYfcP1CvGVr7ItmEMb/+b
	jCfufu9ua3rskx2AnlPuKBRMg=
X-Received: by 2002:a17:902:f54d:b0:2e8:4f3f:60dd with SMTP id d9443c01a7336-2eb3645b7bbmr27073065ad.37.1793380013098;
        Fri, 30 Oct 2026 10:06:53 -0700 (PDT)
X-Received: by 2002:a17:902:f54d:b0:2e8:4f3f:60dd with SMTP id d9443c01a7336-2eb3645b7bbmr27072895ad.37.1793380012717;
        Fri, 30 Oct 2026 10:06:52 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927e526sm10442855ad.51.2026.10.30.10.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 10:06:52 -0700 (PDT)
Message-ID: <13f102db-287d-4d5f-a113-c5614a3cb7bc@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:06:50 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] accel/qaic: Add callbacks for DRM RAS netlink
 telemetry
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
        airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
        lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-4-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UTUmv6P6259QBqBse4dCRDa3Wa7XEAOL
X-Proofpoint-ORIG-GUID: UTUmv6P6259QBqBse4dCRDa3Wa7XEAOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX3aLNF9mMMnKZ
 3vqP1EMlmBJ7OnDrsldIfnRo0tL5B2HhpRbeUprq4ErnB5NBFESHOlV6PWFwPm5w0X/ENiRSSlw
 JvWOodx4cZTL2uivUI/UQXfIu1p2j6zGFh/8xE4epTWOlFeVqsd9bnJ3w1WHe38IQ1+xvb6Yc+Q
 PiuD6eFf0D3zYYwCfKHKR8snC1x/n76MaAbprXvGburAweS3Bfms9oXRBM/gWng5pLSjr/NceJM
 0Ar0RcXE5121bQ8wDTSGMNU3fUbdMlRR5zbbVYwXnurIreMWZ8dhtJqh0zSrINbgrV0sZoR2+ao
 Vofkwj8DpbUBuFvEQd5ZB25smCocOiPYhG7wlymtGyj2BvRdj+E/kf/rh+RWQJlM4YOr/7ZU+/H
 EyG7sbZ5NxQimWN2Qr09u3ZmaL/TOocDfFiYE2f4iN0kXSslf325MCLGGWn+XJ2gxGPCILr38GI
 9PKtNv0iFT0uW34FD2g==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4ceae cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=sY8SXE2aXj8CL1lXyIYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX+7dTmcKA4qSf
 MXsY7M/nsqlQdQfgg4EXcSXmv2VM2f9kW0gzJI6UBUrqf1Tc07amNdGkNfqyoJRUuKqE5FNzB7F
 l7SUk+59iS1yKDVjB/gJX5saTm189/M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300068

On 10/29/2026 2:30 PM, Zack McKevitt wrote:
> @@ -611,6 +620,13 @@ static int qaic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return ret;
>   	}
>   
> +	ret = qaic_drm_ras_register_node(qdev);
> +	if (ret) {
> +		qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
> +		qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
> +		return ret;
> +	}
> +
>   	return 0;
>   }

Registering the mhi_controller will kickoff a whole init and boot 
sequence for the hardware. Feels like we should attempt this before that 
as if this fails, we don't leave the hardware in a weird state.

> diff --git a/drivers/accel/qaic/qaic_telemetry.c b/drivers/accel/qaic/qaic_telemetry.c
> new file mode 100644
> index 000000000000..fdce7a71d3eb
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_telemetry.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/* Copyright (c) 2020-2021, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +#include <drm/drm_file.h>
> +#include <drm/drm_ras.h>
> +#include <asm/byteorder.h>

A before D in the alphabet?

> +#include <linux/completion.h>
> +#include <linux/fs.h>
> +#include <linux/fs_struct.h>
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/mhi.h>
> +#include <linux/mutex.h>
> +#include <linux/namei.h>
> +#include <linux/path.h>
> +#include <linux/sprintf.h>
> +#include <linux/srcu.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +#include <uapi/drm/qaic_accel.h>
> +
> +#include "qaic.h"
> +#include "qaic_telemetry.h"
> +
> +#define MAGIC				0x55AA
> +#define VERSION				0x1
> +
> +/*
> + * Telemetry fields defined by the uAPI.
> + * This table will be used by drm_ras's dumpit to display
> + * each field to userspace.
> + */
> +const struct drm_ras_telemetry_field qaic_telemetry_fields_gettable[] = {
> +	{"QAIC_DEVINFO_THERMAL_SOC_MAX_TEMP", 1},
> +	{"QAIC_DEVINFO_THERMAL_BOARD_TEMP", 2},
> +	{"QAIC_DEVINFO_THERMAL_BOARD_MAX_TEMP", 3},
> +	{"QAIC_DEVINFO_THERMAL_DDR_TEMP", 4},
> +	{"QAIC_DEVINFO_THERMAL_WARNING_TEMP", 5},
> +	{"QAIC_DEVINFO_THERMAL_SHUTDOWN_TEMP", 6},
> +	{"QAIC_DEVINFO_BOARD_TDP", 7},
> +	{"QAIC_DEVINFO_BOARD_POWER", 8},
> +	{"QAIC_DEVINFO_POWER_STATE", 9},
> +	{"QAIC_DEVINFO_POWER_MAX", 10},
> +	{"QAIC_DEVINFO_THROTTLE_PERCENT", 11},
> +	{"QAIC_DEVINFO_THROTTLE_TIME", 12},
> +	{"QAIC_DEVINFO_UPTIME", 13},
> +	{"QAIC_DEVINFO_THERMAL_SOC_FLOOR_TEMP", 14},
> +	{"QAIC_DEVINFO_THERMAL_SOC_CEILING_TEMP", 15},
> +	{"QAIC_DEVINFO_VOLTAGE_CX", 16},
> +	{"QAIC_DEVINFO_VOLTAGE_MX", 17},
> +	{"QAIC_DEVINFO_VOLTAGE_NSP_CX", 18},
> +	{"QAIC_DEVINFO_VOLTAGE_NSP_MX", 19},
> +	{"QAIC_DEVINFO_CFG_TOPS", 20},
> +	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_A", 21},
> +	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_C", 22},
> +	{"QAIC_DEVINFO_THERMAL_PMIC_TEMP_E", 23},
> +	{"QAIC_DEVINFO_POWER_ACTION", 24},
> +	{"QAIC_DEVINFO_SOC_TDP", 25},
> +	{"QAIC_DEVINFO_SOC_POWER", 26},

This should be in sync with the defines in qaic_accel.h right? Can we 
just use those defines here?


