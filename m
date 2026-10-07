Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A144A0933;
	Wed,  7 Oct 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384227; cv=none; b=lSjcms0ZkqgTOk8FhMFBpwA9NNNvJW4JBkskUegddMxjsb3su2nmCWFZ4nUb/IgcfIAeFC6MN/1vfGETur7arDqTlzwbEqz71fgEv0o0a8XxB2h6sU8SR71UUyPM//pDHWbKZ518V5kMnJbiCb+UlWYmynTXn/w3Pjtz+T/QZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384227; c=relaxed/simple;
	bh=827yZvSZ/Jw+AMaGWjJpgib56Mzmme9pcgLVZJYOhY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGNSJDPXDHI3EyvzXicOlFtUe7f2emg30uhuJSUTI357r9uhQJB4E9zx0nsnZHvoXQgTxfLMmpgg2ideLEGTZTuNEbP05OHaTDT0xZG+iY+8XTTDbXq0KzWJTilD8zVThUAcUHBg1l1zz+WZ39GuzitUKVRccXBZUo7+cNcjANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3e2CJCx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3e2CJCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36641F000FF;
	Wed,  7 Oct 2026 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791384221;
	bh=V/D11OxCCnESrHwXZaHU+AwMeE1zzfD9xs9fv1amivk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h3e2CJCxevs003Ycc7FtKTgkOsd7ffontnosLwg+qh3RPVmijoQPUimAWURmGEAJU
	 TuPhjYuGA35p1r5+QxhFusHprWIeH3ZmTWPNqPQAphW0hhn5+9YE9GufL7nao1oSOS
	 bu/x6w1W0bpWaMul1TSNnaUc7+olnjYZARbQGcHSkLSq/xOCulSy2JK3kpdOsM19AK
	 XuW7ILs5UyPd2K40up25FYZfWbEkWKdKxY4s4qfwNTErAZW/am6YeVHJn7WzkvB3d0
	 OQKUIn6ALP5dISnEaZKEMh6dGhUoO/5DeWBy4LUTTBOw1N8LVSenNWU+F8f2C7pfkF
	 yMSuMKx803Ylw==
Date: Wed, 7 Oct 2026 15:43:34 +0100
From: Simon Horman <horms@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>, Yicong Hui <yiconghui@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, vkoul@kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] net: ethernet: micrel: ks8842: use
 dmaengine_submit() instead of ->tx_submit()
Message-ID: <20261007144334.GR83879@horms.kernel.org>
References: <20261002193022.168248-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002193022.168248-1-Frank.Li@oss.nxp.com>

On Fri, Oct 02, 2026 at 03:30:19PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct dma_async_tx_descriptor->tx_submit() calls with the
> proper dmaengine_submit() API wrapper.
> 
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Hi Frank,

Is there a back-story to this change?
Is it part of something larger?

In face value it looks like a cleanup to an unmaintained driver.
And if so, I'm not sure it's worth the churn.
