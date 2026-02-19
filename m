Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46A6FBF
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771459871; cv=none; b=eTKO6JpYN1JzDiyOf1SFSnag1Ldjm1GLJbIgGSJToAw0wm5nXyi5REV8cR7CiEQ9nbDRSm9g0Mf+dSqbL/BbQA4cvdJt9YnJqwIpjNjBUAlIH9MvBx2gWI62mm7M3dtKh1wVNRuq3DPIkhIrs8QYM+/0Au/Xk0VuzwriGbGMjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771459871; c=relaxed/simple;
	bh=OV9Gaa6gFF61ssN8BKdmRENwFUpFt7VOWK1XQWFFOTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2C3ID2MuP4yGAgWQMDt3xVtj30BfRxX/Hmc8tzjhe2W03HmvILlPO1B6nrnCWPfruQFsjKBDp79lzzL9M8ObcN6vXylQpk1CAmqBr925o5z3DPJ/W/ZQrcyYokqlfYqcIWAHCVFrFJywf6kZGE5gi21bTiNFMUzqh6Uj3A9z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRD6MWtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRD6MWtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EC8C116D0;
	Thu, 19 Feb 2026 00:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771459871;
	bh=OV9Gaa6gFF61ssN8BKdmRENwFUpFt7VOWK1XQWFFOTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRD6MWtAL2YsFnELbWi1E90KSHaATnLrwV5hTQEeR6gjWt2I8+al4Hm/xmk1t0Uhk
	 HoYlf7bymFdHxvv7WbFpQcQ17Hr9YvqRUzyVDnIUDwlSBIZR09+98KTr6PCO8yUNvN
	 nXVUoviPI5Q8SlEsCSI7zZvb2VcNnEB/VDfE9RgGuWqthPOoeKY2TAo80nAFLoIJ6h
	 ETwRCPo4IOlm+2e6hpI3TXbFTempOqe/50Tb/dhRh193/iQEHhb9XwYvGA70c4rnB6
	 EBwCI27EhFRmi/yGfe6l+AQcpaNGra3BSR1KJ2qE7fJflxWSp52QCUkG8C45j5aq5c
	 LXHvkOHyn3RBA==
Date: Wed, 18 Feb 2026 16:11:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Bohac
 <jbohac@suse.cz>, Liang Li <liali@redhat.com>, Nikolay Aleksandrov
 <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <20260218161110.14f1551a@kernel.org>
In-Reply-To: <aZVByEOAYdR3WF4q@fedora>
References: <20260214091541.89659-1-liuhangbin@gmail.com>
	<20260217164355.7139ab53@kernel.org>
	<aZVByEOAYdR3WF4q@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 04:36:24 +0000 Hangbin Liu wrote:
> On Tue, Feb 17, 2026 at 04:43:55PM -0800, Jakub Kicinski wrote:
> > On Sat, 14 Feb 2026 09:15:41 +0000 Hangbin Liu wrote:  
> > > Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")  
> > 
> > Ah, also AI says the issue existed already in 
> > 3aba891dde38 ("bonding: move processing of recv handlers into
> > handle_frame()")
> > not the exact trapping instruction but the hash table was used from
> > recv_probe so at least a UAF would happen.  
> 
> Not sure if I understand correctly. Do you mean we still able to access
> rlb_arp_recv() after setting recv_probe to NULL?

Simply put -- wasn't there a case where rx_hashtbl was accessed after
being freed in 3aba891dde38 already? That commit is a year and a half
older than the commit you had under Fixes.
