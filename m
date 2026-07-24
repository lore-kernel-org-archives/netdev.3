Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09D44C661
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909964; cv=pass; b=U/BidtAByhFRaMr0ataAkIS66V5esdz5+MFrt6+hI165JemiMFdR3S+ILI6SyvFF9AB0mgazMOWgr7UOJnLt4nAbD0nbtZN8qXSycmchKvU+qtu/UwKHlz2GTmKFhXJCwRTvsAJpPgul5MyWSMWuArLtRFAoQcNSs3RmGuopWqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909964; c=relaxed/simple;
	bh=2Pz7yi8VnRHhiqlQrvwuFgDpKz5CVC4Q8lP2Pw68SCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzxsUu9uZD5wXUY/QPpM2YGJk7dJicOt6ZOo0ABJmfHDY91i+i5yqk1+9XfovCLyyPsdC+rD3IYBfg84sSaKf4Q7U2H7unyoP/CXrqGQHxXOlN0DoXhFKITvhOQN/l9uUECX5Tt8o8TEjGTocN+DF5B5luzmlOh7OMKGH6mJgO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbVcHouG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBnWBs8p; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbVcHouG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBnWBs8p"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbYVI3196972
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=; b=nbVcHouGe6Z+VeOs
	h7qeGBArJI327t86C+PrctOZsyltv748m/ScDV0HsPpenC1z3jFTg4LyiV6J/FyZ
	owGOr/4SL9LTo2UqQvKh0uDL88gNcHr0uVKuOvntU6WpM2VT9F00DWYccU7reCNf
	3W+Shr4Az7Cj3bgZwWT10I5+AfeG1ieAsn6FNNauwF6wH+zK8KT/3uOxiM0PKJA5
	g5hCgpfIWj021uazh1SKvG5t/yYiUeiG3mZT3crN8cA/gFB3Nd8A8h8MQQObHNWx
	CXusUmB8HAJeYd6rra2az3epDYLosYNDbtF7F4WrLTpOgjM4yHXPbGflsMaEgVX3
	My6sdw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p52kay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92ec91dc265so51945885a.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784909956; cv=none;
        d=google.com; s=arc-20260327;
        b=lKkjak5y9wT1CMGJLCkGozMrajLwT4lW9rTqbi/VfrKIaSoMYgZSRxmagvIB2Kz3IO
         XU2clrDjj27nDbAZOjQsbQTeLJeb3zstdDP4/lcNIrL3XC/qmBNMxQsfJSZ7Jj9hygFW
         Zx89+q6qu0jPNwA5fkihDpHK6Xf1/naKWTmfao7cwSC+WKQvDNq/i3DqloVd6FAXq+fM
         8CPIFcK7oS2MJ9O+BFEBoPxkb5WZgnhVJGvqvJGO3IheDmHLHOV63AQS1VS5H9IAM2+n
         6G0JMHMYoLm+PjA0oQO8iVbhjSaMNNZqXkNhDrxUyBPzIEbDLaksN4NYFU8iBoQxBLtj
         gnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        fh=0H4V9PK+ObWhFzY/3kKveRR+1vEFIliefxP0sLsiBC0=;
        b=o3ELrYxQt1gygNrx+/Ln5Zyzv5xyOXlUnw3ecsr/Fvfbgvhl3D5HYT6iTb8K94czmS
         fRPp3hJ0u1mU8JpZjQnfYTu2pwohvr8Z+4QCmliiPLYbDn5o/CeJoNQd0LGdBmsWvUTU
         d7F4MiRLjW+Nx/3TdUli+kBOvThPFpgxUUna2Y8WbzCWjtDv/de6xn43Y5sT3lgdS+Vp
         roNGbW87DOTcxRFsr4fTH5ObEDX1njYTiBAPXZzZQo2E9M8aNB9b8f4xQQ8BDqory+eF
         c49jn0yuICG2gHfF3QRwuSkbxfYs21j43GL8jQxAzihpfBOS0imaSaTXFxAxvbm+1yCL
         msLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784909956; x=1785514756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=QBnWBs8pQw5wzNA8WwdaOkxUQQF7Ena/XK3A2pUYAMvQPPyb581gO2Mi/SAXt4VDxb
         pJNJe7B3v2OfgFRxwFEEBcaCxpmAOIGWUzmyQuttmynAImfQD73xIZdZl4l0P0rERPJP
         /lpeco0LGrc68SVmmkfXDi/Aiw6UgwokLKaftWKsyA4eseUOQuApP6mrpcFDoGn1Wdp2
         XzAotZjdfQ0eU3U+C+NtkPomPdCRd4j8kHoXIpQM7ncqY9xHNmrgaWVaQoVZS3puy+79
         pPlDzrHQ7WmKBGJy7BPyjCLZwlU5rtEpJaNSb/4DoSuZoS5RoR+vhvY0bbEDi+a4G8IK
         uohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909956; x=1785514756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=dcWSSOQzcgpH9y1sQL8CCxaOtiimzj2BgAM6c0cf32hv4zaQHG1W4Ridq0XGxoTXUN
         EiAQRV36iWHVD81Otii+Owj9P5rFwEYUUInOhH6c/AkL2Gc0YA7jilNtk3kX3+q6g8bF
         +kH6n9XFQWxHddVWrVrUeNvmc+ai3W43Ey1cIp0B7pk2DPtmwfGDwf84XRc1zDMfCq9p
         0HrXO+Om8O0WVvNCfEPJinTA8b4o3gpZoF8ZKMy/V+IbhelclJVHXlfiZl0ecz10vime
         VuuT5KbCWyq7PJZRJDe2wCjTPllNOyv6Yp7j1OdvB906qNGE+Zt7mestWiz9v51+A6BG
         yH6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpi4Ihe9S89GKoOeJrcc/LbQyuTrF/wcfH2HdDI7/6eLYHrYi6E2ylyzYnz5T6hyXQK7vm/k5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF214HNTbSRBei9DjvbKwqEB9Do/D25Mo0OAbycKAbpcOenljV
	HWvr5Z4K5wBq7eUPGK52Zl61uTvtpyWbA5NCKBvcwEwe6knQrtRlfwObNu0vcHelR6CF0AgX3Ft
	/wfjMNlvgbfPIman02wVi4XPpOzPmGgkHSpADykQRGZqCL2JlLNCUsQuzt0PCoYuskFtiuBMQ0G
	jZtKmxp9UnvlQB/bNiRL62zWyVpoVXXsWzSQ==
X-Gm-Gg: AR+sD11HchXok0Zlikgn4dW/mCtUUHcDpq/Tzo43XqiZkStzZAp6xxQy1n3UOPHiYS0
	5xGPEusTCiUyYy5rbnYxqRTbxOBZG4KGu4NYDyoEM59maXZmcrHDnRIf+5Jf8ljra7/a5rf4l5H
	rwi52O0Gkd6JH4k2bzt5/HHiJxBhVMu89S2RhGj5NFW9WIl+Uz9cSKHrAuFLVHEkYg33kX7vLHH
	0f4MtZ9DoXdlfbtdYzAHl+s3fEer9fAKvsXr1twZbmQyLxOAcQTanICzZ7mlgZ7+6Tw1GfTdHw=
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id af79cd13be357-93103608240mr655010085a.35.1784909956442;
        Fri, 24 Jul 2026 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id
 af79cd13be357-93103608240mr655005485a.35.1784909955860; Fri, 24 Jul 2026
 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
 <20260703-block-as-nvmem-v8-5-98ae32bfc49a@oss.qualcomm.com>
 <amLwz6WuHYUwKKJo@infradead.org> <CAFEp6-1_iariDyqWj0KezHAtULSO+piPHX0F=Z46Rx4KDNLmXw@mail.gmail.com>
 <amNkX6HV7c_8jRUa@infradead.org>
In-Reply-To: <amNkX6HV7c_8jRUa@infradead.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 18:19:04 +0200
X-Gm-Features: AUfX_my698y_ctqeRF24VMWwW_1w27mTDvVkuG8C8ZhXfnEBEfynx8DYsYuY-cE
Message-ID: <CAFEp6-2sZTBba4isNDmykh1X0HCxoeWQb5_bJp7AGQHU1E+MLQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] block: implement NVMEM provider
To: Christoph Hellwig <hch@infradead.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a639085 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=JfrnYn6hAAAA:8 a=-e8Xlw_gh5nxI56MKtwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: XGtk0iGwpdoeb1hU11tysJ6A194zh7eR
X-Proofpoint-ORIG-GUID: XGtk0iGwpdoeb1hU11tysJ6A194zh7eR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX2GCl5HN6avuN
 PHRMXkjZVxkgvOeslpRKasYZd4t2ml2QyjWmWERLQMQnk0ncoTcpmAWx3JD3q3ZHQjEJeFsgMrG
 3yecJwjH1OiHH4XH/eaqwMXG5cX63S4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX99TYDkfrxMUs
 ST+CRilMk1LDeW4LiR/1TMdqNsJ7TSnIey0ErRnjgyD0HN+DCWs3xXcAXciqrqunu1Wqgn9pKcr
 Z8jp3OU2+yRz+UnGook/bU41V/2e8jN4mwVFi3sM58GjH/AiVwqH4N8LaLh7VXkoKGc3SXwQ0r9
 GFNH4RCJ62KK2XQ3v1kAxnB6e1cmadSXhzGNEpV2WullbI48qsLDs1FeB6ttim5RvFrpy6EjU2p
 BDgt5gWQrQHKGsxtAXtqSS5lFzTERz4mhPtl8oS+gJJEqaA3kRK/aH+dYgyWyNs5HAWTjmWmd7N
 Ot3gpSR2u87DB3IM60WlHu75saFOH4VhR31b2sLn6EEQpVod89/HOdwAxEuKF0yiiSQN9AP2/pq
 CDiM12Av60/Uwo15ww7ps5pmsALtdghz2wLFlxAWTIv4Gxcr9+Tsb7SIsf17Ox2PsD5LDq9JRje
 56E/mNWoI/P6Qymd4XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240146

On Fri, Jul 24, 2026 at 3:11=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jul 24, 2026 at 11:10:58AM +0200, Loic Poulain wrote:
> > Right, I was planning to add partition support in a follow-up series.
> > But since this is really supposed to be a block-agnostic feature,
> > whether it's a disk or a partition, I'll include partition in v8.
>
> Please include the partitions, as including them or not matters for
> the interfaces.  What is holding that support back now?  fwnode
> magic?

Yes, there is a bit of fwnode magic involved in partitions of/core,
but adding it is fairly straightforward.

>
> > > Also once you register the whole devices as nvmem provider, we really
> > > should keep it from being used a block device, shouldn't we?
> >
> >
> > I'm not sure, the whole concept is block backed NVMEM, so we still
> > need to add that block as base layer, though we could discuss
> > suppressing uevent for it. Preventing block usage would make the
> > feature much more intrusive than other NVMEM providers like MTD, where
> > the underlying device stays accessible. And we may genuinely still
> > want to write the disk (e.g. for factory provisioning), updating the
> > very data the cells point to, etc. There's also the layering aspect,
> > if a disk (e.g. mmcblk0) has logical partitions on top (mmcblk0pX), we
> > still register/expose the whole disk mmcblk0 as a block device
> > regardless. So if a disk contains NVMEM cells, I think it should still
> > be exposed as a block device as well.
>
> So we now get two unsynchronized ways to access the same device?
> At least we need to prevent exclusive openers on the block device
> side.  And document the side channel very well.

Yes, effectively, so the simpler is to open it exclusively per read
in reg_read with a holder (exclusive). This gives us proper exclusion
against other holders, but only transiently for the duration of the read.
It's the simpler solution if acceptable.

Another option would be to claim the device for the whole NVMEM
lifetime, but currently we can't bdev/open the block device from
nvmem_register(). That path runs early, while the disk/partition setup
already holds disk->open_mutex. So that would require a larger change.

Regards,
Loic
