Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF943955F1
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516547; cv=pass; b=Iy4SaqirE0pr7dqOjmOkF+iNu3Yy3V2D/c9MP5HAW6gKHfhxA3GATUxdrbK67nFqcGYn8QSjsDDxMTqFI6jh1Rb3t0EvgIJoypVc+e9bDqwuUgB3jyxRZKJTw282k+4jzvdtKh2RVgSKU7jr/9ppriyKzVdY10/90ImSSGOeiEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516547; c=relaxed/simple;
	bh=UKFfyAxfc2AHZa+zZoe8RHh8COU04xbUZ9VKCkbn7nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSum5ntCpb3iTY7WFqBLQCWqy8nmkJNvVEdD7buh46KpH3d5Nmv4LRFx9/Gyw+qULh1pExHIFeY9uOMRWOGlfTx7B5C40V6J78kQ53mavlGAgFMvECaWbtKG1OoMY7AzEJUiIaOSq1BcMvBP3gu0YVPZkYvk4vwJRfUN6fyQ1ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VH/t6QOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iDCfHh4x; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VH/t6QOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDCfHh4x"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62ABD2646673
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BD6IIVZKV4c5mmZkoHVMchn1BaeZqhuYx+TmbD5+G58=; b=VH/t6QODNBBEPcrw
	aJzTYDSeEGW4Ia8c3WO7HTBlkJrJL7dkJ6kju0a1WUULqt/dGhMUgmOBr7Eci3u0
	pzj+hyXhl1r1xddN7LDeLAAq8w1/DNAKhd/CbVksHrqs2LzE4yMaXNevJdeE3vkq
	GBTuWV9Esd+EviUuuqavIFUNjocdLt0GK9Wn3V0R4k0zDQheI4OSvxKTacLHoZz+
	Gi+3OJ+I7Nt3xOpvor6hJOymnXNDqciWxXJvhKnTIFeSN40GG54nAAM9o5P7XVoe
	UREt3jBfEn45gVCTWwyMTwj5bsGO0+S9RO4XUxqNDpEtQyMVtO8w8Q8HTH50R0x8
	YQq2fQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049kkwcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:35:45 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e9489f62bfso7977566d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786516544; cv=none;
        d=google.com; s=arc-20260327;
        b=r958SLSVnG5nbB5DKU46rr2uWnUc5FwfPGOBM7Mv2mn3NcS3d0/gi37IVkzzDN6G/H
         cBP4K615z+deHTKxfjW7YG7vRU1XeLecXkoTaEhi42UT/51YLDq+ZK1cXFIyz0nZUfTX
         KiBlYieq6v3v7IiwUfRsY+bqYW8SFT0LG0QZGvLzuFt20wUbo16k0fXQRH9LCWAG1QXv
         0I8rCECA2sZhQX3tLnlqfeYN9/on7+78QhiPGnRFFLZLgX2oIiIoUyLcEJ0AxMWPrABw
         M9Xciwo+pyIIzmRovy+zbU+Smjj1qA1U4HizAOZuZcLlDwFt9PNlKfePj65fFaA8Qe10
         NzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BD6IIVZKV4c5mmZkoHVMchn1BaeZqhuYx+TmbD5+G58=;
        fh=dLgU95wM9DqD1EGxkffZ2Xwj4fxq3MGxvT/4g1la3B8=;
        b=VTDfPMeAzulEMJ2r5ExaABsLgizoXlNdOW70BeKorccLCJVuHOm/jxs3Sq2+goIXB3
         NK3OybqzDwDdTJB2IHbD/pEcy6aJy6vna8dL2M4NjTc1u3trAgvlfB7W0Lwl89mZ4sbY
         m5DuqLwB34wWDk4rGcvaViHudPOkQiO3V+k16ZC6h0nlfBCdzxnH6lNIFrM6d5JSLKo2
         eH9Nd76vX/VWwPvoaeqnMPf2NNV2wYWc+GMPCyyTeT98/cL7sF5pUcAE/kTKacDtpWeD
         DtLNtPn3ThMlT2hwWw/nosHdVa+GDuVTmJsvkI98O3F0fe33or4g4Vst85ZN2Fbqj1KH
         rCBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786516544; x=1787121344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BD6IIVZKV4c5mmZkoHVMchn1BaeZqhuYx+TmbD5+G58=;
        b=iDCfHh4xSfOrwYELaSa6soC98DejVv9rg78mng5t1Jo4o/P3qTu/8j9RfifYqnT6Gn
         bOvZG8zIN9bZ5qYz9H1GQsk4bGJvxdiznVIdw3EYvExsciiZ5Hs3gJp4WkCgijRvC5lr
         VVm5pH5SSukOCuTgPMjuOzrEr286C4b+dvfokRB8sj9i9Bi7s6/Z/OUUhNrhW+SxGjdu
         lYitwIMdVJCEOwDeOlbrwsrZs8710vTMyDE5iu/ETGFaMW9SxELSOo6PEkRb4NjBtI6b
         7qkS9kyO3fRMZdkMzG0fejbhhrX0NJWHGY47VwOFaK1Bz8PIS3IZAEtAwzLrXSWn9oKT
         xqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786516544; x=1787121344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD6IIVZKV4c5mmZkoHVMchn1BaeZqhuYx+TmbD5+G58=;
        b=SMhoUbMEJhprbiext6HC092SeTw6yI0yFWUG1g0S7NUu4DG8Tr1RH0IMJplH+dA5hZ
         wpx7hh6uw9OWeJoFjMo1S02bW44R8THp1zWwZoQdCqWX/QtR1Jq+cJNRC7ALT3NfNid9
         NUetxU2igGHKCM6FA+Fxl6Mh/6Qyb2Ou+eHxOPio4OHyo5CvIxV63G6fds5pZMxZCiOl
         cVxUwveOBdhCLvxP6dktKkroKZUSnRsMJVTMZICNtSW/q+QcfeS/YWxIHru0gz1Rek7w
         sZksmz/yqmwmMUSDdsA+8NYMUdU/gr1/rfXwMQ6CClRSaAAGNOAF9mV8m3Qoj2vKlvWH
         GhqQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfviHm4IoxGFmCEUUxLI/g5CYOMAASIdpDYqCj7t7Lobwykmw0Hadyn+AMNi39UGyjOt7eAHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3wcvoweo32ZdolXz8DDPA7VyFs8afTy3Dsdse3ynJvbmzyq8
	9YqRLJNjGS0EW/0REnaB5Gu7PCJ43atrsWM4t6MPjebFsznsUXQISoZLBD+PX9R/Mbckhq/eTG7
	aOx7+I2rleBPL+lkn5tpRkS2eNpeR7RdbHkP3NQAeefIJWpiFpadnpyRERSan/RdURI2hI77zZ0
	fI0J35is/VY+uYhGoH4tyyHh/ZK/jlPWDRxw==
X-Gm-Gg: AR+sD12Kp97uuZywkQkp9UkJorOYCrkqGDqldxMjDTFGDu5iwIvtf4Ni/1HpIHQ22VO
	dSAhuXwJQ/YB8hWhF43tqhnAq+wbOdUQNOoG+Mc9GFyRtXA/z3ifMNIJGpnh4viYjhaHtmMu2N4
	kFdF0pts1eQAHolR/+vbextsMqSybRDxy2Q2YUum+6jaTmAeuFVJ6TVBk3a2AIYIGbFyvsMY5JV
	rm1nrjyscxWAWgicQIAbx7YrHmsiR0at/h9Yz72DVK0nM+YT9ID3Sb9lw5qJ8/3GN4isZWlfWHz
X-Received: by 2002:ad4:5d63:0:b0:8f0:367c:eb80 with SMTP id 6a1803df08f44-90a7001ad5cmr21931226d6.25.1786516544091;
        Tue, 11 Aug 2026 23:35:44 -0700 (PDT)
X-Received: by 2002:ad4:5d63:0:b0:8f0:367c:eb80 with SMTP id
 6a1803df08f44-90a7001ad5cmr21931006d6.25.1786516543692; Tue, 11 Aug 2026
 23:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807215042.2714442-1-peter.hunt@opengear.com> <20260807215042.2714442-3-peter.hunt@opengear.com>
In-Reply-To: <20260807215042.2714442-3-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:35:32 +0200
X-Gm-Features: AUfX_mxzpLAFftiMhVSPoQ8lEsOl7VWetlmRHPSqUPRYAGRJNBVcPAJAWQl7h3k
Message-ID: <CAFEp6-1U_s2QshhUrT5nVhDubJPt3YGHuprDbj8=ps7xJgyP7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] bus: mhi: host: pci_generic: enumerate
 IP_CTRL channel for Sierra EM919x/EM929x
To: Peter Hunt <peter.hunt@opengear.com>
Cc: ryazanov.s.a@gmail.com, mani@kernel.org, johannes@sipsolutions.net,
        netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: NM24wea5RGUbdEFyoC9ANdBiCRpRbUpU
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c1441 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=t2vznHeBAAAA:8 a=EUspDBNiAAAA:8
 a=WViMzPdn84buqVz0jb4A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=V_BghkRpYkFyHJIZkSH6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX/UXo1hIuaurv
 zEkFrqDeRZWX4KNWjpVcc4zbA6HLpGGh97nfDomL7EjZFjAIyvfG6AuNPSQ40Ua2Lgal+ZjpEEs
 /YJEGcP1DJm7vjNhyxGtnyhanGDzUSqPUe9ohZ2geurXmzVmU8fJL3gimMvsHGxyES/BWjdN8+R
 R8V/GSTe48k1qjQRxB0q2RvoBpl+ZyI/t6TCHrMZyp4EFs44o6fBjyI2STfuM76bYnMzIDHZiSW
 L4yOR7FSfTjVcG+HeaRLlrz/0L7Auk0VrGFX7WxUAD8oyYQX5vkVc3D8+KAEGzDs8sN63ck+gOB
 vrPeH2mpeBDwiB3rsLP7sf9tPKeLd98JzT/zojnf1eUT5KLohtwcdNUSEQzFjsCrpM0rPRNJzSa
 kUb3LmIO5l1mJnEb2aUqAO+g9irOKstiEi2RBTtgjWd3HrWYqHRRDUQ8hYxJL8LF7Vp87tPDesX
 uJ/CxH54Iy9A44Fevuw==
X-Proofpoint-GUID: NM24wea5RGUbdEFyoC9ANdBiCRpRbUpU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX+F4N/8fSzYeM
 k75WdVNP0BQsKh89nux9qyRBo6mKlaZL2LSjhQX+stCKFi0tuXYMBqg1915LDr7dGlxdI1SUyrm
 qULzEweyQF1rzxBBeECD9Mr1BiIVZhg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120050

On Fri, Aug 7, 2026 at 11:51=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
>
> IP_CTRL is a standard Qualcomm MHI control channel (channels 18/19) that
> carries the host serial control lines (DTR/RTS) to the modem; it is not
> Sierra-specific. It was not enumerated for any device in pci_generic, so
> the host had no way to drive those signals.
>
> Enumerate it in the Sierra em919x channel config (shared by the EM919x
> and EM929x) using the control event ring. This is the device the change
> was tested against; other Qualcomm modem configs that expose IP_CTRL can
> enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
> it is device-agnostic and binds purely by channel name.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/bus/mhi/host/pci_generic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index 0d0d9c7ffa4b..ba47dd153837 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -728,6 +728,8 @@ static const struct mhi_channel_config mhi_sierra_em9=
19x_channels[] =3D {
>         MHI_CHANNEL_CONFIG_DL(13, "MBIM", 128, 0),
>         MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
>         MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
> +       MHI_CHANNEL_CONFIG_UL(18, "IP_CTRL", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(19, "IP_CTRL", 32, 0),
>         MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>         MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
>         MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 512, 1),
> --
> 2.43.0
>
