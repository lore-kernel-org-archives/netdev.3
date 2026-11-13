Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588008;
	b=GYzHOC5VuY+cFwIDHqtQRVnfMjj//Juq99OBP4yPc80M/1kzxyYvhuSst+cS6Nv3ECy1
	 2Kl6JV59X0xB/O8asCji6OYT0iOU40tRhOIk2JZUiezGtJIiW3Ahb7+rL3Hnrdrx1syPt
	 kOCyVC5gQk+5XgOczI49FrRoVLccjUWboMzI3bp9VcKlbbq8DRfliNrPwb7kjd2OydAXv
	 Pyckh1foPXEwXXvRLKGFocE5iMX8j6Et+XFP9J8N2to+ed09vhXw4jv59j2o0RIxv7RGJ
	 LYstG7cW5ivd1F1T9Cr9eULcNZUsppyM6NH+/qbyoAMlIYYxwFlJlc6RN3wr3x3HVIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6avgCEo2fSnhFvLLvTnIlDNtmxGZjeyTfEPjKuzhlTQ=;
	b=OoBUIUe6uMKM94af2QvyFTVj3hxo2mDRrOWMJPRvCttDqYRQZSVuQlQxcXy7izCsdCJP
	 YfGl1ih6BJO9i8T/kv6kSWVw1EYeBbShkKpCytTDW2stlAWfKA66Lj1mZLh6sWR9BxJ2y
	 x9UE7EVF4YbtDXF983OFD9JVm591b4Jkau+nHA2ij+f6M4v0oA57twdnRwmZZ4jRgqJF1
	 RyFytfcLvLO/rcae0RT73oQbIlXAyTHPHUN5MTclZAOZPT7LoIg09eSV44omaLFD3jcZH
	 iHLVCQ9lXymbGcyy6B8XZEtuBw3s693b8+eBBTyLvObaoW+r9vbsP/fXnRVXqdw75dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6TzjbHm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE740606A33D;
	Fri, 13 Nov 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6TzjbHm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435ED1F000CD;
	Fri, 13 Nov 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588008;
	bh=6avgCEo2fSnhFvLLvTnIlDNtmxGZjeyTfEPjKuzhlTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W6TzjbHm6OxwE+vOYDAtt2IwKfUCCjuCwE546Kk07CsdxzT0OIEryyrU1171j2qFm
	 z/zM9mJE3CNFO5ZG829BEDCTr9hVv+GG5u9Fl0OiODPCpdW7+bMGbpOYW1p8m/+sJM
	 pSIkcAVGz6ySqWVcJqyb+7cyO0QjpEvMhLiw6axt7ZasBRQjgrnY+PpiIxHe+M9WTb
	 +hj5qglbU2cBR5GqDuDTIJeShz8lYIeGnlTQ5CQJUxFYh+nPvAbEAmISFjzvifGDWX
	 0flyt6ZLOnfiBkohPcldj5UttVYLPA53/cuW2P+ls52hpY82osTSS2CKRGmEtXfo6I
	 oekLdq2Q4jvOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A381392B1E5;
	Fri, 13 Nov 2026 16:40:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 0/6] eth: mpnic: checksum and segmentation
 offloads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179458800703.1155704.6123486269782874455.git-patchwork-notify@kernel.org>
Date: Fri, 13 Nov 2026 16:40:07 +0000
References: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
In-Reply-To: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, dimitri.daskalakis1@gmail.com, mohsin.bashr@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 14:06:33 -0800 you wrote:
> Add checksum and segmentation offload support. Tx checksum offload
> follows the generic csum_start/csum_offset model. Rx checksum also
> follows the normal unnecessary/complete model. The device can validate l4
> checksums for tcp or udp, when the l3 type is one of: ipv4, ipv6,
> ipv4-in-ipv6, or ipv6-in-ipv6. The full l2 checksum of a frame is always
> passed to driver via a Rx completion descriptor field, which can be used
> for checksum complete on other packet types.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] eth: mpnic: Tx checksum offload
    https://git.kernel.org/netdev/net-next/c/164fe254d1e8
  - [net-next,v2,2/6] eth: mpnic: Rx checksum offload
    https://git.kernel.org/netdev/net-next/c/47fcc7451a71
  - [net-next,v2,3/6] eth: mpnic: TCP segmentation offload
    https://git.kernel.org/netdev/net-next/c/148df1a778fc
  - [net-next,v2,4/6] eth: mpnic: UDP segmentation offload
    https://git.kernel.org/netdev/net-next/c/6617d7ba6ea8
  - [net-next,v2,5/6] eth: mpnic: IPv4 and IPv6 in IPv6 tunnel segmentation
    https://git.kernel.org/netdev/net-next/c/25284507aca0
  - [net-next,v2,6/6] eth: mpnic: add GSO_PARTIAL for other tunnels
    https://git.kernel.org/netdev/net-next/c/0ad78e7740d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


