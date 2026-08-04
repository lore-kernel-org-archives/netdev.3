Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9028425CD2
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872699; cv=none; b=HXsJyGKsAG9XvUEI4SYZUPW1doQ+Gq7kljchl0iECVAay0X+xTaVt7X2nf1eQJU6YBK9eXACqvEpc1zisg1I05Ta5eachnA1r82iEHweM4SnulAMTGWRR54Iyi8jJ4+7h65X3ddO5J+pJ7OglVjCfR3p1s+HnEGTN5AyXPb90Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872699; c=relaxed/simple;
	bh=w5iF0HpWCfQ4V/63nl3HcJ1L5Q+4PFZWseISZp4bFcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3d1lfy+4LEmOJlbEbNnaWaJWDID/xAxxCNE9RLqDqvmVSUFhVqKT7S8B3aB5ViNEBmxlRDfJnYgJs2fY2OppRWz5L8znljs6tcJOZZgOOTZu1K0e7PdBcuwSEe3ZNfgxqeH7L0yTb+XowVMHVy4PTVowEfXv1m0lPNVRTlKKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzNbyYV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzNbyYV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4268E1F000E9;
	Tue,  4 Aug 2026 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872697;
	bh=2A5LxlUv+7nxuBJx1g5sE0ehhO4OI2zYHHKYSCZQYng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nzNbyYV75XOX4tvSCCvabOtDNWZPeBxqkAgpNgs675b33EWzN9+xn6r25A5ascM0V
	 2YApW3+8GIRJ2sEpHtrrlP2QNT4hShEC82cZpyVuAPwpCwBbECleizMMbqFFZEzpjv
	 /SVEPPVQbjqrnzWwDokpRQYshHsODd2I5UWt3GdpeSNfNQ+CRsaqlmMSonX9QNRra1
	 A8iCgWw3H4nuVWUMRCY4TI7FDveFXcrV5h8EFJBBui06lqm75yEIyq0i2npAvqjl+t
	 k9JZEY5rRNWbBnzMJdzxRB8C2ufutCZPys0nppD+8e8/fD+qdK9pQD8NbdoBXujnPI
	 L9SpvupPwhjvw==
Date: Tue, 4 Aug 2026 12:44:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Nimrod Oren <noren@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260804124456.1acd9f33@kernel.org>
In-Reply-To: <37c7d934-b356-4920-a332-9416b1f7fce8@nvidia.com>
References: <20260804094518.53b56d24@kernel.org>
	<37c7d934-b356-4920-a332-9416b1f7fce8@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 19:16:19 +0200 Dragos Tatulea wrote:
> Randomly clicking around the flakes page, I found another instance of
> pp_alloc_fail.py running and getting crashes in mlx5 during page
> deallocation:
> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/762402/sol-machine-2
> 
> Is this also something new?

Ah, that was going to be my next ask. (there were some fake "crashes"
reported in NIPA because the system was retrying and running out of
time, that's hopefully fixed as of this morning so the signal will
be cleaner)

The crash has been hitting since the beginning of July (if it gets
line wrapped into oblivion the tl;dr is that first hit was
net-next-hw-2026-07-03--00-00):

            branch             |       test       |                                                                                                                    crashes                                                                                                             
       
-------------------------------+------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------
 net-next-hw-2026-08-04--16-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:mlx5e_free_rx_mpwqe:__napi_poll"]
 net-next-hw-2026-08-03--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-08-02--16-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-08-02--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-31--00-00 | pp-alloc-fail-py | [""]
 net-next-hw-2026-07-28--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-28--00-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-26--16-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-25--16-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-25--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-25--00-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_dealloc_rx_mpwqe:mlx5e_free_rx_descs:mlx5e_close_rq:mlx5e_close_queues"]
 net-next-hw-2026-07-23--00-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-19--16-03 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-19--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_dealloc_rx_mpwqe:mlx5e_free_rx_descs:mlx5e_close_rq:mlx5e_close_queues", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-18--00-00 | pp-alloc-fail-py | [""]
 net-next-hw-2026-07-17--16-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-17--00-00 | irq-py           | ["mlx5e_free_rx_mpwqe:mlx5e_dealloc_rx_mpwqe:mlx5e_free_rx_descs:mlx5e_close_rq:mlx5e_close_queues"]
 net-next-hw-2026-07-15--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes"]
 net-next-hw-2026-07-13--16-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-13--08-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-13--00-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-12--16-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-11--00-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-10--08-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-10--00-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-09--08-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:mlx5e_free_rx_mpwqe"]
 net-next-hw-2026-07-09--00-00 | pp-alloc-fail-py | ["handle_softirqs:run_ksoftirqd:mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-08--08-00 | pp-alloc-fail-py | [""]
 net-next-hw-2026-07-07--16-00 | ethtool-rmon-sh  | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-07--08-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-07--00-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-06--16-00 | pp-alloc-fail-py | ["mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action", "ret_from_fork_asm"]
 net-next-hw-2026-07-06--00-00 | irq-py           | ["mlx5e_free_rx_mpwqe:mlx5e_dealloc_rx_mpwqe:mlx5e_free_rx_descs:mlx5e_close_rq:mlx5e_close_queues"]
 net-next-hw-2026-07-05--16-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]
 net-next-hw-2026-07-03--00-00 | pp-alloc-fail-py | ["", "mlx5e_free_rx_mpwqe:mlx5e_post_rx_mpwqes:mlx5e_napi_poll:__napi_poll:net_rx_action"]


(for my own record)
 SELECT
      r.branch,       
      x.test,
      x.crashes
  FROM results AS r
  CROSS JOIN LATERAL jsonb_to_recordset(
      r.json_full::jsonb -> 'results'
  ) AS x(test text, crashes jsonb)
  WHERE r.remote = 'netdev-CX7-dbg'
    AND x.crashes IS NOT NULL 
    AND x.crashes <> '["kernel crash during test"]'::jsonb
  ORDER BY r.branch_date DESC;
