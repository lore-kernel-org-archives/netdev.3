Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511390;
	b=DVju5xSZ8Y8iEHyHaiKMGR4mrf4Yw3MY1QerPOkkbDB/p5mkrhK2SKnaxzc12B8MwSt/
	 y7G/K82Hp0aCd7pUp72V1nyEu5OfgShEqIw6DCt7nWnKtykqFCtsdju5a1S0DC3vPsQDQ
	 k6QJ5Qn7wXiMvLyiz6+bIMJtU3f4Iof2Uj9D5MVZqEYuVXi6dKJa6CxdHWU0OoJeXWaxh
	 xL4tjt/b607RTxlXldSNgfqv1qoTwqankJ/S5RKLq6M34knSk0LCmH5jl3oJpXGtMgnvq
	 ZwWs+O1VUQ1Oy42S4jaoYqM1vH23MF8hkhi6IYTGZ81v8ioj7QuGCcr0aGZkMTOM68A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511390;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=VdEkgtuXYtt/7b+6W/wSEG+UqYWU+snYAFASoVUZvUY=;
	b=waU+DGPMruuwybiLZ22Dg0jtLPYDDjWK5D+6MrOEkML7dswT6y9UibngODA78tbERr/o
	 vDwRdHm8qAqOq18Z04qvYW8sU034Vnif4PBPeZGmOqq4SSCwQ9+LQMwrXISq5QENgkyRB
	 tguRuny+Pyga5cwk0XACKR22Zz7jUO1uQyfEl23LApjAWiFm19iVUiVFLtZkJH+4RiZfm
	 JJ9XjV5pAH91b/DVuzitp4q5K41kyt+WsHrVLTyLSCwx2fQUhJQWZETBQ9/bUNB1tK2nB
	 2HCHxXRWV90zW2bY7RJPUaCI3YKoFrnUkgx0vfv+7pYFwtV0z/iy9LeIULq++O7iEsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YaObJsQ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE4606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18DE4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=YaObJsQ4
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFachp3760929
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:23:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=VdEkgtuXYtt
	/7b+6W/wSEG+UqYWU+snYAFASoVUZvUY=; b=YaObJsQ4RX93ahosRZQ1mINC4Ug
	Ggm2qbab0+LUyE4rpKMXUnzg8PF1HyVX6t1lmTNkqRosQ76FwtlnkCk7GQQdtTQD
	OpBRFGhkQEPgw3w1+HwKWy6l30sHT23BrQAx+mq3OMBIjZlxaoAjoaAlERC7l/VB
	jZ/8YzCIFOuC3vP7c8OSAVSKoqqcbc+85r/gx2K7KJ2g6faLq9K8PgXSi89Envvt
	7amRduCPGnbwryk5VMKkLiUWSPMrbMrW02iG3nlTNAbIGJaQHi9OH5E55VO1eVZ1
	I09KzarxNzpv/nnSouiIbTY2Dncr0K7QAoaKFKujWXrOOiahKo/WVscXtag==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hw87e4j8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:23:09 -0800 (PST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea446ea8c9so9697765ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:23:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511389; cv=none;
        d=google.com; s=arc-20260327;
        b=bZ6pgNUxHCG1jkzcqIfSC7fjP1pIjKFZ7kHmXHOsNGsBcu08C24Q0K5L0A5yPhBrPw
         h9qL1+3lyWf9iOQcq39Wc81bmInvPKZ7zFU1mzHytfZcHqTKCI5sv83vpFuHOSsCYQCD
         yIu8L+c+UAcB3jKotT5S/ObZ1VOeMcr6tJilxpbAVGHD1xdaxdKST99Y3aY8fLPqBgZU
         gG/PYUVOKUpa1dmHilb5op6qOTuNHWGpks0G1tiBMamAAiCp1ceh5oeeDp2nfLRWAXI5
         G4iSKtZUbFsQkA1glAYdvbriM1ArGlrHAYgyp5OZYWaA1yKZ7Rz0s6EGajlFULEmZ4M8
         04Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=VdEkgtuXYtt/7b+6W/wSEG+UqYWU+snYAFASoVUZvUY=;
        fh=uFj2i42xO+pFeCfE/HT4XKdqIlB5RmoqyGsJwumKNUA=;
        b=ir//O8DSCvzgk5Sg8vdu3Yb74y828b17jdv/fR9/gMzoR9YtGwsv6kwnAMYtRObCnN
         mlNLj76gBQzvG2dbXFgq8Ty6gmRjMpO8A5Z8WB5vDRVhr09as/XJolnqOGItwp1DKlb6
         UJhgvbS5t/N+AQz2ajt+NyKDETen7XJyubi5A3PqYtLVyFnZFM2oAI2w1sXnZ53Ip+zG
         W7rj27G92X9g2hrRLIeuB+16rLHca/YNtCQWri9Bu5ds1RCUND8NWU/NSojFUKR6V4pr
         uVmoF4KQBrkMyGLIeSFCvzE5o4IWjnZWNuBPbaGjZdsPRySTs7WZClasm1zyjOMo6laN
         RyyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511389; x=1795116189;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VdEkgtuXYtt/7b+6W/wSEG+UqYWU+snYAFASoVUZvUY=;
        b=ONywuP6c+olvN5LLNbch9g5deUKbDw0fnBY/R85QkUZUKtYieByZ5WDiZEI65JvC1O
         Av37N5/PBVqVL0ffDJ3bSPeTJsyjhnFrmDCYlmPF4/Eksz6yopE/TZ9z0Ig17TVpgReH
         WFPf020BjA0EvKxM6a9obZxnJ1GJ60Nc1D9f5jAat/Q2XzoL+JA/LBB9oY25gzT5MgFO
         G0xPGv9oBzfkORjSxJz7d0zyWFZ4SL/wTP3Ju4sxJUsvRRvJEUZrA0mns79ZzodxdCgK
         ZJNLaTQ8nScKxcY04GQCG8ntyUfgldKMtC+5UJqOhyCdxOYAyKryr/WHYU1dC8uUFWlU
         IG9Q==
X-Gm-Message-State: APuU4Z+uzpNnuBXPvZ0YE8tvQepo42ivR8gORLx5EBLS3eubNG67+tVl
	NyNqjDtgHMH96w5sGTj8uQaAkDBmbb2TX/EbonDRblWB3yHep0gqzD5lgpuuTPCwUbPL3TUdzmI
	gnFKf4CIqOwsGHKPIhFuov4AyeFFFsqLChxPEPNRnKY8hDxWrUMihnrA3Y417TTx78FBr6KVZ26
	TBmGJoSKvyTbhe5j4xbJXxcL4TK3v3AVc=
X-Gm-Gg: AYBFou3n/boxaZVSqnaJ8jjekHgsC7rr7DVjuINPRGj9JYYD7hBiQSwxAZ7f3AphE/K
	2cm50O+XbVeUNYQtRMzqduGzC28rNCkWTJ+QkojsFRK2nKjybPqH9hpVv+Vnzn6db0VrObEHCjF
	hUdKDdHmXe3RsQ0vWemn5iuEX9UeXIJwLcMi3ncHnVu6UFuKxx5juygw1yogmHx5gmBmiYsV3n8
	g13dD4HPzhPrAMWWa9NcnKlt3BPwODt
X-Received: by 2002:a17:902:e542:b0:2e8:5431:d18c with SMTP id d9443c01a7336-2ee0decb2c9mr2380655ad.40.1794511388649;
        Thu, 12 Nov 2026 11:23:08 -0800 (PST)
X-Received: by 2002:a17:902:e542:b0:2e8:5431:d18c with SMTP id
 d9443c01a7336-2ee0decb2c9mr2380445ad.40.1794511388056; Thu, 12 Nov 2026
 11:23:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112001512.3598626-1-toddfreed@meta.com> <20261112001512.3598626-3-toddfreed@meta.com>
 <20261111170524.2b0a6af9@phoenix.local>
In-Reply-To: <20261111170524.2b0a6af9@phoenix.local>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 12 Nov 2026 11:22:56 -0800
X-Gm-Features: AclHuK8kwuouvHwn_2Xi1VH2XJR9zz0E9BHRhMsxqfihG5H7jLll7Uir2TMxEqA
Message-ID: <CADh2yMwfRPEEN2JAa-xypaGO8OXe2iFfBqfdvgjXEW+o+gzujQ@mail.gmail.com>
Subject: Re: [PATCH iproute2-next 2/3] tc: add the psp action
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX+h7FayWY9pho
 GgzX54/qlvjIKnAIqN2s+mbAeS981dxX5dbw/d4HeQjjsWaDemwWZatYxGf7JSc1aINVD2iNdNZ
 xVLJKPrDvdJ/8A57kG3xCPLi3x8rcI53ycreMHiVz30RIMCsLONn6rHLpR7o3fuhX2rDjmcCha2
 Ti5juJwmLvktbLA7kUW5rjWwHIG6zqVdCtbNZOcum0GDilRtJC/nX7Qm+VdEtV7n5BGM60Vhfyj
 uQeKD+Mn0uS/nyHVU0fP4OM5s0gbArXnYrKdDtH+FRnJFI7O4w9x0XYhSmXFKKnCRKfwMogzQeI
 wDs1oWylK75vQoryn70+FaTfmcxKIAMB+WYEpGT3ZsNpbE45Qiud85NVvdkZMxSRY7EiKYp4Xsv
 27ZayzUe2ecggLcLSH3x8XV/7bNas/l8/xQAnhn/QANuzUaIc499kSCAREgp7P/PveISWQKylQn
 7HWMvVyP3avdva9ra2A==
X-Proofpoint-ORIG-GUID: AzKiOHewXU9W8MZ1Ki-Mkg9eyqkm1doy
X-Proofpoint-GUID: AzKiOHewXU9W8MZ1Ki-Mkg9eyqkm1doy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3NyBTYWx0ZWRfX9B6eWUB6DHud
 zdKctZENVkN5cPGI70dt5acCeE9wjs/xeJwWuYafpS1FpxitAMGF5PDfL2IIik/daIqNxx5pwch
 qfNYKY3L5NX+TlDgjApV5FVK2lPv8yk=
X-Authority-Analysis: v=2.4 cv=Uur2pOwB c=1 sm=1 tr=0 ts=6af6121d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=rHa_5kz9ieswdsXSo0wA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01

> I saw several things that need fixing here, but AI review saw more:

Fixed all of these. (I also re-ran Sashiko myself).

-Todd
