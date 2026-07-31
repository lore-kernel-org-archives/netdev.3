Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C813E3C74
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487173; cv=pass; b=pMzAVJoVKJVOYml3OXfYqNC1KdLCZGSsjWT+Hdld3Xfx6JYIKdyNHG8Wvdw5OKFKBFgayup9Nq0lKnZx46Ux0qqqmOaup3p324BaZhjjcnCg2RKHT4vZYQvGMdUJbYYywipKf5KVZdYW9hz6ab/4JCbrMY3rDiuZHov+txWmJxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487173; c=relaxed/simple;
	bh=0nzV3Au5hKldE1LyXy81nTzzO98zLS+bllEvCWCXyh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyeAcng0pYPHjRMh9LFqOmf537pBfD6G2VDr4Tch1ANs6FxgT/n+qfFtpoFaQcCcu5Q0EhXfbPJ80oOorIWM2nHhH29xB+w0q0aWfucB87R/U8YXNeVJqUz9VlJ4zKguQJEbgR5zX9BKfGkEeyWztbdmyTEH+m4ut4qqbQqiAN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y0426o5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zm+5p/AY; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y0426o5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zm+5p/AY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8c0rN480279
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=; b=Y0426o5DtAmpV+CI
	pa9mC3woijvQAOSlCbxssCTGjzH/9SyPVjH1jOdc4ONy7HX2LtjtlCQZV+pBSORq
	BMyq/waKEb9hCO9u1nC+yzqk5caF6dVBfg39rEORc4E3d2GR1iJnWThRE1Ynue09
	5ebW5LPfCkp+baXesyO7CTvBAVuI4r+HRlj7S+l8tX42yRy3/qGBaS4hm4xnJapX
	zj+ZUOXWxFNFl6VWRYa89+uKWtPxfiYch5T65AY3hoQSRou9jxqZBw2oLajdiXPX
	nSwn4106VfDFAUzryNFM3GOgDiJR12oimHPrSoryWJ3NgQCOkmKERuam0pOUatkh
	GEvotA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frrc8g065-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:39:28 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81f8ba7885eso23219237b3.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 01:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785487167; cv=none;
        d=google.com; s=arc-20260327;
        b=jaLL+vSfUfB9uZe64cNHDod6kDDA4HZuytpjhlZ1SJ7s9dS1crgJI+pxMeA7rZCyRt
         VtAhsL0Vl2eDg6GF5TWTHBIROIUMNifPPPJlh4cJufUIqxa60xyFNlXxNRQCoHFUnEOz
         GZ5jYSlBhcGxlCa0llk0HPUDodWeDJNT2sPoHy+MR7nmVjED6+srHZKxdjCeWewnOnJk
         K8dril5f+qWlbJXn3VtjdPJf23oaKfrNQ2+NNvUb6TmsBlbc9CBekXCI6DT5bkwjQOai
         2NLJYveiPh26hWyNWl7FPAwT+hHb+p8KtU7uTIoxHPv4cQAh0RUUSfXuB9UOt+/xh2G0
         l2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
        fh=4Hf5GUK0n6zmx9YO9w5Q8K96PHcYjMW7VxvGHq8lQQ4=;
        b=X9Pt4oBBxVvQ6FVu75QQf3hWA7aM8KtcNAmUwyawrSFNFgb47lbPkm6TuRd1bI1iSa
         O7WNOVNSSnsST9+iOsUTgsJhQ0ACnhEUB5Z573kf3k222m0oF0/jdikcWIUzlxyvx6W1
         uNfQ+JPDSjMs+vbl30xq/Wak9sX25761Qwsj4kSaVfcu1SIuwtSMmrhGDOy97IHcx/+Y
         bMuZcHrCbx1AXZ/FcWEO7nuqKt945wtnUJY4i0epryd0C07dHF3xM0pebtVbtCi+IEvK
         dcsKKWFryaQlPqNVBlHq82GgrLt6AHgOTdvRD6ZvnxApmNdMjSFpuXGr2PxxCdI3xwd1
         +1Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785487167; x=1786091967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
        b=Zm+5p/AY5vlVLVCNQAxGyRVCMoZhwl5WGrfKcHgMxSVizAIeQvdTw0SdY+sT1BX3DW
         TtiVSC65bwNbUOhY5pFU5acHiH59SZFjnktppBihXP4ok4vH2zcguIJQmqhZO13zgCRl
         aiAhh/E+Y728/pwAQRloKZKtb44xH7CUw069iNQqGBGtNCK125F6NbVMseKDorteVwd2
         WpVm7AyhHP29gyLvmbx8rvMuoZlGr4tw56jqW4zLE08uj13f7n5nC16DXZxYhf7AKHd5
         6SKpueDWvgKzRfP3tAx71AAGS3MqRDOCdXNGapwmIHBKcy8iTifzefRwC4wK9KSZHYoN
         HigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487167; x=1786091967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
        b=D2mqU07MBFiskJJ4L87k5xfc1sKhtAEhS0Di0rqVjB2iJWViGsBAFJGQ/Bf7i80bnP
         c4SuY5BVizjcGZEv19KUNO4jK4EGuacR7D0tAwChmYYR9e8ZR1mXAp5328OakA3Q9hoQ
         O7PeKhhdsmP0nvMW9H2bZtB2Q/G4NsWWTSYm6bXe065gFid35f6JtH6Sv8s1pvx7cTP8
         3QKfGxEyqmr8u+XByigANzYCI6CICGOYAo67ApM56voMQW7tRsQgafTaH4ULi1iDDHYY
         aGtU+e+zRLmKARWZ1bp1z7yMR/rwBbQBidqTq9F8hW5voNaDwDzJUhlwtxAPMUVlo88Q
         x56Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVXWSMCsBP8a0iw5sffObWvmOCez6zF/KqNOQvgvf7akkNJY1BFt6kAoiuN53yiPo19z3kjQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkHHOq8GTJwALdsDhhRRoRt5DwH6wd52FVhCuYLYxZwUpPMvf4
	6PVeLn1+4CQZBLf6fSbfb5WGcXHH5wPrCuu3KZe6hO2IQ8g8eL0cmqud9xriVlVavmgLRQZc0s3
	ho1+Xt2Z+yM8wI2lkSxO8/x01o2l4kgxRNMUEecrvMRP7XFipnJyeNs+c6/eKNPOOT6Icw6woDB
	s8dLNjhpj9EbQ5W+qOGDfNdFCm2k0P4B8jZg==
X-Gm-Gg: AR+sD11IqMbaMuLsfMEKLiRjf0YaDjHZO7vLlJv+ZmjtnjojDxf6wQ5qz0CtyEUq+6Y
	R05437Ne2eN+P9GEOBZlAlXaXvM17Jy61ld/hISmHjn+E6NTfTmtmLBoxddBxNYcS5s0zYq0ESe
	haXN4tTIV73YJ91db2w5iZyd9U7ccnRxqri9Akpm22/NogVRYRRmto+VUy
X-Received: by 2002:a05:690c:7305:b0:81f:650c:98ce with SMTP id 00721157ae682-81fcba86c09mr6967537b3.31.1785487167412;
        Fri, 31 Jul 2026 01:39:27 -0700 (PDT)
X-Received: by 2002:a05:690c:7305:b0:81f:650c:98ce with SMTP id
 00721157ae682-81fcba86c09mr6967197b3.31.1785487167009; Fri, 31 Jul 2026
 01:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org> <alJpc3nFX9D7_8i1@baldur> <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
In-Reply-To: <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:09:16 +0530
X-Gm-Features: AUfX_myayjkpJROHbmEgd6_YM-8VOlEVu55qy_zXpmBuYnmJ9VMnESXGGquBttM
Message-ID: <CAGptzHORxaftDtf9K5pCLORK0kpdfP4RGRSE9iNkm0Bf+ZqmGA@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
To: bod@kernel.org, mchehab@kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Ixy2F7neDwRQ9JHSnKE5VqXKkY9IVeAV
X-Proofpoint-ORIG-GUID: Ixy2F7neDwRQ9JHSnKE5VqXKkY9IVeAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MiBTYWx0ZWRfX9vhvVCUNxM2e
 A5zfZVyLbdoNMdF0S9zUa/qyk8DUvBGIssoeBxlVba+Eh0DOdL3SmqaCkNw5K3PeZUNL1oeh0+z
 +nOZIDI5xJG52k8toprGq36OnAZ8gsgSlU94w6BpCIv1ZiDNt99eYlIRHh0Er6CD4n59Efusewa
 YUGkrH+l1dN/DQ19RoWElVEASxg+R6SdJHmU1Uv4U/wLLRmZQwxHRJFsQqLNT/Bs5xoujM7fmF/
 P7xblhxhhb5Yt2KX0ZawzcEyQgPCyx8U8juGJIwsXM98gwaW4jrjEVHx7Lvmr5PLE8drqh6yz4Z
 0npP1wh4I/Jc9sZooZ2KZEk0FmTr7XgC+418to3T+CsA9RnfhGYZd1QhGT5D1MPvtF282W67cPq
 q2aLmb1l3TKimG74OglL5ZGAz4L+H57G1YFcfRXNNAInls1MoA0i0l/OKK4BFdunPlc6wa9eSun
 CmyLDoFg/MYCK0Ii+2g==
X-Authority-Analysis: v=2.4 cv=EcL4hvmC c=1 sm=1 tr=0 ts=6a6c5f40 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SwCItUvQPH3YegUC7JoA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MiBTYWx0ZWRfX0/jPZqe48Zaq
 cBYmQ6NrRglFUT7pyi540tyr7mHC0tqtf1tluqgXeLzJznRXUf6cRSjYkh15ls82DCSXAVjhf0X
 iOfXGIQPZ+p4eX7KGZD8dHW2N3BbO/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310062

On Tue, Jul 21, 2026 at 3:53=E2=80=AFPM Sumit Garg <sumit.garg@oss.qualcomm=
.com> wrote:
>
> Hi Bryan, Mauro,
>
> On Sat, Jul 11, 2026 at 9:36=E2=80=AFPM Bjorn Andersson <andersson@kernel=
.org> wrote:
> >
> > On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >
> > > Switch qcom media client drivers over to generic PAS TZ APIs. Generic=
 PAS
> > > TZ service allows to support multiple TZ implementation backends like=
 QTEE
> > > based SCM PAS service, OP-TEE based PAS service and any further futur=
e TZ
> > > backend service.
> > >
> >
> > Please find an immutable branch with the dependencies for this patch at=
:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 202607=
02115835.167602-2-sumit.garg@kernel.org
> >
> > Alternatively, if you think there will be no conflicting patches in the
> > time leading up to next merge window provide an Ack and I can pick this
> > through the qcom tree.
>
> Just a gentle reminder for this patch to be picked up as only the Qcom
> media client is left in the next branch for migration to the generic
> PAS layer.
>
> If there aren't any conflicts then please allow Bjorn to pick this
> patch since the cleanup patch dropping the old SCM APIs is blocked on
> this.
>

Gentle reminder again for ack on this patch. We don't want to keep the
legacy SCM APIs just for the media subsystem in v7.3 release.

Can we consider it as a silent ack for Bjorn to pick this patch? This
patch doesn't make any functional changes but it's just about renaming
APIs.

-Sumit

>
> >
> > Thanks,
> > Bjorn
> >
> > > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
