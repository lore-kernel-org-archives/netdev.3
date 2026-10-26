Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793052624;
	b=bO+YfC6HMMGJ3yDitPQD9zhC/+UUIKdw33hMMR8ID3a5qccizlfG+M5RfrOtGC3Td7si
	 GQr/wfzWBDGHuqDZ2LrcyX2HkBlsalJAnamwH0NsJ9R9uZR8R0SDsOG4HK5Db5fmPgers
	 ccxwa+kuqIusW3l0RtbzWecmO4annDgdgWgyJHxv+x2EYndkaiEZm7jIBhvZvq0bvAdzb
	 PoBYCcNk1imGdi0+OOKOw3JL4wxXGjqOjXZzpb0Ox6pBqhC/NTZqjqb/wMJzyv6QA4NEu
	 1WDZaOXnRVB341BkPD09Z/fkUbn+j6jJKsf9xBhgflOK58rJRQ5AoWapai7qgjmR2/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version;
	bh=Jf+loG0vAvnxt28Kqn9IrWU5X0/8DtmZggaMgC0lLF8=;
	b=nvvJ2oHAQdT9gD7RDynPUu5zhdE03qiUU8vBDHGWD+VyMfkSGWDrVdm1kgEKpZbEnjMT
	 ZVZ6/jkEY1oYnKoVcZQvdUilMHlHWI8Xixgg8XpYeZBBvgiXjX/SfyNhna+TZOQxck2yZ
	 s+Icz548hE4lX91l4epzw4xZSjLbv5fJKcsxn9/otk9Xo0yoH8vbAXiXYYl8Djxv0KrWM
	 4bYhPOj8lbZD4MC8y3HE7xPBvWLiqpXRQRvGmXRapZSpretI0+ZCmXL6exeLh3x6erpzw
	 10ESoQhM0a/WU944HyfkezWG0niTLq0lFn3LG1KxOZ682vJrjd0rHF1l+TJ8hXp3IuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dZ9tR9L1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65254606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65254606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dZ9tR9L1
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QInXnc731159
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:10:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=Jf+loG0vAvn
	xt28Kqn9IrWU5X0/8DtmZggaMgC0lLF8=; b=dZ9tR9L1/IcxcsH4mEsKPx0GW5e
	UTGvTAWR0q1qhi/B1g7OHS+XHoohqe5XI+h4y/PThlpFE9BsEbWgJiN7eBQlxbFk
	c+8mY+yz8bMouKprc8O3DjrQU3Akz4oTvZpi4r2DjPk2vqEtNi0gM420ieQ5TBGQ
	OLZnhdv/E4lSiGhyExxYkBHSxocmkny3xTMO6kroAjj09D91kBCL+7qodbBM+UfB
	Z/cMVDLbA4rw5O2SP6MupF/qOmMi4axMzQQM+aUiaVU2MBQB2wI3Po4/YvMr8hp2
	zb5Z2ASgUu/S8qEr+ZMjM3GYoWb0Wyrhh5iLDNjyCR15YzzgAKPjekwpR9Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hhee5t66g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:10:22 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8862ed0539dso4089985b3a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793052622; cv=none;
        d=google.com; s=arc-20260327;
        b=AlN7jxpTYoaBE4GvpLf5y36WcaCo0hAsZmsI3f6NCjh8iUAEqEIL3KYU79BIoYDZnj
         bWTrerBIF7NMtvOo0216FDMupKUuPdUoQ541arZAv5nLHdtzK9n0KJeEM16gWrrb+gtv
         CYm3LC/K7zsgUaWIYdphdQxhl42zAYhL9Rt0oNMd1tZ4MC2IYfZ1PeMZU4wzyOCZvIUq
         gQKNiTTBZkgfLaoHfp47l28Vqv0oCsprSeCaaIKTLWTPl1p50Oskk4kg1LTpPWM1oWIE
         RsYZgw3MZgBSiUgibS5C5YDeSG46LvrbiwVkfiJ55HVpxvBEDdfDYo6UlbGFKN5AhQqJ
         xzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=Jf+loG0vAvnxt28Kqn9IrWU5X0/8DtmZggaMgC0lLF8=;
        fh=8/RiRcyUYH4i3uQ5xdJ/upUXGxUN7xAEVO0fdXdN8lQ=;
        b=Siza9HekTwdK7bc3dQCwnDfId2tm7P5g65H0LiUsfJhC27HJtiy5MuX0U2+Z2ClnAi
         camdENO3rieHuFrfJ+DGdgRHAtKqi+UBoWUjUoXrxbQOqSXP1HaHNkrd7zQfw+nY4qkp
         Gi4Dsr7HVBqVOcvnqrGlFyd5au2+1qW8JVoAfkbRzKR0JMvNegCHpP05UugxfMHs2wO0
         dkxANcNf6wnIlKnBPV0A/PJCpp3paqkg8V26Wj/RZb54PLRjsD5RvVoieUvoUIfsQeSD
         7JDbD7qIxTwsB9cHrqbmzo7MID/2u7lA3sSuJp1egKYrf5/J3tIK4YstJDl4nUeg1K3h
         r5Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052622; x=1793657422;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jf+loG0vAvnxt28Kqn9IrWU5X0/8DtmZggaMgC0lLF8=;
        b=1tfu8vIdXp6lN5pl5H7kUuatlMHfEyc2x32XC3qns0fUG71g2Oq41Gw3c3vWQSo3tR
         Ostht2vj1yT6kyBnefA0O0WEwM+noyLG9pjzhhjjgHJ77UqEFgHggLG8GIYx75VUv2c7
         GYMRZMTHfyC19+TNAGPBFtE9S7DoDV82LGEIWQGh+22lUrEiEKmS8TkLPYELWI5FTHus
         45lYgOa4Htt+9L/hZpfi11jJ5fHUIyVPfZAl8lt2KC8FnvrmKeCwCTCI2Agc7aZorUSf
         fGDKO8KNzqgbas0Ok9zkDoVFA9buOojHTK2XAi50c489S9Bl5yw3DNwFfnUUUx+KN9/F
         bD0Q==
X-Gm-Message-State: AFq9FYJ0RPgddAL1wDKoz0+lWW7d6HxGq7M9EMBF4EBSeHsrDFIao+oV
	HcFncQ4sZxM0lg0f+5j+e9azDf4ODSIQscK6Azbum/drFUT1Jcc04gUTZvH4MXOObhkeXVaAk6h
	ph/6xYy14dmJFaNirbT88fCRwgkidFYDZMph68+8ZZ8WF2B7M0+LS2wh/unTDrMJYzdOQn01YEz
	2EzwcbXFlNQlZC650ga3HwFOi7d0vHhuU=
X-Gm-Gg: AYBFou1aDGcfzSSv/wlKDQ8peZuHfzYeqKR/tolpaZh70diW39a4YXSjQFuF/4003X5
	cYvzrX6bX++4B+bQemroNeHbYwXgRkXOhx57O3S+yIfGB2YsiecSyZ+DKWfg0RAQxb9TQukLAWS
	wk4OmZ+VTHa4tuwBdwUgRFMz3MNVaWSRxNfE07TeGK3yCYnhpqHxeaoVe8V8DQlWpMhhq5f78J0
	rz//KlplE6hd4KOjSzQKW+N0fRZi6c40pRHOEEqVbYqY3oBcOU=
X-Received: by 2002:a05:6a00:a211:b0:887:3fca:835d with SMTP id d2e1a72fcca58-8a36772cabemr7073922b3a.29.1793052622061;
        Mon, 26 Oct 2026 15:10:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:a211:b0:887:3fca:835d with SMTP id
 d2e1a72fcca58-8a36772cabemr7073902b3a.29.1793052621627; Mon, 26 Oct 2026
 15:10:21 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023234640.1459291-5-toddfreed@meta.com> <179288570316.3134.17338958323067090592@kernel.org>
In-Reply-To: <179288570316.3134.17338958323067090592@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Mon, 26 Oct 2026 15:10:10 -0700
X-Gm-Features: AclHuK_YNIc8WR5zn4HQHJZd6E-TfuSZHowIMObN80et51S8RIsFb5U_2Jx7cYA
Message-ID: <CADh2yMxPi+eNkQSVo5hUr=pNsnG21ZLjYf=GMFPS5eOtyedrAg@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] selftests: drv-net: psp: test ipv6 tcp socket
 with extension headers
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, borisp@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, daniel.zahka@gmail.com,
        willemdebruijn.kernel@gmail.com, horms@kernel.org, shuah@kernel.org,
        cratiu@nvidia.com, raeds@nvidia.com, rrameshbabu@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bjorn@kernel.org, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=LMrz05W9 c=1 sm=1 tr=0 ts=6adfcfce cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=wrF_2KVHrNPQTX-trsUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4OCBTYWx0ZWRfX8XnBtuskRu3U
 lNHYxJ0OEbsnU4lfsskSCT4Sgsl9oj6jXbTUwTnGUwJgHpAF0YTlTTzmcVdNag43aP9vJWoDjrv
 Xe0utMUes4VrkuSpLE4QQx7ossbz9+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4OCBTYWx0ZWRfXz/5tM5M4rN6y
 Nf9F7fHJmlK9fxZCcBLdK7WMx/387N6leH1XiQL8Wv2WQWtmAFF7AGtz+QJMRYhFW2iYS8llC7U
 3UIwf8n0ZUa4hwwZWxIt50ddqEEwbydOsROXF6JbtK4GRNklXmDlK61XodCU/7E4NE8k26tXx7f
 w9ovOC91Hx/4KKekouxDH3foc6DWP4YYdSKvxkmKtCtQyDfX9NYe3zLYWf7X/oFS6YYdj8Au0SL
 Vj1NxbNTr/YXoPP/Z2GQ6qQW1M8ZBZQbFMY+Sdl4++rWkMWp7xCGxHcoyzkuxjYwgPBfuyCh57W
 IL7wM4vJZTQUWn/LlF/m/b6lUrcNXj+3RV8I4H/dvUT3nltCaOH24lw1CD4LKWtf8fTR48unuvv
 j8wb4p/uvakiV0b3IAt59khJKvC/Xe0jRE+PXL7T+y4sDtfWcib3rSd4ErfsYgO+YgJL3OKrKHF
 DjVTvYEzC22N5yBu4wQ==
X-Proofpoint-ORIG-GUID: Kcm8oqaGvgLykTOBFnII_wZwMhYMeI1z
X-Proofpoint-GUID: Kcm8oqaGvgLykTOBFnII_wZwMhYMeI1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01

> [Severity: Medium]
> Can this skip path end up reported as a failure?
>
> Could the remote filter be installed before _make_psp_conn() is called?
> Another option would be to finish the key exchange before any early exit.

This is a good suggestion. I'll apply it to v4 if it makes sense (though it may
no longer be relevant based on the other changes I'll be making in v4 due
to the other finding.

-Todd
