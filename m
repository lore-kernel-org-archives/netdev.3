Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05803448BAE
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905630; cv=pass; b=XH03YVBdu7FSgxdh+Q3hkLw1b4KR9x+xD3H9PPI4FZ/DI2j8kaXIfwYnMDGMsoQnkV9o85CqFEb9xSRSyyFFyQEZ4B5yKUw4VyWVAbwtIUtICpanW/9KWEOvMVDzFPTe8wX0jaRd+cKPu3NPl0kv0ZwAv4Fvm0t2zNGzWqoYZf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905630; c=relaxed/simple;
	bh=TqF3wLHIA1jAdZt0Tltgjjcw3xRF7uJIwJwkCK9UGR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukyGgysfvxpJP2hdQDR8BqwpS6cb8uFtgNirkhZjpQrP1eqL7hUUDFDDytu69qy0ohH8VM5tvie/Vh1r3rsrvzTPgg3sU6p64w5BhUEVPc25KucSl3Bs8V+oPc9wFFOR31HReXV8wnjdQUqLSLT1sG5SSwt2tBcaGtfuNrlxx1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMNYH8YK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JxpEU75B; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMNYH8YK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxpEU75B"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbNdo2933756
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=; b=CMNYH8YKsP0vLnKa
	kg5kejSOcOGDDykg6w4NaAMhIZjMwg5Hvpg2qVVAeGFA6SXIkFXHAI/V9jYZZTSy
	RttEgtp4bwm6aE9p1KGLNE0/MB+O/oivlVfzYqqXeDZ/TYz39Fv1fPEUWjQMmKmB
	ZOhZL4fM89UgzYGiONz5xZQQ8LEp9cpVqsU7E9WNOiG8/iFseatouKgfxZnlVqh6
	rWFhOjCyVDJkJyyzui4Pk9uGykx+T9GFLHJOTV+t4bciz5za3v7JZndxoHiqDk4w
	c6pEZ4xZYfHEQPLIJ2zTQeesRUAuDTSkH8JP6vyj4qfAeEMOO27lPxff5lNMPRVs
	QuKvrQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cj8grp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:07:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e7ee64b25so67057685a.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905624; cv=none;
        d=google.com; s=arc-20260327;
        b=NqhFq2hitbA1JAnnyrlEP1KwMaSYtgK4e38MDXrNlmb6/3UTaRYuY++pnG3B+1igtj
         crCLPfdDTsm6Mgbe4QHEPyPzWbqU2qPszcYJqZT7iSVm3dSUBSmyl5nw12QHU9ftNdkM
         aOB18tz9/fX3M3akCSUwxBBkbOlXrf0k/+TVVuLzq7hGC/ImkJwOAbly+8Q7fNaJxCgD
         K94yJrhCJiwIThO3zE33vSaHPWZIsbGGzzPEyMVGFb1QzFpoEBhenlVy8FT//z9KJKAf
         eJul964Dir2AK3kiKzBAx3Gn3qPz/Oq6BFux/eyNlPaRpclPVUA8Gugu2lCemeWbqFr2
         gSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        fh=E2fnkFGxHGPiOwNNiI38R5jt22EY1stfvBv6mc+68ZE=;
        b=Y/FMFgUETh5a4Qxiw4oVGfboAgJDtEnYrRlfRUJkaxWTWx2iNADRv9EsM36NNuH2cU
         2LoRcMll/CibGRowezdAghqSInHEO4jR8C9cw7bF2GzzaJHwfWEvFyqSVwCvg6Qq/vuW
         Iygd+sRtQmsfPgMnoTL7C1e7yWHy+pPTCYy4EdTDHt2kY2RHg31Sn5bNnklt0CWOQ66w
         vFOvA2w4iGNXjdySecdXT5QEBc/QMfZCcRjZUR/8+T7qlRewmrALNk9R1yF6ov39SSAp
         GYuz/zMZV6TWgbodHkWDLV6wjTJWngTBP8WtXerGINQvd7E3rTfporFCI3sixmiUrduY
         EzXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905624; x=1785510424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=JxpEU75BJcGFAaPUZ+/wUj6q4yHKXfY+srcPSOK3Ckb61ZNhg6GD4cHqefnm8+C3Wt
         AVBnMScCSDWTsDiCqZMgzmpzO2IabglLt7S/4izdAo5QNYmo9lPP1qNYTCB55nktSkpl
         PEOlnhRQm1E8t7VhCgg+OcAs9P12PJnGc+LQ2Ax9H9a7BprU6n14k6UuyLWBc/4P7QzC
         segY1AS+4t+ZAlWyPN3TzL4REiGQ1GNX+QqC/pAhZt1w2cnLBldPjfG/OpjZty9TMOvj
         yRx7jll5WINMV755kkXIlQwftSOHHiV31VdJA1WxamHS6Bl1+dIMApug/WLStHu2Lc+c
         VJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905624; x=1785510424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=VZNYV2kEQEY1t3GreYb/CbKkW8ulYKf5ASiiwmw+HT/AuErMPmtcoejaGtFKDEfS85
         VhiPOCIRGSq1TbuXCEWSJjvhB/RKnS44LEcmblxWWrmX8By6dsdhu6CMZCBhXznzwISc
         vZirA8PJdM8GGvfLOwzLQ/EejEdToESei9ETBE43YUPFu8OLMZCTTUFLuRD8d8mFdVQY
         hFHhwntUTQ/1g0FpKqDjuhXXDV//E+oJsQTiX+m2aAziESuByqG8QUABncHni9qmPB+o
         B0VSiiUecLKNDJdBCbtD2ORzgT0Tly6sbFLDqVl1hjPty6voyc2NnI3UOeB8yQTza+Q6
         ax+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoL5C5gZ9VTPlyTgziICINxdjilit/PLLvQMroJvaTktIjXLL5biXOwAJIG6WfC2ooDgibGB5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OkhoVJh8VqkTdHaNUvatXPQvMJMCNU+zwc9bfwSlweihW3Jb
	5YzX5iGd6nWEiv5eSj013U9DD3QdRe0iXko96OTb0lNVEwToyO5f93va+0QAGpkm3HzctUavWWa
	ETx7Ok3q0LhUxeZ9ykUAOwBi5KK9MX2Bk6Hz7x4LD4C6XqTheaZUNaF55lOYS4vqU4vfbraB8Ek
	NbCdOxWtQtLMhQw28sNOFP4rlicMpCsC/iXg==
X-Gm-Gg: AR+sD12DwMbb2ROGvWj8U/XDsV8m9f3Kks1pP9LI24NtItzYua4JbLypRFcOVKBa0bJ
	19fNsf7fMk4TG/pwoXSzhTGxPeVwLRTurfXYdHLn0z8zaQAoLeonKD3C4nxlFpnF6uqfbfCBIEV
	FSX0WD+Aszy0Z/hbFZNTjcGLy/Cf+JC8qSLWfAHzCyGgWD9GE6leLoiuFl1g==
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id af79cd13be357-93103a65117mr772234085a.92.1784905623940;
        Fri, 24 Jul 2026 08:07:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id
 af79cd13be357-93103a65117mr772229085a.92.1784905623517; Fri, 24 Jul 2026
 08:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:06:51 +0200
X-Gm-Features: AUfX_mxUpEE-_djVPIMU7ZvWbbzhCFmItK3_9wrfK5-RcRFUSwGHiGhMmnFjL0c
Message-ID: <CAPx+jO9=HWwr4jGoCcWAM6fKTTrg3TphgPiNX+4yvfnyEZa_pg@mail.gmail.com>
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GJE41ONK c=1 sm=1 tr=0 ts=6a637f99 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX0anWFSSgH/in
 Dcsi4g6AFSLv3p1Fat5SIBhipQVArN3EOYNLh+nM7LPCXuP8n7WcTXxIIBk54s0k2Pr0ypORG/Q
 nKqoc3xDe//GTJVULztnwXwBEDWETQtQaZWVJdlFNlOOIxZZXvUdbEb/f59BERilbl0b7NrXh4q
 6E+5Dxh1mSlLD8cySPiGRQidET9wrqNO5FojdLK4wmZk8uoo3wcx1BUL1c2GooVvwO7oFUQiV6g
 tp4iXqUR8CNPHSa/xRspBeGntqwYKQ6/OFMoiHbpsJhw8PxYaljth/T8ryK78zN8dof8yTO/wH8
 pVoOl7YrtmB0xIgPchGvkBWbqsEDXdRrUp/xAXqP1zbBZnp8vLMjGRZTG/7p+FpjJvhwxpACSfo
 UOD24T7Ej7IGNmwJZxbvVHUT8nFBg6IqIfItCIqF+LvA2sMCScAmPtpgP8gZG6ETVz5vy4ZZBCa
 T4TaBswMRwTBkbv06Ew==
X-Proofpoint-ORIG-GUID: BDEVSgDRzeEpiO0GS__Mm0VSsU-MrqaB
X-Proofpoint-GUID: BDEVSgDRzeEpiO0GS__Mm0VSsU-MrqaB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfXyBe6voeNtqKV
 jvjZQZ4vKaZRMcwZDqrSbmcLZ4yDZ6TOwITvtpJGoAJkO2ixe/6y5PyO11zF++0HW56wayDMEEz
 fyA1dP6ewCq16HVw+pqasZDmV9TMTNc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240136

On Mon, Jul 20, 2026 at 11:25=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec870=
29420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       platform_device_set_of_node(pd_pdev, np);
> +                       platform_device_set_fwnode(pd_pdev, of_fwnode_han=
dle(np));
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>
