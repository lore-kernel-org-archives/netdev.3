Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064989;
	b=MTq7TEWwCEdE6ibyozNe14ct3w8BkbHgMDwMOska8CmPByrzLNiAzA/VTkTDIDlCbbc6
	 2hps66yBvkmwDFxxOkMYZFDM5AKruE/TlGhilPkjPCFsN59g9bBsX/N/k6dLVSLRnU8mb
	 jizc3fek0Giw0uoM+3EZn8Ghf5HZxSeutL1/euSRn/6pN/aXQB05gN02OeoaCi5xOusff
	 BEl2Y5S+H750LAxRHACytS4qOP7DQ6+jbM3hrYX8wKMaInYeUCX+UxI/GEkHi8DdkRtzr
	 4CE7HHGdiKwM5g1+5Um7U3AZ69YYZ6id7dKVB1nVeK08qSxEg30xP9v1KumvpTnn3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064989;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=rmV/drJwFzjGVIpMrdq/RYdfM4Dnd81hhWt/4N/tmbU=;
	b=vJgFahtAthJxytfWfILxqg7MH8VhwyGa9yDkKjPs5LPIRyRqjzqFszudo6z+Er+Tm8rr
	 iKAgkpBAGVOu9p+rXDUShbTRtltVVOIWeIzjVrvxoqrkgoaVCu8PZl+hTxzxp12XuBYMW
	 wX0AH6fduLkQJXDyNZajybW7F9CD96iByEAyx6eWgqgrK2u5uZEO7sWBtr7g9Mb/QBtCU
	 L6EdY4HPQrpQlF04WTI3FZKHaOzASziyWd1Ol+s1a73Krg8Vuh43VLcIfh71+Pp9p23xZ
	 m+w6o+KaxEnP0ZscAMUaFO9moti3MJTy/cpKWBEJHTjZDOEjwXM/Xr5JMTVXGp3gg7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E2606A9FC;
	Sat,  7 Nov 2026 15:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881E2606A9FC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jMKYc30Jdz51Sm4;
	Sat, 07 Nov 2026 23:23:00 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A7FMutY052234;
	Sat, 7 Nov 2026 23:22:56 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 23:22:58 +0800 (CST)
X-Zmail-TransId: 2afb6aef42527d1-331d1
X-Mailer: Zmail v1.0
Message-ID: <20261107232258297K0a2CCYzVIOXLNuYCYeq6@zte.com.cn>
In-Reply-To: <willemdebruijn.kernel.703e96022339@gmail.com>
References: 20261107215051120CrLjo_cGXWfdJxXk4ae8s@zte.com.cn,willemdebruijn.kernel.703e96022339@gmail.com
Date: Sat, 7 Nov 2026 23:22:58 +0800 (CST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <willemb@google.com>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>
Cc: <josef@toxicpanda.com>, <horms@kernel.org>, <almasrymina@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbmV0OiBza2J1ZmY6IGRvbid0IEJVRygpIHdoZW4gc2tiX2NvcHlfYml0cygpIGZhaWxzIGluIF9fcHNrYl9wdWxsX3RhaWw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A7FMutY052234
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 23:23:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEF4254.000/4jMKYc30Jdz51Sm4

On Sat, Nov 07, 2026 at 10:04:25AM -0500, Willem de Bruijn wrote:
> In the series, Josef reported
>
>   Two BUG_ON()s are left on purpose.  __pskb_pull_tail() and
>   skb_pull_rcsum() have callers that can't otherwise fail, so they don't
>   check the return.  Some of them would carry on and BUG() somewhere
>   else, or push back a pull that never happened.  Those need their
>   callers fixed first and will come as separate series.

Yes, and this is that separate series for __pskb_pull_tail();
skb_pull_rcsum() is still untouched.

The return contract is not new.  __pskb_pull_tail() already returns NULL
today when skb_frags_readable() is false or pskb_expand_head() fails; the
patch only stops BUG()ing on the third failure, skb_copy_bits() failing on
a frag_list child.  That failure returns before the commit block at the
bottom, so the skb is left exactly as it was (apart from a possible head
realloc) and there is no half-done pull to push back.

Of the direct callers that ignore the return:

- skb_condense() is the one that can reach it.  It runs on receive skbs
  that can carry a frag_list, i.e. the GRO-merged skb from
  skb_gro_receive() that the patch is about; it now checks the return and
  keeps truesize.

- xen-netfront pulls pull_to - skb_headlen() only when nr_frags is already
  MAX_SKB_FRAGS.  On failure nothing is committed, so nr_frags is still
  MAX_SKB_FRAGS and the check right below drops the skb with -ENOENT.
  That is the same path the existing NULL returns already take.

- niu, mlx5 and ftmac100 cannot reach it: delta is bounded by
  skb->data_len at the call site (niu caps the pull at sizeof(*rh) +
  VLAN_ETH_HLEN, mlx5 clamps to skb->data_len, ftmac100 pulls ETH_HLEN or
  the frame length), and their skbs are built from page frags only, never
  with a frag_list child, so skb_copy_bits() cannot fail.

skb_pull() propagates the same NULL as before; on the GRO path the
protocol handlers get at the data through pskb_may_pull().  A length
mismatch is a driver bug, and DEBUG_NET_WARN_ON_ONCE() reports it.

Thanks,
Shao
