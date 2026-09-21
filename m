Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE14388E74
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020402; cv=none; b=JTSga1j97Fh28LwE54schnCH5NaYqswoETbD+YASRN7c9tXJAdpjsxIzK+VyX+sEe0/OQXs/LUQtGGJWvrRCDScelJcPlA3JaZTJS6jpH4u+8wUi1AknWeKMmaKqMaR2Oc7zK5EBgHIW9DJXPysGaJx/O5OgDSjxnnbH4RxF51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020402; c=relaxed/simple;
	bh=C11xViEggXRRpaaUtFgcYrZIYA5pLAAZZojOLSvaqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3hLxv3xyvGZUNhDCUbfoQl4wi1ndHSSFEMl3ViEohRVtlyMmY4iGhqEkjqddFQin1xgr1wxQvQl2DmQWWp/paHqhTQYmYE1I3xJ8vc3maZ4iW7EBY3zhYxq2sELHMkvcuFcwgsAW+cjVtwxSCasoZ4NOOdlB6OqgdL7yEnvTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=midT764D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="midT764D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BAD1F000FF;
	Mon, 21 Sep 2026 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020400;
	bh=2hdgfMQyZpLSb+tfYC6xQFJhRYyGKAew/QFYH+x53Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=midT764DMSHpVXayWhnQ9yjtKiLeGaJ6uFsmsGIN6t9HFUh873OXFWR1DJEjzXM7U
	 TsdG1Y3CNFY4AGWNmuB44NJN/3OiOsN8eamK1unXHrlunrQHXzKr+pLtH4Nil7Lioq
	 ppSmOY9IziOXEOrwSB5V5fPyOg8jVw7U1Ai5ZhnyjYdCf2Exs6e2v+hf9x8/FeZmXJ
	 c6r7PdvMgsAMo0e66GeSPr6/vAVsWssBAjUmcwGmUKU9SqFGORkKTFV0GJP8iygupn
	 rwR4+cFC2ePs3xThcQ8ziiysKrC8LLe4IkbhZ++SiZPxETwaGE2yZd0q0YaCU2EU2A
	 Su1pWqHldbnEg==
Date: Mon, 21 Sep 2026 12:53:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/5] net: synchronize proc_do_rss_key() with
 netdev_rss_key_fill()
Message-ID: <20260921125319.6704c27a@kernel.org>
In-Reply-To: <20260921125156.6623d5ec@kernel.org>
References: <20260921183758.1812310-1-edumazet@google.com>
	<20260921183758.1812310-2-edumazet@google.com>
	<20260921125156.6623d5ec@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 12:51:56 -0700 Jakub Kicinski wrote:
> Maybe we should call netdev_rss_key_fill() from the proc handler
> and let the net_get_random_once() handle the safe init?
> 
> IMHO the concern is entirely academic / hallucinated so adding
> LoC for it feels strange

I see it's mostly gone in the next commit, I guess that's fine
