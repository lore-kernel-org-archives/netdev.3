Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BAD33ADA9
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723930; cv=none; b=Y7EvLnliSzE1/vx3CpOwIu1VTHBhBpZ6HWmFLIPb8IfcDaNj/OejR7t9uA8upGSLaN5Mb9/Tx8NKlshmSox78ijVwK4gK+4N+4VDOrOjw/D+p77eDdkAEnivIE/U0vzVwI1bp9PnZ4T9mP5GmADgqUb/ZHWaQWee58wkjOIX2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723930; c=relaxed/simple;
	bh=pgzEmdWWL1zTQgaMHpl6WzlmvX7Up+ZMjGVNju/EeGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7ePQRZz90oN4GTv5H36RWBTJZHUYRH1m+bsum+GYUzA4sZpW845UtkZhhQggaDXtkyGsrvlLlvy0DGW+CKcKnWV+2EcxeXr4zKS1Guc12R2vYpFGPlTeeyI3YVFn4XY51VXJYZq57s+gfPlwpR+KDI8JtUknXeLaOc81nnIf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1XBF5d+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1XBF5d+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AA31F000E9;
	Mon, 25 May 2026 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723929;
	bh=pgzEmdWWL1zTQgaMHpl6WzlmvX7Up+ZMjGVNju/EeGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A1XBF5d+1fr8snKeC1OozKAMqcB9ZlMlKvfb1b+Zckcn+RbTJP9Cg/3Humh9dpTsg
	 7m6JAKkyYHxelKaVuyrcIZ8haIQm/IdjIZGxCYnpWvjzYn04HPN3LDVNn9oV8KaUrK
	 Bk2qh5a7iI2oyTN2MBQoAnTR3lvVrgAWBx2VHCPgPLPpIvmse4xMZMyJiniLQtLtZn
	 Pi1RUgzpLPvggKPxnbRdfnvz2RFT4KTo+4D4SwebJc4A8r/K1Ke58AUwer0kA39l1p
	 7S6waBlCdk4/+NiKpni+8Pw8VzKD0xfDEGuiKZ8JBstKp5Gf7gWF59xYkJPEShbfkJ
	 on4HfhW45po+w==
Date: Mon, 25 May 2026 08:45:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260525084528.547fe263@kernel.org>
In-Reply-To: <20260525125437.4061-3-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
	<20260525125437.4061-3-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 14:54:37 +0200 Oscar Maes wrote:
> In my testing this resulted in up to a 25% RX throughput increase in iperf3
> tests in both directions.

On which platform?
