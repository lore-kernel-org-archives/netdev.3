Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E72FBE
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786325522; cv=none; b=UxQOz3xTSUC8KXVUPVHVPzbbEFZZ8qq0wh2JXcZb3g5wYDlUPoyhz3dldZJ/gHODKCBnb+3dAS4WWD2XQsH+M8wJINTZFlJ/6FqpZJj9xWsxRHrrPaMgqQ5Teh759vW2u9/ZJnugX6b1Jj8xTQ7oAtLCM/WpeRBbZ9Ad9Sl6N5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786325522; c=relaxed/simple;
	bh=pc2d2oGxjwJiQyEaE6C1+iaJskLK0RV8Yzw8+87++kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC2F9RW0DfzHuQCxSAAPBYaY0k92qoCp1BT2dHliOKfGTYSBoptHZZ30C2tadqmFgfjJ0rIrCZzC7ouFadOHffJeg0NnwnRJcLdjfijGT7Su8/akq5Eq0kshSzYRm2qfhi5Y37i0HISr4qAb8n9XDxrN35U+RGOA+3o2cgGZJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRExtv+S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRExtv+S"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so2835544a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786325520; x=1786930320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDbchV2G7EpH82x3rYzlRJkGZqdzjbYQyUeWypMVefo=;
        b=DRExtv+ShCkzbAZ3vgR94KSZo430ko45l5jL7WCgY5zhFUEQo819o/J65du4A0pbSd
         T31PEdSBNdMwttDnfFZYSQp/JQuEmdxruaMEc7pKzMbDEohzWqZWPOHFhB9FZkvpRb/E
         5AS0VzaUl6hMx4gZWReFLznTPWVWS2r13qx1RC9IMACLeY3KMtgxTRvLx+nKfFAetZxA
         Ac0k8aL4EBcF87iI0nyYmua0p6PZHVKceEnLWjP8QPD62PUD/WwTr2P5+QFPisGpmHbB
         YnhgqmoY358Qoe1v/Rt/eXTRjgc3MSXZ5JjZ1kBFTFwX+hxMz1sshJjIyKEuQ5sIUPPM
         mD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786325520; x=1786930320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDbchV2G7EpH82x3rYzlRJkGZqdzjbYQyUeWypMVefo=;
        b=anAn0FfmiH/HdyW+Ro/x8Dmap8JPV31OBvVv60/f1P6GDfvVmWTJqd7/aEY6e7GK8r
         CSuzrIMIn+b36rzzPuVrewKqWI0uuLAuFB8hiY1jAmU4DSWtIdIw5F4OhBqDPDNK3rWj
         Q9cPZKJLMDIUDKW5RKmo0B3axREJGRtwSTGWc8uP9JYbA+QnWzsiGM4ye9tiO2WPtzsq
         m1vb0rHuQnCKD3Y6M9IZdNdd1Fm5msnpssvcepYfWmK1kHwQlSJg7EAG99NkZ0yZFcq8
         GmHNPyB+DAmUBjirFRqhJl0HCTLRb+oX2crK64fHu5385ZQl4XP2f20aZ8EJRT0t6Jeg
         JqcA==
X-Gm-Message-State: AOJu0Yx2RMoVC9bOd9744T9Ww70Wjj7s52FwKeuFpgmxOgyEIInGveqG
	lK6mDuWOLm/gA5rwcr/2kqm+hoM0NwPxgOigLOKJF24dx0B+Slw4nXPi
X-Gm-Gg: AR+sD13wGYz6Y8bgOHoTWxIS+SfIu8A7oWtAc0NAtKhx4EFwIMtBuODPVzPdXl4m422
	8H6mPPHWqDEjTYShV2WYtboro8xUpp1mRyVDjKCFVDdBO/eHTLRinTuzqyH8wgeXJIx9U2nllV2
	83ICaLtEPSg+G1q53mSpz1H0I9SDWwjsYXEFAmvtQHKc8qxT7duqMWlnaE4D5XzzFq1ua9xIlap
	11r0gKjUmasoad8lYr5eLfBMMYpR+IA/cLA3iQE23gncxCoan0yP5AAaBLU2uO0LDivd0VgUwUd
	EDr6SZlFlxaxt9gdqUmZF1aG7aThlbKY1wCGWOes92NlaEAtjoVSYs5AxW/73jjWqOj/ZrKHtEL
	aXNNZjp0JpOcW4tfr4M7Y746NFnygOY3/1F3cIPWKTGhCaFtbRP+5Jxz/iau1qrR3UKYuieUPNy
	pM8QREJwuHjnJenK1A0/68MCXusvnt7XzEsqFZXEVuYBFQOvnDCY7a70VAw8c+Ek2IWA==
X-Received: by 2002:a17:90b:4a4e:b0:38e:6d55:b1a6 with SMTP id 98e67ed59e1d1-392845e2173mr6585248a91.3.1786325520057;
        Sun, 09 Aug 2026 18:32:00 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3926254ee45sm9987298a91.2.2026.08.09.18.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 18:31:59 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:31:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	fmaurer@redhat.com, luka.gejak@linux.dev, kexinsun@smail.nju.edu.cn,
	arvid.brodin@alten.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hsr: free learned nodes on device setup failure
Message-ID: <ankqCHe8D9y09aN3@fedora>
References: <20260808110814.1637-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808110814.1637-1-xiexinet@gmail.com>

On Sat, Aug 08, 2026 at 01:08:14PM +0200, Xin Xie wrote:
> hsr_dev_finalize() can fail after a lower-device RX handler has
> already been registered (slave A is added before the failable slave B
> and interlink adds). RX handlers run in softirq regardless of the
> master's state, so frames received in that window can learn dynamic
> nodes into node_db, and the error unwind never releases them.
> 
> Free both owned dynamic databases in the unwind, mirroring
> hsr_dellink(). proxy_node_db is provably empty on every current error
> exit (only interlink RX feeds it, and the interlink add is the last
> failable step) and is freed for symmetry. The order is safe:
> hsr_del_port() unregisters each RX handler with synchronize_net()
> before hsr_del_nodes() runs, which removes remaining entries with
> list_del_rcu() and defers their release with call_rcu() for readers
> already under RCU.
> 
> Fixes: 81ba6afd6e64 ("net/hsr: Switch from dev_add_pack() to netdev_rx_handler_register()")

Should we use this fix tag? The proxy_node_db is added in
5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)").

Thanks
Hangbin
