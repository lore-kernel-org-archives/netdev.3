Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA54B7A2B
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023817; cv=none; b=X3KmSzPG1bW3vjiJgMjP9itiG+IzYJYJJvy6CfXzrrx3Dyg2lKIpWSTOHUkckqGwKE0ItUTmczKV8EZrQl1oNFSEccJqDIa2dcFseuDDSB8JCZlLj6gt8w+aYvTQfeOAUiCo0p7tfLW9HVIg6Pb4plCQuUVB2mNoLB+kHZGEK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023817; c=relaxed/simple;
	bh=+QO5fuCHnr/fPc4AyODnXGvj66246F2XCk1g3Rm1Hy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMTpJ7Wan/8hPeF3FyJynnNMcP3ajucVHDWToMWZPw8Mncggj4ZzxRyxVEef4738qF89aYmMib8k+ANgawPgnGudt+3eWq4j7Hb7HWvTYbxw5LX7+HYqHqXlASWJ4k1QKffOLG0rDOf2MmrKrY/PBjkBX1eJhxLirywcZULGsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaAILNqC; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaAILNqC"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2d6f9dddd99so21234335ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790023811; x=1790628611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I6IpwoNNaH7cJ2kkXNuM2goEpGU4JS7nUBIfFryM28s=;
        b=aaAILNqC4thu0XEgwNYoQGvh1fzBrwhztmtqZ2ocVdCbPGx6ed4axkea9QrkBH/u8N
         mnCMWl/DJsHPjbM88mxSVCs3a3YXQJnxiwnVLCVU5tG3+13THVo2dyap2+vwFSDg8pFF
         PzdTFSgJ8Mw1twux4Hg0Ssgb+zBqNJnOodlyhb6r6I3PR2rd5/peg1vOB2KtolCDvDW8
         jv/+mk0+5suzUamXbat1BaSNCfKcvpDbacU3kDgY5UGB98Erq861sOX7FqcmgjPI+i7N
         Xvh5ZeiBznFcRKWgNk3TTarZZsp1dky1sDeWqENS9cEM25SR4BgoW+o03fOOln86HbIR
         QzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790023811; x=1790628611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6IpwoNNaH7cJ2kkXNuM2goEpGU4JS7nUBIfFryM28s=;
        b=NMP8vdJNQfTdQsVsUlk1zCMQa1vD69HznzzcIjZ8xSRGNJkm13FvznemJZsOIMroWC
         rA6feeojkrN5s6A/4tNUj6/8Hno31x2tpfaSbyElxxpCV/7Af4j2J7cGD5MjzmV9P3Ib
         BybfcfKPyVr7IyXS8QHTo1PGBUtG/2nrephsD1vVNwT3SWLUcUDezubdpMDaGZcwQ9tY
         tzBvYtdHt+eA9pT8U9AEIqWHv9amYyavNdQv/ZxoLeXjuD+lSl8huvCmUD+oxn2jF+kX
         ee5ikr9DBL6pwCRpOdUY+OZqnL+n2b236YnWRJVr9BKWSViBvlEEM21hkaEVWrJ0TdfN
         0vlA==
X-Forwarded-Encrypted: i=1; AKwUvBzjs+/0LMRgRWocvsRch5uYSk6gX++aqUtLRC2VY/PS0xjT6bHNuLZ/7BEiZLZtKGJ7GoomNYU=@vger.kernel.org
X-Gm-Message-State: AFuF++khDjMiKL5YZnlUoOOIgdu5MJIKuyY9aeB/FniiCmPG3A1Td8bK
	815HvJfhwoPAJe5JoX9n8BnbBH/FyHemR2H7EVlbKyq1TLCS9viuTlnd
X-Gm-Gg: AYBFou0ltxq6yY+iL0RP5MU+63cr0x7XiZtI49LmTE4EhHdqiGLdhozbXpNbkzJZNXY
	CwxGDKG83Pf4xmHQjDikfz4rC05PpVvf5+IsV6GVfgBQmEa0cgw0WQQ0JspHSDK2545e/D26YJK
	/GMB/4ly6yw1QNzLfOgSG1LAJDF9n314YQDf8TIfK09h70fgyrklqkfX3cgRwJ962nZQK+p6fFL
	NmJlQXsiB4jODKM68n6whHYj1QqjR+DMgpGddKmQMpdQxojo81GiMF/c5aKhdbXm28IL+5Yj2PM
	1kTotf+YlLz63CYflkBnC2nUZyP0cC5wVUdEvoS433qOJYMlbtjBYrsO3D9ROapxCK3302wOHiQ
	f+TtlF4WmudxUoIt3QW2QyI268QvLeaMiiHnM1aahGf2p4GG9wf9MGd5YtEVZvqH9xinT87otPb
	OJK/8cWRSrKWt3rm7lnI/7LrHdDKR2o2BodkYr9ECsF4UA8th/Qe2YSQ3k3/F9jEA=
X-Received: by 2002:a17:903:3885:b0:2dd:ad73:c97f with SMTP id d9443c01a7336-2ddb1b86daamr169079715ad.23.1790023811040;
        Mon, 21 Sep 2026 13:50:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5b7c0cb6sm527045ad.61.2026.09.21.13.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:50:10 -0700 (PDT)
Date: Mon, 21 Sep 2026 13:48:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/7] bpf: tcp: Support
 bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.
Message-ID: <arGYI_SuoXb6urB-@devvm7509.cco0.facebook.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920195633.3033620-4-kuniyu@google.com>

On 09/20, Kuniyuki Iwashima wrote:
> When an error occurs in bpf_tcp_ops.{enqueue,dequeue}_rcvq(),
> we want to clear BPF_SOCK_OPS_RCVQ_CB_FLAG to stop invoking
> the callbacks.
> 
> In addition, bpf_sock_ops_cb_flags_set() is often used during
> setup or just after 3WHS completes to enable opt-in hooks.
> 
> Let's support bpf_sock_ops_cb_flags_set() in the following
> callbacks: connect, listen, {active,passive}_established,
> {enqueue,dequeue}_rcvq.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
