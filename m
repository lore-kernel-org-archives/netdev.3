Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A437F33F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248706; cv=pass; b=Jp4IzlQgAH0G5d8kvl91rAIQebCcoX0ktBeD+Av4Yn1IqsKnZqk6ssnYRlJoUUo6ZewX7absbLnVJJ03v+rLKHs7j35GU04i/N95Ga6lX4gFLMK7I5+fzld4j9jYOqRncqQ/JGXD/yCHwL3h93IuLTfxMfhbeYW5DI2I5S0Bm9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248706; c=relaxed/simple;
	bh=W/KBqgVEZ6BGWdyr9sMiQFsjqiUsQRYYmdY5gVUp8nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOabLQzpEb2Zsin2G0cbqE+dZJ699HLmwoRWDzIN5aJ0U5a+4lEB/qc9GWRlCbOsrUPVLGuYTVOQGtu5hWn5FrA7PLTbwWA9EOumSZscxPB08TW8mPPYReLeLt1OybElcrbvAeq8WkiWhOghfyx6khnK9wUDpaJ2Ue2d+DU6Au8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TbTUhYOb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Svy1Neb3; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TbTUhYOb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Svy1Neb3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O9Po6K1270859
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XoGEOFWfy6+z3llqYdSXWY/bWsrgXF1kF020We0iW0M=; b=TbTUhYObl5ybPmO7
	9By5S/eHO/yhPRBHy4RpBD5l0jePTuqcfJleu600nLB2HYF4p8cDTvqbcteqy9kq
	P7oWDRAVMzp04OTB2tPZlNhwqGYKXlKBy5kjOlz3kchPs3WuxTB78OKYltLh+Nds
	3h1YksK3QiT6+G+GdFwVrRGTL+lHXG+A8ZTJH7X8WsfCmNaA+jsajQpHKQKZZsdc
	Zv1hlM9Xtvd7gaXLeeAtKDCzcxXTX/d5Qjs+smijCvm6b0Nd6QdYjXQffGVF1pxz
	KKl9xZszA0NvJ/yAfgrq2KQcqSzMOgOo7x9TJHlLEHLSI+8On8nHFKUmvuy6CKJO
	1XLGHA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr90ar5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:18:23 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86917d18880so1618816b3a.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790248703; cv=none;
        d=google.com; s=arc-20260327;
        b=RQ3I4ruliLMibvuExt6pI2YDQkgpkrxcSfbziYt/3POx4WS5kp7DvULkyndbQHUHNb
         QHr6HO8qB8RbcBHUPdxUrQ9hGVeZe3zRvk9vo+eAUjQokHHS1t4iei3L6+B98/me275P
         hPmwRu8MHakMNcwqeExxC3jlY0bxKLF9K5DPPTBoynBtg1QXfMa6tdrEaWZdaHEqUevK
         srP5kJHiBHRcnAMET2iDSzrd3PiicmByv2Ndr5k6OJUHF3SDxS55Xy5RslNdSarPELGf
         ITW0O9p3kKd85ucRzMOwln037B7q5Iqw0ywNrfJo1vauDvjPQfIdQ/dnOKseaIwTNZ3p
         ST5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoGEOFWfy6+z3llqYdSXWY/bWsrgXF1kF020We0iW0M=;
        fh=1t5cbjXFW4cy652r2OrisPz2rdCN07PfuKZprzEKfr8=;
        b=RndnP8NvSOCzXfy52H46xNXuRaMeMhcpgKZyDgv5zzsKCzd0UVIrv+EEcN0K04NU55
         KPkoDk9JsxTlE6MuVBJict8M3qGrKrgIgqfkg2Am1q9i/y+zsVPJYC7hVztlhxecKbpP
         abPxr+SIFpzTsH7uYKXbYTj2bla/otqt9g/+lW9L7lN/2R6feAjtYBdw9XnB0iRIdtm8
         ii7oThiHJpjLoBeBrFCEcVUHCV1lhlbzijoCLlV01XQoGNREDrq91AlD7umkz5rojZ7o
         0crGaJoJSTOU1tKzaa/meS17Ju87qmO0DMw0QzLiolwjlIO/FU4R7XfR3Wo8KVojuM9e
         ejCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790248703; x=1790853503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XoGEOFWfy6+z3llqYdSXWY/bWsrgXF1kF020We0iW0M=;
        b=Svy1Neb3jjss7OFoyGlvL8nm/65TFag2OzFrat0SzKhU3eENXDPCyMOL5seNgIgLWr
         JG9cNvSf8VMIIWhiRx7NR/oY5S/bgASsVgH7WwbtLnUDlts3h6/Dq7sC21urClvdPQPV
         c/iHNH6QtaA7b9TNpPvFe+pyjuB+lqhTdii+7yYoFhLDfcsYyaPM/12ws7DV8JZ8aXXo
         p3RdcxpaT8nZWWV4E7ZXIoZ8U6fMkM92nudul33Qpmlky8bq1VswUCZvHFny0WDxeHyG
         D8wVwfr4oiMs3b8h4ucZv0uYL3KjMikIHFWIA48ogZZa3+bSyXGVek94Zr+mcel6gdvZ
         Vqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790248703; x=1790853503;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoGEOFWfy6+z3llqYdSXWY/bWsrgXF1kF020We0iW0M=;
        b=hnDQyU+GM3BvOvU8ht5V/UQ60ph4tZoK/XzprOBTOcEfJ+hTbGdujtOM9a48TGO9iN
         nxc2vQu3Pg6zWgyKV+2ilXBwLGwQLYGXRhlN4bNB2s64NIkoYiX9nOjJsGPVvvzBH86B
         Cypd9TGD5de4LOPGHOoZr0xqafQaWoOvD/7sDuEHMWv3FJRw5liyjQETD29CHybLRyNP
         r1fsf0TGDLcsCrAVXO+vKZXvP9ucJdRduzlykjKu2WgYKbugf/wS0EzE8CWVnU3+Gs4x
         TroZ3t0sEiyjdmohS91mbACCI42uHuFfMC+QSq/+c5NYdOJC8VOJreeXSsY8OxyJylxV
         xfMw==
X-Forwarded-Encrypted: i=1; AKwUvBzNbWYWJ/13B4juGZxt6iextmlGNkzzzrXxKsM/mnk9fNV5koh/jxIzFx4uicnuu6lFffYqpzs=@vger.kernel.org
X-Gm-Message-State: AFuF++kJYAMEnNGoxsW/rUEK3V7VnUYn0dME6y0dizb6m7FsLqunH0Jp
	bRwdEoVoMy35gdfy64of7sHpI1Z/zUJf75mdwTY6e4MaF+03iB6WDKhnJzqMdBKyEqqDMxgCYjR
	kAPuvrmiMEZJoLU7KXT8nuqsVlLPB63k+6J/94hml4JFlPdo7w/DdvYmub5FzuEDcxVsVoej5Ml
	YH0UJQxK0MB1xSkoBEl9rES90IAXiwtGSltw==
X-Gm-Gg: AYBFou0hKGhKBgEp1yF/6Pnx5rdkl4T07YCzeCVdNkMAQgrvKUA0skhkZTTScZm5k/u
	jpFC3ziDpVWlwvBYq21eQ1Nya0drKYb+69FdzVSGMAGYglsQyHwCspteuUDxB6ULEpmnf6QOion
	BAm1cbzjIoDGR37gkDHxuIyfMcQXhTuQJW3kjtNjf+lgfshXFoETx+zcO0AA==
X-Received: by 2002:a05:6a00:23c9:b0:878:3830:a489 with SMTP id d2e1a72fcca58-87e9fd15ad3mr1979693b3a.57.1790248697929;
        Thu, 24 Sep 2026 04:18:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:23c9:b0:878:3830:a489 with SMTP id
 d2e1a72fcca58-87e9fd15ad3mr1979654b3a.57.1790248697236; Thu, 24 Sep 2026
 04:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com> <aa9f1765-ca8c-445e-96bb-4c768ad55623@lunn.ch>
In-Reply-To: <aa9f1765-ca8c-445e-96bb-4c768ad55623@lunn.ch>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:18:04 +0800
X-Gm-Features: AclHuK-44EH4bNDTkJMwrnDWVzEi_hMaghscBr7mHEKsm2sHbLj2Ihaq7X1e6I8
Message-ID: <CAFkd8huag=oW=jz6qPeu9JfqAWc24b8DeT5veRVvS_nqMuFjNw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Nord ethernet followup
To: Andrew Lunn <andrew@lunn.ch>
Cc: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        mohd.anwar@oss.qualcomm.com, maxime.chevallier@bootlin.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX34ziZADrVHUK
 EBw+HLOc8Q4UMrMWgc7vrdTK7hRY+ft1DiBpdF9H5/vuw6MYCyLckuUp6efQXbYHC4jIz4NzSlM
 zvBlzWVH8xCNSvtu+2ahfpRtQUSKC34=
X-Proofpoint-GUID: QoApUBv4FVSgA7tNxcs-W46LgpXpOpFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX4y34abWFuFIM
 eWmct2WWI+SvPxg0OZVhUI36YjafqTZ5wMnk20IVQWCkB63dQQVad9akoh/6xLK7PfEE/xmQmcM
 zwoJBs/4O5EiiW60whij2W55L4Q+ZUtq8pDthrdDG3LGxA0mRehRPBFGcPeHPBBJ6Wkuguun25P
 AChwQzDfHdMQv8DEyW5RNyWPwjXB10H8B1oTDIQmw4K6+/65x73CUfkZgahKVu9zA8TKyKG1vhn
 9ArQa9PqK8CMk4FzdlUQ1/+pGEIx0cw5xiykMjPn+Qq+2ZYk/5w92eFjpIbON5Buvl5TYhTFf8o
 NAa4nckekw2M0eT9h7gZ/PfBiW91Fjri/2X1SMikN/gNmm7vzsojv0jYRinMmysdwQWC9MUT7H8
 1IupX5z0vZCe0zyvmbWiV+iz0LUmmxreJTPHGDF4OCXUWkSsYAmYAXZig2ijn41Xo/NEWkNVleh
 5VzHH8LkhmkBa0P9Q7Q==
X-Proofpoint-ORIG-GUID: QoApUBv4FVSgA7tNxcs-W46LgpXpOpFE
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab506ff cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=DPsbyGdE-c6e5f9Z3pwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240046

On Wed, Sep 23, 2026 at 8:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 23, 2026 at 04:49:18PM +0800, Zhangfei Gao wrote:
> > This series verifies Mohd Ayaan Anwar's patch set:
> >
> >   net: introduce Qualcomm XPCS support and add Nord Ethernet plumbing [=
1]
> >
> > Tested on both IQ10 RRD and Ride
> >
> > The full test branch is available at:
> >
> >   https://github.com/zhangfei-gao/kernel-topics/tree/next-9.23
> >
> >
> > [1] https://lore.kernel.org/linux-arm-msm/?q=3Dqcom_xpcs_nord_emac
>
> Please don't submit two overlapping patches for the same driver. Wait
> for the first patchset to get merged, and then submit a follow up
> series.

Thanks Andrew

Understood, my apologies.

  I will not submit an overlapping series. Hopefully, some of the fixes
  identified while reviewing and testing the RFC can be incorporated
  into the existing series.

>
> Qualcomm has a number of Mainline Linux mentors. Please talk with
> them, because these two patch series are not great.

OK, Thanks

>
>     Andrew
>
> ---
> pw-bot: cr
