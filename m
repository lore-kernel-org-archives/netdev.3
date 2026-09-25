Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1B49CF27
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340409; cv=pass; b=T65ZfovoZhJmXvr0DMRcEaJjmZSxhFuwTEjkfa6Bj2dtG8bktAt1dSrEDn2a56kWdNg+oQ6B8jB6CW6HRFKQ+ImueZgMQO/M/4M5rFBqJJzDSWn7CRlzZDesFP6iQS5FSkc7K3bbrt1E3EECUcjoTYiY+APSZl94aQsJKQV+/Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340409; c=relaxed/simple;
	bh=MPY/wBT5j35ozhTUGWxFnPpk8kim/mWPV8B3d7VqlCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMBqbEZZuFJ9PFSPR6ptFCOorklhj63VVMq/I1OfSVxe2KVMaVSf8SFISxvqvMa8E9qa1BlgR717bLOtoDrfU1ENgzbYEcFrSppElmBqdn3w4RVTVXrIBQ5+I2PBrOka3LDznkFebnWlrIafa2aUnkK+XYRssXabTpqsD/h/+e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYRND37l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IdAF6F8F; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYRND37l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IdAF6F8F"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PBV9hD425977
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MPY/wBT5j35ozhTUGWxFnPpk8kim/mWPV8B3d7VqlCg=; b=AYRND37lW8jWqGFV
	EMTeyG+FZKnEy5vL3U+fYits/0aiDIdPkPQkN9x0BSY8KieqAxlqH+FKJz/ovMl1
	pi+PW955ABRDkDegByWGk5OQwdAm7J0lyDupnHk8r2q6Q0wEuetM6EPfDud8Vtg+
	lnvBgp+TZAEux1kE5J6RJ4GYEhE1WxoVknRktqa87lERES3NKZD6FEymRfNyrxut
	jiw+M63dUTkdK4yjXpqbpbg4dQUpBIYjYUrKRKHKzh4LnutRe03FEDwTlzS0ndoL
	1oaAr5u1jyp3H20NIW452jfWhlhC6tML+hYaMhSg8EPIGEdrRxJVTetuiJfXsDWt
	JYPOhQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e87c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 12:46:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91430af782dso16089066d6.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 05:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790340406; cv=none;
        d=google.com; s=arc-20260327;
        b=Qb89ow5txH5EtMImJAY+vCv4p+hU67zk3kYvKWQ9QKBQcTKZPaIcWA1ebTjGZnrHv0
         viT9kSRxhagh0x1cdIhKep4Hgp28MldEu22ycfL/xu0RWc1EROIVKMlnHkdU/aOg1EuT
         moTFQ26O1fZWGMk/nGGPk9bgKylIUJTESxLvDbyG73IGRJiD8VTUsEbqwJ6WxN3IaCJj
         OOyfkOt4N/zJdBK0XM18w68FDlI+zWHT13aW12HznhgkfCIG4sRwcV+HIjxkEGDKECDG
         RVuARhZ7JSQE3fXPOBIO/apBNCLU0LN9VvfHknQHjGhh5nLPmlSYRYPfujFJJNltRWYM
         84XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MPY/wBT5j35ozhTUGWxFnPpk8kim/mWPV8B3d7VqlCg=;
        fh=4Tg/LqSMBxSQiLl1h30KRxojYZ00Tii+ICBcwyu+qXw=;
        b=pTwAE8XI86rSgQ53Edvxi72xfvPuGurfu4KIrBz04xcNghGGAGr99cE6LKa8zSAbU1
         N9gaQCWtXtX1SiLqVGL6eiTM7RY7AjxhwRGN+DKodoHMfB6+ILyT6GgjEe+mogAQqycj
         wK5+bD9qz6aUJjkdvKz+4uX93BgdFC7QMeMun6RonLDzqbf6v1q64t6Fm2hv2UPVtKUD
         ggdFNCKaffiqNpWJ9njyjE21hfy5E8HUmgI0oDnmeHNvs7JRkCLZ9EpTx2uRjcxGibT2
         PcVwEcaFix738R9pj/+CUXBEQ/bd9qy38C7XMhSGi5oBB/zZ6h0h3wdvitzjBP3m6IsY
         E9XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790340406; x=1790945206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MPY/wBT5j35ozhTUGWxFnPpk8kim/mWPV8B3d7VqlCg=;
        b=IdAF6F8Fs86CVas5ZLLs8fXxrvk9axccj/nvQ2CeCHhgGi0P1PMg+NmFtLKpoayme1
         /8fzYOGqF4m8wVmwaeQegbAW4ffaxADss1/Mv8jbsY8l3Tt+CkxAY+vl/5+DZbOk3K3r
         rZabjgdO+xzQZcswOP4TY1Yr5u0gkwJZ2C11AM/TGXQkHuWmVKTcnFQB2ybR6xIy2uOR
         FdArF51qDV1y5kQGZPtmxmSExHeyLOWr9vuCmQwuI1gjYJdHWk3HKHnBQ0TO6jvffYYo
         3E35uMVRy15lwlyEPT+4zhmlLmF5ybqEbMmQtFQF+GFVGNTCQ/3GkwcEy1l4hiSjMtB+
         Ne2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790340406; x=1790945206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPY/wBT5j35ozhTUGWxFnPpk8kim/mWPV8B3d7VqlCg=;
        b=1udcJmH0FejNC186v8VIhX9o/DRg73GavzMa/jRE9DVmZ40ArY4+uWP1gDj3pg+Gyc
         6NYcSHCvTa3zTQrb1mNtVNuMZXdfM5R+/UXlZTAyRZzBLhPkAEAjI8JC63kt6LPEDlTK
         7SXVWMm4qvhyFeWZBAFvXFq4psyqaj+fu58G86rhhVvh8Bz9sdwQCO0iL3NytqlIOOng
         XEBxq6dLWL7gekLS8K7ppeKxXo7cNbjXpsKauYBo7waG0bsTSIKw5HUDKR4n4lOaIBoA
         PEE04ulJDVkact/JDpkvQYUCFf6E6uiLsYjo3Wcme2y8z7nxyIqGFRZafSaNo4RgknXN
         wDFA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ2E8uOTuGJ2hjAgZ71OaUN3Ihf0RJpYid7uzcyIVAF+uiw3Urbt8GcDxpvAKgJRvGm759v60=@vger.kernel.org
X-Gm-Message-State: AFuF++lnhIlvhKKg4J4nLyyFK5niK84AHD19lrLIProK5dgDVm+W/Eyd
	W2jbgzixMp2KJmylSahPQ9TgMK2ecN3+12X3ir4MXC8ffQAGG96tmUWS8DuWA6Pohr77WFe1y+2
	9Btq8EYNH+qyZuYyFqjHef/pMS1UiFXjWlmHHvovvOgEk2y66B2zAqgHgd/xHi1R6chwpaP0TUZ
	w5XhARCXArpWAqxsFstsuz1i/dGO8ZBSNSdQ==
X-Gm-Gg: AYBFou2i6ahC8fVEuTq5JNKW6AvE+xZY8jLIgHCC9IynpUVOHn9XjFn9Y9fBqpVs8sB
	UDZ+adPAvpVLD54tEeyf04R43WHtwUD0K1Mgldr5rUBQqjg9okEMv2d++YhXzOIAqRBsnxpxHDZ
	C20ST5M/9kIa5MnLItOk/Z1rHqktuhf2pQC2zrvtnvfboUwGsU3jwr/o/jwg==
X-Received: by 2002:a05:6214:2462:b0:90e:9408:2fc5 with SMTP id 6a1803df08f44-9142f63ee23mr38807596d6.5.1790340405759;
        Fri, 25 Sep 2026 05:46:45 -0700 (PDT)
X-Received: by 2002:a05:6214:2462:b0:90e:9408:2fc5 with SMTP id
 6a1803df08f44-9142f63ee23mr38807116d6.5.1790340405276; Fri, 25 Sep 2026
 05:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-qrtr-multi-ep-v2-0-27dd80d841a0@oss.qualcomm.com>
 <20260921-qrtr-multi-ep-v2-2-27dd80d841a0@oss.qualcomm.com>
 <a16d507e-17f7-4074-8817-4b8da3a71c3b@oss.qualcomm.com> <8ed398ba-2ebe-488a-a213-8ca7ecbe861d@app.fastmail.com>
 <CANyhwx0hZJC6xXaSC2g4GFgUOp5n_KN4tdXksW+s8Mk_+7xEAA@mail.gmail.com> <ayyrvpxnxonroz6kafehepplhltnzgopgt6pn5fnpdmft6rbxm@a5sps2dnso47>
In-Reply-To: <ayyrvpxnxonroz6kafehepplhltnzgopgt6pn5fnpdmft6rbxm@a5sps2dnso47>
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:46:34 +0100
X-Gm-Features: AclHuK9M9IbbCEpkXjmHN3eWA-5m3q_sE1ucHvnsGGxug-EHSGOK9v70zRPAC84
Message-ID: <CANyhwx1EG=2FyBm150wrKpj=kQ1066iwZWndx=ZL3BKNoZUhVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: qrtr: Assign unique node id for MHI endpoints
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, Bjorn Andersson <andersson@kernel.org>,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXyN5nqDWv6EeA
 A1Aylcrs3BuHdzAgr0s7KDgQ+vzsNmaWffoFIMU41j/zjp3PWxDFtV3QaCHx/tWhhxKTCVb2oXp
 7rwqOmqMuFJdbHRZKIA4Dn9GfpyI4lc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX/aQSveE7EZcH
 yZsiTQYcvvcobBxKnEagBz+gh8xX1iXblE/O9yxT2p3y4LeW5/AIQMqWDs49RH+QHxacyt8b76p
 C6DFhFz8h0lNhJzJ4TW2OoSqipiC4bBm48hBLd1ISx5xtsLnU0BMVmL/CIA2gB6C42W1nGjJo1E
 eyfM2YnA2nsyLDFJGPn8ZjT1vhhaUYdETa5D6tppzGrQ08ss5GJ4n6vonzabGt4M6DGXLnfWnqX
 5Xfr0K0PA70Xyb+WzTNmv+4kyJx2CTIiA724xnLrqn3BoVZaXkAZTl7E36VxLZnNxpEYSJwIlBi
 j9ugBF1YzIpyDSKR3X+kAGmWc6sBay3pcrRWKOCiqbesVOiD8UL6+KTzudXlOOXAPbLF0fgRr/k
 hhIti09KNwpbC08L/IS34OOLOXc9/YILbbpysvUS9b/AJ581CUzWWiO9W7d0exMEfhxQBQP7uWh
 7qPy/qcsjPsLoNQ2ilw==
X-Proofpoint-GUID: X36Gy6z1LMyM1bs-P35oLwUrbXXD0Lm3
X-Proofpoint-ORIG-GUID: X36Gy6z1LMyM1bs-P35oLwUrbXXD0Lm3
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab66d36 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=nOLRoRm-sisVCJmKiMYA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

On Thu, Sep 24, 2026 at 4:58=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Sep 23, 2026 at 04:03:38PM +0100, Youssef Samir wrote:
> > On Tue, Sep 22, 2026 at 6:24=E2=80=AFPM Juha-Matti Tilli
> > <juha-matti.tilli@iki.fi> wrote:
> > >
> > > On Tue, Sep 22, 2026, at 20:14, Youssef Samir wrote:
> > > > On 9/21/2026 12:23 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > > > > +
> > The chance of collision is slim, but still not impossible.
>
> When you mean collision, do you mean node id collision due to bridged nod=
es?
> Because, even if the directly connected QAIC devices use 32bit node ids, =
the
> collision won't affect the functionality.
As in ep_nid of one device matching the nid of another device. In MHI,
that shouldn't
really matter since this patch moves away from using QRTR_EP_NID_AUTO in no=
de
assignment, but as you mentioned below, it could clash with TUN and SMD EPs=
 that
are already registered with their ep_nid.
>
> Also, there is a collision with SMD and TUN endpoints, but that's out of =
scope
> for this series.
I have not worked on a system that simultaneously uses different types of E=
Ps;
only MHI EPs. But if there is a real case of that, we can move to
global ID assignment
that includes SMD and TUN.

Thanks,
Youssef
