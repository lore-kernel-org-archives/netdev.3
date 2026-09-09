Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCE382395
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943452; cv=none; b=EPn9W922u/DMuzmSEi4qJWyUEuNxKxWe0h+FnKPDb57CGN6O6N78OnxWjhEu6kTo6ZfETHa/fX+HPYJ2G5I+rC1xit7YiSWfuLr4WzC9VcHU5wf9kpfAAJ+Cadox68eSH9/HlCCm1AXw6YreAQ+Ohr8r2ku+D11lmYFLgN9Slws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943452; c=relaxed/simple;
	bh=xys6MsEZcwrHHq7YN0NfAuyBpB8HSgM4kUcuBxXgQ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKkutKa1qED28JE5n73Ip8zZTsoueyBJ8F3r8FxgrC9+O7E6Dzj3U+2GDHHdb4SaZIiS9Xl5AYwewQZmFM4UpuxYEYLiMix5sdJPiXHDIKylIqAMsSheL4Z937xgKLK1WsGQ0DpECSfaq85aH1XmmnJeRzz/olNCi6pocApXJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEDsUmsI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEDsUmsI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so4002875e9.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788943448; x=1789548248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okMv2+1YfuLx/2dcvT40MlDMYaz4gYQHN5TEnTMZgF8=;
        b=kEDsUmsINV6NCR6pyc1+8kWei39dPviDnqn7VXO7zZB8Mwix24tTfynLlu88AgCfiJ
         ALGkyxktB5KagnBzd6rEpKgAzamhzotyVsB1pCa+Xa4MpjdtVnOTR/nw1pF88jwQzVl9
         1KZEUVNRivT4ccs+DNJw3YxPY1HlzeyD9rpJvhl0Tn5hbSGbxVfMNqlr5rUCh2YXfqXm
         sUNAPUR59t2z447tzuZACwv7HZbXERvBPd/W56lKtuV/CTSonrwDWCB0/bpGGLmoWcxJ
         HjDO9Zkfbgtz5pJlP/B9tplKMAYOK/WYECnJhlu2GvHpdyQ5BFe0az5jk8y4Lo7nh4QP
         BLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788943448; x=1789548248;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okMv2+1YfuLx/2dcvT40MlDMYaz4gYQHN5TEnTMZgF8=;
        b=TTcnf9MpQiM+YtI6If5by4pur20O9Z5mF+RJa0+Pw2qAd4Bb8f9RdZHYJ5X/gC1z/v
         Ha9EcnsL3ovzioEXIEUxm8bTEtN0n84PwsnGbWlkOSz0fgZVmxBoZnffGwsP4iTipEd6
         0o9+AAr5FDwCchi8wBPiYcDOdwRjgBt+gI+PSusoCHVFRTbRODsbPSBNFd+4krRRjunz
         n2z8itI/gEkjMiLs1pSuBv88e9xunPbenfTnNwVUgb3DwbqE2br8AcNnWtlT6ZPcNO2F
         O8hkAu231EkCRs/QjehquyLlivdwJegsglYZJH40O574RtsUG6/l2zqrQ3eJ1uATMq5h
         RBSw==
X-Forwarded-Encrypted: i=1; AKwUvByOmc2SVbFePzAsxl4Tgjvy91SQPBNEC77GLiOt+m/aZNEvNJmJbLdI2E4af2BGdZxIvHWJQck=@vger.kernel.org
X-Gm-Message-State: AFuF++lsJibxB9Y+4wUq2l1fXdCELj63tlVboaeDvj0gF3/IvItckenj
	XEkfMdSdnaKFXMF0lqJuP5GFRHqn+um5WZtCdf7HJYqgJBYPoEpMKkH1
X-Gm-Gg: AYBFou1vOLHB2xsf1q+GtkRc06U9wnyAgVT1xHs44QscVCOvITk4FOk2fDBlWiKL1eV
	OVwnfMp+h0bUYRkLJupMm5EB3C06mDu8fTLWaxYTXg679kH+scPgMD3eLkMGhhQOtH65fbnF8L+
	+1MzIUmcShYuyYD9rxwZ1po81i6utdwzQIRldJPJv09AlU7T4l/KwAu11XS8sDVCcrwqIK8/KDD
	yFaILTK81DqPst87E9SE67Ahpm+PRSnPPR3w5myrj65yGxgIPJBhBqVE6xCilUtNfNsxZiXld8T
	BKDAxp3o4GXiVqmfQ4Bl9ROyFjnEyDu+qowzcg3YGVJbB1kXnePIj03C/QgFHcq2jFDEFFYek/k
	wUmiWlLTh0yS5ekdPT2/0OqwEWk+4LzsSk2ygC+IFjyVDVx9ZNT9o8ocrNSEe7VSVYGXwPsRUeV
	i8tIej8dZjuQMNCLiwxGIKVIe9J7ATKIaog8xlqN6eXmfrH0yFHK1wDcEPDR5p4JeNzdbvZC5N7
	ai18qugUlSBGFoTuq2XilWSRp7BspcGfDmB
X-Received: by 2002:a05:600c:3e0d:b0:49c:ff8d:b548 with SMTP id 5b1f17b1804b1-49d1f358668mr92609505e9.11.1788943447734;
        Wed, 09 Sep 2026 01:44:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm439337225e9.11.2026.09.09.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:44:07 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:43:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ajith P V <ajithpv.linux@gmail.com>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] tipc: replace deprecated strcpy with
 strscpy in tipc_bearer_get_name()
Message-ID: <20260909094356.00a640dd@pumpkin>
In-Reply-To: <20260903132718.1616159-1-ajithpv.linux@gmail.com>
References: <20260903132718.1616159-1-ajithpv.linux@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 13:27:18 +0000
Ajith P V <ajithpv.linux@gmail.com> wrote:

> The `strcpy()` function is deprecated and moving towards code-tree
> elimination. Replacing it with `strscpy()` fixes potential buffer
> overflow vectors by ensuring safe NULL-termination based on the
> destination buffer size limit [1][2].
> 
> To make the interface safer and more robust for future callers, refactor
> `tipc_bearer_get_name()` to accept a destination buffer length parameter.
> Replace `strcpy()` with `strscpy()` and pass through any potential
> `-E2BIG` truncation error code up to the caller. Update the existing
> caller in `net/tipc/monitor.c` to pass its array size.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Link: https://github.com/KSPP/linux/issues/88 [2]
> 
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ---
> v5:
>   - Cleaned up implementation by removing extra `ret` variable as suggested.
>   - Wrapped long lines to fix checkpatch column-limit warning.
> v4:
>   - Avoid hard-coding TIPC_MAX_BEARER_NAME in the function body.
>   - Pass size_t len from the caller down to strscpy().
>   - Forward strscpy()'s -E2BIG error up through the existing int return type.
>   - Updated function documentation comment block.
> v3:
>   - Fix patch title as suggested by Tung Quang Nguyen.
>   - No code changes from v2.
> v2:
>   - Target net-next tree instead of standard net tree as requested by Tung Quang Nguyen.
>   - No code changes from v1.
> 
>  net/tipc/bearer.c  | 6 ++++--
>  net/tipc/bearer.h  | 3 ++-
>  net/tipc/monitor.c | 3 ++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e887..65fa18928fe3 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -195,9 +195,10 @@ struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name)
>  /*     tipc_bearer_get_name - get the bearer name from its id.
>   *     @net: network namespace
>   *     @name: a pointer to the buffer where the name will be stored.
> + *     @len: size of the destination buffer
>   *     @bearer_id: the id to get the name from.
>   */
> -int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
> +int tipc_bearer_get_name(struct net *net, char *name, size_t len, u32 bearer_id)
>  {
>  	struct tipc_net *tn = tipc_net(net);
>  	struct tipc_bearer *b;
> @@ -209,7 +210,8 @@ int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id)
>  	if (!b)
>  		return -EINVAL;
>  
> -	strcpy(name, b->name);
> +	if (strscpy(name, b->name, len) < 0)
> +		return -E2BIG;
>  	return 0;
>  }
>  
> diff --git a/net/tipc/bearer.h b/net/tipc/bearer.h
> index 41eac1ee0c09..9ccc9ffa925a 100644
> --- a/net/tipc/bearer.h
> +++ b/net/tipc/bearer.h
> @@ -226,7 +226,8 @@ int tipc_l2_send_msg(struct net *net, struct sk_buff *buf,
>  void tipc_bearer_add_dest(struct net *net, u32 bearer_id, u32 dest);
>  void tipc_bearer_remove_dest(struct net *net, u32 bearer_id, u32 dest);
>  struct tipc_bearer *tipc_bearer_find(struct net *net, const char *name);
> -int tipc_bearer_get_name(struct net *net, char *name, u32 bearer_id);
> +int tipc_bearer_get_name(struct net *net, char *name,
> +			 size_t len, u32 bearer_id);
>  struct tipc_media *tipc_media_find(const char *name);
>  int tipc_bearer_setup(void);
>  void tipc_bearer_cleanup(void);
> diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
> index a94b9b36a700..a8a088fc2a2c 100644
> --- a/net/tipc/monitor.c
> +++ b/net/tipc/monitor.c
> @@ -829,11 +829,12 @@ int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
>  {
>  	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
>  	char bearer_name[TIPC_MAX_BEARER_NAME];
> +	size_t name_len = sizeof(bearer_name);
>  	struct nlattr *attrs;
>  	void *hdr;
>  	int ret;
>  
> -	ret = tipc_bearer_get_name(net, bearer_name, bearer_id);
> +	ret = tipc_bearer_get_name(net, bearer_name, name_len, bearer_id);

There really is no point in the name_len variable.

>  	if (ret || !mon)
>  		return 0;
>  

