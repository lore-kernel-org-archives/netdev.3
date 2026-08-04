Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601C1AAE17
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884102; cv=none; b=PqxVg2FYhCXpiJsJJxRQpm7vGJ8+hVMavd0jQ4HohREWgz72XA6LA1qUvpNcEMMSKNZoWqa8jtGq87axCvawLwOmV+vDCVZ3vJypu9mubicz86domPPDhpSWfvQqgylzCs9dAwNI9G2h1dN8qFeNXqHO1TR8Q+onqnKNp/r0iuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884102; c=relaxed/simple;
	bh=rICnSSK0eUhAcOS6Dfnz7RRSL3MaPB7X4s9fo+wFHc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTeNK0YddHuTBzZxAFXs0FhnJ4pGT6ZQjHKy2OaHLZtQInweKQhzJBOXPiDbsSa/JRvxKcAIHAxNnz2+Y0t+Gwml4yHRr5CEM3/N7fZsObI+khnwzWDHuoEqePGfeMNUKbVZyoxVsq7MlE+n657f0ADkgdlOUIfw8YtyFQ5Py3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6pCMjA/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NVPEdB4I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6pCMjA/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NVPEdB4I"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlS7f016010
	for <netdev@vger.kernel.org>; Tue, 4 Aug 2026 22:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=; b=J6pCMjA/9UJDNJRo
	VZQTZztpJ6ly5GLfzHWJxCBb2QiXV14QgaZyienmOvFWr3RmOlaLgTzVrtLXsuu+
	zUvdKwTlu/o2Dhgcr4m0xvb9xevP0yqMOxiNs8wo9EFPmgrLDsOcXBUp5fMUb0lC
	2+0LxVsJOf/tMc1H1ztMiXW+I1uAvjrhz7KnYTFDc+jcPQoZoh/dldD6E7bod7Lx
	guG1dghAELXaWSnBpNcX6vNLp859XRoAC8anGPfbj46Yq7XnLAkvtax6NS8EUUYa
	iiBRqbbMaX08jHqmI5JWxGgUiGzUT5KlIKFSTRsZp+uycJqzIGBpIZLYAMoLwJIs
	fKdxgA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23kk5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 22:54:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso422151a12.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785884099; x=1786488899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=;
        b=NVPEdB4I3ThQHBFFYnWxMSjukVxkQ0KezHpXUYieEl6c67ccpiD1NvPQvx9E6CpHHD
         brVFYCg3afNIReucvwmoJbPSnAvpNRdQnfN9mMllFMH9Pn4cwynlePtpqz8S1UjiKBxV
         fJ38QDxGzwGKiT6COipLGiV4pLTj14O+qR05etgeIIQi280wCmVdBPY08oSfrSAY73KY
         aFvV0CifoECKprg5A1RDZmYq4f3OseFCGaTKQeVaRBFZ4r+9umqGw5HLNKWQ2WjzMs4A
         78ZAfTdEwsXeOZUE6BTP+yQ43rI5UrdxayWdNyqDz4j1wod2ftmVd7BjpvScUtbXxMZb
         2Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785884099; x=1786488899;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BiBfYk+ikLNkmDTePEHZK/NFlqks+onn7zyzt1bvM/M=;
        b=U32JKMhjEtru3Ge0pUAmPcmbQQcL9wv75nVki5c/YDlFwp6p6uYV0hWuFbqIBxMq9p
         FXAY+aD7qZNroTP2Q05zBojentYifp1CiQ/Eyx0VZGW/nnbVaF9YYoM1VGTyL62fuT9V
         QrugE20qYb5Rvg4wcfl0SebRVyvEpZq4npEHct6SGtKhv+5mn1rLQ+v5LawiMGMTiqbF
         fH+9svGjGVD/8bJ0kSZyddrMDhTTRLandME4CyyAWY4zAYydz32G+ACVOmQLa0cn2rZa
         SEeeS8vXtVJYmUpEY8wfuMkCEJ/yLRpQCTv50ctocmQOKXITycvfHpdVa2y/+P6TGbvh
         gi/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoLfhBmuEREH5FPjhMiP2CKuicn7MKXoUg52Yz82U8S+zp0RpLq0jyvn3mU9FiuekcszueKQTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/thTjUQvjEUjdcSWJPuDs382JwY4ZPnDAXJvX/r7AbZWi/zz
	v0n3R8Pw41/kienw3/sGJxD0hPTFKQny0gqeBL/2J3nyYg0HmU8W7wzk/V31B96XE2OKsaU4tcS
	vX4fhXeaAIok+UKEOGPkJU2s9Gk4TiSreQQrzkKWXYo8nfeMdKHigwgs+TH4=
X-Gm-Gg: AR+sD13Yb+0X5wz089oEO7moItU/AmzrqUSIJdPAp6ElrdY8aYiAfDvIYRbwxMLjgTZ
	CO1ixzkJRV1HfXy6M79AgrJfFNjNIhzvOa0NcSFhtNUHexMdJvx/kLKAP5uG6tCnqXbm9LKHSH3
	q7PRn/RbHLood4JXxhvWrkFST88WxpqUmD4C5QsZLa1H3VwPFDSKGMWiDYBQCaZCxwyXPOT5jd7
	Ptqlk9j0uUdK5paYh2V3WW442NsqZK5hxI8nGoKV7aSCj1cCyZYpuh6L3nCoHFUy/x8xkTRW+Kb
	3G0GwTooIzTWZ5WF6oJgI6VIPeelqBgmGED9bKzMnc37KSQd+A9CFwrwUSB/00hyA5W1R4BDfvr
	qTme3rPRSWwCRYmKd/l21ZUyWj8cX0rs8p0UF3y3iWD0Hm2MP6Q+17uMId3Wv
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cb85e6689fmr2180340637.18.1785884098714;
        Tue, 04 Aug 2026 15:54:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cb85e6689fmr2180295637.18.1785884098318;
        Tue, 04 Aug 2026 15:54:58 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm10073999eec.18.2026.08.04.15.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 15:54:57 -0700 (PDT)
Message-ID: <72754805-575c-4568-9dab-514e1b758847@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:54:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT net-next 2/2] idpf: remove __free usage in
 idpf_virtchnl
To: Ally Heev <allyheev@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
 <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-2-0ddc81be6a4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fDC8ffTzaGx3Rato7WGWwH3jlWD37Ik7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE4NiBTYWx0ZWRfX502Su6VXdfrt
 v5UBKd2wEWIUt/F5PcaIJ6ayXVAs2TEAn/V/XIcxs111zG0zdxnPb870GoKrB91ql5Gu0ZeLMi4
 6XOGZ/e8rlAZhdkgucwRt52f52Wr5ew=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a726dc3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=SN6AwQ4lagRrp0K9xQIA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fDC8ffTzaGx3Rato7WGWwH3jlWD37Ik7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE4NiBTYWx0ZWRfX70Kpe+9Oybzy
 /2f9/TRYKX/DlMGy+LfV55z7iXFqIxFiOH5gb83uXjJ6c1CscVJDepXLYcq4/aaagNjG2t4sm0E
 7tG2nilEjfkb9LZ7+2eYvgkkH7LKSAPlcXfENkhHgsz67JTMyKCG0mJvjSi9G9A8QrVYF/ebOc9
 yaSlTmEU+D6973UAT82KThLSBkFmgL7f/nbWWIlzyn2zVpa18DoW2p2K6vm3rJbrbPJsrOSrqwk
 BCqjwD29c7zRNMwQxbE1ag43lqOIvmIvES3t22mAQhVBSj+zD9IC+x3KPix+k0WrSaUh5dVYtDP
 +iKkb7Z6PyZ6t4o3apuqCOkFPNEG6yWNa34zCJ83E4YLZ2I9yjXlQ/2O/4nxi4ceqRxeGEY69ld
 FPEadCOVPpPUwlpOUwTJ+tBsX1Zywoo0w1rRt7IqOi3i7nlTiDksMUai5swGhCG84aXwMnTev3V
 amXnItya4bfy+8DKr6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040186

On 11/16/2025 7:56 AM, Ally Heev wrote:
> usage of cleanup attributes is discouraged in net [1], achieve cleanup
> using goto. In this patch though, only uninitialized pointers with __free
> attribute are cleaned as they can cause undefined behavior when they
> go out of scope
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> 
> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

<SMH>

If using __free() *correctly* gives more readable code, why wouldn't we do it?

The only problem with this function is that it doesn't follow the guidance
from cleanup.h:

 * the recommendation is to always define and assign variables in one
 * statement and not group variable definitions at the top of the
 * function when __free() is used.


> 
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 28 +++++++++++++++++--------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index cbb5fa30f5a0ec778c1ee30470da3ca21cc1af24..5b2bf8c3205bc1ea0746f78afa2a24f3f8ad2a8c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -1012,7 +1012,7 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
>   */
>  static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  {
> -	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
> +	struct virtchnl2_get_lan_memory_regions *rcvd_regions = NULL;
>  	struct idpf_vc_xn_params xn_params = {
>  		.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
>  		.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN,
> @@ -1029,21 +1029,29 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  
>  	xn_params.recv_buf.iov_base = rcvd_regions;
>  	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> -	if (reply_sz < 0)
> -		return reply_sz;
> +	if (reply_sz < 0) {
> +		err = reply_sz;
> +		goto out;
> +	}
>  
>  	num_regions = le16_to_cpu(rcvd_regions->num_memory_regions);
>  	size = struct_size(rcvd_regions, mem_reg, num_regions);
> -	if (reply_sz < size)
> -		return -EIO;
> +	if (reply_sz < size) {
> +		err = -EIO;
> +		goto out;
> +	}
>  
> -	if (size > IDPF_CTLQ_MAX_BUF_LEN)
> -		return -EINVAL;
> +	if (size > IDPF_CTLQ_MAX_BUF_LEN) {
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
>  	hw = &adapter->hw;
>  	hw->lan_regs = kcalloc(num_regions, sizeof(*hw->lan_regs), GFP_KERNEL);
> -	if (!hw->lan_regs)
> -		return -ENOMEM;
> +	if (!hw->lan_regs) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>  
>  	for (int i = 0; i < num_regions; i++) {
>  		hw->lan_regs[i].addr_len =
> @@ -1053,6 +1061,8 @@ static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
>  	}
>  	hw->num_lan_regs = num_regions;
>  
> +out:
> +	kfree(rcvd_regions);
>  	return err;
>  }
>  
> 

