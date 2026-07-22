Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0D43745E
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752887; cv=none; b=k1AcqF6DaMzM3lcGMjnnBL8BRCDBUvemKzVh4eYIfLXzKhUaPpx/japOSktdFDunv7UuEudPY50XI3S4dZhQZJ/+aLZP8jBsZpJzwEpSoqQ0fcCyUVyllp3WAnPPo6RS/hzMRS8ARm87yvT377UmT4T8CTVt6Eu7r+xCIeeNzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752887; c=relaxed/simple;
	bh=Yf15RLlhXlooxQ5ojngrKI3NfRjWBJYoBlpiscAPU24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9ZYP5zzyE4nLpu3tiCRvN/Jf3AYBIEROSP+IzhbtZHvBnArdMFoNP7xOUMDRfmRk3dkpg0xNTXvqSxSx+tI/TmBTBE+tpyw7YyGkccEOlvIHYzFjQJE8oHv++Z49DZ8rL8HBixe3N6YhR0lZiYqyg+ZsE4ZzRmcYRvgBGlvugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvkoZmOM; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvkoZmOM"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883fbfso3460096a91.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784752886; x=1785357686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwCODOyVSYFhI5c3HdXAxVNdit7/+b6pODVCWxPDLeg=;
        b=OvkoZmOMoZHgmw+uthSEVZwNaDuIVjFK8r4wZ5vcwzk1Qmle2wf/d9bnQi7DIwBuGy
         h7y13hdrNMox/fnxHCtGBAHc7KTIjEXL94fET8o/Mrx55Aog950ugI93RdQcrchmOP9I
         TVDYhfYydNaVHIspnhmuEy55MXIzI3gaJ+FCdzbibdeazu4m5uGj3FRb9vxqq3CnikDX
         lLXogicjPaQDGxkDxwzRh4hs6v86kKKXZf5NwvReJJ3C4hrI/8HVHgeDIISm3BiwA5OX
         nrmhFK+GobX+1TWgBrj+Zgx23kb8PGPUX3GLX5JdoD48npqknWp3WhPfLS3IuC2DkuUk
         fNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784752886; x=1785357686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwCODOyVSYFhI5c3HdXAxVNdit7/+b6pODVCWxPDLeg=;
        b=EPix3o2EjepMGxC9N8ZL4D6J36g/RQ8W6qgz1iXC6CkkaHIIw75wrZJPX1nJEiQL4V
         iEL1oM+iBzrPdH55HEM8ZSlOR/XbCxmXmhjBcAtj9bEE2rRLEzYsU/qgdkrDxyKFWnQW
         RINxUyRUV4u0WNlTLPcBNqncIIXs1QHXvqiLZ3xl01kGQ4o9kWZ86TQLX+jUOG8pb/ZI
         KmsdmrKqoH4wjCYsmXx4zhh36jkmrSKQ5/YiMSWsoysCuyY9dHMTZOac0B+Bojg8TSBW
         pWt9yJ9aHncZDNWRpFXCfwjjCcL+H+SqMezuQ4pqCdqP/p1ab2wwT44TQU4KCLMecrFQ
         XPbQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZcg0A0/T/UU20wXqB76jUD07czkqn5LsmYToiilUsxn21+DZy8lU3JWUzg5wLGxXaFbm6qY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66hiidyyxeGGE5bu15LtrGfUHBnGYB3NojkPx+XpH++n0UaXc
	VycR9t+5AjaR515BlljnpillKv5Vxs2kq64LBNc01OMFbRdsDQtHa6iC
X-Gm-Gg: AR+sD1320hZhn4tRL9Rf1bdXo8jGsSpfTG/M19sqVB7+mrnrAG34CV7M8jhbU3h3zso
	4RSKGHBWMPcKvYp/Z6v9Sc3tE3imfAxwP0wXCg83mePXMsys297DJZknHN2oEQB+ZXsZ4Ya/eY3
	BmbXdcsasyQ6TkLCxwkHV3hwLB9a77pxe8yoqT5qEjXO7rZPN2cCwfpo1T6fXQosaN6t3QsqNG3
	R8VQCzeHFl07wbUfcrTuM5SXF9kKZ4ylYeukjpLo4Wu95JlvtwQvuIKoAa2fXYb/r1IDqleJqy6
	r7Crf1Fx0uTP2X1GuDmmcpLXjcXgXXbkT6sjcIzdbF0Z55mHroEb0bjN6lt8RvBIRXgxURwLPMP
	WTH6WdKGLRa7My4L6A5Go1wwmBNpUeVur1YnZfQ6Eg87arBvu447jyRrbq9jZO82Oy+p6eY7lwg
	MBMLAaEA==
X-Received: by 2002:a17:90a:e703:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38ec6406625mr281164a91.1.1784752885668;
        Wed, 22 Jul 2026 13:41:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea466e62fsm1240712a91.1.2026.07.22.13.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:41:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:40:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS
 skb checksum invalidation
Message-ID: <amEojEGsIGkUjIWn@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
 <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
 <20260721183256.6f49d6e1@kernel.org>
 <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
 <20260722113525.34092660@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722113525.34092660@kernel.org>

On 07/22, Jakub Kicinski wrote:
> On Wed, 22 Jul 2026 11:00:07 -0700 Stanislav Fomichev wrote:
> > > > This is about current drivers that only report UNNECESSARY with xdp: the xdp
> > > > prog has to maintain in-packet checksum if it changes the payload. I think
> > > > it's a fair assumption?  
> > > 
> > > What about decap? If we decap the header that device validated 
> > > as UNNECESSARY there's no possibility of maintaining the checksum
> > > (by which IIUC you mean correcting it in along the payload changes).
> > > 
> > > I think we'd need some API to "decrement the csum level" ?
> > > Or some heuristic in the drivers to decrement if the head moved
> > > by at least len(IP+UDP) into the packet ?  
> > 
> > True :-/ I guess one more case to document?
> 
> What would we be documenting? That it's a known bug and we have no idea
> how to address it? Or am I missing something?

Yeah, that UNECESSARY + decap in xdp has this corner case of inner
csum being not validated (and currently no way to flip it to NONE from
bpf).

(idk whether we really have nics that do csum_level>=2, so I'd just add
bpf_invalidate_csum or something, but it's a separate conversation)

> Again: 
>  .. the ask was to sketch out the plan of explicitly
>  updating/invalidating the checksum even if we don't 
>  implement it today

SGTM, I'll leave it up to Lorenzo. I had this TODAY vs TOMORROW summary,
we can expand on that with UNNECESSARY+csum_level plus maybe more
details on the shape of kfuncs for TOMORROW section..
