Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058C54DAF7
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177222; cv=none; b=QTToINh83CIgu+QVGQhpj+s5FQSoav67XslKtKJQqRDfzGX7TuSQpP0Mdf/ghbYjvqHh3f40rMCoI6bT1EtgCTiREA/zkT/t7rYLTxKE5KvD+HvFt90uHPi8m3gKm+FDytStpiEjwFXo/JURvom60Pe3jKPknKdVYocePmXioRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177222; c=relaxed/simple;
	bh=9ptSO1ytswhM+R/3vhApbg8wWxicmfu9jo6G0XhLqPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PjMoX/Q+JUGhr9cr8vV4W3T6DK7UX+WC42ITL070THDITJfXZLbEnjBbvt9IySMFRY/FJFV6RTFYsMp+Oa5FV++1D54XUYV7jed1J0LnWbfANo611VgVDPAf3ZZTAQk6jRlZoitbM2TK09oRMNnn+q2d878xJCQDHiKUxJtu1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GggU2l7F; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GggU2l7F"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-8716a5baf64so13565237b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177215; x=1790782015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=efdrlHNx11BTy68VJLi3ds9swyNAeXF/5faxI89LuLk=;
        b=GggU2l7F2f8Tjl/lu6HKvaJcq0NWYd4vhrxjc+g/6HoidMdu/OPex9Kl5HJ/e3LqoZ
         22JBbFcu9ST2tjrTgXa+bTtzoWtwJecj2pMl6X6VafJ8U5bptp67/2E4fFEyjKn+YuQR
         gIPEiP+71SC7Pednav/NmHSUXTzeWL0nlKvxL7V9dX0HZ2K6b9hcdv87NETTvwwcpSuy
         mtJhnit+kivyLcjbO0qYQWkwMerdX3YYNHbqYqk4o+8THN7GGF41ZacIgy/0jwBH9fCa
         TWmkZbgfUeNlpwM4O/fPA7rQktBBzSdvP4nYPKmLCYkh/p6eKAZNRaX+DjcPe6sZLBeG
         aw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177215; x=1790782015;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efdrlHNx11BTy68VJLi3ds9swyNAeXF/5faxI89LuLk=;
        b=WsvxxwtQp17awdMW44j7qqTJyp3okY23g3Wg2SJYahcnV6CiDquW/IKfj/Mco/lu4Q
         lprKEK4tpFAWCIswajs3zUP9+GfcR6+64T4d/NqAsL+7IEHSWBxbKm02VbdhmDrjBs1+
         Tk0HT4aLpPM2h+o36EEi7mT+ct59COFzlTDu5EzXK4rJ3Yz5LsdB6fHB7PDWTC4623MC
         5O1r8Ey5THEM9EReG/DMdDk+OiCYM6lbUPbqJdw0kdiLJDTMk0jRz+oxz4VN/yza/WaU
         x0L/uxUDMYLkQ5cO6RzxF8Tf+sV35T+i6+HHEAYbiYEHD7gKCNPo3N/8/NG/5Fqw4e8f
         Gzbw==
X-Forwarded-Encrypted: i=1; AKwUvBz2sNLE4W7/6IqhLY8d8gXKJUkqfHhi/Z/1Gq21VsrkAZ1BJV+hvnCW/qf2IYMg3VO7Jlib9iE=@vger.kernel.org
X-Gm-Message-State: AFuF++mSsTvuo/azPkBwtsUuIddwyU5YVOl0StFE+u2z+G9SnL5Y3OZT
	h2IxeYglRNoCpLnPYWI99eKOhIVmNQ7mAtZ/prkFrn+W0IFoYOpwyRUg
X-Gm-Gg: AYBFou1xQ/S+1+f38gpF6VcYPTndQizJTXLJhxSc3OVLeF64/Q/bhJRU0xQPqfXxfLr
	WATyw6QMBxXve7MaReeD3ZrJmn4/cIUAPxZTSIdpli6Pu3bazC1Ro5fTw+7SWPK4GkD/BuWsvKC
	+pEPIUbZaA9lvJwS44STnrGzvciGHaNyTyr57Z8TcSAmPx2P4yUi3yFsb0O5GoPMv+/r0nRchBV
	GrkRE4mP2aNB7Pj825scm6LdPuVzSx7qIts/M45pEDgvNhR2YvHECUaRUO0LVYB75pw6l2om5uW
	NnfLywYGWDOe5SpInyuV11eqocsq2aDHRp1fhKYdZGMGMX0VwiJWKXE9ed1RlCZzShuluWaTKhr
	L44jtSCv7YTnRJJbeEDlVNLzIhUw0eVCtyxum6m923xRy7/ly237VA9MWKGdvRBA93cHRTdrT6s
	ohKZQOUGATY5chmsEcKwOt4ppDAUXG/crgHwDiXWUfOk9RW2GwLTZ9WJgBN5VlhQySRmRT7Scsv
	S86DNYG3F9RcKvnhi6U/1Cf3iLg1jm82eh64nt+izod1P7HRFhJk8BqxY91Hw8=
X-Received: by 2002:a05:690c:399:b0:81e:6a10:f90f with SMTP id 00721157ae682-8a458c25decmr17614967b3.17.1790177215543;
        Wed, 23 Sep 2026 08:26:55 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a466bc8bb1sm10941057b3.47.2026.09.23.08.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:26:54 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:26:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 idosch@nvidia.com
Cc: zihanx@nebusec.ai, 
 horms@kernel.org, 
 kees@kernel.org, 
 willemb@google.com, 
 kuniyu@google.com, 
 richardbgobert@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.36edefe3b0b17@gmail.com>
In-Reply-To: <8b7e7dad82a40e7bdb4721516823c8a7ae6106a0.1790161599.git.zihanx@nebusec.ai>
References: <cover.1790157745.git.zihanx@nebusec.ai>
 <8b7e7dad82a40e7bdb4721516823c8a7ae6106a0.1790161599.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net v5 1/1] net: gso: limit recursive IP-in-IP
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
> IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
> for each nested IP header. encap_level tracks header bytes, not callback
> depth, so a deep chain can exhaust the kernel stack. Making
> inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
> GSO/TSO later made the path reachable. The IPv6 stackable path was
> introduced separately and shares the guard; Fixes identifies the IPv4
> root cause.
> 
> Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
> per top-level GSO operation and preserved across GRE/UDP context changes.
> Set the cap to five, matching IP_TUNNEL_RECURSION_LIMIT. Allow five
> entries and reject the sixth with -EINVAL before it can dispatch another
> GSO callback.
> 
> On the patched x86_64 kernel, tracefs observed six
> inet_gso_segment() entries for the 199-header reproducer; the sixth
> returned -EINVAL without a stack-guard fault. This validates the tested
> configuration, not an architecture-independent stack-safety margin.
> 
> Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v5:
>   - Replace the header-offset budget with a shared IP GSO handler-entry
>     counter. Entries one through five pass; entry six is rejected.
>   - Initialize the count for each top-level GSO operation and preserve it
>     across IPv4/IPv6 dispatch and GRE/UDP context changes.
>   - Use the existing IP_TUNNEL_RECURSION_LIMIT value of five as a
>     practical bound. Tracefs observed the sixth entry return -EINVAL on
>     the final x86_64 revision; rerun both IPv4 PoCs on that revision.
>   - Avoid rejecting a single-level tunnel based only on header length.
>   - v4 Link: https://lore.kernel.org/all/cover.1790041241.git.zihanx@nebusec.ai/
>  include/net/gso.h      | 9 +++++++++
>  net/core/gso.c         | 1 +
>  net/ipv4/af_inet.c     | 2 ++
>  net/ipv6/ip6_offload.c | 2 ++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/include/net/gso.h b/include/net/gso.h
> index 29975440c..18944ff06 100644
> --- a/include/net/gso.h
> +++ b/include/net/gso.h
> @@ -19,10 +19,19 @@ struct skb_gso_cb {
>  	int	encap_level;
>  	__wsum	csum;
>  	__u16	csum_start;
> +	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
> +	u8	recursion_counter;
>  };
>  #define SKB_GSO_CB_OFFSET	32
>  #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
>  
> +#define GSO_RECURSION_LIMIT	5

The commit-msg explains this as derived from IP_TUNNEL_RECURSION_LIMIT.
Which makes sense as a choice. Use that directly, rather than
duplicating it?

Or else at least add a comment. Right now it looks like an unexplained
magic variable.

If respinning, no need to send the long cover letter again, imho.
Reported-by: is expected to be followed by a Closes: tag. That can
point to the v5 cover letter on lore.kernel.org.
