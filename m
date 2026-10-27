Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119855;
	b=WNaIr1weuM1N8C5V6giL5EjwV2FEYz9Sojvd2OHxh3bZutOJrldMnFTO8MlkAzY5yV/c
	 6JFl0xyIy8KbCEMMFBp0XZbCe1MQUdd7rW/TuEFeKo6rEz7rWpvqP6yEbRMZR/EaIWdOG
	 MEBBpD8JGxUgl4xC4Ybkzh1JkUdEw4xASkJt74oWECtHgIG7qU846012m6YjcdiAbES2a
	 7ao4skwO8DGuU2S1FgceKKBNj3iwVe6h00HtHnM+Nv/lEbC9FiK3G/VizB42eABSu9419
	 ZNDL8dMXFjXZcbL68dTuDsp59FqmoCPP4BeksyUr5xmc6TRW1UhYNSRAbluMDQi09Zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=TNVT5SIENBUHIp7NEAsmxJXryvr6yV5ijHD5gywhn5Q=;
	b=dG9qBR6uC8omfeDpzb9J+fk1mtKGtfh0AifKrnPlZVD0l29a9AxSDT4Mxfa8RNCcvlXq
	 G9t1Z1dIGO6lEOdLGEBY3CMvLVPaomffAsVFSAZqoPKLMjNVD7hEemHCqj3FSipB2Gssr
	 ErcXwXlbZ9Z2G3EMNTj8p8Eeix8qeaY14QRGNu0rybFV/PuuFb7C3Dnm8CGakVKNqlS72
	 NkDGHmFSJtmcgBwXSIZaGBRmLSjGqlbbGzoKUYOi12cTJnjQE6iOC6Ar+I9A1lzWYXRnU
	 IPX/qduAWoCK61IPMCpb2IDB5tZifOWSQaqaBEPRy5p9KexyF4w4Wp5cbSZ7ILxuM1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CvGazHpM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46E606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D46E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=CvGazHpM
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RFAs8N2891800
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:50:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=TNVT5SIENBU
	HIp7NEAsmxJXryvr6yV5ijHD5gywhn5Q=; b=CvGazHpM7r6oRX3bfZbviQcSr1N
	4E0Myd1oOxoHpURR8O3ygO/Dpk/n1BaOz19buAwlnVLr0933AuaeEvpDCFHFgYz6
	abeMKNuKfzjQowKx+jhyOIDNoHJxkAcx98V9472nirEz5YyvT0sbM7FfdvAjRys0
	myg9dJmXQEXflfKncql+ipZFqVziwE147BeO3Mf+MZRkZ85jYo0DUmrHYwzFSUTJ
	fuky37CemmmW6A5xNs+7SuYVHono0IQjLn09R2nqGqXdEjB/jtzeZIdsxjt0ZtxA
	1donqVG410NYAK6Gju6/OsKk5vwG5hhXUeThTDdEFiP5RIa1aM+2sYN+e0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hjxcah1s1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:50:53 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eabb908860so95045ad.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119853; cv=none;
        d=google.com; s=arc-20260327;
        b=QFA9CCtorkfhGqmJvSBdvIHu/tGps+748Om90znO4QZo+qD+zZ0dCBTXhq4sfahXNJ
         Z7r/K0l1dW1JksCZrbdI9wPhZlUx8SNkndxmnN7EKS5AZU1N3qDNXflJIQNsD2QXYMbK
         keiCOVI2Ta4umn0X+MCQct4PvP4LnlwzY5e2fcIAadaESm7F10siDXDIThP9JhLo4/08
         B+OfWaZWcHYETdmm3DVw9jZsg63vmgf9j1Ek1sAvm0SIKrGFOWFbJOViNSo39BbSiXnS
         Wr4xICu5snx5zHmpiimC9xwDoRk/uSLtV1zAPfKm/TJcf1C6XXOkz0/+s+z1xUw8jIKf
         YSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=TNVT5SIENBUHIp7NEAsmxJXryvr6yV5ijHD5gywhn5Q=;
        fh=D6tKmYZ21eXs5E1d+N2NrW6yX6x8NTwPGZwn8rAnVCQ=;
        b=LGxrEM8M3k3+zpMxlxh+4YltH5Ag/8KOh8gNY+My2xt9v3lPwmOTtHvSXuichQ/O7p
         1Cz60D9U+0jaVMruc3wJ+Gr4ZOg/3q72rE30XEfOQ2okGV34lx04luZazFk/j3+NNENX
         SUY0szDe1XeAV6sWF+AkNaHRq3x6LqHgyuP/m1l0DosubKV3WnOVW9thWdhqx4XOBYH3
         ZR6eeIja6yYVNoWPF/yeGcQss+vhKpOiQJ8gJTR90kucHcmKp34fMPY95Qk8yE18K6Sx
         nPM1jHZhexD6gpM1q0D0k/whpx6BR/gD+pJFGFFUol7ZLUzhM+JCtmB8/d5gO/X7IdtU
         ByxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119853; x=1793724653;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TNVT5SIENBUHIp7NEAsmxJXryvr6yV5ijHD5gywhn5Q=;
        b=TG+PaxBTkcPyCBoxhiEEDY0hZxHy5rMKg3J81QE0dxgEeKzcvVp4POu7YgJUhBCOWF
         gBLtyIAb5liOIRTqPSDm/j3I3S+Uw8SmjGf5knLyh1ORA9VuNkZ4k2LKm5X8hA2PVHUT
         l2CNbRnSzQfAFzTF2JKTfFfGkIdFLDR6H0+xyEnLPzI7b+t4nUTZDiCY4PRsMFwPGEN5
         ZVNGtmM1ugkYwUwCT73LSckigbehOVw/drbHg9OnQ3pzQgFYuPgXIvAgGqRgpSqac5AG
         PA8fk+1A3c4oXE64HHFsdpEyhWV9MMMh43N5R2HQ7xYbJi5LT8tRZBhU99yarEuAS2ba
         5e5A==
X-Forwarded-Encrypted: i=1; AKwUvBzafrNTrFgJKuuus1iVSjeUqBncm1ndOdE8UCNlRZpxAJfRmVSzLhYJDQiY+Wb2UdQDAOp4HRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3MrXA67OmLnNCc8JGigVC+mJ9jUdlv5eIsR1ewoAAJMShkkzz
	ehgKI0A4lJgtSIWjG0vspIMSvfm6GlKysK3pRWPbn2Iu/0HecZnF9/jkhe3M0rp6vGeHYHxlTv8
	N+GP15zj7G+hhdV3mcIMYY2W+5wjOr6kgIythSKw42kgnFhlTDqAkg9x2rRyV7F0Q3x+0UpScR6
	ZEpJkJBfbw3w6DBlA1dYwpnL/VG1QW00c=
X-Gm-Gg: AYBFou27RZDSCm0HESkZPuyfaYPrKX1tCRdGtk18V+ISV9MvFm8/kxM2ol4wswed93I
	u93DtUWi27wR/6IV+qnl+zHaK0IxoYnlCRdU0KJjIWkKUfWTg1eBOkxYsFnqRAn6JzW7Yzio2/v
	KcM7axcXhzdq3PGfbnlzNp3d+s6ZMeld8vYAua9raV87DXaQXTCp8IEHI+8OP6KOGn4aO2KSm0w
	BzzRCqfDBJz5u0sPzRC8nMXYb1hbdk9
X-Received: by 2002:a17:903:2c0e:b0:2e2:c995:b00a with SMTP id d9443c01a7336-2ea9c83f0acmr97399215ad.48.1793119852787;
        Tue, 27 Oct 2026 09:50:52 -0700 (PDT)
X-Received: by 2002:a17:903:2c0e:b0:2e2:c995:b00a with SMTP id
 d9443c01a7336-2ea9c83f0acmr97398875ad.48.1793119852321; Tue, 27 Oct 2026
 09:50:52 -0700 (PDT)
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
 <CADh2yMyYS-PWP4912En9D6B9up6Kz-hnCthNkWot+e7N8-q7ZA@mail.gmail.com> <DMFQ63T8HLVV.3L1SY71TO7GHU@gmail.com>
In-Reply-To: <DMFQ63T8HLVV.3L1SY71TO7GHU@gmail.com>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Tue, 27 Oct 2026 09:50:41 -0700
X-Gm-Features: AclHuK-jcpXRH06paBbeGResR_5OkEC2X2pBFWTmfK1GHPn1XqyQ0qM4p7DKnUE
Message-ID: <CADh2yMyGdz8XR263w9PbMf+pM1MvNh015CUX69NdYCMfjFnv1Q@mail.gmail.com>
Subject: Re: [PATCH net v3 2/4] psp: support ipv6 extension headers in
 psp_dev_rcv() decap
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
        mbloch@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, horms@kernel.org, shuah@kernel.org,
        cratiu@nvidia.com, raeds@nvidia.com, rrameshbabu@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bjorn@kernel.org, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=I8/w19gg c=1 sm=1 tr=0 ts=6ae0d66d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=YJpWPkmKExx_aQuJnOoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2NiBTYWx0ZWRfXywRAKMiKKP5b
 1DannE+WBrKSuV0Vi5/j0LuTgyxH3wXwC2Yq10xps6y+oOakzjlSTnDKQ3AUrNPYgzjDwB7gmCi
 P6O8FAOHcoG7F5C5aMVz9aKbd8gUi8M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2NiBTYWx0ZWRfX50xWa7QiFV1d
 qvvGTSRh2G7fIrm4qOhUzdgztCv45/1QX8SJzkbugqM3S1KKuTmnQVR1eOVgxqR5NxwDApL1UG+
 0N9Ein2WH2oUkJJjp8TYBfeKwbwneZNr8J0HYnPOhlJ4+sd+4w1jjev5ly2UxC5dFB8qC7GtAFg
 DsKqYU8rwhE+H/6uL0PXGa/b+ZczzxVDi3F7h/RqXTAZPUgGkS2RIJ+fMG4EJDjM7A5GSOsLAqT
 O9vZH5FIsLuBCoRxNT+iA5ioxs2Rd+bI3ZKA5uX0VwIpbtBxyt3pVbsAxGEYu9OtcaSEmfSFqAt
 +TSJNO09qNy/30Vu5utMfBN4Q5Fqu1PQX2oribiXbHozZLuEbOCU6VLO+6aa31O9Q1PufE/Dgse
 mutGlXejuKB2f0P6fa/i4NT/K5eTfAodJLQmH3ohf1IE0gDdMmeitNNm/orJMSJS4xKsxf9p/7r
 J43Iy5wyxz46LtnSf8g==
X-Proofpoint-GUID: _YwOSTwV1gpt7ju3Z8cOqne2qLH6lvhj
X-Proofpoint-ORIG-GUID: _YwOSTwV1gpt7ju3Z8cOqne2qLH6lvhj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01

> >> Before this patch, all of these packets were dropped at the is_udp check.
> >> Forwarding the decrypted skb itself looks blocked by
> >> sk_validate_xmit_skb() ("unencrypted skb with no associated socket -
> >> dropping"). That leaves the ICMP error path as the open channel.
> >
> > Agree with this finding.
> >
> > Ok, this puts me back in mind of the approach in v0 of this series ; just drop
> > packets with extension headers. Actual support for extension headers can be
> > done separately from this fix.
> >
> > pw-bot: cr
> >
> > -Todd
>
> Like Jakub points out, this equally could affect tls offload. We need to
> be careful with any features that can result in device-decrypted data
> being sent back onto the network. Another gap that exists currently is
> xdp tx or redirect. That would also affect both PSP and TLS offload. I
> think we should try and make these features work with crypto offload,
> rather than building up more and more defensive checks.

Adding the skb->decrypted check on the ICMP path makes sense to me, as
a fix for this specific case. I am a little wary of fixing the known issues, and
missing some unknowns though.

-Todd
