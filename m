Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C731429814;
	Wed, 22 Jul 2026 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754640; cv=none; b=kihO4EgtxU31EdHBwH85+/yr/1/fJLXCuJZuT/oH8Pndf3j67wbRF3znLvwbZruPFhfLaT4w+eGTZHNvFXM14sgrpwATiOaBWK9Cu5hLMEmFUIOW+wjrRjQDnERJgcxVhbWDumPFSO7bdjah1CM4ztNewLOtOCGH1ngiCsu1Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754640; c=relaxed/simple;
	bh=2Ltt3/6y3Ugc4Ktf5gFMSuk07L6dMSW1fu0iuWh7tXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HeowtOIyMYPVOrEsAOMVZSA5IpfgIlwovEZWkN8lbaOC/SmMsdTzzlZrNQ3ZwoWTc6XHro4A6ODN9cK6Xq3lKOH4Enr69pm0wMpjgCriKNSjlyQmoJBCWjpzv+lhXMVYDEXhRP6uBPXhmKlEQnY72Z50gE93cVjUyjll8g6mr5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGvpUI0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGvpUI0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F141F000E9;
	Wed, 22 Jul 2026 21:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754638;
	bh=tKSDJSZlKIPQynsaruakxY17Hn8RWbeBHUWAGWdiOgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dGvpUI0N2B9w4PpG0vzpHQNBqKLNTrzIbWjF4WcbwXiQCeYPuvwC3lsfnClbsM/lV
	 bhwdj4+sMG10eWnkJEERAitvm+hwE6lVpxQMpjQOeaUQTevRzGToWVdt3AwpwZz3Gq
	 PqXZaCyKMxR4eegeVlf2sjCbsZl6Ju7PaGCHH5IdMDugGk44to9SZitJKg3uZuwpTd
	 vjR1Ldjo5ccS9NRizbyAlULggJ3+iVOA+BFMN5k3ISGA880QZt9FF7OYacwAdYKp8b
	 0O7TFNQqtv4krCcOPlM6lC8mNexPu3PmNM+2J0H1v5AW5zA9lfDzYROn76VFd8u9pF
	 kcrOqL9jmWoog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A05380CED5;
	Wed, 22 Jul 2026 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for
 Geneve packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475460740.2026851.11087593775517321693.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 21:10:07 +0000
References: <20260713140915.3381715-1-harshaka.narayana@broadcom.com>
In-Reply-To: <20260713140915.3381715-1-harshaka.narayana@broadcom.com>
To: Harshaka Narayana <harshaka.narayana@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, ronak.doshi@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 edumazet@google.com, linux-kernel@vger.kernel.org, guolin.yang@broadcom.com,
 sankararaman.jayaraman@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 07:09:15 -0700 you wrote:
> vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
> outer header, but for a Geneve-encapsulated packet the device can set
> them based on the inner header instead, signalled by the
> VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
> function never skips the outer encapsulation, this mismatch triggers:
> 
> - BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP), because the outer
>   protocol is UDP (Geneve), not TCP.
> - BUG_ON(hdr.eth->h_proto != ...), when the tunnel's outer and inner
>   IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).
> 
> [...]

Here is the summary with links:
  - [net,v3] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
    https://git.kernel.org/netdev/net/c/34a71f5361fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


