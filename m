Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC62C11E4
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168485; cv=none; b=rZdLc0BEGl8UI3wdt83kTRexWtl7lR5n4Kgnsa35QxhM4s5j+KwvcytbMT2Q1vUO9GpEo+mrVR1hg+teGMPWKx+ygTPZNjgTkBLXTZAs6Enlm9mTZ8ZXe7AGlbzZTBVXhiHCtSup72zk71z8rAtfURk8gcqaku1P7f6GHAS/eLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168485; c=relaxed/simple;
	bh=BQhmcQ8/Z22Yw6lCi4BPzDtsGaWpPHmu4Ypwm/KljfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUzfWCln+TC1Wz4FNOLyTlzd4hODicknZmTm6gIE7J9b7ScI/FxPpjxWTormYyPp/k3UQmOfnqbDRK7U3KEnlOtWJrLa862OFWyeEG2qc75lACXdkadPvYwtEyAYLSeOG9l0KOiWYHrV3wISsYauZBDeSD1tpgS4JXo8y5Bqk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wx74NA7Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZOBw/2g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wx74NA7Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZOBw/2g"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbVAw099085
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eMsXkNbslObm50nmX1vbEhWW5nBdcP9Nry2Bnrgc9a8=; b=Wx74NA7QxKHAGwP0
	hsMY3mR9BqNLCF3A3lZaUQJkKlDw20Xrl5KUQBJy96tF5YpwgJMRo1TTjGGD/8NH
	tGsoGkCsPIhfEXSqrm5+Jz1Kz7rA012tpO06JHzbnGloNbQ5mlZNPLhyfbwUF8k1
	wXw5f2dnnLe1GruVvA8mCvMX3Stf/nsSI8eQNx6TJzMq0kMf67HwUvdXHkDik9Ob
	W+1RIEtRugOHUQMouFMCMDzCs2g+sB5SAV8rhnqiMyKiYFKiWQ/obqOxoEdajPxZ
	LTOiiXcOfXqxKQZMeyYrzyJ0dFC/5w1JB4ziwjMR4BgC1LRkHRRwl5m/HT6GAX2q
	4EmDvg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c4es4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:01:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e2c22bd0eso238749a91.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790168482; x=1790773282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMsXkNbslObm50nmX1vbEhWW5nBdcP9Nry2Bnrgc9a8=;
        b=JZOBw/2gcsYEjvlwiUlbhkqKf/6iBmhnMFMfK5NftMTUeZoF1sEtr9G5rQkob8I8mZ
         QCxfLpLZR8pCJAfATkCrxHYOuf+BJXCL7zAEWJuU/fift65Xb/1PNG1FqCfhYFl80/GG
         C8NApJG5bsrvbn8/cVwZ2v78lBCyLJ1ch9lSY19APa2fIPR5lhn5GNbKe/upTUViQB4b
         t9ME7QyuAbzrzaVwmExbuYvegoSPFx8UV/2ui2p5ZKcZtC8Hd5Mxf1TGuOHK6ygMZvQd
         wTK7HRApLiNueMLUf0r+ppkZgPGWbn1J12Ocr9uzbwejWyritYRQVQFmoJHOo2B54vBJ
         b0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168482; x=1790773282;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMsXkNbslObm50nmX1vbEhWW5nBdcP9Nry2Bnrgc9a8=;
        b=F0QgqcgUC3AuH55IkGHRJCcxqwT4h0ipYZZaxKFiMYBGdFDkHqQiJ+nnyEvNhfNC1/
         Bqz/fVwSCCArQfjYkeJxtIdrdwjYd90W7gSZ+/ryp6p1KTxV8RWtg4inUI9hKNg8OZ4i
         mCM4Za1ymnL9W/X4gf2AYIMspyvZJiSNhvYM6G09gVDSSKcM3odaDxj975rUE0SAHu80
         Mcb5WoRfIhbDIHI169LHN5fjSaaCeAfqui9iPlU7ecVfAajGWkyH5g1mYy2xtW8/ZwZQ
         1hUHyv0nVNyDJxRfpSpEeF3vGTN3JlD+yGDQYZai3AHjBCqz7MABZbtTdJUpWYRY1WKP
         PS2A==
X-Forwarded-Encrypted: i=1; AKwUvBy6tP5yIdYFePrlaZX3B+k/Uf7WbeQgSSmhtjm7CkZ3yRNqOGVTl1sju6XpfTocXk9IKquRsMQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lmxuxsFmYVksuUWo1OA9sWJwJIJ1tDE8TQE3LtbF9P5VcM2S5g
	GSpgb+GxnISo7dfS1/hxVwHK9j8nuKLWHAAuo7T8brDnTZJDuJZo/nJ21QucqTF1GzN1w677eIh
	1X8qqZJTBR0yofmKQNpsu5EAd57OrBoI6oGUuiISYr7LQP4BFhZD8rQmR0Q0=
X-Gm-Gg: AYBFou0KPTPU114FbGvsQYc+zawadc9Y+fXO2zWgDZvRfl6NYhI57dYaJ6V9LfwW22K
	kY/yZ42kasvVsC3bCr8oaLJkparl9k3R5WhVC54Cypncy5Me/zJrqBVXRWkoUlvsrx4Axy+cJHG
	cq/KuKv+Jp/Ou2Xpyp1nIOCzRwfOpGm2W8KVgf8fPsnYxw7w4oIZEWreAvxhZD4nueJNwhYUadL
	Gg8t/jnZKXtcuBqIlHhE+y1GqwFkIj07wfLuuZox71V/2YsQ/Nt1QtvCJ/B2g6I/wlleJY/wNua
	1MQBpxaZgU9Uja6sN1kMYJnEEZgTBmbwczo/AqWPvDgcfsZWrc005ik2GlNQhOLad4nZO2u3V0g
	gfhR0VUKyBaH/+TcRwsJ8ufajMFYoIsZG
X-Received: by 2002:a17:90b:5290:b0:39e:261:4e13 with SMTP id 98e67ed59e1d1-3a07e708070mr3594698a91.3.1790168482069;
        Wed, 23 Sep 2026 06:01:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5290:b0:39e:261:4e13 with SMTP id 98e67ed59e1d1-3a07e708070mr3594629a91.3.1790168481508;
        Wed, 23 Sep 2026 06:01:21 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6d2defsm113710966b.56.2026.09.23.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 06:01:19 -0700 (PDT)
Message-ID: <19853f61-70d6-4727-b8df-da628c0b88ae@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:01:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 3/5] arm64: dts: qcom: shikra-cqm-evk: enable
 the first Ethernet port
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-3-69c0c5c7c124@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-shikra_ethernet_dts-v1-3-69c0c5c7c124@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfXyL0XuLjJEx0T
 RKvNVMBPfJpIiUNXaX9vzkfsLAgokKcygbJFKjqFoEymTWgi9HjRdRypRKVM1Dj62svDYLcc0qO
 GxTqdClEF9xYRdiM/euFV4kFp9ewoilFRLFbNBvtvDKdg28HNRzII6xja9uQivAl90d1YIPUJHb
 PjGao5Lf03EVyqHnKUNY3M0s9AXbgcn4fhxvhqPCkak8RUQN95G3LzpxQpjiZENc/hlLVdA13Ut
 nhxiOu9SXUiVLoqUXS9xnRRvzf7NxqvfVvFag2a+jY2ybvQyrFRsrKiwY7eJo0cOKYGyYeBjE3X
 ZM0Q58ryxnDe4LClBr/9kuQHPSftJD446OjMIgYjCZuFYVGFjeTAAFohKEShXRIn7sO6c/TV2wj
 E+cCZ/9hYTdty/MSPMz4+/HbIXPskuoeP5U+kSS5LozgiQWO6FFF3MfaIQkWSOS5bm3duSAaHPJ
 UA+fg4eSUuwgn8bh0hg==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab3cda2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Fr0nlaHK86MzVMgUQ3gA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Dj6BfkTbMjdmF-yH_iheJh3vzJzAYEX1
X-Proofpoint-GUID: Dj6BfkTbMjdmF-yH_iheJh3vzJzAYEX1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfX2xvSexm7bBFX
 xTLOxUdxgLxfPqEfbKLFrG3YFSh4sW60bTv/K8RCxmhTjO1UHmVZglFjMQHOWi6Lm3hr6Z6Nhnl
 64sL4ijJfCaFq31Wm+h4vpoMlKlfhfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230051

On 9/8/26 8:23 AM, Mohd Ayaan Anwar wrote:
> Enable ethernet0 for the Shikra CQM EVK board with its DP83867 RGMII
> PHY. The PHY is powered on using a GPIO-controlled 2.5V regulator.
> 
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> ---


[...]

> +&tlmm {
> +	rgmii_phy_pwr_default: rgmii-phy-pwr-default-state {
> +		pins = "gpio149";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;

You shouldn't need that - the driver will take care of the 
GPIO

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
