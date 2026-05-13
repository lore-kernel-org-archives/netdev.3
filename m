Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97054921B4
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686221; cv=none; b=t5jES1WXeImmErV6cpyyEG54L/puEcNiqZrUjQLzodNOy/nDLKmp+eItV7r3y2pKVMl/pq0UAV520i9TxlOuTUlz8mLdr7Gxzj9UOIw28FKluntxiXH6m7IU8mXF96+kyjhNiwxJroD1ZPOaPN5eOnwYZI8AbHcaccVx8lf4K/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686221; c=relaxed/simple;
	bh=Rd7C5pIyq6OPAFpxl7D+tvMh9VkGH7FniJDQxl22aEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceUTrLzVwyTE9VPPYn93rP35Iwk10EfSgdi7yiQvyW0umCWx8D9DJzYdpXBmJC3P2Gu6TpVHGX2+KO2dfRAbDxzLon2KuXhgz5qXylB2iYZYvDb0cVF7NO3v6yYFoHfVW3I6VPVZemD9gqXYjHd2geIp7YzH9NeY6Al2CX27enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK1KqgKV; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK1KqgKV"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82f8893bff3so3249636b3a.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686219; x=1779291019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPiUqnotsQbH12PdnNU+eakW9jTUpN3Bb+mdu+U6uUI=;
        b=XK1KqgKVKKahwbs+G2BluT/VTSOjPO8KWsoSKiGZQHNeovUR+vI8A+3ezj6Xhyjtgd
         tn1ttCf8QE/IRZs9ukC834PMS4LgYqUjZqwnk/fDp7DeM/bmVkbDItLVJi1pc5L+P0tm
         dQGYjscyxFXCV+bP/qq3eV5DZBvvZbC3PWH81m2tJxuGSFEALflJioLrl5I250cSTJRX
         igUM4RBGnYdS0UcRnFYGmV+EhlKyviak5QL+vvpU4mgj40/w4U5+ulm6pMj+lYCB47ar
         jdlqPSDtZkcLj6Q7f0ldV8kjAOnFkoMsE+Aq8el61PFDmfRh03mxMkuHi9Q+zH8r1X/0
         C17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686219; x=1779291019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPiUqnotsQbH12PdnNU+eakW9jTUpN3Bb+mdu+U6uUI=;
        b=AO2qzuvcHah17dDGedCHENL5kKo1PxnJyG5d7uj9U6McU5DpqBkYHZuxZ3WxUviNYM
         QpLAGhN18vIjNwJeg0n74ck4bPy/A6U0fdYoM/oUFreTZghkd6h4xifQqIFuAFt+N+sR
         zrAo1nnLhB5nm+a5n45wuOUeHHakgBPBo5bLV9PQv8xJ3vi69ab25e/tAQ5CEEP06/Ye
         yl+am65kpGID75CfUxMWzyTzgy2zN0JIJqniwER2AHCG0UEWTdYumwyFaGkrUJWgbLjk
         2NK+e4ZmP1DLKkE6V3CwMqaGEDyIdR5bTgF4LrjzHKJdn/L7t2F9KKq+R3JDY/tqC5IF
         KGPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YOsHJYqFIfX3mBhsXX2DaZHJEEmQMZ4sjFu8x2OxS/EtWDCmflT/ZUhglakne/38PqpEoWEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvQDoyS31Fnf88ViznkMWw6/qwfdWI+gQJoHd1A7nguJ3FhkJ
	7LgeR4WrmTvUkOY3zQEzld94HqtMprxa2F/1j1870lh8tgs4k4Q0M0pB
X-Gm-Gg: Acq92OEpwUPO47jcA/DvtsWCaRlKNmLglf+/mrcTeIX/k/GNsdZ7XbKJLjJ0sfNmCod
	DdKXOnBsGhxvB3Qi1herW20qsmTgQynq6Vy8aBvvpMpI/p7wyDWbnpmhb2Ypw2FIZUhN4yg+/yo
	ODjky3iYbhG3qSDIRJUrO60haBWAfEFuIqQqfu/jxcBElkmyrLXXKaytXlCnS7pxWM0fhzs3piC
	FpKZuWBTbbcSz0skTxeBuxK9lxj3mSR58YyPb2ehgA0sBk/O7mDF/nzmcR66mrXPlsCaQvL+lI9
	dPLWWGMDzVxHhHTRchhhySmaAwlQDLldc+cm6jJemzc2RrdkEgnM9ZtyONiu5yKnSfPD4CAPCMZ
	dR2Io34Kxm35YPU3H7YOmz7T1RUZ6j9I1I4GycbomIgLiEyQJMrJFVOi9c0xXfW9FaldMIeHCie
	CjaMxmm3G+nkUB+wXA
X-Received: by 2002:a05:6a00:22c7:b0:835:3730:571e with SMTP id d2e1a72fcca58-83f03e91a86mr3976162b3a.5.1778686218924;
        Wed, 13 May 2026 08:30:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm33281534b3a.46.2026.05.13.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:30:18 -0700 (PDT)
Date: Wed, 13 May 2026 08:30:17 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/6] xdp: convert to getsockopt_iter
Message-ID: <agSZAkPavoKMEF-K@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert XDP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
