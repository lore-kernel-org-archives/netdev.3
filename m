Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A657286A4
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412221; cv=none; b=gD19zY9deBA0DOy5nF6rA772hBll5YhQUhkVmrocMn5RFB0ya5ZQXIfkaaOa0HsZ5cjI8zG8BDPEq738XwgEoovr1346bgCY0qqkxVBjRY6NOzODVqoVRW7kpIrVKDf0+BgCKxMcavQnr22YCtcZRHgRGDx46hYiwVDVSrXro10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412221; c=relaxed/simple;
	bh=12EUdsbFiHBURzlJjrzAK8K4NZINHomEF0ijgoIRkOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxAyjUEmocoRk7y8mL+IwR9APKDpKT0/8hXJw7APK1NBfXjo2RYH2O4NS2PK5TDG+VYh20VjfFeGpLSXCbmJtr6G4Yf4Dvta16OhVULK76j6tPbWeDRH555oIpGIXP3wIGhnhig9voGGSt9JY53c+JWnoMgbuoYC4YkR6cJrffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQ9waO3B; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQ9waO3B"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48877902c99so1383437f8f.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412219; x=1791017019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCwVdOxjrFD+KrFGvyZLlA0okXbQCYf9gkSOoPwm8f0=;
        b=sQ9waO3BnTOzJMYOCXCLbcxZZobeBoAgwyUF4n0Itanw/bT0XnLu0IOpdVYUqDMUuY
         CnYvDX+CzGQAPCE9CBJl/4b9zolIuYpJdWuzZZP/X1bfrfu3VV856s+xf3mp+oW4W5zs
         c1u39oZiHrZBS0alTPpBNkqJ6VlGFu8rTRCMFgsBuJKJrxw+XN+ZLHC3z5fa5R635lLB
         0eSu9NAao1vCpTbLcwWb9F3I1ThGBdLeIf2TNcjEXTMRYY5UHGZatJHphdTfjGaa4xyi
         PayrediRnZ/8NO7cBojsw9lOfUsUjNUq/k/XM6+hAvdfDehzQlgpo/9tOOIwoqExXVjt
         VKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412219; x=1791017019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCwVdOxjrFD+KrFGvyZLlA0okXbQCYf9gkSOoPwm8f0=;
        b=r8B0v3AjW5qbCmMIHeJ0EOpzKcMOyxnqca8mDNEUqrS37x+VsnbBJlz576yCqJQVPF
         Gv+stR6jA7H4GmPHTbHfZ/oX8X5ozZlc18Xi/ujtt4IG33vZFPiAB8aBTj+jPCoQEpXc
         BVjiwgk1Sfud8X8yuTZiue6OgiSP60+0cSAPfgT1Fu0gnZaNz9HSI8ZiKXxFz/XExQ2a
         m4fyrauHUkWc/HygKJKruICaBGLEYn0DR0TeDbba0TJen7dsPBde5ymBbbie3t+xn5V/
         0OPbgezw7lJXmJkwKUbA4zEqB26MgarVTFkPG7MMK62lpol7Q++vrjkaRFWuPu77K1c0
         pR8w==
X-Forwarded-Encrypted: i=1; AKwUvBzdXCHr30SIGDTR4F166L97Hb7nXXxGO9CAmDMyWW8tMYHkCcf+Pa6jDt4Y6Eu39w+ioOR7rKU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLroYcz6A8qqJ5w/8vUouatKZ4FUuX+0mypllu/WetZCevGzuZF
	BxOrgP5dNljuRRFWegyxV54SBhERyzXNw8ilDvnOuXDpOsK0iZaI+cu3
X-Gm-Gg: AYBFou0qNaTl7vc4TrB/Hjk4nUky6C22BS/6ZEPMD9pW8lTye9S4FhBSw2CAEohAFiT
	gMUq5Hv80TAeGe+PK2ka+u5qL5IcNHelJibVeUoW3EVh/5nX06coUIHzkyU7UGZHB7W713zwAh9
	2KnLlHQzjTSPrqPSnPDXPdp4VorEPPre0+cHaq1txnYfEDHSnX+EpQ5FlFGBUzdaUBfEq4+wO3R
	tSnGL5woNYV85Khl4q0o8FlywyqybKn2Cxj6ZNkHORlvt8fiOANKCf8w5t4uliGc/3Os31xwhm5
	+J1iaitdGhQbDauUJ6g09IkYBe7n+Hph6Qhoc8kQwHp4wDbzO6aE2s1tWBgCcXYpRdzq931/e7P
	EPVPXFjFBW9QVUlxGq+SgT4DXyMSsNwSaf2FisA3LmemosdnTGkdq/QFqwGIA3Mm/Z8gsOP+Nzx
	NtJXfjQcB5s0d3eTR/RzVj2gz0enRFnvyqUjxkYC4pmU2H4xRupl1KbTqcupaj83xuXzbygtx+k
	oRW5tVxqB3dUJDT7/RVOrava0hjnEEW/wL9qYZHI6QRgYKME36Firxu2teuFbmPOG1dqi8//Aut
	Puz6sZP3YBFTqznvF9MiBd5fkVWMzKzFI03Lp0k5IcJZjeDv07U6OXyceEtjLffHtnnxbOnOcKJ
	pDWvG62NFzSOi74K36f4kqA==
X-Received: by 2002:a05:6000:1a85:b0:487:ee4:b5e4 with SMTP id ffacd0b85a97d-488716b6cd7mr15679810f8f.8.1790412218418;
        Sat, 26 Sep 2026 01:43:38 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm12979497f8f.4.2026.09.26.01.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:43:37 -0700 (PDT)
Date: Sat, 26 Sep 2026 10:43:35 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: Stop selecting flow support for
 KUnit tests
Message-ID: <areFT_yfInT01o2r@gmail.com>
References: <20260925192510.93840-1-kmehltretter@gmail.com>
 <8edc4e71edceb124e2dca233cddb75e198b53a51.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edc4e71edceb124e2dca233cddb75e198b53a51.camel@codeconstruct.com.au>

On Sat, Sep 26, 2026 at 03:53:28PM +0100, Jeremy Kerr wrote:
> Hi Karl,
> 
> > MCTP_TEST selects MCTP_FLOWS, which also enables SKB_EXTENSIONS when no
> > transport requires them.
> 
> But we want to test the flows support, why disable this (and
> consequently skip the flow tests in the vast majority of test runs)?
> 
> > Remove the selection to follow the dependency
> > rule in Documentation/dev-tools/kunit/style.rst.
> 
> That suggests "depending on", rather than removing the coverage.
> 

Hi Jeremy,

Thanks for the review!

OK, I can change that.

I was confused by the existing !MCTP_FLOWS fallbacks, but now understand
that you want the suite to retain full flow-test coverage.

Karl
