Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4C3C0611;
	Thu, 27 Aug 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837751; cv=none; b=NNE2HGuOXKWVWl7YxOHMmi9guWoaST/WZuQUxb+hrqGJEmYZYjM6VUNa2VY1IyMWTDngoZ0rcL6exBPUs4smuTncUqqRI2LyN/O81ZLtz5uVKOxdC4JRnv1ryp41F22NEPzUI6wxBgJEamfjJfykJ3u0jcol7gcot3uCNlJ4Uso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837751; c=relaxed/simple;
	bh=lJFHIZmRzjPci7SC9r2SODugxdUuauevOwsgBSWUULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH+oFP87ZIA/muQSwZAv89ar+KPcXzr3XKZjsW7Sx9emjkdbdgucyeWXvHxqtsT/GCN5xR0cpMaU9Z50TKWpKkdv2N6MBjzdELWzIX04Wa6G7ffAKD/fZ4AO5Ow1yEFzn6tGz+RqZ+R8M40Zjx/KfXNkKLIbvjN96i+qT6VsnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=mr+M29Fg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mr+M29Fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D3E1F00ACA;
	Thu, 27 Aug 2026 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1787837739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuRBr7NNsy1QcjiJOCE3QJ91c/zgrK86l/zJYhNe9Sg=;
	b=mr+M29FgzvxVykz3RmfI15QjTH+ctTJTkVyxyzBHjuGH3Fw6BG5o+/Cwc//j7NDkQPDItw
	HuJzfEpcz3cibyvNX5pbvdxo8MK4mv4b4KfNUU4J7Vvl3k08X97M+Ys9SMzVE/zoUDbdPr
	KjsvHJU1IgHPXiElHRu4GbjOFjJKqdE=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 65acf2cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Aug 2026 13:35:39 +0000 (UTC)
Date: Thu, 27 Aug 2026 15:35:33 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: ramses@well-founded.dev
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <kafai@fb.com>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] wireguard: queueing: preserve tstamp_type in
 wg_reset_packet()
Message-ID: <apA9JU3TAXdSNYJi@zx2c4.com>
References: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev>

On Thu, Aug 27, 2026 at 01:52:56PM +0200, Ramses de Norre via B4 Relay wrote:
> From: Ramses de Norre <ramses@well-founded.dev>
> 
> Sending traffic through a wireguard tunnel on a host using the fq
> qdisc fills the log with:
> 
>   fq: likely mono tstamp with tstamp_type 0
> 
> An skb carries a timestamp in skb->tstamp and, separately, a
> skb->tstamp_type field recording which clock that timestamp came from.
> The two have to agree.
> 
> When wireguard encapsulates a packet it calls wg_reset_packet(), which
> clears the fields that must not leak from the inner packet into the
> tunnel packet. It does so in two steps:
> 
>   skb_scrub_packet(skb, true);
>   memset(&skb->headers, 0, sizeof(skb->headers));
> 
> skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
> monotonic timestamp: that value is the time the packet is scheduled to
> be sent, and the qdisc still needs it. The memset then zeroes
> skb->tstamp_type, because that field sits inside the headers group
> while skb->tstamp does not. The packet therefore leaves wireguard
> carrying a monotonic timestamp labelled as a realtime one.
> 
> Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
> skb->tstamp if not monotonic"): fq used to assume every timestamp was
> monotonic. It now consults tstamp_type, spots the mismatch, warns, and
> falls back to treating the value as monotonic. Pacing still ends up
> correct, so the log spam is the actual problem.
> 
> Save tstamp_type before the memset and restore it when encapsulating,
> next to the hash fields that are already carried over this way. When
> decapsulating it stays zeroed, which is right: an incoming packet's
> timestamp is a realtime receive timestamp.
> 
> Fixes: de799101519a ("net: Add skb_clear_tstamp() to keep the mono delivery_time")
> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
> ---
>  drivers/net/wireguard/queueing.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> index 79b6d70de236b..663b19b783953 100644
> --- a/drivers/net/wireguard/queueing.h
> +++ b/drivers/net/wireguard/queueing.h
> @@ -78,12 +78,14 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
>  	u8 l4_hash = skb->l4_hash;
>  	u8 sw_hash = skb->sw_hash;
>  	u32 hash = skb->hash;
> +	u8 tstamp_type = skb->tstamp_type;
>  	skb_scrub_packet(skb, true);
>  	memset(&skb->headers, 0, sizeof(skb->headers));
>  	if (encapsulating) {
>  		skb->l4_hash = l4_hash;
>  		skb->sw_hash = sw_hash;
>  		skb->hash = hash;
> +		skb->tstamp_type = tstamp_type;
>  	}
>  	skb->queue_mapping = 0;
>  	skb->nohdr = 0;

Seems reasonable to me. I'll put this through the paces testing and
queue it up when I'm back at my laptop on Monday.

Jason
