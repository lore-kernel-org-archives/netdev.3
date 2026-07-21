Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43140683D;
	Tue, 21 Jul 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660701; cv=none; b=hBzc6EJif4DNvBKwi5rHIY/N/8F/TW8rNdSyy+ehVH4funzYHYi8SoXBlBRC3RbWMbZoT9C3WJPVBIiSNqoXvlW1QUd5gH78VUrnvXF1hcjP6KjYppYhmOTByht3Vs+7jjfPpGo75GzYVb1hgkDHUIfEEeeZZ3qE7A7OkRjWIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660701; c=relaxed/simple;
	bh=a6HOKdcgjQ+ddk3LFmreXS/wdMI+bVKKMHV/nuDdqKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXjMwsVWyVZLYMz+RiNZpQ/NX0jHfoIawzn+gd9AW7OJlm59ITDP6ptrs7/aifv9upQlHDjUHtnfV3IsfnzTzlqxxkYhj0qqddqTKlG6gibKs0Hom2Gx+HrTODeW2b4btmtZM1FIFGrO6yC8Ya5IHn4yIvleVKfd/9dD5gLo1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQDnR2IS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQDnR2IS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777F11F00A3A;
	Tue, 21 Jul 2026 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660700;
	bh=a6HOKdcgjQ+ddk3LFmreXS/wdMI+bVKKMHV/nuDdqKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UQDnR2ISwd1KINsT1uvC9LKZjBUDN8l7Svp71EcAb+kIWKsAfF7TPBI27pJ2FqI3A
	 VYkuQKBc/Ud17skq6OHhaZFmmD/MNRIYb/gqw09wTg8LpeLaOw8W9PrSpxNphRkKq+
	 iJgYvqUdX4gyoKPDZZJaOCYbVVeqTsubMPh3FGkG69Ao2k5Qb1fVnDuK20JoO+hZH9
	 lUtFlAIfSbnTPsFyg+roDtnLNfoBAfQBTwDtO4Fat4D2TGZki0E31nBrSGUZVXtS4q
	 AUywFoqUpT8UxW83u7Qb5+2Ygig4EnKyKfjT3iA8vo3ZstrDnUlGXmdpz5iJwF5Cf/
	 lG1cZN2Gbkwtg==
Date: Tue, 21 Jul 2026 12:04:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: cap number of nodes per net namespace
Message-ID: <20260721120459.17cae182@kernel.org>
In-Reply-To: <20260714170306.71517-1-security@auditcode.ai>
References: <GV1P189MB19881AB5829FF8B0B00EF158C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
	<20260714170306.71517-1-security@auditcode.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 19:03:06 +0200 Ibrahim Hashimov wrote:
> That said, the bearer is a trusted-cluster segment by design. If your
> position is that on-bearer discovery peers are inside the trust
> boundary, that's fair enough and I'm happy to drop this. I only sent it
> because neigh bounds the equivalent ARP/ND case, so it seemed worth
> doing the same here.

Any thoughts Tung? Does it make sense to select a safe upper bound of
some kind?
