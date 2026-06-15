Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A0286D5E
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556192; cv=none; b=IRcjbefgWwm1+xWIEnNHWTLHzJCyi5NK3gcK2g9ocHzUGFmSRtlXD/Xyjj7nCbG3Bvsr3nBJwjhIVHW0KDgyPsE5Gf/gWvmYBOSTZSGnj6igQ+mvxLV2NEtO8nEB7aAKmDBHh1zMrqnKZljg8cPSkyDisCTuFu0IT0zOUayw+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556192; c=relaxed/simple;
	bh=jBlnsK/KMS3kauJF9/6kISkgmEqaeXoqt4eJCNdej84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJIInqn29wvxWW9mz+yhWcwu6QsDJKi0zRdn3O+f9Bnt5Xd8Th84WLRvwgGcpJFe8XhwYpsdLzfolUCModjBv4VwaQ8xMGiEaBh0Y+wmB0l1iReLEnfX7ia0iZNkUsBDkVrGCjjLftiiMmjfDZ/OTJ5Q73Ttfg3O4lkd+CZCdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pD1g71S7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pD1g71S7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2d865383so5275ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781556191; x=1782160991; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBDZMBYyw+UgUQjRNToZ0sLPA9XJndpfItnW356E0MI=;
        b=pD1g71S7EtpQTpT/BiJKtBZQRzfYIfK1WP6Ecf1qhkq9I2q6+0lzhgkJbQX7E6OQx6
         8lYPIXsjJGFFmk0JHUpWjMO830tdFyAi4czLo4JWIsG9CmGUVWYN36QRues19Q5DkVdj
         uAb6x+QL2KT8NFZQqfFYaM2OErBJSvUL1I4Qqi2Gw4blEeX6e5fcACZs5tVxoZz7MPRZ
         XpM+9MbJBKt+snIfigmtEgPTGHOMCfwOSkYzkisOYnJS5b7bxPLQE6QRF/w22kQpxi6z
         3iR+OB7SKTTm2BqoMleG4St1JpsngU8TGjGfsyVzOw0ZohYNP8iumIUcX+Jidlm/7BNS
         Y3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781556191; x=1782160991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBDZMBYyw+UgUQjRNToZ0sLPA9XJndpfItnW356E0MI=;
        b=YE+Y3EYmATgADNfHw8Ydko66HwwUKAGjSq8EAkK8KJ0GFvkP5UoWC2V2qHqUp/8MnK
         ZwLQgpUHiLC3+aFseshLlOar+FY3pdUK/64vsv3JR1x1UDcqawBZxm5JirH5l2s+PE2w
         z2g8bcBN6VATHDIw8KEGoMbKsXrf09vUfAWI7jJ1dCsZFTxfiPntH6gAnZCXywYlHh1v
         K7m8JaQil2YX+O6UqCQNfQpyTzniuqBsMnGYXpSBbX+OrIJxpCPc+gOiSO/FbtSE4fXc
         t8c6XDvdyMmutFpW0/pOctCunwM91TSuhVnTwa4TEjRWVdwvZoJeKA+oaZvv75PD4YqE
         jWmw==
X-Forwarded-Encrypted: i=1; AFNElJ++1A5E79e74GVL4DoK4aLg9RwN2ShMvRy/f2SpBdSKPlTFGH33c+gRMoJXAvhdW8p5SQ6yNFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+S3va9/GnS1LmBhxsFJZVq+ZOLgpdrxD9QaiE7lA079tWQsE6
	f3a/+jr8l4p6MBdbx/9Ub15/tAEocTVWQNfm/ME7pXKO5Ftj76YMKocvk/YFk3bhCg==
X-Gm-Gg: Acq92OFLunYTFY7zMvlu1j5L34xb5Z/mCMU1uMlw+MvD9MnMJ7DJQFomTWQHu+orgL4
	nDMhjo6UIVpDCxyPdxKKizPGIH2TSzg1qIk0kccJq1ZhPLEJWMzrhlaWNGWhcdPG+ZZRy3TcrWT
	WQ1NvS+eU6usd4KGZ9/RcWjl9hsCg/NskcI038Sfn8udBdIKKlfWA3R1vGFOB4lJjpH3ZhS+l1h
	mgF3Smi93D6aRnSi4/b7ia3CCMenJaEZMbgbs9GTiR5aZavsAkngEFoLUR2wjdmm0UAFBeZfTp2
	jwEB1zPmiewehSHAqW/DQx8bkIYqKPU08N4Huir72iiE7RSkXcO+E2z6gclR5it0IFIHc6Qu0hN
	LNw9Fukg996iCFowX2t9eZBdilFiduVfEnUgDESThiXVyAb4+fPXki9edyYadSqYMWH+uLtKIa7
	zMYoXj2iH+WqYiHCa3HRwTaqN7qqhdixjxxrTnu+8xBrq4R4p747NmVaXopWsoQdcF85e6KbjIf
	u6JowEitIUiGooWe+8a1j99e/miNBsVBjKDCB/tIRM6bQ==
X-Received: by 2002:a17:902:d581:b0:2c1:ee6e:be1e with SMTP id d9443c01a7336-2c69a35837amr651055ad.28.1781556190181;
        Mon, 15 Jun 2026 13:43:10 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb5bsm483197a91.12.2026.06.15.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:43:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:43:04 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Christian Brauner <christian@brauner.io>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v2 4/5] binder: Remove mmap_lock fallback
Message-ID: <ajBj2BzEalR8jYX9@google.com>
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>

On Wed, Jun 10, 2026 at 04:04:17PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Previously, the per-VMA locking could fail in the face of writers
> which necessitate a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
> 
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
> 
> ---
> 
>  b/drivers/android/binder_alloc.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff -puN drivers/android/binder_alloc.c~binder-vma-waiter drivers/android/binder_alloc.c
> --- a/drivers/android/binder_alloc.c~binder-vma-waiter	2026-06-10 15:57:56.419452721 -0700
> +++ b/drivers/android/binder_alloc.c	2026-06-10 15:57:56.423452863 -0700
> @@ -259,21 +259,14 @@ static int binder_page_insert(struct bin
>  	struct vm_area_struct *vma;
>  	int ret = -ESRCH;
>  
> -	/* attempt per-vma lock first */
> -	vma = lock_vma_under_rcu(mm, addr);
> -	if (vma) {
> -		if (binder_alloc_is_mapped(alloc))
> -			ret = vm_insert_page(vma, addr, page);
> -		vma_end_read(vma);
> +	vma = vma_start_read_unlocked(mm, addr);
> +	if (!vma)
>  		return ret;
> -	}
>  
> -	/* fall back to mmap_lock */
> -	mmap_read_lock(mm);
> -	vma = vma_lookup(mm, addr);
> -	if (vma && binder_alloc_is_mapped(alloc))
> +	if (binder_alloc_is_mapped(alloc))
>  		ret = vm_insert_page(vma, addr, page);
> -	mmap_read_unlock(mm);
> +
> +	vma_end_read(vma);
>  
>  	return ret;
>  }
> _


Thanks,
Acked-by: Carlos Llamas <cmllamas@google.com>
