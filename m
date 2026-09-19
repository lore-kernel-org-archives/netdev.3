Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D452253A1
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838836; cv=none; b=Iv93pk8QSpTua8chk33Sg/nXptb0ldlg73gPj/jhVypYB/56DOWhBGD8FzlF2mJtmsk8jHyTdl8DzWxaiNA4yGc8qYPFUCq47bkle3RFbKIsqAuNz/iBzbgwQOxvhwYReNRVslZrkuVvSRRJIAH5gsH79zNnWdFc/SlBfqh3fB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838836; c=relaxed/simple;
	bh=t1ax5gqL5SrpcrFKqi2uClZ4X9Dpa7FLqNwDI2KpO84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kqd9BNDLrLdPtXokqA9aPsR760SxglsDJZceOFd/lyNP3h17NlUqss+G2D5jZCO2484FnR+ne5OnWdyCZhUS4h1jI1yiyf6IF3Q+1ZAbJ3wBfffMDp8gpLRNAgsbnCJ0e7JeNuyVeqeIycVMgiBUZgYKJ4ILTy/FiCR0CPGoOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYrzMTkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYrzMTkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0601F000FF;
	Sat, 19 Sep 2026 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789838835;
	bh=Ym47AM8H6sBykbBz6npljZ1MaiQXj0M9hvBLj4UYXcE=;
	h=Date:From:To:Cc:Subject;
	b=RYrzMTkIPFiBAi+PvYIC7FhdGDkwYc5rAFBj+x0wp+phUJBqHQlSVKqDBtvXWprX6
	 Wb5HIbkZzcduwZ6/r6VlCrWByZKHbLa740GlKBW9Gmoym7WJGJO7RO1P50mJ9XXE0P
	 8+Yq5CArg3b24SgLAgoi73XfoAHSVZH04wLjqa02twsIrO/Uk7VldC1uy8k5qNySrU
	 i35CxvCQ/WyOoPePkD1vAY5x6YJ3/YQenDqlLePQH6lSO2Aqg/Ius4mZMLvczJOky+
	 kCR4d92dCfg6dCX7ZSUBbRh3r1NBZkeWnO4gJj4QP7+T21/hKr14jn9+5U9Wa9Pphl
	 Zdj0o+GJ4zOQg==
Date: Sat, 19 Sep 2026 10:27:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Yuan Tan <yuant@nebusec.ai>, mkarsten@uwaterloo.ca, Stanislav Fomichev
 <sdf.kernel@gmail.com>
Subject: [ANN] netdev call - Sep 22nd
Message-ID: <20260919102714.67256bfb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

It's been a while!

The bi-weekly call is scheduled for Tuesday at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

Topics to discuss:

 - discussion/feedback on nebusec issue tracker
   https://lore.kernel.org/all/20260830115546.3942129-1-yuantan098@gmail.com/
   please check if out if you haven't already

 - Stan's perf testing ksft, what to test, shape, what we want in tree
   vs NIPA etc
   https://lore.kernel.org/all/20260916190409.1222272-1-sdf@fomichev.me/

Feel free to suggest more topics.
