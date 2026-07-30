Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1233AB47A;
	Thu, 30 Jul 2026 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455594; cv=none; b=M+MBmnnOlJyxLStnirFv3E5i019dgfKpg8Cgd4OCAKow1izJIdP4fo3dv9eq/dNmg2H9HEltyvjk52tQoNED5d+hJAr95wRNt9nfF/syzrgS2hGbjcfLCcYQbWhOy4nAB7MRS6yUx3HyuZu0GI9Plgh/AsyVzBTDhgFsFww8Vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455594; c=relaxed/simple;
	bh=2s5Vvi76CoVnbWZhzKsfBUCdIl0PJe2It1zlXLpxWy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBZjJpiaVACUuP4x1l5HzTI2w7z7XM2hd5ZZ1SrmRouE1iR7L/34yQqe73hYAp/V6XOUgLOCaOUhuchn26r1Lwks8Y1x8gHvT9/iPetloW9pcP46ieQO6sH6VovAaKwigg5yuTyDU5ziPuXPn3oRl24ayC0+0PlMgo3w8fsagfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaDQYqEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaDQYqEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDAB1F000E9;
	Thu, 30 Jul 2026 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455593;
	bh=yekPJtQ/HKN1KxJKL79pejnbw8t9jCzVGqxMhycKleg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TaDQYqEF6gCw1dji2g/MFKwz2+9ikzgV0aeXuIf600oJIfwv7/f2YIs1eYx1mm62w
	 /Kaps0cySjwZDz7ANKoGN5LLfi0+msvxRJQTgqKRwjc/5ZDLLsC8Bs9pZLSOWnsr5H
	 F+pz5bSonwRFr8Ret7Ns6BkxGfNHblJMcL1wNmK12GhX/pklfAUJzit5k3VSoZnO1I
	 kPZHrwOtmZ27pcACEEgbQFIMl7B2bTXqxMvvLru5uc3K8nUnn68w4yXyMd7tJ0+f6o
	 R1LDSmKAiYR93HNYEIidZwjYJcvNQ2Zm8b6bqYiIrn2Q3yeMV/S3Ui4otIbBrRzEhH
	 EOcy+OfabEguA==
Date: Thu, 30 Jul 2026 16:53:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tim Fuechsel <t.fuechsel@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, fmancera@suse.de,
 ebiggers@kernel.org, Lukas Prause <lukas.prause@ikt.uni-hannover.de>
Subject: Re: [PATCHv4 net-next] tcp: Add TCP ROCCET congestion control
 module.
Message-ID: <20260730165312.4b0e8d0a@kernel.org>
In-Reply-To: <amHMvwtUk6CocMBr@volt-roccet-vm>
References: <amHMvwtUk6CocMBr@volt-roccet-vm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 10:11:43 +0200 Tim Fuechsel wrote:
> +static __always_inline bool is_in_min_rtt_probing(struct roccettcp *ca, u32 now)

this seems to not be called, please remove

In general please remove the __always_inline annotations sprinkled
everywhere. Modern compilers will inline things correctly, and it
just hides such unused code warnings.

Please respin for this and whatever else in the sashiko bot response
you consider worth addressing. Looks like TCP experts are on vacation,
maybe v5 will be luckier.
-- 
pw-bot: cr
