Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378723;
	b=QduCCPphc+GdRZnGaULmW58PvXfpQdOpRmh4WOch2l4keJKO7Yw4/u6r/pMJfEs94HiH
	 7rJc6ASUJr8ZDy58Qi94rEckmo6GKR6zxE9aZEyo6J6VjJJcgBNK+AG3jEVYGdxJ6ouZf
	 7l8vSetHewDxjqRxdBUwLxt3SRQVUvUbtay+A7sk/gC9/QlnUsRBULz7d1BNhROG89lQ7
	 IRXtWoyVZaWOH8vz9j4pZj+TlIfLT9lf7aTASVnCcOJl2u9rOoEFKsjeZEiQknfN2i6g+
	 Cfrasmxnh5jVehdm4OLZeuCD0oV+acrM7QAsKya58NEKUVdsCUTALOcgfxTXHQFFfYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378723;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=;
	b=IIc2zJcn92IkSEArFSww/RYNgxfVVkeTSHiz+pKY9/I4hhx39dHDszB6vT/oDtzjcfTz
	 A3Wj4RkpjJNn68L9wJHkWJ5As9ZeHzKGK+RyTrp2bJ8WBjk/FW2NF/nwvTcsUOWrChbI8
	 qp9cTtjQqiw6zVEkc5oUuWj74NUqHKkznJYiwf3HXf38oXbgcT4QcY+oDfIsXX48qZ9+O
	 SWcSkkLxrBRGt7hktvhRS3/acJMh2lDVRZiftzbad+hs5V5lAb+ZHeMBi6neqz0BkL3OT
	 zK+0cX1jpO8tTBoFAGnjfIVF64Yq9wam39DS2B5rpP8uha09ov/SmifmxJTk9LzH3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObMPLRYU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b2Zhiqun;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D7606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 323D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObMPLRYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b2Zhiqun
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERCjY3564376
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=; b=ObMPLRYUzvDQOx8T
	jOmMEcGai/36LLrYr3iAzAd6lGwhObWYTPIHbw4b4hgyzN2RpBVsZFPpE03hd5bB
	QXK0eT0uUvuPwCpZpU70nvpmlmNThdC5YxXzxtPJF8RVtcJSUQ91sGgfWAz7JXBX
	9yCsmxN8y/dWhtFfUEq5+4QkT1q0HKI+fqnMZeG8BeLdsmo3Ymu58LTjxj9FCC35
	jgONqHTr+vWUSHilkCuZZnM3d4S4JkEjzPxOnCgBQ/NqGAgTwbxfTUSc//5SCnak
	Hekq0ajz1GufnHLMFQwbu3Uce2bX1Tbet0Amfplcc5ntcVyxOLI+7XLYCZ3e1lbP
	6ZD0Pg==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm11q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 16:45:21 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6f2e2fdde86so520603eaf.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793378721; x=1793983521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=;
        b=b2Zhiqun1fR36HkZHypNxmTH3OkyvTUwT7fafhZRPJYkqWABlHDJJoe1HU0Jzr2jba
         HXB3zl7ZlFI5YUgX13SKgoDUDSgeJVSQupAbYgbmffTZhC2brV655wLMHNc0xBVdAdH5
         TNEQqBRxgzTVqOB3qU6kYV6xUMAlOZiSE66rq/5Pnm0z7G1vG3Sl4H2fpuPYIwDRBcp0
         LJEWvgKgZT0inAqVJLZYJCv87HRqi8zFv/pYFj6BsqYypfThXyW2rYly2a23cMKlYHHq
         Qfq1oHNV1ZJlPBAu2NUTjq2q4ySAeo9SfNaKt8Mf4UoQ254vJfGjWTcihPxWypwXGoTK
         auaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378721; x=1793983521;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4dVHIRd4XP8wCls0LamSIQUVU6Hcow9GRfU7ul96ths=;
        b=RSHhuxKD0hA9jxl7RXpJ+GmaKTgXVf24+YQicOYL9ewD1+det26nSPShFANk61+cyx
         58OVbvDMT5aDXJ8vnHV6X44b/VOcR3tWL3C7OfmrSGhCVpIz7r16egmAWsMrendRmdeA
         vyzTuEwLBk900qaXx/LHFdbTpdrW5Z/7nANCfGlZtFRqrLUIy8Ki0Zi4QwxTOQuN3WaD
         Smk9QzfEi49Jx42bGKWjZ9shBfXIBvIXyLhEPc3gDHxLu77Aoql+VZw7zwWcqAxmI78v
         A8DTeAIuDDtfABXdiiePundHEMdLnqdOOb3BbsZYjczkqF5vMubMDDC+g0bPg6hJuPED
         b7Ig==
X-Forwarded-Encrypted: i=1; AKwUvBwCATdtU1olotM/RBLQuY0GUVROs/7vBWlGF6eh/prOQDx+3opcBf2KghjFStnb+VXwy8m8JcE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFRP447BbKFPvCHoOjnDcxJljBZC2qrt6CwOCduQ2EIO/HjvHK
	IGl0L8jTPMBuSTTOlBk8VHm0+PlOf5vzJrtBI0KKLZV+H8lr995C9M94SSzeroj+uv+Negzqqpu
	i3U3VXeKA2VwHgAg0vQk87IX3BU27aEJmGEOoQxAulyDCwE5P1ZV9h4T9QWs=
X-Gm-Gg: AYBFou3phXkjFgtUQg1VnStUlG1nZRmhkVb1dxj3xV2qdhRIwab4HjaclPLjm8T/aNM
	6YNWWEPzxueUtVtB0KLd0NNh43OoPBj+CQm76yP03CDa7NPrGpbTS4lm9O+dm8OtPaoEW7WCQG0
	aVM/y4QUXLCKGclBeizBC5RDXXLxg49KvqWYb6838WEatTcMQYXMtARwcs9le99ZQigrpyDT9rk
	iloB3FxmYS+kQotJxEz6ct28wV3FgGD+tFFXDrZMe6pdCQ3Au49feeeaxpjpnjK7pVDSrLlBZhL
	chooC1kaeHcl49NeBBqgXG8XW998EcK3nkpESr8Y62eI7+PW5/kwtKNog3WMzPVYI329o4THfks
	GodyiYZAaiwlPFLe+syg3DaOtw9xngFJxU/laQ0MSsF6SeTXHyeSBjZsNn5+TDxfbuKYkjyRyr6
	xveX6hxT0b8tVSNWsW27dkY5E=
X-Received: by 2002:a05:6820:2206:b0:6f7:6416:a33 with SMTP id 006d021491bc7-714f29bd94cmr1754808eaf.39.1793378721321;
        Fri, 30 Oct 2026 09:45:21 -0700 (PDT)
X-Received: by 2002:a05:6820:2206:b0:6f7:6416:a33 with SMTP id 006d021491bc7-714f29bd94cmr1754776eaf.39.1793378720848;
        Fri, 30 Oct 2026 09:45:20 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2e5b450sm2196842eaf.11.2026.10.30.09.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:45:20 -0700 (PDT)
Message-ID: <6c2b6fdf-90b0-43f3-b5fe-97235aeb4219@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:45:18 -0600
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
Subject: Re: [PATCH v2 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        riana.tauro@intel.com, aravind.iddamsetty@linux.intel.com,
        rodrigo.vivi@intel.com, raag.jadav@intel.com, simona.vetter@ffwll.ch,
        airlied@gmail.com, kuba@kernel.org, ogabbay@kernel.org,
        lizhi.hou@amd.com, karol.wachowski@linux.intel.com
Cc: carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
        youssef.abdulrahman@oss.qualcomm.com
References: <20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com>
 <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261029203000.1763447-3-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dFSNxXAZfdWsjYoGZYXcxGziBvKozCNW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX0PrNoTFLqz4g
 r3fEOU3bkm0p+OaMViwukarpTCFyFlLdmn3HlYvKRgrPsBJwydQFLTSUXOusnk7bCjq9ZvcKv8i
 PJr82oVe2omm+0qilDoGzhwQs/+hGYs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NiBTYWx0ZWRfX87VxgmXNCdxQ
 y3Yo/xFvB3PJk+F/bR5zdE2tNLG7j55nnmnrSMSSfP96LcUPod1bSLI24nQ/0L8+xsAEtduI4XG
 NXGbWYIlLHK43moKBeob5SIpAYNm7X0Ey2G69SAeGUfFdS7AkEKgdNOUf7qxulFwKEPCOHQveeo
 hpEBslu7Och4NOonroqJdbYLng/jGm+YK0523XVHeUWPJ3JtXXg+kgaGYU1Ud4R3m2hppJM+G9n
 bFSkUEbUJphKn0Gm2GV69wSx4BRVoDe97DGAbvqlci2Q9+BRNBX2anvkbfZGu7RkllPS4Lmpy5l
 LAnqVQt7GHeAwBReEJxN5aq9hD+cmAFXd3Te2FvQXiT6YNaNEtyyjoAh2en1jUDhpHpT7g6yyWh
 BFIoLKTAUiMJbUoPpCzHHvN1Wg6+Q6w2hwohs8rz9e+uPdxwzxWkvf8C8/Kqh2FROu5gzNYwsUG
 09XaLQaG1OYaRifmhAw==
X-Proofpoint-ORIG-GUID: dFSNxXAZfdWsjYoGZYXcxGziBvKozCNW
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4c9a2 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Y-R_HQd9ABXJcl_gd78A:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300066

On 10/29/2026 2:29 PM, Zack McKevitt wrote:
> Add a new node type, attribute set, and doit/dump functions for
> performing telemetry read and write operations using the DRM RAS
> interface.
> 
> ynl-regen.sh was used to regenerate drm_ras_nl.c, drm_ras_nl.h, and
> include/uapi/drm/drm_ras.h from the drm_ras.yaml spec.
> 
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

One minor nit below.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index a88fdab7a1c7..a02aaed8772f 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -16,11 +16,11 @@ definitions:
>       type: enum
>       name: node-type
>       value-start: 1
> -    entries: [error-counter]
> +    entries: [error-counter, telemetry]
>       doc: >-
> -         Type of the node. Currently, only error-counter nodes are
> -         supported, which expose reliability counters for a hardware/software
> -         component.
> +         Type of the node. The error-counter nodes expose reliability counters
> +         for a hardware/software component, and telemetry nodes expose an
> +         interface for reading and writing telemetry values to a device.
>   
>   attribute-sets:
>     -
> @@ -100,6 +100,34 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the error counter.
> +  -
> +    name: telemetry-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: >-
> +             Unique identifier for the node.
> +             Assigned dynamically by the DRM RAS core upon registration.
> +      -
> +        name: field
> +        type: u32
> +        doc:  Telemetry field to be read/written, e.g., SoC temp.
> +      -
> +        name: field-name
> +        type: string
> +        doc:  Name of the telemetry field defined by the device's uapi.

uapi -> uAPI
Might as well be consistent with the documentation elsewhere in this patch.


