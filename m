Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16D397E6C
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505514; cv=none; b=s25XFEqx812oCHidZsa7kOUJV54GicLgNjQwYjOmjSWVHbGBDUPtMI60GKDWxDEof2CeFc3UlIB8njFvSUMvaWaulLUY2R9Vuw7pC8/6R42CtNIUrb7omSdnoOJLzyBLOWF2fSEWy4EyWWiYo+gMtlSC0na+o0AF7+nYsyKFDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505514; c=relaxed/simple;
	bh=I78/UicW+3hCmr69SW5qwZkWf3Gw6hcPflvcdDFYlrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2ODc7ten0Hnfqgj2PAavbrhGqiam/yRJNShA+NC4JgoltoFD59z8DV1ytALiU8hCIm7oKGebfmt41naxARa7Vb5R87FVZSdGFJrP5PwOd4Z/lOnzOqE+UFtGvkThKjm00hHm+l5jC/MEo17Cq3QZxtk7SR704GmsqfFLqjlYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C0DA4E082;
	Mon,  6 Apr 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C62B34A0B0;
	Mon,  6 Apr 2026 19:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pbLvLGUQ1GmcMwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 06 Apr 2026 19:58:29 +0000
Message-ID: <345722f0-21b1-4970-8c45-ef85edf9d45b@suse.de>
Date: Mon, 6 Apr 2026 21:58:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: netdev: document AI-assisted review
 tooling
To: Nicolai Buchwitz <nb@tipi-net.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7C0DA4E082
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On 4/6/26 9:40 PM, Nicolai Buchwitz wrote:
> Add a section about Sashiko, the Linux Foundation's open-source
> AI review system for kernel patches. Contributors can check review
> feedback on the Sashiko website and address findings proactively,
> reducing the need for maintainers to relay the same questions.
> 
> Also point to the local review tooling at netdev-ai.bots.linux.dev
> for contributors who want to run AI reviews before submitting.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Sashiko [1] reviews are already being used on the list (e.g. [2])
> but there's no mention of them in the netdev docs. Add a section
> so contributors know they can check and respond to AI review
> feedback directly.
> 
> Based on Jakub's reviewer guidance patch [3].
> 
> [1] https://sashiko.dev/
> [2] https://lore.kernel.org/all/20260324024235.929875-1-kuba@kernel.org/
> [3] https://lore.kernel.org/all/20260406175334.3153451-1-kuba@kernel.org/
> ---
>   Documentation/process/maintainer-netdev.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index bda93b459a0533fa1adfd11b756a4f47d1dbaa22..27296afb05d3828a350b4ed5c16907672db9785d 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -559,6 +559,19 @@ Reviewers are highly encouraged to do more in-depth review of submissions
>   and not focus exclusively on process issues, trivial or subjective
>   matters like code formatting, tags etc.
>   
> +AI-assisted review
> +~~~~~~~~~~~~~~~~~~
> +
> +Patches posted to netdev are automatically reviewed by the Sashiko
> +AI review system (https://sashiko.dev/). Results are posted publicly
> +on the website. 

Hi Nicolai,

maybe I am missing something but [2] isn't from sashiko.dev but from 
netdev AI CI instead. See: 
https://netdev-ai.bots.linux.dev/ai-review.html?id=0b114a22-9aab-4265-8bfc-ea1b5bca5514

The documentation mentioned for running the AI locally is correctly 
related to netdev AI bot.

I think it would be useful to document that AI reviews are happening but 
mixing AI bots might confuse people.

> Check for findings on your submissions and address
> +valid ones before a maintainer has to relay the same questions.
> +

I wonder what would be the consequences for this. If less experienced 
submitters are expected to address issues pointed out by AI bots they 
might work on something that isn't valid. AFAIU, the AI output is only 
forwarded to the submitter after a maintainer reviewed it and believes 
it makes sense.

Thanks,
Fernando.

> +You can also run AI reviews locally before submitting. Instructions
> +and tooling are available at:
> +
> +  https://netdev-ai.bots.linux.dev/ai-local.html
> +
>   Testimonials / feedback
>   -----------------------
>   
