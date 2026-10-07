Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72149370AD7
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408346; cv=none; b=uGxTc7/g6z+by+Q4vACCzMikYYSIeBVuzUFkw05zxlnk5+q41/bgliOZAc/4jvCANhdIB5VXwoFo0Mn2q2Jm9hTbU6VqOd9lge4xBYFvc/2ZBPUP1tqpiIOisUbFlyKA6RxWY4osr5p1eEutgU7F3pkuzTDfgQOEl+uTAIcziXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408346; c=relaxed/simple;
	bh=DXULOpRTxpLmHOeR+sswIpDcE/DrdAQBx/IP6UcQnJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uto+fGjeVbhuFcOmwVnZk/rwO/uZ3IlPDRWQwuj+Ct5Ma03OQMATa7zoJSKcL36TT1FPlH4Ll5pd8dCGFTOA3Q5bCwfhYCMRuDuqFgko1U5wtZGH7VarzJph4Mz0j3XEjv7nh0tMWdOaWzizHZFFd6FDvuMJoEab84XNwznyiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pyUO9Gdj; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pyUO9Gdj"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DXULOpRTxpLmHOeR+sswIpDcE/DrdAQBx/IP6UcQnJI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791408342; v=1; x=1792013142;
 b=pyUO9GdjBEIM7lnRpwdA1WOZn6uqX0CbMdm6lAeJfPM4mm7CeBg28BCRGR4WsMXl7jpEBvPj
 zE2225llVAq3Er981atbQ1DcQe8C6VXkWapHw0CQTHx7jRBa8UKkF2gez2h1GAjVZbg3bCvF8em
 QxXbkD+O3WLhtMnQCBFi8zsI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 71950cc7f1f25315;
	Wed, 07 Oct 2026 21:25:34 +0000
X-Mizu-Trace-ID: 71950cc7f1f25315
X-Migadu-Flow: FLOW_OUT
Message-ID: <fcf0d6dd-c36e-460a-8c12-6f078f7d9ba3@linux.dev>
Date: Wed, 7 Oct 2026 22:25:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ptp: ocp: fix PCIe delay estimation calculation
To: netdev-bot+sinfo@kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20261007203359.417270-1-vadim.fedorenko@linux.dev>
 <179140589723.2527009.3097475687199168486@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <179140589723.2527009.3097475687199168486@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2026 21:44, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

The issue was hit in production (a negative value is observed):

# cat /sys/class/timecard/ocp0/ts_window_adjust
-3
