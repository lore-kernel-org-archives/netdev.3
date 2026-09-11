Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83249310645
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145373; cv=none; b=FFHCjvxedZonMsFGFNAxFKj5AezKqvBxL8jlrwsgZpmVyGwYlTbfS2yJMnZdS4N1X93h94Pe1PIZ5aJv04FxPN2UChPOUyUKRPZ8l3NB3Z3WWf5xbsT+sV4IvQckVcP9xVMqL8NApYyCGseLZJqJsWf3bJliuUm7q/KNKNbHLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145373; c=relaxed/simple;
	bh=I0P0XxYFctuE1Z+YAlASNTt9bH4FEqviQVcmVf+JiUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grsi8ABRza+0TxLsVDJb2ZXdnOK8Lz339cpk9W+fPc8PicoeQVFeF5d86ZNIky9iKTFwB5lmQOdd49OpgLQe/wWYVBqPTjQjkXy4caNCc3eDKTjw9FRzvprkgkAAOO20ST7HF+/SqEk31gwbDCsDsPBo7gQwhxuPXRX0KlkmGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHAERzQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHAERzQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19051F000FF;
	Fri, 11 Sep 2026 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145372;
	bh=cXyTqqhnt3d1dFns1NpXupc9bnB5E+VEUFlDsFv1UDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QHAERzQAUffKIIoV9ccuFsZiLekNp8iPULUzrUtJEAyvZ6bKl6/b36UCHzZzL1dvW
	 cIbJL/tSyLOn88sMTZ8iJApaEA2VxDuLlMXHPz/cvbTtHtTv5Qe9YLNii1ztPzaICR
	 mUsxuvwrIVCC6vqRuCq/0w15Ugbqf2q5VagWJBsydhaAYDwAwKvBSaWD+vvt4Vbfdb
	 7qxJueKwrTC2U9wbBHijE1cdeu7YW/MiPL3WKFDd9UHWVROUC079xBlgvvVXJEl5gh
	 hdlv2FersEJhOQ9gYobd9pQl3HMTp41y1D4iIeqRrvlFNaoAwCqb9OXx4aqOPRJUY4
	 eG3KKC5G+CvYQ==
Date: Fri, 11 Sep 2026 09:49:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, James Burton
 <jamesburton@meta.com>
Subject: Re: [PATCH net] netlink: do not free nlk->groups while lockless
 readers can use it
Message-ID: <20260911094931.12e0339e@kernel.org>
In-Reply-To: <20260911160804.917099-1-edumazet@google.com>
References: <20260911160804.917099-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 16:08:04 +0000 Eric Dumazet wrote:
> +	/* Publish the new bitmap and its content: pairs with the address
> +	 * dependency in lockless readers, which can pick up the new pointer
> +	 * while still seeing the old (smaller) nlk->ngroups.
> +	 */

What do you think about the value of these comments, Eric?

> +	smp_store_release(&nlk->groups, new_groups);
