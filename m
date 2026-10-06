Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8863839A0
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324439; cv=none; b=S9ffz1SwBM9wb4B6va9/GnLxHEQcSbnPzaKcvO7cPSNBGhEsgW+Ou4cK82f3io6x4I+hXYwpSnkgMx9L9gyVUApNNgzK0QBFpRL9JuNVb6qsOKgiUwN47UvpKvAwLdV0OtBYMpoEvuVmuVu0zjKhNVtWhCaKQ/t28MgYNIUjNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324439; c=relaxed/simple;
	bh=N1w/RI/C0q/lwMw02zFBu9mqTNmBjMURnf2bk+PHj1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwmsXkIyzMSWtSZOl1QCnW+2hBt/56A3RI4yDX8K1qP+c/jDixFPAZWiPZ8CXmYjgB9mKIa4ytDma9+TbHA4+94idxBhwnCf6ggbkpg4hruteDsUpC1Y82PYI9jsk4P4szknO9YAtIe475bmnU53VLM2pE77QHAc++8DG0nYdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUNOHhQp; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUNOHhQp"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6fbdc8772so14927545ad.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324434; x=1791929234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lB6agACZeDpwgUNu5aV9/2/RlBCLZnqsqbKw/x3m5Y4=;
        b=qUNOHhQprfOQZ7eZtYfryVYBbT9FQn5Wqjk7JB4xRwneuquRnLKZGYApaCGI864HGE
         PdUxMJXDd+mq3bneIHF0tJWW7FqPPcf8nYsuYx1zEnlguoCipVlgecG5zCIEEOYzLZpW
         GSgXrVwS0bIdH7tu82yMX1yX21xqhSOajvrBPn2makWmxUy9soE0T0ahdnRRegipSAtl
         DAz9gMU5jEPij5aFTN747Ny3O64VVv8eyG3F4MDO2Nc3fGNTZY7StfdiTyqePYGYFqAH
         DnaHuajiZHYQodOQ3ZuGtZl7eyG+yLolIwmAn6c1K2Ha75YnLRpIe9nsdrnirRAHmOGH
         rD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324434; x=1791929234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lB6agACZeDpwgUNu5aV9/2/RlBCLZnqsqbKw/x3m5Y4=;
        b=M/nDRlkaSrDsSilx/rhRjoD4IXevqzFKn0RPy46Iur/uE08fVsMEdJmLeF8GcFQY4H
         NK07qMNnNKNc7fDIVXWXbKCcfnwqYQfKXjlBup7M8r3zXDyi6DEurr5EaQfFZjOF7DFS
         Wmj65ee4A6zw7Ndkh9drFOtJviU66PNQpymoxnWJ/Tp+lGgO+5n40RBqlcDZy067YAQS
         GxKOVrbJL5sFZPnJXfdqQx7bV+PZgak9Bb3kBMTNj0AzfKj2LJSt8p/VdrCXOUEEYWHS
         H/2Tf4ICyRt+a1VywtWxDGCOdRaM6H5TpglOsttlSDQIVyI+JuKrlH/0iijBxRjbgAdx
         /c0w==
X-Forwarded-Encrypted: i=1; AKwUvBwBxsYvqlhEDNNI9csWd52ggBRruSLSg9ZBmhX05id0UxKtKUxS5d65UluZFSGqMj1tZ3/xOQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mccuglp/o5mi2y7hnwFP0YR6pSczBTGuVAwqunt5L3BIktByFu
	PgvqmTqnZLn2hTF14FwCu3mPC5y1McwQI/kFPtk+T8dx6H+lh00smPyo
X-Gm-Gg: AYBFou3D1eUM+iYt5bNGVXFstFBeh6MHIclUQlSGLveUiuNZdmo+SA30DAll9wuaBEE
	ebdc0+7PkUJ/q0S1nNgT+4MCqE4Dlfyn3qw2YC3BsEYuTO0gY2eS0Afe4rubc/2Aw5w9IHhT+v+
	4SgjpqdDkI4PkaPoF8NA4iUTgH8v1x+YeTcfcU96qdkNmFC5X7narXIIVbY3HC3u2U83SWBGc7d
	MDmbTYQeLxLCBEr0KPyqhhCxMaYQk2GTWyHOSi6f5EgNzLiWd13xYKdfBEu6IExTONcZCl1YANY
	XQl3hJNe8tu2bwuY3cjJrK62IvvvwDamSMYbZqQBqJQuH2mU24ncCSU0kAob+AaNKezuDZml1yq
	8ZOdffNpHOyrN6wfzXeV3ApTsfXWlAfZPwyZDh2zj+H54QEdqgLV2wvAyMqZfgeP2zsDz4kYgUC
	hgzYT/KglwPecRryEJJjzPiKwylGwLNtyZSjoNiEYU3CW+SkJlwebJIBFIhspCmKs=
X-Received: by 2002:a05:6a21:510:b0:3e0:c4f0:5c16 with SMTP id adf61e73a8af0-3e13405c154mr274874637.32.1791324434488;
        Tue, 06 Oct 2026 15:07:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a92d6161sm428571a12.16.2026.10.06.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:14 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:06:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 08/10] bpf: mptcp: Don't support
 BPF_TCP_OPS_FLAG_RCVQ.
Message-ID: <asVw917BqnSkQcW8@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-9-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-9-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> to bpf_tcp_ops.
> 
> MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> subflows.
> 
> Let's disable BPF_TCP_OPS_FLAG_RCVQ for MPTCP for now.
> 
> If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> extended to properly support MPTCP.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
