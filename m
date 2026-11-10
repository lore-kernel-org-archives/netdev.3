Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794283660;
	b=VUWT3BtiSU54IfRMY77TMau9zxKiorVG7ifWkFYHyFoFDqedFrneNBgI0NGRjT7Oce78
	 KLZ83I+7mo6XeBPYqg609bhN4tmFMYVnBodcNdzQaNvz47q+YSGXt6n6sv+3ctLAMV2Q2
	 dmGEiXjOwiU9Yq3/Ekqc5BmZqnQ4OrGKZJHRb3L8NBJSGyc3z/+FkxEL6Qgt5jNb/rZlQ
	 C5JfXn7UGoeu8L/4TFbvsTpn84ui+SEoEHQ9EeU7lsbJ0doRpcTiEGcCFjkmDjAIWdRmS
	 J57V9JSyt1FLwFiFMF9PCjPdYLuH8J9xAphxMMjvaImgyXMFo5avgTyhDaKLyeRGvxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283660;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kSIDJ9xADSgbR8w3jhiqKFrL226TZqy9jddz1ef76QY=;
	b=kbSKiS/Uu5AszbSz+eMSFSXXUmZiqeIT/hJkbJ4SJq6ncqAYF7JTGy1UOSvqUimFDOto
	 yuIAJmFqCT2EqMHIbkOQCb0iLQJbFc9VnM3pPXFftKQs8LnZfb8Fo2rAFB4dwcBvuLNgz
	 GWjAkAvOi1yf8nlKB3elJuUjFrzU1EzdoPVy0rdoxAks1koihuYWn2BjtWybs+W3QAkIo
	 MYmRYj8myaS0szBetUtL1xqb2X15AoqomNRhMVeG/ELQOu9E+3kHyYnOKpt2J/f3Azjv2
	 BmSTgi5TuTpctKiMzf2gA/90h52eobZ/hMbighwBDF+GR0TlzvSWEc1S9bjKE/XougA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MGOKsDS3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EW4ji56U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854F606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E854F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MGOKsDS3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EW4ji56U
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0ixPx2827990
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSIDJ9xADSgbR8w3jhiqKFrL226TZqy9jddz1ef76QY=; b=MGOKsDS33AD0AnTy
	fzttIr+/DiatPZLguT12Co3gWSeAiF0AtXlDZCeIuA4Pyzwps9Sb+3/jqA4jnGCJ
	JX9N9FlcNy6I9/29RVgwba/xPrhN8QoxEAEruCjWA8F2ft5xvRj7cwejSvQ/tOPJ
	ONnMZd/ZI8E6sZmsU5UeMD7cNEJG8CgZpV90MSgDyp9cbfOdaEy0Xf88VAbBl5gu
	nuViKURSJMTbpCHX4vcPoC4zQEZ0lflBTmQi12/2ykxErRXsHEYyYurGmHTZhM/g
	TICLBc4cd7OlC8HRtjrXnxUd/RyPGMtLn7+rBwdstMFqVjAM0bCVl7u8Lzbavynj
	t7IN8w==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qu6wf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:07:38 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67532014b2fso3293261d50.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:07:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794283658; cv=none;
        d=google.com; s=arc-20260327;
        b=dm7148axjGcJkJfJJpVK7laaU9mlVDF3mvvVVk/xZjM1acyxf+lq1t9ckiPU5FkDXh
         Aj7oB1aV6NYFVNC9gUPt3Z/W67pDdxP3IGMa3gHGtI/pfzLuakc3xiwdpxNowBuSCxJf
         bbl0icpQJnVsmwNCAQU9D7ytKeJ8V/gMaI1x4aMA8gfTsUFYFhBZMtmCuWfyI1IVPcJm
         fs6Jq+81ghZxgAk74Rrvfgq42bhRTo9O9O6CRs/l5gVU/AqEOf7NdL/P1C6/4wVVBN2r
         55RoIoaN2DO67hwPoaL58spDh15O34gMr0RWPzW+tBc9NMbBiFPLVSJrL69T07eTBdj2
         T3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSIDJ9xADSgbR8w3jhiqKFrL226TZqy9jddz1ef76QY=;
        fh=O2XIHzIbZtdzLTA5ANUBoEQ51dzFQZxlhBvGhKHFdNU=;
        b=GavCKC7ymnpHEA+KhLrOlv+Tzzuhxlqo74qua8EO0SWlvPsKssGNx1hlsdtw97I8hg
         T1CrHY1icyIIc0vm5MT7/DDHCydPaYm7BUx97WXTjcAKWZn/KJu+mPC+vrQdsZUpQQ97
         SC7w8g5jF6AKyfMkLEPEMrviuHwCahPM7VgtOX6kDI6W+N8O5FeSjJxeDEaH9phx8FkR
         e22eiPrAHr0riZ92xOtoDFO4QFaxLccxo7LtMxXhk8niEGd8xLdII8jjjpOpjA4oIBTi
         utJOZcTFk7M1eM0MC/ApPhEf9yiPAZv9LJmeRcxRR0+0PAdlvLjJi6RKR7+APc3W2wDu
         mYMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794283658; x=1794888458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kSIDJ9xADSgbR8w3jhiqKFrL226TZqy9jddz1ef76QY=;
        b=EW4ji56UqTTY5m8+Wcv8W/0K7eRAd4p9yumrh1ZKmX6SuUXyknyE0znPjjC7gl1Uy1
         6PN2Qb0g0zs6z56d2QBM42EPOJFmsbhqlFRQb29eInaECsMc6Tuuvvwbeh+SplTYmUs9
         xTzRvLJH/EGlRFqu1ei3LiXeMxArDPY8w1pclQVnO7wacrJRh4NypPvEelJp50IONnnA
         DuHyGCnCjeyB5lKFUQ/LsZdMmVebMJfuDHhuJlIEcJD/mcKoeO+nYX6yyMPGuJSd/Isy
         WhdcoRnxslyd8smMGDgoTXA2x6oXQzmidf1rLRVs5IJzFuTYi4McUKBHwTszCMnwppvT
         0HdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283658; x=1794888458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSIDJ9xADSgbR8w3jhiqKFrL226TZqy9jddz1ef76QY=;
        b=ptxSjptyCaGJgk0Pk/lSPOAn8kAJaM6x2tpsVbEfQJ4Ls1NZzDkvIACFKSAzXIacYs
         uWbkDFBwYpdphfJ/KjoPvBq8G4A/QvL+cZNNiXeFYOXb55qmdtWwCL0zpL2aLk2JMU3W
         wNyEP0HGa3Qv5jqBcFyBP9lj1XoY1yXsFP7yU6+8LyneIXlKVEn37QgDIWfCnOOhOg7T
         hJmdTzjtrkdqf6O3n+RNrYhl3Mae9UbQogmf5sI4Hl2K6a9/a0peGBibkifYf8iTYy8i
         9H1/89W5qhfKMtRzCj8tsGzWDrc9xMkOhvpndP2GslKod7GDSIByWlO+ou6WMzcwsdWF
         PaLQ==
X-Forwarded-Encrypted: i=1; AL+hErGvgEUjwOxkaJ6mND+UgI8WMZygv/Zda9RlFDgWDJnlp9+Z/00+oGHql1uW+iX2TYB805N1ahk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IY4v9Vu5Sa9Z9mWzBgxYs3FNqdfdhB+HQRA6HlNcbNC94HJ0T
	IVJKCazTfgQYor/fl9W3UEPBiYjzvkIARk3wJdnToUsYxWOzxIDLDESaIw2V8g30J/kFx3dOsMZ
	3J03FPsYOVjZzQ1M+3kPV/Rh5MAQt3igHuSUgnw6JDViwPYwnPbqt39xJ6xgMnjJ3j1IuKVbvmE
	dm3yOGhiBa5+8pHc6IdiMtk7/rdoCQDozZWw==
X-Gm-Gg: AYBFou0mOuPkxHlq8DVCc2/XJciuvecMDx9HobTwu4xI+zYh15l0s9rDqVNmqRHc4gt
	GNyR+JlWeNUQAyZm8/cBamrChlIGE/nmsRRzpVGruk+iH/zi6tiwsG+hNPGMG65e1gj8F9yy2lH
	cThsAIRQYiAh2gulSvsfHaFF3NdqcOxzwTUi5pY6rmjx/XrXjg1uF9Y8Pisg==
X-Received: by 2002:a53:daca:0:b0:67b:f72f:c385 with SMTP id 956f58d0204a3-67c5690bf9fmr802108d50.107.1794283658014;
        Mon, 09 Nov 2026 20:07:38 -0800 (PST)
X-Received: by 2002:a53:daca:0:b0:67b:f72f:c385 with SMTP id
 956f58d0204a3-67c5690bf9fmr802098d50.107.1794283657477; Mon, 09 Nov 2026
 20:07:37 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-aquantia-poll-global-status-register-v1-1-808089824a3d@oss.qualcomm.com>
 <12b07a59-c087-4ba2-8d5e-40b2a6d6a72a@lunn.ch>
In-Reply-To: <12b07a59-c087-4ba2-8d5e-40b2a6d6a72a@lunn.ch>
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:07:26 +0800
X-Gm-Features: AclHuK-hodaACp_rHdXRjEOvx5V_o0KFQRlsldfxlLzRS8sIuAIOx5XG_q9mC_U
Message-ID: <CAPTcHHRv959iu-4V6dAWwfH+gRy4nt0M0MGZYL3CCiuD+Gc0jQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: aquantia: Poll global status register
 for provision ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX5c4bb0zOMdxj
 Cg16qGbqQ1UxGU7ouI7Q9/BDx6uRO75z1sTvsk7wf7Aeik/+7PilrGZrz045/oQCZAKqdFZHBkr
 ONvpm7cDmGLalwQNW3VQBYz2W6xdvOftM/P/ImZanbY4WwReMeVlJLXhg4genJjGWp01lto7bL4
 +YNZsd7E9gwWrWqc3nP9Sp32/sGs9o5AV8c7FwWXy/CGy44qUzxyD023FhpqlnKFq3Pj5DDOZM5
 Vw9hXs1iBlFSM5JD34FLEUGLD2529K5bDrIXnF6WTGifyRIPLgnCNlM+NBWnb1oh8AZx0sM9ZXq
 iUP0dqvxMT3QFw6+MlgdiOvlzmLfJ+i0XzY8NMNyJPq2jCkL0ZLmVMVkdNYUDxXVjxwr2hiXlZh
 NHhi6Zbtu7iCV8VZlwWt/f4PNh31BWDD7zNDPdwFsIdWZSqrIKGdBvr7rveXH/yiHsst/H1SE+R
 APMCpUAE/JVQDtlJTOg==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af2988a cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=_r89ylQa7G5OkESiVDMA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-GUID: Gc94Qx9MWBSmZFOuiDWimYhcGyWc2_mc
X-Proofpoint-ORIG-GUID: Gc94Qx9MWBSmZFOuiDWimYhcGyWc2_mc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNiBTYWx0ZWRfX32/+GhVSI7wV
 PguLsxIFt8PZji+o2E0RRwAssCbAxb4pM64fClyvpXzgyjDWNU5B6jPnnyagmDIRHHb//pF4MpW
 ZSBwyBybUhTzia4e0c08oZbf+MyLFEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100016

On Thu, Oct 29, 2026 at 9:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 29, 2026 at 05:28:10PM +0800, Hongmei Xu wrote:
> > After the firmware reset sequence completes, the global reserved status
> > register (VEND1_GLOBAL_RSVD_STAT1) may not yet contain a valid provisio=
n
> > ID. This can cause subsequent firmware operations to proceed with stale
> > state.
> >
> > Poll VEND1_GLOBAL_RSVD_STAT1 until the provision ID field is non-zero
> > before returning from aqr_wait_reset_complete(). A timeout is treated a=
s
> > a non-fatal warning since the PHY can still function without a valid
> > provision ID.
>
> If it can still work without the provisioning ID, why bother reading
> it?
This is real issue we observed when working on AQR113 bring up.
Below is the basis why this change is needed.
In a word, it is required accorfing to the AQR113 vendor phy databook.
The reset sequence is describled in the databook:
1.When all of the conditions for release from Reset are true, a 20 ms
timer engages, the purpose
of which is to allow the supplies to settle prior to allowing the PHY to bo=
ot.
2.After the 20 ms timer has completed, hardware state machines
designed to guarantee PLL and
band-gap stability engage.
3. After the PLLs and band-gap are locked and functioning properly,
the processor and digital
circuitry are released from reset.
4. The PHY image is then loaded through MDIO boot-load and the processor bo=
ots.
5. After the processor boots, any provisioned register values are set,
and the PHY enters the
provisioned operating state.

And the definition for Provisiong id in the phy databook is:
Customers may receive multiple ROM images that differ only in their
provisioning.
This field is used to differentiate those images. This field is used
in conjunction
with the firmware major and minor revision numbers to uniquely
identify ROM images.

Since we flash our own FW images on the AQR113 . Prov id cannot be 0x0 .
What we observed is if we didn't wait for Prov id, the id would coming as 0=
x0.
That was causing link issues. After this change is applied, link never
fails then.

>
> Maybe extend the commit message saying what features will be missing
> if there is no ID.
>
Sure, will add more detail information in the commit message.

> It looks like USXGMII and 10G-QXGMII might be mixed up? Is such a mix
> up not fatal?
>
>         Andrew
Is this comment mis-posted? No USXGMII and 10G-QXGMII related inforamtion
in this patch, isn't it? Please help to confirm if I have any
misunsterdaning here?

Regards,
Hongmei Xu
