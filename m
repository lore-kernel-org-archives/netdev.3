Received: from outbound.ci.icloud.com (ci-2002a-snip4-11.eps.apple.com [57.103.88.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B987366820
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860670; cv=none; b=Nmj1EcgULxXYtBU8VprFRpY/5dliN4vRvzgL/Dnq65Am1Qg43fdf+HNOSL2EoiAH2EC6SX4IYFh3HSxrXqHPW1o8JLk0ZkrQzec7clGueBZi46bOtFTaPsl3FzHWMr1prY8ovCI8MtzmUhHRPfjTYpKhtaJ3blmB2zXKCfMyPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860670; c=relaxed/simple;
	bh=VCz6Vzcxv7+HrW6MUnn7R0R4JcxjuaOFDj7RBZs1TrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiHQTtaYkOvbvQySq/RBxRhJbQ9ALvdCxycv9TkyC8l9GP2HqbQc1LCPkHgePwsA/62pkXQP6gc1wsEx2CthLDDelUN9xyuomZnarDf44YdBinD1NQX46NtfMaSFQe/23E5Pa/8V5R4IjVT0w+pQcFZ+Ze/j0gwWEK/ndUhyRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etehtsea.me; spf=pass smtp.mailfrom=etehtsea.me; dkim=pass (2048-bit key) header.d=etehtsea.me header.i=@etehtsea.me header.b=BTYydRqg; arc=none smtp.client-ip=57.103.88.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etehtsea.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etehtsea.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etehtsea.me header.i=@etehtsea.me header.b="BTYydRqg"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPS id 55F011800097;
	Fri, 15 May 2026 15:57:46 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5AHVwDWxxBAFYHXxcOVk1UGVoBdw5GFVEMQAhWRV8VGR5XUFoKWxx5HUcIXx9BFVhWXggXGVFNCEkTBVIHXU1WDUcPWB5cFBcbWkNeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVWGVIDRgNcGR0AUktfGV1FD18HWQRADEkGXAJeBUQIVgFYB1MAXQhVXgxeB3IVTR1bGUQOU15UHQ1NQxJCFQQbRh5DBF8vXRdeDF4F
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etehtsea.me; s=sig1; t=1778860668; x=1781452668; bh=DuQegn9fkCMACsPY0TAXb1FFSz4/Ugl6CDVsxtvsXcM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=BTYydRqgcIlRgyauh1SL5vYC76n5FVBUdjGDDdnIZP5eE685UFKpDKizQ7bAOSxH+B0qPGYz+FGSAxE9DflSY4p/6efglR9XWKYbuNYn5jS7sIzu/4dsAX1ATpHgJC1BKVSK3VXdtmV/dqZYBc5qAwZgnWUOTUhmLiv/fmBHhi59PMNXeJL+YlRQ0PN8mdGBrmteGNdF1kyXbpVED23aN4sKu3ficofL2FT3x6hcp0URwr8wqClgXd9ZBNb+46yEDT2btyXGVrX17u9LwWERR9Kzc87hRNWM6a6guPNvLgPCzXk0ohwapX7BxfthyuqfcZC5LoAFxgABjFyKxIm/Kw==
mail-alias-created-date: 1634905887181
Received: from localhost (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPSA id 4910918009BD;
	Fri, 15 May 2026 15:57:45 +0000 (UTC)
From: Konstantin Shabanov <mail@etehtsea.me>
To: kuba@kernel.org
Cc: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@etehtsea.me,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: netlink: Correct buffer sizing info
Date: Fri, 15 May 2026 22:57:41 +0700
Message-ID: <20260515155741.25082-1-mail@etehtsea.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512172757.10c43c86@kernel.org>
References: <20260512172757.10c43c86@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MBeYi7hRfafsSMgW6tgjcPjp87ci0_31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE2MyBTYWx0ZWRfX9u2+/58yK04i
 ED6wxzBp2PRTy+TwSw8sHnM9SWblGZIgyuFUeY1XYnhcSuSoWbeQqDsXukWSNKwwLXAnWyqLKE3
 ngnfDvfqN0Ns3qBlwXRfL/FJOHqjEzvblP2Ige+ckq5PzwW93+sVh1H60axPgH6F6lgMKdQjr+k
 Qjwe/nqM+WiFkyf1tptA3TJhuUavBxYDX/vL97dEViZ7/v8NKo1u9b07hQNrrYZrOZpFxW3PhU/
 Bz+Y0fcJgbdXDhRWL2DEjRGhOraeHxJe7ptlkdQBHDyOqSVrXl+OzvG8Byjjv730hINzPKQTBLd
 8ukX8le5Om+TIzph/z30sW1GYBeVfJ6FmcOjdpFosnR3eGsX/6r+Sie8ZgErIo=
X-Proofpoint-GUID: MBeYi7hRfafsSMgW6tgjcPjp87ci0_31
X-Authority-Info-Out: v=2.4 cv=J46nLQnS c=1 sm=1 tr=0 ts=6a07427a
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=3HDBlxybAAAA:8 a=UGG5zPGqAAAA:8
 a=TJPJEJdEWgVQhX8sVwQA:9 a=laEoCiVfU_Unz3mSdgXN:22 a=17ibUXfGiVyGqR_YBevW:22

On Tue, 12 May 2026 17:27:57 -0700 Jakub Kicinski wrote:
> On Tue, 12 May 2026 17:30:53 +0700 Konstantin Shabanov wrote:
> > Update the docs to match the code (include/linux/netlink.h):
> >
> >   /*
> >    *	skb should fit one page. This choice is good for headerless malloc.
> >    *	But we should limit to 8K so that userspace does not have to
> >    *	use enormous buffer sizes on recvmsg() calls just to avoid
> >    *	MSG_TRUNC when PAGE_SIZE is very large.
> >   */
> >   #if PAGE_SIZE < 8192UL
> >   #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(PAGE_SIZE)
> >   #else
> >   #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(8192UL)
> >   #endif
>
> You should explain what you think the problem is in the commit message.
> Maybe if you did you'd realize you're comparing kernel header comment
> to user space guidance which are (obviously?) the inverse of each
> other..

I thought that the comment is self-explaining:

  * But we should limit to 8K so that userspace does not have to
  *	use enormous buffer sizes on recvmsg() calls just to avoid
  *	MSG_TRUNC when PAGE_SIZE is very large.

The problem is that according to the comment, kernel isn't going to send
more than 8K in a single reply and the documentation is currently recommends the opposite:
to create _at least_ 8K buffer what looks excessive.
Also, the logic in the comment is aligned with userspace libraries (libmnl [1]
and wireguard-tools [2]).

[1]: https://git.netfilter.org/libmnl/tree/include/libmnl/libmnl.h?id=54dea548d796653534645c6e3c8577eaf7d77411#n20
[2]: https://git.zx2c4.com/wireguard-tools/tree/src/netlink.h?id=a998407747005ea7e4e0258d96f105c97241e1d3#n70
