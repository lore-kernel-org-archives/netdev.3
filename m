Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793590374;
	b=oEPZDo2huV3cczGTzt59GEzs4Fn5iPCGzMdWZ7rX/HfznZ/iX3bVlxNlUhfUlQoK+87R
	 cm45WRKZ6x7xBeTKkbdiT2Ytat+CWCKpWZAQIZocgZHgZK5Agfovw8TjJ3azF61wf110g
	 uwsoGM6usvc98utTCk9evvZHxL2mwozTWaq9otl8otaCPh7CUj99hiSmIfeaPCZ/gklrr
	 9XcApdpPOg8Uv9Ap399xK2pIROvhjgm53PqFZ1OP6hI3DVcDIK5bpOhQHeZf5CwJ9Cqgj
	 ZhvdK7eGoDWR9ojCmf6Mzvmsy3eQuwHArGfkhM+3KQqzF3RdhriSi6NipFesoC1CZWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590374;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=m/8uEgVZBiGs6GhX+EaixTcEV6WwGEnxdOq6kuEraE8=;
	b=OYcj5zLK6MclovDMnffhUP2wyU/ujZH5ZknusmamqkSrp8tf8Vf68TVMAkO6Pu2+9VpX
	 LI4MVThgSQAwHi76kkcxJ2FSX/MYWeR5wfeEOgdqU6XRpOZPobhV7w4OzQ+5rh5qKj/Pq
	 /rJqhxzOPZu3wbTVtI0hPtEBcwx6xj1kYZ64G/DhSqcebYLzyNdt4kO+fZe3pLLJI0yki
	 iE77U9vAU2PV+z2XFSn89HkIXnsrOkwjSGCeckUwgEZCVRzUt5RHL46Bz19eYCmPBJpr/
	 wn/awscF9Z8hBii3e8PGmVcQlcryASMrvVQW+ysKRWIi8DM6alY/vejUN7HHKMi8BPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jinjzi6X;
	arc=none smtp.remote-ip=95.215.58.31
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1657606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1657606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jinjzi6X
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nNlyAiB0N622Wf4HwaxQyqQjcvp12NITnvjasTRHZ0c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793590371; v=1; x=1794195171;
 b=Jinjzi6X+J/HEXZSr2S+tfp0I3z7ZtTGk63EFv26nAh/wxu4Ml3RUoctD3BqbkkXroDZX9Sl
 IpnB5Vh7Ls+8sN32Me8WAELsWI5QMsIFLmsVA2NkTPEfHw3IhwLqvWnQ4ggfYQ7+xlsXWnThMvR
 7dbldQzEJsaPqxRyIr3Y6Pi4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d0263b54e1afad11;
	Mon, 02 Nov 2026 03:32:51 +0000
X-Mizu-Trace-ID: d0263b54e1afad11
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 11:32:36 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 5/5] net: restrict message_cost and message_burst
 to non-negative values
Message-ID: <augEVIHANesq7xkO@fedora>
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
 <20261101061331.286404-6-jiayuan.chen@linux.dev>
 <auftqzpuuNFiScrb@fedora>
 <2fd1dc53-ae46-4163-90a4-f916c9dce29b@linux.dev>
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
In-Reply-To: <2fd1dc53-ae46-4163-90a4-f916c9dce29b@linux.dev>

Hi Jiayuan,
On Mon, Nov 02, 2026 at 10:23:30AM +0800, Jiayuan Chen wrote:
> 
> On 11/2/26 9:55 AM, Hangbin Liu wrote:
> > Hi Jiayuan,
> > On Sun, Nov 01, 2026 at 02:12:03PM +0800, Jiayuan Chen wrote:
> >> net.core.message_cost and net.core.message_burst feed the interval and
> >> burst of net_ratelimit_state, but neither rejects negative values:
> >> message_burst uses plain proc_dointvec, and message_cost uses
> >> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
> >>
> >> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
> >> negative"), ___ratelimit() splats on such values, so the next
> >> net_ratelimit() caller warns, e.g. a martian source log:
> >>
> >>   Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
> >>   WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
> >>   RIP: 0010:___ratelimit+0x578/0x960
> >>   Call Trace:
> >>    <IRQ>
> >>    net_ratelimit+0x1c/0x30
> >>    ip_handle_martian_source+0x1bb/0x340
> >>    ip_route_input_slow+0x1057/0x3650
> >>    ip_route_input_noref+0x104/0x260
> >>    arp_process+0x109b/0x2510
> >>    arp_rcv+0x381/0x460
> >>    __netif_receive_skb_one_core+0x173/0x1c0
> >>    __netif_receive_skb+0x21/0x150
> >>    process_backlog+0x37e/0x1200
> >>    __napi_poll.constprop.0+0xa5/0x5e0
> >>    net_rx_action+0x4c0/0xf70
> >>    handle_softirqs+0x204/0x9b0
> >>    __do_softirq+0x10/0x18
> >>    do_softirq.part.0+0x49/0xd0
> >>    </IRQ>
> >>
> >> Negative values never meant anything here: 0 already expresses both
> >> "no limit" (interval) and "suppress everything" (burst).
> > Will this limit breaks the UAPI on old kernels that supports negative values?
> 
> All commits in this series restrict config values, and every one of them
> changes the old behavior to some degree; the question is whether the

The other patches fix shift-out-of-bounds or incorrect behaviors.
> 
> change is reasonable.
> 
> 
> For this one, negative values never did anything that 0 doesn't, and
> since a940d145cc38 setting one already triggers the WARN_ONCE().

While this one doesn't improve anything other than the WARN_ONCE.
The previous kernel works good with negative values.

> 
> 
> > As the comment in ___ratelimit() says:
> >
> >         /*
> >          * Zero interval says never limit, otherwise, non-positive burst
> >          * says always limit.
> >          */
> >
> > If all others agree to set the limit in this patch. I think the comment
> 
> 
> The comment and the WARN_ONCE() are about ratelimit_state in general, not
> net only. There are still other ways to set a negative value,
> printk_ratelimit for example, so updating them is not this net patch's
> job.

printk_ratelimit is not recommend anymore.

/*
 * Please don't use printk_ratelimit(), because it shares ratelimiting state
 * with all other unrelated printk_ratelimit() callsites.  Instead use
 * printk_ratelimited() or plain old __ratelimit().
 */
extern int __printk_ratelimit(const char *func);
#define printk_ratelimit() __printk_ratelimit(__func__)

> 
> > and the WARN_ONCE() , and the admin-guide/sysctl/net.rst all need to be updated.
> 
> 
> 
> net.rst never documented a range or even the unit for these two, which is
> why I didn't touch it. No strong preference though.

I think a doc need to be updated if you set a range limit.

Thanks
Hangbin
