Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEB5349AB
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169963; cv=none; b=pddaYlqJGOlYv4pmMARAAHvjeg8aChbiCel+bJYTWE8BOYtrju4WoLlHDS3leEzwjsjjNSd9/QwDg+PQycIQhz/GUGICwmva0xznx4c1Fpw3HcAgUdUaqwDXMJ3Pmkl0RB4fDGj4DHcamVWOea2bR5LfIX9e64o6kv8HwOnm2uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169963; c=relaxed/simple;
	bh=wqM6FEJq2vQ3XVHRKZCAI8IyVF9ERXWeC4dNI+OIK+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhumUCuPJYTzvlzgKpXqSy+Erk1Emz+csjdtrGMJJIrZC+RV0Cth9A32lTzGYkZtJE+Cz2C/CWehEj9htZ0z6zbKaDxx73nAyu9t13dVxWXW43VqX7td6jidOjfrtn3RCeFEhTBTrxqXXde4e6b/eb6ICm1HQSlvyeamAypLFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE0W7+aa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE0W7+aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B907E1F000C7;
	Fri, 16 Oct 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169960;
	bh=K44KF7WHJdV0yB8Y8tDIVrPEvJQX/IXkcTUCiAK6x+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WE0W7+aak1LJwdhFuyHORnBr9ZcK60lzd6A4a3YzP68Mgk+j+IJoZYYgkod5LdJtm
	 AqdsLuVA05nmGV/JrFphEproCejjuMQzCd+okYvozdB76Re+ItkSOmVflWnTJqYouy
	 lXn2+GCdq05WXqxa3J8lpR1WeLyso2xmg18YMTsQpk3eS0DKWiwZ8M78G7jPUwJl2J
	 EFXV94tj1fD1ZGfHsp6FkxVzu3f5ZUA5hQDxrgX6ZvDKRpRTVtYc5YLfmxEdmsjajz
	 /GWaOoJmWO9HITNhIGvxXINGMJc+RBvAOvy/34QOM3HMnwoTuHBGONLwxNabSbqOvo
	 P0EKPhUyE9VQQ==
Date: Fri, 16 Oct 2026 09:59:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [RFC net-next v2 2/5] selftests: net: py: add metric policy
 output
Message-ID: <20261016095920.5723689f@kernel.org>
In-Reply-To: <20261005201115.2690830-3-sdf@fomichev.me>
References: <20261005201115.2690830-1-sdf@fomichev.me>
	<20261005201115.2690830-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 13:11:11 -0700 Stanislav Fomichev wrote:
> +  ksft_metric_policy("nic.rx.dropped", summarize="max",
> +                     transform="rate", display_range={"min": 0})

IMO we should not be mixing any of this into the test.
We can hard code some heuristics into UI to match on names and create
sensible defaults. Here this feels out of place.
I would have expected only what you have as "regression policy"
in here. And only a subset of that. Naively we want to know
 - if the metric is an error metric or perf metric (error metric
   must be at 0, perf metric has to be analyzed for expected perf)
 - whether it's a badness or goodness metric to distinguish wins
   from regressions
