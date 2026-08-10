Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FE3B6BFD
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405258; cv=none; b=NEpCRSynOZiHnCHz3Dr6GirsmRuSrc+iyIfOCEqHmDfLbaAEcKNSenMlJNTu3e6lfEfXL+QT4UVHHltDKw9OSNoVn6xbCh0AXFJn0IU51YpArpb36Gs01Gu68uV5N4vtaO0AMMWjiQFQ18F/LN3+aW5YbrJc9oqMLu0fEfcDE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405258; c=relaxed/simple;
	bh=U5OFjWCu2ns6gExqt+HwrpGv4d72+kFS4r0oDSxZNw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e46by4nPJc0TkRV0DcIakTWAwJV/yWCdSi7mxtR1yDs6UKcH9Hq8FnXFJqPdFY9DTCjhrkWUyJvzT6x6iyINoy+C+6oJPAwQf2skYsOMduIZMlrRT5MBg7H1kGbSA2ObHZbFYKqD6qKcklhN/JYNNUMOJYX9Q8BJsLcHjtscda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmywOP1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmywOP1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197381F000E9;
	Mon, 10 Aug 2026 23:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405257;
	bh=a6z6dz0gsrmTBYa6wsW95j9SI8xv1ZWu8Cf4xm9g2AM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NmywOP1cxmAzd/9k/TonWUXie+LuXjye9Sbmaxtco0AXIhSwfg+wMYi5VOxXYCfZN
	 Tj+soBFpHLlumA9OO7nF6xag/pd4fXvUR4UtNlQ5HPaEqEA7tXWihTV9qIlx7b+fqf
	 j16eNKLiweL/cCE4NvFrdx17VMzemcSkw25ypBLrAQQ/cL+O0Y7JQhSftyUIpqc0mi
	 Y5/qglEY8s2dfGtXliTaFUdC9UbHsH+gUxIoBH2p2JNQYYUi3ZnXhyBOimHxr+QQ1A
	 vb/iG3nr8xEOjHYO2wyaYMSVYbfjz2Idu8BRLLgozZfcWO9QRUo3SiPH33NFwGCYhq
	 C3bBdPbJxHIGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09AB392626C;
	Mon, 10 Aug 2026 23:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tap: fix incorrect variable used for USO check in
 set_offload()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640521338.254991.9428922162633399342.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:40:13 +0000
References: <20260807070914.112698-1-clementwei90@163.com>
In-Reply-To: <20260807070914.112698-1-clementwei90@163.com>
To: Rongguang Wei <clementwei90@163.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, weirongguang@kylinos.cn,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Aug 2026 15:09:14 +0800 you wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The USO features in set_offload() incorrectly uses feature_mask and
> features argument.
> 
> The USO feature was written to the local features variable instead of
> feature_mask. All other offload bits (TSO, TSO_ECN) are stored in
> feature_mask which becomes tap->tap_features and is used by
> tap_handle_frame() for GSO segmentation. Without NETIF_F_GSO_UDP_L4
> in tap->tap_features, making USO on tap effectively non-functional.
> 
> [...]

Here is the summary with links:
  - [net,v2] tap: fix incorrect variable used for USO check in set_offload()
    https://git.kernel.org/netdev/net-next/c/fac7973f004d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


