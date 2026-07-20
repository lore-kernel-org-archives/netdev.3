Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724323ACA41;
	Mon, 20 Jul 2026 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559255; cv=none; b=uIO3C3XzBWEr543TO3V3tCiv9PX8ga38Zu6QpmbBGjElhsu8DgsD6ovL6XyFpa5MYvXKnHOsWSMc+QsROv5gfAapcwNQcl0/hi9K3vWOePq0/5irv35baBQqFdzYWBQ2MAE7+/0i3iH41K0s4LdqE2ahaPiVSBbnbVc/4zGsiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559255; c=relaxed/simple;
	bh=0nbIRLoRNP6CIzPbZ7SErpn13oVvgq1q3LnuvwxeW+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcoFB9uEqmCweuQgAzs15wrB4NkKG4oLgkO75XFO5881bZc5yWJErEpdY4dhe3qF8WQBmFON0wxq2o1mO2Y+comlbyvVjs9uBs8Jat1lv5x4EmnymtyKKMJ5A5L5VhYlTU6gNTCnC9j/7gBq+ZEZhKR55kOxUj0natYl5n37YuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFXNGUWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFXNGUWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E11D1F000E9;
	Mon, 20 Jul 2026 14:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559254;
	bh=1MIG1B5/55Hz+bD8escksfLFOSFF1o9zAVoYtgBN3lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFXNGUWnIHXSpLnXbRfIeg9kH2m23Vyy3wIcNb+oY/qVSUsDvrtPMb16E8lc5Xe0e
	 7CeFlsLnGrD2UE3wY1OHE0sHCpBbdXpMp/G/U6UHfAejpeMF5UWhdyB6gez0fEb3bC
	 Zrd8fKwt26AE+P5vJ6MmPwT2nEb/93ISSNoQi7dtEVVlYWCWpP0wD10WKJQa0BH7e7
	 kCaVH+XGUAWrBw33QwlbgHmhq50XOqPiMzTAyNBXDM2bDdnSNVROdiQDofqAEs7hPy
	 FFFnOPGRLi3cKTHBdzzMBIvFhK24P/a/31dAcsqgigiWS/kkkgFX+53JJzT2LOG+DT
	 MX2i4XWpwtBeA==
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
Subject: Re: [PATCH net v3 12/14] rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
Date: Mon, 20 Jul 2026 15:54:08 +0100
Message-ID: <20260720145408.195916-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713081022.2186481-13-dhowells@redhat.com>
References: <20260713081022.2186481-13-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713081022.2186481-8-dhowells@redhat.com?part=12
---
--- Patch [12]: [PATCH net v3 12/14] rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle ---
commit 6a78aabb95a0cb45b9da0216dba46c2925209a22
Author: David Howells <dhowells@redhat.com>

rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle

Currently, when a CHALLENGE packet comes in, it's queued in an OOB queue on
the AF_RXRPC socket that generated one of the calls on that connection for
the application (which might be in userspace) to service. The application
then picks up the CHALLENGE and requests a RESPONSE packet be generated,
allowing the app to include app-specific data in it if appropriate.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index 48519f0de1853..5cbfa7b223e01 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c
> @@ -81,6 +81,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
>  		bundle->local		= call->local;
>  		bundle->peer		= rxrpc_get_peer(call->peer, rxrpc_peer_get_bundle);
>  		bundle->key		= key_get(call->key);
> +		bundle->app_data	= key_get(call->app_data);

[Severity: Medium]
Will this bundle lookup logic reuse stale app_data keys for new calls?

When rxrpc_look_up_bundle() compares connection parameters, it does not seem
to check bundle->app_data.

If a new call provides a different app_data key but otherwise identical
parameters, won't it match an existing bundle and inherit the previous call's
stale app_data instead of establishing a new connection bundle for the new
data?

>  		bundle->security	= call->security;
>  		bundle->exclusive	= test_bit(RXRPC_CALL_EXCLUSIVE, &call->flags);
>  		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 71343998b87d1..cdf35440317d6 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -614,6 +617,22 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, struct rxrpc_send_params *p)
>  				return -ERANGE;
>  			break;
>  
> +		case RXRPC_RESPONSE_APPDATA:
> +			if (len != sizeof(key_serial_t))
> +				return -EINVAL;
> +			if (p->call.app_data)
> +				return -EINVAL;
> +			key_id = *(key_serial_t *)CMSG_DATA(cmsg);
> +			key = lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
> +			if (IS_ERR(key))
> +				return PTR_ERR(key);
> +			if (key_ref_to_ptr(key)->type == &key_type_user) {
> +				key_ref_put(key);
> +				return -EINVAL;
> +			}

[Severity: High]
Does this inverted check reject valid user keys and cause a regression with
memory parsing?

The user API expects a user key here for the RESPONSE app data. However,
if a local user sends an RXRPC_RESPONSE_APPDATA control message via sendmsg
and provides a valid user key, this check rejects it with -EINVAL.

Conversely, it accepts any non-user key.

When the subsystem later attempts to parse this key's payload, won't it assume
the memory layout of a user key payload, leading to out-of-bounds reads or
memory corruption?

> +			p->call.app_data = key_ref_to_ptr(key);
> +			break;
> +
>  		default:
>  			return -EINVAL;
>  		}
