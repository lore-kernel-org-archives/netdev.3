Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792688330;
	b=KTTjNW7b+ojqQmNdojkSnXRmVB5jntNcmcN5rT8IccWdSqK//05eKCD20F7t0Utt3y7V
	 dKzJNtFbJKHy4xemiiXH8aeC+pGqR05h3aJC5kbVMAoDhFmZ6Jl2gWV6edpYZenTlXAml
	 mU+GxOKEDnFPP1pAsXneee2FtH7SuyWJeK/PmxBZwrcFZmBesKYmfPvLiGlHBpnoHKAX0
	 vxElO4H4E/2Rdy9FaPvRtxIDv1AXnZigqR2NX6nCM1ls2pYigw1O72GMUMNtKryXPJbgn
	 lXXTZSwv+ya3aEsiyjcd3967GDnUvAL6bYGoKuyuYXxgz28yIaSAAvvJ+rNLuO0151Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688330;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=OlvxhZaFNNxPSruewKqVsjl2oNISZrjoCUrWTQhSzto=;
	b=mNLuf61oQrDu5c9i98QUH1dwQ6iIL54osdD2hB+ZRLalgx7SlDrNLzw2FhSEK3j733+w
	 ZnkNw7MHr0/k1orLkucKqVM5AO57p5zCDNoj63dmQNOey0Q94p4fv9bjZE3153hgMoapa
	 P5Nov/yMs6rL9phWLjy7/RftOMky1zb+dyfLV059DYw4eBbir52iV/Fg1/a15fR2tUcL/
	 LsfCk3cAjkb//D3iwNyyVvuPtLm/rzaZhSQNm0+vu4gQWna6D6gd1BVDrSDAcEbJPdzmd
	 MvqD2P/CkR5sJzf4t7rOmENrrmc2HINgIpSCA/oBDofuNXWHI8+/YOGBIpRCUYZJlVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=TXn9CHwd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792B606A330
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8792B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=TXn9CHwd
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MGgNFU538243
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:58:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=OlvxhZaFNNx
	PSruewKqVsjl2oNISZrjoCUrWTQhSzto=; b=TXn9CHwdi2W4NrcyOm/YUyLxnR8
	OUHcxOlfW4xTdJW26FXK1z9ozbqZGrc3LbIP2hDwwddpkllbZDuyhUYaZXw2Xtk9
	i6IaiMVMZL2tyc0NVeV4A06b7Hv3lICyaI88Lm72gRdkQ4mGIAYYx820x5GMJJ/Q
	nQK7E7W5is4G3a3kMu9HwjM96znznIemvk61fSmEHDAtDR0pfDkiprmtGa75vAje
	7mGQUGl/uX1FP6UcUEhAmSXJ8vom40qV0zC/XEJwGN+V/5hmqD6dXbFpP+iVW2y8
	T1dj2QQpYyYrw6Ub0da2P9GcBsooPzOS4j+llwimH4LHMUj/Pp3ProGC/pA==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hf93mmbg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:58:48 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dea677afcso855129f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792688327; cv=none;
        d=google.com; s=arc-20260327;
        b=qo4Va/D7nntGPvxj+/ahWnoj7uditXvxm3YnohBLuWe1h2qxTMlSUpFG9ZAbyn1anY
         /3BuLpG9K1pvYIme3pAeM/WoowXLGlyAvX84d4n4E35plTlsoYz+aPMrJ4sgSwF+JgDY
         RFgIb9u6H9WWctjw6FDMc3iS7wtPxBofa1+RGcDEqrOC/epgsbhF+91uTDBtZ3ERx63O
         oxkdJvb02J4Sj0bBnsrGxycYdjJ63qLwbFsjjj176uA6XgipnOAZi9ROobu4TKjk4VqU
         jZ4tGBUI5yaKZie6BCo8FWJZJ4+F+7nuRQv3Nhj5gu5WPMQu2C89f8FaVt3mVE6BB1k1
         I1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=OlvxhZaFNNxPSruewKqVsjl2oNISZrjoCUrWTQhSzto=;
        fh=+w9+sO4G7RQccdPVhc69GIF94xdIKQu5Qp0YjjIpI1I=;
        b=mlPUiUdEbIYlFE7enAb3cFxyNddQfTP3SvL2hvVw4+9LmisTGqy0AD0BocEdfkRMSP
         OCGeqvz21kvDww1gvZ3S6gssd4azNPaEmE04NSiVuVyYehFSemLQbbHWNz7R4Unl/mr2
         BsmjrnNx3zG+/IOG7Y0tSMaJgzSF30OQ4VXa00dM6oFVZvmMn1a4wkwtfPI9nTBfNKbE
         GPWaDIMH/AeBud3j3U599e5Wh0DGxpjVGbu1Ndb3OoGFSOLjFROzDT39km2UZkTvJ7DZ
         6uHTgVcnTtYMqV8DRf//g125qB1OaTxmr4796P0nsMgCtP0laBd/WguerOsPoSGCkBG6
         Uung==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688327; x=1793293127;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OlvxhZaFNNxPSruewKqVsjl2oNISZrjoCUrWTQhSzto=;
        b=Vtz3rVYTwA9pyYCaSXxDMqYcLE4obd15SzmtRUEYVyH5blhrgJDXq77KiWwyhfwrqZ
         HcapEeCJWX9ohKO/5+SPrhQ2eXsL4K2hyOh9b03AUcZF7O5GEay6Y555tzFDqv7JmXU0
         zJwODhDI1+M8Dp2YvWO/DQfljeHkpewW7PRCjJJ15JPfNI35+ocW3UmqQZXqQgmgEaRT
         Qnten/Jm8KfznF+pbAdhnokmjRfCUV0JgV07aLALhON5hYzLBtY9t4gHM4mXvyGmEWPJ
         0ECZc2F0OyU3olZYC0TzTxM10uEhvv59lu8PDnU3gnfb2ttlKSkeIsIaWhFUV/DShfK6
         wwSQ==
X-Gm-Message-State: AFq9FYIgmdCXqi8GwtrP8QgV0u3x51P5v2hBuR8B8wVqpZ7ZZ0btxpqt
	idicLlymPaHRlHn/ugsrJ8oLlwy1HhhCvyH7rw+9ipwQYSABEj7i+4CV0kV55cGYxpy4xEisn3S
	JMVbS8SYB6P1VjL1YOpRec7GfNZXaoAhQFZKJ0rIXffGiD1kkkfQo6P9FIKNVRI8MjEuz/NBebe
	18jF+eyaB90WIGzS9DuOgMWzJ6Fg0PSNQ=
X-Gm-Gg: AYBFou0231Ye5LPjS00/PSLTi6fqdTbMe9EOCgVYDnTe/RG7AGC9QoVGPZERxLUd031
	cgwS9bSsEqXxI46CiH59gkcuCe5LlaAzy6J54thyyDPn5wjcEbA48HxnOrHm7++tBv36Zbp+4zA
	lZut76MyAxNAIps558fKXNvhegs5RuByzAC/2A5/7RdqwG07eqOKhFVu6nHHH8Cs0jgkcjzlCnu
	d8O5dIoT0lSr1p064NH5Wq5WQa0S/Im
X-Received: by 2002:a05:6000:4026:b0:48a:fad8:52a2 with SMTP id ffacd0b85a97d-48e2d133c16mr7174876f8f.23.1792688327228;
        Thu, 22 Oct 2026 09:58:47 -0700 (PDT)
X-Received: by 2002:a05:6000:4026:b0:48a:fad8:52a2 with SMTP id
 ffacd0b85a97d-48e2d133c16mr7174839f8f.23.1792688326856; Thu, 22 Oct 2026
 09:58:46 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021210200.788191-1-toddfreed@meta.com> <willemdebruijn.kernel.31749cef483da@gmail.com>
In-Reply-To: <willemdebruijn.kernel.31749cef483da@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Thu, 22 Oct 2026 09:58:33 -0700
X-Gm-Features: AclHuK_NBD94GFwukMTzDWZnzFQVpepA-a7ilcg4xIfDlIrtJsUvYJLY7PXSbnA
Message-ID: <CADh2yMydLVUozaXJR=uvkkw5AjnxYhFs7V4dUAkfBs66i8D4ZQ@mail.gmail.com>
Subject: Re: [PATCH net 0/2] psp: drop packets with extension headers in
 transport mode
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Shuah Khan <shuah@kernel.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Raed Salem <raeds@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2NyBTYWx0ZWRfX5cmPuehtg14M
 EL5Mwf3R4xgh4kbrrrwmRmDA5Iio3T4/vV2HCJeEvEWBdtR2BvbtcU7STbNudZk/eTZmssg9Whx
 9oCFuIHLM/Qih8esM1LmbzyWbXdD8citapznxipvJjrH8c/n4kKANrRtJgcLZZJv1io84LWutT7
 j8yoLOe8cEjtTrxiWCD3ZqDw02fpMgdNYWsfzbGGo3DacB1fz2U3uDwKJxRJZPKW8c/pyyZJKPS
 B+b8M2+o5RHQf+K4kYbfq2yDoW2d1OXdM5nQusVcsx4tUcCoNM26dhAAohvqVThIqdZuG2hFrub
 anxDe421/9kfKGv4B8vz6yA8PQOLvugtYp+Uhs1LEiV7ou2kGnJnrj16ICyVrzwlT8yRo+M05oE
 /391933G/upmiOaL70HccQ7+hO9akrPwG5AAZIgLV+C3yaSV9GKlKABS+HqLWHmA3/8yJvj2nk7
 ZPERn21iiHVkxTuk5vw==
X-Proofpoint-ORIG-GUID: Uk3lbyQ82EwHadJkDkAArOHh0S3grpic
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2NyBTYWx0ZWRfX0XL6d36ji5Yn
 6iebjRn5ja7z4F17lTV2WZ57xUlbK83MhH9tuCan3J527VNAqvT9Oi+rgpM0RNn/6m9pDRZRGlU
 MVZZpGRaZPG7HN4slzYyRQDxPE2GGBU=
X-Proofpoint-GUID: Uk3lbyQ82EwHadJkDkAArOHh0S3grpic
X-Authority-Analysis: v=2.4 cv=a7+lZkSF c=1 sm=1 tr=0 ts=6ada40c8 cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=v5nOu5Z_PtvP9meoUtAA:9 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01

> Todd Freed wrote:
> > While working on adding support for socket-less psp associations, I
> > noticed that this case was not being handled correctly. It will be more
> > relevant with that series, because it adds udp support, for which the
> > psp nexthdr will be taken from the inner packet.
>
> Just curious: what is the plan for replay protection for UDP?
>
> As PSP depends on the inner L4 for replay protection today.
>
> FWIW agreed on the ext_hdr conclusion in this thread.

To clarify, socket-less psp associations will apply tunnel-mode psp encap.
So it is in this sense that UDP will be supported (not e.g. adding support
for udp sockets with transport mode psp encap).

That being said, UDP which is PSP encrypted (transport or tunnel mode)
would be susceptible to replay attacks, just like regular UDP. Except in
the sense that after enough time has passed, the packet would not
decrypt if received again (operator has rotated the keys, etc).

Not sure if you had some other kind of replay protection in mind.

-Todd
