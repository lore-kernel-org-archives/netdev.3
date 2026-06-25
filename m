Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACF22D7A9;
	Thu, 25 Jun 2026 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355599; cv=none; b=ttH+C6BdhPUQsDWNdKvhlQujRG9aIyqkQcCGFOj1SGfvqeLFENp9K0pTeGuCBd10cCXCSumWQGMNs3POWlKOpnPHu37jrrusHH7qnAVzg5HMZCjHf+xwlHkleI+kzoOOOQHku05ElGESsZXQRh+E3p4kHHR+42egH9WFh3go/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355599; c=relaxed/simple;
	bh=BhzY+rbfs1JEflXE0RnwVSiR6UjR3BP2XZSAPZGKsxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X++ygu61/stdRSdKV+N+ZTOm4n9NyFtTWp0xCHY6PPhcAMhEj4PnMFKscCo+TQ6IPPfa0yioyBKsAXIWxec2ZXEWt6hJVROTpj5WbTlxB+RKgJaN+XxfImgeT/rjEQ5F4cFsE6iyUs58uZ7MZITxD7OK1NUI7xYAzVWuT7GDh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp0oRg3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp0oRg3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE4E1F000E9;
	Thu, 25 Jun 2026 02:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782355598;
	bh=qqLSgi8tZ+sERewRYYSbz/rljystIb5K9oefx4Of0ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kp0oRg3s+3H8r8m+ZpvKw/98d0lCjuDOKnIatwbX2sAltpkHMZDJEcv9sgHscCn9c
	 YEy/VppRdKc8AamXDZlVZcPKNtWDw+aFDDnlI69bdw+XGi97BY7Up6BMDuGD2Xwvfy
	 PeAxHRgR5gsOguaHipSHchCzBDXxDa9nEDuiH40sreUvUhaFK41IpimUL80jd17ITz
	 KKysud7FR4U6suqPu5tJbHs9jE1E0m31mgZ7Uaz8E7eVsSSOeEA54Yd8M4jyn9rxz9
	 W+hmJUNvTxU7toxSHb0kjyRl43EKh/KJFvcV78bcZVmX9xMk8v8X4c1BpF302pJwb2
	 DAGv9XbLlcrbA==
Date: Wed, 24 Jun 2026 19:46:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: madalin.bucur@nxp.com, sean.anderson@linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] fsl/fman: make enable() return void
Message-ID: <20260624194637.51158fd8@kernel.org>
In-Reply-To: <20260625005600.3400023-1-haoxiang_li2024@163.com>
References: <20260625005600.3400023-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 08:56:00 +0800 Haoxiang Li wrote:
> The enable() helper always returns 0 and has no failure path.
> Make it return void and update the only caller accordingly.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

