Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E73ACEE0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322655; cv=none; b=BRW0ZhQzsoPY7YJGYBPxmapIf18cDga8M08DuUEnBD6EGJQk7T3Jej/06jd+nuZrYK25X0xUB/olO0toggPVdAUawb6C13o6qdx5H/q3lqspFluUPVyyUuVYyESVFgeqQGhP0flPMshn7Et5IkWWJqAz6oXGb2kJ2NTuJKb82wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322655; c=relaxed/simple;
	bh=+7p3xwRNtCx4HdpJlQfvshSN4t2hw/+vLxkAWi01ZAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhymd42XYnF6jgzO4LDGvVqsFv4t2j7rTKDU9Hs0E6PkmNPshaR2MVEsUbKwZNdIe2kzwnrkXWUqh+0RBLqr4bJnqQPoT0soqgCaWX+cPnxDBUPj7AE3YKfJdhMsde+/IP9OHD06G0V7pXQfCQTDx4zbkPKO4yvoJ20F8p+3vKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=r29YhBIJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="r29YhBIJ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso176962866b.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792322653; x=1792927453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7p3xwRNtCx4HdpJlQfvshSN4t2hw/+vLxkAWi01ZAQ=;
        b=r29YhBIJ5kulnDAxXvlytJq9FSuRdUL6HubyancxWQ0cGFtgVvy2etvgtS//31Auki
         q3xZS1sRuXhpTzFVOxBlSHqv4QKlTd2+y6/HpS8VsFpwT1ZxzIED65bCn/cWpuT7oNun
         8IVwddZikt0gBee5RXFp+GWQLOVFnzKsSYPrOCKKbQNar8zYzAyV8LOJuXTs2TjMBUYD
         o2RPL2UrmNFFAywZIwmiZwmhChcCUPydD0ZAQFqScinekOOqdiChB+4XtKow+5FSvsag
         +opxWHhu8yYOX8uXnSN+FUKI+PMIDg3QlBxy6Q3r+IWQcifCJ4fZUwM+cQEmWcIygLZV
         Wy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792322653; x=1792927453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7p3xwRNtCx4HdpJlQfvshSN4t2hw/+vLxkAWi01ZAQ=;
        b=H9tH1+Gy3ekUkfPL8Rr5RT6Bsryy0+n/o5oG2Kp/AoGYbp9sLk/BzLvHNl2LSZwAzJ
         gftrQtG8/oZig+DcMPteZiiGtwEwjooRpp3wq+J8CETUlZARUdY2ZAovUO6qkPrQ1NOR
         bOMLVkLaWQjtZRdiS/DgjfQFjKBz+IMndDscL2W4eku3umc6tDSptyyOqqLjIvzRDcr6
         /I/6df/ExUik9IPv5y+c5/NX9MXYlhyi56KwXis82pRdTdUlLJ9YDQXnCUpJMWaLLddI
         +REtX5urx5Qex7plc63oHRrbyavnU1048vAPh+0YFFkkmO145ymumd8KWfcDyo2IUvV5
         Mmzw==
X-Gm-Message-State: AFq9FYJkDdleIktkpH0B6Xj14fiwfhjTotdUVe/2AsxvV6xFikqZ/ofq
	LxTLOtapoEecombpuwrvOpcq7e4Lyr9ji/eeMRQK/yOpfr/VkHhQECmZfqc5ID14t2TZW43C5wT
	sft/r/KmTAGY=
X-Gm-Gg: AYBFou3tuta5lNOz1yo7pYQRkWORDtX9HF5XcMSqAHUBdg4Fg/I/iALDGd7Z/rlfvP7
	JgunWn0s9emr8nUz5WRYiKjVn/J8k7YUbgUUuCasCA8gph5XrCRWwESTVtC3BpRxXGHR21t0jGl
	Vet6x9T/RtE3p7F4ONnawZlebYR5mNBtPQZU0r8AaClWqB/19Y2Phvg4BYJH6ifK3/l+rzcdWaU
	m6mHzEVy9uLsaC9Aehm+iImyuMlkBpUsCrOeJojnPkjeXx7HYyMb8sx18BHbkrZzzCnLa/6DlJo
	cXHkN26+rzoYrBvOw/yYJuhPULcBIIALUwElglIWvg3YVi3uptBadZ2AqpTscSjDnQsZtYc0YIB
	VATzn+rukhSBd5L7EFKc56CBm1G2BexBTrXZAv14yZ3CdsQGi5dWOl1x8YtgzTWq6IfoVGes7JR
	Nnsq/NFO2eIUYozGunz/J2Kt24VkyMGyzXJuo7dMuTXwzotx00Bv0unvPCGWRh0UVxClKrgRyU5
	lOCbg3UcojkUL7FKzfcyfMGI/gfv9zIQd9l9mV/yYdVzVCTIyrLsOJZUL8E4XcjmZ8xlJyLV8hr
	uUrJ74Dv+vxq1I7BEBzJ1PPDw7KYo6oQSUh6NrCZsOxMePbnuG9UnI2sodZepHlFl01dJQwC3ia
	qZfrGXbvW0fpAfKNelsMuDuIgmAPt8S6pOTK/wRh8o0U2esLsZaLM7rUmIHfc6hqXUolFgY+L1s
	ivq41feuDNDw==
X-Received: by 2002:a17:907:c819:b0:c3e:d0ca:d2fd with SMTP id a640c23a62f3a-c419d8387c9mr321040266b.12.1792322652341;
        Sun, 18 Oct 2026 04:24:12 -0700 (PDT)
Received: from Desktop.fritz.box ([185.181.130.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c1282sm256561466b.63.2026.10.18.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 04:24:11 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipmr: do not drop GSO packets that fit the MTU after segmentation
Date: Sun, 18 Oct 2026 13:22:07 +0200
Message-ID: <20261018112207.15005-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179172627842.434549.17722584347227331391@kernel.org>
References: <20261010131842.2157365-1-julius@bairaktaris.de> <179172627842.434549.17722584347227331391@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by v2:
https://lore.kernel.org/netdev/20261011162957.1328474-1-julius@bairaktaris.de/

pw-bot: cr
