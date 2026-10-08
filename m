Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C9654704A;
	Thu,  8 Oct 2026 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417901; cv=none; b=YT33QKMKo8bVVAE2KatF5l5q9bunCHeAhGBcq5bQcG/xDMzzJe5nlLx86JU0wEwP4EY/UUZMfPGuhpNLUaJ6gsIrxrQp3vjDGppDBE6wzemxv2q8qYgMPewigoPc8R0Tbo4DBdQ3gXijURozhzZnjCUvHzJ339YHavgHDz662dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417901; c=relaxed/simple;
	bh=RcfRKaRt1ig2OG8yWyUfZwt/jZjP+i+vf4jLHTwPBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tT0Imka75R9cZMPQ3SVcYh47VQw9dmOkGuyzRU2qcgIIVJq2Qejz6Um20vbtiGtZpndpFWPZSikz0aGhf12gWbe25HxXnnUAHje4Jpj6s8fCqD04CgPR7VCt4ROw8H2OnvzjITNmy+sFYMSVf2XW9bLvj/V1AG4yNFwd7MGwqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LobjnhFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LobjnhFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674E41F000FF;
	Thu,  8 Oct 2026 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417899;
	bh=b4NhxT5pjkWgc6bgAlrqz4GSGXCb+Wnpr+2c3DRhsmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LobjnhFEn/u33bTsInQWOHBxnjQ90PdM6jJDN/0+2zGmN26W988v1NhcIutPlXjuw
	 ZzoRdc0Cx+L42gcV/OfEJpxducGrD7nnFbDgeGq7mqEMKT9PGDtOIPBiI+SnVuTAhU
	 3+LSr9SSWvytfR319TJYM0NELHEkfxuZcktgMJSDt1ORfnHSp59uJpBBDyUlUBL+lQ
	 X7SAVYOq7uOzDBhSNCDNLLLfN7HEltaF1ZfppMLByJux9wLb+7esBTvUNn2J0bbsks
	 3Ac+kb2g7ehZlKbbW8niuNaSdShzzqDSra6dXVI/PhM35XP56sNr/Zt+5EsFW3R1ic
	 Y33LGxaxE/J3g==
Date: Wed, 7 Oct 2026 17:04:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 4/5] eea: unify return code variable name
Message-ID: <20261007170458.3699232e@kernel.org>
In-Reply-To: <20261002100035.863275-5-andriy.shevchenko@linux.intel.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
	<20261002100035.863275-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Oct 2026 11:59:22 +0200 Andy Shevchenko wrote:
> In one case 'rc' is used in the other 'ret', the most use 'err'.
> Make the latter use the former, id est 'err'.

this is below the bar for things worth changing in someone else's driver
