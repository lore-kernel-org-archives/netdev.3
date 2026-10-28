Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202004;
	b=r1URpI6H9HLUOpvfYWuysisbJBXgsHCn7mVAp/fKy2rmM6yS0xIx0i25UFfw/Ngi87rV
	 HLuk9kPplpCcYtLB/Vfjhc1EL76WhUnJExZcK7xtLn9qrOmUYr1ZxL4W5bfLM3+L7fAjp
	 kNmUCBDcKoXCw3IOqnJHrwP99IGiNT6MsH9vmXfEyKXOsOBMlWA8mY8H1eHbA+8BckFnR
	 md3BZ+6aHYwri7Cys4jx3/MsjccrlJvAJuwCLVBqag0aS7j+2+7QsqL4gU9eS0RIg2ZD3
	 rkm8zmYMMM8aSMxMDzWxDp97KPgXQcAs7ZSiYuVYzk0E4j3NdVG/M9yvI7iVzGNbxHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202004;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lZeWqgO+2lHgeB2G3uZ2RGo97UeDvnaxq8shefBQPMQ=;
	b=Fb72ruN6KRPhSJTLqtGdrXCl4zke0G168nAMMKuc/2KTD5j86C5JAV05fr0JX4fyDoiw
	 JfRKKueke2lRE41tMMtl3CfAg7+XeyparsprtTXKmPAHwuh8jaXdzPqVxtq79kEwn7bB+
	 qSCVc9y3K9BLpYelh0oIorz/OtWsTe9mkDTzympYmEY/Vty1JCXZ1nLueGPNTMDGjMR3K
	 ASOJPXpJPGzO3g2QL3PEEAsxrAW4OOxbmCdqVFndBx3/xRybAxL3/G3c7Xcwaz3hBx6z6
	 nfTxt/8a53TRVtZhCrxrW+c5Wf+geRzocKzmP6Kcwu8QHnUM6td6WJZ5GXm6DFtbaWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4gG80mw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfBZPdTm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0939606A323
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0939606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4gG80mw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfBZPdTm
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAE1U2001700
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lZeWqgO+2lHgeB2G3uZ2RGo9
	7UeDvnaxq8shefBQPMQ=; b=b4gG80mwz9eOkArK4wem2b/toBhwdMRvOpAazlgi
	QaGwu0u7Z+CSUeIm8cDdiaaaV6VPEWgJxDRpRzAyAmTESsDswyDXDYUdkgWFpKMN
	ol89qlux3BGZGJZaY7AvrxsST86HegLkTcj6z9xbhhevMKdSPQGIByzkP+jkBj0w
	jf1Ptq9UU6sm0/nXAuWg0egt7G9f1xDrnf64iWTmA8ikHndHH+5RZonOUPOuClp5
	k2/cbTn/BpNvlDOygac1DXQsbksoTqpXRWUSAAVJb3eilEOpaGQJdw29PQwUCt3E
	TDGLOPe3B6h9EpVUWVdOBoKUcya3aTTz1yUpU0PGDIKjXA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdf7sr1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:40:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7b175e38so23366556d6.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793202002; x=1793806802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lZeWqgO+2lHgeB2G3uZ2RGo97UeDvnaxq8shefBQPMQ=;
        b=KfBZPdTmyJQcWJlVjr2DXOgJlKlLr8YDCNpmlMU6cKGWC0pcsA05NPfWK08fAVbZ/I
         ap50ljy/Li/m/kH+Ylf5325KvsCePyHEuOsm8QhwLmH0DNpkt1O/1rj++HrLx/GlT1T9
         TScy8Zk1cNBCRQimwYzB0ucCRmtmYvykVuI14RLE9SUQ9o2xfPT5G5w93t0M+rcSZZQa
         vwq9RjAq3BIHBTLLJdDjlxGhxRQsAnAJCNOCXE+Si3MeQSGe04uNX7DLGMW23vmJtpHG
         gL9+VBAFRw74O0PWcAJq4/Qh5uBNaQ5Y1yZO9aAmCEmjC1r7a0nKNldlU6u4BIiGRB5Q
         mfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202002; x=1793806802;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZeWqgO+2lHgeB2G3uZ2RGo97UeDvnaxq8shefBQPMQ=;
        b=dSfA9pclUkiJSrNb2iFtq0UMwkB+LDNtx4slqagqa77XGaxeHafpkyhTd+TZRREya0
         EhrJLlZP7yZZ+5qIw45EB+8S7W9KgSC6rxpue5/KRU5T6KX2fyZk65Y4mNzuDZRQidHI
         Ln9VSHEKtYl05USvdmIOaRm912FlHqDg5/ZqIoQsU3NUD/49GtT+QVar/SNovUyBU1P9
         TlXUgCLCpf96pSX4aTGyosfJsMguTl92MtjK9XB08++IL2/zQVudch9vzETobNoZ/Ihb
         dYbc+mYT1/UzNaT423wBEqEbfB1FwQgOHjkDaGaNCwtiQaO8SPtvDi/sm3L9RbdKmPQ+
         vWog==
X-Forwarded-Encrypted: i=1; AKwUvBwzcXpsh72XK6mgq5KVVr08iF8zauDImqf6d7c8TfNaKYhZCQp6nu0a8la6oyQCXAr4UARW17g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx75D7faPb2q/gZOrNKcFH0W2UMzuKyc9s/GbjFGWAq/sjr0mk
	apc+p+idLCxwtaKtp/CGm38FsiRvtqJEzJvFmgem7cttQ2AYuqs+ZLBH/UmXaQ+vWl1EZl6dwT+
	l2HlZROI2qblO6muy1h14WVAxAYVs0IeWhYb5CogcEhZ7qGAehsbWUj2MskViPb2fW8o=
X-Gm-Gg: AYBFou0dlszruPRiH19dVWSh5rxITo3qSrhH9yERsE+v40m4O2acIThmq/4ek2meD/6
	LhyoZbtU+banMCKdtKBobN3+afbc6L75ypjwrc6GIA9xHzqKyKB14xFgUGsVdMmJ9Lx3zEAucZR
	qEANvi5HLTfEPdy9lWzAiO9BeMDjdkUo9KtKAeU1IaxocFe+6izYAdNPDtm6r2zlUREXqX34GAb
	734EAUIGs82AIHfbE+Ivut5eTcMi8LT/NShVtB1eRz7pRSSUJ2w0T05MJqCAyvp9D9/EQv5+Il7
	n2TRCY2TxjGqLdrEgK8biOXRugZ5Hl6EUY8kOksR20q8JWL5y3MbF2DbqZUopx/nwt84fe2t35Y
	DlQmy6kEHogPoD7HSEim2m27bZj01RS2/lTj2dGyTrakhsazhBtQ364hypxOJkYj80A==
X-Received: by 2002:a05:6214:d0f:b0:91c:7a3c:22ae with SMTP id 6a1803df08f44-91c7cdf92d0mr43355186d6.1.1793202001675;
        Wed, 28 Oct 2026 08:40:01 -0700 (PDT)
X-Received: by 2002:a05:6122:e208:b0:5c9:a60b:e5d8 with SMTP id 71dfb90a1353d-5ec4ccfee2dmr1553631e0c.18.1793201562412;
        Wed, 28 Oct 2026 08:32:42 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4be6sm26641291f8f.37.2026.10.28.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:32:41 -0700 (PDT)
Date: Wed, 28 Oct 2026 17:32:39 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: qcs615: Add gp_mn mux function
Message-ID: <iw26iktbkxacfgbt6btvh6nd7u7b3wvogh5c6sgdt47ve24qpi@wsc7vilt3bge>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-0-ff8e4bc8d567@oss.qualcomm.com>
 <20261026-b4-pdm_clk_gp_mnd_v2-v2-8-ff8e4bc8d567@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-8-ff8e4bc8d567@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M4bYuCws c=1 sm=1 tr=0 ts=6ae21752 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Y5GSmcL30hd6fLb0oHwA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: R_TCbxGz-6Md2R7chtMiDc8WzJIPZltv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfXyM/0bk7Ypjmz
 oJ1t8sfxEf8xu0NCLdKl0p+Sg0CpfNIQRmBOYhF2l6gE/224mqqeitFm4z9X2cFhkTVrrTw/urB
 RJv7OGaJKaQ2SV7uoeKY3mzcDCSm0Ro=
X-Proofpoint-ORIG-GUID: R_TCbxGz-6Md2R7chtMiDc8WzJIPZltv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX6AZ30BLoC294
 5ZGLpnq7hLgExNm1vDIhVHSSFP0UeLv6vD8ahK5YOg3kb8mBEBDCUef0vUxFqFYPdLSJXikgWhQ
 EoSozBmJS14ZXe3y8u6luvt37I2WDNgu7pOg1cczbGaNN5fh3OHpr/wIlLC6iFDaXAKvmGUppcF
 eWLrVnGgdX+9di/i5SOoEG6cT/FR+0/zZUiWnLWb1nOdwy7+ngwv5sgBGav7AILwVXp8JvPUlMc
 RYVdZgh5DEBALPBZUT0o73N/dsB6I6Tvu6PcKIgMpFtgkefcp93dppZk/ADJIT6+pB15UW7olrD
 e0eYeTW0HDuoXLSahLSxyEbUKDLtuz7Y+gUy3QHbxXfwo1Bi9I7DmrEWB+ZtKtYJ4DKT0Au8ufF
 WgY2rD1wbmVzK9660Lr1yHWqBhQ5yQ30CCn5dDUYlphi0UXrFXreHmwab57qI2gXN2tVb9eYtnJ
 JuhXLRg7C59Oi/0c/Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280062

On 26-10-26 16:59:34, Taniya Das wrote:
> Add the gp_mn pin mux function on gpio29 of QCS615. This exposes the
> GP M/N divider clock output on the dedicated GPIO pin.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
