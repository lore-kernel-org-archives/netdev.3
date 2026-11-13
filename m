Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601340;
	b=F9U5ehsV7U/rCtll3VSI1GicsZ3KIPZtQb8f7qR+fZhfVIGrYPG6c3mwY7HGaUWcRlMW
	 WY+Wh0Bq3WMG1LAp/EJtp5UQZj0kbOCdpyYURkKUZC0jVqd4iu0sK1y6gXz6+wFnwQ/It
	 Y8BvWmrx9j90qZkLxodIiWQZAXvB23vsTW58NrODBpxXFYJAlmb29TmRP1NYtRn65acGb
	 3DTS0x8LeFfNSTx9fn18AOh9bud+H55VbffUa2GlvmeXbDGCqgAu0uHwBQa7X8/9UW+Le
	 J7LMg7UmjHEN8Luak05AmyIK6PumG1Pgab9WPupPbulNZvUKMmYmXYQTR61ca+b56SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HopEjVcKVy5WlPlbnxrcDQWkWX0L0xT3AvRN619hsz4=;
	b=n4ZCpcnC++ZRz9/sILeQLPa+a9GrIS7fVjmxB3z9VtPbkzmO1q4vjvi4nl66ktRzn/64
	 rSKHAUvP7DP+blPNuqHwN5rV0lk27SKknAwwJPTwn7SP3WP7DtB5wG0MJY/2VagUJvWtN
	 gy1v77pC6K107L3qs8vDzfiu/k8p6KurdW+eNAZdKcbTLA/76w7DTW1Mc3eN39Xgjx13G
	 ltPvDF2Mt8SRZkvkUXZhLWsYp1f9gHPPDmswCLq/ka8YKFqDG+SWkoDbxComq7H7qj1X8
	 8lSVVvShsTlaF2XHHhEavUdNBwUXGjKAll3Nx+OhLFhkozYMQ7ova+XqruX2SMTLPJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpB7fYZ5;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CA606A880
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C9CA606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpB7fYZ5
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso450210c88.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601339; x=1795206139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HopEjVcKVy5WlPlbnxrcDQWkWX0L0xT3AvRN619hsz4=;
        b=OpB7fYZ5oudIYsb91KeZQgQ1i2+Yz+pWWPbfqpFJ0c/wuhFClNklZv6sc4wpmQeaDl
         mUOsbOVX7fX4RiViMDJs2bAsdSH/f7cYI4vJPbL3GaFQcLDk2FVjwuZryQqyXIUMjYIc
         cq8hIvkyFTHYgr64EYJprVhlJq+G0bix/FOaebLcvIFybOfqUcuDl9cx3LTbKx6THvar
         0Sgko3b/NsmmejwxUdRbl7fx9witxeyO2B3kJMMwS2bWhIRQFd5P0Z5zAK4L+w0MZ7Nh
         IqN2OxnSyPaddB0xEhdEs0rSnMF0M6WyShKcYcMK8UgAo/+ut4VgCMY/0f6ljygrmQdK
         5qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601339; x=1795206139;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HopEjVcKVy5WlPlbnxrcDQWkWX0L0xT3AvRN619hsz4=;
        b=txcoWr3GIppbmD2DWWmM/upByMGusNuHq3UieADh4FAPNDHHAxI1ISmHhd+ocvE92A
         W+3C7EQPk53UmSDFSc/HTEGQRsGJ8TrRUYRJ5DvGbyO1LACvdxjuO1L1SKgKH+obhpZw
         ewOEvc/17OnY8VpvXun4G8oX/jzQWAYHYkFyuo2wykswrQtOz/EfZLsJFap9jAeRdPZ7
         kNYstbgHy881GL2CwELZv3Dj8Ia9+vh8ylQ1/rHoqviUFiokYbw6NWoO8HnJPJte9uFw
         N0agpn7iYTFgjOuoS/7AcMNSM8Z2JXZ/nNfFZgkJcVmKYxb3IoryEfiD+Dq7lkihvi1T
         rMkg==
X-Forwarded-Encrypted: i=1; AL+hErHkcLJBe6XdpqA3bYIJuNBhPzpEVhxuxV3Lw/r0fmgB6+Jpanc4YzNhdpBwf0q+d8Fi4poShKQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BBXb+ut3Ma56xrpO00aT8cYBb138dw8sUwhWOqcfwJg5NiXwB
	MNLmi9yPAsm/ml5hjWGxXSwGjyPjsAPTVQFbPK0K6gF88czBc8TchBnZ
X-Gm-Gg: AYBFou2piNQZBD280xhgj52BgZ2bYhO6dang/nxInSMzSXj7c2n1I1kTxXq9fVBgm1v
	g+GuV3H9EAz8UYVSgD4SKCGp1pTcHOX1QOgGueBrRGMslxOmmbfNlKdlmR7Wc/Msi2L/kFNR6iX
	Ws2XZd0MYCyDFg+MVSb+MW9WrKHf9iHHQxuM6ZyCs4dNAxGkmNR8xyh+gQRLEUL51j3brOuVlO1
	8prZB1lnymdkrH68x2G+5ixszz33+Wwy6YuYM7gUcwXA2QzCFVqTDWM9je33pZuKBlR50cUvnuc
	uO6SjsTybY+x6JZY9IQ6jfYwWppJUlapKJ8qaGp0gwmsfNYdlot2JkknKeH3B3/mJ572QSTkF06
	GH8Kq50NBDa+LRWqb7pofCX+GLMNyiZnEHaj/IMtoADI8JaKI9VfccY2ZJTYFP+CK0RDuS3+p8P
	gMCxP4X4jR6T+GM5tzcR+A1T3raTMIlIjks9SGkzcYUAwiOduhtfkRLNi+fYbyQof4iOQIr6CtV
	TQ7mMxCgshkrs/ugIGnQ1UDsXxpMbCcIIGqG53cEWg2mwq29dxphL+6vOnroay/JlD8yDcWd4TH
	TWyuj8xe4bmiHz5u10IL6pM=
X-Received: by 2002:a05:701b:4587:b0:1b2:6844:25c9 with SMTP id a92af1059eb24-1b5030613dbmr3036601c88.3.1794601338374;
        Fri, 13 Nov 2026 12:22:18 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm11098622c88.8.2026.11.13.12.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:22:18 -0800 (PST)
Date: Fri, 13 Nov 2026 12:21:59 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] tcp: convert do_tcp_getsockopt() to
 sockopt_t
Message-ID: <avdxYs47SOZHDU-D@devvm16445.scu0.facebook.com>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>

On 11/12, Breno Leitao wrote:
> Convert the SOL_TCP switch to sockopt_t. The TCP-AO helpers already
> take one, so they get it directly and the tcp_ao_get_sockptr() bridge
> goes away.
> 
> The options that re-read optlen to get past the sizeof(int) clamp at
> the top take it from sopt->optlen instead, so optlen is read once.
> 
> Only a user buffer reaches TCP_ZEROCOPY_RECEIVE: BPF's sol_tcp_sockopt()
> does not take it, and it maps pages into the caller's mm anyway. It
> keeps checking the bytes past its struct with check_zeroed_user(), now
> on iter_in.ubuf, and a kernel buffer gets -EINVAL.
> 
> tcp_getsockopt() builds the sockopt_t with sockopt_init_user() once the
> level is known to be SOL_TCP, and writes optlen back unconditionally,
> because TCP_SAVED_SYN reports the length it needs and then fails with
> -EINVAL. This mirrors ip_getsockopt().
> 
> Every SOL_TCP getsockopt() now writes optlen, including the ones that
> did not before, such as TCP_REPAIR_WINDOW, TCP_ZEROCOPY_RECEIVE and the
> error returns. An unwritable optlen word therefore turns them into
> -EFAULT.
> 
> The others stored optlen before optval, so an unwritable optlen word
> stopped optval from being written. Now optval is written first.
> 
> sol_tcp_sockopt() and sol_tcp_sockopt_congestion() reach
> do_tcp_getsockopt() through sol_tcp_getsockopt(), which builds the
> sockopt_t with sockptr_to_sockopt() and stores optlen back, as
> sol_ip_sockopt() does.
> 
> copy_to_iter() runs the hardened usercopy check on its source, which
> copy_to_sockptr() skips for a kernel buffer. BPF programs call
> bpf_getsockopt() from the receive softirq too. On the vmapped IRQ
> stack, the check then takes the lock in find_vmap_area(), which is not
> softirq safe, and lockdep reports an inconsistent lock state.
> 
> sol_tcp_getsockopt() therefore calls do_tcp_getsockopt() with page
> faults disabled, which makes check_heap_object() skip that lookup.
> Commit d319f344561d ("mm: Fix copy_from_user_nofault().") added that
> guard for BPF and kprobes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
