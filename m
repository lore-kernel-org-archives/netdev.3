Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588049504A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463126; cv=none; b=Kd91WoMoBbRLC9STDbM7xtEEcQrP1KESY4Jp//1AF6B1ShXBTtlpTE/SD1PnONccLp6jcmEUdhqIXZkCd8kYGxVflIb5CgcQiSj8v51xJbdUc2rRua+HEzfrhzKVNwpNV1MGRds9Qja1h71GE68DzivVuERgLp2GAGBCPOS0ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463126; c=relaxed/simple;
	bh=URwSaekjnL1nbkUOtrm8l0o3BrCK4LvgZ73eX1K8SxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPjdTYEAapxzMbEXHip/rSZNE5vkaCVi5LHz28fvaYwb0mA6tnS/yR88ydv9ALFik+/xoZ4cjR9EBTugju0qKSRDWsrS9APlGLup66pU92S/dmXiXvrC0KXyvieBBWQMXjQO20Ysjyr+yeFajAABeCa1Y7STjL7pTEVj9BGUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=N87hV25A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBmvmHeI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="N87hV25A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBmvmHeI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D5DF3EC018C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:38:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 08 Oct 2026 08:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1791463123; x=1791549523; bh=dh9WPB4TTDrILJK1OPNo3Cx5BDd3OlvG
	/87qurPFaiw=; b=N87hV25ANVjI69iN1groJQ4aXS9z2Z1sQM39wwnUhUCfPQ2G
	489PHELW7GBGBJx/ViGM37YHIZTrnb5GgRiU+JeY/cVZskEk8zW/ionsXbzh+jwY
	R9Enh1h779xGcb3iMu5aBwROpYnXcif4BAmG4iY0lATN5+q0chPqbVlEqbtrW05v
	uKcrXtpQge7lSUQ/UiN/n+N+YteZg5z+WM6FJppvoJNqFdl9nAzboEThg0gxdoMZ
	ZL7sUhNYAwRNBdIXpQaFczLLTRDKSVqYtSVExFqhi/6n0GR4ytTv/UGTC2J1ZcAl
	ea60TouvyTD4GI8flJLiDLrcykVaWwoAh5Doog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791463123; x=
	1791549523; bh=dh9WPB4TTDrILJK1OPNo3Cx5BDd3OlvG/87qurPFaiw=; b=Z
	BmvmHeI33myprkcOqsuQnKUGWmB6DGOdzCxfpYbHh8zOqhfj9dyMkUuO4Tm9X4yH
	HTyI3l63Mk6HoiEFLd22hx+3w7blDNYWz6OVVyQfMq58JzYtxl6zbxamNoi+CjKJ
	f5P5ovkVKD5GzoHFmIDPgSHYfsezhkKR5Hu0xUu81qDNJPXFyhqr9lSNrK3m8JrO
	OnNJWpags/Mk5VKdtCvP6azx9qAOU6UFtHxr8KueCIsdkVyr8s7Vgzg0bIC4rkOP
	LEFz/NBX5OH7bFBP2GpT9A07NSE8hCp9Dms8FjcPxUjCeSVhsJbbMP0hP7L66mwS
	hsLYrCZ6mhPALeW6ooX1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791463123; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZQ4tc6Jq8jn/TjP2J3s/KZwvtItbkmYvVmAq4uv394CRsFE
	u9MJZIxxwEPo+7ezOF9k7HFytsp2Vh80mbtORBzlCKw0OFrHab8Dwt4IU/B8XVuj
	ecx19rlc4yMcIAzc24YxFT/vOre680OIIMMBQer6yrMoTNhqVyBRzej1flYwHiWg
	ggQTcA/elAdE0wq4Bp5VdlD+zbtQjSzNn+kzgUbMii2U8UnuqEFpwQSm10tDD38e
	Ba+I13P8qXgSoPZTTR+/8BfZVW0UoSmv2Hetl3ygaMb18/+/KWdKVEFBYy4eMkhl
	a+UJxwnG+YWov0irGF5udV4U2oBlK6pBt5gFiFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:puR7D5QmmaHowrW40k4DNSJ3lz956z5v17i4ZXoCn0g=:URwSaekjnL1nbkUOtrm8l0o3BrCK4LvgZ73eX1K8SxA=;
X-ME-Sender: <xms:0o7HavuRKhcHOkYzWDcz2vFJGvtx9qJPPEjhiwjYWul5j5RH6mf7LA>
    <xme:0o7Hap31ESs6UAxEogoLRUqIbscvbsy5OxJWi1lNDARnb0O4vCEqavFCy0CglYQxa
    TnqHr6KXqelY08T63BetsofG8VMjLdLi4NZswJJmkC5QKr47te5xczi>
X-ME-Received: <xmr:0o7HarTfC9yhOFZwExXMzJm3kIVk1PxWSZlKmjYC7ru0NeQ5JF3HsQCpHBc>
X-ME-Proxy-Cause: dmFkZTEECNTjd/hKOLiIyIHohdObXdhDZod88zeg2NIAdyr626iHyIBahS3jQa4X7JZTmT
    EQhWRbjleN8+H6iRXP2di62rVH6/46yHmlI6GzHWc/bJV+lLvaOb1ias6oS6UhVU0YsCQ1
    CHq+/ZSBkIHe8HPFHgvitKIbqBGouCos5e1TrzTtd1EIsHeK6WbsB6107k0jzW2Vv4RkBs
    9VuxmV0Bx0Sv5sq1JmVDUD8/GXn29WhDeUCoKwNwYvyqDcMuMaybd5Js/TqKNoWOpEfjIv
    OR818v77huR8NoXOJW9BEwR3/nuqbvKVTjviFC1DNLF5pGFqU3p9K9Qer33Mo92ZKBx1N1
    9oVMKtKlWpJtBxd/rwzLnBcLrVPDaMchSo/eRE0voWzEsgnH9LGsJLAnTA4iT3KhvO7Zru
    DTqggReUbiWmeXhq/ZEXgfJLL15Lg4eok/CvD6cheS9tnu5rqoVPh3WYeFJcZySSbYefTx
    bZI8WhysveTQtsYXZUHGRVdjkAbcWewWYLXtoeuMVUMTOrJJOrlzUjODeD9AuEaYt8db0d
    1TjWqKZk+2zTJcAHSCkXirsQER3y7BYwRTA0AON3F/rEYAzHjvGhHfkkiEPe41tM0GpVlJ
    ZvduNirgreP6ez9Z0DVm3zv5vvbObkxu27CADIByCfkoyuXvegJP7fxTTIrA
X-ME-Proxy: <xmx:0o7Hatt1MurExZwC9vhVPgVK3asB7zH2s7unX6-ky3b7farAmwyYRw>
    <xmx:0o7HahL273vJfBhXAte-yywpPnyoHuutV_M-ayNXInamyNN0R9oTfw>
    <xmx:0o7Hape7WX7wKX9Ma8u5e8FMC2WA3Mh77hqzuX_uzQfJI0AM-SqlrQ>
    <xmx:0o7HarUr6AXgP7ijPobNQJIN7TpQX388Ah7iWMAKTPuAftI0mS14kw>
    <xmx:047HanT0Lcst7TbqQRqODuYzfQYaYIxfakfptZYqMrz1vMk0z5QrwARI>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 08:38:42 -0400 (EDT)
Date: Thu, 8 Oct 2026 14:38:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, stable@vger.kernel.org,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, ronbogo@outlook.com, zylzyl2333@gmail.com,
	n05ec@lzu.edu.cn, eulgyukim@snu.ac.kr, jjy600901@snu.ac.kr,
	kuba@kernel.org
Subject: Re: [PATCH ipsec] xfrm: espintcp: reorder operations within
 espintcp_init_sk
Message-ID: <aseO0MuammN_z0he@krikkit>
References: <dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net>
 <179085931198.434549.11976738723347461302@kernel.org>
 <asXrPCMX747L5_tq@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asXrPCMX747L5_tq@secunet.com>

2026-10-07, 08:48:28 +0200, Steffen Klassert wrote:
> On Thu, Oct 01, 2026 at 12:55:11PM +0000, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 1 · Medium: 0 · Low: 0
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [High] The patch does not fully close the race it targets.
> > 
> > --
> > 
> > xfrm: espintcp: reorder operations within espintcp_init_sk
> > 
[...]
> Sabrina, do you plan to update this one?

Sorry Steffen, too much stuff happening at the same time and this one
was a bit complex. Let's see if the AI is happy with v2.

-- 
Sabrina
