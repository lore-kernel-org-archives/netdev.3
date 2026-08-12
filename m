Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0343635E1AD
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786495557; cv=none; b=Px8YTBMDnmFo/QMkaEGp/XnSU1u5CZP7PiYsMP4zweycuyvMGR53pP4ETXlZNRhcCDLVHgPf9Xx+2mHfVJoscszeHotQBFDLWt1enQzMO3hvhI5Na8DgTKxPZEfoO14S1Jp0q9ckvkLgTnZeS923aT/5UXeQg8WEOWXp60qftD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786495557; c=relaxed/simple;
	bh=pDqai7r/O5/wp8TX/k7+4oLC+FC1SPLxI5plRWvi+FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaB2Gria1602OoigIxlPYCiNd1vZGyfw4Rs4kJfFFAV5B+/i0GMNirPQu6Qjt2lLoK/9Ujse+udE4WzhKEkqNpX+lIovBbI9oNhQT8F4B4bKO7qtdp9BUm+An+QtoOLiikbUJxdQN5YUstGMBHuSNETd58nTFXwKAHLCk/uNsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7k5rspb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7k5rspb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4401F000E9;
	Wed, 12 Aug 2026 00:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786495553;
	bh=hYEUfb7LaKZS86Qv4WyxBYeQ81hRh1oVJhQS+3Kbg2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h7k5rspb5dZvlQ5oK4P4wqvjz7SI6b9hc5oW9d/6G5pM5m4oKgdJDoCYuKAzYNsR9
	 uOmiRi5pKVUlbF1M7yKYZv+ZFGs/1Myu5uz3QmqQY8HDlCQRLgsjtBhxgNux3yCjzG
	 sj4NbZ3futTwLOVJCdYqsgbaHtsPf4pFbRJhAlHagdwGdma2HZnceIV36HuaXn/Ah/
	 Q/mevwPPf77R9KCKCAoputN/4Xkiw7eUd2640SXWZrfz5wstEeLoSz0T4+oPaM4FAj
	 sa7F+Ij+PmSSVaKxSaVycwxiNnGqcbqUkukFknfTFLffPEC2N3K7otHq+Be/yozkCS
	 NVtz0OaFOYOIg==
Date: Tue, 11 Aug 2026 17:45:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, yotam.gi@gmail.com,
 edragain@163.com, vega@nebusec.ai, netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: act_ife: use mac_len for ingress header
 offset
Message-ID: <20260811174552.21d08728@kernel.org>
In-Reply-To: <20260810144201.1563259-1-victor@mojatatu.com>
References: <20260810144201.1563259-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 11:42:01 -0300 Victor Nogueira wrote:
> On ingress, the L2 header stripped from the frame is skb->mac_len, not
> skb->dev->hard_header_len. Use it for the skb_push/skb_pull offsets in
> tcf_ife_encode()/tcf_ife_decode() and the matching header length inside
> ife_encode()/ife_decode(). On egress keep hard_header_len.
> 
> For devices where hard_header_len differs from mac_len (e.g. PPP, which
> reports 4 vs 0), the previous code pushed/pulled the wrong amount and
> could hit skb_under_panic on ingress when headroom was tight.

Clashiko points out that act_ife operates on Ethernet headers
pretty explicitly. IOW we're fixing a crash in a case that
functionally won't work, anyway.

Should we not simply drop all the packets if they are are destined 
for a non ARPHRD_ETHER device?
