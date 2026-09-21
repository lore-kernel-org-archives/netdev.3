Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72144C518
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978611; cv=pass; b=SGOGdTjZaQoFsosxNiu7SW/GWhIR8NXYk6sjEH78f9SN2EU6xsmmEGDZ7LuKaGH8/1ZudS3scGRmGS0DnTdJ6Q0dosFVOY6DK+TNBXtWSx++IHvEaprq8nlK1qMRV5wWuP4gmzeH4Kkp9WUSS+ytAfQMG09s0+R+/zBg5kCaH0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978611; c=relaxed/simple;
	bh=q3EkqwdcLdgFV2VFGPbC3LNBtZOmLyf+gqDHedG+WLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaCk+Mu6vWrueY7pI3ToFoa9CrCU9K2jEZKdiEEdj2CKorGJWipaKBP8vru3TYqD/yA9KrdSxLDIhrOWk+hiPnSWwcDntGX1/ffsxPKYMFVQBNNmqizpne3vDXakO1WT63Ol9qyoV7jQ3iyq6ugVo1fvM9kFk1T9suZ2uFbpw7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kESnledQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4pxSYk4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kESnledQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4pxSYk4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79u7H467168
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vx8dnU+n6phV57GfzrrgfQ2D/ZRjFORy9xJ5hSXAhSg=; b=kESnledQd8++Pdet
	j62TRILMBoyIcvS7lWMhOXOc3NIB5u3ny0DJZovb/7Y3qWU/fkIHUM4ZDyae/7qW
	7Cgt8daE9hvwrMtDaxVmqV53Dj9ibjoIUeT5DQTKhtL360PUfTl0tutd7I9wV0pJ
	mFYjzMXMdzYTimqKu26QbhtYRwb3exVRHvJrSF5x1HlIesDkuovAb/wVoXG+p37w
	6FAJJAgUDemBP/niM4BSmVfHUHaixVYDxDF8tiafzP62HH4V+pG5j0qQ5WxEYScm
	GGSHMx4FZLlmCP8kGDRodpzKQymMKpxHl0ZNO3hfA/FQPm75e9G0c1AIXyOvg7vV
	bYM4+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b9mfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:16:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a1bffc2eeso188735885a.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 01:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789978607; cv=none;
        d=google.com; s=arc-20260327;
        b=gQipqfvN2Xedl1pXDd15mgbwu4/ZYApTYMHyaCXKZmxw83WpUIzlFh9+Zz0tpu55uZ
         fDSIMugN7psxfJN6KrjoK/dH7iwLrm1ociu+gwDUNJh4MkUkXtawxGOTgMMl0T3qEStH
         w1O1kFKYvsfBgJBtynjm8XNYNb4doim5IcvzxJku6EjqKG4bUGio31yJUHAaf/1riLhN
         iob9/3t8ViaPbIlUYs+l8GX6WYZ3GvUvKkIMUkYTdLEWpT0nKqooBkPYGvXBGHaAWLdh
         QaADxEGvgq9RkTGP1hqbhuAlSJrKGTDLQtm6lcn7GhDyE9USGbhSVzbjjdnJ4CJ9kPSp
         9y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vx8dnU+n6phV57GfzrrgfQ2D/ZRjFORy9xJ5hSXAhSg=;
        fh=obngh6pbpndp67D1IP7N7xEC2sp0Pud9D2GQUJy3tlI=;
        b=Rx9+pDRl5b9zeE2P+mfcOgAhV9xpnr07U9jiXSzq4NM9GvWS+DqfSVBLXkNc5jRrPW
         FHhSfmasIDjjr+Dr3rtZYvZwHTikNecoIYCLJGHU+sVTJfvpcz29aRAS+qxoZOd8aEWT
         0/qpUS2V60Ub9sefun/Z4IgeFUxqq3csOO6pCHgzohVec2CHuCrW0rYqAWz7cxAiIhTf
         5IV/5b9bkw14Br1fLwJ6SmFS+JqI/yV8pk/I67tpI+bVGmV6qgur3Ccndohwj+O9w99j
         reea6IpEIKCsS5SFWB+AYD6onMbX/eBOyHSramvxZMjzjdgr3/eG2HZSuOWRmQcPP65K
         WSFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789978607; x=1790583407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vx8dnU+n6phV57GfzrrgfQ2D/ZRjFORy9xJ5hSXAhSg=;
        b=Q4pxSYk4mzOJtcchWS+0LzAiXerBnzDJRcDq8gCvQnz4vXhL+RmLh6T+ju+Ocljjla
         UyOjdycpqbYJnlek6dTTnGFmWBfHk51EIp7ETV/u9oM/IIgBPc/zq/wZdrlNhKJMWWXm
         Ib/u/sMwkulJbO6/hXs8eTA98d5a2Z19k7tPkXnphOB/r9UGN7PrRmONUuaRUgV4T/eR
         BjRQnRmRAG78cJcmGImr0qnVHReAwjlcXepVt3Vr3wu1J9TLnMlfooegI/ngrY+nyg17
         ae82mEcCf74fg15Lts2EPj7h4cIipGUhDlqa4KOUZOdEDFFhBkllytpIDozFnJgL8n8O
         r0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978607; x=1790583407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vx8dnU+n6phV57GfzrrgfQ2D/ZRjFORy9xJ5hSXAhSg=;
        b=xy7JHVStg/Vw7/xJlHpCOkRYsmYj3ykI90XrYeJ2YhjMudKVHDw5YIbieJZaW2OOd8
         +5t16yid3f/ta/P90XpSMX22ij9WY0Os3srkEUYMs3Rl/Nd8joPnzKYLtVCGuttRSbKd
         lPG1UfzfLPrp10SG/qrqfJPGJshwskO4d1LjFxpiNGU785EN4RQP3E4f4Hqdll6svE7B
         ZTNwxZDw3K9T0yZmDO5lGRfDbMG2NP06vMihB5zUDEGwBippERKy0f8ZzhyzA39udknz
         bOWuUY52im3k04MNUcTBFpT9clIYfXgC0zNJKlgbmfkpqtZOshh/a0Bho/uLrRNdVHJ4
         szXA==
X-Forwarded-Encrypted: i=1; AKwUvBz3l/nPt0qEf9OHHMa9v+GFin7Phsei+FkKLS45bIYzWJusWKeRjB2h2nwu3/D2L400zJsZVI4=@vger.kernel.org
X-Gm-Message-State: AFuF++mZg9KC0sXek0LzXlNugCNQ2Yz4c+olS+N1W546azscumfWROpj
	ZRh+1iv4fShszqrdmmrIkxoxQfbaaq5167armu5cvqs3znF8s/WZa7nHCeVL9IHSCMbNEh+5IVo
	VgNL7zaOk6soSBkJHXHj8kFg3shOMn9FgazhZ0DFnTmfFAk91zm8IOs5fX3e9Wz5yDU8NINleLq
	3rTX/jidRHKxci+4RW0QzTcVGLbUNFr6y8ig==
X-Gm-Gg: AYBFou1tQr5vuI1aYVd39oJWBCVzzjR6okdS6qEvrj0bkzo/ltW15cwxqu9m5gnFRxI
	ndUOBalK7AbleOFvyu59rZ7jHX0t6SmIfsOIaEa+PPIuWqWjPHQeRQs1esNVMtnZo5zy/kZ1Uzl
	aOCtNAUmJXkNYIxldk5SnuK3hPg0tnzj2lxjdkwc6mGlIKtd1iob3JC3MkQS43HtB1U/LYOZJHr
	DVilp8W8Kn9tywFDgdDR73HDQmp2N/L4PxiNDf95+T2hJnacbLxrJgjJhalHgti/ESLCW64HfWD
X-Received: by 2002:a05:620a:2809:b0:92e:bd39:9993 with SMTP id af79cd13be357-93bf55af058mr895547985a.31.1789978606917;
        Mon, 21 Sep 2026 01:16:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2809:b0:92e:bd39:9993 with SMTP id
 af79cd13be357-93bf55af058mr895545385a.31.1789978606550; Mon, 21 Sep 2026
 01:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378@oss.qualcomm.com>
 <20260920-qcom-bam-dmux-vmid-ext-v2-1-ef5ca2178378@oss.qualcomm.com> <20260920-humongous-raven-of-charisma-bb99ed@quoll>
In-Reply-To: <20260920-humongous-raven-of-charisma-bb99ed@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 10:16:35 +0200
X-Gm-Features: AcwNN1VVhQqlVhKk-jGl48O2Ddr1iFZHmIKcpsImvO5gypb5NVk-JoOt1_b9g5M
Message-ID: <CAFEp6-0juFLDxo6kCTf_RrHv0EAevVqB3DP47=fg6PBNSCDcbA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExOCBTYWx0ZWRfX8k1piQzvtZ5D
 Zyy2fqqm1sHfx97bzVzROjFBQBKpootlx4GxHC7kRz5+EUhsJCicr6IZA5/6hB6EdQEgPhWctRF
 ZjS98eDXf7sks7AupxWeLkFztGyC8dDFdG/bIHrQAXzF+pt0qE73TekQT/eFhjAlqNZm6Ece7UG
 FrjcMBvhhBIf5h+jyzmZmGljqWkrBPX9R3fYp02VyBzUHfH3HPGUEEAQ7DvvPqbcwjVp+L5wO17
 XLB9McV4xilC8V3irINWpUsy6MduPv9xnW+KNa520yVfAgfTKk0HmVV89UMSiJbh7wK3uJT/bqq
 zMZ3SXZprXj5S5hzTZjTP5NGwotwBPulJjz9ZN3YcyKHeP2sqOzSw698tGjkBahMGjVzjxA5VXt
 pKEjp9DZXb8UZVrZDTKTWkbeHvyLHAR5wuMi4eZl1HFlKXm/xk4fNEJnCDLzM6l8iOlovdNC8dT
 kGdUljd5nJ5ELv7ssew==
X-Proofpoint-GUID: Xb-h8_ucj4QI82JCIeS5ZAKS2WzngWZq
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0e7ef cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=p3HfQXL-393XT7cpVekA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Xb-h8_ucj4QI82JCIeS5ZAKS2WzngWZq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExOCBTYWx0ZWRfX6mfuWCCt8M4i
 c6DbEE+yavjRuHeVSFbKAq4TY5aColR7bKvPJt71J8J6LYciXX+CqpbW/+7XQsglJ+M0XzPHA3d
 69UOg8LZDcsmgV+DUXhOyj8Up2DE/6s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210118

Hi Krzysztof,

On Sun, Sep 20, 2026 at 12:36=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Sun, Sep 20, 2026 at 08:32:29AM +0530, Vishnu Santhosh wrote:
> > Some Qualcomm SoCs, such as Shikra, run the modem in a separate securit=
y
> > domain with restricted access to system memory. BAM-DMUX DMA mappings
>
> Then this is specific to Shikra and should come with its compatible plus
> constraints per variant.
>
> > must therefore be constrained to a designated region that can be shared
> > with the modem.
> >
> > Add an optional memory-region property to reference a restricted DMA
> > pool used for BAM-DMUX mappings, and a qcom,vmid property to identify t=
he
> > remote execution environment that is granted access to the pool through
> > SCM.
> >
> > Require memory-region whenever qcom,vmid is specified.
> >
> > Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> > Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> > Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/net/qcom,bam-dmux.yaml     | 38 ++++++++++++++=
++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b=
/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> > index 33746c238513d72366bc52359fb10f275475b331..5351269b0ab72ede808ae47=
b55d57580af209038 100644
> > --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> > +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> > @@ -72,6 +72,24 @@ properties:
> >        - const: tx
> >        - const: rx
> >
> > +  memory-region:
> > +    maxItems: 1
> > +    description:
> > +      Phandle to a reserved-memory node compatible with restricted-dma=
-pool.
> > +      The BAM-DMUX device uses the pool for DMA mappings.
> > +
> > +  qcom,vmid:

I can see several existing drivers, along with a few ongoing series,
using this same property. Instead of redefining it in every binding,
should we consider defining the prop/type once in a common soc/qcom
schema and reusing it across bindings?

> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
>
> Drop
>
> > +    maxItems: 1
> > +    items:
> > +      minimum: 1
> > +      maximum: 63
> > +    description:
> > +      VMID of the remote execution environment that is granted access =
to the
> > +      restricted DMA pool through SCM. The local execution environment=
 is
> > +      retained automatically and must not be specified.
> > +
> >  required:
> >    - compatible
> >    - interrupts
> > @@ -81,12 +99,29 @@ required:
> >    - dmas
> >    - dma-names
> >
> > +dependencies:
> > +  qcom,vmid: [ memory-region ]
> > +
> >  additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/firmware/qcom,scm.h>
> >      #include <dt-bindings/interrupt-controller/irq.h>
> >
> > +    reserved-memory {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges;
> > +
> > +        bam_dmux_pool: restricted-dma-pool {
> > +            compatible =3D "restricted-dma-pool";
> > +            size =3D <0x40000>;
> > +            alignment =3D <0x40000>;
> > +            alloc-ranges =3D <0x80000000 0x80000000>;
> > +        };
> > +    };
>
> This wasn't here before. Drop.
>
> Best regards,
> Krzysztof
>
