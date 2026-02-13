Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62219005E;
	Fri, 13 Feb 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999872; cv=none; b=Z5Uuh9c0D/LU8ho4xp6fpVcgp5bt4qV6DkFrgBvJ0m1JpMHLq84dmvP5VHp78vT1qSVSDlP3obaY5FeyAyNTbQNBlyQvu2S4+6YrrDMlUtiC6dbDgWI8rW+MVs37NlRCeY5Au8XyiRIkW1yhpCrt+6myvO1Z7XBa/dWKb8V3hOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999872; c=relaxed/simple;
	bh=JPS6VmWYIBXzVgbONSRcgfzsXz+prtoxjghQHWsOkek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+H4hMMdnwqUTed63FnRvngqzz5r1xCoVOj7vdvKH6EBY5rwgp0DkqDlhm3Bt4UHg7N2j03I05DmrdOX+IPKT9sf7CtXflBkeBevwYqQ+xgU3Fjl4Oa9W0+VXEkNT4k9cmxfsZr9YUSEG1ZF1u2JdJMMZrJkWsGzK/eO+84U/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ols7zC9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ols7zC9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C69C116C6;
	Fri, 13 Feb 2026 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770999871;
	bh=JPS6VmWYIBXzVgbONSRcgfzsXz+prtoxjghQHWsOkek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ols7zC9XatT3+T8ajUtjO7RUpbwYAvg+ODeBxndQA/ZesmHuKS3ra8fEpeZcO4t5n
	 LVYCZVxDhhVfzf3WEhocX/Q0c+0C/SWpiETPnugHFtN3moaqDe/RWtKYqbRtrGDoU+
	 fvE8r5wCnYBGYYborW8freEM4Bgw1DWnXtVR3doPSHwZZf8FT3U/4d5f3kf85ZyzBY
	 1uwLdJaXW+ANMrHbgZWiBLVkn8x4cndFwCDffwY8yy6m93K3O1mSJ7GLoUC59wDqnx
	 eYMqTuVPsHYbIs3JOLbp7TwtaT6CNNL3RnlkFZO7bSzn/DI/XVYGBotqbtw8h0sGR6
	 S3+7cSO23IkDw==
Date: Fri, 13 Feb 2026 08:24:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: RUITONG LIU <cnitlrt@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuyuan Liu <L0x1c3r@gmail.com>
Subject: Re: [PATCH v2] net/sched: act_skbedit: fix divide-by-zero in
 tcf_skbedit_hash()
Message-ID: <20260213082430.7c4ce0af@kernel.org>
In-Reply-To: <CAK55_s5pR7KTMzNkHySK+XoGtv-WFdVe77PzD3+7uPuytYDNYg@mail.gmail.com>
References: <20260211184848.731894-1-cnitlrt@gmail.com>
	<20260211194325.797963-1-cnitlrt@gmail.com>
	<20260212180810.0b06e2b3@kernel.org>
	<CAK55_s5pR7KTMzNkHySK+XoGtv-WFdVe77PzD3+7uPuytYDNYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 20:29:20 -0700 RUITONG LIU wrote:
> With queue_mapping = 0 and queue_mapping_max = 65535, the existing
> validation passes because it only checks queue_mapping_max <
> queue_mapping, which is false. The code then computes the inclusive
> range size:
> mapping_mod = queue_mapping_max - queue_mapping + 1 = 65536.
> However, mapping_mod is stored in a u16, so 65536 wraps to 0. This 0
> value is later used as the divisor in a modulo operation (hash %
> mapping_mod), causing a divide-by-zero.

I see, thanks, could you please use the version of the patch
that Eric posted? It's much more intuitive than checking for 0.
Maybe use U16_MAX instead of 0xffff, too
