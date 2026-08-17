Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DF3A9879;
	Mon, 17 Aug 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992809; cv=none; b=NAVZ/QbkiGJeB9NQ8YQgaEdlIyY13iTlHgijLaosKVMW/kxlhYrxfMeNnGLddTD7Cwbqb9SFg+pMZ5YiebvTSI4xppDBYrojNGwdg8R2bOC4Zrsl40Hu3GYoySVCBeNiHNtDp2bc8XLzLsDnMul9j13sqpsX7jguTqQ9Iklvnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992809; c=relaxed/simple;
	bh=1qk5o6mqf10UOvNgrnTGj/YqzhCs2+kNG4ImE2A9omE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrdFZWHfptNi8p335fDGPx3U0S2M+V22tQ1D3vRRwp+GJj9gIyt5IYs39OlT4mB3HMIru+lkWqP1fRh/rycrsa7vfLi5DaU1DqmYSUQKGrABoscFC7cDe8kh5ivodfn87j/0fIIxVI84mktnpIp+++7zX3CdpqHPK0em/pwif2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NODOT7Ev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NODOT7Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992D41F000E9;
	Mon, 17 Aug 2026 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786992807;
	bh=QAEG0GQGVlUiDpCh1oFzyLFsr4ifZC4c4sD6vkSuKJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NODOT7EvHZO5YWUKJJjRiZ0D5NAcNEkQRiMFNZqyB0euiH485+XNfIqw/j0pomMo2
	 XNh5t7feqS7q9IMubyMc1G8djmUn0khvPNVspsBLalrZrSo0vBmDisG+/iHN/kMUT9
	 5H4lEBovzNN3Uvl1PeI5WZSTVHH6g+ieCgQMFlCg/iPlRST1w//Ou4KIbXs7vmJEkw
	 cWIZUlFzRElaiKwuNbeDKT3qfIfxv6Xn02jjQIOKpgNUKE6gSlq0bwqFmeAvZP61d+
	 1IXTaCLdYi3TTuB38mAIVMNSQj3cjAQ8cGTyesoJy65m8ULO0cEeLG7VLi6xxuVzyd
	 kB1tDpcNhbRzw==
Date: Mon, 17 Aug 2026 11:53:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, oe-linux-nfc@lists.linux.dev
Subject: Re: [pull-request] NFC updates for next-next 2026-08-17
Message-ID: <20260817115325.4333587c@kernel.org>
In-Reply-To: <93a47987-885f-4e5f-8920-788fb281db67@ixit.cz>
References: <93a47987-885f-4e5f-8920-788fb281db67@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:45:45 +0200 David Heidelberg wrote:
> The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:
> 
>    Linux 7.2 (2026-08-16 14:32:26 -0700)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-net-next-20260817

Please don't rebase your trees. The base of your tree should be at
whatever point net-next was after the previous PR to net-next.
Because:
 - we don't have the 7.2 tag in our trees yet, if I merge this it will
   look like I pulled a week worth of Linus's tree, not a small PR from
   you
 - the commit hashes in linux-next do not match what you have in this PR

Did you rebase this tree recently? Perhaps you still have the previous
version in git reflog that we could pull instead? Exceptionally, this
time you may need to rebase to go back to an older base..

BTW normally to get your own fixes into your own -next tree you should
stagger the PRs - first send the fixes, after net -> net-next merge on
Thu afternoon - send the -next PR.

