Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F723FB07E
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822907; cv=none; b=U8T4gXyOkwy/8QGy3QtntF+JCoK1Qq9LL38+N6DrpV4iiHJRY29rYkhBt196k5sKhcGuQosuft6C3Mn1b5dFegQmzvQWlnYJytMqUN1o7ZoUxWLC30CbkWbb3Ux8wNdlQbLNe8M+Bpdr17hwMhqQtBKjUotXwzuzpEm22EE8d/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822907; c=relaxed/simple;
	bh=9TD884/1eNmXF43nG6KMGGmoxZbFnZmA8KC/ejMW04w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYaVjRQq7wxQ2aYRDBxUC1BWLWiZA0ji2K1bZeabtmrFYrgG2Rb6zsGYY7944n+zgBV/toOKqKTQI5hZ+TNglWkG5CriMB6VFTA2TyAhMVcIuW24L4+u78/6F/VPqUOYUWxWY7EaOQ8N8ZOHLQjwIno2sB+Vs2aj773vGVXHtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKnkbgGq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fTkZyi08; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKnkbgGq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTkZyi08"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n0ER1613519
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=; b=KKnkbgGqOr6Axbi5
	m8AFO+/Jphf+KutD3yzjJBOBGMRnZBe0xFfEDCpHsmiMPqrNjMgEqDLg5As+APA1
	d8qxQEA9OWFnuHHrcNzvJN31S1kOhgBbhvh5O/v/NANPH686ogZ+A6f0Jg11XSCu
	L6oDMxUpi66Stm8pQ73m5lflpH04VKTeKA0zFa1EGW2Iuhg6ljJv0qoye7xW45Dd
	HGtzYmxnVhiXD4HqcQrgDjuP53UqQiUinbMagr+sEQrcnIqU0lXA3SKbPhm8FgXS
	fJ6ZJJDxasvRRXyPxZS1CTAR6hpiohrzlxjtTBOBierePcL5Z5NKnDlfpBqAH/vm
	wze8qg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cuv12-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:35:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c194d1ec0so518601cf.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822905; x=1783427705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=;
        b=fTkZyi08V6GwTZ86ygorNFxoRPMkH3eFEfO36sM+2I6TfgOtjmHxtMP5epbC/4kv3d
         WWzbS+609U4AxUDJCS1uDlHxUcNMIkinGsJGUHauyf3CspEf6cXZf6x/S1bumg6qEyFd
         SscAQVBi6aGKoLZYlxPbTH0oRojgYyTdHyd/ZkfrfpI2JCUYYZgetRqwUOd0F5EM/RL6
         pHeZTiT8cwr/Om39mtWYA0CH6XWhQTNXZsOBDjmAZpw3PF3VN3qYcSj2Rh+KleVsz6av
         eYl5zu3vguKNjo78QRqg48owtxhIOCLx6yFchlIDfN24rjaKSOMC79e4kqKUrWYnWoec
         xePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822905; x=1783427705;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbxXKmb6m1o+wu+br6lLzlt+6G9oYy2IEucIolB22Mg=;
        b=aCoSAcD22fYYz7iyfwg0I/yZolLSlJJ1hYXbZ8hgPGVFD1kabTJQKiCfe9DVOFdwF8
         P//rURKSFHyYDdfsoBnh6yxnX53ulnYtbPTHkkKiG/JeGwm8qr3SFB+iJj5LbqKCCNnS
         Q2LY8LilPb0JoTxvXJrrK+YFIGufEv1N9hTAB0GO2xwEeBHz1UbeC7NaglTFKpNDGFSY
         4gpvNcM+2WITDiAjQBXFoS/E4qnLkNFAD4u6Kk9KYnETA/THbSB2HlbpcUBn2DCNZsIx
         gSgalV7Q23dJgfzNfRVi1+QsuCskaU3hI7o+AKB+6osxHbe3+62teziB+8Uqd18t7jBm
         1njw==
X-Forwarded-Encrypted: i=1; AFNElJ8HjzBJuyAM1to3HwOEWlas4tT5hdzkrfTTqKbTtPOBP+uHGxISbu/QqowC+22IqXp5sdZbG+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXVz9UR1qllBS3oJdhyGFy+ykmuS/bSiDujr2/yWBv7R8syBk
	YNkeAlX4gXlu/7mZWcMDuXpALuXNlBZk/TWsDXAMqSWz09hAHtUC1ekhL6Mi8JJGo0hSFpM4ViX
	rTMaGsCG/7GeLPuGCgc6WSYrB3yRxWG4Htkp7AUYc5yxinT4dqiKddf48vKg=
X-Gm-Gg: AfdE7cm32wFcv3D9ei3EC0BYIaDXiEV9lbBJt9hdtaO+nxO75mAegctNSLhmTRlU305
	77l+oYHQutMQUbjuSJwhOsYvsx5Pi31OCUVWeWmeKeMqCOksj0N4eMt+ILygUs4Y/TWp1jxN+N6
	N/vYm2QEKKtl/frIYQKllkbCaQp9i/wv7d+PF5S2JbA9Rdtud/3iJC9Frta2VbnFPaOgYJYTlmQ
	LVds+L6gHfvosW7yL4Ydu3lZmABPcUhfOPMoHEhxmHX9/FERsduRBPYW4W6zPlpjlkxaoHQbOIo
	RitccIRstnUIJbtzAH3R6t9vC5Xxfz8Gj7dOSiWka27gMOvvtE7T2lhXoUAJ20wdHJOFbLm8hAo
	nxZXo1CcJU7+OeNYgyfx/SpHK/LA4Fl8IjGo=
X-Received: by 2002:a05:622a:a1a:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51c1744f08cmr12929381cf.9.1782822904908;
        Tue, 30 Jun 2026 05:35:04 -0700 (PDT)
X-Received: by 2002:a05:622a:a1a:b0:51c:1744:edf0 with SMTP id d75a77b69052e-51c1744f08cmr12928611cf.9.1782822904391;
        Tue, 30 Jun 2026 05:35:04 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm117506266b.51.2026.06.30.05.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:35:03 -0700 (PDT)
Message-ID: <594cf827-819e-4262-9dff-a35c7f69f86b@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:34:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/14] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX2i+HjTVO3Bbz
 nygL+w7M47PgiaLa2BXzt3Gn5Jw11LaxWqOAcUqB+KyuGFilnDok2JmR/XYkr3JUuIuoHzl70RD
 O2HN4jvMroeY/ZZZVVmzoCKa9zol7Bpb1qZWPE5cc3eRuJkKST+xlYItvrDqvc+iHqTdvs/DgD9
 IDkfNu0zfIzHWTFWW6SdRD9pIpS4ldWbbjLYuRpIdpNIFWJetFXi9tqy63RBz+ljyQViA4rx6Lc
 BOQiC6e061E78NIWDSiMsf9qvLSs4Q40b7zx2RWCeoBWgJYP9An31JxEd6MHP8ZT/ZDck5+dKiu
 puYVxXaJGKemC8kx+p/rMcHLc7s5v3QuaaOZ9cJC96YiBPjJYQTnk5Gl+lm0iuxA0b4yOninXEs
 FRXygWeNjH8f88HeHRBtWJAYlwzBknXmdf6SuB1ejUGcg4SWhMZ4bqXSROMQy6yyFc84ysbZqjE
 /OcydOjO7Fq06Ame+Bw==
X-Proofpoint-ORIG-GUID: S3jJf65SUBZr37RypKTgDEESsOzV0jo-
X-Proofpoint-GUID: S3jJf65SUBZr37RypKTgDEESsOzV0jo-
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43b7f9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JRhjOG_OB-XQkuSI_8oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXztYCNjHSS9wZ
 VzVYfODfzVSFBfVfn0+s6SYuGixWPNAaPkXXC/MieJYAhJSZb1jraCaVpPCb9aJfFpXwWCyNZEV
 Yl3x/7ERPjl+JdYg8sjMQ1x2j9hcnrU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Since qcom_q6v5_pas depends on MDT loader for PAS firmware loading, it
> has to be switched over to generic PAS APIs in this commit to avoid any
> build issues.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

I assume that the leftover qcom_scm_assign_mem() will be handled
in a separate effort, presumably through something like FF-A lend
on the backend

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
