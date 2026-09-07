Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355143A48C8
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811651; cv=none; b=B45SdSWQsWs/LjZevRmiQYRo7x+Rr1kbjaPd69v/qeMVhzYzdTQSc7PyBRPTRhzCUjhiKSxNaI3lXcRYUaXLqN0FywW0oNV8Xt+pI2Iqi5AyzDFoJsdgbI3UPx/TXGFeeKI6a62HLB2XcuEwW9yhcBSDMvuXuHer0MRSa4g/2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811651; c=relaxed/simple;
	bh=7NykevhhirRjqD4n4VJwFeqZSAO1XwPp+tka/eMaYgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3LfxjGLf2lBXuqlbkLx27ifvG2haarElC8yxkOiuF/KSAF86XUuTe04iqJ7D/l1TpLt3fnx+S81x+mFn/KK6oxrNwZKcJeTCCghUVoooheWhPczwKiFxiX4kEwCHVS8P50k7UYNHB4L3ngBmnj6GXs5H18OZph5SQ2MX3KKLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Y9OFU7xP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Y9OFU7xP"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d0d2d37ceso10089845e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788811647; x=1789416447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NykevhhirRjqD4n4VJwFeqZSAO1XwPp+tka/eMaYgI=;
        b=Y9OFU7xPUJBy+/s5oAlg1Be75AVxSTrepbtWpgk0VsCl0038EUCjAF+DWkr/Ftq7eU
         w7c41FYEEqLSYs4tED7SCWIxtTKwxN7S5OfWexWjs0ry4+SDVJpAt4G+dqKClIKBdrMq
         xu818MkI5vXHJaZh5dzWWFJZR0S7oAtJjAQmeU31zsOmJkw2vdRaxO5LdR6Mo+7NDmoG
         i0d+nnVG5azcG55xjrLo/PnU9BTO0yP28SOTvcLEqMefqr6pueE5926ljGthl88UoXsh
         1yCTw7rAQZ1bEQKGWSbH4Z7XmVfB1f2xsTzNy9W/dAhfbhzVi5UG9BE7I/koyi0/D1uj
         GGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788811647; x=1789416447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NykevhhirRjqD4n4VJwFeqZSAO1XwPp+tka/eMaYgI=;
        b=iaMBmXWb6UwS4LvSi0oqFAPwYRzwWh49Xrx0MZHYYAfu21jDxQD+mZVMqAoo/aPsY4
         7ovCZC4dpASUEiKh9XFiIFUR5acxSMItJZe/PI5wyPt6gI7OYM90E3XYtQfJu5wJvkta
         5jY+/Ptsy6qQsOfKV/+UXM3n7lBvsPtRj4rhVxacSi/j3oDmwFYpEAnBfWHiueHJGtp1
         AjPHeIYStgDiB+242kxzgWIOgjFoDhiAjld+c65B0wf2r81xqGYhpJ84LwSw4MuJ40bA
         cHjWAUXWnIPBMADm0XV4ZcesXRVxMhu8Rd3mz2ZDmOeVCSCDFd14CHckpcesCpxcMGf+
         b3BQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhR0SOQaVvy9pvORYy1YKBU8Z9NYSPx69sopXQ++EOJM733e5NtnhWNm8FdMjWz6bT+K+yRbA=@vger.kernel.org
X-Gm-Message-State: AFuF++noZNJpBnNQOMWcxwHLI3rZtrELY8DZxkvuAWmFPpv3var7Yr+G
	23+tbjiQeDA55vmgcoTw/xv5I1G3FKWPuAZPV/Js3z8TebbSu7rC4yGscf8sg1WrZrQ=
X-Gm-Gg: AYBFou2m0/i7vzbfzAkJzLcwt/WDHiyBZ5KdpyXOCj8wTalsMSPmDyaafK5v7n1SruK
	jz5yXJ/Lhv4Sts2qNwHq0ASu+b0UZ5dnVuUv+p9cz72e27xtsAEx3kp+FkCr2xPfJxPgGe6m3W8
	pRoEnMf6Ry9CHWVgxevsG0xs4siY/aSo9FtmmKIGkl0PuwBLJdJdmevwg3pKAGlJo/WIqOwZQBd
	vhXcveew0b1p+QMP6uoHglYAbjDG5j67LTUisgQ3NmnZwwAXrPtsqjfm3udQ/z+oprzc0l440tU
	8y4Y+MP0eCae17n4Z2YoKw0ZJiQNnlKjHMmSFywaYp4t3TEvYqjISG5wU3S9uzVSCfAvbc4U0Qp
	pMfDgSyidklLbswfT4ynshujyUSomeVohg0Ao97MMth7b4xaNLTeytTQOAm8CvUh/KSn/9S7Sw+
	zj3jlhxESQvK/0qS4pHwGsVhBApbJXcIr/bKVkd6g=
X-Received: by 2002:a05:600c:a40f:b0:49c:fa21:e74b with SMTP id 5b1f17b1804b1-49cfa21e9a7mr169708245e9.33.1788811647263;
        Mon, 07 Sep 2026 13:07:27 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm295497795e9.3.2026.09.07.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 13:07:26 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Conor Dooley <conor@kernel.org>
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add phy-needs-host-firmware
Date: Mon,  7 Sep 2026 20:07:21 +0000
Message-ID: <20260907200721.3391458-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907-shallow-universal-b614da6fe0c4@spud>
References: <cover.1788711837.git.f@lex.la> <20260906174621.4107320-1-f@lex.la> <20260907-shallow-universal-b614da6fe0c4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 06:26:31PM +0100, Conor Dooley wrote:
> That doesn't seem right, sounds like it should be on the phy if the
> behaviour is caused by the phy.

I'll move it to the phy node.

> In fact, it seems like something that should be determined when the phy
> is identified, not really sure why it needs a property at all?

There is no device to identify when the controller connects. The PHY's
MDIO bus is registered by the driver that loads its firmware, seconds
later, so phy-handle points at nothing yet. The chip does answer a
Clause 45 identifier before the firmware runs, I read it on my board, so
identification is not the blocker.

> Or based on the fact that the phy has firmware-name.

Nothing carries firmware-name here, the blob names are in the driver. I
can add it to the phy node and key off that instead. Which do you want
in v2?
