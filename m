Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123889;
	b=d6Z7j9UvrFsry7x5AwAgGlV6nxXGY19TGDeER4n84NqrasTkfgIO9Su266mjyFsoGbrp
	 0yiiJ2BV9/tJEqYXnB/3dQBBzcondAJSNWPCuVOReOG6DSdVrmCAZX5UTrolvvc3XjBqr
	 sywNb8Zhhr1LBNqabSI51UJB8GPLoQktXV+g8x30qIaqZSimg97wNPnylfXlbQ8yrRh/7
	 PEL2gJKLr/u9Fh+GWTyztZFuyvlfAy6sOzp43Cb7UqsX4TpKpHWOAW50FEf4h1GfXuFgI
	 9n5J+xJG/FbgkVWpqe3bvjCu4GDTDcuU3hqCDope+dWj08oUqTt6sXQq0ZZB0rglElA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123889;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=1SLwWY5nhyzce/BMXQZLOCKP7mE4tnUfLqJlnWOr9C4=;
	b=P1RZ8ELLlJXtHT221jVCz7LRgoLcBvO8dbxzWZtEkw0wAUCkoUI+kDPCcoSa58H2NcdM
	 rfUgt99gEgQ5rVq09ClmultpND1QWwkki25dKdquNzhV4IvnwRcx8ZP3nvhhQ+ZBCHeXL
	 1pzFxS2/974z11nY625JrkUeE2TUZ3dz+IQyXWMR75TCZQARNEiGbmvbexuuC1RBn52D7
	 RwJdSDkIyLMo9yse9OVYR8VJa+NVMEB440V/0nwAXAxvR1f7mhVUJh7iPT//unNcgedKH
	 iCZ5KjQt++7wufozWTO0dNqOIpG3UGbmXL7alfMOtJVRt2A7HCaxvRR3kc2iOCRONjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=IW8i35GR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8015606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 17:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8015606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=IW8i35GR
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RGwwMC3501668
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:58:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=1SLwWY5nhyz
	ce/BMXQZLOCKP7mE4tnUfLqJlnWOr9C4=; b=IW8i35GRgMONClqZI2OvdI+YMWt
	lbGNBCfDtJu8Dc/fyucXYPugZHQ8NiMKoVfl37wOvnt1jO8E1i0HqT5KdUOLN9KU
	xzv6eowT1GeapoSuHMktOIYQl+bD6u/tUHXJJAypgqr7uU9CvsbXzTB3tIatCvjl
	AbI2ALTb2EZOdpL+elkTE9SsnhiBeI3nFDjzW4x+47l9XFcO9EmlFHXz1rwzWuuF
	SHS2s+lWCD77gihNNzffxu693UkpGq3Dm5Dn/IoV37REIc9nDbKMbLrDuXzSllOx
	48A8MwWWKGoWl+Fv98Z5xBMaIFaxhn8IQLoo6birj4rZq7EZD9LNbaAda/g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hjvhk2v14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:58:07 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so148226a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793123887; cv=none;
        d=google.com; s=arc-20260327;
        b=JX+TJxJM6GqP1lPiQVq+Q1zCNMq1+HLyayLgQJzAt69/EFNhQoDPiCB3/wGr3lI6gF
         lxWG4TNfm+E7M8X2+lbABAx5N93i5/ES9kDeel1WABslRiY2TAulvbbXSjGRyZUBDGnI
         +QKdL45WtLOVufBFKOqXncrlI7bWc5ufmT6ipM8zLb2Tf84pchPh7t6FIvyG5woKSjL2
         6ligZ+tPh2cESSnRPlsOkpdP7Oyk40UsUBgNVDlbjL+YBbrblT3/QoKQPErSmgfcKy0x
         NhqlgR7uGvekTSesXmo8k+kL/NSCI+SULKdlWusVfm/vK6/N+/oZUEa+T/jux7UhhGsQ
         xb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=1SLwWY5nhyzce/BMXQZLOCKP7mE4tnUfLqJlnWOr9C4=;
        fh=qUDRcPnJwlKtf8mi9MS5XzebNoQHfQsU4tJNH1DO7jY=;
        b=N2i+hKr2Zy2e07r05vN/NZvh82fk0+pf9D54xwR7GNSTNGG/SBOwSKjwzUhFtr6HXm
         nWAO+mBv2yZp44s0HuyoBQp9OXNVZ6V0jKV7qGdL0F9VegYwoIqXAPuMd9q04gL16V3q
         cy+kG9GiJJkH3u1VZ2UNck3Grtjnop+JCqNE4stCNOxBYiZ/qkTjDH63zv3VI/giRNSv
         3Qt67hztitL5R+j90Xd30JvCvXirRpQnF/FKXy0x2uqw1xksggAvwlb9m8+wqIwAnYEl
         /pqo+rGHVE/R0RQ0j0vV5m+gW0ecJOB7NQV+wx4gdPY5Vt8Copt1mCdFODqddSKmM/N6
         2K3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793123887; x=1793728687;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1SLwWY5nhyzce/BMXQZLOCKP7mE4tnUfLqJlnWOr9C4=;
        b=ZVZdlXnG2dGy5DXP7VqWA2qmFvRCaV0DaPXzA5f2GzsklKiWRr/2+w20cYj4ZTrDOX
         4mwVsEMpGfzmipGX/dp5pJjbKL3hknotlhq7is2oyUkTLq0MZJSaGxKNWfLV+u4XWTPT
         qxTseWeAxkc8FG5D/JS/ypTJKRtnbGlVcR8VqO9NG/lZtlTtLz1buKI1NdkMXNF6ZSEh
         Xr0krryhCz9zUZM+IHlonMTxVlR13Re3m/+aoZ7Hm6QWN/ZeQ7TVy2hH+vrQ23RZCdaQ
         TS4PQO9IC2dVK9ZnQhEmzDUUcsPy7fzOzv7MbrhrchytoeM64p12N8gjYG/JcYQoKsGq
         WfOw==
X-Forwarded-Encrypted: i=1; AKwUvByQ2Mh4mqWKOBml7qG6W24/afC8Uq+3bWahfvsSVLPJqgDmN3/FQ0mcn8L3xC1BSqE+bc/dD0s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/ORT0w0UxcNwQ8jfqxvQZ2hH4W+7hPBjiclPKlzOiHFzPAa8c
	5r02cT2OEdOK8UKI5JXd5A6t5ufI0an394rQwOy2/lpFsNujzzhszm3rNQx4k0gYEDo9O6ei126
	tHnW5jiKExptbMNLqXhtS3FvOG0db+oaQvW8PcarYOKL5RsOuWgxnQA+2cbAVaob4FhjCnM9poa
	wKVh+rs5sftFQCGilKW5+cIwgiJ20APz0=
X-Gm-Gg: AYBFou1S/5pn+pzWex7FtZgCu/l1+3afvBC9QMObd4DqkezkxuaWisVFEUo0BpJeaQf
	YTu5/XAbK6m08vdj30RNnyIyyyq23QyiNvXBsdc2kC3Q3yFQMUUVX0U235U/ZMMWTjgDEDohKjN
	uONRiVvHWyQu9P6ISmRx4q93Xh/IHEp++YEhXN4UrOImC9iDW1xQGYNo0yfWCzlSN2IWqE+7ry0
	0JNpHaA4dcDCwGv08zaV3yZrVTRB84=
X-Received: by 2002:a05:6a20:7343:b0:3de:505d:d77d with SMTP id adf61e73a8af0-3e90232b771mr13642637.15.1793123887258;
        Tue, 27 Oct 2026 10:58:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3de:505d:d77d with SMTP id
 adf61e73a8af0-3e90232b771mr13625637.15.1793123886850; Tue, 27 Oct 2026
 10:58:06 -0700 (PDT)
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
 <CADh2yMyYS-PWP4912En9D6B9up6Kz-hnCthNkWot+e7N8-q7ZA@mail.gmail.com> <20261026175805.6d4dcae5@kernel.org>
In-Reply-To: <20261026175805.6d4dcae5@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 27 Oct 2026 10:57:55 -0700
X-Gm-Features: AclHuK9a9sPXLGBoQ5eEYEDdm6r3iIivGDQdeIyBtpGnfGV8DBsPe7nWqNJ4q-Q
Message-ID: <CADh2yMwtF3DxcD4h3zevCcmy5vn9iK8sYHoPrjoFPH5PHuNkoA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] psp: support ipv6 extension headers in
 psp_dev_rcv() decap
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
        mbloch@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, pabeni@redhat.com, daniel.zahka@gmail.com,
        willemdebruijn.kernel@gmail.com, horms@kernel.org, shuah@kernel.org,
        cratiu@nvidia.com, raeds@nvidia.com, rrameshbabu@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bjorn@kernel.org, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX2iAYB7aBtdsW
 dyYHglFCNypdvn1gMd+FH/t8M04IgXA7QyfhTim/tdSdrQ7htblafP0p/cRVolROOC4OX7aK0UI
 L5wqnUQFVCPwmzW7erP3qfM3MGmCgTFPZd5sTw8HpZ/XDHykctXZWcXE808Z2BcsiIJoM3/DnDP
 WtthIWZtPtbAYUVqf1GFPn0H/FEhZNwGy1yeihCoXin5b0h31De39heX4JSGoeIo4V9sKHtSniL
 jwcspmbJaK4hDIV22g+m3lSxqmDTX7OSfYK6VjrD7sTI+nrHx5WyfuWaDGZfdt58N07KQ0pqKzn
 gr0Q8o66lRsRdVtxJ+qrXpGI8xtXfzQzWdICYv3ZRoI2z0pyXzVaV9pwqXguvhmqgi1M1rAJewr
 Q6gxWOL9op7v/J/d/noXZH9kMlWl6sTJOxDV4lpacKxqqEQ9rNLxNUJS0F5K6LNZEd8wg61/gG2
 5PL+uDwHieqNsSjsfig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfXwDNyShNO7UYu
 hDGxLNCwcIH5grano2laEq1I7EfxkEnjR66lQB3WdOItE76zfcr7+rGqluLBAbXoy4Lbmv0e9Y9
 zZsw1UZOzYSQ6ma6MPUcy2JKxJL+CGE=
X-Proofpoint-GUID: dBi4HxlYqkvc9BjpTNTcwCzzqFT9LL4r
X-Authority-Analysis: v=2.4 cv=N6G8hG9B c=1 sm=1 tr=0 ts=6ae0e62f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=GCtVsLiEsvdnKASXBLoA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: dBi4HxlYqkvc9BjpTNTcwCzzqFT9LL4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01

> BTW I haven't looked closely but is there no existing helper that
> would give you the ability to walk the extension headers?

The closest candidate I could find is ipv6_find_hdr() in net/ipv6/exthdrs_core.c

I don't think it quite works though, because it doesn't return the
location of the
l4 proto nexthdr (only its value). Also, we would still need to traverse the
headers separately in order to implement the reject cases.

There seem to be a quite a few "walk the extension headers" implementations
which seems somewhat justified because they have different stopping
criteria.

-Todd
