Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453383E1CE1
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218140; cv=none; b=Fi00E9WVC+PteUrPLdXbBxqOyQCrHO43qNqInN8xQmz37Uzdb1Rpp7BW8YfLTzMgwlYdHFVmDNaOlUBfKmYBG6u4F6QOnEXOXm8fviXKF7Sx1aYWLNi5C+6+2cBcTq5N8dvTOW78gk+5uQ8P5WMaV8Tklb8lKTBpZKMcOpMwUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218140; c=relaxed/simple;
	bh=nLjNT1G5JUYYPrhknY0eB9x0ZjckXKrDo9yhKokRjVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7HVxYAOtZrpTQM+nkM/ODmtS9tSUgEYjMdueEQ8ZV2Agxbx0y2j+o7BZhYzz4Lj0LaC7vbWAXljRYT1PL+SZP5hHMnZ9CKGDjKO5FXx6Y9T74N+e/SfEVolY0mn7CGPWyrlCZ9g9XfyYNQIkRFJN9JjuGBUs1TeiG+RZI6wjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDowiLX+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDowiLX+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48431648f33so307898f8f.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 16:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788218137; x=1788822937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Cbbg1ZOVRL0U5f2uy8yCobIVDqIxQsXjzjOSTe5SUM=;
        b=NDowiLX+9lFsVlgSpsbSBI75OdoGWkBcd3+W3sPqomHUJpEOngiZS3JDPCNK1zCk4D
         PcT9p7Nna0HxKYETKWidlLgKKejGVXkefLQCYsmapqoXMMXjOwnN/bL19XZlsyqt44Ao
         iAzD2ha+jTDygPTOv/mws4TcV37rJ4rQJo+0hg4NJn5xqvKQq9rqFtypGeCFvGNYL9yf
         wL4rQSduJCopY8p2S0Oet+5tRnKQoH5kWpK4ERvz2J53riqnNK6rp+mSgeWsn6KLmSh8
         4LbJUyeF8HWyWUKI6vTvLDaOC2J31Wmjjr7D0Bvn1WXm3mFpepcxRKG3saI/T19WDCC+
         VQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788218137; x=1788822937;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Cbbg1ZOVRL0U5f2uy8yCobIVDqIxQsXjzjOSTe5SUM=;
        b=q0gz5j+ZLMLcyEUm5PtUB8CrnEvGPUNj5G2RiTVd5YvDzHZfpA6kV09I33w0IxZ1df
         gJUPx4NFvVXxijQ6y6Po3vXm3vbVL8C0c0rCFyyYhBuJSb3w3df/EFNn/lathugnFtTz
         vPDP/CAUlv+gya61EVEZhkBMLlO0+l8Fc8eWBS4GqNjVMyQSFOsQGTtpj9LORNojQ0Zz
         o/RHMoem6q7sHnwZipYUh9SEQ1MLT+DlOWnzoPE0h4PzvG4Bdmbhg6x/LiSk6wvo6HD2
         7sS5aCuVLMu13rV24wnzJJzkvvS/9WwlO37BVlyVToYRynhCPslvhDVPUMqxz7mDWE7r
         HEfg==
X-Forwarded-Encrypted: i=1; AHgh+Rp48JeaW1C7EmATdqIpuC9SboxABIPLoZtZqyGx+2NoAo/uWK0nCg/Emhn/sOEGP2wgZQZS34c=@vger.kernel.org
X-Gm-Message-State: AFuF++m91tGkDphvQ5laoiQLfTcnVIOK2jw7SAQx2kVa4pVZ69Ia+OrA
	3bwxloKOx9zELNAKedf+/O7BkPCwWKMooXQn9nPoD+emwNkgYXTv91wl
X-Gm-Gg: AR+sD10gbGRzN2hbzsIRfi/pGAR3NqxGdZk8W00SvppQzc2jVV5CajGtAKXTZNWwFSy
	DPOjAGbUoBYrUGP/yhgPb0CDPebdmptYnAxQqROeitK7kSxuqzPhSYGsGoaf71G+MnmrtvFc/Wg
	KS/UQSobaacZf1MOTYSimRdqvUL5Go8hYadpvZH9cALVoiR5xZwbH9vBbbk3/lj/6qelllHOpCd
	h9PUaf9ITXjzXgy9iWIrfhwRxA1RPTZpQzHV38byBG6zeWI2ZlmbIAMjlvL/berLOWb0sqjjqBM
	gCfgnBfheLVBxvMHlHnGPZ/1n40N+ektl0nF+nA5ZH8TsI28H+EP0jL3WuwB/eWHeep0PC5PDsF
	D0mYbu94x5vvR2UC72wXHIe7Fh1IaZI2epzP02BbFpR87R0TxfNFm61Zzwdr9S03JVN7c3LfMN5
	Q6/Kl6EutECnkWMbnelRkUh7pKgqhrymcGXKzx/Zkyt/r/or6ECPr6PZgbzZQd9NVKXK4gTKsSd
	brcVvhh/yYHhoFeGuxM64V1v4du17AHsj0LC/LdxgpZveZQv3ljuohdZbvSz4QdGMe4KBwGj+b5
	8aCvsl2zp1zMfnbbDLJhRse4t54GxiDhA/Q6hgFLcq5sAkeSIOARqG7cMvzb0u4=
X-Received: by 2002:a05:600c:6819:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49cdd41ca5amr23361785e9.6.1788218137195;
        Mon, 31 Aug 2026 16:15:37 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d6e9cfsm957147f8f.22.2026.08.31.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:15:36 -0700 (PDT)
Date: Tue, 1 Sep 2026 01:15:33 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mukul Sikka <mukul.sikka@broadcom.com>, Keerthana K <keerthana.kalyanasundaram@broadcom.com>, 
	Stefano Brivio <sbrivio@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, Bin Lan <lanbincn@139.com>, XiaoHua Wang <561399680@139.com>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 6.6.y] netfilter: nft_set_pipapo: restore cloned
 mapping table memcg accounting
Message-ID: <apYKQbvpIWvY8Jqi@gmail.com>
References: <20260831194905.45045-1-kmehltretter@gmail.com>
 <apX9AZoNkpVrBMIE@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apX9AZoNkpVrBMIE@chamomile>

On Tue, Sep 01, 2026 at 12:15:29AM +0100, Pablo Neira Ayuso wrote:
> > 
> > Fixes: a4983e89e3b1 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
> > Fixes: 32bad10de347 ("netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR")
> 
> This two Fixes: tag do not make any sense to me.

The two Fixes tags are for the two stable branches:

- a4983e89e3b1 is the 6.1.y backport
- 32bad10de347 is the 6.6.y backport

Both backports changed this allocation from GFP_KERNEL_ACCOUNT back to
GFP_KERNEL, which introduced the regression. The accounting was correct
before these commits.

I used one Fixes tag for each target tree. I am not sure what the usual
preference is here: one common patch with both Fixes tags, or separate
patches for each tree. Which do you prefer?

Thanks,
Karl
