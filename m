Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F744DDB3E;
	Mon, 21 Sep 2026 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015587; cv=none; b=e3pIoidcmyHOEi2pXTdGk+lwVmC8xKv3q6Zmojf8bwn9YEFfiuJkkc49VjTPar/Vq74snHnRl8MwtoIxu6o1qdahmWgYTgJiXmILBoNzHWyaErxbV4PuL07Ur/gNVzUEPy3W9LaLyV/WJqt7+OKUbRGebadnfepWG09RUTE07eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015587; c=relaxed/simple;
	bh=e7eFgv9Xh1RyPh9o+fXn2SoUQyWtArk/tT//jdV7+R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRTmqrnDLxf2M844ZNKpXdpDqkPV0ttbhZNt8PZcGI8sJ6t4rhxG/33Y4/V4iwMoDSIOrNvCJRWlVaPhlblxXha/qz5ICBgf0LEhe1DsAubY2vSkYw+YQ1TgOE/YzRL4CqgNg5etRy3h8EUU6+/f/HLPc+uvy1ICbCZdb8oYRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JR+evLmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BUjgg91O; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JR+evLmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUjgg91O"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CFC291D0008A;
	Mon, 21 Sep 2026 14:33:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 14:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790015582; x=
	1790101982; bh=rT4ym6gamMeO4k+QCVSq/IQs/c+VRLzf2UINvFNoSNo=; b=J
	R+evLmvJGFATyl+UXWsjHehDdOMqztROlPbQ58+UaxgFrX2NkGCCgYD0uwo1lQvg
	hGNGKzLWzlFVIPLefP1W5OsqpBdQ/jQpQeV1a7Xu6qi8d3i8yxfRUdZbB6Os7WMX
	5if8AQvXpWEZTpzXJTYyqmivWk6X7JFKMh+IfUWtT35Y0mjEG/4V3cYzC5/eaV6V
	+MxNo/44oEfVr8X5kS7tKeCz9ahDNisHNzJgOeuSfQXkUfwZqlApRpk7O3gUcfkR
	QWkdY1UM7RMgbcYSYR9uTcSDfrGY9BWi8rRtChX9eEMWd+35N0poGj7oTCeMvO7z
	gMJt8zAEyZX6SMgwAQu+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790015582; x=1790101982; bh=rT4ym6gamMeO4k+QCVSq/IQs/c+VRLzf2UI
	NvFNoSNo=; b=BUjgg91OrvCUoMU6A/ou/6VAbBa/6I1UDMQZw02fXs5IXxucqnh
	MigWe/bCJ1hLw32p7GNWMf5gpQjWRp9+e2R01/NZgzaUpaW+8W0RHsbSROQSn2Pk
	iTlmtRvE2diqan52C3P4Y4ZKqhvxtsDHFnSjTClb21iCtfUpZMoEc4TaA37v3qNS
	iVYrfDaSaTswxQ19x7lgwJI+A8F8IBkWkavpdyGIyg9xu6YUNP7xRbCFfuxNklVZ
	QP/xDfDDyrRvstIV0jbN7IEjXBph4I7RiJ1XNci9xYtoRxa8rhlKAh/fRdFBMBQu
	VxRlXu1tq2uBozZAGqnjGfTd/sKitScI7ZA==
X-ME-Sender: <xms:XXixan80oZ2namY-8qWEaEVNeERo4RBz38-nl53hQ-Qwe_MQFb2BoA>
    <xme:XXixar6EUzxsFfL5EgdwGHV5b7nhy2IXXIPFPrtww3kMCfUR91H5biqpKSEoHCWSl
    NvCrIWoY6SpGMqSexRnfkbdiTs9Xu-QCUjFotQzJUGy6XN7EHNdcVeZ>
X-ME-Received: <xmr:XXixagn7dGViSPTPBgQl4OPTurNqWdEQNquNhfqE5eDGESUtuZ7nfxbwdU16>
X-ME-Proxy-Cause: dmFkZTFtlqAOmzOP88e/ejlp2Qk0G8rG1541p0jCDR/TlBY3ZinmwU0nhubQFSuunnmntH
    Uh+UcTjpfOBCSclTLC9pFo5fD+3AbLTHdCx69cRuTdk/bzMVb4XDjlngJyYNPsehgPQlwr
    GoGFtXVgnVzd/RPOdQAG0Cl1oyYqGZJKku+7NPXLybQZDiOvxg4M1G5AjSBQT3foSBqo2p
    b6rADWbO62xDreiiV/4dlLIYHkfAxDi0sMVfDGT2ktGMbbo6H9f5FnVEkDTVYhf+rNgNgY
    /l4L2VIlJgvKUkZCDyduITb8kyx323TK7+mK7KetBawFmrS5wkVZKQMQKJEKepB0x6tdJu
    0QNgQ4KGAp9cCKM4IeLINyX9YYetZ/X2bozpC/WBm5ruo6+Nz9cdEixNk55HHend7+QJ3R
    h6xA29by+qVa5GL8AR8b6yWph0lYncxS7x/uRCyv+gAjfzCVKhV5tQwdwW2WmEC2aHVWfc
    qGZEZ3CgVo9hQ8f9qKHaw8QTXDQZE/Yt4OKHXJqRVUOZEhTJZzYj4Oeewvp5Zd/XqG6vgn
    lkLEydvd+oT4PJHN4HmvLMPbmp1PlCPaLZSYTPxhILDGcbPA2mHhL0DcEItH/Ts5KyyWM3
    moOKejMs1niyvYA/tIicJl+mnwuDH0ZtAVTjSXS7OxaPkWx5LkxIfj++Gq9g
X-ME-Proxy: <xmx:XXixauF-Hen9pGiWYoYGhvO9GrbOW6pQ76QqIyGbOAZkSFy_yE3IkA>
    <xmx:XXixan9vR84q1tc3PRYMhZyZxmXhmucUCoQdlPoVURItAwXRA0AnAw>
    <xmx:XXixavllj-QjRIuTostG4QfP3eTyg3oMkMog-xLBr21aHIA0E15CYQ>
    <xmx:XXixaiA8A-Zx5I7L7xNJFRwu57zI2K5ZRrN9QTs7RADcZm6oA6a0gw>
    <xmx:XnixamBQtC33RkaPmaYutEspP38NJCviL-bPHYx011VLurXb9L1Y50Pu>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 14:33:00 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:32:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hong In-su <his1415@pribit.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] xfrm: add ARIA CBC and CTR support
Message-ID: <arF4W6lgjp9ovkVL@krikkit>
References: <20260916023135.26043-1-his1415@pribit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916023135.26043-1-his1415@pribit.com>

Note: for IPsec patches, the subject prefix should be [PATCH ipsec] or
[PATCH ipsec-next] instead of net/net-next (with the same
bugfix/feature split).

2026-09-16, 02:31:35 +0000, Hong In-su wrote:
> The kernel crypto API already provides ARIA implementations, but XFRM
> does not have algorithm descriptors for them. Consequently, ARIA cannot
> be selected for ESP through XFRM.
> 
> Add XFRM algorithm descriptors for CBC and RFC3686 CTR modes using the
> existing cbc(aria) and rfc3686(ctr(aria)) crypto algorithms.

Why only those, and not for example gcm(aria)? (just to mention one
that I know is a "valid" combination, since it's used in ktls, but I
guess all the combinations that are supported for AES would also be
valid)

> The CBC and CTR modes have been tested with IPsec using strongSwan.
> 
> Signed-off-by: Hong In-su <his1415@pribit.com>
> ---
> Changes in v2:
> - Drop the duplicate "aria" compatibility alias from the CTR entry.
> - Use a 128-bit default key size for CBC.
> - Document that the CTR default key size includes the 32-bit nonce.
> 
> v1: https://lore.kernel.org/netdev/20260909054530.7861-1-his1415@pribit.com/
> 
>  net/xfrm/xfrm_algo.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_algo.c b/net/xfrm/xfrm_algo.c
> index 70434495f23f..7ed84220ad5d 100644
> --- a/net/xfrm/xfrm_algo.c
> +++ b/net/xfrm/xfrm_algo.c
> @@ -512,6 +512,33 @@ static struct xfrm_algo_desc ealg_list[] = {
>  		.sadb_alg_maxbits = 256
>  	}
>  },
> +{
> +	.name = "cbc(aria)",
> +	.compat = "aria",

I missed v1 and the bot's feedback, but I'm wondering: Steffen, do we
still want to add "compat" names for new algorithms? SM3/SM4 are the
only additions post-2010 that got an alias. It saves a few characters
on the way in, and then we get the full name back during dumps, which
is probably more confusing than helpful.

-- 
Sabrina
