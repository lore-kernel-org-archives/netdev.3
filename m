Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D393DB651
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248375; cv=pass; b=e4WPMTtKjSdYI0sWl5cCPvhk+1xD/a+YFCGBofTGBpJNnll0rFXMRyp437wfWJTgaAbMi2hYUrnA6/MVN4tLdKoNbXKfUWkQ+ZkZ2WzT5GFjwMdh8LS+mjfQujQwqR7+gY+pxirL5+b1ZqzIEL2A01o2zkEUZzPWJXblZIzmQa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248375; c=relaxed/simple;
	bh=U7K/8GIisOHzCRms+OKCv5d2y4oxaKVysMdgc5MbHqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geLxnWZldOlzzxZJ7+qzlnGb7/h2GroiysiYJxvXOvueW/eto4UIzXZovkO59zug/I6e+m+Glm0zy6SXHBHzQClozERsu80Lh6IumVOrHKOA4orw8YKJvH5SJOVJRr8ZQnH2V1LvjdWDpnHA+k8ibASrCC/pzvLNmck3jM/NQsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJt9BdBB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AzCwugBf; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJt9BdBB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AzCwugBf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O9PmoQ1644174
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1V1OZLd8PuPRGQwN97+EBOj831I6h3gVcxIujOMO+c=; b=FJt9BdBBPANqD09t
	Arva/bOhhI8YKPNoC3dT8lyPPLQWPFtCkEMrTT9P5TbeT9Bd5OfaXtdFdMUNxteW
	OBNxC41ZioyCWD1j+IXkrJIa/ZAWEgqnTqOVpALi32BWAmlMQsEsGsP5W1+iLKZB
	fCiIWq+aIGAqQr64amrtXf7rKBGSkNzVEpgVxNZhobTHWRS85XFFZ3e7o1tQJF91
	HQZuk1CG8tO+YGTx5q78IxkF0TrPzlp2cefhTU7Dlt+Ch5FUGR2choeOKiCqOZGi
	9FkOSKWDC1DgMSM2aJKj4H6PZaehuIs/Aj19TyCnypn+LKDycYNp+WbDMYotaOnD
	V6WyYg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvmrrb83q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:12:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so3618991a91.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 04:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790248372; cv=none;
        d=google.com; s=arc-20260327;
        b=Z4DG67tu1Gja5Gd4e93RC3IVIy2/u3ksmm9BG/oB0qZi2448SLmsw8xqaeifqJo2Lo
         RD6Bh/7QPjeBB5QComKF3S+McoV8cguC/jYlKj4uVH+9Hoj180QNcCP8ybf4K/Y/GOjL
         O4OvEZHueAW05Z8LisGVAHFcX/YSUhvuQKRrplLuTlTbEoCKdlVZKk6PDQaS4fBvLLoZ
         gJuk1XySAOV+FDOnyRY/tJQi8QGrnYSZiPIBpD+e7tNVnY5h2ZV4Kqg1v3Behcxmt+D8
         EhXgmYmMQ8CWXbpj5vc2I8wypoEUcyxE6vixkLjHurN4B4IxH2rgt53a29exLXcA3YUT
         C32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k1V1OZLd8PuPRGQwN97+EBOj831I6h3gVcxIujOMO+c=;
        fh=pey5QIkOTmRyLbjb1hS/lOQWywhf3OHFZF//6jE8uBA=;
        b=Pp0J449WRq6Bqbwl894LJ6kJNwknNAQJTmnpzkSDy4q1ibnj9mBRoov/huoiH7Fl9V
         6g45GJra81w+j96M54hJENm7IEoeuRfEJyAXciD8kIsC5py1SEkCd/vxelumleMl2vO5
         SFzohaxKVf86yNJpd6eBUfPIxEJ6CGVrFyEz4+xLHDH6VhaWrXcu5J8nr3FnC4eIJRmW
         S+J5PxCgA12eEqUs6/6Brmhv/Dc0uu3oNXm/7uTNG8aFA6jPsGysTCtyuicXYJaXyF4k
         z3vaUmrTAxND0mSCIiWyt3wGmu99npojBMr8HCZJp/xmUX5gt2A7YWZoW3eymfTFgbbQ
         qM2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790248372; x=1790853172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k1V1OZLd8PuPRGQwN97+EBOj831I6h3gVcxIujOMO+c=;
        b=AzCwugBfcwLZ5C89XSP6biaNDtAcRSadIIJk9y4Sa3qjkqO74bYhIJGoAHMaDPcsgR
         XRng11zw9J9JPXMNy4YO02C11zONN0hnMWJ/dlcOl1pi4via20YoFOLBUZ7xRyMELVNY
         A0qWhgYCKL+wHloQbjfQJ0taIgMxMUMuWyIRrsFE5gFylbfWNg9RjCtNII19VJbJD42g
         qNzDQnIuXde5pedzSD859WeDOkPC1yxTLtufGi4uJncbURdhVPlCU71kCgWaTP9kgBMw
         11vBksr1BqmOWVbMHbJrT0zvii0V01+mm6FlK+KO/Q7f0UZfqV5ZFe5sCptxAYs/2KCr
         tg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790248372; x=1790853172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1V1OZLd8PuPRGQwN97+EBOj831I6h3gVcxIujOMO+c=;
        b=Y083cTwySYmyayjBYiEE+bA9QxqmXo8dzgai5b1qpFjd/dMx13C42hdrWOtXvKqjU0
         L8L80N7/BTQD7k+4SETuECO1hQAo8oFM2nN/uU6MF3amQObR+Os5JvPDh1ZLZjtf0J+B
         vuMS7EdmKMJ2mLZjsv5qLDWKIae/US3ID6CmffyQT60npCH9fSBEZ11RY/efbYfdaeS2
         uYccBNjeevktwrldsdtl5Z1qnMFGVut6tq8r+2upa2QrwPMMbMbF5BtnTL+J4hx9lCwN
         TykL+ZKJt21i/VIsdlBdRlSqpU98/BRRMXfBQvV22TuU7H9IVGWbKlwKI7tqgKr8WIxf
         eObQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8uoQ+N+pha+L7rHsP6v5dmii9L/B6jP6l53GXXZGZYxTUga7fdM8ak7EWSp0iYyeDoFrmWX0=@vger.kernel.org
X-Gm-Message-State: AFuF++lYyijf7m243KazX6W3yVVA5JI+v79+dqQxSA5NkHYFNgo37sPu
	bBsvvVxiemWL+TUlY4pLm6oMcBu1wnzfKcguxZ/wghEAd0PhGS1VGeXfs3QrkrO4ZBC+vivBu/5
	KT8zO9Y9srL8fSaVHx7qhxL66T5jRsOxVdla17++LDergkJEnvxUFUw74tmg0+MAuneUy8stfUw
	Pka9sN/7EMsCHiUX2GD6S2G+2mT/lDaCuErLJZy+4LQGFt
X-Gm-Gg: AYBFou0lNafYkd+INLDv34ftBgIUhgp2P2eDRGR/euDofFsLWlvvz2uXkQ1CT3Xvfdj
	wM9cQCaNjscDugcMD6fGEi+AxzhPZq0hVqzEmt/psq9C+GgCWrKair7CDQSFNYK2/azt5Y8W1ne
	qL1I2jZBdDJv6Gl1JE0s+KdAF/tyy225vfbUgUSL1mNWlX6gNeG+x4tPNUOw==
X-Received: by 2002:a17:90b:4a08:b0:39e:6c6a:6572 with SMTP id 98e67ed59e1d1-3a09896f00dmr1967119a91.53.1790248372005;
        Thu, 24 Sep 2026 04:12:52 -0700 (PDT)
X-Received: by 2002:a17:90b:4a08:b0:39e:6c6a:6572 with SMTP id
 98e67ed59e1d1-3a09896f00dmr1967095a91.53.1790248371549; Thu, 24 Sep 2026
 04:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com> <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>
 <e05baad3-49ec-4db0-ac70-ffd8e0f52b10@lunn.ch>
In-Reply-To: <e05baad3-49ec-4db0-ac70-ffd8e0f52b10@lunn.ch>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:12:40 +0800
X-Gm-Features: AclHuK8TGQHMGqvYSLBah1tI2wfOeuTGvUtjSV6O-ttPpvUSi2Ylv2WtiPcL46s
Message-ID: <CAFkd8htkQnq-KVKMc-qTOFvbgi9BRdnewzmyu4c5B2hULDKPdQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: stmmac: support low-speed USXGMII validation
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX3YA5oy8nc5rz
 GM5b++KHZDkV9UFqQ/0pAoKzciBiCaWtM5M8CISJm1092dBxI45jwEAR5MtxF5cio43UZIo1USc
 E2YIkWQwwYeo1tcEbZeNZfFG7ogBUlBdGmbHBMokA1WpJnskZaBEnA7NxbHcX3aDFWflMpw5KPy
 d1asE4lrBku4nlKcRbdF3Ywp7Q/AK2Xijp18PBh0t2a4PPc/bEB6QrUVLjLlrYtl1nCA/+qa1Hc
 3sNm4sDyodPP4ESeqneIV5NYCq3huAhdbD5eOXRQOCFmEd8MiANvf+yDdAas0WWNRErYh3P3uzX
 w10n8ZjXx5GcMUwdg1R3+6+OdQib1B5ek0IhvF/dtJ7MjJkbHx8Sb2pqIDtenzmKdd0kFpPp9VX
 aFg88aI1qStplr8rLbs/+SUJyQL57q0w+Uy347H++GDINIDvg9q6JCPxdrNIBaP2ePMmT/l+/mW
 esaZqN9V3+Mt9fxmpXg==
X-Authority-Analysis: v=2.4 cv=TYwDJhQh c=1 sm=1 tr=0 ts=6ab505b5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=oAscVk_Hh32IO0NGH0cA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX+NKya64om1+L
 WMmoGlL8vh56tSSX/uQ3pSMomegAO4Xn7dvip54SnpjAIeq7Bq3c9G/wOXbnNYk25u4E5Gzu91N
 3lVU6GxAmw9t/8V85O5H5tkjFDzglRc=
X-Proofpoint-GUID: LwjqMdPp-4X_mn467khj4m_X2ugBj4NL
X-Proofpoint-ORIG-GUID: LwjqMdPp-4X_mn467khj4m_X2ugBj4NL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240046

On Wed, Sep 23, 2026 at 9:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > The XPCS also consumes the PHY-generated Clause 37 in-band link and
> > speed status, so USXGMII must use in-band signalling.
>
> Is this a qualcomm specific feature, or defined in the databook of the
> licensed IP.

This is defined by the Synopsys DWC XPCS databook, rather than being
  Qualcomm-specific. The Clause 37 USXGMII implementation added by this
  series uses PHY-generated in-band status containing link, speed and
  duplex information.

>
> >       case DW_AN_C37_USXGMII:
> > -             return LINK_INBAND_DISABLE;
> > +             /* The PCS consumes the PHY's CL37 in-band link and speed=
 status. */
> > +             return LINK_INBAND_ENABLE;
>
> I ask, because when i look at this, i immediately think is this a
> behaviour change? Is it going to break existing systems? Or was the
> old code broken?

 DW_AN_C37_USXGMII is newly introduced by this series. This change adds
  a separate case for that new mode and leaves the existing DW_10GBASER
  and DW_2500BASEX cases returning LINK_INBAND_DISABLE. Therefore, it
  does not change the behaviour of any existing XPCS mode or system. It
  also matches the implementation added by this series, which enables
  Clause 37 AN and reads the received USXGMII status in
  xpcs_get_state_c37_usxgmii().

        case DW_10GBASER:
        case DW_2500BASEX:
                return LINK_INBAND_DISABLE;

+       case DW_AN_C37_USXGMII:
+               /* The PCS consumes the PHY's CL37 in-band link and
speed status. */
+               return LINK_INBAND_ENABLE;
+

>
> The commit message is where you try to guess what reviewers are going
> to ask, and answer the question before they ask. Seeing such answers
> in the commit message gives me a good idea you have done your due
> diligence, and the patch is probably O.K. Without such comments, i
> have to assume this is poor quality code and really exam it in detail.

Thanks for the guidance.

Thanks
