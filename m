Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09331ACED5;
	Fri, 27 Jun 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053710; cv=none; b=R6bifqOuIvIAGgcL+dZzaI+i/AxBnfCiVo+e2LgkRzYSu50evHE42UfcO+CV9LiY4jpq0Pg1g5Y8PfjcySontQagB6b6n4j8nH3S8Bp99HKLQnjVHo5B9eIRzD3mhjqn10nIsrQ8CpL45m+HN5L2cNITPso+yhcqIU0xSgAkuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053710; c=relaxed/simple;
	bh=LqxgY1mZIOyQXZp8pJT83YnznvBj9dT37g+kAnvOH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omfIKwzY7cnnWSLdDAI6kgCpd35ShEuQlwyY0IuJXUtsli7QgPGrOeYLSQS7cvWpAWqflHItPad4yWP8a5V7HW0Rfy09bzC8YluQbg5KAbNvbbKb+Mm0FF4UZqdWddMOxrehEQIDX8erD2HK7qXSVpxcgUCI4IsP1J2sUvL9a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2MSRAk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2MSRAk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA975C4CEE3;
	Fri, 27 Jun 2025 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053710;
	bh=LqxgY1mZIOyQXZp8pJT83YnznvBj9dT37g+kAnvOH2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2MSRAk2IcVTsCnDhGAFyfDQKDnd3C4dmUmUza3SL1uX46RiTO4azxWetRwFK5gSU
	 1JyBpeAK77sviKI9fA10V9sv5NtiGM7dRKI++ljKFJ8rMx9QALzsYfUagjkNz+4Okx
	 OklfQ1sZVXgIUSiVbsmZ6PQhC6D0R5IX8TUbvAXVUXQXIzu1kAs4rM/Gyb9Mt/VkMn
	 7KIQgMGph16gwdFgYn3vxmnnFtWdFQcKfFOvAPMhRDlDzxSTY1KUnrMq1bdyYmgo86
	 SFgSBHMTNOraEHg0KuOpHBceHDGz0gHm04259XWnFaPmBOMAY6QnaGlBH8k1kwwxbg
	 R0akjyGQ9T8/w==
Date: Fri, 27 Jun 2025 20:48:26 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] net: tulip: Rename PCI driver struct to end in _driver
Message-ID: <20250627194826.GF1776@horms.kernel.org>
References: <20250627102220.1937649-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627102220.1937649-2-u.kleine-koenig@baylibre.com>

On Fri, Jun 27, 2025 at 12:22:20PM +0200, Uwe Kleine-König wrote:
> This is not only a cosmetic change because the section mismatch checks
> also depend on the name and for drivers the checks are stricter than for
> ops.
> 
> However xircom_driver also passes the stricter checks just fine, so no
> further changes needed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

As per my comment on a similar patch for a different driver:

From a Networking subsystem point of view
this feels more like an enhancement than a bug fix.
Can we drop the Fixes tag?

...
