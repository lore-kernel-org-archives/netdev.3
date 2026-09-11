Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1349B20B
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142203; cv=none; b=TQWXAAiaWQYUPYVgZLdrDLO3gUh+PFryBASBm3hzQNSZfRC5mDXFaJfVrnts3CmlgGo6ai+uakBkRJ399fUXRWQp1GTafQbxmvj2O4S1ylMlb2vaBAC0esF8fg0owge00qbMI4Yft1T9+JnEoeYxx8jx4kneej1m0GbWiiDahMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142203; c=relaxed/simple;
	bh=mjbvHbioGHY7urkc7ALAd6QAqb6mSR2JpyegfZB+S/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djUNqSUMh9LIq5K5vbNcNnt9z+UYdrEsy50Mx7UqjMfLe4h0q85EuJNs7QHcLMk1jfl5bgi/AbWgHbm+AU5Ms4xi85xkPvEdjvI45ipdBsikzIRhqyItHOG9rmGfmWmIxFUAx9X0NjYPtdDVR77AHgPaEYQcMDqiOEndYk85MbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/9PFcH+; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/9PFcH+"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d9080b18b6so7846465ad.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789142201; x=1789747001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i93HR/ZVRY5iecDHt3F7Fd0n7rJ1kE9Xq94CpGBbTOY=;
        b=J/9PFcH+8RwW0AkuX99NZ6ZFXSkbTfBOveZZPXyIjM9Ul5GctCK0d1KzloNnICvb6q
         YCAepxnGbOSSHPl/RsCdR3pXUhDAqNeXhJ6CrhnoAiu0su26wL60oK82gdy6EAGf0Zi/
         Qs+8kRdZH1TcCqpSeTbFmrb5K8mNRmnxsKtYllWLL8tQnudAErNVcxkeX0Dvv8L3/H3W
         MumWVAAWhSxkzP+N6ngNp7k9hr49pwgTQgMMO6uVEWdnpXQ6kbFSlgf7zhRFcpOqOiJz
         KGGZSMGGzxITvHnWu5ZFSvjSfa/8nhFD2wgUKDTfKvsh2nm4VwJBvWdlC1T2OpBWBRzS
         ZDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789142201; x=1789747001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i93HR/ZVRY5iecDHt3F7Fd0n7rJ1kE9Xq94CpGBbTOY=;
        b=E52TP5la6SGlcQJUIr3iAqaUKDPSKzn1GJkWHMM3pknT9TU3eYmk5jxUlkwmcsS9O6
         Al7HHawmIrSMqUyV85Q1eqaJ0cVLUillpfQGMpBDgnmnPa2SiL+BrmcTWsssm5vqftj8
         ErhQ2ECT7u5sS4kNyYq4Opi24U6vYN9cktJcl107ut+sQ1L9Nt2iHrPE2YRZktjk5UVk
         lVitr0qVzPjXZMaMjpScucP6oyuRQblStEbJFwReLsU4BEgqb1y4Fv2G+wRoTE7IuPmr
         t4pvK+45g9IBe2BNaimY3sM+1J7v6y5TrWydmVXBXCbaJYcCXY6X3WLRJVXjOhapWWt6
         4ZyA==
X-Forwarded-Encrypted: i=1; AKwUvBydGAgSZLBeGfgDNrM82nqU6wp9KuJavkW55+fC546Q1cNO06ocgAmgQHkTthIrPILaZcx0+b0=@vger.kernel.org
X-Gm-Message-State: AFuF++lerc+MuLf1bM1Pm9UfwW3+0RhKODJOiB2TcKfVSoUzGwwe3g/u
	dOY02xf+Nzr5AP0YM9OP8QPWaxVUkU68mrtY9YRkqnsr8mSMU/I9+pUo
X-Gm-Gg: AYBFou1AeBzUJISdmJUKQ3bsDbWmH/9fOpUbWNgvUOJLHn+5cMnu4hf/aR755F9/ESt
	Nfl/E0wQeZLdlV+F5b/htNE8NCPVrpJjBRYQjHjWNeGb4bQq+OVWktAqRDvw2HV915qzipp2OvZ
	khseQk7mQtXiznViIiEmNUfFadZxdFZmRMXkBkyc3e9bCLbcRMkQQnBxo5LuXnjmKbRuu1fEwjp
	dXAHFK+JKRGdSNbMN1ByVP45CL2R37cxd3VCNPIU8mD4hh7j5f/4LiBWYteAUPwFq6gE0SYpawx
	1OBa9RBPgMXp7eLoZRhFs1HY6FCHUYmhJzm870bR1xRqjLde65VKtgYhiTe6Ul32xY22A9WEcZf
	HAzI3Pl8zOfj/l2qQkTt17YUwq1CXuv6AAfMqZYQ6Zfk//b4RGe7PogCSoO9x7v/it8EGkCh3gg
	0V312Chv9EJ0kkj1zTzucqe/e9hkabaGaXdAkFEpKxbfQPPVS3xX0j+pv+/+y/hB16
X-Received: by 2002:a05:6a20:d508:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3daed59e465mr8842930637.9.1789142201223;
        Fri, 11 Sep 2026 08:56:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c65b1a63sm1435313a12.31.2026.09.11.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 08:56:40 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:56:23 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] net: add sockopt_expand_out()
Message-ID: <aqQkImqiHPorszOY@devvm7509.cco0.facebook.com>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
 <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>

On 09/10, Breno Leitao wrote:
> Add sockopt_expand_out() to grow opt->iter_out mid-air.
> 
> It is a no-op unless the proper size outruns optlen (i.e, some
> not-well-behaved userspace program calling it).
> 
> In this case, only a user buffer can be longer than optlen says, so
> a kernel-backed optval keeps the bounded iterator and the callback gets
> -EINVAL if it asks to grow.
> 
> This whole quirk is added to:
> 
>   1) Avoid breaking userspace
>   2) Making the quirk explict
>      * Instead of protocol doing implict assumping like this.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/net.h | 25 +++++++++++++++++++++++++
>  net/socket.c        |  4 ++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 470100ae710773..de0ed362b37794 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -70,6 +70,31 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
>  	return 0;
>  }
>  
> +/*
> + * Grow optval to @size, for the options whose reply is sized by a count the
> + * caller left in optval rather than by optlen. Those write past optlen today
> + * and userspace relies on it.
> + *
> + * Call it before writing through opt->iter_out: it re-anchors the iterator at
> + * the head of optval. Only a user buffer can be longer than the optlen the
> + * caller declared, so a kernel-backed optval is refused with -EINVAL.
> + */
> +static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
> +{

[..]

> +	if (size <= iov_iter_count(&opt->iter_out))
> +		return 0;
> +
> +	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
> +		return -EINVAL;

nit: if you end up re-spinning for some reason, maybe swap these two?
I always get confused by the count vs len of iov (iov_iter_count vs
iter_iov_len). Because I think count for ubuf is len because of the
aliasing? (and then, if !iter_is_ubuf check is first, at least iov_iter_count
will 100% be ubuf specific)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
