Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732190;
	b=E/lQuLZj5nd5eIon8rdKiZpbuWioSTPodvUVxfC9hlHc8XGb+JSmxy/30XEJcy5+eD9y
	 g7VdLQeLVkHIeVGi8w3RcHS3D4Xmehp2hnPzA36YYnLdMOmPo/RzrKqX1bAwCUG9RKyUW
	 +YTMv2PDQVm7EKbM3g8iDfA6lOLX2BIcDpdMrCXGNyuGh+tSHA6eC+o/U9Qg8s5grfgDl
	 Y8oo7FQWdY0vSiZkU4r9U9DFAJ8VpsJ5O06//OAH8PYnsRD1+4wVcv5BaK1M2qTlbqRYn
	 ZvkFublzb01GUUz8Xs/95pxAi0evUUvObE5ZyxZ2lWiICwmLEChVfdM74C87hdLmv3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=;
	b=rQJoF0VqxvOm/QMiyXZTBeGBWjM2TY3JSW5oxUk5j0ZAuVLtriPBimGa3QdEDzRM+CEx
	 o/LFb8OQZkQChwI+CyUhHNnDahhSmME46uiHRIDWDnO6FTlqb4dTFZrcPbryoLpu0uSpp
	 +cVrnXHSmOR5pEpluLpWnfLLcG4G6HMDIhU8ZCnZLR479HZlL1gkBsQVEEKLOquGhL3sj
	 EGoWL42R8EG42x57AUP7RcrRqMon2rN47ZJNZIbXA7HNwie3GKyoDWq/IhbRepRNYkw4M
	 ONmCxEqMziDe3TpDPAVPC1REwLAU+/3y/vCrd8dMmyb/vDeNEDCGG1QKnRYj5B7Ih1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJeS5+Eo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JPUkT2RF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A65606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJeS5+Eo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JPUkT2RF
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N1F939988705
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=; b=RJeS5+EoDeJi1vMg
	Eiz3d3BfH+lSlytnorw2SryWcFbynI/dVqxcy0fjgIC57r2LwsLH1vdfRQqWpc/3
	XtT33eqAUXP0og0TFQfwbjN/I5yOCqv0q+EWg2TN50oH4Os+BXyp6EvmxddK3TkO
	DAfkD4foA3KcF8+IYejIyfJo7QBe+Yicvz+gWU+BFXSAw0eU+3c4SWH8Y5O4dKLc
	EV7QxeumnzfGLH91sexZ+ZTcQiHRxPitRxUmPFWcu2LKxG/I32amDVqdyzXsXFgm
	tNo02jRB0B1ojUjcs0+3zXAkPHcRyU4I2M0s+ATF6DBH8y4wYmnWaAMGTIXRXGWc
	of3Qhw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahtdm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:09:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab08c4aca5so127143a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792732188; x=1793336988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=;
        b=JPUkT2RFfnDkEYnsIe1uPVXZwSbW8bVDshmIMFoxfTg+nPg4wq1FDZg8bBQKhXh+pA
         fsqBSZEiSAqg5jxMjL/FCBff9W0NjYbTt6IyIi1uND/sjVZZrcg/W5Xs3634sbc+I0iO
         PT5CvIHB4aVvMeSxCl8HFZ8YHI9r8XMtCbeykptY4+W8cgRAwcWreTlBkKH56WQNHb66
         FmMNkaZJxTuud32eI79jY2lvjdmrpn09Xf2NjZN9hQG/sIpx/MaXi3+weRsDfUQsiebj
         lsJI6mLNO51RpFstTiFlUjl3dvgoei2jDeoSo+5LMcYfRRIEpdgve06tPMeoQjMXKyxe
         N/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732188; x=1793336988;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=;
        b=LSzwieC4qD57IzoV/7StQLa93aU5zlaB+gHFLUgthGwsltu6DIDn2bxHB6P2JqNh43
         GLH4795W3PPOdOtme0GKuleed/oY7XJJCEg2DW2QYFyPTH0bjqK4eWS4e9YaM2fJOFFj
         6HfBxJINNQKQ2mn/zgrSGAayNZRtSfP/DZVmT+Y8RCeunFqGOGqt2l5QLtVFUNMsJQYl
         PjQE6hZvYT3kSwLyUkgf+aia1NZNhxMx/7RWwC+yYoeU3TaNCe/j9496jJML+n5E1Hup
         btGTWUf3qq9q3jWkyln/e10qhUBu24/APoyWxXYhWI9NM6d5jx7ZyB3CQSKijNQZu+kJ
         1bLg==
X-Forwarded-Encrypted: i=1; AKwUvBxGohvpFpEwz6dw9y+INW0GkXw0OdgKoL4+3+QaLuFraDwdcuf3UbyEXJar5rq8P6cRrk6J54w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZNumTbtheeY4PDMbStoQCPM9CwzeN9Fo4NDRI2G7bwbfii9pj
	NZheqUUaU345AKkEr5duQplRSNP4IysVChQbqlTdXzHXs2/B+vChzktxrIvLkmp2naX79Z8FKdy
	3I4oyS6MnZ+BycfonBWCFmpgW3zg/GG9gljYCGG4N7efWH9JRKrZ2hwf7CCnx0PJ2n4o=
X-Gm-Gg: AYBFou16sA++SEfg3UiqJZFkCfApIAmib9uwY4b4u1Vbki9hGrshSj1ourKj7XtZcsZ
	cfubfGF9IuVir8Eoj/G9bnEU9uo9h53DxDZF6eyrhJpFVpBiLoRyBIgPg+DIRQVRDlF4XhQnM5K
	dTM0Ec5EtUc4J7gJdaOfPs/OR4HLFLx9EEOKg0lUc9S7RNfm+QB0tdoPqBbxJUIxbw/5LTGWVVH
	XBQIzR/SLIqKJbeiNFGeour1gCvYLMQ4gV4BQOUhBgLmYfqS9f9c33JzDjE7joJ9CEVG+0MmJLN
	xh2/UjR47Hw9tUtH+COPb+LzPnoug6zFH+9D7mPluhwOpSeeHH+dUlU24zHeGhe1m2/HrEhaBPD
	SofgwPLdTWGZPbX/C67QIanLq0kKsHmzLVKZyHjJRqKJuA4j9g20eJbY8+iyS/sPw
X-Received: by 2002:a17:90b:4407:b0:3ad:50ef:f5ef with SMTP id 98e67ed59e1d1-3adce08123cmr1517871a91.3.1792732188109;
        Thu, 22 Oct 2026 22:09:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4407:b0:3ad:50ef:f5ef with SMTP id 98e67ed59e1d1-3adce08123cmr1517840a91.3.1792732187636;
        Thu, 22 Oct 2026 22:09:47 -0700 (PDT)
Received: from [10.249.18.99] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1f93e0sm1803501a91.15.2026.10.22.22.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 22:09:47 -0700 (PDT)
Message-ID: <8c868c2a-d5f5-442b-b7cf-997f377ac90c@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:09:44 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm
 multi-subsystem
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
 <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyMCBTYWx0ZWRfX94EkpKpLohtq
 KD+igA7pV+ikhG6u6AdF2BHQUdDRrX/xsE1a5zopqCph/Pt0NlKrndbpnvBlZ78IYT1hHDs9sNl
 qHXqpgIIqdT7xAgbph+gEI6/H98xIIE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyMCBTYWx0ZWRfX9eATSk5Y6o22
 9mgwpGwwVav1LBUPpZEz+IFT2/Y9d9zEi25B7kFAOEOa8ukFqKc8UATGh8o36cEK1wyoN1h0baR
 iiZinQpCcxXBzGw2C6C9UQsdXn8GnCclLhDSS2YtUZWzn1I1synDE9PmhjvKI+fvXF4UhqnN8Cn
 ma5zraYtNrL1JShdK2nN7WOOu3PUZBlM3Qp4YTWG/u02GaWd6kDW36tAEWwY4FgXAZ2/gOiG/qK
 WEEWze64bDnVTNyNtN8X5xrmk2G9LC6GeCLZRO6m+F16ue3U0/xNnz6N1YZXtsxhy+xrB4343Rp
 ryjt2qwAfrwpyaLs6UTtj8mTPZrjAkV1EFC15jlkhwagriWXdb07RVudfsLw077Pcd62iDKSXJ6
 Y4/h39R/sZkJCFiu7wD8ILNr81UOCznma6F35wBg0+UwVjkge+E9UeYtwj21gWBARJMw5PW1Cz+
 rkuH2ynNJWWTBpxba5w==
X-Proofpoint-GUID: MZzb-sIzUOBybxlIbb2MCbLtgLOxaDon
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adaec1d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=MPfgTQqCwHivTDeqJUUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: MZzb-sIzUOBybxlIbb2MCbLtgLOxaDon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230020

On 10/22/2026 11:44 PM, Luiz Augusto von Dentz wrote:
> @Zijun Hu lets us know if you have any problem with it being default
> n, perhaps it can be default y for a specific Qualcomm platform but
> not in general.
Hi Luiz,Paolo,Jakub

Default to y for the following reasons:
1) Avoid regressions when moving support for many existing Qualcomm controllers from btusb_main.c to btusb_qcom.c
2) Align with BT_HCIBTUSB_BCM and BT_HCIBTUSB_RTL, which also default to y.
3) USB devices are hotpluggable
