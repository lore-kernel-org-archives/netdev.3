Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A947541E6DA
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648464; cv=pass; b=bDxEXBYV3IT3WLkp8QFDTdQodFYDPEakPYtYMdopoS+XS2L2r0ySgLE1QwLQWE2gdHz9/rIdqDMXva7IpuM0wmbHob/kS0J/rJkVxpsexFG+4vuwabDxEDeJ0mV4rMc4rVtZwDP/vNvvygYMSpbHSEV4AqfQnFIVhyBkvpcVN7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648464; c=relaxed/simple;
	bh=4qRIJ9bpinyu0DwZHr0aKQZUHjvNHbNe7UYL+kxds2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zeuk+N3m9YFGMZjM5mkoCO8fStCbRZoP1Ns1mF6YglgV16pixyo8fAdN21Mwq2wd5NEiIwAShXiKdM0AWojD4WOcW+m3k8q+nkm9zm3+Y1CdLLF05dBACsGQpWmrZ1uvGWKvP2zHwAs2DYNkGZZTC7Mk+rthWTOTWSs615kVTmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eR8ny32x; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eR8ny32x"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DIg8VV1818401
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:14:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=aFRNQgb0jvgeXUeAY2YfTzMp8MmWSXmQ2d5I+
	/uZ3LM=; b=eR8ny32xnvDwAoXod/G3V3tHF5Q8fON7TL8MSf37DfSW0wMMCVnN6
	yFXzpsMvmkGVbUZCVJw1kGX+YJ355bKJ8pcZAxkivt3fi3sw32IcxyIg0sh6cHp6
	sp0UO8E8/0Ya4qxF65cgTaDFgIbfMT3rdXoVwiQ82hfNNtY/cgpPhKPdB8YsXV8w
	XXF+RhDJ1EH3jtJlTdgBeQWrZnyNms4elByzkb0z5B/rZ+G8mCOOLUe5CUsx80HA
	AEMTEcXIzQJp+KviDn0ON0/aDrKlUQnunOqQcH3BRp9RGIGv32pvOxOH7LdzCQIq
	T1AvcM/4LodqbxaL7P++a0zRp/Rk8DYAg==
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g07xd8m4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:14:21 -0700 (PDT)
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-39f60b70366so629361fa.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786648460; cv=none;
        d=google.com; s=arc-20260327;
        b=s2kgdvmVCmOGavyC4jwx//E4rKmc7jYeWwcQmei9X2anNxohoSE7pa47ZBgaPWnKdZ
         QtXexEZcFE5yUlVSGLk7SdhWODUHW1gzwvT4IHdDqsFORaj7Ojj4P7S0Usqm+V+OE71z
         4GWvsYKBOPhiGFiKGAlaTEyAefSlhhZA72Tv3nX+6UzF1+WY1EsewEc0GcEuTNHL0x3B
         rJvMQSNWHd7bhBtUqV3lPvl27KpI6zv3VPJ3yT8K/8phgAxwwv5CAG5Xy5uMtn4owHH4
         PQ8Ls3uDLApMdth9x44d7pzXS1C3/6vV4j27lV+eW1DSrQozzqKbO5CZmcbN/T/2uUBQ
         LuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=aFRNQgb0jvgeXUeAY2YfTzMp8MmWSXmQ2d5I+/uZ3LM=;
        fh=BuQ28IRtSljusvh1N0A3oQ48Y+e6r31pPIJX2kzLw+s=;
        b=rCo2TJ7mUDFHNj2qOU+4NhW15yNHDvL58lL83M9iT9cirtutneR5WGmPvreKU90NOm
         WBNJA7CAWBtorCgMNFJwmeMXjTblQQz5q5RriOY9MCzhT591Ndp861mgL6h9vVs8NtvV
         GOxWh/P67OMmOss0jMDMUbkFPM2/kSMyheiLX2+DW3pMhy2uX/Jq5sniIoVA77b4TiYI
         f52g27FFlvSI+kKGo3ZIqIRMDNDcU4+nZ6g2ee9thVaD7oWvZjw4UaioMj1nrd0M/5ka
         QYm4PEhbGXd5SssaG9BseFNmuZx5TP78lt9Xb2e1Cek6Ch7wTK9BafoiLep14B2qkBQX
         LeAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648460; x=1787253260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFRNQgb0jvgeXUeAY2YfTzMp8MmWSXmQ2d5I+/uZ3LM=;
        b=Q+4NbVRoUxZfvVtmpfj61F1NbRN9M6JscdE14UoJ5Tndy0u5cXWq/I/nfxzJn6Aktm
         KZQK4ZzRIWZuSDfChT7jMj8eNYIe/2oNhmaMS2tZVc66kpSLsKzTnEJ+lKzsv1vKvAnd
         4p9PyOwT1xFOFDYtIXevKlF96TptL5fWgMSFk1uAahqIdQq4Ya3NCZmiqPKkhUxwsTMX
         vZoAFIKZkA4aW0rb+acuXcUU8AfQsMpSBFwwYTl/SOyCyru36CYSmQAUGtXE3VvUYIW+
         UYauWGRC6WLOqXN9r/xj7WRLiCD54iklpJn6oWDbt0HAXVNKaAlsyZKSMDg8Jcyes2+M
         jhXg==
X-Forwarded-Encrypted: i=1; AHgh+RoWtgN49E1Prf80S+x4hYtrouJJUdJ1PSC2oQsyEa66FO9/MQROprb/JvvTA1I7JJuEqh5u008=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKZUZM47XkcGk3pOuMRHU1qEKSkbdTqRqhxPWz+8r9frmOzi7
	rWA/oY8xm+jMAk3Pmosd3mAhMbgbJ6fhiZebOl3vM+82aaY8MKVpx2jsZbHAxNK3kBmW4ZNcscY
	xjQQTGgtQJLqyXykvRFLJA/Sc5l4os/LwspwGvN5iC6ZSwRLRF9CZmL0/uCSVDdMHHzZfh0lAsS
	+GZnKxwpiloGuG0Ze+fRt/hbVbWprhCdy0FJPxx1UsQsEo
X-Gm-Gg: AR+sD11q3/ctviOn4gv3ceXfaWNA6o0AxbMRvDmY9BXyVAp1lIC6FFul92u3H8BWdXY
	WN98XeAvdZzt7OfMR+gTcWpb62u0JF5jHqsR1nN4FSApzuGUTa6RgannR7ZRXvXOWFlEfB4ewNo
	ELShY6QtDZqppEjcchKnijSfdV3UpFwkEcdAYEmqkbakhcmW5WZ0KTEzuYKA==
X-Received: by 2002:a05:651c:1504:b0:3a1:11d3:16f9 with SMTP id 38308e7fff4ca-3a1324cb6acmr650141fa.23.1786648459998;
        Thu, 13 Aug 2026 12:14:19 -0700 (PDT)
X-Received: by 2002:a05:651c:1504:b0:3a1:11d3:16f9 with SMTP id
 38308e7fff4ca-3a1324cb6acmr650031fa.23.1786648459610; Thu, 13 Aug 2026
 12:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731185431.2777685-1-gmj@meta.com> <9e741e85-76ff-4625-85b0-62ee679aa2b0@gmail.com>
In-Reply-To: <9e741e85-76ff-4625-85b0-62ee679aa2b0@gmail.com>
From: Glenn Judd <gmj@meta.com>
Date: Thu, 13 Aug 2026 13:14:07 -0600
X-Gm-Features: AUfX_mzRStG8snbSZp9jy6R-MpmdyO8IqF5t2aItUDB0o5wfGhyd83XYPmU3rlM
Message-ID: <CAD7-H+=o6afiydHrgdWpKRsy02fAwz-StUadCwWb3TprmMTukw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net: gro: coalesce padded small IPv4 TCP segments
To: Richard Gobert <richardbgobert@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
        Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzOSBTYWx0ZWRfX3EGHgM6uCoP4
 BAY5UJAAOPmrjNh1TFa3kzQjpJPblA7GTfVZuVUcdzIuzY8BvfWuTkTrDFvPSutG9wUv8RamXI8
 JFbv2MpTrhKMv7gUNpnR7Iuj/UrX1s1+DY/44iHruuxqEeHHgjABt+E5kWc78/SsdXWKWdY3AbJ
 X/5mSu7mW1ZU/tFRi7of6X7wM7Y8dEQSvJNkgpY0NmSkJKuya+Wepjm/0Y5b1KcdZlP9ud7y3yA
 iddARCEdXrll4wOaFIZ4Ws1iMn14GVS+hmtXklomild8wzS4Z1JR62t+QjglawRevHzmnOHKAX0
 WkV5D+xcvhr+jrqV5gu2CySEAykIRIAjcboSKjHftcc8mMzHTy0uxaGpK29V2ln07EHUUCtfHbZ
 NIIS8VakGeMfH+EAPge/FBniWUhlG6Y3WUM3V3r2JM/AKIFB0jTHWDlR6Veuxyw+/s+xsUcg+eU
 D4gs3/XqGu1fhQm0oXw==
X-Authority-Analysis: v=2.4 cv=Kvx9H2WN c=1 sm=1 tr=0 ts=6a7e178d cx=c_pps
 a=jH9SAkXWrj5X7T5/VHKg1Q==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=pGLkceISAAAA:8 a=97N36fql_02kr_JmGwcA:9 a=QEXdDO2ut3YA:10
 a=uSDOZ7Pa92Zmn_oY2RqJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzOSBTYWx0ZWRfX5NcGY+V5dSl/
 ZHZvuxzTSXhufQVrCDs91IMHLyWi0eH430hgaWiAvnh4GD+BAhWtTcsjzEaF1dsDO3BhF/7B+px
 wuthKv5zIS2PHs6C8YmHQbd936g+lcM=
X-Proofpoint-GUID: 0VQ-az08U3wjKwMIGF-wlLE66UsllJ32
X-Proofpoint-ORIG-GUID: 0VQ-az08U3wjKwMIGF-wlLE66UsllJ32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01

On Mon, Aug 10, 2026 at 6:11=E2=80=AFAM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> To address Jakub's question on the fast-path cost: I benchmarked GRO
> forwarding with two-minute long iperf sessions using 1, 2 and 4 TCP strea=
ms
> (17 runs per configuration) and CPU frequency scaling disabled. I also
> disabled RSS during the benchmarks because it caused a lot of noise - up =
to
> 20% variance in the deltas.
>
> | streams | baseline (Gbit/s)  | patched (Gbit/s)  | delta  |
> |---------|--------------------|-------------------|--------|
> |    1    | 14.083 =C2=B1 1.01      | 14.065 =C2=B1 0.67     | =E2=88=920=
.13% |
> |    2    | 13.891 =C2=B1 0.75      | 13.926 =C2=B1 0.78     | +0.25% |
> |    4    | 13.008 =C2=B1 1.26      | 13.029 =C2=B1 0.97     | +0.16% |
>
> The two added fast-path operations (iph->tot_len read + the skb_gro_len()
> comparison on every IPv4 GRO packet) produce no measurable throughput
> change. The deltas are all well under the 95% confidence interval and
> indistinguishable from noise.

Thanks for that analysis. It's in the ballpark of what I see on my
side, though I do see a small cost in my setup. I'll follow up with a
revised approach in v2.
