Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEA3655D8
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788726225; cv=none; b=WaX7R+7sqFL/qneYhrFpDPQNbpMDktKhl4K1Fagcl2IDsO1sWuR9QaziB93H/gh/W6mf7tirIMuLSWWf8N01tVZk3McelXFTCsG0aGGysGm2RVehMXG7UkR0iT8YTSEuwUEeUlFH90butUbteirjSD4U6K1d4b/GT80ad06t4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788726225; c=relaxed/simple;
	bh=9zW9anpJ9IpVxBTdkttWRu/Ds4eJn5s5OUHExXZpTu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4dLSYDh8oS8QDfwp8EO0HiTJWXt4suI5PLe7OPLlohJoRJLKy9Ssb6+27puXI5QdEu+AzRos+WaYvf83SXV9egnbXv8QA3UQm5IdsE1GCsB2cm0z3l6ImZGDLKOnfySli05Jhrn1vQzYCeNkoW2JOLjQki499dGU+h1IdtgalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=u51NSmIX; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="u51NSmIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1788726220;
	bh=9zW9anpJ9IpVxBTdkttWRu/Ds4eJn5s5OUHExXZpTu0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u51NSmIXz6QTRrkLo8CVxcQvTyK8LV25LJzLA0at8HObFzK0USeh+xz7peecz2KE7
	 bVgbaW76ct89dj//3SLtD7t1p2z4It1lkAQRDadpsvp0YSCGwXCFyUHjuLST6Xh2Dr
	 u9+phwJDqktVpquk5BOyYbLcNHmx0QCmQlZw7El0hEHkn5hREFdDhHmWjD80DrYI/q
	 lNV0MzgrQ9kyyL2HRtbv3qJ20co38Mj3/0jvKSiG4ivzIZwMMxA3QmCyHN/u0qKdiA
	 VzZVfovcOISVa0RwOGnSQDyratwVZXDiAaZqEqs03H8n3wZlzMBJsS3yUUqWaG6iQ4
	 mLXcmS0ynIPrw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1BD3560075;
	Sun,  6 Sep 2026 20:23:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 3FE1A200349;
	Sun, 06 Sep 2026 20:23:11 +0000 (UTC)
Message-ID: <e5de4d2a-4158-46ec-89cb-bed61e2ce2ce@fiberby.net>
Date: Sun, 6 Sep 2026 20:23:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] netlink: specs: handshake: type the
 remaining key serials s32
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, cel@kernel.org,
 donald.hunter@gmail.com, kernel-tls-handshake@lists.linux.dev,
 davem@davemloft.net
References: <20260904190410.3864660-1-kuba@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20260904190410.3864660-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/26 7:04 PM, Jakub Kicinski wrote:
> include/linux/key.h has "typedef int32_t key_serial_t" and commit
> 160f404495aa ("handshake: Fix sign of key_serial_t fields") converted
> x509.cert and x509.privkey to s32, but accept.peer-identity,
> accept.keyring and done.remote-auth were left as u32 - the same
> quantity typed both ways inside one family, and a generated user space
> struct with __s32 cert next to __u32 keyring. All three come from
> key_serial_t storage in net/handshake/tlshd.c (treq->th_peerid[],
> treq->th_keyring), and special keyrings are legitimately negative
> (KEY_SPEC_PROCESS_KEYRING is -2).
> 
> NLA_U32 and NLA_S32 have the same length and no range check here, so
> the only wire effect is how the value is printed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: cel@kernel.org
> CC: donald.hunter@gmail.com
> CC: kernel-tls-handshake@lists.linux.dev
> ---
>   Documentation/netlink/specs/handshake.yaml | 6 +++---
>   net/handshake/genl.c                       | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
> index ffec12b46759..9ab46da04c49 100644
> --- a/Documentation/netlink/specs/handshake.yaml
> +++ b/Documentation/netlink/specs/handshake.yaml
> @@ -67,7 +67,7 @@ doc: Netlink protocol to request a transport layer security handshake.
>           enum: auth
>         -
>           name: peer-identity
> -        type: u32
> +        type: s32
>           multi-attr: true
>         -
>           name: certificate
> @@ -79,7 +79,7 @@ doc: Netlink protocol to request a transport layer security handshake.
>           type: string
>         -
>           name: keyring
> -        type: u32
> +        type: s32
>     -
>       name: done
>       attributes:
> @@ -93,7 +93,7 @@ doc: Netlink protocol to request a transport layer security handshake.
>           type: s32
>         -
>           name: remote-auth
> -        type: u32
> +        type: s32
>           multi-attr: true
>   
>   operations:
> diff --git a/net/handshake/genl.c b/net/handshake/genl.c
> index feac1ad063ee..58606c2a4600 100644
> --- a/net/handshake/genl.c
> +++ b/net/handshake/genl.c
> @@ -21,7 +21,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
>   static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
>   	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
>   	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
> -	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
> +	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_S32, },
>   };
>   
>   /* Ops table for handshake */

LGTM.

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
