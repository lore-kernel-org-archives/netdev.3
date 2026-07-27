Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D569396579
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166035; cv=none; b=ruVNZ1rHyZ1SfY3RqhlydkTJdQYqMwTxeuFY0anN6nBfpxr/Nay5gQXrIRfV/ht+dK2WXUfmh800TMhvHdbVH86KEGMSzKkfgdvj7WAk6Bh4hZi8d2sOAq68p3hMWdFTVOMSdApzUBZBNZq4O/PI/FyP49w5Qq27VmxC8Rn288A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166035; c=relaxed/simple;
	bh=vCyBZzr8XG5fTez25O0nwZsdRsvkch87OhUwThfBK3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YINU86Q0mkzolCMg2fenODjqUELZMRj/a/b5V0ae2LQK+0MmuvmFwPT4CjN9HLGxNF+6t6CoZq+akJR/KR69s0ZSz1y3uvwZ9Td7F0gI0Pd9bGD3YSXwaMy0dSiO1p348yMG+qDrkaO3Qjdw0DY7olPMBEplaP/s96BcuoIKC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz+fa25R; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz+fa25R"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-381072761d4so1910829a91.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785166032; x=1785770832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAjxxzf5O6bgYjOTSZSfouQee5mJtyXCeTi3IXQgpWs=;
        b=Lz+fa25RJXHRCs6DF99cRN7MDbemvvD1xhuJKCrZmZfbDA0M9n4P0SsiOFl/vnb4Ya
         jez7xfQQS1ZyXBI3DuQCP+ZyU7lxbApOTke+BE2qYPBd4KhApbUEU79o1eR9BqPwC6co
         sXYOOPd+lgq3R1wwmIqSe/cnS++weE+mqlbf5FEjABM089BiR2q29drG2pKG6D0CBQUR
         omDHKs6D/uWM/hcHv+tcXJvDOG727z4cb9tqHZ4mwgFVeHS1l4aWtkC9PqUyNMn1/QGH
         E9Y6YinaxqHzzNpcrSWCLuWG8H5iZ8n9+zY47jX4ZkEsBsl67z841e3XAfv11yceLv9z
         K5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166032; x=1785770832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tAjxxzf5O6bgYjOTSZSfouQee5mJtyXCeTi3IXQgpWs=;
        b=lb9H+SnEYlTHbBTS/+PASBZdAanp99obG38b3+7s9Rt8iHfvy3lZuOvVpMdFlW20IM
         q/gQKjkukY7UEqcO0QKY8jfJxjy8EDgROfDe87AOv8/ieazlu86CHqPbf15gdrD5Aqc2
         deIwF5HcmOxw7u5ynvaNHo2F2lo4VXDP6mHu7mBNEaxh+LWjLLCFQNZlIe4RNY/+5KYX
         zudLlS8tbJwTh3/Nx075pxOuzJ6kSNjTPzgQ+gIWFxkZQUfikzMhhk0gxAiZlDoFzeqB
         C7KhU1Gho+LQvyUCMf2fmr2wxawN9n3Rj2oC7qHrOFLV0FHhm41JdPKO9CcCj0MLY3pC
         4qrA==
X-Forwarded-Encrypted: i=1; AHgh+RqVKKycuLwfAQVRJUE2Tzi50tbfd3jDPiGvrdmotXW1XfJq9MiB40BtZ3UlmW0MK1LpcOLh2gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfW+y/oDVz5Hm5nmdaqYtW6TWByQec0/paXtZsIxrobWi9GE0+
	xvGm9/FAEOt4vLvT/LaugYZeMp8vwNeIB0/C2j1iPYMI7Xuir8HmwngJ
X-Gm-Gg: AR+sD13nhnpwuQcMl7pBcy71UJRsDSND09w/yO1AZdNR3zf5nEhURi9CmsBDYWrmgjR
	faqd6mXxrByOQ28ZRXhm4hcrNAOivnEsdMF5qsm3jnl+mDlkoG/aLDdHfSqBuPrddHfA1vahHpD
	NQxIkaIWk7hUOp1H/CWP/K8dLMvQksxNLZ4lql3tk6Ko4QHMWeeJU3BqyRNGvSbqqWEvKj8b7E7
	B3KsY/X/0+/+VE46Vt4J0YSlDYzyAEClwyxngODY2QhyF+uR2uyyr9JG3+2SSps0bs6wjKR3R+y
	FWx3pMV9axgni7QxXF/ads1POk+/CXR+dppneHIvtbJWcTQbxDI1sejufPKiTVmclqZCLh5qJ0F
	d2hSfjrmCLM5d+f/lDgSNjIUEG4Ajrwv2BGtDAawBvfGYiyLcbPMfnGSKvHaNWOyKmhDK7Fg=
X-Received: by 2002:a17:90b:4a51:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38f295145c9mr8809225a91.16.1785166031485;
        Mon, 27 Jul 2026 08:27:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412ba8csm1894a91.7.2026.07.27.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:27:11 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:25:34 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@fomichev.me, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	=?utf-8?B?UsOpbWk=?= Denis-Courmont <remi.denis-courmont@nokia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com, =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>, 
	Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 5/7] phonet: pep: convert getsockopt to
 sockopt_t
Message-ID: <amd4ZOz51Y-ttEBX@devvm7509.cco0.facebook.com>
References: <20260727-getsockopt_phase4-v3-0-e89627544639@debian.org>
 <20260727-getsockopt_phase4-v3-5-e89627544639@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-getsockopt_phase4-v3-5-e89627544639@debian.org>

On 07/27, Breno Leitao wrote:
> Continue converting the proto-layer getsockopt callbacks to the
> sockopt_t interface, splitting pep_getsockopt() into a
> do_pep_getsockopt() helper that takes a sockopt_t.
> 
> The thin pep_getsockopt() wrapper keeps its __user signature for now:
> it builds a user-backed sockopt_t with sockopt_init_user(), calls the
> helper, and writes the returned length back to optlen. The helper uses
> copy_to_iter() instead of copy_to_user(). No functional change.
> 
> Acked-by: Rémi Denis-Courmont <remi@remlab.net>
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
