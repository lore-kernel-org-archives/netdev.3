Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A2146A66
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804711; cv=none; b=EooDWapRuFiw8ZcTAlu7zqT+C+9YCt+I7OEkP0CnB/iJq6Vv456m2R017lX6Jj/kMvFgcf+wm77M0x1kr94yAHPZCQZPuZQqG9XKygiy0GOryyVOPNXBO4j2zcELaAGRixeOqXab4PHfGMpKj0eiMmmQjacZI2BTV6jsLVU3uOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804711; c=relaxed/simple;
	bh=hq4fxe09NX0xzjImkyMX8yU+82mfvDqSj6+AVV5ALbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTm5MRk1wXIMoYMhotuiq65qFStNNkhjx9xzMvoC6rsynNkCQZzjlLxN2z6StX99qcGuTxExHygU2MdNmeU1eQoLhbeBZtSYPkyQH0CCSyWvaiAhF0cf6Oo0bqXv+jdZIXsaLmfdWnFmIwV4STuHSaM4whgDYTPB0sgcgzK+fgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI4Ez034; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI4Ez034"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB67C2BCB3;
	Fri, 15 May 2026 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804710;
	bh=hq4fxe09NX0xzjImkyMX8yU+82mfvDqSj6+AVV5ALbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RI4Ez03482UwWIJjJi09DVYMCp1TmAAHL+grOHCt48uJibXWyd7WtrjU605opIoRU
	 m8nfmNyoTIGNDuqK9Vjy7fWzCAQAkwmdbRdB93AjHVbvonabdC+MKdbxtXaAon8JiE
	 zpxp6hK9/LcztzgzRqtKG9RvwvS0snJEiTwS8gF6Eh5fvVSqo5bsVcJuv0CPLw/avr
	 McP0R15bAwK0gJY6VBboIkS/qtso5xOg4DLvacwzaYK7WzbdAh9KZw3XwMN5txGsrG
	 XKQkLk/JPeyEPu+GqkirKV+EKXUSvjWPmHeOWjucQ9xEkonomzHMvmc1M8m5gJ0JKa
	 DURGXoN4i4Vfw==
Date: Thu, 14 May 2026 17:25:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling
 ISN prediction
Message-ID: <20260514172509.4b38e684@kernel.org>
In-Reply-To: <20260512175250.346486-1-edumazet@google.com>
References: <20260512175250.346486-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 17:52:50 +0000 Eric Dumazet wrote:
> Fixes: 41eecbd712b7 ("tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b9edb0d1342319d4340c0a9997eeb..93c6072c97b65ebabb5dd0245edff0728ff082d1 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1066,6 +1066,7 @@ struct sk_buff {
>  	union {
>  		__u32		mark;
>  		__u32		reserved_tailroom;
> +		u32		tcp_tw_isn;
>  	};

for better or worse I gated our CI reviewer on build issues, and this
generates:

Warning: include/linux/skbuff.h:1103 struct member 'tcp_tw_isn' not described in 'sk_buff'

If you repost could you change the reporter to Chris Mason
<clm@meta.com>?
