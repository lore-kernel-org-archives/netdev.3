Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295564;
	b=FSnho97UMmmeKTo3tncWYYMQki/+EIaJ8XjBMyYUbWeZvl1ayxseOafYtSxoCrpsbZeG
	 CukHlETAlb2BggnZn+vCLSljwEryxCs0geseqWyJ1kAuw/vNvoitt0itGCJIw+2KEddy6
	 zMIxqDYZxzm2KIFRhvtZObEQ3ge1/y7kJZUnBhwlVRiVdozl5Vuk61QgC5PjHHRmd0qTr
	 1NAbCRCW/+qbVEbxAzuVNn1I6+NchD76fWwdT0YyrR1ujTSVckyxAsQK6l2ht5eJhSf/H
	 TcbHvMQosWVj9onullBDtPw+kSEbT9tGu666mcG9pPvf6xTN07vEpqufhRjfxl8wlKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295564;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aT8+tDcFqR2grJlSVWzWUtCzKjv6fftf0ezYMjAx/94=;
	b=xeUWj5/7hQJ74YYiTij3TLfbcI85YdeK9DmDTvNAOolyl/rvTniDrvvMSDf1hZAvb63D
	 jvmUrEluCjB6xwSF+bBAheno/poC6/dEZTiawBwpyqIMQiUB4VitxUxTMAOecd5aJUoGH
	 NEYPiA2qAVyilSesIvsz/AfritgPMh+YoNZav/YVqC1gpBYsPN2XR5D8XTJ5370skyExL
	 gUJFgLFD+6qzg2tGyv2X2yNzrz5PkoYIq7aiHkq5qu40W2nyAcvj396bxf91K3H99fVXx
	 bf2DgTlrwZ2bw04GBF1RaInzQH2s5YhsNMR0Ukb8ohisdHB/hvrfpy5ByRoherbeTew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TD1V5XV3;
	arc=none smtp.remote-ip=95.215.58.238
Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B9606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 498B9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TD1V5XV3
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NGP5NSQ1l+1OBRJX/cyPTA+lt5a7xUc8WPRfGUDUNJU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794295560; v=1; x=1794900360;
 b=TD1V5XV3eq4O0hRzN8leEuT7sGyWsn7Q/7JH2mAyXiKbbhswqFrrlhAQuB42CMdvAQSvPh+2
 K8GC3lnh/hrumeMLGnvz48vgpW79evasyrC6G03WLI/sVRjMD+vlqwFHb9xuX2Q8NVJGHqjgQXv
 /xvefT2JXdhZgR9tek2t12gI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ecbbf582530854b4;
	Tue, 10 Nov 2026 07:26:00 +0000
X-Mizu-Trace-ID: ecbbf582530854b4
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 15:25:46 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrea Parri <parri.andrea@gmail.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rtnetlink: return EMSGSIZE when first dump entry
 does not fit
Message-ID: <avLG-gH71kT9Zewc@fedora>
References: <20261109012115.11898-1-stephen@networkplumber.org>
 <20261109012115.11898-2-stephen@networkplumber.org>
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
In-Reply-To: <20261109012115.11898-2-stephen@networkplumber.org>

On Sun, Nov 08, 2026 at 05:13:12PM -0800, Stephen Hemminger wrote:
> If a route entry is too large for the dump skb, the dump is silently
> truncated and no error is returned.
> 
> For handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE, rtnl_dumpit() drops
> -EMSGSIZE and returns skb->len. With an empty skb this is 0, so the
> dump ends with NLMSG_DONE and status 0, and the remaining entries are
> lost.
> 
> The first dump skb is allocated from __netlink_dump_start() while
> max_recvmsg_len is still 0, so it is only NLMSG_GOODSIZE. On a 4K page
> kernel that is under 4000 bytes, and a 500 way multipath route does not
> fit:
> 
>   ip link add dummy0 type dummy
>   ip link set dummy0 up
>   ip route add 198.51.100.0/24 table 100 \
> 	$(for i in $(seq 500); do echo -n "nexthop dev dummy0 "; done)
>   ip route show table 100
> 
> The dump prints nothing and exits 0, although "ip route get
> 198.51.100.1 table 100" still shows the route.
> 
> Only ignore -EMSGSIZE when the skb has data, so that an entry which
> does not fit in an empty skb reports the error to user space.
> 
> Fixes: 5b4b62a169e1 ("rtnetlink: make the "split" NLM_DONE handling generic")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/core/rtnetlink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e141340172ce..2777796a4ed2 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -7043,7 +7043,10 @@ static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  	 * Some applications which parse netlink manually depend on this.
>  	 */
>  	if (cb->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
> -		if (err < 0 && err != -EMSGSIZE)
> +		/* -EMSGSIZE with nothing in the skb is an error, as returning
> +		 * a length of 0 would end the dump as if it was complete.
> +		 */
> +		if (err < 0 && (err != -EMSGSIZE || !skb->len))
>  			return err;
>  		if (!err)
>  			cb->data = NULL;
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
