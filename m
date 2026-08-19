Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039A489872
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157979; cv=none; b=vFLG3L6UnEsiVXTwTvPKI44MIU1OP7jRBR7oAYVX0mooXTLEyj3v6kGT89gvSx8v3Ic7B6Y469nl2JQCVAV117pLpLnMpzVMgAWSACaZRlkFhFCf/sxhjnO0jtByo6mpEwMQDp1S05iME5WccMMxOVbF64fEaFgGsjTpr6ZgHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157979; c=relaxed/simple;
	bh=kVm7qF3Egf7ZwOK5DxGrizYgvj2CLuXYPJof+rBpPXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA27RaiN5Ew/53PIXPpqGo9fWTCdSlWctF1sJuxCHvx1vqgFYr+uiXyv6Flnh3+BEG4j6AsG/ErTklf2rsXd3oTvZO1ylVohFhEEFJZNaDea8vIo4zZ/a7J+MEu8mkBMCWSWS5zhtSkgKYLcBFdoaNDXQWCfXUEyhwwtfV0zQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMgRbKPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMgRbKPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62E11F000E9;
	Wed, 19 Aug 2026 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787157977;
	bh=jurf5UncSNKJlvAHXmUIdjCmgyM2ngh4O35aqqoVlEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fMgRbKPe9w7DGjfiLUNP1qMckOIHySAj/PqjgXXpTu/peivFfMQmMChDLO1srccnC
	 6PvqC649KecYei3zbYpoXDoov0JqCDwrfnzkMqFqKA8g2vAK+6HB/YIEN0c+YFD9cp
	 RkTAahhayFa8yLWR3C0rxTBjQM6AjjXzeTKaHNWYPwFAhe7DK3L+cGJRWG4V/I1Fkj
	 8nLCVcIN/fUCZ4d3cyq9UHG4gdtQRJGQ3+v6H+x1pZEw6ArmHrLt1zFuU5QWhomZUB
	 yxk+TJRYfdU9qbE8Jrw7Blwkk2hKj2MH2flJ4NVDJUDAaHmCkYn+YtbWhsa7lDtU5O
	 45cxEGjmrdQcw==
Message-ID: <fc98de42-02cb-4de9-8986-b77414793df5@kernel.org>
Date: Wed, 19 Aug 2026 18:46:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2-next v5] ip/bond: add lacp_strict support
Content-Language: fr
To: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com, jonas.gorski@gmail.com,
 horms@kernel.org, Louis Scalbert <louis.scalbert@6wind.com>,
 netdev@vger.kernel.org
References: <20260625114216.2507435-1-louis.scalbert@6wind.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260625114216.2507435-1-louis.scalbert@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David, Stephen,

On 25/06/2026 13:42, Louis Scalbert wrote:
> lacp_strict defines the behavior of a LACP bonding interface
> when no slaves are in Collecting_Distributing state while at least
> 'min_links' slaves have carrier.
> 
> In the default (off) mode, the bonding master remains up and a
> single slave is selected for TX/RX, while traffic received on other
> slaves is dropped. This preserves the existing behavior.
> 
> In lacp_strict mode, the bonding master reports carrier down in this
> situation.

I'm sorry to ping you about this, but I'm wondering if this patch has
not been archived on Patchwork by mistake:

https://patchwork.kernel.org/project/netdevbpf/patch/20260625114216.2507435-1-louis.scalbert@6wind.com/

I didn't see any reviews on this v5, and there is no v6: is there
something to fix?

> Link: https://lore.kernel.org/netdev/20260603150331.1919611-1-louis.scalbert@6wind.com/
I'm asking, because this patch is required to execute the
drivers/net/bonding selftests target from 7.2 released this WE.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

