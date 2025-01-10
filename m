Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4F22257F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553056; cv=none; b=QTjEskbGUq+X9VyaTddetz/5o6QpstBf4HevaUL2Ad4NdcHqAvEW+o9//nCS8A+VF9cdNiglwuowCuqts8BlPhD8zTbuTsE/6kkBGrFJeMKydWxmsnjwH5r411QscaaYGFseaeUJlZiQWw3VAdGq8t+umSSr1kTpLz/VDj9XDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553056; c=relaxed/simple;
	bh=KiooUqLri6RujPzP4jRHhQ4MQmnOY9RsfSZqN7DBPyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVG/+5f2cfFdoDTEp7hYdxmKSqSEuCmQsjlYD/RSWzfNqjznJ97qplZKdPRb9+r0wIvGfUVfC3F5G7P4AcquJzG9UzyCkH+Kl6c8PJi+0Bh5SXzyaUwf5PBlwOiWSj/Mal2O7bw1zIOx1X1uvRssUOz40fVFMuMwhkvCnMsHONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DA8Lp4Y6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DA8Lp4Y6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3FC4CED6;
	Fri, 10 Jan 2025 23:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736553056;
	bh=KiooUqLri6RujPzP4jRHhQ4MQmnOY9RsfSZqN7DBPyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DA8Lp4Y6VPF3EDNdq2+UPWe72DOMY/bSpUcDED/s/Z5IEnUvOJtu7QsFEznOixaP2
	 WNV7+WsnrVMcQhlC25pvSPO96T156/KVza7Pj0z7Dep7rO6mmoMNoEuuUpbMZzC/4q
	 8KCN01SfjdAqkI8nINFBjDo0LokWyB6gEBycc2EUl1QRhzQgLWLNIiqYQY+8UMUT+O
	 ciD123MBcBqobGpluEOwmMqj9tJUaIRRqW8ESDL+QqyQV4HQIH3DWxp869ObSXfbc8
	 AsG6HK0Km32bLpFSyfWB9e7pyQmCzp5MIA+dKgaxZyh/hdYYANF7//vO6h5j0vvSA4
	 2IWdCANhSRaEQ==
Date: Fri, 10 Jan 2025 15:50:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, petrm@mellanox.com,
 security@kernel.org
Subject: Re: [PATCH net 1/1] net: sched: fix ets qdisc OOB Indexing
Message-ID: <20250110155055.04ddaa2d@kernel.org>
In-Reply-To: <20250110153546.41344-1-jhs@mojatatu.com>
References: <20250110153546.41344-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 10:35:46 -0500 Jamal Hadi Salim wrote:
> Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> 0. The overflow may cause local privilege escalation.

ets_class_leaf() does not nul-check the result, which crashes 
the kernel during selftests.
-- 
pw-bot: cr
