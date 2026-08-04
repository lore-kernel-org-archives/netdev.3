Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83F3E49FE;
	Tue,  4 Aug 2026 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808255; cv=none; b=RE9mxXCO9bYvQ2bdIvR0HUAvGKzeRUw/FNZk8jT5aX956qBJ+dI+vOmde1SFxbBZ6R8p6XrZ18MIBOSwhkukfsZVB08URRbzSyd2Yrp009fjaQk/zyeoLVka2WOKMjpECsaOYfaX9Ib/I2fcnUKXTQ2TfVjsPHRJeJ1m6m/W9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808255; c=relaxed/simple;
	bh=wI3w53lsSfJ6fnT8nofn8NfQyaw1Afvntp+gsPSFmc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFmwEp2e0qYxu55HbM+W90AvYsxgFrNiOt3kADkIusYb0SpCkSRewriefGCdf0ET0tgfHzcNZez9NZfLibSMuNg6kLBrW0ZH3QP6CO1xkmTgW6rmPBsgHRgUX1pP2HWQDZBDAve1+pzGDfPsR6cMO6J/re0rERXdu9zNRUnRzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWs58wmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWs58wmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C351F000E9;
	Tue,  4 Aug 2026 01:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808253;
	bh=YUSkeSNsZ/aKQ7r+BLgAsDTyW3TI5MZ7GkQDhAlyA7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JWs58wmU+eV9YsRpA16yjstCIX4vpQU0nWYD/WFwQjPCU9BzXDFJdGaRY6h4vb/wp
	 nENRfE9eXMFRRkg2DXgUx7CH97H23nuaFb7SgYcZvH9PA+KgsdU6r4fc8HU9iN2Qhm
	 bNzJp9rvPel87YXC/ox+03O6hGL2DCQEvXWZ7Kfgd9F6VPV9501GVeIikI2yXL6MnJ
	 cVpVX0FJlUxd6Kqq6gFaCXj/ZVUlqdOnzeNrRNloYpI0xG/eLjPWLbTUMRLRWLIrnx
	 SlL95nJd7cIycDCmnu4O7wBvgm6V8TjjmuK6sK5h+lg5i0BLG6xdGpT5Cr++ZPe6tS
	 iA9yeENogB8AA==
From: Jakub Kicinski <kuba@kernel.org>
To: l1138897701@163.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: auth: propagate HMAC calculation errors to callers
Date: Mon,  3 Aug 2026 18:50:52 -0700
Message-ID: <20260804015052.2536225-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730064202.792809-1-l1138897701@163.com>
References: <20260730064202.792809-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net-next] sctp: auth: propagate HMAC calculation errors to callers ---
commit 13a8cd0a9fda699784540030a5b3eada76f4de88
Author: Qing Luo <luoqing@kylinos.cn>

sctp: auth: propagate HMAC calculation errors to callers

This changes sctp_auth_calculate_hmac() from void to int so that an
allocation failure in sctp_auth_asoc_create_secret() is reported to the
caller.  sctp_sf_authenticate() now returns SCTP_IERROR_NOMEM and
sctp_packet_pack() drops the packet by returning 0.

A few questions about the changelog and the new error paths below.

The changelog says:

> sctp_auth_calculate_hmac() silently returns when
> sctp_auth_asoc_create_secret() fails under memory pressure,
> leaving the digest zeroed. Callers then compare the zeroed
> digest against the saved one, getting SCTP_IERROR_BAD_SIG
> instead of the correct SCTP_IERROR_NOMEM.

[Severity: High]
[Finding: main-1-0]
[Sources: opus-5]
This isn't a bug introduced by this patch, but is a wrong error code really
the whole story for the pre-patch behaviour?

In sctp_sf_authenticate() the in-chunk digest is zeroed right before the
HMAC call, and save_digest is a verbatim copy of the peer supplied HMAC:

	save_digest = kmemdup(digest, sig_len, GFP_ATOMIC);
	if (!save_digest)
		goto nomem;

	memset(digest, 0, sig_len);

	sctp_auth_calculate_hmac(...);	/* returned early, digest stays 0 */

	if (crypto_memneq(save_digest, digest, sig_len)) {

If sctp_auth_calculate_hmac() returns without computing anything, doesn't
crypto_memneq() then compare the attacker supplied bytes against zeros, so
that a peer sending an all-zero HMAC field matches and the chunk is accepted
with chunk->auth = 1 and SCTP_IERROR_NO_ERROR?

The preconditions look reachable from the wire: the peer picks a configured
but non-active shkey id, so the sctp_auth_asoc_create_secret() branch is
taken, and only the GFP_ATOMIC allocation failure is not attacker
controlled.  The same path is reached via sctp_auth_chunk_verify() for the
AUTH chunk bundled with COOKIE ECHO, so association setup is affected too.

Should the changelog describe that impact instead of the error code, and
should the patch carry Fixes: and Cc: stable@vger.kernel.org tags so it
reaches stable trees?

> diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
> index 6f2cd562b1de6..eeb3297fe97d3 100644
> --- a/include/net/sctp/auth.h
> +++ b/include/net/sctp/auth.h
> @@ -83,9 +83,9 @@ int sctp_auth_send_cid(enum sctp_cid chunk,
>  		       const struct sctp_association *asoc);
>  int sctp_auth_recv_cid(enum sctp_cid chunk,
>  		       const struct sctp_association *asoc);
> -void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
> -			      struct sk_buff *skb, struct sctp_auth_chunk *auth,
> -			      struct sctp_shared_key *ep_key, gfp_t gfp);
> +int sctp_auth_calculate_hmac(const struct sctp_association *asoc,
> +			     struct sk_buff *skb, struct sctp_auth_chunk *auth,
> +			     struct sctp_shared_key *ep_key, gfp_t gfp);
>  void sctp_auth_shkey_release(struct sctp_shared_key *sh_key);
>  void sctp_auth_shkey_hold(struct sctp_shared_key *sh_key);
>  
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index c901d373af803..4db3a3a4a4574 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -613,7 +613,7 @@ int sctp_auth_recv_cid(enum sctp_cid chunk, const struct sctp_association *asoc)
>   *    zero (as shown in Figure 6) followed by all chunks that are placed
>   *    after the AUTH chunk in the SCTP packet.
>   */
> -void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
> +int sctp_auth_calculate_hmac(const struct sctp_association *asoc,
>  			      struct sk_buff *skb, struct sctp_auth_chunk *auth,
>  			      struct sctp_shared_key *ep_key, gfp_t gfp);

[Severity: Low]
[Finding: main-2-3]
[Sources: opus-5]
This isn't a bug, but the prototype in include/net/sctp/auth.h was
re-indented for the shorter int return type while the definition here keeps
the old indentation, so the two argument continuation lines sit one column
past the open parenthesis.  checkpatch.pl --strict flags this as "Alignment
should match open parenthesis".

The same applies to the wrapped call in sctp_packet_pack() below, where the
added if ( wrapper shifts the open parenthesis four columns right but
the continuation line moves by only three.

> @@ -636,7 +636,7 @@ void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
>  		/* ep_key can't be NULL here */
>  		asoc_key = sctp_auth_asoc_create_secret(asoc, ep_key, gfp);
>  		if (!asoc_key)
> -			return;
> +			return -ENOMEM;
>  
>  		free_key = 1;
>  	}
> @@ -654,6 +654,8 @@ void sctp_auth_calculate_hmac(const struct sctp_association *asoc,
>  
>  	if (free_key)
>  		sctp_auth_key_put(asoc_key);
> +
> +	return 0;
>  }
>  
>  /* API Helpers */
> diff --git a/net/sctp/output.c b/net/sctp/output.c
> index 23e96305cad7c..a7930cd9400e3 100644
> --- a/net/sctp/output.c
> +++ b/net/sctp/output.c
> @@ -517,8 +517,14 @@ static int sctp_packet_pack(struct sctp_packet *packet,
>  		}
>  
>  		if (auth) {
> -			sctp_auth_calculate_hmac(tp->asoc, nskb, auth,
> -						 packet->auth->shkey, gfp);
> +			if (sctp_auth_calculate_hmac(tp->asoc, nskb, auth,
> +						    packet->auth->shkey, gfp)) {
> +				sctp_chunk_free(packet->auth);
> +				packet->auth = NULL;
> +				if (gso)
> +					kfree_skb(nskb);
> +				return 0;
> +			}

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
Is returning 0 here enough for the caller to tell what happened?  In
sctp_packet_pack() the value 0 is already used for the PMTU overflow bail
out and for the alloc_skb() failure, and sctp_packet_transmit() treats all
of them the same way:

	pkt_count = sctp_packet_pack(packet, head, gso, gfp);
	if (!pkt_count) {
		kfree_skb(head);
		goto out;
	}

so an -ENOMEM from the HMAC path is dropped with no SNMP counter and no
rate limited log, and sctp_packet_transmit() still returns 0 to
sctp_outq_flush().  For an AUTH protected association using a non-active
shkey this can repeat on every flush while memory is tight.

This also adds the first post-merge "drop the whole packet" path for the
non-GSO case, which previously always returned a non-zero pkt_count once
the merge loop had run.

Would it be simpler to materialize the association secret for a non-active
shkey in sctp_packet_bundle_auth(), where the failure can be reported as an
SCTP_XMIT status:

	auth = sctp_make_auth(asoc, chunk->shkey->key_id);
	if (!auth)
		return retval;

leaving the packing loop infallible, or alternatively to propagate a
negative errno so the caller can separate a transient ENOMEM from "nothing
packable"?

For the record, two related concerns turned out to be fine: DATA chunks
already removed from packet->chunk_list stay on the transport's transmitted
list and are recovered by RTO retransmission, and the tp->rto_pending /
chunk->rtt_in_progress state set in the merge loop is cleared on
retransmission in net/sctp/outqueue.c, so only an RTT sample is lost.

>  			/* free auth if no more chunks, or add it back */
>  			if (list_empty(&packet->chunk_list))
>  				sctp_chunk_free(packet->auth);
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 708fa07d5fffc..bb89c9b52e0b0 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -4455,9 +4455,12 @@ static enum sctp_ierror sctp_sf_authenticate(
>  
>  	memset(digest, 0, sig_len);
>  
> -	sctp_auth_calculate_hmac(asoc, chunk->skb,
> -				 (struct sctp_auth_chunk *)chunk->chunk_hdr,
> -				 sh_key, GFP_ATOMIC);
> +	if (sctp_auth_calculate_hmac(asoc, chunk->skb,
> +				     (struct sctp_auth_chunk *)chunk->chunk_hdr,
> +				     sh_key, GFP_ATOMIC)) {
> +		kfree(save_digest);
> +		return SCTP_IERROR_NOMEM;
> +	}

[Severity: Low]
[Finding: main-2-2]
[Sources: opus-5]
Does the new SCTP_IERROR_NOMEM reach both callers of
sctp_sf_authenticate()?

sctp_sf_eat_auth() has an explicit arm for it:

	case SCTP_IERROR_NOMEM:
		return SCTP_DISPOSITION_NOMEM;

but sctp_auth_chunk_verify() still collapses everything into a bool:

	return sctp_sf_authenticate(asoc, &auth) == SCTP_IERROR_NO_ERROR;

so on the delayed COOKIE ECHO path in sctp_sf_do_5_1D_ce() an allocation
failure is still handled as an authentication failure:

	if (!sctp_auth_chunk_verify(net, chunk, new_asoc)) {
		sctp_association_free(new_asoc);
		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
	}

The same helper is used by the ASCONF and reconf paths.  Isn't this the
NOMEM versus BAD_SIG conflation the changelog says the patch removes, and
should sctp_auth_chunk_verify() be converted to return the ierror so all
callers see the distinction?
-- 
pw-bot: cr
