Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793052356;
	b=XOP0YJi+Vh5L+LDAJB3FGCswNwJ3TjZUQT8O2Tid224YOQ3Sa1liVf7kcofYMAqMEayl
	 FAkeqCNY7IMcUnBlsc2KrDM6pv3FJXSNaCWFpDVFp5q6coAWnADDXJIcxovF71xtak5uI
	 //zmsOgutGrDGeCAGAaO1z77av+53/0ZgX+FpMVpZcx7sMTjaLoW21l9xzkn5R/uR+rtv
	 L/9p3jetLfxu0BarBfN0y/HyUliFVSdxHX0/c8iqMU5+kcC5Afyzwrm4V8Q6OLihB6u9g
	 BPJNWmQZmO6ASgINk2L1z8jRRZD/5gAZy+raj/xYtBRcvQzDCN9uvLiQsrjwy9WmdLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052356;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=z4nQTtfOhd8q9VhT0x4dUvhNJ9D8OtV16AyYym6/9DQ=;
	b=C6tbZBjA3p8D5d17tjL2RDj64feCx/pdPVR45r16sVNb1P0IFl8MMUa+NNVEfold1WiU
	 2Zw+sLZMxcHxP8phyjEsAxvi5zti99Y7j+zBNzdaqwGTGttrrRqAxXO9NuBtZS7fhVKxZ
	 q2MKQqSQsSN+4FPOequGLTdXAjDn9sw/NbaoPpL5sinEQBuYVn+4/FmqczWc3LW6B4Iwi
	 Y8ucoc3uhdwfkdlimEzraJMFc2HFcGDuAVz3zrED8N3G2T0NtipMwWOyC6mPcd6BlyUSV
	 c7bIOqfMjJl8xD7hFEUqbBSCuRnQ1io9yYYB+Plmc5PN5d0TDLnnsyjjprf8SJaFoYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hlKqV8Du;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49344606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49344606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hlKqV8Du
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QImlFK835457
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:05:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=z4nQTtfOhd8
	q9VhT0x4dUvhNJ9D8OtV16AyYym6/9DQ=; b=hlKqV8Dur4ZzUuKxTjP7YrMiIjt
	3ZsOzN/DdqCpY/o56SvMkVq3ZXuz+GA7bcM+/aPPz6SpoviGFTl/4hrkVTfjX05H
	0GT7EGWQj2EE0PEccBWYxiw+GhKrlLLc7J9afMut2vpHBX+bQM6qRxkTR5zRkbmX
	oSa5qK3hwZ9vkghNACrjtWY57rxM2wrBkf1P9KEau/9GkUYQ3XheuKXBd0gfttSu
	UqqqEN99t56wc+KwSZdPn/fNIq003oaGTjLV+M2+SjYPlgkNzqrgh9aTe+EnkyOZ
	1DqwCxNs9C1AFXQUxT8UomRIhtnGM9OfFoCNlDgfBKJ//xeeR05pvvDZU2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hguyhdn4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:05:54 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e80f7acc67so38671135ad.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793052354; cv=none;
        d=google.com; s=arc-20260327;
        b=ENnffRXDwHUuOgMB3VLrMjRe+eIMORP+NZAifExI9kMBRk3qUPEYF/+MzxJALPGN0V
         dRbNH2ca/GeClUoQshRIatHLANJ2WRX27SJDCp+dLqQHHog3vlxmVTiLEfVN3v9T37Tq
         4Okuiige7ILM+u88SaMV/+9JvnJf+ZdrBddqxTnKfLM3oiH4FpobxemUTgkepM84h1Eq
         2k7ZjwLSIvQ6BDjYiFueWwySil7MepS+Z0nTvf2/uB+mZkhVkbSwr24hur4VY3pyv2Mr
         4H1Vvv8JhAcFbni6JuQixzqYWwvZxxBQ36gcFkHlK42XdbgUrUP3TvRFRL6hCjWhFvM3
         l8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=z4nQTtfOhd8q9VhT0x4dUvhNJ9D8OtV16AyYym6/9DQ=;
        fh=8/RiRcyUYH4i3uQ5xdJ/upUXGxUN7xAEVO0fdXdN8lQ=;
        b=e3c2GSQqP93td3h3paYPBhFXoCeChE4a/0ryzXjIoFu2l+hiH6IpeH0hX/1/Qj5gi1
         gPHyJpakZXGsS+ILu3n9pOAY9uss3KuN9nb/zrequ4C8/mO6aQJpwCmejA6hFPtIkQkH
         Doqld2Etmllpamb1MuWpD3sH+7JCsSGhuyqUxaIDZ/cA1V5NF/3LuhLqco/SBefPcwra
         fsI2jf5KI/VW86CSKmHMj0pMXqDXMMTG+urlG1UP6Soid/+PWLbTaWNL85hVl7h25A4U
         ZRfdaGoSfETkZk0QAvbhI4+FOMCbMj4PUeUJmWhtr1X+iiYW3wmDk/bSDH98yHKXCCpj
         hJSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793052354; x=1793657154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z4nQTtfOhd8q9VhT0x4dUvhNJ9D8OtV16AyYym6/9DQ=;
        b=Sqq4o4hrsllCHWpKngJjsTtAZntjvWQo0Bby3GHWDYe1eRGlY8fs0sSpQ5AtOYBqxO
         a0E+7X70nWwe6ErZ0668WBrVgLekD7h0wFpTtTjPn2RERGaPnomUy4hfACczcPE9cvmp
         k1lz+Sf/goC7Rl3JkuYf4vIfmN/d4XhZ0V1akV3supYAIA1/2Dl0OlEWrlglmEXAyIZN
         sFAY+Ar8987wiMEIW8nZh7x6IOlHJ6wv5KoXwxlFuOlmk6qzJZJy9zDXyxVa3Fl1gDvU
         /qC7429+MQ9O6St03VXxQeL79mz0mH4vBST9HiCA5w/2VekEYC5qcG0q33R7FTNnu6Jn
         hvhw==
X-Gm-Message-State: AFq9FYJJD1zNXfQR+VA//+VflTJBZnjDKbaNP5UC4jJcBr3p94s83QKk
	zvk/YZD8pDbzmIkZCekJr+CMHIAevt4ahICoyChrkt+kshpv+rMwazkfBhY2YJY7xObprkStax1
	aZXL+JcycDntO3n1fRfu8L+AdWgvBSULwrPFkIsKW5DECFcrf+jd78GlxhbaM4ibvWQNBhOP15C
	Vyg9nxwgggtfFzSrTh8kQK0mXiYYLOwh4=
X-Gm-Gg: AYBFou36pOJxcaahLpz8ocwSF7ullxUl9in7jyaVekvqXmI3/DQdTsbyyJS4s52cVYF
	vkyth28gXurJnuxk4NCR7ynFDIvdTPB845rSMa5TZrql9S2w9uUMIgPreIrwHUV4ZqSugyJptnR
	FDHNs3U0t+ppW7pEBb11cFzHk3nHCSFudqbRCJGmvpa5USwS9XtpsH3aEkT+q2622cei5ORZTt5
	jnq2PcmMsVQiAgPJ/KblRZuikT+zf1alOWe7qnSiQfPNDpS6Oc=
X-Received: by 2002:a17:903:fa8:b0:2e8:3d48:4d80 with SMTP id d9443c01a7336-2ea9c695516mr62602085ad.45.1793052353835;
        Mon, 26 Oct 2026 15:05:53 -0700 (PDT)
X-Received: by 2002:a17:903:fa8:b0:2e8:3d48:4d80 with SMTP id
 d9443c01a7336-2ea9c695516mr62601855ad.45.1793052353322; Mon, 26 Oct 2026
 15:05:53 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023234640.1459291-3-toddfreed@meta.com> <179288570143.3134.8925369868949382653@kernel.org>
In-Reply-To: <179288570143.3134.8925369868949382653@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Mon, 26 Oct 2026 15:05:42 -0700
X-Gm-Features: AclHuK8vmHsUIvz0IY0SMdSvsvG63AqCObkQ1uaVFzRtYuR6y8WvmQn7TcpGKDc
Message-ID: <CADh2yMyYS-PWP4912En9D6B9up6Kz-hnCthNkWot+e7N8-q7ZA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] psp: support ipv6 extension headers in
 psp_dev_rcv() decap
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NyBTYWx0ZWRfX5ciFdbw9qLSx
 AG7K5/cc8BuGhPryocA/rf91CT5TXaPPGiV2ngzvULsHtdbsFk5nH8k/vrZjIIW8CCUNjkxHBjj
 gMEBvheHyQ8qDMN7mA0NRXA74Yr3ur+sTemPptTT3riH8XS1TBQhVgPLCvHrTq7xB34qj6+WVGX
 TCpgykPZazyGxHzhYBXQpYrVtQmNkzkT1axVqHnmbjyjAzQp2nT8ZEi2EOhfYr5cHXBxnCUnqgp
 a1/OMgMV4BlGRLl0UqN7u2xSm/cfal46dcFTj775cKnHA4AfhvD2b64SOUe2Nvhj60Wx2pNBfW2
 i6ZuGJp7lmkNoqDCr3T4kRAKyyarkb5cbg00opSbdQfISyGfKpqCSLfj7VBIr72wK8uWsy71EbY
 jSik1+98JBzf3FWT8WyrUYHx1rkV+7XJP31KalhJDlyPvAiHbzPVoQkocU2Y7rDtUMTX4bDadKo
 oc8RBrXue20cwgatxTA==
X-Proofpoint-GUID: 7enjU14jBx3yYoZO_5Cspuxu0i8hUsaA
X-Proofpoint-ORIG-GUID: 7enjU14jBx3yYoZO_5Cspuxu0i8hUsaA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NyBTYWx0ZWRfX2xBW4TwKXMOz
 wVQuGMYjYmXz8uHO4V/1kR5Cp0O9Bq7XR4OI/lriTYSFS8KJ3VpyYlRaoiWI63yrczKdeiyoMYx
 IxgmSHIGaT7ahtk0Ycxh8OZU0NhdV6M=
X-Authority-Analysis: v=2.4 cv=FY+iV5+6 c=1 sm=1 tr=0 ts=6adfcec2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=Pwd9bqppP3xQxChDgmkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01

> [Severity: High]
>
> The PSP ICV doesn't cover the outer IPv6 header or its extension headers.
> An on-path attacker could take a captured PSP packet, insert one of these
> headers, and set saddr to an address they control. This assumes the
> device authenticates such packets, which this patch's premise implies.
>
> Several of those handlers reply with an ICMPv6 error that quotes the
> packet. With default sysctls, this happens for an unrecognized routing
> header type (type 0, for example) with segments_left != 0:
>
> Before this patch, all of these packets were dropped at the is_udp check.
> Forwarding the decrypted skb itself looks blocked by
> sk_validate_xmit_skb() ("unencrypted skb with no associated socket -
> dropping"). That leaves the ICMP error path as the open channel.

Agree with this finding.

Ok, this puts me back in mind of the approach in v0 of this series ; just drop
packets with extension headers. Actual support for extension headers can be
done separately from this fix.

pw-bot: cr

-Todd
