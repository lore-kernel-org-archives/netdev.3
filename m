Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DE29B795
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814655; cv=pass; b=f77Hl5ru+IIGlFO0y/KaNW7317mv/PUOrtjTqcdemCkpgYUolyW96mOOYmKr3cFzXpQtIz1vW/uJX+6feo65xH1OenShAsB2w4+gh8XPoVn0w3FiVoeSE2yNT1hiXYKxY2Gv5Q6SmgCCWtSzV2k1qpEVlYipZNso1Eq4eJpOr/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814655; c=relaxed/simple;
	bh=iscFCO3gbZCKl7nRHSfqWe7Zm1pjTCd5trEn1vCgiYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIcEZLKlZOVYTzcvgpDeXxOyBTXAndi7OrhAmdcoN8bBXs7/QZn75LWZLtnEgnQ+dqKjowjo3pYF/O8x39Ifqlg+jH3RnlLyNdpQazX/4Syolr+JbsTN7+3hrYRImrBjuHZUlB6Bk73lb9n32d5Y+XLTix3BiHGETlGAXKIYSoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=glouqJia; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=prHYwYlh; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="glouqJia";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="prHYwYlh"
ARC-Seal: i=1; a=rsa-sha256; t=1786814620; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OFGw5+PiW+0pbARglyQvMFT5cwU0Gst15Blv4tp7ohs6xA9HOwNcl4X4/Zo0Ln2StP
    VPrAx9UBAtG75b4+acj4GlWzY6B3Ha0LqKpxwxV+q8XhXNrERgyJ29aJqrdAmzktndEW
    bnPA6n2KGBB7sp9JIJIjqsQMNPqYGS07XynipaW81Z+iLBlmfGojIkLqfG3PhiIqSORP
    UdH4dImdGaLjX91wfZTkr8PKwYkc2zoTGG+820YhLAek51c3ldq4snrMCQZTLUj01DTd
    p4QMeXtxN7ZaqR8LpZIzzx1fnE5beZic9d3iwyWfQ2H/cQapyK7JxOZa2PEatmNfqKd/
    83BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786814620;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S40W9Eg+/XwmbjpYvpVxbqFs55uu++it3lSKvawxKVQ=;
    b=bypvMlOKkuQUiyGyrr9U6S1vPHSN23X5XF3BYwhhwX5NRIfmwmdsaF0JBIZtJM6/N/
    ZBJM6tfb2nF7rii4ZFsjIpsNSTEpmoDj099QLNo8Iuy4JlxS6tdTdjTdmVW+dyhOHIFW
    eTo+arwy+E8wLRZpvuBgKDkMddE9+JLFQIyRaH5Ui6xsnqZGDYwk98Vl+udlPrNpIteK
    nFZOETWwc3xMnvo6BG7IGHcLzHvnA8vkuOvjpcP28mp+iMfcXHacv3TJt1sEib+SpAT6
    ZRwS5WPy/es5oDWrznia1AGkOH3J0uT2xemo/Q5IdJX+/gQfyrD/Pp0QbAeXmrcHmNBw
    sUKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786814620;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S40W9Eg+/XwmbjpYvpVxbqFs55uu++it3lSKvawxKVQ=;
    b=glouqJiaUrTibW6BV5BMpG8ZsjF7Non5tJrlPTEhs1Yj1qLFuXqFr6vrkWUUnVJxLo
    +8mJxMZi8eYUn3DDZoxHejKV+QE7mnCuJdxSFL+JslHmuNwct09EXc5hL0GTguRo6h4i
    n0S0PH79TtoA6IvfYoJ/+4uB1AVWRKhO/zl4cDRlb2o8kOExOwGpKpiVUcoa8NATaOv0
    Gca+ZXogbkc4MTs7u/vsJqLz/yJ2kSxKgBgQgJB/7s6O5HdUb0lhjTszIVarLDKuO3uw
    DexPWH9+tQY/1Yk4WuXPg0rW09Id1MchYAR3l4xolvQaRKjKTPg3Pqfh6FvydzxAvv6o
    6QxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786814620;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=S40W9Eg+/XwmbjpYvpVxbqFs55uu++it3lSKvawxKVQ=;
    b=prHYwYlheY6F7sZhhwAacwcHPyTmCMMca3DB3rjizZSxzQeLutfWEwXv2KSN4kL9eP
    W7n1Qx3ZTxm7Q9kx6BBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727FHNe6WD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Aug 2026 19:23:40 +0200 (CEST)
Message-ID: <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net>
Date: Sat, 15 Aug 2026 19:23:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Jay Vosburgh <jv@jvosburgh.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiale Yao <yaojiale02@163.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260815090015.4a518a54@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.08.26 18:00, Stephen Hemminger wrote:
> On Sat, 15 Aug 2026 17:39:38 +0200
> Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
>> +static inline bool netdev_has_ml_priv(struct net_device *dev)
>> +{
>> +	return (dev->ml_priv != NULL);
>> +}
>> +
> 
> Minor suggestion: use const and drop unneeded parens
> 
> static inline bool netdev_has_ml_priv(const struct net_device *dev)
> {
> 	return dev->ml_priv != NULL;
> }
> 
> 

Good point!

Will wait for some more feedback before sending a v2.

Many thanks,
Oliver
