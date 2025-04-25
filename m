Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071BA29
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745544996; cv=none; b=tK/UI6ibZkFLmv6THJ5ljz3Dd2KQp5xsg8zKzKffFxcUgUXJ6iKDlNOg99CfBI8EokiB+dzQYigyBiBgondtRIJdA4XIuW2mK0xqKyzbWuo3m2iRzdFqHY0Z7JE5Wm2yi9cBC0yu423S193hH+VFB2UhYqb2CYVmMb3mhBqpQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745544996; c=relaxed/simple;
	bh=3k9hDQLsnP9h/bGwcs5dTU1K+K9VW9JMJKPxKZKK2hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amTrrBPWr8y0fUqZRzBTvCfdhgpLzZVCPsyi0nPtncIxgVThO5v5ZeP1EOfuTRf5HCmp/02aVgic59vhyL7qZUgVC9FnWbpJlp7X8JQhSP011RhNtLPXM40yFqMpwWEvy9Vai7Rq2Si5ROLE++GugZ+ucq8IiFy5DkAzt79NnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBqeljDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBqeljDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39EDC4CEE3;
	Fri, 25 Apr 2025 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745544996;
	bh=3k9hDQLsnP9h/bGwcs5dTU1K+K9VW9JMJKPxKZKK2hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBqeljDn63LP0xwCEG0gqdrO+zbmitzJj1qsfDBGpLfYsjf0twkmC3zKrta2wjMpT
	 AEPoqSXrFNwYnF0JOpc89ZbzKvGefYaK5hcyG4Q7gou8QBvEckNUSGGVD1l19zDpiC
	 7GKOEu+59MQTDZ4WKoFvyslxpYFtg/dNW9+ZSDj+EGfF6B1FauRvR+OjDhuTAwYfFJ
	 GXqkVox7lt4EfU/K+09kvA9ktS03RutF9G72Ngyn+14BVcdqFcFYXQa8kaR5BXe5r0
	 1clKDFEE23KhJS4zwyl8xFfgjFGaodweVurY7pa19iHFp/T7xEpqFWBSNgvdITdK7Q
	 /KCtsO2aeFINw==
Date: Thu, 24 Apr 2025 18:36:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shankari02 <shankari.ak0208@gmail.com>
Cc: netdev@vger.kernel.org, allison.henderson@oracle.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] net: rds: Replace strncpy with strscpy in connection
 setup
Message-ID: <20250424183634.02c51156@kernel.org>
In-Reply-To: <20250423153730.69812-1-shankari.ak0208@gmail.com>
References: <20250423153730.69812-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 21:07:30 +0530 Shankari02 wrote:
> This patch replaces strncpy() with strscpy(), which is the
> preferred, safer alternative. strscpy() guarantees null-termination
> as long as the destination buffer is non-zero in size, and also
> provides a return value that can be used to detect truncation.
> 
> This change is made in accordance with the Linux kernel
> documentation which marks strncpy() as deprecated for bounded
> string copying:

You need to explain why padding is not necessary.

Please use full name in the Author / From line, like you used in the
Sign-off tag.
-- 
pw-bot: cr
