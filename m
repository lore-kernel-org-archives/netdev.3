Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC01377AB3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477347; cv=none; b=IgPbLnnL+vAU6l8iw7CLCj0gp6diWWQDOCTbjM6E3p0Wq4R3Gat+vaI2f+tVbNEufGYjksfsIDK34BK7dBUCzb1g0x3UD5DSHjULmAQsORMOsk9TW1b680ufmhcMw0HW9d03G7zBX//shrsaQJexQnLzwzbc6drbEX8IS4ZMKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477347; c=relaxed/simple;
	bh=pocQj149itFOpS0PEIRnutvZJVu/sC702LIBv/g4ATI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4Fo5bZu16q7Od8BL3Ouvvw+eSIe7m1EmJliLxQWifAJcq89m13Ch2StYtxJ2ieHh+rqjEtUAaYDMKJ9n9EyUPPZ67yWnP2dC0YlAptD7P8HOxEwDDZwIRtODWzoJBp9wofJFCx4x8HKVsuUNY0+DNA/fG9tfqehBKLO2ph6VFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eVpvHjbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UeCXI7l1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eVpvHjbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeCXI7l1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61546140032F
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:35:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 08 Oct 2026 12:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1791477342; x=
	1791563742; bh=W0oJMnCQ78JnYbIPPucOD7+9FD4ZiDpFqSPYnQzIwD4=; b=e
	VpvHjbBMLiES3j0KdNW4YwkJmIagzqzA5UcP2M4fv1EBF2LRwOHcJMTYYh6NYjsY
	MFciSi8CVUsT7VI7dc8ri+OVMPR8GNA7YsmspElmmyhWqFFl1t98WBzzEwGy6cFA
	7JepgA8XivgQyfxxDJ31Xe1jd4sVhdZSq3595Pi6FhpUeUGOHKQgJFbmD+qe3QL3
	43kLSmgY7hP9BkD2yMwNEHJPGs4Y/dC2FsBf6Bky+J+2XOwAw77Z/OzDadEm20Pv
	JmGBZmlWYMDg0m4sM+ak1XwsykrrnqesWcYVYqHQcLFP+IEJfGq7xSZIg8ecuCtO
	nccFrmz35poag5WXZcOog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791477342; x=1791563742; bh=W0oJMnCQ78JnYbIPPucOD7+9FD4ZiDpFqSP
	YnQzIwD4=; b=UeCXI7l1z1VJk8bgs888PxsX+cn751V4o3CTr81yzqZ5YYqwvkJ
	1yeN4WwDYFEHU5HMhpbuajaiUdE6yxbc8f38fZRpMKzTbh9+fOnAa4dYKjqcpXeO
	dAMfKrqiCyItjqKqNw6ZOFwhGT+RKXZGbXGjlNnW4hjPeqkXM4DufI7QPcy5Nv8F
	VNN6teGGzhpT/IseB148koazoB1Ler8tme0tnq/I89RBxJMVy33UGOqMB8VoQSm1
	sPhxS81M5r1thjTxx47oLe15VT6Y3lO5nPx87WttM591YWCeozexAXFTFIXGxlJc
	m/Uh0PgC9un6LWY7RpAAQFmQbLhJNKO7xfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791477342; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:cVFSa6akIb6JiUPWayHp3OBpTmKyvuRelZT9hj6Io8u1Lc/
	EPYTjws/hw6j5ZKM0UV0MqYrBMcYFcW0+BRJjfDg1W/ZGtgYqD5VCXDaPgQyXysU
	eHPtieTYup9Kgb95dNGj5TCW6NDWAHtPFkXGOuZmt3yAlwOPeTgsxutK33E/xIan
	9QlSGTEiSyx+M+DmPvZlP5o70F8aMTg0/zE5GVyIw/3Wp8gsKM6loMlCUiwBB+JI
	PKqKGA6f2AbXhh6hWqkcJ+TWQb38hPIGvFEAC2fvLfzkugUo0nC9Krmo3kP1IPqf
	IM+AL1fZAJI8HfaM4WLddtYyC5WReQQ5RYn3KRA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dXjq9keN5Lmrtr3qN/Na11kF1+qdczpxa1BvkjQrLSc=:pocQj149itFOpS0PEIRnutvZJVu/sC702LIBv/g4ATI=;
X-ME-Sender: <xms:XsbHamkG7XgMRzeXYMduQQIc3LTg3FS_EsTrDTNROor2e4KvjS6iog>
    <xme:XsbHaj2wDUAS2wuARA0Q_sAX0GnRZ3HIX2fSu3_xbNzNHH7V08DJ6dzuKTI8mt--T
    -jjpsF6bxIrsm4azCT_vEQAzaBX3COjjWW57VCZ3O3-JhF95-yxGRc>
X-ME-Received: <xmr:XsbHaiTOryS2Z4JoBmp_jWpkV6ss3tp5lFVwm_5U55Z3vPlRn8hqkU_ckRE>
X-ME-Proxy-Cause: dmFkZTELHSrcoZn21nBBS6LvUB8gjq3AOaA3iNgo8TuL9dAcqNJOoFtUlCrGqTHIFKHs6i
    5rJYxCZ/gHiJxvyL1gNseJf1r49UEoaxX0a98DZbmu4a/sW3RC9CEvyH9H0kPbfIDT77vY
    RAwoBEZAAg+fKdFf7Ygt6q8IqNCbk2qqu8ZjyPfkj6Yg5IM0I9hFPGrj2Y/xywJTRFwo3Z
    fR9ShAOTFOs7GZLTan6AVQYLpWjDLFUibQtnZKltMt+BgxrLwExudxP0wxcH/QPb0VcHYd
    Yd9Q/Tnzm0BfRW6J15wrkUF7Ct6ZF+FLfuVlFt1NFNQJP0LgluQZLcUa71VmYs8uyUdXji
    FzzIDSXw4JIFxc9bO8kl7aBEGUpVfjRmXZGfWY6QWl/RGPn9Kdqfc8fMYyGevq/yMwHe6H
    NODARA1IJQHMGY4y9CEoHc4BDus3cSdJbiYHeXJAKXxRpGpG3XG7Xx8UDwXhBE8RrTjDuM
    fblGrR6P6SF9PBwkpC9U+pG1Vtj2HPCeuBrod22F8BaQYIXLbalCuWp1I2JSKK/sm1EUr/
    uo5LiWYNAqlxE+WGBojVAX+VEb9cDnW8UHw/N8ondd9E7o2lh45kQQL+AFTdnGm/oOfaY9
    AUtgtk7FHPV6wTO08kfyCWsxZiiqw037XoHHJnnLoQuOM+mlRZQm3FjEF8RA
X-ME-Proxy: <xmx:XsbHaltmGfuInnmFfV9LrV0gZor_iIUOLriPhGGISc_ntrYatZZCsA>
    <xmx:XsbHanbUcOvZcvx0LmZp7_uloGC1OiUBLlg6Ic56QwmYkj5Ob6NyBA>
    <xmx:XsbHaqtlTGxKa2XWvMne3XHfPpoof0WimnCvRWYNnKp46FqMjUfCmA>
    <xmx:XsbHapGeF5-eX58NgDe-Li8fCI4r_4619I-3_rrx42XJKOX3qUHvUw>
    <xmx:XsbHajy8ymzWvekibFbLhSiU9O6iFEMioingUaRIX79YlocTH-dAjL6n>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 12:35:41 -0400 (EDT)
Date: Thu, 8 Oct 2026 18:35:39 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] macsec: reject replays after non-XPN receive PN
 exhaustion
Message-ID: <asfGW5xAQ9_dCN71@krikkit>
References: <20261008082550.349487-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008082550.349487-1-tjdqudcks0424@naver.com>

2026-10-08, 17:25:50 +0900, Sung Byeongchan wrote:
> When a non-XPN RXSA accepts PN U32_MAX, advancing the receive PN cannot
> represent the next value. The replay checks subsequently accept the same
> authenticated terminal frame again.

And in XPN? I don't see anything checking that .upper didn't wrap, so
we'll accept replays of the first chunk of sequence numbers?

It also feels strange to have an "exhausted" bit that only ever gets
set for !xpn.

> Record receive-SA exhaustion after accepting the legitimate terminal frame
> and reject subsequent frames until userspace explicitly resets the PN. Keep
> XPN behavior unchanged. Preserve the exhaustion state if a hardware-offload
> PN update fails and the old PN is restored.
> 
> The identical terminal-PN frame crossed the controlled port twice in all
> three baseline runs. All three fixed runs rejected the replay. PN max-1,
> fresh terminal-frame, and bad-ICV controls retained their expected
> behavior.

We should also have selftests for all those limit cases (for 32b:
exhaustion/wrap, for XPN: both upper32 increase and exhaustion).

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 78a19b1346321..906108e10b32d 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -750,8 +750,10 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
>  	/* Now perform replay protection check again
>  	 * (see IEEE 802.1AE-2006 figure 10-5)
>  	 */
> -	if (secy->replay_protect && pn < lowest_pn &&
> -	    (!secy->xpn || pn_same_half(pn, lowest_pn))) {
> +	if (secy->replay_protect &&
> +	    (rx_sa->exhausted ||
> +	     (pn < lowest_pn &&
> +	      (!secy->xpn || pn_same_half(pn, lowest_pn))))) {

The code you're modifying wasn't particularly nice, but this is
completely unreadable. And there's another variant of this test
written in a slightly different, but also completely unreadable, for
the pre-check (well, pn_same_half doesn't take the same reference for
some mysterious reason).

-- 
Sabrina
