Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C627332EB2
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163658; cv=none; b=F+fX97yaQYx/QxAuZTfLCvNhmKKBqs/hEgNVQMXEU+eQZYqcDxxQp8x9nN/2R6sq+6RuzIkV50bopGcRMkRDeM1lcHYh/4fXMqTcam9aJRfzwTKO3XuxkXN/4IpgAaF5noJ9KqWrgoze+9UY+CF6cHJaog4VCFV6lhiNS409wxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163658; c=relaxed/simple;
	bh=+vbHfHwdsKnpbLquZfeI79yyBZMPIGvPvvw1WFUVIOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5qUt7oKH3e26GBxTmoKMb9kyUmh8KLZCql6ACTkgmaWFSC8KR/x5zsz+lto17GavlbEIukKZnSPDkeKQ6wUBOQT0DkLAse3aeUl0gnvhR3+iALCzo3MA1Hm5X++zI1Rwe1OzvZPOZYoxCMWZRc9HLKgnBhrjDFj8oKJVdd8Aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGUvyq8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGUvyq8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6F9C116C6;
	Fri, 27 Feb 2026 03:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163658;
	bh=+vbHfHwdsKnpbLquZfeI79yyBZMPIGvPvvw1WFUVIOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CGUvyq8GEAz6hq+3Ga3jasAClyKH9lDYjlmwhX+ErFH1wztY/Ffkw33+Sl3SV1aTS
	 aEspxckCDr/oJ9YKp6BkGLKEy2foGzWy7LQZS+RzYV3Pt9pLDPSVlVEeBXkdDJ8EAc
	 UEEuXJT8bxpj3+1q1pLtCXjYqfOThlGT3CScZaFQiN7e/+cXg/eSJmm9Drazcd4Mu9
	 koInN6q+XmdESMfScr19eSQP5qx7k2UJSsU5Tbl6aXC53y2mYKtS4LGpGU2lYruPQy
	 jnfJRFvGXnq0IZLZDKMJg58FfOhAHd/BTefn+SaLuHbHnwJ6Vj2MbtQaYbo8YfhDIs
	 PdjKYcECdbbKg==
From: Jakub Kicinski <kuba@kernel.org>
To: kuniyu@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	kuni1840@gmail.com,
	edumazet@google.com,
	davem@davemloft.net,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	lulie@linux.alibaba.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [v1,net] udp: Unhash auto-bound connected sk from 4-tuple hash table when disconnected.
Date: Thu, 26 Feb 2026 19:40:56 -0800
Message-ID: <20260227034056.2605149-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225002709.156882-1-kuniyu@google.com>
References: <20260225002709.156882-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
udp: Unhash auto-bound connected sk from 4-tuple hash table when disconnected.

This commit fixes a bug where disconnecting an auto-bound connected UDP
socket leaves a garbage entry in the 4-tuple hash table. The socket is
now properly removed from the hash table when disconnected.

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b96e47f1c8a2..3388e4ab9056 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2321,15 +2321,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
>  		if (udp_hashed4(sk)) {
>  			spin_lock_bh(&hslot->lock);
>
> -			udp_rehash4(udptable, sk, newhash4);
> -			if (hslot2 != nhslot2) {
> -				spin_lock(&hslot2->lock);
> -				udp_hash4_dec(hslot2);
> -				spin_unlock(&hslot2->lock);
> -
> -				spin_lock(&nhslot2->lock);
> -				udp_hash4_inc(nhslot2);
> -				spin_unlock(&nhslot2->lock);
> +			if (inet_rcv_saddr_any(sk)) {
> +				udp_unhash4(udptable, sk);
> +			} else {
> +				udp_rehash4(udptable, sk, newhash4);
> +				if (hslot2 != nhslot2) {
> +					spin_lock(&hslot2->lock);
> +					udp_hash4_dec(hslot2);
> +					spin_unlock(&hslot2->lock);
> +
> +					spin_lock(&nhslot2->lock);
> +					udp_hash4_inc(nhslot2);
> +					spin_unlock(&nhslot2->lock);
> +				}
>  			}
>
>  			spin_unlock_bh(&hslot->lock);

Is there a hash4_cnt accounting mismatch when inet_rcv_saddr_any(sk)
is true? The udp_sk(sk)->udp_portaddr_hash is updated to newhash at
the start of the function (before this block):

void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
{
	struct udp_table *udptable = udp_get_table_prot(sk);
	...
	udp_sk(sk)->udp_portaddr_hash = newhash;
	...
}

When the new code calls udp_unhash4() on the inet_rcv_saddr_any(sk)
path, udp_unhash4() computes its hslot2 from the already-updated
udp_portaddr_hash (nhslot2):

void udp_unhash4(struct udp_table *udptable, struct sock *sk)
{
	struct udp_hslot *hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
	...
	udp_hash4_dec(hslot2);
}

But the original udp_lib_hash4() call during connect() would have
incremented hash4_cnt on the old hslot2, not nhslot2. This seems to
decrement hash4_cnt on the wrong 2-tuple slot when hslot2 != nhslot2,
which is common for wildcard-bind + connect + disconnect.

The else branch correctly uses udp_hash4_dec(hslot2) on the old slot
and udp_hash4_inc(nhslot2) on the new slot.

While the impact is minor since hash4_cnt is a u32 optimization hint,
the counter becomes permanently incorrect and accumulates error across
connect/disconnect cycles.
