Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793346832;
	b=R4txEaXtOuKm4o2f5xxNLj9D1+h7tDzZVsxCGk5Z2XIXOn9zsvwfYUZhwczxHLYX1ZJD
	 LMhU7tfu38KOXdx5LA8CcjLEaMB9ZaSxshdgXRLdtB9tESy522posNhBGogScW+l205jv
	 dV344FfRC6woyE0wrMZs/Yaqusztb45hqtmzzbsTn7XGFls4JNCq2y7qEhJX6275E7wZp
	 GG6gw3FTOygIzyHewhYi1ZwPRoAXj8oBrqMY/Kih8r0V83RMDV8Y/fNnG1356l0RRFaEe
	 5Ad7eEr05aLSuLGX6t/yyXmalj06lOc/tpum0QE4nyLZXnicLnMdjdB1BFB9qWN1Gsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346832;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NcUKI/JdjawBplQszTuPDd/jbVzlRqz2Iq7B2hO8QVk=;
	b=wUgKtv1MEGfWPxtfMgjcJchRzJ0jnnQAEdbyLab5QX9AqW3IS+z5ujx6hpXcSfzQxuXS
	 3NBt84oj/ln4cIbmfjeaVXalvBERlE7pjlMb6/F8ORcR3fu+GHuuS6AMbRq2X88j8GsUf
	 dJx5W7E34AMdBqwlD9ubCkqa8nXlRnZ0GXQREix2aw7O9x3DcnkngFMAZYF4BiHaNQGUr
	 4De3TPM2Mv0RyJwCbJHOMd7j+MGyxcYnYsd27V8hlFpuw/TbewH5NUcZelJBS5x5SW70x
	 bWQRwRjgeiZC5V+//HMPHKGw4Gtrv22vs0N4ES5Hz42ZGTqKOg7M5KOmDAmUAGZDVsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="py4x1+/4";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JVl6KrXV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75D606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA75D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=py4x1+/4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JVl6KrXV
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U5F6t32326375
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NcUKI/JdjawBplQszTuPDd/jbVzlRqz2Iq7B2hO8QVk=; b=py4x1+/4bTBZWV7S
	8fqBCgCHynF3TCgZR/SWB8ArinjwETcLeI/FMzApeCfFfGuqRBnUKyZMYjGrIJZw
	P1bR07HB/A3297P7wS18YN/ILMJNrCo3kmED+EnwnlZIQ82Pdv8UHNoUBsFxd1d3
	WsDJh47s/j8Ou4S/Nj7YJWy9A6ldEG6/8AycHKPUrQhVWC71xH7coetgsm+FgtUG
	ucLwNvgxbisLr3lz4m0mhGfgSOgc6e9PPR6M+gbcDr4s7SjkKbaBNC20BXsfuWuH
	jKE32Igte+JmllKwstcZQPCwpB6yXzEsHY6IRcN11uqGwQ6BRU/K2oVq9Fu6wGyu
	LfPoBQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qhuvp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:53:50 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-679a3664e1fso753418d50.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793346830; cv=none;
        d=google.com; s=arc-20260327;
        b=mGdaIc5slMl7X/WsfNp+fhTWFB3V+e4FXo+Mp0KoBEySGPimjS7wZdczXsEQ/364Bn
         AE8OpxP5+TUUc61VacTSeLxK98IlAtjbwxYQ7LRZA2rwVk2cH+fVu7YEgsdanZ9uiT/r
         o1wc8LPHXnrqbDg2K5ZiqL4P50cIH300PUBnB3xQsE+JLJFOenFU8JsYgzsC+pb14TOH
         Hj8Lg+jjVHZ89GhkeapErTabQdQse6PNCyxJ8yzmzn+Uym0mGA5Dx+vbpRkhgs/BTQaT
         QR7IhDey5VDnMamducZpAZ0xHXrFRMriiRM4Z2pZR+L/f/7TSSnIGZHCNFkAX/ZCw8ad
         xXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NcUKI/JdjawBplQszTuPDd/jbVzlRqz2Iq7B2hO8QVk=;
        fh=tNTGCswaWpzzCzXDgpjrEQoPQjBcfuvZUilBKyPrHJQ=;
        b=TihhIWkr7HncqnuXda6wkw5q0ZAekya7N1+MDHoQ2PKM8RzVRyoxli5PSMBjZtuMTU
         BWIXohklYo4NncqIQVgA5h/tt8fzBP06eLt+bsSJQpA18cnZSO+UalgWs84eF21dK9Z8
         WO5VAVhhoK9AGHOOqIZbkxLcAYj0iI5A6h6sNbIw0tW5ozE/kfdnny2FhybYnF3tKFRZ
         4DgjyTq86fv98bKOEJSz49gGFZn6uzS/K6VGkjbpn4HFRDP85w03kKLCC+k9jKpDXtji
         gseNK6+WX2qTeqkKYpRI6UcdJV3klWbzGW0cbbixA1uqk67Sf+sF2yD2KbLm34rdR4JX
         ciCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793346830; x=1793951630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NcUKI/JdjawBplQszTuPDd/jbVzlRqz2Iq7B2hO8QVk=;
        b=JVl6KrXVVHVd4TTaSllKW6dR8Rjo6FyGNBLSeBj4p4OeucxAP0ogEY0Q4ui+URy3Vu
         7CfHTu/LdNJq7FPpVs48FVRtHz4xyxOfFhdBs5gYJP6WXSK5VQ80mq1qm31MG5reXnfn
         fobcruM9SaM/JftYXXPayQw6/l2Wuehw8S70ufqhjt7ThAv7wb9IdXixORTHapxQ8Vcu
         p3rXsJ7BLcd67dUeKEOWl7FDbqW5Qsl7a+Je1i4iwv5Gs9qRjV028yjQjI7NT2eBzlxp
         tgx6S0aGcQWP/StHgtQKqbPbCEqXmfci6/cSQHjidR9OgRQBuSQmI5464P0FKYQtnL73
         E9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793346830; x=1793951630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcUKI/JdjawBplQszTuPDd/jbVzlRqz2Iq7B2hO8QVk=;
        b=zc6iXVAqHUWZoSZnq2swpxtmG428nTisZ9UbEvgh5LI42JQXP9XI29AGKNHubsXzeG
         E/ibVSsnjsRXcxVzkVcpXV7H6OFx/C5Ozh+QH8AZbL8UoM8fbfrbaf0uwzhbjx9F4Y/F
         Ez3AMB52Gi/V7eym1kp692kXcu/hK1hWmFlEwUl3KaRb81+tsz9iftHUwy6ziAiVgikZ
         6iK2QKHEcm5UYadraM7FPGKXVdeUjNUsponyczwShrdHnFgfouMY/eFNJqTsxzU9dWuF
         JscSfYlOAfSWCuev7m+k6g8FLWVo82MRKicK52kMynfVBWIylW5/+c2kv9tccnzGlAeL
         FmmQ==
X-Forwarded-Encrypted: i=1; AKwUvBztfC76yKziEiZXGgsZ6cQxM1mM1SZ0g3jwd8mLJ+tPNqwujBmB1P4Qz2EEQBffwfmT91R3Hsw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCgeUqr7+2rXrzTuhqdmu8PbykwkZzlDV+qG207nKXM1WgAQGf
	Nu3zLxgYPxmf1BBJHgklAeRH9Wt87OXmGTmtc6S7d418Aiu9NkANDtYrUqGSzKKgycZMFsr/DaD
	fpeLAzPygYwveBMLLf62zOYZFph1FT5hbi3MjI7DTgdJ+kOCZ0TCvfb5WOgr/zE74GHMZZ3THyk
	mwUt2f5gmu+K1GlilxS2xRHaxH26H9SSi/6Q==
X-Gm-Gg: AYBFou2FQDA/OOYPYO4FIXgQQLp7cqHKqPhGC4rhEHB/g5KA0miNqp/R18Mm53uiqfc
	LNpnRM9yAQ2ZisbC8lJXM0cXxD5DRKdCUiGql6cX+0AUcqEKEsPH+IEmR8QxiPkMgr9MZw9UJPl
	FPTPckziivPA6MDE25fNZ7g6/FFZ5H4JAKHG2x3FlkvafDzIPaT4Vsn21LLw==
X-Received: by 2002:a05:690e:1487:b0:677:c8f9:73d3 with SMTP id 956f58d0204a3-67ba50a89a0mr1180172d50.75.1793346830047;
        Fri, 30 Oct 2026 00:53:50 -0700 (PDT)
X-Received: by 2002:a05:690e:1487:b0:677:c8f9:73d3 with SMTP id
 956f58d0204a3-67ba50a89a0mr1180150d50.75.1793346829417; Fri, 30 Oct 2026
 00:53:49 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-aquantia-support-5gbaser-v3-1-f1f9346553d0@oss.qualcomm.com>
 <b87d66ca-dbd3-412a-9ebc-055f8e6f9a6f@lunn.ch>
In-Reply-To: <b87d66ca-dbd3-412a-9ebc-055f8e6f9a6f@lunn.ch>
From: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:53:37 +0800
X-Gm-Features: AclHuK8Ikwa6ly_OXK4n2rwx6KaDD_xdAJZgr6Thjfs7_nY4U9Sd1s932qFQXNo
Message-ID: <CAPTcHHTmGGC22ng9z7Ct8XjXjEDDukYBc8hDv3ku6t6O_Cnn_A@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: phy: aquantia: Add support for 5GbaseR
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
X-Proofpoint-ORIG-GUID: 3xNSs9GAiVkMYCVXMrm2dhmKiuh7L1kS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMSBTYWx0ZWRfX3R/haKS5toWb
 7+kJWXOTrK5ECtvN7izDTVT0VWo21ipYNOs18tGTi5qxigv+7YQcIPnBWXjOTTqJUWijFyqs8PJ
 zXCBHmkVNDbnMOAJjW3/bApg+xPFRg0=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae44d0e cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=sxNmbdBMPtiPP6CAsAIA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: 3xNSs9GAiVkMYCVXMrm2dhmKiuh7L1kS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMSBTYWx0ZWRfXz2xpZU+QI+bD
 RlSvjGT+AUfXD2JSwtsN/iGrfNcib3kV3tpiY5Woo8ESK0BhKLi/0Wv0kDnup414lZzkhKR5bch
 BactK5Sf3BL9pEZVzqqguxY5ShEoQZpUVrhV0bXAjiO5kUTtqxQCvQunlSPbp3JYd8NfRNjeTPY
 jl0++kEHPqfLWkcCnYJweiV1Ws2OrMNyr8crSOWL1fg6l5+eTwuZrXTfkwENsXridxFbPQQrkMC
 38gxXGFolA6HfjaJX1qmpWh2H843WxbVIVaPitqpQ3vpk8sYAs6mWBZiZF9I/OAqUPFX90jMqCt
 PaYnoKDiHATWk0NbhjIuLcm4MgIfL0Sch13D4qZUvLXKe121+FjpuwR1y1tPLUQYf5TaxI4egle
 Alvi7PagX2JauJil0ehrRW5Bm2REJ8TXsAH+Wzi0Z0tmL+1ICUfnmDseBLvus3LWSMBPY5stRdV
 Zh7vkb3hvYyCwDBwZ5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300031

On Thu, Oct 29, 2026 at 9:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > @@ -786,7 +790,8 @@ static int aqr_gen1_config_init(struct phy_device *=
phydev)
> >           phydev->interface !=3D PHY_INTERFACE_MODE_10GKR &&
> >           phydev->interface !=3D PHY_INTERFACE_MODE_10GBASER &&
> >           phydev->interface !=3D PHY_INTERFACE_MODE_XAUI &&
> > -         phydev->interface !=3D PHY_INTERFACE_MODE_RXAUI)
> > +         phydev->interface !=3D PHY_INTERFACE_MODE_RXAUI &&
> > +         phydev->interface !=3D PHY_INTERFACE_MODE_5GBASER)
>
> This is sorted based on speed. So 5GBASER goes earlier in the list.
Will fix in v4 =E2=80=94 kept the interface modes sorted by speed.
>
> >  {
> >       if (iface =3D=3D PHY_INTERFACE_MODE_10GBASER ||
> > -         iface =3D=3D PHY_INTERFACE_MODE_2500BASEX)
> > +         iface =3D=3D PHY_INTERFACE_MODE_2500BASEX ||
> > +         iface =3D=3D PHY_INTERFACE_MODE_5GBASER)
> >               return RATE_MATCH_PAUSE;
>
> Please keep this in order, 10, 5, 2.5.
>
>     Andrew
>
> ---
> pw-bot: cr
Will fix in v4 =E2=80=94 kept the rate matching conditions sorted by speed.

Regards,
Hongmei Xu
