Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8238E8AD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325003; cv=none; b=dJKWUCERxDxxydR5whf11zgg1iB+X/lLxVyqwDzD1Bth0la2oACtD9j84RB6abKCqzWVETsPr7qhlo3KEIONBGigvlitr0ZBWUrRo7s6yz4oNqgWnz3Aa+2BbyGl7ksfONLy//Cp7zZqNDUxWYBwpckxDsElJHp9Wjiul0YZlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325003; c=relaxed/simple;
	bh=ZTZWSUWT+BYXcBmOwsrpIH71/aYizy2jbotgysbsn4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc23LI9KoV21p0GfgMIBqiez3O9nY82wFHmC87elGnSZVBWpudXHzCFFOu4J/Zbj8H6CmuXj1m55Res/vhUV13/bk7EKt++1TN3iFupaiNza1vofWifqVmIuCEx35vA4ktnUj41IK9qCsIntB2CmfmDIAypF8lR5ozR9F/Y9dvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo/K0cC6; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo/K0cC6"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso1167324a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791325000; x=1791929800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X1/zEEeidwmunaCjCno3SSuTgxVgDYLh+KDZF+o9+MU=;
        b=Uo/K0cC63+HPDFz03JAgLhrA/ZLHxOSF3lkKaoM2xRlCj7c6h9eYivcSmQKcRrR9FC
         l1CAF3dQCDTRN3K7iwId1UoqPTeNVS0LjKfaGPIz0yhG9Wjr/YKfnIY5tZo5y0hQ6oDI
         grm7K9jn0+L9gjHx1K5JeQCHcTdmttztvg5SRyCxpsnjaqIbNZKI4kXVuANf+cCPmXji
         QU7S+5Qc/Tz8IDQgBz7xvmw2CwkBo0UmQ5aSbHuZM14JKkWA4zQtqMYwomUZlbyfQ+ec
         D6RYwwiyxDyqUyiruIwgEfwQMq4MSG1c3yQU/L3rVV+sIchYBa0AtRAnF5kTAbyfgYhA
         9+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791325000; x=1791929800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X1/zEEeidwmunaCjCno3SSuTgxVgDYLh+KDZF+o9+MU=;
        b=nmi81fa+WPb3gHETWGLPCG4JYLiBwVXNXw29Rqbto3PRVvvB3Ahq/8VEZCc6cNAboy
         ySIcZ8nt30WDElbz5VGf4QZJYhAk9RAEMXsd44fAO/hZR0a6OHlk+TIR68/upo7qey3h
         TATIu28sp1otX4Q726Ld7hp5PgrqXsPMsOUlRZg2Hk1XzaUBZXv0rf3DlQ7RiQrxiW3o
         sFtCeVaw77wc14pS54zId/k9C7eFaWRvGRWIs5XaQdyYA/YQINetMPgsGUTAuDeEaPXo
         ccqdSCt1rHS2t5nmF8+2F24sbIIDVB+q2FzAy8OzrySt8Yqh0vYlRhSxDsSaW90GuZFv
         w8Sg==
X-Gm-Message-State: AFq9FYI5FSfT4tR44OoEr0wkO2iuuyl3KwaxXOJxEUkYBGNf6oKeYwZ0
	H5rxIx0SzRyD949xNOEirOCWBj30rUD39KqHZpQ+gkZVFjQze2ginut8
X-Gm-Gg: AYBFou2kknJeSQSxplcrziE/Z8n45mqdzXrMNzjJmJYbkEM7y5zUrKXc3Z7LUX+x08k
	lTeo4kO3Z5GeWH5O++qsiE+iQlQn7kHxg7JEVvDfz5QTGn8itsBgR2Zhc91JkLWhrYGOckc4XTd
	fZ9OJ+Jei2gvGCZY47hO2KWDa/X4d/PP0Gceb5U3vwSLappRvpwBv7jaOvxf+eqviqueSrfqDDV
	8BTIOcfPJ10NFas32NEETsUDaq/X3KQy6hnkBSLJIuaGKKG3/Deh4YEOtX7bdBnpeIw/kzUKO9n
	+XdXpt+Bk5q1JHFgmyA8k5VRGjSt8/qmMk5LHyv/pCm2l9APd9VVB2KRdZ1WOtNl8tZ3LiF8Ung
	XH9+l/8YyrEV5PwZDIq2OOQIqUpQ57nu4hqdbSveY58YHxplAN+Sb2+vraVg8kNLmt0iHC8bTzO
	XdkHblwfmBAKdihMQ1vW7C0ObqSTQgho0rW9Z9vOMnEfZajEO3O6Vbqfwiu/ld8NYaFA==
X-Received: by 2002:a17:90b:35cf:b0:3a0:f0a4:a2c7 with SMTP id 98e67ed59e1d1-3a8a072a9a7mr402497a91.20.1791324999984;
        Tue, 06 Oct 2026 15:16:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a4b1abbfsm195262a91.4.2026.10.06.15.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:16:37 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:16:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
	kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, asml.silence@gmail.com, almasrymina@google.com, 
	willemb@google.com, kaiyuanz@google.com, sdf@fomichev.me, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tcp: reject devmem tx with fastopen and repair
Message-ID: <asVygRljv-0Qw8Rg@devvm7509.cco0.facebook.com>
References: <20261005214002.3226574-1-kaifengw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005214002.3226574-1-kaifengw@google.com>

On 10/05, Kaifeng Wang wrote:
> tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
> zero-copy path is active and a valid dmabuf binding exists. However,
> subsequent branches in tcp_sendmsg_locked() can still intercept the
> message before it reaches the devmem zero-copy loop:
> 
> 1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
>    If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst with
>    NETIF_F_SG (so zc == MSG_ZEROCOPY and binding is present), but
>    tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
>    copy_page_from_iter() to byte-copy from the iterator. Since iov_base
>    represents dma-buf offsets rather than user virtual addresses, this
>    misinterprets offsets as user pointers and copies arbitrary user memory
>    into the SYN packet.
> 
> 2. TCP repair mode:
>    If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() similarly
>    calls skb_copy_datagram_from_iter(), byte-copying from the iterator.
> 
> Neither path supports or makes sense for devmem transmission. Reject devmem
> sends if Fast Open or repair mode is active.
> 
> This pre-existing issue was identified by Sashiko AI review on commit
> 125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
> hit in production.

Flagged by an AI review: we do tp->repair check before
sk_stream_wait_connect which drops/requires the socket lock. So
technically someone can setsockopt(tcp_repair) which the connection
handshake is happening. Sounds reasonable?
