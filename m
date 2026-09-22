Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D24A3879
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790118134; cv=none; b=FzOLLSPwMnWvRjEVIAvoQ0dQ1ndBVlPyGd8w2OUsl5AeaOnRYTkOBsQSNpf5D5kCaUxTrfd3E31tvLomOOGcYxOvwJhKeI2C1I2FRzhBeTDnaWduuGaB26eo4TPwphGDsWospF2JWb1DfcL7z+gDtK04LA7WUQeaSD7g464RyGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790118134; c=relaxed/simple;
	bh=/kR6171VB3erZoDRI/AmxeFfyrqkGrs6uGWwaYmkEkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzmZdocXgSaVMHb70inNIMNNQmPkO4AGmceRLDusTMfHS7iZuejQVz9Txw/sX5JCj/r0RDAz84Jw0wYVxSJWHRNGjgyZrlejbFM6HgPbWNmcdNnd/Cb/YoKCR/jsJ0sfSy2KMHvEINQwMO/Drepix+W9u5477avnS8rm2GD6EBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1n+cES1; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1n+cES1"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so215830a91.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790118132; x=1790722932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h7ulPYzV5Y+Sdfs1jUESf1o0c5bJv/uTbUIcuWdrADA=;
        b=D1n+cES1mxFmCL+CAWxBSYhAVnjRCOGK2M3w1jPjjNsZeUbBfIGsxotMXKdFyZKvuC
         hGVNFZv/5DodqS9O2jx62R8Jrnza8E4bS0As/HpIzXy+Rw44KSmrZEbW5kNUUjTUfAHa
         UvBtOWbeU0hx5LD06d6cbp/vh8ZxQqAq9PeKoG51/meG5Jp9madddR7L4G8LmZBYHHDD
         yt7qiq052dFHOGOIrzdhKh3R5/FY5i9RgEFBIqvl55SGYQWFCRAN0LX9/MSYSoZUkmee
         LAGet9XsebNiQY8R6q4TTWkKxN30539QcgN3Xb0kK+qs+GtGfDNJv1WJYQrBDxs36ufh
         y9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790118132; x=1790722932;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7ulPYzV5Y+Sdfs1jUESf1o0c5bJv/uTbUIcuWdrADA=;
        b=fZiZmfpw6iiqxqKIS/BcCulttdSriar5KHvDqr+o5ApKUyqtrxBqgCCaFAvdkVvlFC
         ND2M69JXLP2O9Bdhbm8Wha3/fZKYLmDHMAE0fbtetCq0M1+awBrGtx+j5qKMmgXt8V61
         DxLrE2x/MXr3nnHbT5RX9335lwQTjL+xcQMHrgupse8BR8myb9MNRmX788/sHmMC8eU7
         yvz+qG8UXAeJlAOOYgy0tYsQBbKouI1jjnPCK5VdEnrhRAdinoAGTRSjWxYmYMpVSaOj
         9kLesuJBxjF2NFMpwmf4zB8UN14uuKfSF6JqNyi2vQ3JhU/uKWpi5hCoME/NbP0T68JG
         GqoQ==
X-Gm-Message-State: AFuF++maS4Ca8WY4AHZvCp0tRFjpIe6o/n7tzaBmvxpEpUIodT04Y85K
	3G4JrXq8R/mOzZ+KE8WG3BJE4T0+e13wk/NdbMVGTR+F5UgkKcMAgXL+
X-Gm-Gg: AYBFou2WE0pa62+90+PnOKVQizn8cJpYpy9uzBEs/McAvupaggHkcwC8ZFzKSoXTPBh
	Lo9J+SoJhxfFM4RYXrXcvZ7hFG9OEXqQrglcD36lbaqEYNnKiryqsHHoyiBdDQwUHknKbeTBoBJ
	5EFhBa/1kJ4cLdb71UUmOnRNDrE9eRBCTdS9dxEy97bRhAIlEc2YSILM0rSXu+rU2/sBVI8bWyi
	AZmzptYUk76aAuC4xt/L+NGWDM9ZQnLPOnPE8Ihzvt8MsOshGOOZZmHvd1xnCPw/5rWXXP2PWmL
	bWcbOu7mzvWD00L4pW1JHzXQgpncaeLIzhPjTxlbi7es1qSbKNojTcaHBr9FFxlLc+Zzghw4jM4
	VZfUolppAYbAW+6XynaPlSKa2GCVKDaxhVXHLTm8ZkjEkyBxCGMCt2elH/Vs03YFR9gGWkoPGFB
	J3hXzbPQTYnvjJ734+EuFUIXs8gv114EXwt7swTgmX8VgGc78dGPej4pMcPPhnzTq/
X-Received: by 2002:a17:90b:390d:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-3a07e54a8e2mr805121a91.19.1790118131508;
        Tue, 22 Sep 2026 16:02:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07f8180f6sm315373a91.0.2026.09.22.16.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:02:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:02:06 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com, 
	kuniyu@google.com, pabeni@redhat.com, willemb@google.com, davem@davemloft.net, 
	kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: use page_pool_put_netmem_bulk
Message-ID: <arMI41pIJDuQK6JH@devvm7509.cco0.facebook.com>
References: <20260922193356.542922-1-kaifengw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922193356.542922-1-kaifengw@google.com>

On 09/22, Kaifeng Wang wrote:
> Instead of looping over napi_pp_put_page() and repeatedly acquiring the
> page_pool producer lock in sock_devmem_dontneed(), use
> page_pool_put_netmem_bulk() to return the netmem references in batches.
> 
> This reduces the number of lock acquisitions on the page pool ring
> producer lock when releasing user tokens.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Kaifeng Wang <kaifengw@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
