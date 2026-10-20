Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528207;
	b=xDQNBT67+cEyZIGMivLID3pHsem9ehDfGbNuD2aqvKuvNcaoBZP0jAYIfJPOIgl48Awf
	 IT8Mx9epQEJZqCAqRZ3KI7Df8Xqy6snBGKMLze5+F1Y2rCPPkkDwnFO16BGr2668mipvc
	 0Off6cpmW273zJGDeqt5fUk/980J1UFgMO/qTeWZcWC3NCbvzEwHaFv8eXpzi9KXrEqOp
	 M0CCp/Ys8x7IG7iwnyNfEwgF8SQrAnztvlh3Dlh8nA6DoNZdP6h4S0Ypbmc+TEYP/CuyA
	 375K79OQH4peSLHMKFgImTN38N6qxfisbClDXtG6yJ9Fxv1uwT2O9ut63FmVHC/cahg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aAvnBMjH92cM2QBT1lcCnBLDPwEz2bOfhH5v02cG0N8=;
	b=uz1pRi/psojjbkraqOHvPCRiEP9OBBVmfYhX+SQzCcRjfI+vPsm13qVDxafVzcZhlvxQ
	 589Tq41gmGOvJgxJnTWTuHWCIkjSDdq+/gIuKelalnOtbBYPnxylnZQqMwPFEqC1gWj87
	 Atk4Ywh9amELf0lUSKYnKUQWUaIoTcka22ZgXhrpZ0OrPVz7gwJAPcIwhn8HNDzBSMhpv
	 D2VpZyewNzZKHACI3GrQh/NyTkph/FCXZB0trfeN+LAm2oSeQNG+yzFBKae+bCYPVaBqy
	 n1lRKiKF+00To51pyLlc8p0Zk4XmscP3DQTRmNRuZ30bpFNGJj3cjy050Ex/8PX82Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MJOf1/IK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B6606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJOf1/IK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2521F000C9;
	Tue, 20 Oct 2026 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528206;
	bh=aAvnBMjH92cM2QBT1lcCnBLDPwEz2bOfhH5v02cG0N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MJOf1/IKCwPN99R9XHEP862ecVSvVtx+v7esXNrxTME3xDw/60KFWw63Ub4VjqQZQ
	 duoOQDWOYSi7Dk8bOmfZjJ3pzOQfqBrZ31j/aQl96CFSKo08hL4jSI5MObho9XQc8N
	 z56mMSYo//iDWy0N9zReWhtWT2ipFUuCHq/s3aC9gOvRYE3HkEkvpWoZ+uQ0PyqB06
	 Xs2Sp9dq6C+6KPanlCL25JdiLYG6b7yPyqqbMJWCyKLbL37l9vPDtQOcnez/wpYMoi
	 yo5OA4XFM68TKUClBdFF/OYDD0GLk53i91OL/jWVwuvHPxDYP13946dOKeMVCGo/VI
	 m0islQW6NW7/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44113809A09;
	Tue, 20 Oct 2026 20:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] iavf: use skb_put_padto()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252820557.194567.3699567188784426422.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:30:05 +0000
References: <20261016094925.2762785-1-edumazet@kernel.org>
In-Reply-To: <20261016094925.2762785-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 11:49:25 +0200 you wrote:
> Replace skb_pad() and the manual skb->len and tail pointer updates
> in iavf_xmit_frame() with skb_put_padto().
> 
> No functional change.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] iavf: use skb_put_padto()
    https://git.kernel.org/netdev/net-next/c/4f29e69cf1d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


