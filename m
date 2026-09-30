Received: from mta1.migadu.com (out-11.mta1.migadu.com [95.215.58.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA332CCC5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790747405; cv=none; b=IoM+0HgFHsRYpT9nwiQDjAXPKLzW5bPS7FF/8JAasaiCGCwBa5OtYUy1qiRDvST+j6VoALoYV09s+ELZKB1nk0GXG/Ax4Gn0eZTK/NqiGTlTEJGVF6pN3fJhCfsNqwX9pqB3m8xw/S0UeOFUaUfy6/XDms02xCLQMifaRD5Qga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790747405; c=relaxed/simple;
	bh=VoUWKhSsc5jAqRZ0m1ClkrcHD3Ijqo+qGS3UdFNAQNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+J8MPxVrCq5kT0duee02+K5LCUx/pFlZNT8AOMNmDpJvItPvklzN2zaGDh25FtwHIXwuuNH3WuknCizbOtZcEnp0rEEO/N43MeWVcv84mQ8NuHBf71FtOc2jLAC3ZNSy8AlU+5glY8VtYsvflae+KtfKadJBdL+HPNN1LuVRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qRhL5b/b; arc=none smtp.client-ip=95.215.58.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qRhL5b/b"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VoUWKhSsc5jAqRZ0m1ClkrcHD3Ijqo+qGS3UdFNAQNM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790747401; v=1; x=1791352201;
 b=qRhL5b/bGptX1wYy+tYW2MR+NTrvxxBREK6ZFx7FcXG67//mGjifld9aPjWIt9W50ng2h2n/
 siN2rGdpz1ClmOfXaVAwAMk/SYy8l4hO+/1NlVmtRTAKB4LzB7RcF1ONE63kRhyRQSVxdl/c/hj
 Mji0UTe8OV9bGqXyLOuqHv9M=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f663c2b6a0792e28;
	Wed, 30 Sep 2026 05:50:01 +0000
X-Mizu-Trace-ID: f663c2b6a0792e28
X-Migadu-Flow: FLOW_OUT
Message-ID: <b3409f74-749d-45f3-8dde-84ba9d135001@linux.dev>
Date: Wed, 30 Sep 2026 13:49:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
To: netdev-bot+sinfo@kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Dave Watson <davejwatson@fb.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chuck Lever <cel@kernel.org>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
 <179074618718.31693.10040628020266132112@kernel.org>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <179074618718.31693.10040628020266132112@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/9/30 13:29, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Quoting Sashiko's reply:

> When an application invokes splice() on a TLS 1.3 socket and a 
> 0-length record arrives, rxm->full_len is 0, making chunk 0. 
> net/tls/tls_sw.c:tls_sw_splice_read() { ... chunk = min_t(unsigned 
> int, rxm->full_len, len); copied = skb_splice_bits(skb, sk, 
> rxm->offset, pipe, chunk, flags); if (copied < 0) goto splice_requeue; 
> if (copied < rxm->full_len) { rxm->offset += copied; rxm->full_len -= 
> copied; goto splice_requeue; } consume_skb(skb); splice_read_end: 
> tls_rx_reader_unlock(sk, ctx); return copied ? : err; } Because copied 
> is 0, the copied < rxm->full_len check fails, the SKB is consumed, and 
> the function returns 0. Returning 0 from a splice operation signals 
> End-of-File to userspace, which would erroneously drop the live 
> connection.

Best regards,

