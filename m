Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86C3876B2;
	Fri, 18 Sep 2026 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693755; cv=none; b=n1ja+3BfHFSZ9JT6iDSeoIvEOF9xxLAsNF8CFg7hzYvt5691Pt/UBNevoLZGuudDAEJ9VmPR/9sfURY+XOHoh86pDgKcYDYubTW4i/w1XZmX7FUW2zA3uGEh2+lLSC2yTouWlPxkSgrhMaUjkbvw3E5iwKkHcvalgs4mpyXMlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693755; c=relaxed/simple;
	bh=gS7z4w5LjU2D4ToiUYGi0O15to3mkDTtyfRHe0JpZMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deiCZw9aJM6uGNdMXokZSlFdXore7MuqaUBYdF50QZEBzXfIQsDCq7nNsjWIPtGIUlQEn2hZM5jChFqq/LeWmv9JSH52fj7AmyGpB3ledN44naXzfs3iAjl5Um+DOwmNt7ROESVPc6L4ysRvIG1MOd8AQ8duButkfAtwPajII0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1XO07WF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1XO07WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A61F1F000FF;
	Fri, 18 Sep 2026 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789693750;
	bh=iYi7HJ090xbSuBoaZRaeaTvNsSxvODBQTAfYNT4R6Ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I1XO07WFH2WyMNEKuS/VCG8zbNtPkpXT5LndC3QOIVUnHP4wpSDE35tbXM38DHVOe
	 FfktB9CybfNjhWZ6PKvomV9FUlaGoif6L+6oRg2l/sbLs8wex2wTnEhV9Qwg90NgN9
	 hrQHJ9u8AlnsYwttVV4ZciI+KZJpB+N+HAVaQr+gVGLzvtZjZWjPpxiAcOUsU1FbAk
	 ln9fQNG0MYLY76P08kZP2rm5cBsaX97tOTkI889hIUi++EFDfCI/26HJXvpifBOC+n
	 rbqQNKXslUOqhCsIttJSK2nKdddm2efeLMyVxal6UrBQh00qw6GGzj1HOK7DHVCGmp
	 KZT1e27X0J41g==
Date: Thu, 17 Sep 2026 18:09:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: haseebulhaq55@gmail.com, sd@queasysnail.net, andrew+netdev@lunn.ch,
 horms@kernel.org, hangbin.liu@linux.dev, felix.walter@cloudandheat.com,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] macsec: initialize SecY before registering the
 netdevice
Message-ID: <20260917180909.566fb795@kernel.org>
In-Reply-To: <178951752525.22033.8547704610100726932@kernel.org>
References: <20260911-fix-macsec-net-v1-1-c82aa58ae741@gmail.com>
	<178951752525.22033.8547704610100726932@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 00:12:05 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [Medium] Incomplete fix: the registration-time RTM_NEWLINK notification
>   that this patch makes succeed now carries a bogus IFLA_MACSEC_SCI = 0.

Looks legit
