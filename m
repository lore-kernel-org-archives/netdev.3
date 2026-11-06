Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000247;
	b=DTNzkoByLVCnhzvrixCOM60LF/VobDavfEAY1eVHC91MtNDdpWgHNP0TEMOLTXGwhKNs
	 xzyyH8o92mQvElxFcDPgDL0Fud5iF7sBSypML+UWga13zfqSdFYxzkCzn3hATdB9x5xcq
	 pufWydufNBWNIHEk2wxKyJfmvvBfHbqxZy/eXwx9hUq4NIJ0Mm5YD7god8ATiqLq0bpdI
	 mpeDjcxOAJh/nRju6PKXp1JmK6BtqzpX2LMhyryTW83odVRIxzWZs8/CKDkesJ9akROPZ
	 uS5qn35Nwk+RcfvV94BvbjdnnZWGLk5yuuZ4Pzz/fNnb4PEq/JDJ90Uc51D6ZEgGARw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aeCN6wptuZFxQwxOglBLWghbHtJUYjvmR86PPRTT2kY=;
	b=MgDyMnYr0YRVvR7egzcqNBjXuZkr9tcbTBLtUV0nAVMK9H9jRwiposgYYJU/dqxy5qEe
	 yhA0ebf8yqSwr6YCipMFqvivAy4Jmoh6MpqD52czFrtiwd/0bwJZsoI1uO+/q5YYAkViV
	 N8cmf1lJQZ05wWUWLUlFVagUEzAg3fcfAQkDrnIp54IPw09LHGTagja9cMBT0lhYBFhxh
	 q5pkBvQgbHkh/sXy99OUe2/VsfGsUDKpt8UmX35FVgk4rG87GWDDVUzY+lJb4G+VnYzuJ
	 ih2sCjG6mdpKrWvYd9lIM8brkSans9t0ckTCkzKTjuj/pxyQBpK877m11tUr6TjrgJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2Dekw5X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC09606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2Dekw5X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D31F0089F;
	Fri,  6 Nov 2026 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000247;
	bh=aeCN6wptuZFxQwxOglBLWghbHtJUYjvmR86PPRTT2kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2Dekw5XQD7iDgbVLPvYeZ3ktFd8MjqcWjbhOYlmLsBQw6mIC/AGyZW718s9b5u8q
	 qqs1SY/k5+dqQt/toGGU6PmO/uYNszr3DzGO38w1LVMea7Uoa2xaFJE4z4sKE7Fgjo
	 ivKLoDg6AADapogWZ3TNuL6O9cD/i5tdZ9SxvtwV6wgb5LB0HvEsxu0FbKDVuJHIm0
	 r/AWdyhtecHY2lsaXSbBFAWqw0Af5dUENMhpanVAc9CyRwk6WE4mjtghW7GC6cmy+R
	 6nbsw38M1U55f0CK/4bhjDhQhh9IwIhznHf2Ghcx4jTphMMo9cFTXdiJsdugfUUaOm
	 yaoJUEJRnHOgA==
From: Jakub Kicinski <kuba@kernel.org>
To: willemdebruijn.kernel@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	paul@xen.org,
	wei.liu@kernel.org,
	mst@redhat.com,
	axboe@kernel.dk,
	josef@toxicpanda.com,
	willemb@google.com
Subject: Re: [PATCH net-next] net: skbuff: replace ubuf_info ops ptr with type id
Date: Fri,  6 Nov 2026 13:24:05 -0800
Message-ID: <20261106212405.947546-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103194625.1628600-1-willemdebruijn.kernel@gmail.com>
References: <20261103194625.1628600-1-willemdebruijn.kernel@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: skbuff: replace ubuf_info ops ptr with type id

This commit replaces the ubuf_info_ops vtable pointer in struct ubuf_info
with a u8 type ID. net_zcopy_complete() switches on that ID to pick one of
the known completion callbacks, and callbacks that live in modules are
registered through static_call. The io_uring link_skb callback becomes a
direct call.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f6764117243..3ec9851d0a10e 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -1898,10 +1900,72 @@ void msg_zerocopy_put_abort(struct ubuf_info *uarg, bool have_uref)

[ ... ]

> +void net_zcopy_complete(struct sk_buff *skb, struct ubuf_info *uarg,
> +			bool zerocopy_success)
> +{
> +	switch (uarg->type) {
> +	case UBUF_TYPE_MSG_ZEROCOPY:
> +		msg_zerocopy_complete(skb, uarg, zerocopy_success);
> +		break;

[Severity: High]
Is the indirect call primitive described in the commit message still
reachable through this path?

The commit message says:

  Corrupting skb_shared_info gives a trivial one-hop indirect call
  primitive via uarg->ops->complete.

Take the same threat model: an out-of-bounds write that overwrites
destructor_arg and flags in skb_shared_info. A forged blob then needs only
refcnt == 1, type == UBUF_TYPE_MSG_ZEROCOPY, mmp.user == NULL and len == 0.
Completion goes:

skb_zcopy_clear()
  net_zcopy_complete()
    msg_zerocopy_complete()     /* refcount_dec_and_test() succeeds */
      __msg_zerocopy_callback()

__msg_zerocopy_callback() derives the skb from the uarg address. A real
msgzc uarg sits inside skb->cb, so the derived skb lands in the same
forged region:

	struct sk_buff *tail, *skb = skb_from_uarg(uarg);
	struct sock_exterr_skb *serr;
	struct sock *sk = skb->sk;
	...
	mm_unaccount_pinned_pages(&uarg->mmp);
	...
	if (!uarg->len || sock_flag(sk, SOCK_DEAD))
		goto release;
	...
release:
	consume_skb(skb);
	sock_put(sk);

With len == 0, sk is not dereferenced before consume_skb() runs on the
forged skb. consume_skb() then goes through
__kfree_skb()->skb_release_all()->skb_release_head_state(), which calls
skb->destructor(skb).

That destructor pointer comes from attacker memory at a fixed offset just
past cb[]. sock_put(sk) only runs after the indirect call.

So forging costs about the same as before: one controlled region at a
known address plus a target. Before this patch, the same route could be
reached by pointing a forged ops at &msg_zerocopy_ubuf_ops. Now the forged
ops pointer is a single byte, and no data symbol address is needed.

The other type IDs also hand forged memory to callbacks that trust
container_of():

  UBUF_TYPE_TPACKET: tpacket_ubuf_complete() writes status through the
  forged tu->po and tu->ph, then calls sk_free(&po->sk).

  UBUF_TYPE_VHOST: vhost_zerocopy_complete() writes
  vq->heads[ubuf->desc].len through forged ctx and vq pointers.

  UBUF_TYPE_IO_URING: io_tx_ubuf_complete() queues task_work on a notif
  derived from forged memory.

Would closing this need one of two changes? One is checking that
destructor_arg points to a real object of the claimed type. The other is
stopping msg_zerocopy completion from deriving and freeing an skb (and
calling its destructor) from the uarg address.

> +	case UBUF_TYPE_IO_URING:
> +		io_tx_ubuf_complete(skb, uarg, zerocopy_success);
> +		break;

[ ... ]
