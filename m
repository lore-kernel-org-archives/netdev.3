Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A623BCEE;
	Mon,  9 Mar 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098308; cv=none; b=S2lGTUKS4iRgIfPjaPrHFX+ktsr+4gaQF9/avTpEI1wohucZkqJHNeXmNZEhi9BoJei3Z6qQ/xiIwIn4YtYIthKK45mss5rCBbCLQ36PK3gERQC+OeQdXppGR7nwL8LA9OkFSrJqzkEn/xVG5NfXVNjeoEuGHq6BnQ0GyLNOWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098308; c=relaxed/simple;
	bh=yr1BbUskKMDxVNwUewnuybasq7MpSYPSYu5QktP+Ywo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfqpDD2XrgvD8k14SJlLnDwlyggEkrUPavMo2aP7jzHNqlR9q36bvSLx9AcBXnOrqq2U+kPrEr+FOAsANr4fCHPnWVZiuLQbTcu605o4/9110+XCMkuvUFOMzEeXrXA2bRpMbRHFMphzCHLINtbw+p6p6LzwnQhHkp2rKZ8ET9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJH33dXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJH33dXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FDFC4CEF7;
	Mon,  9 Mar 2026 23:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773098308;
	bh=yr1BbUskKMDxVNwUewnuybasq7MpSYPSYu5QktP+Ywo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QJH33dXM9eIDGJpOjUkOV2f7KgKq6yykj+yEL7q0D07HooSegaSDYAY0I6CATfL5I
	 NBRuf8qNTjtTFrS5sdIFi8qD3PTp6ecvebXCap0tCQghfnMVTjQ8MkLAPfaTWU/lxD
	 koEpz7bgBGfTOO9dibHuqSE1fR4MgPYqQcAE6LcdVLVjPIM0TIqV3BnuLdeJvK2kUo
	 ytkIJcYUHZE7hrqxc+wNIUQTgu4O4iiuQOCoa24Inn6gtjeVKS/jLUfDVlLK2E4Vxw
	 GJ31bU3eTPaI/oBcdzymdMV5+UkCQlS5SxTeRAqALrwus9BRWfIHgwfcjLehv4zD3t
	 eAiaLgjL8CnRw==
Date: Mon, 9 Mar 2026 16:18:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260309161826.46074d55@kernel.org>
In-Reply-To: <f4598201-2115-43e3-9da8-22583ae67db2@kernel.org>
References: <20260309022013.5199-1-fmancera@suse.de>
	<48ccec3f-dbc8-45c8-afda-e4f7e8f150d6@kernel.org>
	<f4598201-2115-43e3-9da8-22583ae67db2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Mar 2026 11:26:08 +0100 Krzysztof Kozlowski wrote:
> Heh, I just checked, that's 6 MB module on arm64 which apparently you
> want to put into the kernel!

Pretty sure you get 6MB because you have DEBUG_INFO enabled?
IMO "I have full debug info but I care about kernel size" is
internally inconsistent.

Here is the top line of bloatometer without debug info:

  add/remove: 1769/7 grow/shrink: 86/0 up/down: 374521/-228 (374293)

The vmlinux increases by 200kB with IPv6 built in.
Not a very dramatic increase.

Please note that opening any dual-stack socket will cause the IPv6
module to get loaded. And opening a dual-stack socket will fail if 
IPv6 is blacklisted. So I find it quite hard to believe that other
that deeply embedded systems with custom configs there are systems
out there which don't end up with IPv6 loaded. Whether they have 
a single IPv6 address configured or not.

And if we stop supporting =m we can actually turn a bunch of indirect
calls into static inlines so in practice the memory use on real system
will be lower! 

Please be reasonable, this is objectively the right move.
