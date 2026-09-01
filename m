Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC82DECA8;
	Tue,  1 Sep 2026 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232274; cv=none; b=pyzprBgl/0prpFgS0uX/CO998cIkKo94JnulT2u6b5CZpBRBqH8IxHDuDC41RT1wb7O3oJNVCjcPDkuduIcgPrpwd7eVji7zdXeCutWrJ/LwrrjXLRMKsc7FW8avWT36fiPqhJ/WLWrl+4yA7OFGG2ZrQd/aY56iIlJhimpns2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232274; c=relaxed/simple;
	bh=cOc2L22Llri+e6tjT17uyUdQ7023qApw6OVcn0Srfos=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fBV5GgAIsYEMlzAu2HhvcjrdB1NZlCzPfXfm9OYOdsFgfvdypdYDbTG5uvuNAbKfn8cOoA56f6Zcl4gf5w2fjVxpKHI75HJjq8Yp+iRqTGkC0mnt9mKurhDoAnc3Of5asruhExAf3tWmvCL6OYkG4TB3eK2kCQkumL3MUubbdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeIyWawc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeIyWawc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C8F1F000E9;
	Tue,  1 Sep 2026 03:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232273;
	bh=PEPzgn2bb8E3BGj8NWISdUdjMIn7NhjjdX8frGZRRrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FeIyWawcYnF7vrsZyJuIBQM/NSgFvwX8e+vFsKekmoseaaogQac85A+Ot/3OJF3LW
	 roWEObD9eTTUXu5fu5hGb3DKmiBpbYX/lKvh2AYmD/AQaSbJWpJClfy5pdR+hiiKnP
	 mkjwnnEo5O4zHjcVMfaBCx4abkZhPf7BtzeKs81R3Ks2INyLwBVYtSyYswEydRh8MR
	 9PLhFlzQITmfi4q2Gu/RYIZ0hxvRwd8cA9T4Hqc9SyLYJ5xOuq7P6ZkU0YMWSjoGG8
	 o5+l2A+7bIGBe9XNna+rOc0UoMTKqaPHEjC7mwsiDRG6QQvhsgNs//gnjunpqYq+x2
	 v9Vwa+TeNqr3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AFC3924A51;
	Tue,  1 Sep 2026 03:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: Dont send random pad bytes in RESET/ACTIVATE
 messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178823221590.912076.8913153975020025087.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 03:10:15 +0000
References: <20260829115813.188600-1-david.laight.linux@gmail.com>
In-Reply-To: <20260829115813.188600-1-david.laight.linux@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Aug 2026 12:58:12 +0100 you wrote:
> The interface name is passed in a fixed length (TIPC_MAX_IF_NAME) buffer.
> Replace the strcpy(data, l->if_name) with memcpy() so that the
> pad bytes are actually written (l->if_name[] is zero padded)
> rather than sending random bytes from the skb to the remote system.
> 
> Replace two other strcpy() with strscpy().
> 
> [...]

Here is the summary with links:
  - [net] tipc: Dont send random pad bytes in RESET/ACTIVATE messages
    https://git.kernel.org/netdev/net/c/81c600c26302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


