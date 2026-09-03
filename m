Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099183E8357
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418182; cv=none; b=EpV9UcKPK6b7d3qwtVoAAl0taxnIALI2sXOQVpsk70z+A6dbBEvdnajYiH8qSIr0tIiRXxiLufL4aeqPD8LdWVG08ae4Oeb2lHdnPMrVceKMM/v7N105YYdFbQgtUPCwMHnnTbg2Dxq2N4e/Au+w+oH1lz2RZ6pAjDnzFsiMDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418182; c=relaxed/simple;
	bh=8VraffC5BKkejHmJdMksu0LpOfb2HU7NmdH6wjOmvrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6POrm5QmKVPHu+jtbqRnJbr5q3cnSkw1IwiuRVuOJWsy6L5qFpIvWPA5N5soHCXTL0It3DQ1lyDe2SpWoP7+P6/4/ry17qXbetFM4j9pWO/zziD8VxX+kgonGJQg2hqc+wclz70I8Tq/m6Loi9CO5gL1ZcbaMo3pgooQ3hK4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blP2OOD+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gM4iy3q+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blP2OOD+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gM4iy3q+"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lQZq2596701
	for <netdev@vger.kernel.org>; Thu, 3 Sep 2026 06:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lFCKmyK8dAOrbMDfK/y9bBG3LydVBne7sXQVgWJrSN0=; b=blP2OOD+OBnEz0KZ
	dil2gbYrbsBizldaMvz9GXwB1tkzZaxB0DmqxJT/NtTsPeEKG5dIFKY7fb34tgEC
	HnE0OOhDZqcTTznCMJAgLRLeb2m0gEmRcMAk0op4ahjKHYil51FYsNVCxQptoN+b
	XeGOJHY8zT/HDynjAQ25IqjviJcnWy4gLrdt0yfKw+JMOJHYqpYhTcBN4DwI1FSY
	hvpZWw3SdEaoc0A0gEz/wecMOEpiXTW96poop/fH/30uE4KBB0RSk7So/l9NrUZy
	eUQtSadHAzZ183T67zM5QYUbxewZoNzeFlzEP9emxAHUpRO394MUhEWwFFyqcZ8n
	hEK4Cg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja3ye6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:49:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21be5bb4so4310461cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788418179; x=1789022979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFCKmyK8dAOrbMDfK/y9bBG3LydVBne7sXQVgWJrSN0=;
        b=gM4iy3q+S/n4ZIItsZDQLxQtFeOv8FhYyGBonA8OEofBmfH9YzZdbFMcnNDTTp2Y+b
         L/awb9+5zto1g6zqrnxAtVANk+cSYdXjYKS9QYe9y3OfQlZS3nHcAWRFVxWo3tCybmIT
         fIah9w5j1TyX37PqgYiHMAZI75K6/HWq35LQzdrTOBXftQ1K3wkC0vDRJcn56r7DHu8h
         9bPPrEk2fBaFeQMKdBLZCB8UMMsDMjyWEnsB74mAwjRa1C5pBuiFUt7vQTAF7sNVbche
         Yo2+fF217FAkFMuVN2uBJPCsH9hKGG8aXwoMq1wvERULeBqmLg/N+4oIX3aFyDVCBKqz
         eJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418179; x=1789022979;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFCKmyK8dAOrbMDfK/y9bBG3LydVBne7sXQVgWJrSN0=;
        b=ZzMPZhxi3oWCGSBfapUx4GUhburzW1f6wSK0qCoQfWI3L6WhALw3GW9a3EdHW3TdN8
         BBtJ+PSGK6HOMlCdhQ1e4PuxueqlnG+yWaKrHkvtQ5uUoO1q2/oQ0Mwjo+ZFDxwcmix0
         tE19UZhUyyUfWydmDS3+UvAHTXPaDgSbIAUn1rN9AtNX/e6KLF5+dU1acuhAIkKDM6y3
         fERwyJ4pWkJ4yv7ugD+X45leDLotiyn2ZOd1jPMP9qkITAK5by/E8RJTAHR4rGavXDd+
         Np09x13VnWqOyLa2pYsqBD2MUD0FC1aB6SXN63u5pN/dW+3nd7gSvEdtUDm+NOZ2mARd
         fxIg==
X-Forwarded-Encrypted: i=1; AKwUvBzjhx8Juu/JauNxHLt9Lky7fvbmX8T+5RdJBBGIj/C+XihKqM1CxjUPwsTbJtCfd95inSovB7c=@vger.kernel.org
X-Gm-Message-State: AFuF++mmvucnETnFUvBSFrRIUOeYD/o2ZjdQBuW2+oV8+vj8u/IwtqWG
	ig+8huRIjy4QgAlhJQRT0dyg2fTqBlOv6zOPApsR4tHrT9RKs+H7mpdzmJZUVi2hFcYEjpFcJH5
	TANgZmHCJUKrVpRQOmWkaMuqvC6aEByfNvivYj4ZfMRgpspHjFyWfV00TH9E=
X-Gm-Gg: AYBFou3pwSeRsuQYLtAmb/dqVH9DKAfeOL2aBgwKeCuYUczHeZDRW5gaBcMv5FZNqm/
	9y3wHWANzZ5QIok1yFcs71xxBFG3I6PNnqVkl+SIKwSy9DrlIQYO4ZHw6bl3QL0NyUY1sxHdqKs
	s4Xl39XKos/7UpKfvWBdSQKBu7wZ+HxNjEUFmDaxQXNo5yi+5ud+GeCniJRuxgXGmmmOUHZXKq/
	Em+P+a/FtCv975BkUmZ2DwX7ELRHC11AidjLAB6ItyKIRLkZoGQ30EiNDh389iJhqbaCn159SUS
	OpfyRAmT+VyMm9tAF9q8xvxf8hPGDiEUIS59aOVWCJgIdjq4r97q2XuyV/z6kEZ9ToteV6g4PO1
	jSdUINuYS0xVsIYBv2o1QWw==
X-Received: by 2002:a05:620a:370d:b0:931:23a:83ca with SMTP id af79cd13be357-93961007ae2mr777142385a.4.1788418174277;
        Wed, 02 Sep 2026 23:49:34 -0700 (PDT)
X-Received: by 2002:a05:620a:370d:b0:931:23a:83ca with SMTP id af79cd13be357-93961007ae2mr777128585a.4.1788418171248;
        Wed, 02 Sep 2026 23:49:31 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895e14sm1779131a12.3.2026.09.02.23.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 23:49:30 -0700 (PDT)
Message-ID: <91e5c863-43cd-4703-842c-7bfaf2de877e@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 08:49:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: add
 ST21NFCD NFC
To: Kristian Brox <isyourbrainfoss@proton.me>,
        David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
 <20260902-fp5-st21nfcd-v4-v4-3-ded2f1c501be@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260902-fp5-st21nfcd-v4-v4-3-ded2f1c501be@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: InCNPu0l0HmRsX1hIKDOZQSDmXcqofe8
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a991884 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=FWA6L-ytD-VELHUIOsEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1OSBTYWx0ZWRfX+m29b1SY1voV
 NWPmMJiG8TbUGoSwCN17uq8npUx5aEegVcD5FkzYUYEwkBoA4Y+hDEp1Wo/TM9TV2spZt7hG5IX
 EF0l+Vw+GxQQ72pAdjhZ88EhJt3ubto=
X-Proofpoint-ORIG-GUID: InCNPu0l0HmRsX1hIKDOZQSDmXcqofe8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1OSBTYWx0ZWRfX5RSJkAyfA2dd
 vokPPN70NWmn/y1irO+/l3mlZFXzZw/1Bn1lh9oYtvCpsc7F0geQqV5ypgwZq7g6Fnnom6KBBYW
 XmZcDhfPPj5qi+fbgh8WQ+puMf9tuGG2gVklANcmj7lMASjPexIYEvBaqWxKB8vVRo+FQ268Ou3
 AfLh4NxZ61VT+Bx3LW8qOqHTFMZKJ9SnfTk9so8Y6UrGXNr01/eGGjMfn8WvVRuYPv9LE8W7F3m
 dp9+xeC1xVfaSBhbsyTq1SzV7nByATVZFHej3F6+YXSgyjG0rMEEFF4R8kkmkN4I3L39eU43u+7
 YrdaGlXKAQ+izn0zbIhQQJ5w4Yt6lBJkTfS7cXpm77a5Eppem2Kq3eelYWXdb5tBqrXR+3D+4Uu
 T08wzHg0Mtt6A7DrwjibrtgoTEehLRayfM+QjanAC1PdgYgqWjpzeqdnDcEpzJ5bOXBg5bitWtp
 WQZr09ZSxaI22XDQexQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030059

On 9/2/26 11:22 PM, Kristian Brox wrote:
> Enable the ST21NFCD on i2c9 (0x08), IRQ TLMM 41, reset TLMM 38
> active-low. Compatible is st,st21nfcd (raw NCI).
> 
> SYS_CLK is LN_BB_CLK2. VPS_IO is L18B (vreg_l18b). ese-present and
> uicc-present follow the public schematic (NFC_SWP1/SWP2: SWP_SE to
> SIM1, SWP_UICC to SIM2). Reader path is tested; SE/HCE is not.
> 
> Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
