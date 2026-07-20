Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1443BE144;
	Mon, 20 Jul 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559491; cv=none; b=fZax0vyDQOcsQo8tPonvY1wDMZA+Xu6KMm3x1lwVjAd8tSM6sE0OTik7enXWsr4FWjDu8OrHzUXjxwKAScL1NYGX7Npb5O+9uBpNh8RJ/cCNE1w+AqDuMQdJgIfTLs/+XHGuHi2uLKkxeB4Z1+9uCq2GWXFgn3BIS8FJgI2u/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559491; c=relaxed/simple;
	bh=zoumzLEISNSSoXrwrXqvez2z49GpY4BWliGaz5MGMzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSNXn2Zd78zoTAY7ubC2ptUaJKSLGZuakNOZglxYRT5Ry1kGjtiPR0R1X/PCdjPypx2aWp2N4nZTR85wDS8oW3ZuEk/nVHzyXMXm19tEE9vhbdvOtanUfArGuOMOT5LI4FgLYLBi24/ogKZBfWDNGObWgM39JLRReqjy6XlCEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arR+V1q8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arR+V1q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7914A1F000E9;
	Mon, 20 Jul 2026 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559490;
	bh=wQ9RU38/rwClHmnas9Ebsb/6Uy1wdtR4ggVlodhzROM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arR+V1q8Uf7UEzf/ZvJedgbFz349KZ1yRen7me8jATh+UdwP7pH8YAkcv7E/vOA7y
	 O/E3wHopsGl0J/R7HaOpjgEQP3gYuL0T8TjJ3gnNNf/tf52HxDHHDhMxqM40zEhPI6
	 xXIFAcaeFyKv0WQDekw5ARDunYTiSY42p0EUgdyghGLimyiPcFqV9yn0vxmpLmQ2Sr
	 wmUZMegT6x+S+Nv7glgwNHuL8Tc8Uy1XscbJ9FRzmkE0pieKqiFKT7XdXw5brLf8+L
	 XHm+DdE33z/8ebVkFBQmA4A5jzeu02su0C1pOYPF28YcBPV7oQRfjZxTeMe+EppI8G
	 O1tII4HAItnAQ==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net v3 14/14] rxrpc: Remove OOB challenge/response code
Date: Mon, 20 Jul 2026 15:56:32 +0100
Message-ID: <20260720145631.201053-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713081022.2186481-15-dhowells@redhat.com>
References: <20260713081022.2186481-15-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713081022.2186481-8-dhowells@redhat.com?part=14
---
--- Patch [14]: [PATCH net v3 14/14] rxrpc: Remove OOB challenge/response code ---
commit fd3c68debe8844700015aad0c42af18084298daa
Author: David Howells <dhowells@redhat.com>

rxrpc: Remove OOB challenge/response code

This commit removes all the OOB communication stuff along with the UAPI
elements related to them. The reason for this is that there is no actual
limit on the capacity of the CHALLENGE queue, which could be abused
remotely, and it is not actually necessary to generate the application
data in response to the CHALLENGE.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

> diff --git a/include/uapi/linux/rxrpc.h b/include/uapi/linux/rxrpc.h
> index bcdfdf9c67a14..7d6a501519311 100644
> --- a/include/uapi/linux/rxrpc.h
> +++ b/include/uapi/linux/rxrpc.h
> @@ -58,11 +58,6 @@ enum rxrpc_cmsg_type {
>  	RXRPC_TX_LENGTH		= 12,	/* -s-: Total length of Tx data */
>  	RXRPC_SET_CALL_TIMEOUT	= 13,	/* -s-: Set one or more call timeouts */
>  	RXRPC_CHARGE_ACCEPT	= 14,	/* Ss-: Charge the accept pool with a user call ID */
> -	RXRPC_OOB_ID		= 15,	/* -sr: OOB message ID */
> -	RXRPC_CHALLENGED	= 16,	/* C-r: Info on a received CHALLENGE */
> -	RXRPC_RESPOND		= 17,	/* Cs-: Respond to a challenge */
> -	RXRPC_RESPONDED		= 18,	/* S-r: Data received in RESPONSE */
> -	RXRPC_RESP_RXGK_APPDATA	= 19,	/* Cs-: RESPONSE: RxGK app data to include */
>  	RXRPC_RESPONSE_APPDATA	= 20,	/* Cs-: User key holding app data for RESPONSE */
>  	RXRPC__SUPPORTED
>  };

[Severity: Critical]
Does removing these constants from the UAPI header violate the kernel's
policy against breaking userspace?

Any userspace program that includes linux/rxrpc.h and references the
removed RXRPC_OOB_ID or related constants will now fail to compile.

[Severity: Critical]
Can this sequence cause memory corruption and an out-of-bounds information
leak via RXRPC_RESPONSE_APPDATA?

Looking at the remaining sendmsg code in net/rxrpc/sendmsg.c, an inverted
check incorrectly rejects user keys but accepts the keyring:

net/rxrpc/sendmsg.c:rxrpc_sendmsg_cmsg() {
...
    if (key_ref_to_ptr(key)->type == &key_type_user) {
        key_ref_put(key);
        return -EINVAL;
    }
...
}

If a local user calls sendmsg with RXRPC_RESPONSE_APPDATA to attach a
keyring key, receiving a CHALLENGE packet triggers
rxgk_respond_to_challenge(), which blindly casts the keyring payload to a
user_key_payload:

net/rxrpc/rxgk.c:rxgk_respond_to_challenge() {
...
    appdata = (struct user_key_payload *)
        user_key_payload_rcu(conn->bundle->app_data);
    if (appdata && !refcount_inc_not_zero(&appdata->ref))
...
}

This yields a pointer to name_link, and incrementing appdata->ref (at
offset 16) corrupts the keyring's keys.root pointer.

Finally, rxgk_construct_authenticator() reads datalen and data from this
corrupted offset and copies out-of-bounds kernel memory into the network
response:

net/rxrpc/rxgk.c:rxgk_construct_authenticator() {
...
    a.appdata_len = htonl(appdata->datalen);
    if (appdata->datalen) {
        ret = skb_store_bits(response, offset, appdata->data,
                             appdata->datalen);
...
}

Could this allow an unprivileged user to trigger memory corruption and
kernel panic through an AF_RXRPC socket?

> diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
> index 9eb6ca3c5ebf5..9d5ce1c7ad0d2 100644
> --- a/net/rxrpc/af_rxrpc.c
> +++ b/net/rxrpc/af_rxrpc.c
[ ... ]
> @@ -710,23 +710,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
>  
>  		case RXRPC_MANAGE_RESPONSE:
>  			ret = -EINVAL;
> -			if (optlen != sizeof(unsigned int))
> -				goto error;
> -			ret = -EISCONN;
> -			if (rx->sk.sk_state != RXRPC_UNBOUND)
> -				goto error;
> -			ret = copy_safe_from_sockptr(&val, sizeof(val),
> -						     optval, optlen);
> -			if (ret)
> -				goto error;
> -			ret = -EINVAL;
> -			if (val > 1)
> -				goto error;
> -			if (val)
> -				set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
> -			else
> -				clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
> -			goto success;
> +			goto error;
>  
>  		default:
>  			break;

[Severity: Critical]
Does this change break backwards compatibility for existing applications?

An application calling setsockopt with RXRPC_MANAGE_RESPONSE, which
previously succeeded, will now unconditionally receive -EINVAL.

> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 20c10428a50e0..1c6f4a279034f 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
[ ... ]
> @@ -310,13 +305,6 @@ struct rxrpc_security {
>  	bool (*validate_challenge)(struct rxrpc_connection *conn,
>  				   struct sk_buff *skb);
>  
> -	/* Fill out the cmsg for recvmsg() to pass on a challenge to userspace.
> -	 * The security class gets to add additional information.
> -	 */
> -	int (*challenge_to_recvmsg)(struct rxrpc_connection *conn,
> -				    struct sk_buff *challenge,
> -				    struct msghdr *msg);
> -
>  	/* Parse sendmsg() control message and respond to challenge. */
>  	int (*sendmsg_respond_to_challenge)(struct sk_buff *challenge,
>  					    struct msghdr *msg);

[Severity: Low]
Is the sendmsg_respond_to_challenge function pointer left behind as dead
code?

It appears the OOB feature removal leaves this callback, along with
notify_oob in struct rxrpc_kernel_ops (include/net/af_rxrpc.h), the
rxrpc_skb_put_oob trace constant in include/trace/events/rxrpc.h, and dummy
implementations like none_sendmsg_respond_to_challenge() in
net/rxrpc/insecure.c.
