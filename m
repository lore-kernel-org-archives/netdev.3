Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711F2D7DC8
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811533; cv=none; b=I7vtotOWnn90tTMiq6y3TJHaKNpiHM1QVbGfkT+lWqC+E5/HV7Xz3DSlz3lSpFe2GBFWkSh9CL148E/n32SHYN+jJRUh9kwO7rJu1X752/fVOEY3jbHz9v3to+p8TpkGQ02QtvUPG10LljGgGIw1vYVgVUqH6oXeHejCAOrJKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811533; c=relaxed/simple;
	bh=HrmalTditcZrNiZ8v+KCnPbL2RJYFiSY6wNR9nLzrkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj4qb1b2z/mwMuTv+rVbAtWjir68tL3FAY21lw4VcYKKzGK9LD5JiVncx5pbCqso7xeCL29no09is4VeZzLVUdGEFolPHwivuwY6yIyldVlw9mnsJfV4oaYRz90Fl0La5o+50pEYSxU9Z4/2AylHFoRD/04GyZCqZ6k0R8K3WDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLFv9emJ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLFv9emJ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15756f82e8aso3285778c88.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811531; x=1792416331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HrmalTditcZrNiZ8v+KCnPbL2RJYFiSY6wNR9nLzrkA=;
        b=YLFv9emJB9g8hZdI20OIuKfAu1Y4EUn+7wquHT/JbbB00a+XvWY47ir1lU1dWxgmat
         SqTDmf0DVsf5s4Hv8cX71jqsWVsVuvFDrAVrt3T/PNx0GRcAvHKYQLU+NyomiPgBrqe3
         mgKwYD3831a69YK4xWZqGthg3OM8RoYYgevZI1sVe0tQsNG3zCfQ6+ZZgD195+gzS5Vx
         DsPQjwFuerKzFLx1wdiOyFlk1g1bC5PLFBJMZ3LaArz+60hxlRr/KExlrI/Yk6TrAAZB
         VFwPa4dFRjgKDEmrgAE5C4xhTpFqmAWBtW/XFNB+zK2hw5ngwtFCp+Jcgx3emJjKxN7G
         qp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811531; x=1792416331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HrmalTditcZrNiZ8v+KCnPbL2RJYFiSY6wNR9nLzrkA=;
        b=26iWU9sbfQfc9+ZkGf5ewkkihpjxq0KsUZMbs7oLtGhS/zHN3iodELSPQ9BnVmUX5r
         trUjrLm/q7wSljfnHDGYUspwPhybFhBTCBzf99kb2Klzbl93Z7BfqK9+tBBcwKQGpCZu
         6aloQ/VWzrYJ6yT/2d/9ubmzA7r4LfWxvjZEUXf9H76lhzXV8RUkYgE7w3qAengv7/lI
         xmn1pFFCToQOD59R4CfxjLWLsdlNtxxYb6PrefgwodO/X0VQ0p3Wc1feKeyOvMR1gn+Q
         KsuGpLUyCQCaUlSF1dAXq9reAjReYxVh6OC/Owg0JQ8ci5nViDGhKfCeWNAsa3FpaF8p
         c8Rw==
X-Forwarded-Encrypted: i=1; AKwUvBys6cBdcJRQCHA4qETUrn/tBYBJIWCQ3N9d8FERu46eXJV96ZlXTb30t/D/Pm0VZdWzK22nUNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUMfx53GzzjFGgDFrGdDCfW6yEEkxpIrXHgVdPp6a/KlTJvuuR
	wcOxCzMrVce/jMFgaPCsByA3ekz+iixjTwWUntki3WymxrQ1lDunkVtY
X-Gm-Gg: AYBFou25S0/KTFQRK7qNplV0hEDnWVX3Y31+1hXOKC5+it9FHG+PJ7JtJ1x6F7JI3VF
	pIeCOOYPx6gZv/K8TfV4V8fPtk4hEm6ndUydW4/ngxaMAamXpruAnC9bonVsip4xDDBoadE8/J7
	W1u7frfu4ncRzfrA46TBCVpA4GKMLr006XY7EWR0auJArCuuiw2Hz/vccOJhGz3VVCScAF4RINg
	a1khP83Pe8B+IPFnYsgINVnxqhwmbfNN8J/YL14XbLPpeWo99SU7WiM93bIwIpHnVGaU50/vUUC
	gF0aVRMDNU8BwXrU/txb7/ZZB+f10DR3Tp2abibze7NUeekNWBtWfsmkSRGfgLQaNRn+ix9a0RJ
	jcorRKZUpA99gPsTdcWo/DeOAxLXKMjgU9Fsb1OSj3JnMDW2JcfaOwtlxdatnbuChLo0c7+Eehn
	ddJOVTZAkYhiDd8gFKu+xaRMQgiyxhhzV3jgED5sxpKYn/pt45SBP9BCLKlTDzlGPTbqoFeTBKg
	NlCbL5QhnTfJzn11NnBy2RIfw0z2i57+ftzbpnFnyksRD8Z1POYkT4naUDokX+r0J1lQlYxzjw4
	qigXOtDPo3lYYekHgAPJW+7wXbIYojCIusyIQ88GiE/FSFxWjgpcv/WGBhcQbG72WbUz3Bc8kQU
	qPygygcg6GxU61t85fYEFSoQ+s5/xuQrYn+Hv+3Xs99DWs+4Gex1K1A==
X-Received: by 2002:a05:7022:5f1b:b0:16e:a290:12bc with SMTP id a92af1059eb24-16ea2b0303emr6974568c88.12.1791811530714;
        Mon, 12 Oct 2026 06:25:30 -0700 (PDT)
Received: from FT6N242TWK ([223.181.117.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a620bdafsm39584553c88.23.2026.10.12.06.25.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 06:25:30 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] tcp: don't set window_clamp from SO_RCVBUF before the socket is connected
Date: Mon, 12 Oct 2026 18:55:23 +0530
Message-ID: <20261012132523.48360-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179180390054.434549.3187163637190599944@kernel.org>
References: <179180390054.434549.3187163637190599944@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 12, 2026, netdev-bot+sashiko@kernel.org wrote:
> [High] Does this check cover every case where SO_RCVBUF is applied
> before tcp_connect_init() runs?

You are right, it does not. The socket is already in TCP_SYN_SENT before
tcp_connect_init() runs, so SO_RCVBUF applied in that gap - via
TCP_FASTOPEN_CONNECT before the first write, or via bpf_setsockopt() in a
BPF_SOCK_OPS_TCP_CONNECT_CB program (as samples/bpf/tcp_clamp_kern.c and
friends do) - still writes window_clamp and still overrides the route
metric, and a state-based check cannot tell that SYN_SENT apart from a
post-init one. v3 will instead distinguish a user TCP_WINDOW_CLAMP from an
sk_rcvbuf-derived clamp, so tcp_connect_init() and tcp_openreq_init_rwin()
apply the route metric whenever the clamp was not set via
TCP_WINDOW_CLAMP; the selftest will cover the fastopen and sock_ops paths.

> [Medium] Is the part about the case without a route metric accurate?

No, you are correct. With no RTAX_WINDOW metric both the old and the
patched kernel end at tcp_full_space() - the old kernel through the
"window_clamp > tcp_full_space()" branch, the patched one through
"window_clamp == 0" - so the advertised window and wscale are identical
and derived from sk_rcvbuf, not from the defaults; the patch changes
nothing there. The real impact is only (1) routes with an RTAX_WINDOW
metric and (2) a TCP_WINDOW_CLAMP that a later SO_RCVBUF on an unconnected
socket or listener overwrites. v3's changelog will say exactly that and
drop the "any application" / "without a metric" claims.

pw-bot: cr

Thanks for the careful review.
Shashank
