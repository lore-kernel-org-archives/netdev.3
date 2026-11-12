Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794512170;
	b=vAWJS/Q3T4/F0FgkduCnLsXZeeoRSLmN0rFyrpI8jZyBtNpp4Be84LCnu05eINQs6hPX
	 kYvBrIn8M2i79it8tB95yEwfBze6QJ7+8nWWThGGDqJ/mBOWFuVfE1mT/zbKXP7ytsVrD
	 WIdip+g8Ecz1YdSIrIzL5gpufGMmN03DA5P92DgGg8WPqbD8QK541v8lOOK4BI6bea/Dz
	 H2Kb85HRU7n/xSxSnxL/XZ+K9CJxSHuIlTPi3Q4XzvkO5FPJmdFwTNJbaQ6voCsgxnzll
	 5pJEx5+IuIIQJN8ivJ3wKYZpus8yAOcfGmiTOBCRBiBrz+qidmW/EIXkMkFOFyBrkgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512170;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=Q3u7I1yY3nJmuq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=;
	b=Vxln1DKPleHCZfPEbyXvGF6MNANnYfUqBTfpKjBDbwlm/sMEAPHwFpyMdxNFY78GD6E6
	 9QKr1sBnJXMkyQ4pzqZrzO6nV4dytLkOxncHMLmrNkldKwYb2bfmeSUqZz5iRU71g8B8q
	 7BlK5gP1+n53qyvQeMiUs2ndPbXhsa7w4EXyMWlD36LVEnvex1x3co+Mst0yfHm0LAdzm
	 HX48JXivSMPB0EvdRDiffuX1iPuqm0knid97q4O9SWyk92Al/AQnB80d/GLK+I15v4ydh
	 FwDsXMTCvO1sQmeeKbE0qIR+QHmGE7XP3NoF1cQW9LF02e68pDtG297xpUh+R3lz0FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=LU8nJzdq;
	arc=fail smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEA606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DAEA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=LU8nJzdq
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFau103941996
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:36:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=Q3u7I1yY3nJ
	muq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=; b=LU8nJzdqTuFeXxiCts/Icr9sphO
	9JwQ6qneW0n34BTZV0JOHdPmVmq6v/o8AAukNp0VfJtyC1BxJESUVBZnUPO6bTJz
	heXDvu278xn0fp985Ow2X7KOpGQZ22QPNDE8ZkenXzSOzsL3mE+pV15Ld4NYN0ke
	Z4xYE3FlOFj/3hNCfLYkNWEOgkL+E1fKr1d8mgMFhG4bM25au11LSDbP1ZpUQNkL
	P4j6oE2OX8TxKs7kHuTuK5VSeUo2ZEx/0qtZHGl8RSf7BrtesxK08+eNxS3Ts9nr
	J4HURg6r5rm/vNvQFI8Dm0i35N/VUkWCnNGSvZbKTT+YhzyAn8Y9jOOTXJQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwfwd2a3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:36:09 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdba239d0easo189813a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794512169; cv=none;
        d=google.com; s=arc-20260327;
        b=docT2Pq3DP6mqZ4XW0Rt1CWjvPaWdxh0Gn/416aJLuaxg5iEWXRDVegmw8raOAE7go
         AJccOY10ceCl+KngogKHTuoaf1Py0O5SPJwfIT4M+2d+R6XztsGMqruPsHCg4Zb6l2/O
         tARXk1+QSYaBsJr8U40FrfgZD77tFs2K41vl/A5GkFOJUDf0BeOHc0e/VzP0B7sUhT3X
         90xFRC85vpkBFxhdM5R7YBMl87sIp87b+4ltn811rDo+zNrW/k1EFiX11t08YPP0OOyw
         /nekXPI3Jvf/+oYYa8/hJgjrxfKc40JU2Q5A1zwQtjjhEumbbgFuQak+kUteVGa5DGmQ
         1gMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=Q3u7I1yY3nJmuq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=;
        fh=Pmj0flJu1UnzQXPteF+BeXRUrdGICr8j0xYNarx7zbU=;
        b=pc2gWKwuc16kfVMR1rw3msemePcfAyL/0F2Wzh/2uaJBcMDuSUbejQU/wI7DIeLgC4
         yJxzRCBUxElR/HEWZnbMw0Mp6DK1BpWMNyu7y5waCGE7b12vgZDVoO3fEwtysPlXH/Id
         7CMcBBti1S/6U8JbYa1PEUaP+H+LqqjZU1ozzWS6VayNdAsPlhKG7OwNUomDv+9rA7N9
         nQ+zHoZjU/KVYuTusiOf9G0J2rF5R5Zp7Zt9a1X6tCeQ89Byq6gM3QuENtsgfbGSb4GP
         v1PlPRV/cg8wMohdXuXX7VsWIc8ckFUJRbJWO4M5HiAbN5nbFHWOB/efVna3Rn4D7M48
         FIHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794512169; x=1795116969;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q3u7I1yY3nJmuq+49fNnSVZ6NxAiKftF5EDGZUfjWaE=;
        b=qxAdVPbi71fxHrb/3yGSmgHb8AZZ1haOqCuxSYBPGKp16HS8vFyhvo8jvONT2f6+J/
         iv4gyH9J2LzHuv6SmvQG7pwPhtq7kyEgFUa0Tfe9MeYT8MRK8gopeaTYvP3aL4CoIcCp
         FXua5mgMYonV70rXZlQFDxQM9Tcs6wrkRnMNd76E2hPXDMODbek/dEGFeUFsgTAx3KtC
         3BEdnD3weji781P+0o5aHsChrvZeBcX+Hxt1WBh9oxFenk2Y1ID5J0H+o1DTlGsf0A8Q
         h4IiaxTpmh1/8pskorPrB7gxB+2YxZgtHVQGWKtvdNbIXW31kvo2v+oAtqIPz2q6L16Z
         5mjA==
X-Gm-Message-State: APuU4Z9mc2OEJxEBD2YZX6sdGnnJEvT4qzEJEL2kl28IM/f/D0z/+gmK
	39J2p8KNrrbshTfZxtSbG9Kb9lUEMBhxNAKIVwQlPle6c0G0kpjwKT8SMYUSXUqml5+/wpVVtBK
	GKJ7oF1RS9Uc9H/f2NOAToC8U5Dw6wZmWLsiTjPwTZMjPNUMawBk2fGWm9x8yLojXXA8Yt7oOd/
	Sg39K9aOOiEN5RH0C1/evnVeKtr4eL0p6OsoWwUPs=
X-Gm-Gg: AYBFou1xniwyKEk78r452Z4Z+0JFLjIeUhkujxCWfW6p11oD4zCEMTv2zw7EZv5Fdev
	qJebEurYJrCg+DvZBqFwnETLWKMt6mo+6lkwwTXZEdeeM21ooke5jnGTCB8B9ofJgzlBA1VnbXA
	K/1n5YWxs0TVf2t42dHoI7zktkRo3JiNP+IlK2e2J8JBSF+Yn2A6MwmEczEOCmvLpgnkdj92Gd3
	KsjRZn2CFtAp7NE8zxQBnwlE7Tf093b
X-Received: by 2002:a05:6a21:798f:b0:3e2:2b76:bf40 with SMTP id adf61e73a8af0-3f7a6e9f331mr164002637.26.1794512169104;
        Thu, 12 Nov 2026 11:36:09 -0800 (PST)
X-Received: by 2002:a05:6a21:798f:b0:3e2:2b76:bf40 with SMTP id
 adf61e73a8af0-3f7a6e9f331mr163970637.26.1794512168673; Thu, 12 Nov 2026
 11:36:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <DMSJJY9PLHSR.39PSNUXEC82J4@gmail.com>
In-Reply-To: <DMSJJY9PLHSR.39PSNUXEC82J4@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 12 Nov 2026 11:35:57 -0800
X-Gm-Features: AclHuK-L78K4XX2ZOiQNpBmdIZKiLWCeJjgy0X9ZblQI3qzdXkkSafaXrEWKuy4
Message-ID: <CADh2yMzE1ipKD7N4YBjb0oP1Ko-Z5J6uN4k4_kK=gosHyfsKWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less associations
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3OCBTYWx0ZWRfX0vnGm6LwQFZD
 e0llqQXmgIQz0W7Axy1acVwdvO+73ernj9fV0xsmUAOOkM06NTvr1aJXRV1QJCDvX1VWDotjXr9
 91gLbt4qTw5UIq4zG1f4Hf/MaSUCqno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3OCBTYWx0ZWRfXyw0K0yPEUBlH
 DAdjM832qIDYFQX7MYH8+XAbYN6aYNdLdyUeo6dOCobfDu8A9Tnqfms/8cb2sg94METem8HqRH4
 baUDVNlnSTi4t2+25znpPtRYiADoAQakOsQdGQpn8Ki5p1QUkgXesmD/094xvvvMU4x12pkU1Ks
 SXq+VaiC4KqpT+F0rUb2LOvMQkGrCgsAoC5B/D8FWkexB5tYmWyMo1ZPBFZRWVIwcJPYRKV+R0z
 fsaezx7jaFc60oTPQJ9E8AzUQRna6PT7FYrAGvEaV7j/Zn7nPmPc548owBEMW199NXe/njflBdO
 LPTu3YixUrgkyDHQsSMTjOZZTNd0kZBJttcFKOKyRHmN2rsUNwyHgfnjPrMcFh/pgkmCGVRuXPd
 K/PwbFNUfGKkitlTLTcp68px4lVOAXcKd35ZeCFuzLNFz3pJOLVSs5gXMUhvrHIwJvxe2YPB4nF
 kRH3FaB6novGZrNi0yg==
X-Authority-Analysis: v=2.4 cv=Df+COftW c=1 sm=1 tr=0 ts=6af61529 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=FSGtspZVazLKPRRdjFEA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: hv3CZSUtTHTnWNZnKd286k5ROpxhlii0
X-Proofpoint-ORIG-GUID: hv3CZSUtTHTnWNZnKd286k5ROpxhlii0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01

> Some of these can probably stand alone like the bpf decrypted, psp encap
> helper, and timewait validation, and be submitted first to shorten the
> series. That's just a suggestion though. If there are dependencies on
> the main series you can ignore.

Ok, I will re-post 6, 7, and 8 as Fixes to net.

-Todd
