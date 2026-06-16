Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D33409128
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595178; cv=none; b=A6162zenZl1rpWpZgbmNkZBVYq3AGrFPnuPzDlmhCKoImMXkNiWFS3UCS1TeP8y/nRE3WsednJzYmB+0PCpvGFh3LCy484np1WdWo6GtchaTUoc3MLPKhAwOERcF4p0YozV9MWPw9yYpPZ1q0qpK3ksOgeK1hO+Ijs/7G7tyoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595178; c=relaxed/simple;
	bh=cd2B0/1gOgvgOhT71QQaefkBal5eD8dZq2pHN3zhVFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWeHOGOAfqMfPN+a9tuet/DZtQnuZ+4wX1xWYVjFDawmoFRkE+1zuxz2VnwQmFHQkZfvt4rycsGSMdIUnlq7Av2Q4VgnrB0aIfku43kl3JLyW0IM+pho7wuPJJr7tNt3rAKQCSCL9VRc8LFhPCcml3dCliI2N6RF5RPOjztr+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1mYzQL+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1mYzQL+"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ef697092fso2993362f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781595174; x=1782199974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zyAwKqxz9gNzOb7Kn09Yqf6wA69wLeYs6JAnA+G13A=;
        b=n1mYzQL+VrofBTHWD3X7KnK1Q7EDBDrA2TSpCW94ENclNMTZxKTRPYFMInqS0YhG5S
         1GQfXYE1WIVHlIcRsmRfTvcKfWwYF/D9w1Us+Op8QCBHLf3vH3QnPUnKSa44aJlCGOR3
         a8uhIrII/NLIYwIfgQxsF4fiDGuZVcvyX28kttXm6GpSGaehwgGKVY0SeGhAJsqzJXy5
         mgj7lQbtMtW4ICPyx4pnHEnAQ/TwhdCD4QLzq/V109ZzcQ/fZ+Gmlp5hz2+0UiGXqpFu
         oyn8qPFguIohnlQkuNFGHyTX2iyuewS1GvKDVt0hXtPDNYIQ8G0M2a4mK+kzEWXqeeXJ
         wxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781595174; x=1782199974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zyAwKqxz9gNzOb7Kn09Yqf6wA69wLeYs6JAnA+G13A=;
        b=B7pD9fGqlTFUO6KJetwAUP7u4Qd/akdixjW2dxqPHOOhPFt0uMha4gxpf2d6XrOZ/r
         bb0jTI74sesA2mTVFtxbKMcAu0nupkYsj5Y7caWVb3Kwdqjr4kmg0Ft7SQi48lm8JXlI
         CUntiEhqFh/4sAu09GI+uATWdPwU24Bsmfm3P038GX4E6Onjz6kxNO1DZt2kMJqvny9T
         FERzxhSMMrw2wOiBjyTu3j+nwGEKK0Ie4g+n7yrcgb2FsfYEwW8uMyt6fbcFJkJTYDfT
         ce7tE6YzEFUXE3+xbws1Kqwdf9BQ3vlWkFTYV6k/AvduKL/HWXFVYpFRFk5dMx/aWHZB
         M7mA==
X-Forwarded-Encrypted: i=1; AFNElJ/6tnfYyQfOymZ4qkWXQOAKFDGKEZu3sF5u1o0Ia3tFK8wwUPV2CvbuhPfcQDxjPsa+c5L71aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWkTBN0KQFV0yVOPbAITIOkBXuH/73+/CIfZCTPEmBFmIMeVA
	7r/049hg1ZYvoJuNY144El0kMjfwUkHWZ2dJvqX3oul0NPMIcKihjqhAWEW58aZoSxHVWDLegRQ
	3Cz/L0H43UoPHrJ9o0A==
X-Received: from wmbgv3.prod.google.com ([2002:a05:600c:80c3:b0:490:ad90:c234])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1591:b0:490:e281:287d with SMTP id 5b1f17b1804b1-490ec4c0ceemr150167325e9.1.1781595173855;
 Tue, 16 Jun 2026 00:32:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:32:51 +0000
In-Reply-To: <20260610230411.617DD5E7@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230411.617DD5E7@davehans-spike.ostc.intel.com>
Message-ID: <ajD8IymML3eklnj8@google.com>
Subject: Re: [PATCH v2 1/5] mm: Make per-VMA locks available universally
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Jun 10, 2026 at 04:04:11PM -0700, Dave Hansen wrote:
> --- a/rust/kernel/mm.rs~unconditional-vma-locks	2026-06-10 15:57:54.051368539 -0700
> +++ b/rust/kernel/mm.rs	2026-06-10 15:57:54.078369499 -0700
> @@ -174,7 +174,6 @@ impl MmWithUser {
>      /// When per-vma locks are disabled, this always returns `None`.
>      #[inline]
>      pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {
> -        #[cfg(CONFIG_PER_VMA_LOCK)]
>          {
>              // SAFETY: Calling `bindings::lock_vma_under_rcu` is always okay given an mm where
>              // `mm_users` is non-zero.
> @@ -188,12 +187,6 @@ impl MmWithUser {
>                  });
>              }
>          }
> -
> -        // Silence warnings about unused variables.
> -        #[cfg(not(CONFIG_PER_VMA_LOCK))]
> -        let _ = vma_addr;
> -
> -        None

This isn't quite right:

    error[E0317]: `if` may be missing an `else` clause
       --> rust/kernel/mm.rs:181:13
        |
    181 | /             if !vma.is_null() {
    182 | |                 return Some(VmaReadGuard {
    ...   |
    187 | |                 });
    188 | |             }
        | |_____________^ expected `Option<VmaReadGuard<'_>>`, found `()`
        |
        = note:   expected enum `core::option::Option<mm::VmaReadGuard<'_>>`
                found unit type `()`
        = note: `if` expressions without `else` evaluate to `()`
        = help: consider adding an `else` block that evaluates to the expected type

This error is triggered because you deleted the return 'None' at the end
of the function.

I would like to suggest the following implementation

        // SAFETY: Calling `bindings::lock_vma_under_rcu` is always okay given an mm where
        // `mm_users` is non-zero.
        let vma = unsafe { bindings::lock_vma_under_rcu(self.as_raw(), vma_addr) };
        if vma.is_null() {
            return None;
        }
        Some(VmaReadGuard {
            // SAFETY: If `lock_vma_under_rcu` returns a non-null ptr, then it points at a valid
            // vma. The vma is stable for as long as the vma read lock is held.
            vma: unsafe { VmaRef::from_raw(vma) },
            _nts: NotThreadSafe,
        })

Thanks!
Alice
