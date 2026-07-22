Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89036194B
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750130; cv=none; b=J43e/fauWAmSB7WJqMfmm6Pu7ekHbRFKNT4m/uva5cVNdqn/2p+J9mIbv3yjyvLD9wIDQzjkdmPgFFoQO2TfAd9nZxd1y8sxXWpWr8XkBeM61yPzw7k8YX2Wjf7JaZyt76pRSTSnSMYiEGZXtCYKeMQwwmBOMZhXMV0dAFHWWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750130; c=relaxed/simple;
	bh=Ob3k6FOcz/fx2VYNzIABBkjIuaOxEMmy7H3elCH3Tow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcNat5VB6PrcDBt8p3MbU2emMeTxgDWlXiqhFlcPpzJ0/cZw3ZgwURCWVdnxfQWIMknMjCvOGF50XLSAZS27LRVJS61qNJJM/4AeSrShRtoMAHgYj8Cf8WS8z9AX8fCV5ldv93efvdaog+vIN+FaRK/ACfAd9rBIvDPx3zcF7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKDrba+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKDrba+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F111F00A3A;
	Wed, 22 Jul 2026 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784750129;
	bh=LdrfmVb2cSBi1mFE7YB8VCC1kclfoJMOrgKzcLHwoDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TKDrba+dSOgpIBYy70ydoZ6g7peUD/1yR8a0JLXmf4Ul2LCCrA9Vpf7ObcMAqMaPX
	 xWSoH40i+OpC/DRFDtBFlcd1YCytFi/TO7nXhZM9Tm/j/TEqbkYom2GiI+Tnyb458H
	 Uh6e9dkc9Tzko+9vtfXhv2hO+jO0xEDjKEB233Roa8A8Xdxh+cwWjtMGWgyOclE9AT
	 C8yMl3sxtRrw3F0y8Pu+//fcnnXflv6/FooRPKCYNkhA2BlF0knWhyup59xWx5F23B
	 /J4cO3B70R6gVq5nLQmJ1CA3WBoC8Ga+Mtk6vpcFa6hbO8982M4C7XpOuWYHs5EoXz
	 QH1YiMYQ+M/wg==
Date: Wed, 22 Jul 2026 12:55:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: houminxi@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, i.maximets@ovn.org,
 echaudro@redhat.com
Subject: Re: [net-next,v4] selftests/net/openvswitch: add SCTP flow key test
Message-ID: <20260722125528.0f192cca@kernel.org>
In-Reply-To: <f7to6g1q1ct.fsf@redhat.com>
References: <20260719162657.3263089-1-houminxi@gmail.com>
	<f7to6g1q1ct.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 08:42:10 -0400 Aaron Conole wrote:
> > +# sctp_connect_v4 test
> > +# - sctp(dst=4443) matches client-to-server INIT
> > +# - sctp(src=4443) matches server-to-client INIT-ACK
> > +# - remove flows and verify connection fails, reinstall and recover
> > +test_sctp_connect_v4() {
> > +	local t="test_sctp_connect_v4"
> > +
> > +	which nc >/dev/null 2>&1 || return $ksft_skip
> > +	nc --sctp -z 127.0.0.1 1 </dev/null 2>/dev/null || return $ksft_skip  
> 
> This can probably be instead::
> 
>   nc --help 2>&1 | grep -q -- --sctp || return $ksft_skip
> 
> This reads nicer to detect SCTP support in 'nc' binary.

Can we use socat ? nc incompatibilities are hard to deal with.
