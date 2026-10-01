Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540E30E0F8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816626; cv=none; b=kAbnNJtJDGA2Ss4ULmgXaGOv73pMbBBrv0lnIekZHQJIbVaBv/1mvWC63nsVtLigKSZpZ+4xY+lCvdXLXUvxqtO7b5xRc5QHHIHGliAmz9sa0UJ6wt2adyo4xwPYlRxDRs5x67DVwKS/dQnjZqZTTG0p4lAGoenpyLFNniWeNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816626; c=relaxed/simple;
	bh=TedO0BNEDhQ19wWOuNt5kccfwtPB0adfrME76jg2V+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/mjQNIJJrvTzHyGYfGkTwLqsjeLfRzU2OMt6Jm23GgFm9A2HoGUp/VSiNh4XfFcwfJjCDQP5bsTUoMz5rTxMfRwLufIvTYgbPxW+FdcKrpcjs4LGFsRr9NOdyaRu0FgffoycyoC5jIvbEx0nXPIhFxJrBvvRZLd2qNqeZKDxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLfNGsPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLfNGsPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46BA1F000FF;
	Thu,  1 Oct 2026 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816622;
	bh=0GrQsHu0iKqZ40IzN5P6Anm0AcQk1Jc/JrZlkEsU42U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PLfNGsPUALlNq71Q2qvSleJHki2qzQD7YusHwJLOQO3BLCWVZt20ERLKtm1fhaOkL
	 inOn4QcKzs4RvD0GeyFpqNDnNnqx5/Ria97/JFsk2vPSs759/r/dI7zEzKmAG0uAhM
	 TuKVyRyDgVm+C4TAvxZpSbKVwCmmYhlnaRFRK8ByBEW8a+S01jrCUSPJNRovimI6fK
	 61lOTNoVdJ8NVxvjBSH8bxlh7Drr69w23psETf1C64alveJ0QwfJK08mNvMSHtnZhp
	 DkJ4Z5mDKxO5oHZX5f+eJfxi+T+rmI8GhyRFocR6WLnThc0jr8pmANDbbhxuR1LKN+
	 LM/TOopy7IXTA==
Date: Wed, 30 Sep 2026 18:03:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev-bot+sinfo@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, joe@dama.to
Subject: Re: [PATCH net v2 0/9] bnxt_en: Bug fixes
Message-ID: <20260930180341.310e9b53@kernel.org>
In-Reply-To: <179056950861.31693.11019543022435274443@kernel.org>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
	<179056950861.31693.11019543022435274443@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 04:25:08 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Michael, please respond to this and the AI review feedback.
We need to sort fixes more aggressively now, basically we need
to how if any of the issues fixed here are LLM-induced and
expected to be irrelevant.
