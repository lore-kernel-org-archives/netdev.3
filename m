Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474F4DE73F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361739; cv=pass; b=NJUF8rJ5YqfGdY3dFste/bJVrWOTGt02uRy66rbScl4Sjx6MchzbLCiXJkluaEN7Y+dmLDlidmp9e9XNVAwrk4aGOMzTcdGqKilwwqzATztIJIShV3acYMq6hgpw+oEQwaFwUoHmFh0PCYBIDyaFWJQ5cyPI9w52zcVRMOIefRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361739; c=relaxed/simple;
	bh=qe35OzbfSn5jxEUxVU2cmzIGiFHK7xWuk7f7gKumZ4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHLJRm/J8m27i4LDyd+YVbu72sHUACL7+IlsQMOh7rvPSmxC8HoEkj6xxRBW05RS3ZgnylVKXeyj46heBvwzx2snzbVS/T6uDWVDI6pkdlIy+agST+W+ETazstYKK+Bnt/qp4x1ooEeyjpP6Y9OR4que+YCrjsDG8w48b9hiPYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSlUeud9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLqMAtOF; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSlUeud9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLqMAtOF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG1ONk797091
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=; b=aSlUeud9MMrnTvaE
	fBNW17DTlK1pd3VcwQpUk4ojbblR/A1hMmRDFhOv4r5cy3OVu8i2q6RmCi/4vkuZ
	vUfJnemh4SMXjd7YTf5sbLQCTkc017+cBse1LMO1nsJkHCEWniirrH+WKHG39Sy8
	my8Qbas7L+ScsIZTV2pNDMGhJ3LWocXSDZvk5Td6QyumagYlnF3T/M65woH/CUay
	IGqzzkIMWOsK+Mg9kxItyfWdlSbMOxtpgASz+AMsYETe9UpdCinK6WF8DBzpNC6p
	SaGtAz+max3hYXt17goBn1g67FdMVjHnVQNwOXVfg+HpnIOlmupIwqr2msOh/dir
	1yJ5vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3ass1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:42:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9390a2c895bso334654985a.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361734; cv=none;
        d=google.com; s=arc-20260327;
        b=SRZ2xaSdlxoreg8VZ2YxTvNB4Qhn5Os0DyJevB6FqJLWQDm1JJ/J4mPKLBiF3XnXyv
         pY7B6CNy0F5fB4mQqQJrfXJrkyYcm3CJj3JFPpG34WG0g2uR5Sz1LddlANYBxG+o1fCi
         qYyeYKZyeSexatesVr8dPrfuv2gR7BPw6paE59Bvc5fxwRJz037P57PJIR8GGqVrC+Zc
         O7jGAof1osWwyMF3qgqkG3gMakKt/Xsf6x27zhBLBw/vdfCl1hb8YeK8v8c4yC+v7aH6
         xfDD8sQL0qfNTOzLgh3AW6lZ/XlI5vZktwZcWcleULm8fGi/q4Pa9D2PjzsjHK8IzEME
         skPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        fh=AQ4h/5AM6BGGdSOz8lbDD6udVoiMYfh+dBkQL1Xx6ZM=;
        b=OkNbHSLO9RQQBSF9kf/+qZuNNjEoHQ4v+YRTPyRLnKG6hN9ASs9wfd8cj1XbBQJqzo
         mdc0mQ9vAWaBwIgNOLkBdEAiL9diYY9t3YbunFprD2RWm7UbPFEBY33t3zOHgroEcgSP
         9EdDeK5zMAJmX+GJHUO2CkNhCsB8r8jNXbBwhOAqi4XOGiEWNfbanx4DOw4BR/tkibpn
         sWK2Fu9eFg+cqQb9AaHeYfTHe8heFw2q7GpDF67T9jOCKIAfXNUpTiKR9Gf1toT/idCr
         HUp7Spk2cZSLMYGwvNvVvCKbU/ArLqKnvDGKDv6k6NQFlQWmHOjtgRECn8dd8CkQ6lSh
         ltrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790361734; x=1790966534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        b=MLqMAtOFgcfL9/esEM7x6BGxofK86YIE1Fei2550rmKgF1kyAQlJ7ay4c9AMp95V5F
         9yVqR3MeECJxN/rljFLWY8Y8cH/y9dErI1SDMfWjRP2T6c286srna7fLafAgf12jJNhb
         C3dUd0We4dWIfe51+7rlrCq4o4SInafcewYvXgEfvqw032ew14t/HA12/kHlUjnorEzT
         Xk4FEBXlguoF/nQB8KmmRq+ZkQq01LvbBb3469/GB1/ktBO+P5lX7PuPxO2z8L7DaBId
         ZzYTL9r+nufOK+2xNUxp1fhF8PNMKIoObRgTMhZiPFhlIeXx0EXSKM6iKcZYxwBqOAmy
         v8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361734; x=1790966534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        b=ozFzE+Vtq7Gc6QjgmsjvbJVUlM1zM+jOkXTDShga+8bsW4R+uygKkWW96APmCJpvpW
         nVLUFOYVj0J5fU2Wr3+08NsVBZ9JbaLg5g05OiwAK0MljFjsPm0KG7bZreRReMm0gssW
         xUtkK1r43iZmHlQxYtfhRMSCRlFUAw2qTExi0A2nZc2oze/AgNWNDQ6mHnXyuKnLTcnT
         mP6GLktjXZwLmh10VFRVirEVJok2C7//fGK954VdQejRW/A9L9U4sNySHSbiK30UPM++
         k531yZtorAHWDOhiRxjbzu3ZvdSshs/0URNd/dwRcvl7MZO+Qvxr6MP3IblRxKbopE49
         VUxw==
X-Forwarded-Encrypted: i=1; AKwUvBxWYAqPX+w4lKh+oWpLRGhP4o7D8NdZ6DGoRDKyCMsObPIaMugwk47/EQ4ThW7AHuBuPJ9EvH8=@vger.kernel.org
X-Gm-Message-State: AFuF++loQfaUm4iSh2yv9i8xEADtFCJzjZDpmw0x1+6qHuhnQURY8PkW
	1aHNd6NGyvhxYktOIwXKUkB5nDdTiO/zRQkzsvPAb9eYQnH2D7FtiVbzbZXhs+ybiga9kKS9/sA
	6Mkw7mlhDPXMYdDlM6ze9udi2cTqm39z35kpJh7t0yksEC+wfC6kDgFz8xF3gIUYxgBLxrrLkss
	VIteZ6rCcxYV2HIKqhUeS4XgTEERzKrt4DWA==
X-Gm-Gg: AYBFou3kplZ5uVCT+6eWYk8egTGewGDCWUy0uvi0GQrHaXjRQfOwfVSSdCaZVpLl9YB
	zbbPoAYcavLYtBw+TcE62eHCaCbOcChLeBsKyzo9MOPh+pY6AIMzRNNy2Y4xj0+aUswQ9wyNxK/
	1oZLX/khRDdUcUKFecHMfzzGhGXiIAvDugwhwEhrKj2Bug/ulaAk8A94tdT+b1aU0gqSgZ83zwK
	AlipS/ANnAJs3WdlaMLg4Njye9Z1BmPkCXakgQMv94pQXGkCF43PL242aBu8pzBYNA6u41glMxB
	EX+zbxHSrmwedGdrkRxo54drxl8T
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c43cfd3cdmr614937485a.25.1790361734031;
        Fri, 25 Sep 2026 11:42:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-93c43cfd3cdmr614930485a.25.1790361733529; Fri, 25 Sep 2026
 11:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
 <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
 <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com> <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
In-Reply-To: <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 20:42:01 +0200
X-Gm-Features: AclHuK9eWyYSXO1LoWJtwtSLZuLm-A6-I11eiFIWKFJB95hJR5ZP3c6jJQ_Yo60
Message-ID: <CAFEp6-074kS9GO2TFcR69fMjuu7Y2Os68CzWs-KUfmZDYaPZ-g@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX+zLRvqxpKBkR
 9apqSkw+GOozrEotlApY6Do7rZ6cSc5w/glGsqT/e1/TEyVKb8MIQ991wi+gK5KR2YAFNRQlVaF
 S1xXI7ODaNcoELecGu6lW+uzGd++tqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX69TlTCBIpx3c
 kLgGM9cRZQrrIax8iPcJ2RwVMtlT24Xlv9upS/0qe+zyt3bA04JIPWEUt5yPhzsZJoRm4QdGH0t
 aVb7IYWXwZ4GhnPXpm5HDRzg219eyHDCL7Er/URIqjha6xNX99lh4sslv4uv8I6OxcnbxVa4t14
 MwtN594Irxo/KZOajUjcw59CwaahOrE5tk09RidO3zNXxy2IRZwZcoIE0CpMIPX5QemFHeuuBAq
 drFVEEwIaCXMBi94orT90PteIBns0qHuOba6vPF+7HIOZWlzqPhTeZ/argcG5ifsOyVxfvmudXw
 Ti6xZbeTfNcocrP4DEPNw9P6d0wxgIWmSAf3PbeWLsox1QE8oOw+yc14m7eXlxemTno2qGnbzxI
 IKriNsCBPjaAA2oVIJ7YjISUoqTeyVJv7J1qUgDX/OLNBNcs1r3e+MH1jslQE4KDwaQf/nsNiLM
 e5C97xaM78L7hYqWnfw==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab6c086 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=8pm97rweiJCjLsilNG8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 4MCwFG1DLWLaGrqQaxdfNWz8ubPMzOK4
X-Proofpoint-ORIG-GUID: 4MCwFG1DLWLaGrqQaxdfNWz8ubPMzOK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250074

Hi Jeff,

On Fri, Sep 25, 2026 at 4:10=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 9/25/2026 6:38 AM, Loic Poulain wrote:
> > Hi Jens, Luiz,
> >
> > On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@ker=
nel.org> wrote:
> >>
> >>
> >> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> >>> On embedded devices, it is common for factory provisioning to store
> >>> device-specific information, such as Ethernet or WiFi MAC addresses,
> >>> in a dedicated area of an eMMC partition. This avoids the need for
> >>> and additional EEPROM/OTP and leverages the persistence of eMMC.
> >>>
> >>> One example is the Arduino UNO-Q, where the WiFi MAC address and the
> >>> Bluetooth Device address are stored in the eMMC Boot1 partition.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node =
itself
> >>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18
> >
> > If you're happy with the current state, would you mind picking up the
> > block-related and Bluetooth-related patches in the respective trees?
> > They are independent.
> Should I take the following, or someone else?
> [PATCH v10 02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM=
 cells

Yes, it would be great if you could take it. It=E2=80=99s mainly about addi=
ng
the possibility to source a few device-specific values, such as the
MAC address and calibration data, from the NVMEM area, regardless of
the backend, so no dependencies. Moreover, the ath10k driver already
supports those NVMEM cells.

Thanks,
Loic
