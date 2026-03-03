Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC31632DD
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497172; cv=none; b=QWoeJ6JV1YvwXkfKofrVSj8IL1SO1gtZUKcMTO51xSqFeB2WTRvHa50QL8CfX85W4VTo2RTg5ZfQIiqn6u/LW10gJQs0znGtLsbFMsE5jeIcIgAUbt78xg91uctiNNlg9xz4LSA+Klvq+vtMIFIP1TPzdMODJbZRB7aYG8UYaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497172; c=relaxed/simple;
	bh=qAt9pFEBY+VHvWx67/18n1SxCFgPMoLm5nrkvpm4Z4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXApRT1ni2at0ZF8wDG+FZi4bSmaLqitMCfBPN7r0ZFwi4ySSodd1UFSm1ZrE3Wt2s7EIONs1mBSQADdyNhamY7jw7Qj9UonFrpJtZC6Q8WxFBjOLvk3IoBV1t2LDq/kzjFsKTQQnywe4uxk06ypc55dn3v4aUzeFREubzo7Fv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUgoNGib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUgoNGib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEE8C19423;
	Tue,  3 Mar 2026 00:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772497172;
	bh=qAt9pFEBY+VHvWx67/18n1SxCFgPMoLm5nrkvpm4Z4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUgoNGibQ2B8N011M+8JFDIgA+d+Mv8d7Yralal8I/0I5KosRC7rYzFkXaIXjlYmk
	 8yvveU61DbzM5ALbz8zDdwfZXUS+wLKhTmEF/8CFJ5rdgj6ahVZo57iweo0XxOvv4c
	 ImUen/DDhkurmU2wS54JwV4jCgCZ4kh/boWnSHfEY+AK/u1npprjLtWnVTBFykqFf4
	 gtf3W7OY/koyJbMofK9huiDUalQS/pkemG+mnqO45q3Ofr3iomqZVRgvqtjQsk4UEE
	 VCHDeDBvjmoJMoXO/ADb7FUGcc1JGKYNtcM/qWiP8MwG945hqSoIa3WX4zkZiKPQdg
	 n2OlJFgUv0Gwg==
Date: Mon, 2 Mar 2026 16:19:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH 2/2 net-next v2] ipv4: bump rt_genid when a relevant
 devconf value changes through netlink
Message-ID: <20260302161931.6cd91704@kernel.org>
In-Reply-To: <65e44884-2db7-4db0-8f48-138983314450@suse.de>
References: <20260226133949.17070-1-fmancera@suse.de>
	<20260226133949.17070-2-fmancera@suse.de>
	<20260228104547.56186b2d@kernel.org>
	<65e44884-2db7-4db0-8f48-138983314450@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 09:27:04 +0100 Fernando Fernandez Mancera wrote:
> On 2/28/26 7:45 PM, Jakub Kicinski wrote:
> > On Thu, 26 Feb 2026 14:39:49 +0100 Fernando Fernandez Mancera wrote:  
> >> When modifying IPv4 devconf values using netlink for some relevant
> >> fields the rt_cache_flush() call was missing. In addition, if forwarding
> >> is enabled on the interface then disable LRO.
> >>
> >> This is needed to avoid possible connectivity issues and ease the
> >> responsabilities of user space tools.
> >>
> >> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
> >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>  
> > 
> > This OTOH probably deserves to be a real fix for net?  
> 
> Okay, makes sense. Let me re-send this to net.git without relying on the 
> previous patch. Then once is merged and net-next is synced I will 
> re-send the validation one.

I could be wrong, but FWIW in this case I think the changes won't
conflict, so you could also post them at once against different trees.
