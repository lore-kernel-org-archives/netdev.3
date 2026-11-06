Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968281;
	b=IUklKuSbq00Z7zzb2qS4ojHs3OQzMmz38e7Z71tLwa2Z6m33G0bP5j/el0k/b/T++wuy
	 3k3AFQCuHP/PrCxgfbQ0dL6/pN3BsdLvC1VqzEEjIr46fTUnaR07GkgMRwLgRqpsMTEFA
	 1duQE7Gfa0faQg0AVYLmtbjlMzal7kgokEVLCnpA2gbyWvV7Zkb3eaNiV8Nqw8BDIYPpn
	 EHKJtMATTWAiqY+A7gvWvAqNXd0lc/+cDoGc8CG75iXF22QacPfxmm8Nn26Sa3/uJMbrt
	 FipKtlMBtkrY1dxw8niflnhiozydlkmkdSp3Gno8FbHwS1A7IpEbP8vsVvob6yPzbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pOzKxUT7AEOYV8jkBshdYIOEQ95xhfIUx35G46BhKkg=;
	b=dIeSJF8+pn+adEanAYhl11pPC1nh52J53DQnvgCiAgMWmP0Krlmxbfi2PGBGlZGhdJwO
	 zHCWpdsh/SJx57UP6her8l486gpQAM/7GpP4xLIQyeFXiL62HKA6cORiv0+Tey77Ciw8D
	 pr8sU5Ln/2Luvh1kqhO/+n55D2ODgNi7E+t3Ud6FMiYf/5g3WH3HPfKGRWzGuvwjAuA1A
	 iWfdkSoMLEoe3NJzzYz0bLOkfv5jHoZeAwqgDKdKAUOc/ABGWcia/Kl0T+D/scSmyK0D7
	 ZWfE/oQddskeh5iUwJhQvqEPDRdhNCvkFOO9Fvs7OtSljTqZjmU7/BZZDR4l3pD9N6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=hKOFEJcU;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4C606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC4C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=hKOFEJcU
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso92563666b.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1793968279; x=1794573079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pOzKxUT7AEOYV8jkBshdYIOEQ95xhfIUx35G46BhKkg=;
        b=hKOFEJcUY0Ogw7gyLyr8vZXJEQOLFJ6Qo86GvPqrB2e2DTLTRFLuBke2HTHDd95+z2
         Bel5PqqD0V2CcIBn4u+SYSXzKMtKO0Evvkqa5zkj60Mnbs5lYjGClQH53aarenQS5SCH
         Yx3vhPwF/psrXLJdoi64monkLUKvjnDigCBQLH+c8V0DH7oVvQbWxCtdTASix8WHGCMT
         P0b6uStYgHgkeRTgh3xZO7lJL1h0AzF9qn43rtzof3lTnYDAAt6UoUPmWZ/A/1ms9vVR
         IXbStCIdDVCojAJeKuOTtYsUlQVn3ZPkTYDnmAstq0GwPgDh3r+4H2jmLV4kA+69mwr0
         uNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968279; x=1794573079;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOzKxUT7AEOYV8jkBshdYIOEQ95xhfIUx35G46BhKkg=;
        b=ytFgjG26UiBSCQWxAB/IsZYxFKcLqDub99nh70Sa8UDoPqhFijdDes9es6QbgDlDic
         KyY7pP0DjtHoMP7u8vKRxYVJlAK1+kL6EOTbozdiuaO+kDzZBtox6z7t08RhhLLXGF1V
         K8dJtpXhqVNYBhy58n5F678HliQbnUVlIob+uqX57prGxuHTMzgjt5ltdEwPsrIMh1f6
         saf3Cbr9ccT4T+ppFjOzqx0ECAL6so6PSnsKuLsUFcL6gJt2Dzn73v34XELr6/A3EOQg
         diYnEqtWtEqNSTMzFEZ9mcSM232/mWL2QAhiEWAQUeMaGjcbDayMda5ykfve+CtfkFCS
         islg==
X-Forwarded-Encrypted: i=1; AKwUvBz4KOAH8sq1+XlsKQ8PrRLzV/lYKlCYqHQvBJdZxjdoAbIkAMMIuRXdP9CpPSDNFDIeo5nJhso=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s5pvEh8CWFSmli2TcVb2IySNX7hU7fgJQkPA10TBR4TNb+rQY
	DLjGQKZWcRo/GsTKY37cr97kl0okS0jwd6CAWlE++1+TswY+XIcXEDZqhZBIGsHhDNg=
X-Gm-Gg: AYBFou3//YmuhVfYS1i+atHtFl51AMM2otuARIbe0ZyQjBTR6c+EeAcDQ8duCTyf9bz
	MtBnZaqXsADlc82usxBGvd1Mv0St32xPuql0iruwCs8skzqoZ3ylkmc/gkEJ4zfWwBT9yg4z5pR
	DVkJths1gX8FG2RWp/Dhunx0sArmtqUCFxHMOuGdDSer5+ihYbJ9ZxgLsiu+HgtLA/NuxOTEZ5y
	5tg/LP5pmV6GL2yVbvB6SRrMbvcZPksazCSlvLJwvgeMeCUZ5Z+7BVTwdVVdAhYufzCSoNYaC3P
	/KnA/E6nwJe5HL1nV5Y2CBK5u1gAM/FFjU6CbG/8K5YcGzo1eVD7qSLlvqiijC8luSP4G5uY0b1
	0GmbxpjC2PvNypuHJwgC2EUACz3Moy2QEjTwUK1UFLBjNK/H6Tz0abwlTPfTeoInVXdtv4wi814
	1hXWfisjVNnY2cIfZt/CoKhInSsN6UFBfABfHQ0Y+Q1EKDzIaP/TmQ5A/LGd09/zJ6AXuuqW4LP
	8/Om6UnP6ua6NlICaQBanbAvUUwUROUr0hfD95JTlnaZfgcCe7HO0Uxtn9WlXHlRhQfMH3jVSfK
	PCFdtL4Ff/8RCVa/iOwuRkCqy6D+0kvF1zyp
X-Received: by 2002:a17:907:6d13:b0:c4d:2895:e492 with SMTP id a640c23a62f3a-c4d354c5b41mr215939466b.21.1793968279181;
        Fri, 06 Nov 2026 04:31:19 -0800 (PST)
Received: from localhost ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356ea58esm77460866b.81.2026.11.06.04.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:31:18 -0800 (PST)
Date: Fri, 6 Nov 2026 13:31:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] lib: objagg: Fix stats imbalance on hinted-parent error
 path
Message-ID: <au3IjV88SKC1wKsl@FV6GYCPJ69>
References: <20261106095621.143-1-tongzhiwei@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106095621.143-1-tongzhiwei@cmss.chinamobile.com>

Fri, Nov 06, 2026 at 10:55:58AM +0100, tongzhiwei@cmss.chinamobile.com wrote:
>NOTE: this commit is worked by llm completely
>
>In objagg_obj_init_with_hints(), the parent is obtained via
>__objagg_obj_get() which increments only the refcount without
>touching stats.  The matching release for internal references is
>__objagg_obj_put() (no stats adjustment), as used in the success
>path in objagg_obj_parent_unassign().
>
>However, the error cleanup at err_parent_assign calls the public
>objagg_obj_put(), which additionally runs objagg_obj_stats_dec(),
>decrementing user_count and delta_user_count with no prior
>increment.  This corrupts the parent stats, leading to
>under-reporting and potential user_count underflow.
>
>Use __objagg_obj_put() to match the internal __objagg_obj_get().
>
>Assisted-by: LLM
>Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
