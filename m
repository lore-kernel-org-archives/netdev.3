Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCF7E0E4;
	Wed, 13 May 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631436; cv=none; b=HtSEZe6XDlAoDkdXbs9lqK8JM+3ljlh1D+hf6tp1+hzs5llhF8JDfgahNKO+ygt5i37CzgVM0DPfiiOzJH6aZ4Z9+V1nghEu0j0IxYsLkQuJtWUcg9VSBn7jiyE/34oPjfYDiZg6RBaltUsQq+gLJmhgW4GH75jfNwogqBKW30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631436; c=relaxed/simple;
	bh=utv80Xku51u9uxyE0nWQKe+3Q0uAH0bQnpPwsuzF96s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+346+98bcdBJN73qqFtX7eMB8zxjL3G8mgta3IJ2yzgj30MoNu+He/qrRwK1bJJQ+mb/3oFdtZw6wOqok8wS64AZPOJPYQ1GQUvQyvQKIaeCZAmStU1eR6H+VUpjAGAnC2LjKnfCHR3U6+mZGzmGSLNNOAyB0/8mJEMzmWFXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ10MTMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ10MTMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540D4C2BCB0;
	Wed, 13 May 2026 00:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778631436;
	bh=utv80Xku51u9uxyE0nWQKe+3Q0uAH0bQnpPwsuzF96s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJ10MTMpTtvdLTfZ5yWG6ndwxXXiXNeWfrrtWCjNZ7qGILBaXzkWXbATBVbfzx62w
	 CeUbiTdFFvGZ5K4X7DmulK293Fl7+hImeegon3IsZEyp/U+ySym886zhcNAwAo9pcG
	 Mttp8EWVKazdmxOcISaPK+Botm6JzJsiF6UxXp20kDbzjrB9zsB6+lYAplMW+GaBfr
	 ugvyxD6oL09MQCAO3icgLTwPJ4zcye/xviriuu1C/ycXWyDfzlpTrs5yvs0BfRCj60
	 2PP3uIK7yBWH/Rq/Wdt+Baw80StjHu2bOnTbiYRdAHuFBQPmvVrzkOkpdNsLQOsqdG
	 f78TFPfc/ea8A==
Date: Tue, 12 May 2026 17:17:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>, Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next v10 3/7] tls: Re-present partially-consumed
 records in tls_sw_read_sock()
Message-ID: <20260512171715.078b49cf@kernel.org>
In-Reply-To: <agMiq7CULgkRzd_E@krikkit>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
	<20260511-tls-read-sock-v10-3-279fc5015f0e@oracle.com>
	<agMiq7CULgkRzd_E@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 14:52:59 +0200 Sabrina Dubroca wrote:
> > __tcp_read_sock() handles the same case by leaving the unread
> > bytes available for the next iteration to re-present, though
> > its mechanism (sequence-number re-lookup) differs from the TLS
> > path's explicit queue management. Adopt the same loop-level
> > behavior here: update rxm->offset and rxm->full_len, requeue
> > the skb to the head of rx_list, and continue. The next
> > iteration pops the same skb and re-presents the unread bytes
> > to read_actor().
> > 
> > Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")  
> 
> Fixes typically go through "net", not "net-next".

Just to be sure - no in-kernel reader partially consumes today
without setting desc to 0, right?

If so a more appropriate direction would be to say that in
the commit message and drop the Fixes tag.
