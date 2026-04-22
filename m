Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C1221F0C;
	Wed, 22 Apr 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870275; cv=none; b=P5yb9agPF8Ygc3hLZ0nSOEW6TUZsxkAVjVZYHN9xCMPOZIgCF4B11NS1SNfTCo4GHmFaQNN7G8klrSpYp6rlyQZk4NpWIBnHYqisgtw6xMQ7JdK4I0A/TCAASoqkW0gJdZIzJqyoU0pmduJIRnNtUjLylzu13zwivVxX9WMIhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870275; c=relaxed/simple;
	bh=F6RKtB9c5NMsYq3hatvMo4jRKia2Q3VHjtemygkf68g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXC8r1+yp8SaYAnVBa3C4ONGiDJXH6F9awyUXz9bpTdNXAoaupympeGQN03ZKbW81KadK5b6pyMssf82sV0GfW2xeYHlipyMN+QZQsTYylN/mAQrq7k+7EnCoGMTu8LmkJuME0uJ/amuSihzaXInZ5jRBMETNU1BsUf/DZ9i6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krIayGE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krIayGE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8ACC19425;
	Wed, 22 Apr 2026 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776870274;
	bh=F6RKtB9c5NMsYq3hatvMo4jRKia2Q3VHjtemygkf68g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=krIayGE4TCmDTbCO9OAOXldfUme31ne4gun7oSWGgFPAo3zeKkanxDSEOU7y+1Mkr
	 gRng04c/Y4BrRCJQWJA+iZKQ8TNy6RaMk7wSr2QnCYLuVqjbgeNH5fmBKblmilt/g0
	 JE5IveefG4ehCG7A3k6T8Qi7tqgS3M6lgRQ6nGqnNv7fngSRyjLflassbQn61sPn9c
	 HeRCOhP6Xc3+4b+d6B8flPMmab06mr1wLHpZBV2E52dPfK23fWCX93u54u11X1TFfZ
	 5GPkiKykHtIZMuFvu1VmiGpMas6pr7UYJ5RVb6mK6e2sawSVFqFOAbGUdjZCJ+aOQ5
	 vZVne858Oqa/g==
Date: Wed, 22 Apr 2026 08:04:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: udp: fix memory leak in udpv6_sendmsg error path
Message-ID: <20260422080433.0e5a3b47@kernel.org>
In-Reply-To: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
References: <20260422105802.486216-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 18:58:02 +0800 Mingyu Wang wrote:
> During fuzzing with failslab enabled, a memory leak was observed in the
> IPv6 UDP send path.
> 
> When sending via the lockless fast path (!corkreq), udpv6_sendmsg()
> calls ip6_make_skb() and assumes that the routing entry (dst_entry)
> reference has been stolen by the callee. However, if ip6_make_skb()
> fails early (e.g., due to an ENOMEM from memory allocation failure),
> it returns an error pointer without consuming the dst reference.
> 
> Since udpv6_sendmsg() unconditionally jumps to the 'out_no_dst' label,
> the unconsumed dst_entry is never released, resulting in a memory leak.
> 
> Fix this by explicitly calling dst_release(dst) when ip6_make_skb()
> returns an error.

Test this with cmsg_ip.sh on a debug-enabled kernel before you repost.
I think it causes crashes there.
-- 
pw-bot: cr
