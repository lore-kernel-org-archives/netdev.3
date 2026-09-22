Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE07538D95
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074940; cv=none; b=BEaMuN7V/4wAIYa1anB1j0L3/F+lSD0ty7PJ35K9MjhTIMU4aLUkOQULTPySqsmnktII8ah89daX4N9nW3HP9ksiXgsXMrW/eHdItRMqjHgrco/UrgWA7svTLFnYuSolMNLdp9MedY3VsKtQ+z/+o04UDpQetB3HlMbSsFZnijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074940; c=relaxed/simple;
	bh=c/gHB78b+REkg1KShrJuw/VfjHzyhX5Grd/Q9g073SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIGrpimMsGPDULJNJb2jOnmdZgqGc+DdOlXMCvX0NdPpubTl6dEszTsez5k2kWtxSOBERO+7FgjLdFKsICI1TRG1teO+mjIBeohW4+ysF0UnuXeKAJ/EvTsA3g56veqcTMaguhxTgnS6G9NskZylEAhpSRlni1Z90HQg3NJMGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/9/FtWx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ILF92qxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/9/FtWx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ILF92qxi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M9CapJ1842269
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UG1NMm+Qs5qSxVwFob/kretHVwJFEGJ0GkvM3SFCL+U=; b=O/9/FtWxxKdesNdn
	X+jhngUM6a2s+f8cRg9BnTHs2IB1PNnBRiC1xXp4TMMwDFbYjqQ/N3TVfUQJW8sk
	zME2nth6+gxZpgbZ3yvB2MeeqBAD/tYgO2iRPyrrbkFNoGL8sq2Y3s4l5jgI2qX/
	uUHppnv09sG4NdpeT5LckSjZU3vI5z6hwxhRw8QYWBawGSRVF+v6R51JZFtrOV++
	3lByHLhyPB8ufyRl5Eh5sry7IL8HqFOTY19Y1dQHC3g0rKiW2An1/8k+OYB3TLSD
	rrVbvgu1cGLnMQMVey4MDWaNNa42OakQEYZLFaQ5C6rW7crCZ5Y+qfEXn5g95DVY
	8PSBfA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj111kr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:02:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso5128465a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790074938; x=1790679738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UG1NMm+Qs5qSxVwFob/kretHVwJFEGJ0GkvM3SFCL+U=;
        b=ILF92qxiwSiAjTQp/G6nz+a1SiO+Rc9EkC7CedMsPSIzC196H+nLq8AwGrdVAKVyp5
         CnG1ONV7MAnz/sqUWVCfxnd/dqmJBdc0g27oAVJBSbYFgcEXM0jSwzz0R+gvVnp71Q7o
         WnHoW9PNv1apOH5OGtWkIymu261Jkg3ollf+mkikN8a3+4QvcCkvHRGdP7u9rkBbJBHX
         L3Jnyvi+wAYaaANA9f0FIsCBQFcAblINvLluxOGJ/yvPHbdiBED7bcKwWZWwUAfdYk9G
         C69KKTk7gVrFCREGth24iLie8CchwyGjSQ/nG3IAvfRTSxaBGIUDWG5e/gGslsmMpYtu
         +hDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790074938; x=1790679738;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UG1NMm+Qs5qSxVwFob/kretHVwJFEGJ0GkvM3SFCL+U=;
        b=i7aBejvMzd1DeDRO6tEba0S0J7lhyq7fpPB1QDoeLWIwe7kKRgWdqVmDYcEYltDoTK
         icRbjxgnl+aE0GaqkRhLfCPncIBl3Vp7HJdAclW9eARQNgXf3esQ7AnqzR+ggYFZ0Lsm
         hoD4OvZrKNW0ND1Bd7Jnc4gh6cj0i6/MWQt6MYUjgSLiXdI/SmWyZcaIesqFe8y4CRcE
         rirFCQpGgLw9kJaigxePi7yrw1MVp5v5hAND58JA916UpAdG1yDObMwYZibl0BM2m8ht
         dxaNf/zmvAxv6yF8WbwNtN5Lk5mhE0VwpEYQ/4xnPeJC0MpIfJrmS6Y4/BG6lXL7lVp1
         ZJhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPEcZN7RqYXqh9n1iZdCP48Wn2Psl4KaVz2VO1vqfIZJaKoWk9wTA4TwQ4fOf/GFvKDWgsUBw=@vger.kernel.org
X-Gm-Message-State: AFuF++l19cC3lKly5nyUzBsL1iRYBPF8B9hGsUd+2aV7Qh8qSBzsM6or
	LRTSM4DtZrlTyh1uP21icTrTQRYsD85k8Ij9hHNCj/HrFdfiHc/x0R6Df9tBrARhLoK/pLfpV+R
	QtrjUCr13ptQN2ctaCHUTkuiFh7l7owUcgX/6W38I1VtFTJQ1g+kX4febc/w=
X-Gm-Gg: AYBFou25pLW+IvEsTty++DOBJ22jPGFm0uerIW4Pc1xnVq8x6qVoO9o0AHF8tl5UWtX
	wuhm36JR4zG/A5Idf8KdZ/3zaAZB5PVZU1vHSA45y9EjU3qcEMak+KOsVla391q7mrVXKniLpvf
	jHiNlv0gv+qGwjoTnMjyT3zFhriEkgmTKsKf0gXjBK15mAmuB/qC3TRKfFadPGhSXIqmE2Daj0h
	uDKOMq+QKHvSh766z66hgXCu2SWOBAQlkZ4OXUwqJyAyCGe8N75QUVHC0bJ/5IF+jNHqRaIawmj
	44qe2yzxKnrhNNfaQsly71JYzbsoyWKrWSPP3oJeZeCKUCTZZdKfibfULUoG+TujACxiDZhrkS5
	ZgoUbu8SoMHshYIyb+SYUU8wr9oNQRX/xKHNJ2Oy3rmv+ACo=
X-Received: by 2002:a17:90a:fc4c:b0:39e:6c6a:4b65 with SMTP id 98e67ed59e1d1-3a073240acbmr919712a91.47.1790074937878;
        Tue, 22 Sep 2026 04:02:17 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4c:b0:39e:6c6a:4b65 with SMTP id 98e67ed59e1d1-3a073240acbmr919631a91.47.1790074936903;
        Tue, 22 Sep 2026 04:02:16 -0700 (PDT)
Received: from [10.152.209.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f294d894sm7775851c88.2.2026.09.22.04.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 04:02:15 -0700 (PDT)
Message-ID: <3f31a185-b7ba-4ae4-a3c3-874bac0d66b3@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 16:32:07 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] wifi: ath11k: Connect to the QMI server belonging
 to the device owned by this driver
To: manivannan.sadhasivam@oss.qualcomm.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-3-27dd80d841a0@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260921-qrtr-multi-ep-v2-3-27dd80d841a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EDGiGR3cKxj5WQ5O8-1S8XR-YTCfHr0T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1OSBTYWx0ZWRfX94XiYmbFZS0+
 v22fSr0aDuhluVzl+izMZ3Xk4GgT7bl7vPPjpfA0fU7UcMhF1TzLZrI2q1X5KsioyZ+nJtKqK3W
 Al0HwhzPZNUpOvFKCU80XlIdD69qs1M=
X-Proofpoint-ORIG-GUID: EDGiGR3cKxj5WQ5O8-1S8XR-YTCfHr0T
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab2603a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=bQg6oyjaoxrshYPP:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uJV0Co7Z9vYWId34oq4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1OSBTYWx0ZWRfX06UQjfJvriRe
 mFqy425idcM3L8tz/26/N2CQLCTv51c2Qw6wvMVcDevp65kZVFETgRKVO8/ZHoc6UUEWccRIhG/
 9C5ewsWGyZFN1mNjRXirSG43lAShDlt7rUzINS49+EpIkZYNyjvFvK1/bqfxks9CBB37Q0w3q3Y
 v1KvOdTeCxmhkuKWqffowQKsUNvYy/CfiDCoVazFF7Lrw0D90RA78C8E4nc/L/vD6467YkCNjUM
 G5uGrBiew80tfQyi19SOnHQjLMNUzus1MS8RWZbVAeMF9xWJVmVnO7DtbWWbD4fwyfYyd11Uj/b
 wHS8GiLiyY0d+ex7tS0EiEXRLo5zTpexcDgbTSR8XJ2oBuUpFcqSo7mhGd9+wTSYcSbWjG9zZqG
 JJ6v+v1PwXc3o5zJY2RgT5LFKMRXWS8GaP9gU4C5AL8XFX4cW3Sh9Y18fvhw3mvE0ZNIoa2GC9H
 pKXHNn05YKSJ9u5bcFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220159



On 9/21/2026 4:53 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> When two identical ath11k PCIe devices are connected to the same host, both
> advertise the WLFW service with the same service and instance id. The QMI
> lookup reports both servers to each device, so a device may connect to the
> firmware running on the other device.
> 
> But now, QRTR provides each MHI endpoint a unique node id which is
> different from the node id announced by the device. So use the same id to
> pick the correct server. Add a get_qrtr_node_id() HIF callback that returns
> the node id derived from the MHI controller index and zero for transports
> that do not assign one. In the new_server callback, skip any service whose
> node id does not match. A node id of zero disables the check, so transports
> that do not assign one keep their current behavior.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath11k/hif.h |  9 +++++++++
>   drivers/net/wireless/ath/ath11k/pci.c |  9 +++++++++
>   drivers/net/wireless/ath/ath11k/qmi.c | 10 ++++++++++
>   3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
> index 017fed1b4bd1..0da9025c7ed8 100644
> --- a/drivers/net/wireless/ath/ath11k/hif.h
> +++ b/drivers/net/wireless/ath/ath11k/hif.h
> @@ -32,6 +32,7 @@ struct ath11k_hif_ops {
>   	void (*ce_irq_disable)(struct ath11k_base *ab);
>   	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
>   	void (*coredump_download)(struct ath11k_base *ab);
> +	int (*get_qrtr_node_id)(struct ath11k_base *ab);
>   };
>   
>   static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
> @@ -159,4 +160,12 @@ static inline void ath11k_hif_coredump_download(struct ath11k_base *ab)
>   		ab->hif.ops->coredump_download(ab);
>   }
>   
> +static inline int ath11k_hif_get_qrtr_node_id(struct ath11k_base *ab)
> +{
> +	if (!ab->hif.ops->get_qrtr_node_id)
> +		return 0;
> +
> +	return ab->hif.ops->get_qrtr_node_id(ab);
> +}
> +
>   #endif /* _HIF_H_ */
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index a163168f3617..4d327b5cc98a 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -10,6 +10,7 @@
>   #include <linux/of.h>
>   #include <linux/time.h>
>   #include <linux/vmalloc.h>
> +#include <net/qrtr.h>
>   
>   #include "pci.h"
>   #include "core.h"
> @@ -900,6 +901,13 @@ static int ath11k_pci_start(struct ath11k_base *ab)
>   	return 0;
>   }
>   
> +static int ath11k_pci_get_qrtr_node_id(struct ath11k_base *ab)
> +{
> +	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
> +
> +	return qrtr_host_node_id(ab_pci->mhi_ctrl->index);

nit: since qrtr_host_node_id() returns node_id in unsigned int,
may be maintain that in the return type of the callers as well.
Mostly harmless as it is unlikely that node_id is allocated with
an extremely high id. Either way is fine with me. Same applicable
for ath12k patch as well.


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
