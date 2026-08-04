Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3632DDA9
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878169; cv=none; b=hZIqS6U453pn0E0gGDi8mpYcbh0iNxkye5I1U4zPB0DUIlAqfaCNi/YyE8Uvn494g3pOQ0l+i/kYhrxuSJarrRMFFtHMmHspMKngzy/iV6iE1GnbhnZa9UfqAk21Yeijb8ZmD1uvKcK8POD+t23q/pnXZoY7OEUEhie3fuczYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878169; c=relaxed/simple;
	bh=z3BsySwBz4s7ySjxA5kPtqC7nZEbxHm5e2uGwt+M48k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7FjcIYF/1226M68sClug+zS6dfAWrb6smQW4WkTk2fKIhKcm+rZ+LyVsY4EgKTS3kKcoUsim0+EsoCSwm2za9ARzvKWa7xc4vDKO3sZqwXrhJ9zzYNqu5PCyRHYHV03yKfZlAOuGoqAvndryXLfrY21WtUc3qFQP1y+33RiprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+K1a6u7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+K1a6u7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEFD1F000E9;
	Tue,  4 Aug 2026 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878168;
	bh=cVGVr2SxrTVYo+lbMQ7+1mGDwWGFzklfwfkNH5NHtuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O+K1a6u7wBw3AtZqAeLnOd4l9BHOaWpjZbkfhJFaJyC0lbLK0v0bswxashFIMZR1E
	 dBPzvhOAyk4+uml3EQYoM0BUiQXJARB3SuDQFTnjNlIEqxgsUwbOnAxxo2IliLzH/O
	 l7luyVCiML1Al1I+fNgst2YyCklVoO7zhSHmZPaEEw8bS0nsyBupKykI5M3s0CeCyZ
	 H8vEl+egyo6bL60ox+4qTbxDJEfcqMOfxcjnVwAzd7l4HLh9M1RTJPFvZ6fIWR/6NR
	 2JgB8U1fkgTwdJWBLjqm3Ks94eHwZN4ngav8W8gcNqyAx3V3m1rWFB5nPod+DydYwC
	 +bw27iq4JbkBw==
Date: Tue, 4 Aug 2026 14:16:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in
 unix_del_edge().
Message-ID: <20260804141607.111111ed@kernel.org>
In-Reply-To: <CAAVpQUAnR+7W6fXgWo4AzABSn08YAZL0P3ipzkO2FS1B9Q6X_A@mail.gmail.com>
References: <20260804002155.2233594-1-kuniyu@google.com>
	<CAAVpQUAnR+7W6fXgWo4AzABSn08YAZL0P3ipzkO2FS1B9Q6X_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 17:46:37 -0700 Kuniyuki Iwashima wrote:
> > [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().  
> 
> Sorry, this is for net.git.

ack
