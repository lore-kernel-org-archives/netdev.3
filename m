Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AF3749FB
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806841; cv=none; b=huCG2VZieZh/yzJFqfVGhbxMhlWT9iWT3rFizkyIIDVt62DoUtFI0xloyVpSCOE5SR8pjM0UWQC8+MHi51Xrqb5sbpNpzVDMPlfIgr24kXmOdBAJ97B4dLx7oQ8OGebo7134PLq5eNjQ3AqZrPYT0PPwqmmsw8ku8zqNWHYUHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806841; c=relaxed/simple;
	bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuAQV1CAwF6VYR5n73TykblGOkBo+ZQjmfL+OLq/6ddzqF39DRmnno7bdbN7oZvAhKPFFfamVh6ZQpxTJblgK533PCMSs70nKtvjNc/E4FOZqMIv/DJ0HU9dQUAiV2YiX83ImG7pm2fLpi6Yzgyf3F3/yyKmsKOqiFCf9AeDvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezU/w5EJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezU/w5EJ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36d8b644473so1020866a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806838; x=1782411638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
        b=ezU/w5EJX1t2+iEkAGIsRBUpcyThpvp81RpcvCs0PAcChHSCTl71QGadtQhPetT2Qr
         /2dBC8BLBn+xfLes0/16SeMHpuqrRXtydm+CTN8PahxcUY7HOWxR5319GTFpJ27mQaXn
         Sq5O4E1x3dsC7Yuncz+iX/YclJGWs6bTGlW48Xjcua6oJ8odELVu/RNvNxO4ToDj/d2o
         E2UWcywPsXIa6LwbfXJGaXpMSm3e+UnWN4qaXTXU8d+pYKucFglFnRuYjtNrWPorHSMw
         dlM/oD9TAR+uyQb8BjpIv9iELbvRVWJqV0yWtUEmUq0ppLw7NLRG71ZDzveQQaiheuSc
         pZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806838; x=1782411638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
        b=LAoCVOzyjZTV3gO1SRhPZGjJvezMzOlXZsKsVI8MNMdxJlb0xHYuDebG+v14V/E7UX
         PRkL20dnLaZ9vmxkuwGyE9d0cD7NSN/AFasZxvGqrLSEXEdIgpf6HBwz7vNTPq0tUYX4
         Y4HyGBFAB1l7IoZd4knClQ8t5Uk2l6VWhhNo1qLwsUXEgjo83hLwBzZCoeNLDQuO/k5W
         xfOHKyhZDkSsExD2POqR/yulVi9ydFkaUStE0yxw42LiDXDMe0+pRnEkZB0N44x5fx7c
         HBOJm1ZDPPcT/7Ths0nBRsRSvPapD6oAEXOtoqdhhmWN8l1NXIXro6Vwb8yS+4b1jO9g
         sTJg==
X-Forwarded-Encrypted: i=1; AFNElJ/jJq/qFLtsLkZtHsCTe4jPHtIv3ZAFIao1+cAxDQT071LHD90bCUxM6zID4O5nG8rutzxjl+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHi0xlr+mlHdnK2ePx1iUuqqUwEmzFmUsvbGjqHHv9uC2fv4qP
	AhOYFjzX126m1IbtBd9QrlrSnB/+xf7+zejfi4s1gJGw2Y2izc8y/FCV
X-Gm-Gg: AfdE7cmutgdS2VnlwLg/Kks7dBUjRJW6BnKI8j1RbvDuLqMTE/iEQ/s4bk1OgE9qbfL
	Z0lB2Nwn2TtDRk0fzIMUoAxwmOzcJVe5ByHhtR3mFvxjdvhK8O283qwy0AMlUu83st8ovMp+eJv
	WoVpo/k8ygxy3rerYJFmdb0VD61sJ3eIddEGkYhPlgB3hlyjtJ6fcoPD7Ip64ENrZ0bDZgWtA5k
	VeZlhq/L47SyUcQC8LhL6cXTOj3qHgwF+EB1vGMsSuSNjzq06ZBvoWyY3hpccf9WkHBDjGvNT/Z
	hHsKec4h4UmQnvWH6S6c4oKJwATOrkbWsA8nR9EKHZVdQGjLPd0hAS3ye6cdtYxSJAYXCygJk2G
	/AA6ZakWa79Nmb8SUmOaHc0fFP/imPTt9TE3CCBrBns7alBskpG9HvTO/yc94hT/BG9TlVQHVMy
	JQ75VIS7cuhQ==
X-Received: by 2002:a17:90b:3ece:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-37d15fbff00mr568255a91.3.1781806837595;
        Thu, 18 Jun 2026 11:20:37 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1558b599sm341702a91.7.2026.06.18.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:36 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:20:34 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Message-ID: <ajQ0p4ernwLzxkhu@john-p8>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>

On Wed, Jun 17, 2026 at 01:18:27PM +0200, Christian Brauner wrote:
>In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
>we added support for extended attributes for sockets. This comes in two
>flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
>are actual filesystem objects so reading xattrs must use dedicated fs
>helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
>are inherently sleeping operations. Sockfs sockets on the other hand
>don't need to use sleeping operations as the underlying data structure
>is lockless. In addition, retrieval of sockfs extended attributes often
>happens from LSM hooks that only provide struct socket and it's
>completely nonsensical to grab a reference to a file, then force a
>sleeping operation to retrieve the xattr and drop the reference. We know
>that the sockfs file cannot go away while the LSM hook runs.

[...]

>
>Link: https://github.com/systemd/systemd/pull/40559 [1]
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---

Nice this will simplify some of our socket tracking.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
