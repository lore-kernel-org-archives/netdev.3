Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31992BD597
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658125; cv=pass; b=E4fh8cAuqV8wLE2AonNM98OPhthxscVag+mXvlVhWbs9CDGcxQdU8wAY7HLxd40/SthEi6Mnxe0/Dj4ISXixbJ4l1v+i5Fx3wVFZ/AHo9KILvIYe3/GTnOYPOKVxVLU7DNtybHeubR9RRBgv2ZNn4uqi5ugEybeQYiuFzlnq4g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658125; c=relaxed/simple;
	bh=BT2aLvHHSiaAITvo5ZaHcBXI+mS94zT/sODXHEZQDII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uET2emhAFhBlX56yJUqXofTRXs8LVHQvNI1qY/TMKVJdtR1PCPWY79zyyW8QZ9vCMedRqnI96qYq+FJ15Tr5YQlO35Ky6fjNUnYLJLctP/8HigooK6toqMa47a0bfVjBdM+oZD/sQP3lQCr+6DM4G80YpJ3Am+2U+3R+ALU0tMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn9kYlC3; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn9kYlC3"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-5014e1312c6so3426181cf.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:42:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769658123; cv=none;
        d=google.com; s=arc-20240605;
        b=Rn9ODdlX660B0LNHU+T+ir4WbMnXi5Fp7XBJ8NqDVy99cp50KuokXYG3fAOQBIZfZQ
         f5lsS00irHpHd3VdcmMqjyjbsHsfLyjokGp3Kgj1Px8b5gaaLDa5FluacmNUYCNwUCrU
         0P5Uhao0T0D3W+mTtxc1Q6wJExE3EQ/OEopOke2S+iqy5lZycVpjch8az1q2+LjnSxyn
         8sxi/yOMv3kkKEFapQOI97HHdCva6V/QvhUYsT6tl2eMBjs2X0jW/tPEq9SgmplmunxD
         4oIvdGUsMJ1wJRi1n4YYCgvyflvoqFqjR/eLFezrQjrvQoxwbIeldh1PQsyyHrOSoC8k
         C5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BT2aLvHHSiaAITvo5ZaHcBXI+mS94zT/sODXHEZQDII=;
        fh=Ue3s5T3FzWC1gR9h8NJMiJE5Z/QWxbun+Fo1WMA1MXY=;
        b=Wd0H1xlwAcyJp5vLn0OPBhYDYdQmMcbyzP+AhaA5iCNlHOcs32qvDNP/WENlIzDWj2
         D674e6eCbQnkSlQMfnx92kaQY9cVJzhRvgNRUtIK3sj+BuQvHGVFrlJCVWXVigk7a2Jk
         5hqXpKwTOdGw6OP1sploTIRrnLCctSKXVPXmAAZJwHH1gECf8k9VhxsAOjPF6IbhhSBr
         w5bG6Ld+CeU+J7KEakCTUdx4opuITbKH2Hk8qL3k9yJLSBXz+KU/G1ahViumnPDm7/vB
         UBgEZwf9ipS7iqUFa3+CfL9aIxly7+rlKClfVD15rCFVAyVNbZDSxL2Bp7Q89g7IJsVI
         9+Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769658123; x=1770262923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT2aLvHHSiaAITvo5ZaHcBXI+mS94zT/sODXHEZQDII=;
        b=fn9kYlC3aHIDPccHOVfC3WQ+dbUHOteDGSp8kQy1d5LSUh5kIOl0kXcapdLsQGdgHf
         yLQyzi63zw+XBff6XK5sO5h8cfek8/tKhe9jTyJFwYVON6Rt3+sDnAQ8Xwy3fxbh16cM
         pKq4DLi0CqXNHLNdwKWrKRikIU35IOKFhOMRlBNny22N5IbFOAOHTJFQ550s1kXAS+Du
         JV9xWIOKk39MosOA2Vz96XGJjUwjruE9sMFrf1RCcLY+iW0i2D+AnM0LRyndaEBl49ma
         SJoXP2iYQJPBoWaQOvKzBECjBHz5OBoOR3ovHNi3eGJO5HI8Q+f7auPqejQjXUB95Wa5
         ddyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769658123; x=1770262923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BT2aLvHHSiaAITvo5ZaHcBXI+mS94zT/sODXHEZQDII=;
        b=TqcrPEAYBTiPxXvzzFG7AToPzNlCTaNyytVg5COMS0/lA4zq6yOKc77MZlm71dUnMx
         cpAoPz1hJOOyVt2IZe2oxWZl8ny5nhbKlI5DSg2J/6MgANGV5JwWzuL9mh1EseI5VPc3
         d0yA+T0jGvt8smHtpzvenep1/e25dsu5tRBAZLUFcTAzIuaEAr3UAakMPcErCg8+HCtO
         IP1py2faJDVyvBbA9fhl2Lst/UBLUL2Fxsxp2irOz8Xkawkp4ob9j7X59GqLmcuX0qIr
         9X4R1+3AuYUQjrcxouWM0p5LoB2QT4HnGiPGwHruyCadgfD+j0cgyoM/iWMwdXE0df3t
         tMSg==
X-Gm-Message-State: AOJu0YzsGv1bdb6RzXy4Au6+7KBncBj2gJTzT+2ed3fg+01jDmY3wXpG
	j/oqsZQb8Dn4FPGGq1/Aridt65akA+AIb8QGiaAN8ljXAD3E9gZP2+O9GL3C4pPO+qoIuEYERia
	uR5s/ydT1652gT/Aig/hRDDKvD6nFSAU=
X-Gm-Gg: AZuq6aLeEts8q9/lO7X1SiwEuWqL1M1CTCHdSK8te0fBRLykrVHfy8+8wxrHJXLkaTZ
	Tgzc8se1nrPotQf91SbvIxnM+QV4MQ5JIQdhvaZnHTukf5svLhOtYQ4vz8aCxVDuAaF6dvQGSi9
	GTfOsXsJ8Nm7Ivb3eQ7UW+VhrW66i3eZMCom9sT5kFJUiYrU3rIJPb5Q5M3haAJ8J0R98vrFzzA
	Pn7PTYvb246Y3Lt6ovMw/OlsJlsMRQtl1F4nW5OJLmd1kkP6t5xXwMakLzBQ22k6JCY0XCwiDwr
	EoCgcjq9BQUMyR3F9PohFDuAVD+QrOrqC6dcWxlRZktJfuWilO/UxVTy
X-Received: by 2002:a05:622a:44e:b0:4f1:bbaf:c5d3 with SMTP id
 d75a77b69052e-5032fa02866mr98189661cf.59.1769658122607; Wed, 28 Jan 2026
 19:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
 <20260125083501.34513-4-enelsonmoore@gmail.com> <9239ddef-c197-4fbd-8e88-691766bda3e2@suse.com>
 <CADkSEUjgRrC9eAQYOkaErd7wyXKkUs7+dG+Q1jz7VbqF+zxwuw@mail.gmail.com> <314effcc-5bf2-47c5-9757-aafd5b47fe65@suse.com>
In-Reply-To: <314effcc-5bf2-47c5-9757-aafd5b47fe65@suse.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Wed, 28 Jan 2026 19:41:51 -0800
X-Gm-Features: AZwV_Qg07bQCnu--MS7f_wI_CqnIpNU4ub0DGn0BDCXHfvCSOfyFVLIbfhWi6Ps
Message-ID: <CADkSEUjk3uE+vMOPw0u7MOc4+AN__LWsriWA9fVhm2C35gJ6MA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: usb: kaweth: remove eth_addr_t typedef
 and bcast_addr definition
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 1:23=E2=80=AFAM Oliver Neukum <oneukum@suse.com> wr=
ote:
> yes I am aware of this. Yet there is no point in breaking
> existing setups. I would prefer this driver to get only
> clear fixes and adaptions to changes in API that are absolutely
> necessary.

Hi, Oliver,

That is exactly the point I was trying to make with those statistics -
I realized cleaning up kaweth was not worthwhile due to the lack of
users.
I wasn't proposing removing it; it is simple enough that it doesn't
really cause any maintenance workload.

Ethan
