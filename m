Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28647010C
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663496; cv=none; b=C94OEAkOgKGpywW6jE0d2aLNSj58kZEq6rrbfD8+sJwQfr2Ya3QxgDBA08FaM2GIvLiXABkVKydpe1jf2RdcZNgpLYF4C70yvTEdC6WI/kEuKNyNZU7XNhxynMUh5Oqy7ZGWWvEDM3PvcsZvPO6EuzErZJxrG6HsMhsO2LXRaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663496; c=relaxed/simple;
	bh=pxmVjLPG3nH0hKHLAF46OKERZeBhdHYcYAXSEaXX/60=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SUWPm7+71j8LteIebZyxwXUbselrtV5aITKtA43fHFypwT6cNygPXmYUsrB8nqJlOp7yQ1hQF4gdBt2OgOffx9juoWbOAWQF5b+/FU7IIrlgQ/umPZaBx3ybHbzeeIEf5K/3iBP6OPXnw0f264jU+1IyJk9o2VC2RZKAxEWdidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNOkofWs; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNOkofWs"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80c5cb9a888so98404877b3.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663494; x=1785268294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/8I7ufhgviSfj8h8UvuBu4QX2xTPKTDNTn4U/E8FrSI=;
        b=LNOkofWsMEukwgjweGlIaW2OaN33ffpv6wP4GcsyfR1ps3dbqdns1eolzrStdLmbkZ
         am7xEj8aLoYEm5L3+MYIGwZ7cFiJR4K8ug6fA1HbP/Hhnt1KpRzTPc0cmrXpDb5peDdV
         qv/iz8uHgLz6E2i1zjwz5oxU75Ay1Z48CjfHU4OI83Dn6kcQo/wNOAaL1PRTo95vtC1F
         7x2l6Cl18RnTfp4FuPofG0twkF3PfaqJGlbWPbvXMxLW6UYrj8bvIzYoiWxuu00ZeWk+
         MAKRMqynijGrRtgJsOBaFePjRDZhCcZke0daEvucKvfNBOXR+Pu9tZtqIcPAGKv5WXPZ
         iqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663494; x=1785268294;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8I7ufhgviSfj8h8UvuBu4QX2xTPKTDNTn4U/E8FrSI=;
        b=oaAHNsie0MS+6l+0+0AouVHtucCDBGho2j2Pb3LJfqrJKrO6CmGBF320M3TnH6Qc2G
         bpsDmGg8i8RVVB9MaDXtlZQCbxpb90QzZEpzHcnlgFjt33KjCHSmJm2O4B5JaIFamjwt
         /dOnqxvAHIr2wUpgpS64FCZ04fZGYvt8oWd52lTs1I/mDG1glii3CY6ckSQdiNb8Al4z
         i9RJhCJTnmaDVV89cGxexNaWnJ2Mmc6syMbx461x0pujcq0GQOVjuxKsSee707/KK7W9
         /p/M406BgCs65shDTaK0TwQCcr3s2eU0kybfs2ov9sdWN2mr9CNJJJTjnYUWHN/vvFsG
         Yo4A==
X-Forwarded-Encrypted: i=1; AHgh+RoFYCAAd3vPNEXIfVtogOy/lvG4KD/W5OfTOs+4E9xahwzyVvxTR21wCcgOxGWrtA0s5u6Wk9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFZEzAG2u2m1db4bx5oP2rb9omJ1z+qI1S/D+zF6KFm0nGZzD
	GzZN+7chIOJBnTsxkIRX58DG2cNoVn3hbSi/FZ19ujLAscS5Dy/rI4v2jMDHXFur
X-Gm-Gg: AR+sD13HWCtjhEjYxFkguJhF0i3Ktu9fy7uM5fxFTr5yIJKjczPDUIXTgK752GsRLfJ
	uR8vs5UD0YtaYKVSI5XkmwMMendcxI5B3HFAe8tsO3R4kGceo+yo59ZeFgRr8UcOiiHKxCFhb2X
	6P7ritkZxS5CfP4U3C+I0HegoiIjR0Ar0gg+jEwHVV4Bz8R3Igc4zSqBgiwfZwXTVc0jAmMW44W
	aMIzXmXTyVWUgoDCBuatgOHQi5vvKx2NPiT+5OqQCFb0MaNogRXsSNsjoRdD/8h0OwGYvohnsn7
	fcwW1cydGmP4+BLb2sEW8fW9Y2jZ7p546alm0jGEr/9yQWx9dBY+ptFdP84B+VFKaP2bkO7Ia/V
	pgQ7AxwIoPM3q9DC7xLM22pdWI89phH5Iitl5nrMU5bbK/RjCwa6pyMjJ95AVI4t+JmeGYi8idq
	nPGjD+bTKf1nV/AqcINb6gDI+T0qpwBudk7NdlyhI8h4cuT6BnmhPpqQA=
X-Received: by 2002:a05:690c:3505:b0:81e:6d9b:154d with SMTP id 00721157ae682-81ef283e79emr63529217b3.55.1784663494168;
        Tue, 21 Jul 2026 12:51:34 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33ddda95sm2715587b3.35.2026.07.21.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:51:33 -0700 (PDT)
Date: Tue, 21 Jul 2026 15:51:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.22a199c03e97f@gmail.com>
In-Reply-To: <20260720122714.759175-2-joe@dama.to>
References: <20260720122714.759175-1-joe@dama.to>
 <20260720122714.759175-2-joe@dama.to>
Subject: Re: [PATCH net-next v3 1/3] selftests/net: Test PACKET_STATISTICS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Update the existing packet socket test to include a test for the sockopt
> PACKET_STATISTICS.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
