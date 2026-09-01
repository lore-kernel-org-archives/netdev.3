Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA03B6370
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248231; cv=none; b=kRtzj9wgNVJoXbXgBTGRLiJtH53qqKcbWKZnZyxojX3MxLcJWrp4Q66KgIlQmK2uMlw/RkTa4bgMeZ8uicfAx0gNnUTeJQs+Z9GZt7VmsT2h5ZA7/BB3wpQfr3vdD/JsJ+yU5BOzG5NVm6p5XvI5pIN5YuFAHTmBJb0uj5OMxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248231; c=relaxed/simple;
	bh=FJwryxdj6SeAfeatAboNCbJuNSz4L2laoNofSSSnyxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLFOy2p+WuR7o2b4dTLNAoVaV4tWVnEx100GehH+ZLbDfU5lOvZRM/doS6158Ac3eZk2nSl+/E4U+QV3rqAJwhLcrxsdbn9wZp4PrfaywjtD502+WQOZE98wrR+6TEDajgVp8zKqLVlrSipTamfsqz1wbrgaq7F/L7MyQ5OTpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZxogu5o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jgMLF2p8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZxogu5o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jgMLF2p8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788248228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJI7b9uIFuaHf590ZX0b+HvWZoEv+dLMUmfbEqRC6AY=;
	b=fZxogu5oE2aq5NYYULtqjbn72COhduwYhUY50e9I7c9eIvnr/bRH3gEGJEa/TVLnSHpwJU
	3lkwSoGyrOiMRbHMW4CDoWx04uuN6W6BoC98hfmOJxyaz5h4XOcTC3CUD1MsT6dYVuHk6g
	xomXJANBsZvt03BKSTwUtjy8t/RbRlE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-MRtgAqqfMh2diylWhER_Lw-1; Tue, 01 Sept 2026 03:37:07 -0400
X-MC-Unique: MRtgAqqfMh2diylWhER_Lw-1
X-Mimecast-MFC-AGG-ID: MRtgAqqfMh2diylWhER_Lw_1788248226
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994aebe932so43218345e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788248226; x=1788853026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sJI7b9uIFuaHf590ZX0b+HvWZoEv+dLMUmfbEqRC6AY=;
        b=jgMLF2p8tcprFdbhmlgojh0EQNBDWMNznDDz8+99YsWvXdrtErW74P2hBbLABW41pU
         PECHfXmROOT3grXgMTnKCSKzM+7fdCszb9j9SudKt3zIBns1Qr59RHP7dpYvoHMOZ/UL
         L4ORzNkfaNZ1MajOYOy2UVmC2s1lRGyT8g5wyTHNqvRx310sh8A+/zsJ4OUH9+MdfisI
         ULJEnS1h9Kf8fA3qK8Dzkr/rVApUfyv3z0xrH3Hu0h2VkJhmve07V853Gh+VZjRVeQs1
         nvrYKDjBWyVAvsusO/hE0asq/Bg30xwsr91BEFaaGbEYr57xCQz5qasD8YDVL/VJhM9v
         iHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248226; x=1788853026;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sJI7b9uIFuaHf590ZX0b+HvWZoEv+dLMUmfbEqRC6AY=;
        b=kjwH+GyDkCOYiKN5FLBohi7ouYya2LP2A7nhrSPbJWsL4T5Vz87XiDWTvhDl2RDcQW
         Smrz1WHSItxGL2DzrbniHOwcDE3YSWlcp/ToYnmJn1yDA0LGBK9CMtRzYy8nsKwAJkX3
         9admuNvr9HpXXJGjQ3tsy21s+g8GdwTRobUqFVkPxEuUs7/ySeVaTKerfSaZ7RfVymHD
         wNAXVAQDHDKDmDgLy4cK0hKkVFnL9GaQG/BFHT+BB2rCI5crPMFuqAsTj+loPUo6uiwL
         9s5c3opmuVN+SCxCjyvMXzhc1tmPN1K09C4YntK2F+MGCjm6VzYtlL27B/ptUccXACjk
         2fmA==
X-Forwarded-Encrypted: i=1; AHgh+Rplo/1V1Rdr0KX+Ur/pUZFEyQ7rm54W3zMBDR4KEK5fJoYE9+xKY4Thrmm+wkeqhRuv6It6IWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ne9fh5Njag5oc755+CiKo7DXxWJ/MpmG96Y3020Hm00m4JRci3
	T2pygMmXrTg3YI6Fzse6vP4qGSHL/xDosv13KHJBYCmgDXhgeOmtjFlT46F/OF4uXZCCcgWTgwz
	CBOdducgz53EyS0O0LT2mjhizn19T7GZesIwWZ/05QwrEwd5dwZD/hFzgqg==
X-Gm-Gg: AR+sD10X+lfbN40q9bbxxKzIbfxrT628Bi/+OcZmS3S4HohKl8FbmgMkF2BrK2uObuY
	uZef/A9mbHElSPK5miqM09EWsh9N+1z/gBugNU0GIUBWnnHtwuVSbOy6w1oM9T90db4vP7kzSc6
	7qNgE4ZN/LdzvtF7L5goihsNAOsFz0eJrNgBClVMXID/GxeEC7XMoR9Fd0BZQYEQjQnT6A2En9M
	CLpMLibA4KLVtQDxvrTxX5Hv6QMswStPVc76nSJIwRnIiXE7p2NNQk5n1uXdj7CmRujeUk01BLb
	fpieYx692JM1XXTbAyk+CgBzZR+Rj8eYLZdPpChL+FKyk/VqSGI644/o4cPyx6k8p5O4+5RlLQA
	QQwbr+EXjUmRivgxJKKCl19wEwfmRDKwdC/f5QgHnEbWTu4sKgIlLqSUxfeqJmIzAcltJSCc/aw
	==
X-Received: by 2002:a05:600c:3b2a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cdc57d1d1mr95574065e9.16.1788248226221;
        Tue, 01 Sep 2026 00:37:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cdc57d1d1mr95573025e9.16.1788248225616;
        Tue, 01 Sep 2026 00:37:05 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e4e7sm45045755e9.9.2026.09.01.00.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 00:37:04 -0700 (PDT)
Message-ID: <3e84c09f-d760-41e9-a99f-0d86239b5ebd@redhat.com>
Date: Tue, 1 Sep 2026 09:37:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] tcp: Remove mmap_lock fallback path
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
Cc: dave.hansen@linux.intel.com, Liam.Howlett@oracle.com, ljs@kernel.org,
 david@redhat.com, willy@infradead.org, shakeel.butt@linux.dev,
 vbabka@kernel.org, jannh@google.com, aliceryhl@google.com, arve@android.com,
 cmllamas@google.com, christian@brauner.io, tkjos@android.com,
 dsahern@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 syzbot@syzkaller.appspotmail.com
References: <20260831203056.838265-1-surenb@google.com>
 <20260831203056.838265-6-surenb@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260831203056.838265-6-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

adding Eric.

Full series at:

https://lore.kernel.org/netdev/20260831203056.838265-1-surenb@google.com/

On 8/31/26 10:30 PM, Suren Baghdasaryan wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Previously, the per-VMA locking could fail in the face of writers
> which necessitates a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
> 
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> The fallback removal does not affect NOMMU case because TCP_ZEROCOPY
> is gated on CONFIG_MMU.
> 
> This really is a nice cleanup. It removes the need to pass the lock
> state back and forth to find_tcp_vma().
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  net/ipv4/tcp.c | 31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 455441f1b694..62defe70f3ce 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2167,27 +2167,18 @@ static void tcp_zc_finalize_rx_tstamp(struct sock *sk,
>  }
>  
>  static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
> -					   unsigned long address,
> -					   bool *mmap_locked)
> +					   unsigned long address)
>  {
> -	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
> +	struct vm_area_struct *vma = vma_start_read_unlocked(mm, address);
>  
> -	if (vma) {
> -		if (vma->vm_ops != &tcp_vm_ops) {
> -			vma_end_read(vma);
> -			return NULL;
> -		}
> -		*mmap_locked = false;
> -		return vma;
> -	}
> +	if (!vma)
> +		return NULL;
>  
> -	mmap_read_lock(mm);
> -	vma = vma_lookup(mm, address);
> -	if (!vma || vma->vm_ops != &tcp_vm_ops) {
> -		mmap_read_unlock(mm);
> +	if (vma->vm_ops != &tcp_vm_ops) {
> +		vma_end_read(vma);
>  		return NULL;
>  	}
> -	*mmap_locked = true;
> +
>  	return vma;
>  }
>  
> @@ -2208,7 +2199,6 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  	u32 seq = tp->copied_seq;
>  	u32 total_bytes_to_map;
>  	int inq = tcp_inq(sk);
> -	bool mmap_locked;
>  	int ret;
>  
>  	zc->copybuf_len = 0;
> @@ -2233,7 +2223,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  		return 0;
>  	}
>  
> -	vma = find_tcp_vma(current->mm, address, &mmap_locked);
> +	vma = find_tcp_vma(current->mm, address);
>  	if (!vma)
>  		return -EINVAL;
>  
> @@ -2315,10 +2305,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
>  						   zc, total_bytes_to_map);
>  	}
>  out:
> -	if (mmap_locked)
> -		mmap_read_unlock(current->mm);
> -	else
> -		vma_end_read(vma);
> +	vma_end_read(vma);
>  	/* Try to copy straggler data. */
>  	if (!ret)
>  		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);

