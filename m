Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CB36F8E9
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282902; cv=none; b=Sr3YFCd2XTtjvAb7H9ullSBVqVLbnncCMq4NMAv5XRtrtCmRs61DycwOOHJIMEhEjMia8zwvB825pXcNEOLZ5YRPAka6DngqTMkf7t0jLhgnLAaNrb9Cb8dkWwIXVj33scVLzAqqyXm2vj+PQNANYupnM9i3ehGoFNqc337yJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282902; c=relaxed/simple;
	bh=CVY5b7SwRl6Vq/WFf6i4vxxeBv+tNJ4n2zl6kXlCkj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYL75Mx7p5PmifFKsHbA1dcdUGqb0pqlzQLaFAMNdodtcD+vWjKXzTGGik0/aq1nBWrFkIIemXgjywgl1BGqGyylvP2iks8PPxVuABkA0W+ovhRu6sxFExFD/Y+ac35Avzzg+H1XH7mUrSNXcCRo8M2NqOu17vHaPy2+aY6jArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MkJ6ueZk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=duRNcNrV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MkJ6ueZk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="duRNcNrV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L2wvsU941906
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UI1Tbvhc6FTvaWPxg1sYLXwp
	R1ISlm99MjydVZW2xP0=; b=MkJ6ueZkoMbniUl0k8Zi7TGTcIEqlBhKknD5JoIl
	+O30DzGTMPjWSzKRiRADSOoGmQAzNq2kgBvmzxDuC2Ud+f5c2gItdov2DmwKiKyd
	UoEp0GEmUid8SbuPl8MEcHZrzDBKbnGla4jDzflauXpcwPGc6nIBq8BAkycQWQSh
	U871CWtaT8lu7xo91E+UIRADBH6GGYbDVdvCqLAF4gJgeuZId5oC6lVm4vYwIoIE
	w55gFHoRYUJEpouBscCzjFN0RExPzMAuVf2c9kE7WHbK+xWYwFE5Xs8qBtZeCGMl
	FSOT1gBdgHYVuGwpZZk1hJPg+6kyk2FMfFH23gxM8PuQeg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ecb82nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 03:28:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97c5ad30efbso402839241.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787282899; x=1787887699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UI1Tbvhc6FTvaWPxg1sYLXwpR1ISlm99MjydVZW2xP0=;
        b=duRNcNrVfHbg1C0GtI4qJS/W730LyrZ1NK31PAy0R3U+4Rk8BWKvEk+8W++u5iz68L
         4YNQKGI3AXD11bWiT7tYsY5Fvwn7yBGdSx+jwr8y4uy49/IrP+0poERBleFgYTQdpvs9
         M8a8TjxyED2jOkB5HncDf/x8HjjEWAft0/aQR8jMD66XRPjKcr9GljMC508TMfnLFqjL
         MTK2BE+yrt9/D3Q/QV0ZhQ/3an2hSQPwAzbxw9DboCoEWTcVoB+Njb8Owo6TiF9Gk7xm
         0a9Gg2+hoDr4lPM4QzJsU5V2A9d+bXhm2kbYOMr+suj8N6ouX/L/z8Is8+f3g8t+LU8b
         mVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282899; x=1787887699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UI1Tbvhc6FTvaWPxg1sYLXwpR1ISlm99MjydVZW2xP0=;
        b=kRU2ieBtpMA+eq+P4VfJXwA50eN7OrXyXGI7uwlpAlNnlOH3BtT0dbvi7O8HdmPlAb
         p7XkodXTU+ewNpPLCL/QdfRxY7d9DQhnu6jyL9xYBOzaI5qHqNZsDwhi5JRsBulmS+b6
         XcMsMLbmmBq5NEyO6Ge2DE1/r0crxnISNrEsAHt9QeJhLR9IWBgvvGH5SVOAiKP0NlTG
         P03YRdMW7fE/AJGAe+KUtKOWyU+/Y93tnp/anZLH4gbAU6qxEgjkbbCauYZ2dJo8wSTk
         r4dUOPEkQqAzsifgoQvqUhvpCVFpWspB0aA3BxVarnhCqA36REyVZf6B7ONU7lT5OXQF
         aFjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOd3EJpBo7YJXE3yZz2P1BF5y8IxEsu+h6wTc/RYkHvh8y0juSbuaYAKoXewXSmzu63fXHDY8=@vger.kernel.org
X-Gm-Message-State: AFuF++n8gEYvkJOnrGpS/hNO+cVxtDz/yorj8mv3fKoxSJcOC4hDTUGG
	waMX65MOfOdVjsxFNvO5lOBrC9MaMqDBEuRto6ZaIc5+s0ZPZqRN+AXEdL3yWoCbgq2qARqad9B
	1x4wMX87tTJ/N8mnbNqHp/EbQkBGnZ9rSwicYl+k8Kr8szYdYE0ozEfpiqmg=
X-Gm-Gg: AR+sD11eBS5GPWa/h8tQ7FxQE3O6CNuTQ2dOvchLCtzeBfQsYjiwuHELU6Jzc8Qsnwy
	KBFwE4ge8Kk9wrzhapmNUrH5+44ksFqcyAeW6VKIh413z413peYTJsOj5Rrn0P0Qt5LPx4bptqZ
	dI/O027ozA9xTo8rxhsl5uIUzabrFsQ9ppgzyd4Egb1Md2tI5u2N3kqoCEkQhxFqzfQi6VZ+T/a
	9VnUroqxiL5Qrk9sgCYEodAMlbShP64CoDkBezf8w9IulE8cHhV5dumWMNkHivho8+pp+Yfr4I1
	TqhNQ4uC6lIN6BWgxx+mk7lLktO/FFGN9F9rk3VM05HUQ5VYIFr6jdtDqzrsyiGNi1nbHkupnSs
	TpPYRmW8Lic3oasw=
X-Received: by 2002:a05:6102:839b:20b0:778:6695:2f71 with SMTP id ada2fe7eead31-778f33e1026mr2377735137.15.1787282899204;
        Thu, 20 Aug 2026 20:28:19 -0700 (PDT)
X-Received: by 2002:a05:6102:839b:20b0:778:6695:2f71 with SMTP id ada2fe7eead31-778f33e1026mr2377717137.15.1787282898603;
        Thu, 20 Aug 2026 20:28:18 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm4377106a12.1.2026.08.20.20.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:28:17 -0700 (PDT)
Date: Fri, 21 Aug 2026 06:28:14 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Simon Horman <horms@kernel.org>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ptp: netc: fix period truncation and potential
 divide-by-zero in PEROUT
Message-ID: <qdqufnjopqbl5yjwicf7zsmi6dbvzrq4teyj33pqhtx5naf7dw@2jc32iztcu54>
References: <20260818033342.3154990-1-wei.fang@oss.nxp.com>
 <20260820155615.GA265046@horms.kernel.org>
 <GV2PR04MB11739C05FD4C2D5A8B477B82D88A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB11739C05FD4C2D5A8B477B82D88A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAyMiBTYWx0ZWRfX6jWkY2G89yIU
 XJhOTTVORF2oEPDmmSbxVfagorazfh+TMEBI/fPQYqMRFAAUcgfgCbR0wdRPnOSVMSlJ9eMib6J
 hhbiKsdCOh+Cn65C+Hg+87q7/99UsYurwS2ePlD+zPMj39QkzA2zz1EMD3TYL9hLTo4D8xMfwgm
 1jwrstUXq7bwuVPOqwalnc6luUTkru+XTu7kWq5NFXV6+FwsU1pC/NIvGYqIEGXkb7MX+f7EYa+
 Nz5jd2KUOBMzm2iVGIeu8P/p39Xu9Ll8StizaAizNzPAZHzqFMIOp9m6jAazMSJKCpoWnFBEZOW
 RcvemYYfG6tcgWsBD1PHhwFMTKpmtTAlvoho4egD65n5tWMevYjBipIChGFr2R88SM6L63c8dvH
 rWavaIFP4nzGizwee9zZ/uKd6nSFxkmXRHbqSUhzl0WN8roGhKxWOHIjVU7X82YhVSJPBW+BghI
 JYtW64AYnL9OVn6Zhew==
X-Authority-Analysis: v=2.4 cv=e/s2j6p/ c=1 sm=1 tr=0 ts=6a87c5d4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=8AirrxEcAAAA:8 a=AzQT1qjVLsAWKmEbjuUA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: dnkENK1l_ZmfPJkEFxS7b33EFEKhW1tT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAyMiBTYWx0ZWRfX5PGrJm6KR3cK
 o3W1h6vFNRSJzDZvNkJ6D9QV0W+LFO/qDQadGYj//9GXWdxmd3Lwc1M+sAnSLl4FLPN5a1q2RTA
 XoLl2zcW3RK5OZA/byxlzptGl70HcU8=
X-Proofpoint-ORIG-GUID: dnkENK1l_ZmfPJkEFxS7b33EFEKhW1tT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210022

On 26-08-21 01:52:37, Wei Fang wrote:
> 
> NXP Confidential

Which part is confidential ?

> > On Tue, Aug 18, 2026 at 11:33:41AM +0800, wei.fang@oss.nxp.com wrote:
> > > From: Wei Fang <wei.fang@nxp.com>
> > >
> > > The max_period bound in net_timer_enable_perout() was computed as:
> > >
> > >   max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> > >
> > > which exceeds U32_MAX when integral_period > 0 (e.g. 0x100000002 for
> > > the default 333333333 Hz clock). A period_ns that passes this check but
> > > exceeds U32_MAX is then silently truncated when stored into the u32
> > > struct netc_pp::period field.
> > >
> > > A truncated value of zero can reach netc_timer_set_perout_alarm(), where
> > > the local u32 period variable would also be 0, causing a divide-by-zero
> > > in roundup_u64(delta, period) whenever the stime < min_time branch is
> > > taken (which always happens for a start time of {0, 0}).
> > >
> > > Additionally, netc_timer_enable_periodic_pulse() and
> > > netc_timer_enable_fiper() both compute:
> > >
> > >   fiper = pp->period - integral_period;
> > >
> > > A zero pp->period results in an unsigned wraparound to 0xFFFFFFFD,
> > > mis-programming the FIPER hardware register.
> > >
> > > Fix all three issues by capping max_period at NETC_TMR_DEFAULT_FIPER
> > > (0xFFFFFFFF). This ensures that any period_ns passing the range check
> > > fits in a u32 without truncation, so the stored value is always valid
> > > and non-zero. The accepted range is reduced by integral_period ns
> > > (typically only a few nanoseconds), which is negligible in practice.
> > >
> > > Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > If so, then I think NETC_TMR_DEFAULT_FIPER can simply be used in
> > place of max_period.
> 
> Yes, I also considered this modification, but ultimately chose this lazy
> approach. Since you brought it up, I will improve it in the next version.
> Thanks. :)

Hopefully, not the lazy part. ;-)
