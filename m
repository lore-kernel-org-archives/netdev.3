Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182401;
	b=SnTF/F4w6fYPjGtaAHd3VMw+HVNKmpogVHSv5WWzOpXjtojQTg90l+IYfJz6uMYFWeBb
	 rH8Rersk/OgHT1yffqrPNpLZsXmJpl0ft5eEORrHymotPHoWIozZ8BYFM6v7ys80hteiY
	 Y2QV/tTS6sFzKaHTDOpmZWWot2dGv9hwSsm/D68HlCZWg9kZmOmnYoTWQtDVtVIQ8tLxs
	 Pp14YFA7A6+x0TDTv1Neej4CGz4db64UpKHuYu3M8bWzPldQnUEG24EUBXgy+zYK1Oqzm
	 EVOIEa7dGADQuAtInin6ZhB3LeATYMXLqPKOKZMJr3ujX3q71K6/yas8ezkZnDBSB/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182401;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4GoiSSZTBci+FWZ8jvsDrk8LVCpVLRNNBYJskL/l8Fo=;
	b=33u1ea2piOFwP2UEf9NXj8Uaek6rLxlKbGNwMQ7wD+aKIT5n4BTUUVSPsRxZbp4mZOzQ
	 Aqbhy0MFsuW0HT4UQXRbxFVwyWZRVxOvXFJ9DDtihojZTpd2Ay7P0p39hX6RGUctJDrFI
	 LzIjYKhPHXjoFOcDeZby5T6UyEacQiZMgQcJjRybX/SkTZvynThnCPFgU14Gs/2wF1TUI
	 4PQCZEKBJFu9p0+jz4JNSRLj5kqhXELLjnBUreMghY5SwrTCG/j4hn6FyuMYiEJ1F8twC
	 Klfx7SWlGv5W1j5OyWgWwBgOTZHpfOl0rtZNBOHW6bOtYBO1OKkyxBs/rPgqfck26uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cVeYb1Zh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kaw8xQpg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94F5606A324
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B94F5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cVeYb1Zh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kaw8xQpg
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8hJ1U3768373
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4GoiSSZTBci+FWZ8jvsDrk8L
	VCpVLRNNBYJskL/l8Fo=; b=cVeYb1Zho5kN54poLg09hAt9NXAremIF2oEjcxfJ
	xZPGraeREvqLKSwr9ROKamr9he1IEQ53PM2Y9WV47dzINOuUekdT6PIawSIu6KJi
	OvmrfBET1dUzDId/nPkaf8f6h33UTMnt2F/ZI+CDYURZBcn0onwu9v04UqxCrKP2
	9ku9DMxl/S7c1s+/JfFI8LHhDb6m3qoQUBa5UqGYJrzWeM+5EJEKiuuWcNmHs/iv
	+xOfPL1GFqAeZdqo4RC3PnIFwMK1N8FkB3ORG0PlQA2opBcWhztNjZvWKMyd0yB8
	ZFy82CMvyPKQDx9RJ51+NRHuquLBOq2pjSPdaY2VYQpUqA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp0aqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:13:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so1742796eec.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793182399; x=1793787199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4GoiSSZTBci+FWZ8jvsDrk8LVCpVLRNNBYJskL/l8Fo=;
        b=Kaw8xQpgNq198dq7TyahsEbocmVT6cuKa5aYvzNLerZGLlPa+BXk1u6jhr/hi3qe95
         /TnygKQEHLHjFYwDV4NpZegNGb2SQXuBwcONsWZYdD5zPTRg+BFr+cagND8ilrmywn1O
         mHAEHuNtyS2q3EKnFYRfaEwKeRnNY3VxOa9ftwgcOlFZwprJRrpkzF8FWjLYrjt2+qMz
         edCelqIOirriRp7TeR6KjnCeL/ecTKnoNmLQiwLSIedIl4RaTua4gKAesR9hv3s7PNOC
         2VP19vMtaxjDEg36GbbUylPqgwWYkCdT2wzVe28eZXqiJaN+nSmnyyb/rUsH9ZlkSLCP
         hWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793182399; x=1793787199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GoiSSZTBci+FWZ8jvsDrk8LVCpVLRNNBYJskL/l8Fo=;
        b=smXppaBJFAGR8/Uh7HAEz3i5nuaAedty/KNLbF39fkNa9yqSayrZYrvqS0UD32MxtQ
         DmsuCX8FN100uZjJ3cMEpz+P60Jk1bmCHfPERtRhCUS9pjds0EcEeizE61ku9PIDYuJI
         Vq+YY+Nq6T9sL8sIjuf/kZjKPDCYqG3BipHsNyCV5V7lLEs45eWyfD7nyC775/ggKIpg
         wPhIqXPBgYgrwZLEzXcFAPT4WNhC6OJWgR3cRTw0bC+wYbpf7ktDUwb2Xv2E46NiiU5V
         8u1k19Y2BG0zZOGJ2+CHB9SvufWo5Fkrrfy8nrUW68WHxE5XSbYzNXv+KXLc68fLkkFn
         xYng==
X-Forwarded-Encrypted: i=1; AKwUvBzv8aI/070NxAhWG9OhIZhYM8pPr5H87xetlUMn89U25Ji5seQ6DkzsIZrKF/dAlAfQ6eE3S40=@vger.kernel.org
X-Gm-Message-State: AFq9FYK80lrzPZQ3ik9PuQpor9mmHoeg2V2AiEDTjekxQ4DsnehjIx/3
	SmoVecwlVnCxFXJ5GPvooe3ZS7rwAHrE1O5jlhvBzO9sVvB4lseC7OWboPXTj0oSXSS2NewqL5/
	z0WJfbPmWCfF8Z5wDQ5KZtdclQaCVRBVfEVtlK71fBfr5KpnDW9TDHXsCExw=
X-Gm-Gg: AYBFou2EUTtiq6iZnw93mFVEUdwL63xIGMPzqGiOBLVWwTS8TNzU4b9h/3mBW0JgT52
	nxoQRXXZRvTc0Da6aimg1xWnn/QuZMTDrIzzQMM+PjDfXXmefn/1sJx2uGOX8NQzaC7Jj/oAhY6
	6qP//9gnYt3grBToFP1L8rtyHPYJcdCi/0UYn1cd2/u4bVKaInhiMkO5nzivteGnziIehD85Y6Q
	uGefutNCpXs9ksrBr+Or8TQumUsRhWKziGlY8W1rGsZ3HsZSszAG/u7bZKc8opWPA5QSe/fwQSB
	VZX7XyJt30TBTOw74B01b+bpj9xF66ORiMk5xOOfrjoJOSdvlhlo/h36rmEc8Lonv2oZNjQFzXr
	bJo4L9eDl3sejzhTN+6jBzGngHKNOo6wPyxYEy8iG8Bo2JpFCkcIB/wKoQA6aWjyAw63xdwZAKL
	cRyzrtvGFcJF5oh5g=
X-Received: by 2002:a05:693c:240e:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-36a204049b5mr2973415eec.40.1793182398561;
        Wed, 28 Oct 2026 03:13:18 -0700 (PDT)
X-Received: by 2002:a05:693c:240e:b0:35d:2633:ff79 with SMTP id 5a478bee46e88-36a204049b5mr2973376eec.40.1793182397948;
        Wed, 28 Oct 2026 03:13:17 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bc445sm4865357eec.1.2026.10.28.03.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:13:17 -0700 (PDT)
Date: Wed, 28 Oct 2026 18:13:11 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: lemans: make the emac compatible
 specific to the embedded variant
Message-ID: <auHKt_hdMPaolIR8@QCOM-aGQu4IUr3Y>
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
 <at8Q9umfE2AP24lI@QCOM-aGQu4IUr3Y>
 <CAMRc=McYTWmV6iAbm97C-xs1vh9Atvy-LivQBW10iHQh5+rPzQ@mail.gmail.com>
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
In-Reply-To: <CAMRc=McYTWmV6iAbm97C-xs1vh9Atvy-LivQBW10iHQh5+rPzQ@mail.gmail.com>
X-Proofpoint-GUID: GzksAs_EKSlGvzsxePMoA7Celr0wFTxL
X-Proofpoint-ORIG-GUID: GzksAs_EKSlGvzsxePMoA7Celr0wFTxL
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae1cabf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=d-OPr4wEzgqMDXe8fBoA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MCBTYWx0ZWRfXwIii/qKMo4qo
 tI16zFmI2mkRMHiwKge5e1IsrnUOXivQNOfFKHjjKdd24uyKeikoqPbDEg2dWoc/mtRdw/VOHgF
 wRBXH/RmmQEwN4lrEbBiho5XhPGWv5dgCKWvFP2Fh7EsAOEZfFUNa8Q/b1/4ucWE1+9aefL503a
 t/o9Cx2ys3z6FhnSUq20ay0XkmQHmxHTx+llssQUiAhFLIyeICC/YZHTCwFTbBinwXlxGsylStU
 EO6wpDbiIoK9F60FIe0UUkseurS+DlceVwZrJawF6/U88+sYgD2pyXkQM/2BGU0+diVgNo+PUIp
 aGEPNEFVgTMeTwtlrm5fRJytplQzIr8iUtixgdXXt/TkM+MVSOM5Ljc0ZT9GqczaVAeOFx6EI2E
 tkncVJ0BNxkj9KZDmKHQOuoanT0Ye7XmkBIQC11yVFPpcsGiLbjpqpMSqFSG+VspoX9YPz4dx75
 a1W2/g7R1pUuoPv5DYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MCBTYWx0ZWRfX57TqDwH9kWzp
 9wkg9my/I1Yp2G8N/ZdIwIUFjNgftJLi47ohzVgfeI7xawr0QSvD+5UitnABQSg53EeIEWK8Nd1
 vVyk5QCKoNM2MJ6c+NOux6nzj3Cxn+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280040

On Wed, Oct 28, 2026 at 01:25:34AM -0700, Bartosz Golaszewski wrote:
> On Mon, 26 Oct 2026 09:36:06 +0100, Shawn Guo
> <shengchao.guo@oss.qualcomm.com> said:
> > On Fri, Oct 23, 2026 at 11:02:23AM +0200, Bartosz Golaszewski wrote:
> >> The embedded and gearvm variants of the ethernet MAC use different
> >> compatibles so move the one for sa8775p into lemans-embedded.dtsi and
> >> make place for the gearvm variant to be placed in lemans-gearvm.dtsi.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >
> > Do we run into any problem if lemans-gearvm.dtsi simply overwrites
> > the compatible without this patch?
> >
> 
> Technically no, but then lemans.dtsi is incorrect as the MAC compatible depends
> on the firmware variant. I'd move it if you're already touching the files
> anyway.

This will be inconsistent to what we generally do today for both
Lemans and Nord, i.e. we are defaulting compatible to Embedded variant
in <soc>.dtsi and overwriting it as needed in <soc>-gearvm.dtsi.

Shawn
