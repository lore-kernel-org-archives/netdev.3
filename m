Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B7331EC6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044576; cv=none; b=ph9r0BF8h5cudnFWRFFDImvh1Ecng3gjkrfpmMDDDFbstUz0CPPbSOBuUkABOOMEhAIoYLak1Uws/US8eynpzPzpS214cBGVLEB42ckIGNEhoFLZXFDa1nBAopXy1Ry079DoUCrvubFGon4vVaswoYkqXfztTIv1r/pZD9c+M9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044576; c=relaxed/simple;
	bh=3XL8Gcy9YwfsTavlfdmGmcgK7xxmvnvAX6588konu+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD4mtiPE/Wx2/7vAbzIO91wTJUvVQ44wg2KxA1wEEZE+rI27XPxG0mZ68I+UgVtq2yS1l1+qGpGimXqzRWQcJLGozV1Y+e86PojQy6mlcXWCCtEJJ5TY6S+lK8WYvxMrPPh3hkp1sEJWWudT7w/oAXKxHTka1HLpwKKWd1H2BDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUB1tcmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUB1tcmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146B71F00893;
	Tue,  9 Jun 2026 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044575;
	bh=ru4EGolBoxhLkgeQG9Yo8j1K/M9ZlC4Cr1czFlLjryo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VUB1tcmD4kKK/9Kv0Umk2kfZP017f/qHH3/3lZm3UpCV+9ONA28wDS+R67pycXaC+
	 5HE/dzRA/2tVkyThYkSl9zT3Zklu8x1Z8uqd34BVsTRFHvkFlVjtsafhPJf85908Ut
	 ykZ5dbPuUMfqKr6OvjI7H4dFIIFEy8SPERzeMGp9H8ZPYC2wjGM5H8LYkZGwQVftVd
	 tdEmToWlQWbP5V4UPpfJ7cmZjz7QSqyMERYRQnzawtOx2o+PXdeE1wVXEURCCx8l8e
	 CwSunQzff9+vYWQ9vqHjLEUQ74SF0zrJnxcnB80bYBaU9tGOWM4C+lLTaGePqFvHkb
	 IFhFAQdtRgXew==
Date: Tue, 9 Jun 2026 15:36:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v1 0/10] cxgb4: Add Chelsio T7 support
Message-ID: <20260609153614.20d8bb0d@kernel.org>
In-Reply-To: <aifv8SR/ANbxBAUM@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
	<20260608141314.5c79faad@kernel.org>
	<aifv8SR/ANbxBAUM@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 16:20:25 +0530 Potnuri Bharat Teja wrote:
> You are right, and I apologize. We have had some difficult internal 
> circumstances recently that pulled us away, but I know that doesn't excuse 
> neglecting our upstream responsibilities to the community.
> 
> I am taking ownership of this moving forward. I went through the netdev 
> backlog, Shall reply if they are still relevant. 

I have no doubt that you are genuinely willing to improve things going
forward. I'd prefer to iron out the process issues before we accept any
more code. Specifically I think the process issue is that Chelsio does
not have a (competent) engineer assigned to participating upstream, and
explicitly given some amount of time a day to read the ML and review
other people's code. There may be no cxgb4 patches on the ML right now
but there's plenty of submissions for other drivers. Please start
reading the list, engaging, reviewing, asking questions which indicate
your understanding of the code and the process.. And if things are
going well, in a month or so we can revisit this rejection.
