Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838442123F;
	Tue, 18 Aug 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068437; cv=none; b=OaWVyBKBvYLIxx+mnjgvpUHHWm7DXXT1AlVyWDfW42R3kKXYMCOXM3GH5CR7O711tgw/GnXsGWmE7pwNUKaU7M3r28GyhonsV8Ztfx8rsRNaPUtzlb7jcUbVD1At3uJoIgNg9OUPNU6AUHMwnVaq/cJrv32okz7kV5RL0PG8q8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068437; c=relaxed/simple;
	bh=Vnbc/uTg57dfJs3+aZUkkkaCDE85NzuJytYflQY+DqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMuz40KksdYfxCUrKKjJxY8WwDc1F3QsnF5eUI81xohELiMIxZbk25T6yNUES2sUto/sR0xmn3KS01i93bSAWK2RW1zngXKB4LW89ekVn+i8H2ehjWH8r8e/eUtBc0NgN5ar9UgH19/OL6k42KR5iVmJKRiKCFFHKtVVtxdXQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCi6/Tf0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCi6/Tf0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06781F000E9;
	Tue, 18 Aug 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068436;
	bh=LQT4La+5Zvy3buhHeRt1oZplUssCcmOOpWcOZtAVvHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NCi6/Tf089TGa81zxHg1eF/h6jyXAiJ+7h3wNuQ4oZ1QUfQc+N5P5Yh37O9zxwoF7
	 Lq6VC2DvcPJXHOmcEvcF+VKUD2S20a9mdmaGnqqFk9KlqqgCZQ9T5FJajtR4mhOK0/
	 qKf58hLA3zLIXkZVC0jtgP0sBP4VSX2lYEHmJcrn80VqLo0wXd5RDavga5/JIoTWgH
	 o1ia8/+X8iF29/uzkgSVhjLHkvjEMnJdzDyisLHDn2Cal4E4uxBVOhEcyr5gmIxLTH
	 36KKk0QdNZ9A5DNkh+TjxW3KAwU+ff5Lo2fjHcTewXYzv4C+pXz2vsGwVyna03Gaof
	 nr7mzmuBofiLg==
Date: Tue, 18 Aug 2026 08:53:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: fix mdev comment in tcp_rtt_estimator()
Message-ID: <20260818085354.34325d0f@kernel.org>
In-Reply-To: <20260818154253.6895-1-zhangcoder@yeah.net>
References: <20260818081346.03773154@kernel.org>
	<20260818154253.6895-1-zhangcoder@yeah.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 23:42:53 +0800 Ziran Zhang wrote:
> Thanks for your reply.
> 
> I understand that net-next is currently closed. I will wait for it to reopen 
> and then resubmit the patch.

TBH I'm not sure this patch is worth the review overhead in the first
place.
