Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C429BDBF
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413085; cv=none; b=j/FjQsAhr5pjWK9eNiVNxqoqoKrWgR0oW3W2idW2nj52ThiiG1YpYuwMvKpu0HBD+Ao/iWP5H+Lohj7eq6EgIIlGgCmcLbBTQcVuJ8qLjGA+6aJh9leeFI0sxlVlOE3s5SdkwYtE5w0IdlpgbbJ8PKrlU7aojlodPNknzg5OUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413085; c=relaxed/simple;
	bh=8EGxWuYlQ7OXKhzQbvph7ohelP0EC9V3y0OQ4e+V/kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcb65L0eQZI71shIuB65U1NI4T6qXpSYR0V+30gvzV/fCvMGFt0h7RhztNdMwH2FM50SXoYr7NXCdloI6vo+uGu5VsTBLD/R8FQkasKeJDFV+2bw3UvjmxNtsQr65BxPcvdWk4Eqc1URZFLzQPjdL3dCix7nm1PtpaNG6ddQ1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PgXxb2lP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZAg1ldlz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PgXxb2lP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZAg1ldlz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Yhw52688721
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	txESpfZ1KaTUu4rWKR+uZuZxaLU8Tf/Hk0bNSZQy788=; b=PgXxb2lPr8/6R74a
	4EMF60QmvDN4AltVu/aRXIWapYshPM/aRd4TppnpCrjI/2YXQZXRbZiG5jh3glSM
	uujC8uFb78h+4iejMiPiX452wkGFjRXatOYLOr3oX9r3bTTCqC/Ga4GV+DK3cAtt
	MJLjnjk0WlKolKmr0hV6zrQkixIrEl0RnSJMeQUKoUuBchNISoR+n72biJ1+KHhF
	rURKfkxtN41j3pfXzodr0d1rFmjtDh8ninwh9p9QNbkAeTmJnzo+mag9ngY8aOCk
	EJP7C+hrRL6ViFFbY2a3N85q3WHWyxjkHfgFuJMHXkW/kwToWiu7zmncNykthO2X
	bftmYQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn0v8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:31:13 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf97f74492so53631137.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792413073; x=1793017873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txESpfZ1KaTUu4rWKR+uZuZxaLU8Tf/Hk0bNSZQy788=;
        b=ZAg1ldlzUi6CYYY8ljiuPoxvdBkbLUKpE7q0SL9Bza0lpWYffImNNc/L/anl+JKhxP
         Fu54ET93EWJ4aa9s9UXD7nz/cfq2Q3tuH5dWa3N4051Yu6b++UUfkULz2EkB2KtKAiI+
         p3fTdw3KwES7/ficD62FWOD4UuGl8mpMAtVw2+rBIGRtEQsDfSwyZCCYSXw3yPD4Kthi
         cAL5qC6/6psfA0czXfFiOThsYq9SGUFx3vD+Av4b2S0vrN9E50XpYvnl7/k33YejISDt
         q2B/yX5NR668LgWk7zJCCghWS0X33yNOcrHY5sbdhlyCaGbueMChi09jRCaKw9XKDSyE
         8KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413073; x=1793017873;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txESpfZ1KaTUu4rWKR+uZuZxaLU8Tf/Hk0bNSZQy788=;
        b=aCTdJxxwC7hqb8vVe0Y9r9aCUu0svM0y8uvWJAdxj4+/fPY0qLVzmp8BmfsfE0CqfF
         tekqA/7ZjBaGbateNvSODezOCfMRf6OBprl1dDt5ib/W6IVBjNP1V0HlTj67KtedW4zq
         dUuqfilelwBfeC6wDjuQwVNAxXOPbIPHacQ0BcIQpyVCVUOGgfYvZTHGeTyzqiWtBsbY
         Sx7RpW9AmZyThXQIrYY4pDHN9cLZS+6T3l9HRUtrz3fEJFuLECcxOyYZZkVkYn6oCIpK
         e97tyP2Ecs+wclTyHpyiiBjm0zH1J/QnSCo52GCrMbD+t9WCuL54ZRRNvN51VTrE+mk7
         ++aA==
X-Forwarded-Encrypted: i=1; AKwUvBz5ATcqWgdCQXFuNWQ5dsRZ5I6g0p14FAFOiNqAev8TqM4FUG0i6cuXm+NLwtEcnAMT23XxvHQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0VkrRHliFU1ooHtGPke/oa8m9pVvTCZU9F5D9K9IDlDZ0vwHJ
	+zYnDttwElAEmRskbezsuXoivQrAqFvly0cxH3M3EMaY/y0o9QDypTh0G1HQ0pVAjKG0XUmgc8i
	DybSbvHxdzECtMBZFWxercvx43yADuqAF6RmoLehEKpmbc+v0RwjUMAOAHSM=
X-Gm-Gg: AYBFou3AD8DGMnfdo1lDS66fsYY/aPVp20K6Lhr3bRzB61TUHJPYUiGebyVYmhllUmX
	khEuzgfcp4J5hl6Da6vVQcbNc96iYSPA5jvTlcponNfepvglClHQEbJwBzvhjNJfGaiLmF7Wxv2
	5hDS3ubueKxejuPRuklYKEimh4886Ryb+Uv4brW2rYyo6UTZkHXYr2iEcI80/vdCRQSrshRH3Y9
	u/fBBVexUWWTjiEhZ3sjleX2THITmZ5VhH6bm+2mRgNZkTXYmqznoGlpmogsq2lpl6GsveOTlNS
	YpVwA/JvWXQY+/4gulL4v+DDruzkHdQ7HQMHIsbmv09rUY0jV/oADI7N1b4Wy0yMUF/Mt0tJpIi
	MVPX5sA76wa95v17gXv+t2g==
X-Received: by 2002:a05:6102:50a1:b0:7c3:91f5:26d4 with SMTP id ada2fe7eead31-7cc369efc05mr1517839137.3.1792413072757;
        Mon, 19 Oct 2026 05:31:12 -0700 (PDT)
X-Received: by 2002:a05:6102:50a1:b0:7c3:91f5:26d4 with SMTP id ada2fe7eead31-7cc369efc05mr1517832137.3.1792413072286;
        Mon, 19 Oct 2026 05:31:12 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1ea48bsm3601007a12.35.2026.10.19.05.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 05:31:11 -0700 (PDT)
Message-ID: <e675b54f-9eae-46f0-a207-02580fd0b974@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:31:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: lemans: Add Draco EVK board
To: Gopikishan Thawre <gopikishan.thawre@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
        Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>,
        Ajinkya Inchure <ainchure@qti.qualcomm.com>,
        Anuj Tripathi <anuj.tripathi@oss.qualcomm.com>
References: <20261019-lemans-draco-final-changes-bringup-v1-0-dcabe94f1074@oss.qualcomm.com>
 <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-lemans-draco-final-changes-bringup-v1-3-dcabe94f1074@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OSBTYWx0ZWRfX2ixC0R/idtlH
 85iqn6pIoHHK1KQqsTiNIJ73XxD8EinT61cmHdeg2DJGVO4bVrIAu7laQfh+oXaiJXvNtDlUy9G
 tWZ8/CbSPDEUHA7ybWLLzajWwxU4nmk=
X-Proofpoint-GUID: EM-1zCq0i-2jObmaaoEViUXMJJI-rRqH
X-Proofpoint-ORIG-GUID: EM-1zCq0i-2jObmaaoEViUXMJJI-rRqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OSBTYWx0ZWRfX2C32oHuKCItS
 +WM1jAqTMh4xTwqePTJdJzBljLBA0SSi+noTomE1vSJ9UZUtX4+Q/QsmvqBim9QPsT/RJMQWJux
 m8jXEvkP1Yom1ez4mzUB4RAxlJwzVkpk5y3l4B59/4LiVeNZzNztYaMHNFPRHEMBPWOhqihJTRq
 TrHCHTYH0TZmmgQBqtjnfAUC9XzrxZa+LNdNRhOGI2WXRF6pHXiZU3HUTDEWwrwIQIh068pl/Mo
 3YJ6gjRO4i4Nasc7ZyuQmhOJFt2GuD/q2nNyUzZhCcgthrD/a5xA5OGAVURb90MQaRtEG9+ZN0l
 1YzHSWE0cCyC/8G0bZbygP/dgSA+CWZCzLx1m4Ky545YhuNfa6z0i0RF+fVLSaK3OHJnjvN2DVF
 ojjvneMwGFmQB30K7hxpP1CSswg7SVuJDXjYmMCjfwnnQNaVfPe8Ll/Za+kXQ0Uw3rMGAPNgEOq
 SEbY4ZVu/5AJooexA4w==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad60d91 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=2y-c5VRBA9tA1ecnzscA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190049

On 10/19/26 12:27 PM, Gopikishan Thawre wrote:
> Add the device tree for the LeMans Draco EVK platform which combines
> the LeMans Draco EVK SoM and Draco carrier board.
> 
> This device tree adds board-specific peripheral configuration on top
> of the SoM, including:
> 

[...]

> +	ethernet0_default: ethernet0-default-state {
> +		ethernet0_mdc: ethernet0-mdc-pins {

Please drop unused labels

Konrad
