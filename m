Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC03C3438
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144725; cv=none; b=IqYsvfaOXnXZMOWy8boqzotcGYRvdq636PbnNb66l9uCc0cEmMYMkrchGaHb2tynJB94t5Q4Ev8VetX6z5HvVbcnM3HAFui9f0GmQO/RirmBtUVeEL3V9goJA32sS6uJa/PVVWW6yDlYnOy0SOoqPhLkOe1febKC6w+7ovpdcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144725; c=relaxed/simple;
	bh=d3HZYqSyo9R7mDsZV7CtyOOiJ3DKUyLBdIZ9KqXDsHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwOrmvUMomYeZ7gDDRmr8lTSkDmNc8Rl6exYjfOZGfaiP4axNwS/viUCvJf+fg5j+enNmVK10buKiDSKaLdKZR3RtqZG8BzhV2pfycC3+mO3Wu3F9PJBNEYBGEjgbARp2VojwfXZpLJ+VY74DRCJpY8hL3nopCxt/zP3Jtd7vAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AN9l3OuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2dqJtdR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AN9l3OuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2dqJtdR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A3FF140016F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 05:58:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 16 Oct 2026 05:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1792144721; x=
	1792231121; bh=FfE4leAnjqhOPJPlsRZ92wXb5J9iUlFNfB8UzFcYtRg=; b=A
	N9l3OuHfv6F1JqW9R3NaFqQAav5atoa0ogdeOXM8wTx8DuI0JKa5Wo214JYvxCJt
	7x/5/ym/caZeL8gWaBIG9MZZEXkFMooZn4kfgovTvf6sH6qZMVn2i9WOAFlAzU0G
	KKCGEIHgIPOcE/mMc8Eolz9Tw83+7MdNOtq/wMrbQdoYQ9gAbiXR2FFa/OtvKK6U
	4AwkZq/cEZ8H+DIFpr8l6D1fch37ZXwsz8TfDXjpBTVr9j/No9ftp0o6t6T8aKSz
	YDC3xDFXd/Bzn+0W/ymoceSs8+zvfzCqwPoVhf/sCPcJodfh6oQCqWRlvmyJJks1
	INrK7eeI9tdGJNCCbKXkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792144721; x=1792231121; bh=FfE4leAnjqhOPJPlsRZ92wXb5J9iUlFNfB8
	UzFcYtRg=; b=L2dqJtdRdZzLnN8ODfXruoGg+dbJIRl8XdAqVcqJWxIP+yL5dMs
	rrBlAmF0CJ1PBePCCQDxjbMbnFK+0c28vrMCOuxGbFFHZ0lfBwQlY3a8GjvBxASN
	3+1JGPYtKp1yNAJwjEuyf/s64GsvFM0EmFC8DJ/KLREHXCs1lBwWIs4oKzsltrG7
	RijvDADCVxYWcbQvlxWFxLozrSNGgZHPvmAC4GtpiWM8GwMoiE03/3IJRdOLIB1r
	YgzOdXYfHHRplCHCIKpjLzR0WyHybc4PTICL4AG4zefaMhWFId0gwFlSBK2V1vEz
	ZWxUYq8hfIm5sEiJYgOdQu0412bEqqMgkJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792144721; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gHTSo5aGnr6VTIwp54MoMGgGUM/mTBqJ/rRA5M9vebc1jww
	6M/6uY5UFnBwx3hp+dxbMmwQQnppWN2njtUYlz9fKZD/NaE36bfesworgmsaTDGo
	oCgBTy8ngRjD1iKKPqP6e6PyvEKGz3kwZcXNUiE1feQ2nMYwUAdJs1WVe63UEciz
	qGjUOqhHn1gb2bYlFA1ALyje2UXXOSn/4s8OCEh4lutpE0Vm4dDiXK/dlO9K1LFv
	KUxjcjy4mFUmuFQzsKxiJEbfHWUecPn2wG2yJ9cvE7/VNhvxPU91xSt2WVJ8hbVS
	PPJGOXfwKl7SKtzaIfjhj5UQBnbcEbSwkVww60w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:3c8eETQjnB5bemJdklvEl2KSSrtrFFVvdfCeZ9cyDak=:d3HZYqSyo9R7mDsZV7CtyOOiJ3DKUyLBdIZ9KqXDsHY=;
X-ME-Sender: <xms:UfXRapbT1Noa_P8zb-J3hGdskl3O6DMQ6WvZlGwlmfrfaFHc2P4LaQ>
    <xme:UfXRalWQi5LI_A58Gf_V1WarlCy1AXVrUpyPNT2BE0WepeYOmbmSXMEWlV-V9Y39x
    mzq7E9YuN-RlI04ObbfM1I1HuqsJtzhiJN8PLLMEMKXjlGa7dMr89O->
X-ME-Received: <xmr:UfXRagMC9Q57u3AQz4bRKcnfk2VI97PmKpVYYt2ieeR4l61ctB2OX2SWuMQ>
X-ME-Proxy-Cause: dmFkZTEalc+JwHTaDsYr/KJN09Yw5q3d421DRXB+xvI4ce/DomeFbmxIRGgVYvDeMdtEMR
    oFTpR/lG3kq8KyN5S2XOArx0qMUuX+AEWTLfcTzbfKEymBJsIVuJvIFj2IcF6aR74pH6HG
    Yg3NUClONser2GRuG7SQQm/lV1uedyKJBJMRnaYIYNcSIhJmQpwmC8kN3Ws+9QG9MJIQmQ
    BpNVRJQ/tMGK9EekdKJuxcwGKjkjBxk+SiBzp5vzEEYKWcIw+psp31VhxGeGbknnsNQ0ba
    yCVZpelGpjS0bRrrpvh/+W+d88/TRaIPR8Z2u2zv8nKK3dGnBn62D6dgoMs9nOx9naSPtk
    T0jD9kmKBWHJIFPyDFLwpvfB8GJBDaxTtNXasvCYItl6nEueD+2lk/uLmoKVPr9SWy99Ax
    NMiPSWgCLenwNJEeb+o5pq6AZekj4uhVYy/bm2o+GS/+9hf4aLiza2bIbIYTC3ovrkY8xa
    SJHfD+R323dO7mgWs2b7FMWzf7V8tlB4ZU/6O9nVPj7FPmzZLGVA8W7hjG1JNDtZz5/8g4
    iE+PBrYWRbAX+2fQtnk3cqYxs5oSBdib1N+woEkwSytjt5UIAXVROKLQTztuYj4JSW3H+m
    O24v0qOxD2TyR4d1IvILPDlkR7+5IJEkqy0kzM89y5yYFTBGlvlQ7wcBopGg
X-ME-Proxy: <xmx:UfXRanZDhgTh9ScAR4SH-94Slqn_nSErS-xx2ef4A3T37aBxETHPvA>
    <xmx:UfXRan-5ldtvKbYdFaBF3IDAtxTsAV72036azXz9jXlMfARXHdvqkQ>
    <xmx:UfXRagT8R55ZNUSLcUOUR8u0kVySOVXGAI_3BFQZUUDsH-2H3-to5Q>
    <xmx:UfXRapceaFAddJebJEj6QZCXI_KlK7M-7y4xUzANoOLk-LswDz0bRA>
    <xmx:UfXRatB6aw8efro-6jRwa4BCJSSG3llPSr5Ta7QpH-JdV54Qs-aVAKJL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 05:58:40 -0400 (EDT)
Date: Fri, 16 Oct 2026 11:58:38 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: only install push_pending_record for a TX
 context
Message-ID: <atH1ThJGVObmpeKT@krikkit>
References: <20261016042604.357739-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016042604.357739-1-rjethwani@purestorage.com>

2026-10-15, 22:26:04 -0600, Rishikesh Jethwani wrote:
> tls_set_sw_offload() assigns ctx->push_pending_record for both
> directions, but the hook is a TX-side dispatcher. On a socket whose TX
> side is HW offloaded, tls_set_device_offload() installs
> tls_device_push_pending_record(); any later TLS_RX setsockopt overwrites
> it with tls_sw_push_pending_record(), because tls_set_device_offload_rx()
> itself calls tls_set_sw_offload(sk, 0, NULL) for the software half of a
> successful HW RX offload, and so does the fallback when the RX offload
> is declined (NIC with TX-only offload, tls_dev_add() failure).

This makes sense. Some comments:

> From then on tls_handle_open_record() (a TLS_SET_RECORD_TYPE cmsg after
> a MSG_MORE send, or the close path with a pending writer) runs
> tls_sw_push_pending_record() against priv_ctx_tx, which is a
> struct tls_offload_context_tx, not a struct tls_sw_context_tx, and
> reads open_rec from inside the offload context. On x86_64 without
> lock debugging that field overlays sg_tx_data[2].dma_address,
> which is never set, so the push is silently skipped and the data

Do we have arches that support TLS offload but use dma_address, or
where the struct layout would allow something more harmful than "wrong
payload"? I'm worried that we could access some random address for the
open record.

But on its own, the wrong payload within a TLS stream seems bad
enough, I think it's worth a Cc: stable tag.

> buffered by the MSG_MORE send is later sent under the cmsg's
> record type, e.g. application data in a handshake
> or alert record. With a layout where the field lands on a non-zero
> value it is dereferenced and fed to bpf_exec_tx_verdict().
> 
> Only set the hook when initialising the TX side.
> 
> Found by code review while developing TLS 1.3 HW offload
> rekey support.
> 
> Tested with HW TLS TX and RX offload on Mellanox ConnectX-6 Dx
> (Crypto Enabled): after setting TLS_RX,
> send() "AAAA" with MSG_MORE, then sendmsg() "BBBB" with a
> TLS_SET_RECORD_TYPE cmsg for a handshake record. Without this patch
> the peer receives a single handshake record "AAAABBBB"; with it, an
> application data record "AAAA" followed by a handshake record "BBBB".

If we already had selftests for offload, I'd request a selftest for
this.

Would it be feasible to extract the non-1.3/non-rekey bits of the
selftests you have in your 1.3 offload series? Those would be valuable
on their own.

> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
> This is independent of the TLS 1.3 HW offload KeyUpdate series, but
> that series' TX rekey path (tls_device_start_rekey()) calls
> ctx->push_pending_record() and depends on this fix.
> ---
>  net/tls/tls_sw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d1ad31986cf2..b3fe153c3c68 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2591,7 +2591,12 @@ int tls_set_sw_offload(struct sock *sk, int tx,
>  		}
>  	}
>  
> -	ctx->push_pending_record = tls_sw_push_pending_record;
> +	/* The RX path shares tls_context with a TX side that may be HW
> +	 * offloaded and rely on tls_device_push_pending_record(); only the TX
> +	 * setup owns this hook.
> +	 */

Please, no. If I see "if (tx) install_push_callback;", I don't wonder
why we install the callback or why we install it only for TX.

> +	if (tx)
> +		ctx->push_pending_record = tls_sw_push_pending_record;

-- 
Sabrina
