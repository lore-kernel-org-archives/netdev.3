Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C77262E
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785463857; cv=none; b=COuN91rCgNPaagMYGg/zZCzTPEqubMdRzMKl/ucBNDUWIKv+PgILbwVoeJUHfUYRMGOHACDVUIumlpEwx1XzayijmTCH6eV1P/k5DJMEw7QLz9BSMxaG31ywG7hl4e/bWx07RYNggCN5hye1WbXG6EO9Rn7Ee1MSk5RkkwWJagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785463857; c=relaxed/simple;
	bh=laaDGR8OD4JUMLPIL/IM/G66XrvJzCKytq92XGT2G9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcFS/uJj4Wqg/1reR+BtxeVWbgZALNwbvrTlIuVfL2aUd05Lddt4s075aV+3nKy2RYogf6oLjoiOwJQhKNvoRdwBiuBjfoUZsppnohVqZkMsFmAVV2adIZ7tu81g+zdbeclsuCY1AhLRbzEaXST1VhghHUui2GVStzdAk7P/PoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9SpMXD9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9SpMXD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52731F000E9;
	Fri, 31 Jul 2026 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785463856;
	bh=laaDGR8OD4JUMLPIL/IM/G66XrvJzCKytq92XGT2G9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D9SpMXD9FlkVEMbCKg6S1UQYGlx09rwPXcb0tcp1rcWCAG3+rSvRZn36G9A8yvKPm
	 dDy2QYmuGkfBVkZBFUjj9QUMqriUHsVIuxepBEkvBGQwlFcfWIuNoUd15lNjzezxY4
	 WBLWkc3De0h57PNhRmUo177OSXQwfxw9BKp4ch7cGCEOubJXHf/m1afw4BbgUqQlJw
	 9/Nvd5HnDh6qWjdN0M6mdeLurvquoXRLVqSX6QwiwynUGgS9b/iaPDLD8+jA/3GJgX
	 Iz/pjymS0P8YBuECAcwuoyIa3xsyb8M0MmYqkKMO/ZdCkLVd3sZ8yv92x5kDNUH539
	 QzEjZkTQ3iHWA==
Date: Thu, 30 Jul 2026 19:10:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, kerneljasonxing@gmail.com, kuniyu@google.com,
 bjorn@kernel.org, bigeasy@linutronix.de, jiayuan.chen@linux.dev,
 willemb@google.com, jlayton@kernel.org, gustavoars@kernel.org,
 michael.bommarito@gmail.com, runyu.xiao@seu.edu.cn, kees@kernel.org,
 lirongqing@baidu.com, vega@nebusec.ai
Subject: Re: [PATCH net 1/1] net: skbuff: reject skb header offset updates
 that truncate
Message-ID: <20260730191055.2dabc26f@kernel.org>
In-Reply-To: <06ac032651d91cfe4b2e246f6fc36e3d4b2f87d1.1785346409.git.zihanx@nebusec.ai>
References: <cover.1785346409.git.zihanx@nebusec.ai>
	<06ac032651d91cfe4b2e246f6fc36e3d4b2f87d1.1785346409.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 18:40:33 +0000 Zihan Xi wrote:
> raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before
> storing skb header offsets in 16-bit fields. If the reserved headroom
> grows past the representable range, skb_reset_network_header() truncates
> the stored offset and the hdrincl path later copies the user header to
> the wrong location.

Breaks a bunch of tests, quickest repro will be udpgro_fwd.sh
