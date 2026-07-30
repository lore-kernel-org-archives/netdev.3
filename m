Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566CA35C688
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420762; cv=none; b=imu5bVYmqC1fyg+Y3/2ug2NWaPc4qO3jebfa1DFdWMM7J5U7T2cuglFGifpX3a9f3fpCGg3Up67E+mWBSO4kXvgaGGb5/o9Mz9i9pmVNyOKQBz5GUzF1qLzfOQY8svDp/vnsLOGEmMgYjNPkTvZ6LGb++rMj1SVRZ4L0N3zIUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420762; c=relaxed/simple;
	bh=CLFKPhZ78YTibR+2pHMA1SavKhKEytCS+KNPwy8W8vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nsw+izGanMDihb6YV2EMoWozn4ESMEL+aahRo3iouHbsiH0PGd9PYglN/428T16dw0YAVo2khsqThMc+9AgKpQvLFclO2tasGrOKmPprhe9XhoSl4BNRmIJIwKoweCVZiSSfpp2/l0mF2AQac0nOlNpUfCv9E0p4n6F44CU0i+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GsCRJVl4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QOwtdg8J; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GsCRJVl4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QOwtdg8J"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F9ECEC0190;
	Thu, 30 Jul 2026 10:12:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 10:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1785420758; x=
	1785507158; bh=LsZUjk3Zws2Mokh7LiosNXpm7BNlFvo0BCIJ1Hz336Q=; b=G
	sCRJVl4AWdd4PM9g5N2cQSrbqSqhGZqnG9Mi60Mxu9EhRY5x0ASSZ8TrvBstGx1j
	vGGOn1flknw/i/fsnhqca6Kp4YL6X/710xxu3B7Wczg5Igat57Y4jquiIZXrP4UT
	tDC0KwQNUA2f48rBLDuhpeL6Qbsmvxpf/mzOdBinhJblQzCsJTjwhDiKMqckBb5g
	4ykxnHBVEvi/q9Sq2ZEgg0t2LV5TnVNriwAlOJWq09EQbL/blZJB4dsV/3ElN+LM
	qYNKqPWp8AsiYDeOQTfY7U7W56E4UGoH7t0X4ZEisF2ZZ8lHtjWJVU5izhfWc5Kf
	+4fMqPqDiTCrAmUtDQSeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785420758; x=1785507158; bh=LsZUjk3Zws2Mokh7LiosNXpm7BNlFvo0BCI
	J1Hz336Q=; b=QOwtdg8JbhFWeJ7DJxszwVTVDYtm80c+E2ZHZL4MXGEUJPpniVx
	COkDFcU4prlLHi1YSziPwpzhm9iLRQKc/6bqawuF1s5au4ILV+xVjtMaop2yhH8L
	971NY6GJXUkuUI5WyYncq3lg5kcvwaLCkvhGAPSvagm/0ujGAz1e0jRf3lkCWwJT
	qxLoMLVDx0MSZe4JBR/Wowp59REASBJWcFIdkzLfCbKvQ38hWcci60e/RAGzJzLX
	lD1MgHS4DiWD34W4y46emc4idNDQVjVeUXCAMwd6cwSqVBnXaXshVdLuc/43yn+u
	TTQjKv+6SeDinqdGTYGhtRMj6Fj2m5bmxAQ==
X-ME-Sender: <xms:1VtratMzgLmSHlCQ63JZyIQH3FLMfJ8EHjA4KHDiUXb6reKYgBvf6A>
    <xme:1Vtras5gNn6XgCCxbbqP7WYDEUqlZCG1opOFgAaOIWL8VWTXKAHKrz6f_53USu-N8
    ULPHOvu2OMj60anTG1HgUky1K-Kk7AZ21j9UBH9kxfDv1FDF7YOqQCf>
X-ME-Received: <xmr:1Vtran5p8e6Gae4Xzc7mCd9_m4QjZJ-NPbxkDmiANG-gHb8QgE37xWJYOWA>
X-ME-Proxy-Cause: dmFkZTFS6u+kaEsjP+oI6qv8MFj9j8daDe8cFGmMIkrVj5DypEnR/7uI5X6GswZOhYxs5K
    Vpmg2etJAwglHAN0ZZ0rxuPwuDrRdF65PKvc8ow9pYAYkbxCDnWgiQO7NoLNg50kMPlpMq
    WyrKtga6whV/RZXJxRm58UVABTrF6OYm43xvVCitvHJkM4LDTrIHU4AGOO0kENafzxNgOK
    aZOuybs4O6LmplH99+ugNhOy29R/WI+prbx0o2RnHCF0Ti1YwuJropoKV9NrpdgvrgDq3S
    27HT8vNB+7psdkYK5jWrOTjcFVRchYx4yhJPw/VQAPhhv3kk0WN6npdXaGedV7eAXZSjS+
    KXtrVC48noD9UToKgrYyvi6N5B7lgasT7P/DXNHmxrMu4pJZgd0OvGEgwUJda17N/OumgH
    1Bqt9u7ysOYMM1gWgtjl664HnuBtYvCgd8uJLF/3xKGleb2WxULt+kOXEFKuOzC4fASCpD
    +7sxMmz6DMDDwor9cixMpCVcZXOi1zY0seU7G6DXugaAMSCXA5cyG0IiOfVgbkyraBMJJx
    InC3GJh6cyOOLotuAcF0tg+M15j9lfXef8G0bGPwYZ9LCFg97W+zK8gCnwXVBQY99fEgxJ
    QweNBGOJ0FadFRG7zqqIffj25rhiprFJDuibHn2z9EcETS256ufVorZ1YOSQ
X-ME-Proxy: <xmx:1VtraiGt903NjIhqoed1DQv3jD73QZxbH0MLZwOgyAza6GGv7hKObg>
    <xmx:1VtravVaJNHvtrvrAxbWMRJ0TsvuEMKF0tJX2lNQqNv_qMFVpkWEDQ>
    <xmx:1VtrauUo0ojHzz7RcXd32qPiAL_kcpJgiiTxlYCjXkuAJB1dRfaSyA>
    <xmx:1VtratIHCY4wMzQfMT-TCccHc8YNNEQBw37P6Eytxa_Gpt3Ph-ctWA>
    <xmx:1ltralOcxB5MnJmSODpsPCuf9DaoNvp9gIWO_zhrIxZjZY5EQMokxWuJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 10:12:37 -0400 (EDT)
Date: Thu, 30 Jul 2026 16:12:35 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <amtb096CVcSxaXeX@krikkit>
References: <20260727204724.2787038-1-kuba@kernel.org>
 <20260727152517.312895f3@kernel.org>
 <amgBCpqbkrEIiCuh@krikkit>
 <b39fa14e-1bd3-4e02-8d44-648628303197@kernel.org>
 <amkzn_79gJWAjGEV@krikkit>
 <20260728160820.3860b3de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728160820.3860b3de@kernel.org>

2026-07-28, 16:08:20 -0700, Jakub Kicinski wrote:
> On Wed, 29 Jul 2026 00:56:31 +0200 Sabrina Dubroca wrote:
> > If that's the case, good. But "quote this text at people until they
> > comply" and "get an AI bot looking at all patches coming in" doesn't
> > sound like that to me.
> 
> IMO it's really very useful for reviewers to know if the author
> triggered the issue.

People usually add that information if they did. If it's not present,
we should assume they didn't, and treat it as belonging to the "AI
report/other-tool report/code analysis" bucket?

> Also, for downstream backporters it's useful 
> to know in case of conflict whether to invest time in resolving
> or the patch is mostly theoretical and waiting until next major is fine.

For downstream backports, there can be a number of differences that
make an issue either easier or harder/impossible to trigger. But sure,
that's a useful baseline.


If we could reword the statement to include something like (with a
formulation/presentation similar to your patch, this is a short/ugly
version):

Fixes should describe if and how the issue was triggered/reproduced.
This information should describe how likely it is to happen in real
life [stuff about delays/fault injection/etc]. If this information is
missing, we WILL assume the bug was found through code analysis
(whether by human or tool/AI) and not actually triggered on a live
system.
[something about such patches being penalized in the reviews/queue?
I don't know]


my concern about having to add a bunch of uninformative text would go
away.

> I'm also guilty of not adding "impact to the user" info, but that
> requires thinking and theorizing. The ask here is to purely state
> the facts.

So just something like "possible UAF/memleak/deadlock/some unwanted
behavior" is what you expect here? That's totally reasonable. I
thought you meant something more abstract.

> FWIW the immediate trigger for me is the people who started sending
> sloppy fixes to drivers that nobody uses. I ask them about the
> discovery process and half of the time they don't even respond.

Sure, I get that, you're drowning in pointless slop.

An alternative could be an AI bot that looks at "fixes" and checks if
they're likely to ever happen (or have a measurable impact. a tiny
memleak when a device is initialized/module is loaded, even with great
reproduction steps in the commit message, still falls in the "don't
care" category IMO). My experiments with "find a way to trigger this
code path" have been pretty good, so I guess if the bot comes up with
"basically can't happen", that would be fairly reliable.

-- 
Sabrina
