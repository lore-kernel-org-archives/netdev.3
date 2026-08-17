Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E840DB58
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968895; cv=none; b=rChihPeGXXX0HVRdgEyLTxgltPOeKzso0VY/zAh64iJFSt3ggK2r6XzaDh/Ytm0LbemC4oCps6krPtDQ+GP2xWJkkHsoUG5HsVKUEtVPezQPCdOUsh/S86hXQz0K3xFSk/9KUnAJ2bUi+SzmMv+Ujwf2A7rL85mQGmGZ+REAuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968895; c=relaxed/simple;
	bh=Oxihi4tyCiRFwTTtT5PJ9Pla2kfNMBs2lDDv7Z3LJDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSE8a4hSUfYO3Ce4vzWUuttmVVmG0hg4aiMYSVPrFPMq3QWIBcuG5RHEauUB3se/wuc8/ulB+N49Lui+odPmH6RdGucn9LhX0gdKkGBi7Y8EtPVY5ZK/BbJjJ/z48GWWUnuQeP1ZKnvMKJYYfmp5SeCFmBfGD9CYVuvwpwvAl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mCxEg+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+mCxEg+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d027b7c8easo8396785ad.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786968893; x=1787573693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XumJTl0I5Y8s5eBq+8CyvqpDHJfE5sls8hInlodZWic=;
        b=G+mCxEg+Zj6MjF6JCASm3im5/iFH0kkfRvfOf4lw/PRvNGISlgbX1SmqA8n1YEmWT0
         9WRdpnpTYOokxwLxSes971ZQDlu8KY9N8HbvZrCJkWRTU5rIiiqGq/oiQnQlWaTH1FAB
         FIa9IEu+8y9RymQxSwAtYzBMY6+MWfQJluAcqEHYXYQf5AfRuZdL8/bHOmnVz3fIHIXk
         bh9iEfJ1GDDUFyIY60h1RpxplWvZvO8eUiI6LM9n3wO7yv1mHnDzLHyOuHfCl4sJsfnY
         b5MEBsGVH4UNi5VkLAuxKqZ6REGgNsKbpP6HSH6XaczpCDhqYS93q7nvZdUit1+AjrED
         gzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786968893; x=1787573693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XumJTl0I5Y8s5eBq+8CyvqpDHJfE5sls8hInlodZWic=;
        b=WhgF3HBu5tHL8b4ivcPNIlm1v5q1Mzsq0yLC6uMprngoLk83MTwDSAhmbSGAASYY7Z
         FWhkOO2kGm6Gxd8Q5Y/DvKPUUr4MxLSxuzDm+i4RoXzRe68dxKFEH4VqlLy57Kb0tf8T
         v9KrMAthDCiWxvBRIfcBHgRC281P28Xq6nqnPWt5QT4dpRapgrFSFLegvBJyRhNDlG6A
         wWmMw9OXJz71U6XJBOMMJ67gyX3V5tHp0UmX77X3PetolugJYOZtJPBLegxpYckE7wfB
         EwgoMg+K6eHbBbMKpmD+5+rnEUphJ5v3PIs0+OAHxVwsvAgKte1fjYhbASIH7YmWRF8m
         dTNw==
X-Forwarded-Encrypted: i=1; AHgh+RoOpvz7dFLw8G3EiUuiRUcouuGQUQx9zKYsw1vKU0FOu0ZqDZL8zU5tnj6EQeAMNAvmKA+xUnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKl4315DmGkNFnPHv5T044iVHI+YBF9PY+5uqEAy2JAWJy7DQ
	RleD9NhBf5/mxYU2P8Mb5TtL8lFKiwH78egbuMD/kSKEgExrnKQr/MRH
X-Gm-Gg: AR+sD12NUQYBOp/DIQp/VEAnRM4mkqiCsLKHyoyOUpZ0/2ibdIL4LCDE9rcwGa4rG8s
	jU306Ymi51PixhUOULGbIakIAtGwnbv8dg+hyUnu3tHzrt6r45Qm+2sRM9O20J0pBeZVAvSsu0+
	cI0k/2tNsjcP4K6UkolZ+2ym8Q2ozEExioxUHcB2aozhvwf5/UAnwlxj0NEEpQte4lbzgK6afy6
	5pqFju7nfgA/sCcFRwH6O6SbNBxxF6HsNtrfkRphyhYHg84DrNnOiRxaaFdo/g3sjWcoFHnseN3
	cjHYenmWZ0qH+j7IgT8Cs/SbiohvfpRIdUjhPIXsR3uAoARnlOVYwc3rDnfNg1TDATvRRrT70+W
	Ipkp7zmkYOQ1Kw7pymHWhpTrNfTjaNg2+pOcAULzcjVrUCGEFZjWUsQNfheWy52FEWNWiB5A9PU
	l+dOmwZlswFr/5nL0i0o4107S/CJn+JmDXeWisbyxiDAdfLHVLoxw2GPot/L5M3NoDtsPNDzr8O
	4S3BZhOlRdZIOthFA69SzvY93wH9A==
X-Received: by 2002:a17:902:ceca:b0:2cb:2b50:d9da with SMTP id d9443c01a7336-2d3b0dc5c4emr200745695ad.3.1786968892964;
        Mon, 17 Aug 2026 05:14:52 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e543besm1821135ad.41.2026.08.17.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:14:52 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: jk@codeconstruct.com.au
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	matt@codeconstruct.com.au,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	qwe.aldo@gmail.com,
	sunyiqixm@gmail.com
Subject: Re: Re: [PATCH] net: mctp: hold a reference to the route device in mctp_route_lookup()
Date: Mon, 17 Aug 2026 20:14:32 +0800
Message-Id: <20260817121432.3586534-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <55cd94e61d68d95e9db16f21980a532f4edf70e1.camel@codeconstruct.com.au>
References: <55cd94e61d68d95e9db16f21980a532f4edf70e1.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jeremy,

> Hi Aldo,
>
> > mctp_route_lookup() uses rt->dev without holding a reference on it.
>
> [...]
>
> > Take a reference with refcount_inc_not_zero() before touching rt->dev,
> > skip a device that is already dead, and drop the reference once the
> > destination has taken its own.
> 
> This looks the same as Yiqi Sun's analysis:
> 
>  https://lore.kernel.org/netdev/20260731022926.913865-1-sunyiqixm@gmail.co=
> m/
>
> I had requested some simplifications for the proposed fix, which would
> likely result in something very close to your contribution here.
>
> Yiqi had not followed up from that review as yet, though; so if we don't
> see any updated patch shortly, then your implementation looks reasonable.
>
> Regards,
> 
>
> Jeremy

Sorry for the delay. I haven't had a chance to send v2 yet.

I've reviewed Aldo's patch, and the approach looks good to me. It addresses
the same issue I was trying to fix, so I'm happy for Aldo's patch to
supersede mine.

Thanks for picking this up, Aldo, and thanks for the review, Jeremy.

Regards,
Yiqi
