Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32D329C4F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769731086; cv=none; b=CI16uzHOJ4Ojkw573wPJISaCzGMcdAJdXddreMHaZ4p9I1jTCWS34jzzGmL7RWFNoggr9FRhIZMzCkBkOnOQDaCqqh3usTdBmgmkQz4s54Y0X1EFq6hhTXTq+fQxGk2FBIU8FPM4TI9xJrtHnKKGz+m/xz4Aj/Evmq39ziA0NNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769731086; c=relaxed/simple;
	bh=fkkeinuaFYJ4hsnWxfVzhlTOE0z38x6eOGNeP707EFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgcdfFYIye7I0eJ33h1NsnpEh/QzivG1EtzkIGV/eNejp4YCW/u7cZFp8qxBluIT6PC2E6w6qRnYicu6UEtkTgyuksuk3oLAf7cG8Ral8jJXRzy7VcZwXfY0JX8J3WvZrrwcMqZdnn/U+w/dYCv2Vkmrib8eLPjEdErlvTuGhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhZKFI9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhZKFI9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83163C4CEF7;
	Thu, 29 Jan 2026 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769731086;
	bh=fkkeinuaFYJ4hsnWxfVzhlTOE0z38x6eOGNeP707EFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OhZKFI9Lqgv4u6kLxYYA4OeRjv6kuer51uM2OilgqMkZ90z+nvtiiT3ESZAvu1mwk
	 4OzsYa35vfbtmlMXX5aDfe3l6QrsZnaZfCzdYIdbVAeOJEiNSbjIC+ETkrkqtWLGG+
	 /4hyBx8frcb42IZuyeJHIc6tj0xrL9Y9xcIXX+Xw5cnDDDbzqtUvPpn8LQ4m6tu6Q9
	 q2Zg+Afw7EizUUivpteeOnHBainc+6s21dtJx6EBLFuY1Yx8xByx2bDaTey/ldU7lx
	 iHNMiXkXzx2rXU7XSwIKywcRfkykae1VHWSMS2/UgOGg83jD+w6PMcHxj9pRDt9dZ5
	 /7IInMv6zMlaQ==
Date: Thu, 29 Jan 2026 15:58:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts
 persist after ifdown/up
Message-ID: <20260129155804.492ca32a@kernel.org>
In-Reply-To: <aXvA11H0AvNcjaWJ@devvm20253.cco0.facebook.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
	<20260129061646.1417185-5-michael.chan@broadcom.com>
	<aXvA11H0AvNcjaWJ@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 12:19:35 -0800 Joe Damato wrote:
> >  .../selftests/drivers/net/hw/rss_ctx.py       | 117 +++++++++++++++++-
> >  1 file changed, 116 insertions(+), 1 deletion(-)  
> 
> I feel like this one might be net-next material since it is a new test and not
> a "Fixes" ?

Quoting documentation:

  Co-posting selftests
  ~~~~~~~~~~~~~~~~~~~~
  
  Selftests should be part of the same series as the code changes.
  Specifically for fixes both code change and related test should go into
  the same tree (the tests may lack a Fixes tag, which is expected).
  Mixing code changes and test changes in a single commit is discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#co-posting-selftests
