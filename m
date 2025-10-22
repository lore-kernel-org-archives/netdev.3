Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D6846F
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094248; cv=none; b=oTmOiuQ+/TVzraQsnYj+dCFWZWoS5TM3FUu0mz6mH6ak09nbHzKx9Zzue2CoD9tXwAJdU7XOOsoMwCPJqv9QW7cIJlbgANiJFqEMTh89KocbMf19MKrT2Qzl9KQ0lcEtt6ETs5C2JnmQ0j2oxacZg2RP7MiKBt6PauNJQceVVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094248; c=relaxed/simple;
	bh=NNr1U6dbF9mBhs8rx3i8tywIpKbB860P1jr2BlFzOsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=skp5sWY62RnsJ4nHtgfyDeoKj5yjIYLZqbP8r1+L7pAzcWlVBJwLhNCSbh+PQVQ654uXat7vpC7kdQZ6liMKxtOmdG1TDiQ/NOf5sSU5Y9hC/5j8MmtVYdpeWVOSJAPDdHkBVbNps88jW3IsrsSsdzPzmCrFAjz+UVhESeAzGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKajOcK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKajOcK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF3CC4CEF1;
	Wed, 22 Oct 2025 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761094248;
	bh=NNr1U6dbF9mBhs8rx3i8tywIpKbB860P1jr2BlFzOsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QKajOcK69UKfvSUkirkZ4vg3GY3P5WvgabkWBnctfZwloZbnia7TnCVXsugqMYTMx
	 zKQ/uRJXDKCmiSGpUtLBNly2a2VqsKn5i96U7ZHBdOZtqMqMQdFLBYUojPA3xkPE4f
	 5aDjbtdnHfcA4i2WlUxRichddCrt6yX0ffUtzVFi7s++9naCB06CpTgclXyuxmoyTl
	 1q9lLpZ5vQf6LRD8axtNxkBYX16A9i9PZBQF9QjqqcGjrN+7RChWQBZflYgy15KkPM
	 sm9rVIzfdfet5m0acdO7EhmmzwV5AM23pFQRl5VLCbEokxDa4+O0pWOaLejeQp0kbv
	 dhJk12EIDBIYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3C3A55FA6;
	Wed, 22 Oct 2025 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] devlink: region: correct port region lookup
 to
 use port_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109422899.1291118.11554866418311248522.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 00:50:28 +0000
References: <20251020170916.1741808-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251020170916.1741808-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jiri@resnulli.us, jiri@nvidia.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Oct 2025 10:09:13 -0700 you wrote:
> The function devlink_port_region_get_by_name() incorrectly uses
> region->ops->name to compare the region name. as it is not any critical
> impact as ops and port_ops define as union for devlink_region but as per
> code logic it should refer port_ops here.
> 
> no functional impact as ops and port_ops are part of same union.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] devlink: region: correct port region lookup to use port_ops
    https://git.kernel.org/netdev/net-next/c/0364ca33097d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


