Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FF44E672
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153452; cv=pass; b=sYafX0CXM3QTu5OqJbeBoJSGtL7gtAYiRwkb5NnW8mIxisHdWES0qiJv0Ri/tSlQDG0ATCaCUgszO2YlAJhGikjg4Pad1HUJigK6JaNPD2GZXH/3oQc8L+49j2q7wbagkfvTjm2GsdJXCzHHKnhWKlrP2BKQywgzyykuLu+DAgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153452; c=relaxed/simple;
	bh=7v2013CmmvcfqVlNh6omWvZ+UMQjVGTi7ffXQjdnqL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhnjdiRX/UYc5NSdu9BUaqm7HtbZ22btGscGHL9O+hbFUr3OkJoBG2CGLYb2ra5MhqP8/3upAC/NhViwbQnZPQDlVt0EV93vN+/vBwE6e1E8TmamJSUu5FU1k/LbsL/0fHxSK4jB11DOtxP9cjFZ441+lM6GF/6y/C4+uhdesvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gum4gTJd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NyVXt0S/; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gum4gTJd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyVXt0S/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8JZvL2004136
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jVlz6wozUNJU7Ozc0pFD8STVyfYjHeBzDGHFKBRICIM=; b=gum4gTJdGnvbTqQj
	VnGZ48CvO5dXwaN703L4zRE+4OtxCXP5YLO9HxLDqbQqTpRsEzXa2GmXaZ43lhVS
	n+OKqyo+WE/T88KyggyHH+qNqi2dQVtHMHc+pizRqRZsvuYBer0Ht6ZtOc+cCjvP
	HNyGX4cKRPFjoAEVbmnwlwX/SMjRCzt+A7/LKtFh+7FiflXxbMoUMVERD7da0luG
	sp1Sp96ptBTmKOsZFaVb37aZVxVyoCL5lvAk7iceuIj5P4yKTsooBB9nNRB3o7y+
	Qma7KtaxD5RsFujeiUtayu16T088CgsnEIKghjg5R2hakTAnVU0UJ+0EUtQ1cMKh
	Bd0+6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec4h63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:50:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86ab8302b54so586006b3a.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790153449; cv=none;
        d=google.com; s=arc-20260327;
        b=KrhAGbkL9qj9FEtiqBD3K7MgY/tIqxy5S+E72EfUJ0MftIl8E1buSnUsw9Pwm33HTT
         PVlw9CrkJfDSZUGbLZcLx3zCdkoxRSmHiBS/gQU7QEdZXNqy/TXfT9X+FIPceoXEi2Qr
         UW+KkStkttKSoFv6HCZo6UO4X1jAEiVBzibdG8AKPQH4/brKnO1bGvpqYpcoAx7L/Zh7
         CzcmDa2eb7oygxm/e1BSH2otrPS0zILA7oNvoSbgtJvvYpzLpmjrPsrPLIxofycaepcp
         CipB6mD2+YEHL2jlYP/wcZMb2jRk9RZsdVpb8VxgKYBoX4hcKB982Dg2rneHm5Os5YXP
         T4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jVlz6wozUNJU7Ozc0pFD8STVyfYjHeBzDGHFKBRICIM=;
        fh=z/pl1HAN8VwGRgfgkpq0zrhAqL1NVcuoQLQ8H/nLk04=;
        b=qCpaQBBISH7Rq2kt7Le/vH6QMTVlZLlzLdOwTuAwSGTI9ym2OFsf8ArrploFqRAvnx
         QvTeEIxVXDUMUIeithytVxsIkPxkNLmNPlPIsNRvzdXGt/abaxCUd2qJh5okyphDwu8L
         6+G3vlGQDgVJFadttg77bJB8iNMD5szpdccF3zjSrkbHHzR+soln1+t8u8ZeEAa9G/tY
         aA/zQuKFM++KWzJhOhVD5iVlJsAXOqDzK1u0LAFrKCkx8nuNpAQXTRlwIi+WlYpzaErl
         pwryiFo4RcexrVjmfMBQIvpTKFZJRS5FT652Do34GQbpu3xxkOichAzXqI+BgXAYzF3Y
         bPFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790153449; x=1790758249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVlz6wozUNJU7Ozc0pFD8STVyfYjHeBzDGHFKBRICIM=;
        b=NyVXt0S/U8o2KYZJDG3Fha35cml6RmzJfkFfXyqec9L9swOCxwem4AzYPlFMO+VEi3
         yZKxV0XrUGkguhcMRns8zfj9W2RK+MfOQXQCrQPe1uCTVeLSJbX7jbmFrTuSKPNGV+2j
         FqM0knIqtsHaibtDIXHc76xNoc/DR31OIkAqb4u0oLttkSOriWFtv4WyWO6XQ3SkxVfr
         sG35+JmEuCiQ+V9cy0lEr2S/LwOHx2JSUc5Vmr3oAp3cFMdfjLH9M7kkcZVqiIq/wG6E
         Sh+Xlm8CJIXKSsnfDOUrsuqZg9oS7PXALD75QJWBjQ/Bb8+4wavSBYzek0H8I8qW9q5S
         ZnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790153449; x=1790758249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVlz6wozUNJU7Ozc0pFD8STVyfYjHeBzDGHFKBRICIM=;
        b=bzbIIgpXBXR1pf/HfGRQ3aXOcvBIHgQvVDlNJ/A32RH+kGVUrbNtD438XVNaEhxzlN
         bozE630X5rsE5MS86Z+pLnrunfT41FlyZrXuFAZ9Ve+0CXscbv73eaDV9oA8ABItfSS/
         4E8Xn0i5jXjTC5Me3zzLjskfAqMRtqUCF3empyDECNS1cZe/VEcZc6+VmzRVbElgc84j
         zpi0UAdWqeaD9YRfQ2BDq/VFpMNla8W0VzX1mSbuVj5HdH5CNFe9VUWoTNxWUWEsvVbt
         esf4/u6mi9w/3/AjiOgAcHJxGiUXaAehtZr3RvU5u+RJeNE6qGRMzUqCh3U66FVVUeJy
         eO/A==
X-Forwarded-Encrypted: i=1; AKwUvByxsNcS9FJ0RjqpAaUkhHVl1r1ecHLvsuxpMOZvrUqAdJGnXDBPjBdfUDTlvCeiEZGmC0knOTM=@vger.kernel.org
X-Gm-Message-State: AFuF++nzyaw6ZpeTuWPDOfo2OHwAJvydVgq0CkD3jKl06gHZxE/bEymR
	HIkg+qZkTXQtms16UQdYs/sYh8tTd4Le26ehqyWVvpRaUkuFmJ5KgJiFaVySWqrkabKj5lD+Ed9
	u318jucbeopdFiE1g+LLLLgsO7SLfO1U2+YhG6jETRYNGEW0fkMrfE5l1P8A+k8C4nzANFs91zD
	RTrx6Ga8ctIXNfUcRIqBJePxFNegNcM4NuQQ==
X-Gm-Gg: AYBFou3QXhCJna/5tZKpmpYu76MqzOPkJGe7hyUbvvcKYtpCWFprBfXkmwNXsIsOKZD
	A60DWO+6Z6xpCD6DG4Fl4Sw64DeqIw5VKe1S7DKZEl27ODVwBcKVOVE/15u/KpsTUOVAw+Vtm/c
	UCnM6BTwRe1avNz4J0wwPKp+vInC8ENRzuiIZk+hO0W3hm9E7STw419lYqsn8yYCbK+3O5
X-Received: by 2002:a05:6a00:2e9e:b0:874:706d:9629 with SMTP id d2e1a72fcca58-87d1b6a89bdmr1526849b3a.27.1790153448502;
        Wed, 23 Sep 2026 01:50:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9e:b0:874:706d:9629 with SMTP id
 d2e1a72fcca58-87d1b6a89bdmr1526838b3a.27.1790153447969; Wed, 23 Sep 2026
 01:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:50:36 +0800
X-Gm-Features: AcwNN1UGyeerkYZHrx1isWt7YiSI0LmE8lI6EzIuvsSU-2kHZ8m2Q4mcnuwVcxA
Message-ID: <CAFkd8hsUzJEsDYjGSM3tsJzzwByuEkA+G4k1c75uYD-y5qU3iA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/9] net: introduce Qualcomm XPCS support and
 add Nord Ethernet plumbing
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX3Tnd7MREzeMb
 lgtODONhU4CuINlovFQfHwaLKFplL/smReiMmB/FlpAuDz4lEetfKG4pds1TXMJ3Abp2OVlGaPH
 wGIDPfcqDuMJ83s1TZ6Zc0CpRlJJjxMFvf+IrQDpmMSBLBv59T/Ate7M+3cfFVRkClsGz+JFSFu
 6OssSOlAFKiNTaqWaUDpHnFDg3qmFaV17UzRQCZYTpBMLB9yUIsImhcMC67R2DSMSyj3fufO3BV
 gtBPmR7rKYxf4K0S6eeLFV82EF6EqhxTDVdCfmIma3fwjOTmrqKj2Erf8D0TicY1TAN6tbpIhMY
 PNGYeQjpOv8z6jEA3e+/RiXgAGEiZk6qDDbHTpmxKFFB8UR2b3yUZXtXdgRs04xQCmHWkp8wgrk
 Lw1Moq/5kjvOZctZb114p8yUC4UPg43MBR8BpbdJbwn0qcmzp9OvfroMIBj4/mnppoXvZAjZTiP
 DxwFHS1MAsvMdpijxiQ==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab392e9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=Gcu-WNPWmvmYkCXGu7wA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 6uWxVWtV9Rg1YwLD_dWf2Np6k2v7m03w
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX/WVNPsQUmnW7
 GF08mnOBrgac7Fgl1sZ/PM5euQCnWHu/7nDkcibfCc/6I8TfIwAWTwMwqbASxIHCRqQ3QmYYRtA
 fuAI5tMfCyCJwMwm6rYxfnAY0Ts9c2g=
X-Proofpoint-ORIG-GUID: 6uWxVWtV9Rg1YwLD_dWf2Np6k2v7m03w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

On Wed, Sep 23, 2026 at 9:08=E2=80=AFAM Mohd Ayaan Anwar
<mohd.anwar@oss.qualcomm.com> wrote:
>
> Hi,
>
> This is an early RFC which adds the XPCS and ETHQOS plumbing required
> to enable 10 Gigabit Ethernet on the Qualcomm Nord SoC. This is the
> first time USXGMII together with an external PCS is being supported by
> the dwmac-qcom-ethqos driver.
>
> This platform was somewhat tricky to work on, with several new pieces
> having to come together across the MAC, XPCS and SerDes layers. Any
> feedback would be appreciated, particularly around the XPCS modelling
> and the generic stmmac register-layout changes.
>
> The overall hardware path looks like this:
>
>   +------------------+      +------------------+      +------------------=
+      +------------------+
>   |    DW25GMAC      | ---> |  Synopsys XPCS   | ---> | QCOM SGMII PHY   =
| =3D=3D=3D> | Ext PHY / Switch |
>   | + QCOM ETHQOS    |      | + QCOM wrapper   |      |    (SerDes)      =
|      | USX/10GBASE-R    |
>   +------------------+      +------------------+      +------------------=
+      +------------------+
>
> The series can be broadly divided into two areas:
>
> 1. Qualcomm XPCS support
>
> Nord integrates a Synopsys DesignWare XPCS, but exposes the PCS,
> PMA/PMD and MII MMD register regions through separate direct-MMIO
> windows instead of the standard contiguous or indirect XPCS mappings.
> Patches 1 through 5 add the binding, generic platform register-access
> hooks, the Qualcomm MMD-to-MMIO translation, and the runtime-PM handling
> needed for the CSR clock.
>
> The XPCS also uses Clause 37 control and status for USXGMII, while the
> generic XPCS support currently handles USXGMII using Clause 73. Patch 2
> adds the required Clause 37 USXGMII configuration and link-state path.
>
> Using a small Qualcomm-specific access layer around the existing XPCS
> core was the most straightforward way I could find to model this IP.
> The core already uses synthetic IDs for the NXP integrations and has
> vendor-specific hooks for other XPCS implementations, so this series
> follows a similar approach. I am very much open to suggestions if there
> is a cleaner way to represent the non-standard register mapping.
>
> 2. DW25GMAC and Qualcomm ETHQOS support
>
> Patches 6 through 9 add the Nord ETHQOS binding and driver support. The
> Nord integration has sparse, platform-specific MTL queue and DMA channel
> addresses, as well as a relocated timestamp register bank. The series
> therefore adds optional XGMAC register-layout data while preserving the
> standard layout for existing platforms.
>
> The ETHQOS driver then selects the XPCS provided through pcs-handle and
> adds the Nord wrapper programming required for USXGMII, including the
> EEE clock vote needed for PCS link-up and the platform-specific SerDes
> loopback control.
>
> This series has an obvious dependency on Jitendra Vegiraju's DW25GMAC
> work:
> https://lore.kernel.org/netdev/20260402213629.1996133-1-jitendra.vegiraju=
@broadcom.com/
>
> I understand that a v10 of that series is planned. While bringing up
> Nord, I also needed a few fixes on top of the DW25GMAC series. Those are
> not included here; I will share them separately with Jitendra in case
> they are useful for the next revision.
>
> Testing:
> Initial testing was done on the Nord Ride SX platform, where both
> Ethernet ports connect to the on-board MV-Q6223 switch using fixed-link
> USXGMII at 10 Gbps. The testing tree included the DW25GMAC dependency
> and the additional fixups mentioned above.
>
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---
> Mohd Ayaan Anwar (9):
>       dt-bindings: net: pcs: add Qualcomm Nord XPCS
>       net: pcs: xpcs: add USXGMII Clause 37 autoneg support
>       net: pcs: xpcs: add custom platform register accessors
>       net: pcs: xpcs: add Qualcomm Nord platform support
>       net: pcs: xpcs: initialize runtime PM as suspended
>       dt-bindings: net: qcom,ethqos: add Qualcomm Nord
>       net: stmmac: support custom XGMAC register layouts
>       net: stmmac: qcom-ethqos: support external PCS
>       net: stmmac: qcom-ethqos: add Qualcomm Nord support
>
>  .../devicetree/bindings/net/pcs/snps,dw-xpcs.yaml  |  17 +++
>  .../devicetree/bindings/net/qcom,ethqos.yaml       |  57 ++++++--
>  .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +
>  drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 162 +++++++++++++++=
+++++-
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  94 ++++++++----
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  34 +++--
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 128 +++++++++------=
-
>  drivers/net/ethernet/stmicro/stmmac/hwif.c         |   5 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   5 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |  15 +-
>  drivers/net/pcs/Makefile                           |   3 +-
>  drivers/net/pcs/pcs-xpcs-plat.c                    |  47 +++++-
>  drivers/net/pcs/pcs-xpcs-qcom.c                    |  86 +++++++++++
>  drivers/net/pcs/pcs-xpcs-qcom.h                    |  16 ++
>  drivers/net/pcs/pcs-xpcs.c                         | 126 +++++++++++++++=
+
>  drivers/net/pcs/pcs-xpcs.h                         |  15 ++
>  include/linux/pcs/pcs-xpcs.h                       |   2 +
>  include/linux/stmmac.h                             |  11 ++
>  20 files changed, 707 insertions(+), 121 deletions(-)
> ---
> base-commit: 6598456d72e48d779445bfec8f72114747f8b8d7
> change-id: 20260923-qcom_xpcs_nord_emac-bf296eb48e4b
>
> Best regards,
> --
> Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
>

Good Job, Mohd

Tested-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>

Tested on both IQ10 RRD and Ride

Full test patch is in the git
https://github.com/zhangfei-gao/kernel-topics/tree/next-9.23
