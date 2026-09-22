Received: from mail-yx2-f16.google.com (mail-yx2-f16.google.com [74.125.224.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47087367280
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040207; cv=none; b=bCk+bBHE8Z7L83bhpppKx30j5Ou6IHKxIV9XeqwYet5zGezdUGtl/d4k8cvsYbPLal1xFGtTA6N3AJunm7D7hQe7KkvmRxCPgbx3dlVrHcnK0HoqYvc8a+hihl6yefjhGNyXUhAvZ6P67DblZ8KZWjN+wdVVHu9VD3s5gMx8RvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040207; c=relaxed/simple;
	bh=VWYvwt9yyDEggsy4Q+9+VuOIfUMjuty+TeN8CSEFPKI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QOkHoNASjRax9NhP4Rk5AzEEhxtIijgDhU+c9qV10ZLYKS4w86nt+yGwPRKZymx7dL+EevB8m8pvfbRl1Z4fGGUY9sWRPzIDijN1RCS9VFj22CsToB+hhT3dEVgFwI441c7Kg//F9WwSvnid/dAaF3l+M/m8WPm1kEyak7tLuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ottkzwYH; arc=none smtp.client-ip=74.125.224.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ottkzwYH"
Received: by mail-yx2-f16.google.com with SMTP id 956f58d0204a3-66e56a1fe83so3244844d50.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040204; x=1790645004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PBOt0OoBsQFCcu7Wjsc5maKeziBC8Q+8HaeFpnFZROA=;
        b=ottkzwYH7vLrB6b0LexznzrJIHShxy9fIEiXo96jkkG/gMZ2NAA8vgp2o79R4rc46Z
         1zRd1WEk8H4CWgoJQNgDmI44M7VFJ7HkX/v7XyFCnGX0/OhfvLz603PoNRUCaZ4paU9+
         XKAKbXUORLBKhfPPnfFiIQ1eOJknd0Wd6F96oA614fZwrp+PRVrOZci7EBoKmje0Pfaf
         tEbGVvMHwBpv+Pc67D8mXp4MRmEBwmaeTU0R0bUZi0Vk1A0qkDnRVHAOojT/CRWxQ05s
         aQ+8d8NrLfWNo/OrDHcE39qHmTHL+nd4YxPVz3IerWtxMOXecFen6r96Q/5O3rZsD0Wp
         yW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040204; x=1790645004;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBOt0OoBsQFCcu7Wjsc5maKeziBC8Q+8HaeFpnFZROA=;
        b=CXJXIYaI6zxGoS9Y2EWlENLMCYwfTvib52cJffRhBBzEFnALdMEl5PaebEij3sJcwb
         exbryGR3EgQwp+0hKZuItFOWThurUe6y+SdnixP+som9Lpedep0AHKpIGnZQPZh0HTlI
         I5vE5Ctr0hWN51NHDTop17pFTpdCohPeoBFVk5mopjfSW0znIuVq9UVAhlgccZwzmnoT
         eS4yYhlahsu3+jk6abmkuvLvx3m8XSKJi+99Og8D0B/47/D/iS1nEYmcWPJQ4z7BN3jg
         Xrum9UmpJCFqvIzSWAscdtExiZMJ69pDJzPMTjFtY1emJOQZPgNFry0/FqjNhLnmVVV+
         Hwgw==
X-Forwarded-Encrypted: i=1; AKwUvBwKtFTgKMdiQwPhDEOunD+U8PBtan/oLM74FlG6t94ETekiRnPPxQp3WtjKFWZGo1cEv+iWD+0=@vger.kernel.org
X-Gm-Message-State: AFuF++lxGnsE+SJjQiWMF0qiJ3H1K4VdaE9uiEnsNYK/fyQC7eyV85R9
	UKnL6YJet3r9L+fa/WEU3KRFfeobSwtjRbxFYeMckp6aTK+v9s6qDaQg
X-Gm-Gg: AYBFou3G5Rf7X5zzqvoQLVEDoBHmLcPPxYQHgV/20+PzwgJP+J1LkbbCWJrfz+2tS4w
	hmUG//Jf90ciHAN4xXg52GLb20XIzL+sZWVw0HiLYMfy5KTbOzUBRXWaI4gHNyXfpW16xR4ZUet
	5Ye0Tgx9F+GG96Per2zPay4RJCtAB6TFkjTjNzanXqocYPj2a/ctFt2s1UuyR6cHDn+RYu8LcCM
	Y8yllG0oTixF+IvtLqT8J1n08Q/McZ1HS3Di+byk65G2pOO8mhMgnF9I0aAFeYtd8KPq393V1eD
	Zi/JqL8c59PN1Dt9DbxXSSFkV9zpNO24fDFcx3d3Puf35doTi4PXTGkuMWOQCptZaATqi4T9lpa
	ybLv6JYLGqmL5S9RxJocMmuBk/voDGEG2F6nMuWI5kXlHRA6eo2yTowjn6RcYDIv67ZEMwWRnw1
	Wf6/sUmlUMq3Fy5Ymf4DIm91WsJN9FNE7Y3p2+/Mzkr58vwdDoF3r6dDTJVWliCvvKqGESNCLnD
	XwK7vSn5fyHI/xHqVB86wn8OBij1HjlRCsWD2kxwpJKfjAHEJvEHoU8PP5Ja28=
X-Received: by 2002:a05:690e:43c5:b0:671:f0:c756 with SMTP id 956f58d0204a3-6717fcb7f11mr2862439d50.23.1790040204156;
        Mon, 21 Sep 2026 18:23:24 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c72fe63csm172542d50.0.2026.09.21.18.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:23:22 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:23:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>, 
 netdev@vger.kernel.org
Cc: zihanx@nebusec.ai, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 steffen.klassert@secunet.com, 
 herbert@gondor.apana.org.au, 
 dsahern@kernel.org, 
 idosch@nvidia.com, 
 willemb@google.com, 
 kuniyu@google.com, 
 kees@kernel.org, 
 richardbgobert@gmail.com, 
 alice.kernel@fastmail.im, 
 gal@nvidia.com, 
 jibin.zhang@mediatek.com, 
 luoxuanqiang@kylinos.cn, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Vega <vega@nebusec.ai>, 
 Luxing Yin <root@tr0jan.top>
Message-ID: <willemdebruijn.kernel.102e0468a26de@gmail.com>
In-Reply-To: <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
References: <cover.1789802623.git.zihanx@nebusec.ai>
 <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net v3 1/1] net: gso: limit recursive IP-in-IP
 segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zihan Xi wrote:
> IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
> inet_gso_segment() or ipv6_gso_segment() for every nested IP header. The
> only state that tracks this nesting is encap_level, which records header
> bytes and has no recursion bound. A sufficiently deep chain can consume the
> kernel stack before a transport GSO callback is reached.
> 
> The unbounded callback nesting was introduced when inet_gso_segment() was
> made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
> support predated that change, and IP-in-IP GSO/TSO support later made the
> affected path reachable.
> 
> The corresponding IPv6 stackable path was introduced separately by
> "ipv6: gso: make ipv6_gso_segment() stackable". This patch uses the same
> budget for IPv6, but the Fixes tag covers the IPv4 root cause only.
> 
> Limit the cumulative header budget for a GSO operation to GSO_MAX_HEADER
> (256 bytes). Keep the consumed budget in skb_gso_cb and charge each header
> before dispatching the next GSO callback. The callback wrapper checks the
> same state, so direct IP handler re-entry and nested tunnel dispatch share
> one monotonic budget. GRE and UDP context resets cannot restart it before
> an inner GSO callback; other GSO tunnel and extension handlers charge their
> stripped headers before inner dispatch as well.
> 
> GSO_MAX_HEADER is a practical header budget, not a measured stack-overflow
> threshold or an architecture-independent stack-safety proof. With a zero
> initial offset, 12 minimum-sized IPv4 headers consume 240 bytes; the next
> header is rejected. IPv6 base headers, extension headers, and tunnel
> headers use the budget faster. Validation of the preceding
> implementation on x86_64 used a 16 KiB task stack and completed without a
> stack-guard fault, but this does not establish a uniform margin for
> architectures with smaller stacks.
> 
> Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> 
> ---
> changes in v3:
>   - Treat an exhausted 256-byte budget as a callback-entry failure, including
>     the zero-length check used by the common callback wrapper and IP handlers.
>   - v2 Link: https://lore.kernel.org/all/cover.1789618203.git.zihanx@nebusec.ai/
> changes in v2:
>   - Replace the callback counter with a cumulative 256-byte header budget
>     carried in skb_gso_cb.
>   - Apply the budget at common callback entry and across IP, GRE, UDP, MPLS,
>     NSH, ESP, and IPv6 extension dispatch, including GRE/UDP context resets.
>   - Rebase the UDP hunk onto selected revision c9151088f167 and rerun both
>     IPv4 PoCs; use the decoded crash evidence from unpatched 88c17de85ddb.
>   - v1 Link: https://lore.kernel.org/all/cover.1789302084.git.zihanx@nebusec.ai/
>  include/net/gso.h       | 29 +++++++++++++++++++++++++++++
>  net/core/gso.c          |  7 +++++--
>  net/ipv4/af_inet.c      |  7 ++++++-
>  net/ipv4/esp4_offload.c |  9 +++++++--
>  net/ipv4/gre_offload.c  |  2 ++
>  net/ipv4/udp_offload.c  |  4 +++-
>  net/ipv6/esp6_offload.c |  9 +++++++--
>  net/ipv6/ip6_offload.c  | 11 ++++++++++-
>  net/mpls/mpls_gso.c     |  2 ++
>  net/nsh/nsh.c           |  2 ++
>  10 files changed, 73 insertions(+), 9 deletions(-)

This is a lot of code change compared to v1, a simple recursion
counter. Wang already suggested a simplication.

If the previous approach could be tested at only the two
network header callbacks, then this likely can too. By just bounding
skb_network_header - skb_mac_header? Or skb->data. Each pass through
these functions does an skb_pull.
