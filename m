Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006648;
	b=J5AuWytutLI12qsCsl7wNE0KijZySOaLSZnW7+1JxFmv+ti0E0f+bhgkQQXcBH3bK26s
	 dc1bE/TUJ81sdkphZpvLE1k7T0IDqz6Q/sUN8BSoGi8pEH94gE5H4NxQSxMsaBK19nrLl
	 cObNC4790VNFVy8MdI73UQN7eOEsYyV8eQYf2gc0xYl66hAOjdQil3bDD4TgBQlp55pZX
	 BCinE9qicAgdQWqzaKwA/67u17DLitaYevHzJjzfvkBAY/MyY9Vgqr1/zByh5qWui9Cki
	 s9mBV0sopeDEzLmmoUGM42z6P/C4zZLHTEzn2v3TY0kcWuGjkO4yvtiCpeJsGaAt3pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006648;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=SSu8sahHYtJP4tYEpVQa1z5i0RcdS7+U4e1oKrlexBE=;
	b=YKrr0bDsuPNLjB0ELF2uhb9uupiL5J2s3MJP5+qTvuiVvJzlEL1bPwU4pN51+oEZpuBZ
	 bFGQXobLRUbCgZbHqOrofkKVGSXCFrF//nDGttu8WgOXNKAa2JOiB02O5E6BEOwcJmjym
	 c3/o+0ox0K4TaSKHpjzgCZ9U1nvLkHQTgJviKb+Hq4OoMYmPA0hGB6b7358TJ8AyMjSSy
	 a814mAokjOjcE+Uj5WYBc/9oUldafEadz7lEAFgCIGiXLUR4lROZmVghJKvoYwITZ/DfF
	 cpSz5tcWtp8DcSW5A1kTX31TfFaTtBjw91t2o4vE2SGkBM/3KRxGumqrdOFjRwMIz/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.24
Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397D606A32C
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 23:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8397D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bSp589ynlUSbkHZ/Pc8oj+44xLBN6TotbLXU3BpwP8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006640; v=1; x=1794611440;
 b=QVdBHXCf+YgkLKYumhrLD6fpuUKcp+E/ZAqbFq9mwZooLmomr5cTdrc4rP9finr0QLFyh2ne
 CHFzaErK1kkzmQMX9iLCJOvg8dXjH5A+LgjuIlEZCaje1eD93ZQkyCrW/+1Fk1R7XSi5/A6sWYc
 mOtLmfjd1H+usMO9Ytx58ofw=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f5adb69807cbc1e0;
	Fri, 06 Nov 2026 23:10:40 +0000
X-Mizu-Trace-ID: f5adb69807cbc1e0
X-Migadu-Flow: FLOW_OUT
From: Roman Gushchin <roman.gushchin@linux.dev>
To: netdev-bot+sinfo@kernel.org
Cc: alex.aring@gmail.com,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  netdev@vger.kernel.org,  linux-wpan@vger.kernel.org,
  linux-bluetooth@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] 6lowpan: fix netdev_priv() type confusion in
 lowpan_event()
In-Reply-To: <179400615048.488859.9102835578031186781@kernel.org>
	(netdev-bot's message of "Fri, 06 Nov 2026 23:02:30 +0000")
References: <20261106225930.1379968-1-roman.gushchin@linux.dev>
	<179400615048.488859.9102835578031186781@kernel.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Fri, 06 Nov 2026 23:10:33 +0000
Message-ID: <7ia4fqxd8sk6.fsf@castle.c.googlers.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

netdev-bot+sinfo@kernel.org writes:

> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I've a reproducer which I don't want to post publicly but can share
privately.
