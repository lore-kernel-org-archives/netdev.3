Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E4399FF
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311440; cv=none; b=fdXJ3WUl4WTDN5Ub9+HJ9DE9v9WioAlx+9uKxOBPS/rBdahBrWlgAECVZYVm9BfxIub92ivNJLHPo/Qgy5KtCrTtEHkOji3XFQKmfGY7vprs+R00go3/4+Ttnuqwms84iTDmIt3VDOb7v0q4UzF1/Fxex9GO6dxxftQG/7Don6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311440; c=relaxed/simple;
	bh=pB/iasdouCgv5+/m46LVzlmorsCQMcNvBL6R5iWICCg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eVhKE6OJPE3zIuWqYl5ZLntih6ahusuNsFclLzGrQmr8rhQGBqGOIvss81+SwPgfOyUl4rRoP26FAAh1Aj8eyXfUbVE+8njhm5m8dqFqCkWdhzeFB8T/s0cGBvUr/AVDk7Tdbw1Qx4S+HbFop2R15tilMUl6tCvNMsrCRxE7vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2w17lJS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2w17lJS"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e8fa1b8d6so10167727b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311432; x=1785916232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ArooMk/BeNv3RVej5k9pLl6zc7N9gWRgmh4NCVP0KIM=;
        b=Z2w17lJSYZFTIVzMxTYRunl6TQO8p+XiNkGZsMmEsmWy7fkmp2xKA99OCI6wsfruPk
         1UeLVifBdzz54q0hulqCGvNucLKqqFkEKTiz/4hULDqPhGrnP8+f1cgGgKcg0/RtK2Hu
         cjmNmOarZ20UToBznkASC7F0qr/mtGam12WIRA+VwNIVuL/4PRUb3Ek8SNpJ2p9Rfuxi
         ixEWAYlxdi20GCxjSgYF9ewU61fk8zf5y2Y9Y5WUG3t6llN1ibMQPu7Fwoa4BOoAdQWE
         xeEm3pGO7AovXMKpMtyfRbMAfmJelIDRoI9q5655C7he+sbY+ZyoD16kPwEsY/zL7OcJ
         aQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311432; x=1785916232;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ArooMk/BeNv3RVej5k9pLl6zc7N9gWRgmh4NCVP0KIM=;
        b=BoDWP5oCrGuKeR1j+LiaGbxvgxUpouaMevA/ublX06u95i1BqOZU8lWRP0kbdQNlLJ
         UZ+z26ZNY84vByjc4s9xlOoybud4t3DZ1Pm291Pa/Hek+kkYq+yz27eP0HWOpUb3ekiS
         eMPS24AiH03wprdM4O27oe2rtEif3ZoAjCtVWXCtlPfWAtlxwMCXUiKTHv2IsgFRcovA
         Hbi0bVmSrphX6IDSnjwIjYWBzK2ukeGjYmHdBoIqtrDOn/+sarxeSrmyx89TRVKSJfeq
         3Q16CvICiTVgqQCspTDkYac8rqfd8W+PaAc0Zn35BjaYSewRf3uqADA33y0Dt6wI4LG3
         hRcA==
X-Forwarded-Encrypted: i=1; AHgh+RoCbXaLCCEbzp9r1PI4piIBdhPwy5l0yY32/AUdKFoovfE8h9lSPU2DuTTBV0ghe1aNru6hBIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9Mxpn/EocUMeXvDQ1r7U0NdXGSiPPsYK+6NKcl11X1Lx/N8O
	9wPCbmXorW/1HUiGN2Gf1YX0rOxf6K+e998IjAcxrOrCPZvxvR9xpfuW
X-Gm-Gg: AR+sD12pal8cAnqNL3z3nSAKdrs0H0H2HSTQKnPionROXz5x747ZD7DoxAxMilAQRYk
	5jAmPR7YqUnJGAbvWKp44Pzg0ntCZJH1s+KzfLcy9nFWtxXcGMEijKim8r71U+zeEbdwVsBguHb
	v/6a5mA8s3vaX+TTIPklv7dpySZzstvJlJrvdm0tRPKD7i0zojtCOqhIRel260pwP1ffbk6DCIV
	rDwp6Q3FcK9X2tDCN3Ku8kV9uqeZZEYE8bZQoy/oMbsFWGFag/moeztsPcg88XpDxity0Dj8RjL
	WQGFuYHgyIoKH7DnYAXGCSi8xY+vp2clNeQXCoarZySBnNV8009Hf6w+mSz+UJjxpP8bGdnf6lq
	dS0EKVVLuG8BVs8+vs4NU9Ue15sMm7iz4XRmYHaycssaejCUEdPkUgvnloVnJHmuuume6xqjWN0
	vUZAZEQIg4DM71RNND5mrWm/YDnWvUBIhhTmx0ZyKm+hrAEOeif8AJ+PHTwCFM4Joo6sPDHQGgx
	mfbPbYj06ayf/MA7JKCy/njnGjxzBjNaZwq
X-Received: by 2002:a05:690c:7245:b0:81e:6d9b:156e with SMTP id 00721157ae682-81f99376184mr29288167b3.47.1785311432078;
        Wed, 29 Jul 2026 00:50:32 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa29b5fe2sm13394877b3.49.2026.07.29.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:50:31 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:50:31 -0400
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
Message-ID: <willemdebruijn.kernel.e3202003b46a@gmail.com>
In-Reply-To: <20260728160935.4128982-5-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
 <20260728160935.4128982-5-joe@dama.to>
Subject: Re: [PATCH net-next 4/5] selftests/net: psock_snd: Verify sll_pkttype
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
> Extend do_rx() to take an expected packet type. Existing callers pass -1
> to skip the check.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
