Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474D3DD847;
	Fri, 11 Sep 2026 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165711; cv=none; b=M1eLrLGM82t08QxpJAcB0oUckGrr3yJaOXE5hKobQor7ZlVjfT0+s5zYeHUdixPhVZql5jlOYGo98h4GVy31guzFr0tLlqqkVoby9kmZ0tY4keaNNEwQRWWp62EeGF3ZGziewR/iSg4I59Wrsatk7apshZrgN36OzPUFns1Lf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165711; c=relaxed/simple;
	bh=J34ChJRfnEor4xnLjT39ONvxVU5xrfTKtYl5hMoLu40=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l/u60kK6vK8t/PnfpDIY7qCl7t+WhxcgAxvDyc76DYhdDHDXaIrUELCfxfISakHXvx00LSz9a9Za2M/lmaXz//hBzGyHUtq5QN4vs9M1k0NrIa/eU7BYlVHC3fc5wyMqoaexuLuz+SX4q388ZOY6oYQqo256V43xO8fy6tOXgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ONRNSSFr; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ONRNSSFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789165697;
	bh=J34ChJRfnEor4xnLjT39ONvxVU5xrfTKtYl5hMoLu40=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ONRNSSFrJlTQ4pRkvvoaDhuTxzHcfeOin+SMMgW2p8vE2hHZqlq3pg6L2iXf64xuN
	 HiPiGAjn6TO7mobD6lR+z07B14gr4RdULFczrOZAs07VamvBrBFWl6lMiuVJ7TlKgi
	 wWhQGbbE4g91cLVj4VvxX9XHJrFm0auoSmNPbvmyKi2tY95NhzskOkxbNJ/aXvj5ap
	 XKQGFgogRvysiwlAM6RXrCLXV+1xFsAjI8uyZNqJjcUmvw7iaqzg+cIkw61hLaTlOa
	 YB1eqUpW918fj/eVu0pZyWHVOsiakEP6U+fDD7pADD7eb7w/0VwYYjAfdpzbrJ383B
	 uAqFsBFWMQeDA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5FFEC600FC;
	Fri, 11 Sep 2026 22:28:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 464862016D3;
	Fri, 11 Sep 2026 22:27:53 +0000 (UTC)
Message-ID: <11c42402-bb2b-4bd4-9b55-25bc560b3d12@fiberby.net>
Date: Fri, 11 Sep 2026 22:27:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Subject: Re: [RFC PATCH net-next 3/8] tools: ynl: add C-based YNL linter
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Danielle Ratson <danieller@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Greg Thelen <gthelen@google.com>, Ilya Maximets <i.maximets@ovn.org>,
 "Matthieu Baerts (Netdev Foundation)" <matttbe@kernel.org>,
 "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>,
 Paolo Abeni <pabeni@redhat.com>, "Remy D. Farley"
 <one-d-wide@protonmail.com>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, Heng Guo
 <heng.guo@windriver.com>, linux-kernel@vger.kernel.org
References: <20260910221733.1021864-1-ast@fiberby.net>
 <20260910221733.1021864-4-ast@fiberby.net>
 <20260910193348.2ded41aa@kernel.org>
Content-Language: en-US
In-Reply-To: <20260910193348.2ded41aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/26 2:33 AM, Jakub Kicinski wrote:
> On Thu, 10 Sep 2026 22:17:23 +0000 Asbjørn Sloth Tønnesen wrote:
>> Validate that structures described in YNL match their C counterpart,
>> currently focused on enums.
> 
> I don't see the point of this. LLMs will catch most of the problems
> and for the hundredth time classic netlink is not the focus for YNL.
> Anything genetlink can have YNL generate the code and uAPI so problems
> do no exist.

FTR, I didn't intent to imply any "regular" C code gen on classic families,
the --linter was a very limited output mode, only for validating enum alignment.

I like to also have deterministic checks, the LLM didn't catch the
IPV4_DEVCONF_* alignment issue, while reviewing commit 5e63ade19044
("netlink: specs: rt-link: update ipv6 devconf doc"), where I claimed
that IPV4_DEVCONF_FORWARDING = 1 (while it was 0 in YNL) in patch 1/3.

Now reading the raw log, the closest it got was "... which means there could
be an existing bug in `ipv4-devconf`!", but then it forgot about it, and
that was for patch 3/3. I can't find it in the Clashiko log for that series.

https://sashiko.dev/#/log/148492

> Feel free to keep the code OOT and let's see if you can prove my
> assertion wrong within a couple of release :)

I will keep it OOT for now. Thank you for your review!

> If you have any ready fixes to the spec please post them.
> I'm also sitting on a bunch of fixes based on LLM scans, I'm just
> blocked on the "15 outstanding patches" limit :(

I have posted my fixes for most severe issues now, and left out adding
extra enum-prefix and header entries. I skimmed your new devlink spec
patches, to look for duplicates, but will do a review tomorrow.
