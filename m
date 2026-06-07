Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DD11F09AD
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840174; cv=none; b=I0IvlNi5uPDp4ECO+9gOLokVKaMcrLsUpFR2xnGPK/ZQgMVZfvT7j7RRSOxZn9zvdsx05CGdZmWIyX98HbO6cjt4LtyDUnHau6PWZMqyIE8sUSa+Z83x5ItXpc9Xi3lRVTU0YCJZllKZIP5raZSYmQ+L1qNZqvHLTjJkXqQlv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840174; c=relaxed/simple;
	bh=XEmC8cTzKQpgszHArxiOjIai4otMc07eukOUPay4pQU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=THzwCy6cLuc16M2n/IZ9vaaPaEkwg/WN8zF6/70z/erRNK0BkZfsr0jhH0nc4j5QJzIu5OwJtqQP7P4IeGgXLk/9IKticN67agTyfih435OsZ0QxxCNzwwzGXCbjjqZb6YldyTeT0tGMOCeW6lLE8JIOnS/6DTxCTJQpAEB1T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuK4OqAW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuK4OqAW"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e1c3f47d78so36476217b3.0
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780840172; x=1781444972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93wINgt7Upt+lx98SvFQMNbQYg0vszE9BajcG6iLDZI=;
        b=ZuK4OqAWIGLGiIbJbySOub/GRfPbfZyoMJNaKDCCQNI0RoBCX5gHQ/1j7REZGhUmBN
         PyxXZxB3RDOTKRA8wWeFgTy+UZ7rm5IbYhLKCuY7k0QGhOREDvbUSNZK/AhVDj3jMNiL
         K6Xs/T0tIyE+YjE0JP8ju5XadGOSZRthpiNr0aYvlLsqiv3NaSBMcGCFFbDRnMPeXWKL
         l3GPyiK9RXBJCXWZRwi7/AkqZsJGOANUlp7rrHi9hGnB5FYnKTQheyHnS1QU2cW12b8l
         LO8YLKYXn5XF6JdCPDmxAd6wPGzXj4ScZSAz2Jbdq+XO3Wal1+nDImpTVjHc6K8cPISB
         cA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780840172; x=1781444972;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93wINgt7Upt+lx98SvFQMNbQYg0vszE9BajcG6iLDZI=;
        b=QP9A5iQhSAopLVBO37xGnC2JDz5N+3r/td2b9uXLqMZOaXQu8ODQYLef/Vll7b2hCK
         04IgQb+Oh+xA1cChKB089vXCRMjoDMFxcLSKBh4wnwO1FzKgS70e+6ZiFiEPsCQH417o
         d6F0HOq65qFJGJmv4qDeYzx9xsmVQvFoENfz8gpg8JkADlk56Y0GZMcxqxc4yCyeeRYa
         1eDfDnfeoeuGprpAph0wQjYVUL0hl8eM4DMm/uPFu313fsqNa6f68zBSjc2ML/Sa9+Xm
         +OjYQ6WtT18VhymAsl+JTJia7lH6Fal6WCL39EJxGQsH5eaJhk2JYFaYO9gSfUuVr2tP
         TdIQ==
X-Gm-Message-State: AOJu0YwS/aUGe7/RYq8jdVOPlEie5ol489cqU7qTcQCsnt67jfWPdke/
	uA684AGGVpxzbLRDU1oLXNTFOKrn+jAbTDcZSPPM7AF2NNoLLN+a3Cq4RRef9Q==
X-Gm-Gg: Acq92OEINNuHOx1Njh9jxrsAnKFyLKKw5xnsUe0XVQ7WYVg1V8yW9PvkqwJhEUKlVaG
	SvlF64ZC8+YGYIzH01JVcN/41hku0RlKnmyXW2XPjxzIGyMKTOkf10GvvFUxyRLlQYrLxI4H5CL
	bCWA46MGgn1b/SmGgvbYJqcGHUQb3anRcuy0G5gF5chPBe5B9LrvBGXei4XADTbhMo7tmS0Sf5B
	0wyxyQI6tCfaAIAvmIAjTn+bZdG9gE/7cEHFlbVh4D0YROPmv/54U027Yyqh2rF/XKumnyWllKS
	ZA2MFLESpJqTwdn0WHbwEjJh9yDhRpGTtMmPvIjCKjcdhQAFrhcx/bDy9kD7skqUGtDp95KT3/1
	eJ4giVsth1cGgCxLuHwF0Ls6rUzFAXi2U1lYt1OUzRUtuPUsR1+vRy5u1QktDcpAKrXno5o8uDC
	x1btI83PspsQfMrYFVvh6j5xWesFlHW/iAJRxnNPJU6W+MWhMQoFhjiOonKbvEu8nw4qg+2seMN
	Sd9HYw9T8n0qnficw==
X-Received: by 2002:a05:690e:191c:b0:651:d430:7832 with SMTP id 956f58d0204a3-66106dceef5mr10363870d50.10.1780840172574;
        Sun, 07 Jun 2026 06:49:32 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f441f8sm8081424d50.3.2026.06.07.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 06:49:31 -0700 (PDT)
Date: Sun, 07 Jun 2026 09:49:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.ee6597e4f7af@gmail.com>
In-Reply-To: <20260607002401.212976-1-kuba@kernel.org>
References: <20260607002401.212976-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: gro: signal over-coalescing
 more reliably
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> GRO test is very timing-sensitive, packets may be delayed
> by the network or just sent slowly. Because of this we retry
> each test case up to 6 times.
> 
> This makes perfect sense for positive cases, in which we want
> to see coalescing. Negative test cases, which modify headers
> and expect no coalescing should have opposite treatment.
> We should really try 6 times and make sure that each time
> the test failed. This would, however, require that we annotate
> each test to indicate whether its positive or negative.
> Let's start with a simpler improvement. Do not allow
> retries if we detected over-coalescing. Previously the negative
> case would have to get lucky at least once in 6 tries to pass.
> Now the first failure breaks the retry loop.
> 
> For background - NICs tend to ignore the contents of the TCP
> timestamp option, so that test case commonly fails. In NIPA
> having 6 attempts, however, was enough for some NICs to get
> multiple successful runs in a row, getting the test cases
> auto-classified as expected to pass, even tho the NIC does
> not comply with the expectations.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
