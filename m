Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561550;
	b=QOfNeJuwtTh//09u2Bd5t4A4STXtrIxW08HIVgMRTQwDm2y4YJkA2Tp/LfABUYD80dAA
	 2JvBTqb5UBota3wzVYSomY9WtaMvH07AgGyMwh+kGF4535VrjBZ9NlgmDN0XzsvodQSYm
	 tDfx9WCX89dUNQueYohNplIha2yW7P3LeVnetbpcRBPetQmJMnyukyRK97ZQ7OdNUR2Q0
	 pwR7MPa2Em3jLQIo8y4cEPqkVpeH/fEorsB/m5ZlgxClCl81RUGHpBcQj+DlyLn9X2+aE
	 6/1DLzgLZMCGcrx8qOTiu30wbJVewnyS5c6ZdVqQFjaTRMkiNE4voY4Ku17WnezlIew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YNlnEeogPiCHR6te9lkj2QiOwWqQwxIx/RUVSVDQoTs=;
	b=huLfCr330vTI9hPfhc+3x9RBVaFWrPgQtmVs1o1Ecasamax0WwMa/6LNPf563pDwV526
	 L/L9wk4SfLq1tqlsQgaNX2ZILiTDglG7DkHt7OVAKo/JdxuQCF0V9wEC2jy0pZlwwQrxD
	 gVDFfG80glSOixrqVgEoDOMb6mZ9/KK5QO9zJuMQdQ03v7aw81xJUm7l9Kj6zQKNaRPsL
	 4HcTaIZB4A23rxz+K6Jc9ilFuZS1pUd/PK7iZwxFKjHeQkxD6yPwdSad4dz1DQvTL90rl
	 8qNtXB/+o/N3Fe6ZsrZ9UlJDDMSQtRQbhHQ5ssmTezkW5rFeho+njMUno1hcRN1em8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rvj1Ngyd;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCC606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 05:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDCC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rvj1Ngyd
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53644b28706so4912151cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792561549; x=1793166349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YNlnEeogPiCHR6te9lkj2QiOwWqQwxIx/RUVSVDQoTs=;
        b=rvj1Ngyd1Q6IpIe0F7XRyRAymYaoLHBzbcXE6ZTFzyEwK1jjFwE2Y4XhM9r5w3/yTB
         UbDDCh3XNaYPBLCdLsUjHTpxEddWsRkSyezwrmpDlvVHOpatxPJFOKKWEytIr6nYBTn6
         PnYjl5sgVe1Hlf82afwEe+LfBFBKBDRj57m87emEWj9NyE23Wd7hVAzVP9NCFLmu9ZMZ
         ACwG0oUJVNZexWzbi6MtM+Jfavqtlpt3ZZHHRb1S/JGaIIRD4Mq5Pv4tqYsv5khtN02W
         /b8cl53qzM782MCq8MiEuve8pSPStj/odusBTNdNOY9DOVE2OYU3Q7CZUbObkfxR1Gz4
         6YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561549; x=1793166349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YNlnEeogPiCHR6te9lkj2QiOwWqQwxIx/RUVSVDQoTs=;
        b=klmL6TTACClNZ4LQj5dmQ47pUnbZQJh5Ouv6dJx3bZtgDk+b90WUAbwbtN/rJkc+LF
         h59/GrrdTgggQrOtYF3X64Hc4AkFJ6BBQnM/V+d10heC7MJ8LAsdcCY38uiIYYpEj4Xs
         w3Hokd1rJbRw4T0hJC2HYfbxviF1y0uOQ5Ejmw8/Co+P03tK92QaZUuc54zT411Wcv7Z
         9Ba3qtasbq4X99x+k6G636B8Pbr9FHE14aOqXL7FL1dSb+VgLK+UyiBP3UuHscYVfbz0
         kcctqfooMBlFl7SyHYL4Ay19ajfU4zqmr6Epc8JbZ3i8fE+ykjl9lfJG8uHn5mSpXJbS
         8TuA==
X-Gm-Message-State: AFq9FYKNYa2TP5F3g0GuG+bz4GInJiwriBKmKj4SF4lI/UrCDLvip5qQ
	bA6k3kh7suPto4wlh8Shq6A9wng/GXu95EsKB7mjx81sUWlBJd0KPh0U
X-Gm-Gg: AYBFou0mm5qWZkNuQUnh4Sp7vdJfpAXrcDsjNj0G0Y0dHjFxTC59soGnXkAK4FXXEsv
	xQupWIhMXN0VSARh5Rno0Gn0VBEH9AbVrh0AsIOOSBqodaAq/ajBKRZo5wzRSwM9skKPMGtcLOB
	GSe0Px8mCXkwEPUeP6+Z7JVQZ35rKqjzL7oPWK+I3dclbwqyOuOpRc5+fkg5QHucQaqAMOl9xOc
	UqFY3Ee6T777bgBsPO/oVzdB4wSUBS+nbPRHx4neFm+c6Y9hghKPKIvchrN4dLzRyegYFm+93bj
	wPArjAaJhW+B9V5/l739rbiBkihVRapX51JJNiPUAninCKihSE/YD1DzegErIcVd2POvTbh5pLk
	i/Httau689Vb44x1HZKUy7pTjEBh7T+xCp1dnrK7nmBZQ5JaQsKYu9DrxkXQaWWWqcdvYCccier
	/AcmhhnEzZzUncUrpu5hCZouNk7sFQC00fnWFDF0lEDJSokxFXaCsYCBjHsBjn9+pk5hQhsa6qN
	OB169ZLcX4Gd7/Ka5hsG8s72/qsDYQ4S7CYJayIS0z+OQAtHic=
X-Received: by 2002:a05:622a:14ca:b0:534:d369:f398 with SMTP id d75a77b69052e-5369b8943edmr16119711cf.41.1792561549041;
        Tue, 20 Oct 2026 22:45:49 -0700 (PDT)
Received: from houminxi ([61.170.224.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b9de47sm16385166d6.16.2026.10.20.22.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:45:48 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v3 1/2] netlink: specs: add ovs_flow del and set operations
Date: Wed, 21 Oct 2026 01:45:29 -0400
Message-ID: <20261021054529.1857897-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020202440.1012706-1-kuba@kernel.org>
References: <20261015024132.698658-2-houminxi@gmail.com> <20261020202440.1012706-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 16:24:40 -0400 Jakub Kicinski wrote:
> Should include/uapi/linux/openvswitch.h get the same update?

Yes, the kernel-doc for OVS_FLOW_ATTR_KEY still says a key is required
for every request except a dump, and the kernel does not enforce that.
The header is a kernel change, so I will send it separately rather than
fold it into this series.

> Could the doc mention those two cases as well?

Yes. A dump reads neither a key nor a ufid, and a del that carries
neither flushes the data path. The next version says both.

> is "Always present in notifications" accurate?

It is not. A ufid-identified flow with OVS_UFID_F_OMIT_KEY set has no
key in the reply. The sentence was already in the spec and in the
header, and this patch only kept it. I will correct it with the header
change.

> Should this change carry a tag like:
> Fixes: 93b230b549bc ("netlink: specs: add ynl spec for ovs_flow")
> Could it also go in a separate patch

I would rather keep it here. del and set both list probe, so splitting
the type fix out would leave them pointing at an attribute the spec
still encodes wrong. I have not added a Fixes tag for the same reason:
the change belongs with the operations that use the attribute.
