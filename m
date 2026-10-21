Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792626881;
	b=m3k+khtT3OwDkhqda9rqBAywxcJZG3YytbH0CNhgEQ/8h3PWl9ehC50LAc1Hee4Lko8l
	 L03PUBm4wbH/zmkasUen8FYJKw2d3J5NXlpnmmj12JBK8EV0zzFW3dSmGgiYgmE+xsXfd
	 /AA9rjH+Gcl20U7b47/TAtG5JAScEgz6ZSYv1/6AEfdpC564TJbLpkOmHL+e5MJ1/yluD
	 qrb1771uMZlQFRF+xCMeK4L4Gl9E+YYhyBvyhQn10y38aIqn3fIfENsmP+uG5DjyrnvbX
	 L8DtmOmEFI/OJFrGzfyPqIaQ8DhtEGhiUdYtM704z6f6fBMNEXL2SvGu3S/6nyf9YGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792626881;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q36qNveLTcF/2CVCJ9eqhSiMOybN5Gr8A5IUFmwUtAg=;
	b=MwdHOWyx0JhXHkMzbiyI3m4wRQfSRpQX0XvzqXik1hHYFOsig+iRlFPo/X4UOlrY5yWW
	 C4gIcB1clL0zDYAp9LBffxzDghd7OLW0YkycgiQN3ljIfLqOX1SkbggwZRFPlwMZ9faPC
	 iNQmycOk1AYgIsMri/aYpqLZ4wJAjij/lSRrr63AYJvglrPLg4Htgmg4y9wx8DeuxVnQc
	 jFjNCi4+dV82/VYBSnZZ0mdf4hgy9XNbc6fAc92Zuu5a+GzRGw5lPZqTa/AZyxMYJpt+R
	 iUzho+yfxQjZ+ggq8QImCeod2LTkFs8sPPlHuIqLTi4uOgggqiu1R0z2TIXQYLKqtzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBiBaBwa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2A606A319;
	Wed, 21 Oct 2026 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBiBaBwa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710611F000C1;
	Wed, 21 Oct 2026 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792626881;
	bh=q36qNveLTcF/2CVCJ9eqhSiMOybN5Gr8A5IUFmwUtAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NBiBaBwaGElD+PIGjz8+tQPRqzf/2eOqGBTzo/tNaRSZAvl7PlXB8ofO5QxjH8FFU
	 g3SwiYwfPx6N1Bdsxj0PnBBfdQDX0Iod++RclBJTlVStwSgePVswwA3ygolca4KqWx
	 PPxcZWrd3MIkJ4SE9vNldU60+zZE48XbsjuFtalc1nhy25oxuyosdMG/M6hXzwN3Ya
	 u2uQyzbwE2iUGXqC8FocO/gMTWHwrvjCEinUggn3RS19GXO9+MzSlj2fEDqKRWiIfT
	 wvitGdjqRynIWwliIkx4kVIDFjRd+YDqv22tSZbvGgHrqO2ezngjbCUIjDEreI0nnI
	 lJWtNW3eFNc0Q==
Date: Wed, 21 Oct 2026 16:54:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <dimitri.daskalakis1@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
 <hramamurthy@google.com>, <ioana.ciornei@nxp.com>,
 <larysa.zaremba@intel.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>,
 <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <tengpeisen@huawei.com>, <vadim.fedorenko@linux.dev>, <wudi234@huawei.com>,
 <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [PATCH net-next v17 1/2] hinic3: Add ethtool statistic ops
 part1
Message-ID: <20261021165439.1a795e5d@kernel.org>
In-Reply-To: <20261021082104.14495-1-gongfan1@huawei.com>
References: <20261020175113.182b3b92@kernel.org>
	<20261021082104.14495-1-gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 16:21:04 +0800 Fan Gong wrote:
> > On Thu, 15 Oct 2026 17:55:43 +0800 Fan Gong wrote:  
> > > +	HINIC3_RXQ_STAT(alloc_skb_err),
> > > +	HINIC3_RXQ_STAT(alloc_rx_buf_err),  
> >
> > Why bother separating these two? Rx packet was lost due to memory
> > pressure, doesn't matter which part failed to alloc.  
> 
> The `alloc_skb_err` counter signifies a failure in allocating a skb,
> whereas `alloc_rx_buf_err` indicates a failure in allocating the data
> buffer referenced by the skb. Given that these two resources are allocated
> and managed independently, distinct counters have been implemented for each.

Okay, so no good reason. Please use the standard alloc_fail stat
instead.

> > On Thu, 15 Oct 2026 17:55:43 +0800 Fan Gong wrote:  
> > > +	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),
> > > +	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),  
> >
> > Isn't the 1519_max_good just the last RMON histogram bucket?  
> 
> The `mac_rx_1519_max_bad_pkt_num` metric functions as a specialized counter;
> strictly speaking, it is not the last RMON histogram bucket. It quantifies
> the aggregate number of packets exceeding 1,518 bytes while simultaneously
> providing granular statistics for such oversized frames. Consequently,
> this metric is classified as a private, non-standard counter within
> the `ethtool -S` output.

AFAIU user can just add up the buckets >=1519 ?

> > > +static struct hinic3_stats hinic3_tx_queue_stats[] = {
> > > +	HINIC3_TXQ_STAT(gso_packets),  
> >
> > Isn't this the standard lso/tso counter from queue stats?  
> 
> Yes, it is.

Remove it please.
