Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA630595B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616835; cv=none; b=VANX/5I5aNLdlRWyZ7J28UuLidL20WXfncRbRG1XETKprYNDhHSnxRTGL2BCsQ+j3x+zLQ5b7hrCwVHj+T41Znwf8yaXcT5BG+nxo9XeUJkU0cjopHdHYa/Bq6UQMxlhZ+mo6Z2K69XkUv5eM/UYk20LvVzqqcpOL1ZhzeZVdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616835; c=relaxed/simple;
	bh=Sj4HWP9QisEzm9JzhjUCOB4XKgrZNOLEhL7geAA/29c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPtm8Uci1ymZz8fHBiRoYJDcwML/fzM8HdzkLWrxBAcMZFQW6qphaPZtmWBTty3+N+ES/HZ6S+Ji+0O/W/OkNdwlOfkMEAYLExWG4FbjPWzTFZVrfPHL+ROx//IU+9JQ/ieIj/T7nXyuGsibuyZDYKtnaoTuXXkK6xwegyWtPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYrtHlTR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYrtHlTR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-461a5a39da1so452967f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616833; x=1782221633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvYxCng4UXLcQ/XoznoR8Er/jzsFv5UY/bjt0wk6M20=;
        b=mYrtHlTRdxgA3QyRxqM98M3oCUow0xVbxWsJIoBCSQB5kHzUCYSvhTWJ5vFzmEdvih
         tXJzr/GCI+jNAMdr8g9ipvNeUMn57kf4iKxAPO7yXDKMCdinPWG7PDPGmdMKmRLP6DHF
         60khKnZY3ImNbn+QlfBD/s3IHOTA0gWX0P7qmmgICE/fhtsg2PYR8g92tKpdUtJMQuKt
         M2P8bWOOQ6Q5POIH8JB70Tipi7QXKTTQzTnCag53sXEq/mJa01dH4AjESnuPkdlPEhf9
         JMybhn1k2kqUbjsHf5ZAJxop9Nwl02qvn9qa0uftl/MkUq0hqMVhMZ783kmzvT9yQ6DI
         1mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616833; x=1782221633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvYxCng4UXLcQ/XoznoR8Er/jzsFv5UY/bjt0wk6M20=;
        b=rx5l5QXoRQl+X8Mf0AqBZhgdh33q5ZmpklBNYjNjR1Djg/A0aXJsrojkXV6+Ftw/rm
         mL4kPtKffBxcrc/nc4hP4TcxHscazXPJJVrS4+I4YvaF5BDRIzbkctgH0T+NyJWLACWS
         CSuNh6+keVKWp0nMZfZAW+zhkPbDvpjgYWYzMsFkWT/41/2hGu09uFQcl/ckgQcbw5U3
         WeU2ZoAiAlz57dQA5+caxOJr8wpANeaTK4i2XC+CxyYP9KZzY4YRSmnaBlkjLpBMa5yE
         IA1l8jLBfUFXBfmei8eWal9d9do8Ej/h349c6+G+wpOuS/gumoexiZEM0kFqWKfSqzzA
         eB9w==
X-Forwarded-Encrypted: i=1; AFNElJ+sS14rPRtznOvHHztuc3zTQglfohB9+01qGiynxA7WhgCdDPPfJjEx5I6VH5CF6p2VEb8BDAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRa7EfaTUz+xPBmlgcGRJk7lzWsnZxXU+Jmp/sxt9Bbn1oDJkc
	gW0YoSAaASicmU8krZNsc1DQV1vOAmtlmTWK4xu+dzOYSWu2vg6ZxRW2
X-Gm-Gg: Acq92OFl/5SHAlVR0X86IniFRbq6OtONd9c+KZWUkMgkS6Cq6taQdJ8FL5vCZa5ppJn
	/SzP9t3BjOn0+w/sO6W35yTZx+OQNTUctpCNnmb9X5Umk6wg84zmJwKETc+XpQ9o0PLumkokhRy
	QNurd5g/oMJDlFdyhS0aYm3bASKu8eSSLoQjFWMVvoQcy/T+Ba+h0vBqrdMQm5rHGFixngpQ7aO
	PELVr88ohV4s6HNvv8WJeyBxs2xRYyw9xet6XUG7CKyAtfJL58JKJbjzNvkozBi05AZIlGqhwxP
	AUwsuTpseyy6nnSGHGSdz7RoDRKl8k+F88nGfgTWnsks7w8qq9pW99YZLITCRWt3642rtmcFV1h
	AjE6A0ktu9eDGSC8oQlJjzLnZCy8Mz6lSD/vX/7vfZiDzVs4/O6PPb6LVR1Wk3I1tDDofWX+Ira
	6DErhNFz2hTFWVlfJxf4Dr7nsZLvW9C91Idh80LzbQomJl8FEf34ig5nqxMH9wXO4TuSXCw2B69
	pMmyuJlHuyeyBlN5rktRqV+URCAoobLyp2PZQsnn/ngmcY+oLNtRl2CggRXJ2XW9UVCwju1ZeIM
	1V1L6zpXUNZJn/JQQ3JEOoTupMH4+xot5P1fvBKEoZw=
X-Received: by 2002:a05:6000:986:b0:44b:7ec9:2d76 with SMTP id ffacd0b85a97d-4619f383d22mr7296064f8f.7.1781616832689;
        Tue, 16 Jun 2026 06:33:52 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004325bddd753d2e35.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4325:bddd:753d:2e35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619a041986sm20656081f8f.23.2026.06.16.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:33:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:33:49 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	toke@redhat.com, lorenzo@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix partial copy of non-linear test_run
 output
Message-ID: <ajFQvedGURQuKqbX@mail.gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
 <20260616093103.471444-2-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616093103.471444-2-sun.jian.kdev@gmail.com>

On Tue, Jun 16, 2026 at 05:31:02PM +0800, Sun Jian wrote:
> For non-linear test_run output, bpf_test_finish() derives the linear
> data copy length from copy_size - frag_size. This only matches the
> linear data length when copy_size is the full packet size.
> 
> When userspace provides a short data_out buffer, copy_size is clamped to
> that buffer size. If copy_size is smaller than frag_size, the computed
> length becomes negative and bpf_test_finish() returns -ENOSPC before
> copying the packet prefix or updating data_size_out.
> 
> Compute the linear data length from the packet layout instead, and clamp
> the linear copy length to copy_size. This preserves the expected
> partial-copy semantics: return -ENOSPC, copy the packet prefix that fits
> in data_out, and report the full packet length through data_size_out.
> 
> Fixes: 7855e0db150ad ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  net/bpf/test_run.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 2bc04feadfab..976e8fa31bc9 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
>  	}
>  
>  	if (data_out) {
> -		int len = sinfo ? copy_size - frag_size : copy_size;
> -
> -		if (len < 0) {
> -			err = -ENOSPC;
> -			goto out;
> -		}
> +		u32 head_len = size - frag_size;
> +		u32 len = min(copy_size, head_len);
>  
>  		if (copy_to_user(data_out, data, len))
>  			goto out;
>  
>  		if (sinfo) {
> -			int i, offset = len;
> +			u32 offset = len;
>  			u32 data_len;
> +			int i;

That doesn't look needed.

>  
>  			for (i = 0; i < sinfo->nr_frags; i++) {
>  				skb_frag_t *frag = &sinfo->frags[i];
> -- 
> 2.43.0
> 
