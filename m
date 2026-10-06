Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17F2D1907
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249334; cv=none; b=GPr5sHKGJyClFzd6lXxj/N9PodgJxK+XGhvXfTETsClr0TbPDZ6ozSKvfP+o/m1+/oO3N4+W2YIXl2d84rZqwGMEcHQWD9dObIFPspwgbpVTohWDJ0GtCYaWDiv+G4XT+5aOOiKWf6jK7McxOv6kurMACf5SZOJ12tB1UmdPhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249334; c=relaxed/simple;
	bh=K5pQyqH46zcsDmfRdRd2NPpjNFFoQHxgDiZ0drKaNzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxaNm6gBtkNpBc3U4S0EpKqZKBSyt3MWDeVwheOdsIr2/bMkfM3w+jVvCQiMurVYR2bjS1lsRv7GTDpohscEKpRGw4seDYnAnoewo3I5ZdZbGZYxecSI+nr19ArBJX+OrKqG7HiHpW0sCKUZzBjdDcLh/EKcWZGaXf1eMGyWuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mftngpvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mftngpvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EB01F000FF;
	Tue,  6 Oct 2026 01:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249333;
	bh=kPBgOdDUNoeeBwEep8DhqcxRYlVjBw90m7P4orsHwAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mftngpvfKYU20dobvPROjE0T1097WqAB3/JhIdzyGoYkPX5zJquUUuqvygDXypRDN
	 foQWZfxb4Emyg8sg3Pkj6RGwr2KSQStEyVsiEMcr3mK3G7dkevF79InLDSSOvqlypQ
	 ZAOaFTAOxpAfQARYeYUbBaadgHx15JudMysTCC7AzvhpR/+vE8qAqJ1+En5jKp1slW
	 pyAweQhzT7S9toMnjxvueR+hAGCr9dDo4W9zUGbi9E4fMH3IdDAblOxeLQvgN6luo5
	 mRyoOPpI16w3PiiGaJyjnfdhgB4l5kBH8PZsCTYUOyR+0D+h/CPRPXp3ezc0sqXnKP
	 WzrtWb9Ra9gNA==
Date: Mon, 5 Oct 2026 18:15:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Naman Gulati <namangulati@google.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, bigeasy@linutronix.de, kuniyu@google.com,
 syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: gro_cells: prevent enabling threaded NAPI
 on gro_cells
Message-ID: <20261005181532.49d699bd@kernel.org>
In-Reply-To: <CAMP57yU6Ghd4AG266kETfq1-o0n86ufRA6+ucZtnMO63YGXfog@mail.gmail.com>
References: <20260929010058.4063305-1-namangulati@google.com>
	<179090301201.434549.1629224862256105592@kernel.org>
	<CAMP57yU6Ghd4AG266kETfq1-o0n86ufRA6+ucZtnMO63YGXfog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 18:34:31 -0700 Naman Gulati wrote:
> This and the below finding both stem from not being able to set
> threaded = 0. I missed handling this. Wireguard setting threaded napi
> by default along with NAPI_STATE_NO_BUSY_POLL deffinitely complicates
> this further. It might become an overengineered fix to tighten the
> loose sysfs interface when netlink already provides stricter control.
> It may be a better to just update the gro_cells documentation to state
> that it does not support threaded napis. May respin accordingly if I
> cannot find a clean way to tighten this interface.

Ugh. Alright, thanks for trying, seems we have to return to v1-ish
approach.  Please name the flag PERCPU or something like that.
