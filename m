Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534222157B
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791349402; cv=none; b=iskEqQKuJKfe330D3YAmM+y2UgjCD/Q12mhsydkM+zJbcDZcvEpZ1t9UzteLpdc+jQ1fotqHWjHrhE4IROr8msTnEFuiswh9H/3ePcpgjvCAVsKi9q0jUgajHOq+5lW4QN9I+l8gp3RIqpikePUHEU1P/o5tNeqfqjFfKwJfQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791349402; c=relaxed/simple;
	bh=8YvS4qDKbr9csvIpveZ4IY9tAzTMs2t5frXjZc+BHVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzOrsGksyTYtirPQkZXeevxnc92/6J5EDJoFK5RO9S9RkNcL3ab0ZF3QW0EE+6bBTlCWrjrhsFqn8nrJGVTmL26ViUOJFfnT7GRfrGOjW8Pzd0Bo8WlYBFocwBgyKwev67azD+qPO4OVGySTryxMFQULa4vV2fr+saDf+gkKzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvvPxO2L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvvPxO2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDFD1F0089B;
	Wed,  7 Oct 2026 05:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791349401;
	bh=h/DxkkkP0n0gPAlggMulaWhrMeG63/6hMvFKmEeNBqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OvvPxO2LOR8qybYEDnbAUKNI0SBM+IzaDjrJQVAZ0AEkAiZr4Ugyh2uaDsjWFTwKz
	 Vo954psZgNZC7+jn6LxnUKaBShPnLqFuNDBS9TrYvIV/qR67YitO567OG+QLTgWvFj
	 ybCB3wmDm5c0EoD5otOW43LFvFzAEbrkdwYfpgDKZULcMzEXgv8VLNeVQQxGCq6sID
	 woLGQ3B59IxXC/vCEdhKaEVrLiV977a8VW4fa5XSa4IDSmVcgE5annAx4RO7jpdX/Y
	 MZ0R58LWh8qndK9Y+gynvMYuZ41njuPY29Jk7C3DbneTjA0AmYC2hr6/gHeb/77p3l
	 jbmAKdXqt6F7Q==
Message-ID: <9f688c24-488a-4862-b8fa-7a34750285c5@kernel.org>
Date: Wed, 7 Oct 2026 07:03:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] flow_dissector: avoid u16 truncation of hlen in
 bpf_flow_dissect()
To: netdev-bot+sinfo@kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20261007045616.445596-1-edumazet@kernel.org>
 <179134921160.2527009.6970913813334453403@kernel.org>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <179134921160.2527009.6970913813334453403@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/26 07:00, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.

Changelog stated: Found by sashiko while reviewing the commit above.


> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

