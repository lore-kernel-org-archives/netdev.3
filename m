Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683707;
	b=TUm06tMU7p/YA6f+68eHvyK4myWHvx1ZILvgStaHx7VDe/bkSG9Ews7jeaXKyFH8StEF
	 JP3fx0wh0hU2H0X8HjT9Ov86Rr0ZSApLIlIGjMf3Dq8DhGVyMLc59z794RlV9hOctYZmX
	 mTRWD+GbJTnnt+vSa7REoGU8gspejirZW/2QjVb26knhZdDFw6PV6mLmEq3/hDGZi7W3F
	 qFnyXW8CDAhFfOEMx49rNnILnw67TbzqColWPum/8EEZwEEtSjLUhusoyLxr14M18S49j
	 ajAy2M+uSKpjc27ISrSmWXYYKfREriPubt6mJUJZM2jtkFY3TjOOwz9f+bk1WlWs5FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aMipWiH6il94+oUwDW54rQDx5szuOcXlyk5T4hyKyg4=;
	b=hcAz4dC7yRPamr/PK/M+SNbolkJRl0H0IVZh8uW8lMnvHNeSh3wKIn1v1Z3a3mQb4xGm
	 sxX/aejUHmlptg9sK1Qh2KggIAcO8RlBiJ1jOhGyrwGS8byULl5Fzy9w0RHJSki/HLmNn
	 +IDvCSLRFGuDWg+GPUCelNxZQ0Fj4YjPSl9WzmAWcrm0UWORksypeUDGF1hvxKgMWXlXv
	 jGqGbtwJEo30bNSXx3qziRQTblky1ZDmr1tHiYelSvMGZ5ICW+/tnfVyOl40/CWRqodBe
	 Csu1Okz/TfOyvipyGI2vP07tn7L1800wHhOd/i2dvA10kl9Els2s9+EiVphbWESRc4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D67W3iim;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAB606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5DAB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D67W3iim
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so3559887a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 21:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793683706; x=1794288506; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMipWiH6il94+oUwDW54rQDx5szuOcXlyk5T4hyKyg4=;
        b=D67W3iimOk/17qGhxaN/Eawx3Q2tNpJFK0LUWfdETtro3W5sr5EGCkDtygYnrx3UvE
         PtO/AIFMUKKybxavy0wGnv3amrfM6FJIKFNt14XbVqG0vopML4NPoL4HXIaCQW8Wo25E
         m2r85wLt0I2rv+glgxFJsvLAtqMWBPZm278yijwrr8OG4wgS5Pk5vLexAebxkOOIkd+L
         j1PGpV1WORgkgY/3DRz+2HvMER6SxBjqqsYdj2xoJJ5Str90PpCGDgAspN7XxAxO4Rwk
         B5ZNQ8zEg8uFh14BuOQ693MX1cwsra3iI5VUMDItTILNsN1s9vRhRN9gUHrngxfZ4+SC
         nAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683706; x=1794288506;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMipWiH6il94+oUwDW54rQDx5szuOcXlyk5T4hyKyg4=;
        b=g08lW8A8OCCyrF+rceCaYuTlcraakh2HbJ8pP18cZ0tDQvZJzkFk3WVzYE6GFlv+Y6
         PGQ++8ac9VdeTNVNXhf9Lc6WJW2YaFCr4FnN6DM639w/IhWKP8ZIAtMSe8rgyjJDROw6
         cC7HZ2iolr/aFXSCpkM8EXWwI3EauypMmVY/XBOXbqu0YKa9wkkOQSK6whpQ8Xf+a9jH
         PhMo7v5i/TTuJGK/wGEb2fLkM5yB/zd+ClKp+R3n5G6PbCjFH6k1ZAIgulDfTQahx5vj
         hQBLqAmIV12x0rsvU+gBWJbw30JGc8yBdIipFNUvDkpnqCeoa+7riyE3MRa756NsQn4b
         hthw==
X-Gm-Message-State: APuU4Z+wl9/yWO5IZP8wr4ylR2Q9T1oJDM3+atbYQgPrCTeAKSn1wyxn
	ktTyTsukeYBSbUnFxof7vfi1PPlLt5XJGWlvEnqyHP0tQ2+9b403jPvk3mAwqyIO/gbCTtCsfQB
	qfZBV8Q==
X-Received: from pjbpj10.prod.google.com ([2002:a17:90b:4f4a:b0:3ad:6c5f:feb0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d83:b0:3ad:85fd:711c
 with SMTP id 98e67ed59e1d1-3ae89736495mr10727525a91.28.1793683705855; Mon, 02
 Nov 2026 21:28:25 -0800 (PST)
Date: Tue, 3 Nov 2026 05:28:25 +0000
In-Reply-To: <20261101061331.286404-3-jiayuan.chen@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101061331.286404-1-jiayuan.chen@linux.dev> <20261101061331.286404-3-jiayuan.chen@linux.dev>
Message-ID: <aulw7Bfq65l738px@google.com>
Subject: Re: [PATCH net v3 2/5] ipv4: fix shift-out-of-bounds in ip_rt_send_redirect()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Fernando Fernandez Mancera <fmancera@suse.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Willem de Bruijn <willemb@google.com>, 
	Maoyi Xie <maoyi.xie@ntu.edu.sg>, Jiri Wiesner <jwiesner@suse.de>, 
	Zhan Xusheng <zhanxusheng1024@gmail.com>, Gerd Rausch <gerd.rausch@oracle.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, 01 Nov 2026 14:12:00 +0800, Jiayuan Chen wrote:
> ip_rt_redirect_number is the max number of ICMP Redirects we send to one
> endpoint; once we hit it we stop. Before that, ip_rt_redirect_load gives
> the redirects an exponential backoff:
> 
> 	if (peer->n_redirects == 0 ||
> 	    time_after(jiffies,
> 		       (peer->rate_last +
> 			(ip_rt_redirect_load << peer->n_redirects)))) {
> 
> n_redirects grows until it reaches ip_rt_redirect_number, and both
> redirect_number and redirect_load are plain proc_dointvec sysctls with
> no upper bound. Set redirect_number past 32 and n_redirects climbs past
> 31, so "ip_rt_redirect_load << peer->n_redirects" shifts a 32-bit int by
> >= 32 bits, which is UB:
> 
>   UBSAN: shift-out-of-bounds in net/ipv4/route.c:949:6
>   shift exponent 32 is too large for 32-bit type 'int'
>   CPU: 1 UID: 0 PID: 1845 Comm: ping Not tainted 7.3.0-rc7+ #364 PREEMPT
>   Call Trace:
>    <IRQ>
>    dump_stack_lvl+0xc1/0xf0
>    dump_stack+0x10/0x20
>    __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>    ip_rt_send_redirect.cold+0x2c/0x146
>    ip_forward+0x1ddc/0x2430
>    ip_rcv+0x2b1/0x320
>    __netif_receive_skb_one_core+0x16b/0x1c0
>    __netif_receive_skb+0x21/0x150
>    process_backlog+0x37e/0x1200
>    __napi_poll.constprop.0+0xa5/0x5e0
>    net_rx_action+0x4c0/0xf70
> 
> Bounding redirect_number instead is not an option: 0 disables redirects
> and -1 removes the cap. Compute the backoff in u64 with the shift count
> capped at 31, which cannot overflow once ip_rt_redirect_load is
> non-negative, and clamp the result to MAX_JIFFY_OFFSET: on 32-bit a
> backoff of 2^31 or more is read by time_after() as already expired. This
> keeps redirect_number as the limit on how many ICMP redirects are sent,
> and the shift can no longer go out of bounds.
> 
> redirect_load on the other hand gets a lower bound of 0. A negative
> backoff never meant anything, the old code only happened to treat it as
> no backoff, and once converted to u64 it would turn into the maximum
> backoff instead.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
