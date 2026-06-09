Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50B30C629
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044027; cv=none; b=nFttqrNefkUHAStchK/XyuXsHxOVAJ4id5bokjSSa7YlX7ITKkkvg2A9uYLRNGhWSPvN/tvmNSeByKT6KivvO3urDXnFCWLqv7hK93OpPuhfVfaVtUOEAR6w8+Da67ELL1nMLoBVVoLAJU33xNee/AKVHreYoen+G2e34XAbYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044027; c=relaxed/simple;
	bh=t8IXsILI7McNhKssp3rbCYyBlz/RIsjszHWT6+rInME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O92NBJTx5+hZHRuQIUY2BayljsCRycdKxnnRSV895Ym0Cucj+T69Uo69iI8ag12OU4snn45oztpYys1yhFDHm20/0HbZHXP26lV+0tz1ZnB5iwZ+uRozeaocCxfs3hNdPrCAZugvPXMHdiXmeuDNVkPXRgJ261UQtBII3U2WMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQRVuGae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQRVuGae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59681F00893;
	Tue,  9 Jun 2026 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044026;
	bh=t8IXsILI7McNhKssp3rbCYyBlz/RIsjszHWT6+rInME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UQRVuGaeqx3lcHnF2uQpfJKWslZYLrsn3LTqktd1vKqypjM4LB6jbcrtbYI694NpN
	 SH7Wivy4Ptqn2vbCQtYcZo/+gN3PpDXDc6havEbTmuyF4B1A2SsJyrkv3AonJvOlns
	 pfc+nBu4HHwscYx14Mq4N6MXQs41yxDA5jYXHDrePRW5UINDc3AozJvj96QZc/zPn+
	 GVupljhAfYwQA444sMfiOoPAhlKGR8joh9/xcVzGITkQTDVRNc6C35VUENvX0wNuaO
	 HrZgj136XvR4xuaGi+8yyvupgxvBwdimqfCGXlXpp80C9SxnjzHkm5aj8Jhg9XYVvj
	 KH0CJdWCpS7OA==
Date: Tue, 9 Jun 2026 15:27:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, ncardwell@google.com,
 shuah@kernel.org, kuniyu@google.com, alice@isovalent.com
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
Message-ID: <20260609152704.2512ce9d@kernel.org>
In-Reply-To: <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
	<CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
	<715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 19:01:02 +0200 Mariusz Klimek wrote:
> I understand your concerns and they're reasonable. I would still like to
> proceed with this series, though. What can I do for you to consider this
> series? Would it help to submit a few less-significant patches first before
> resubmitting this patch series? Should I resubmit it as an RFC?

AI tools changed how much we value code, but they did not change much
about how one joins a community.
