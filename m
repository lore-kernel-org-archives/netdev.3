Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B135F165;
	Wed, 22 Jul 2026 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680995; cv=none; b=qOgsXxw3SqhA+28bUk5HuCHpVIrVLi3OWy2f7Po26Glr8qb1ZC+lxDuKcgRGD6ZVdvtRb/Qtfn9CmNg0mMUOAFaMZUfocezlt0vhUPM2bO80jltOMkCtTenfsDSPBF6LyQs/By2UBhi1SOCJEzOgxM5CEz4WNSMRPdZZphjHrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680995; c=relaxed/simple;
	bh=AkS2E37uHeoBzibaALQpAwwuZ9JWtV9S+hAP6bZKz1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8rdL/SqG5sbJl5VBkvExoVi0X2X4w3JB8Q88uv8rXPG5AGARCkMYheNBjXk9gVeheexrc61ZaLNLDZg50CvWLAN6VcKActkc0prrZjdc1Ijg0NZ8u+6LiK11Beaf127BAW/iAH3x6XSZseltVQGuWk84+cIpo6fsubACZaVqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV+KOgE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV+KOgE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC4F1F000E9;
	Wed, 22 Jul 2026 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784680992;
	bh=AkS2E37uHeoBzibaALQpAwwuZ9JWtV9S+hAP6bZKz1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VV+KOgE/iDASVfwPN3OwERfoppBfo9CUhBUSKcfvBs7+zDbEGuNb4ntefh/Kuv+pe
	 idoqn+5KGdm9xJMPo49C0R8QgNI+piB8TLxaag5N1Tbmh2pPGc972+weN6uGqazfT0
	 Y6c8UVwKs0Crt4yI1L0Lb2Aan1MAMmRVS/sI5FffD+yehUevPNjViBxYuNKHCSsXAU
	 5NHXtqSbOtFG06jbp6ZMuJYor/AkZgkjPoSqYZDYDkBn7Q1fiwICxZY+4dkZfIfItp
	 W9ZbCPp5rxB3E+Nc6z7KJIWNl9mC+o8MFaD7Mkj6hir9UjA6Z5twgvOKo65TXllFua
	 N/sqBpkIBVwpg==
Date: Tue, 21 Jul 2026 17:43:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/2] amt: fix use-after-free of the skb head
 across pulls
Message-ID: <20260721174311.4a4b3028@kernel.org>
In-Reply-To: <20260711151934.2955226-1-michael.bommarito@gmail.com>
References: <20260711151934.2955226-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 11:19:32 -0400 Michael Bommarito wrote:
> Several AMT receive and transmit paths cache a pointer into the skb head
> and then call a helper that can reallocate that head before the cached
> pointer is used again, so the later access reads or writes freed memory.

Taehee, please review?
