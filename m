Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0B32B107
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918003; cv=none; b=Hdd1NA2/ol2AqC+Ma5jdincGR/dsNWzHsrz1acEDnhTzZhTPfmvKSnv/D0WtDSucaNTTlWSesVOtyS+1D9/ni03z0wFMXt6eBg+8uNld1eT9+hGhUhb3ddoAlnrHETFpVC6Y/qwxGXZ787HL3WItVJRQ1cqfBxAjhj/Tx5eRXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918003; c=relaxed/simple;
	bh=9nSMgGbHYLZ9ndfcWVD5w2PdNEuK2dnceFwfTeyhg+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qwKlt+XvStbK+YAjYB1ysB2O6jjmKHkOmpkI5dtQjLpWdXap5WQUBgyuONPkMli9wKE9m86xTo9LAWaFxoe3b0mNymyOYcA6AkcF+lUbJqmyU8HBZ+a2h9z1+Vz7fMPGsfQGM5SCDlziZgMgziOrrKai+pjvhuJgvCSsB1K6Io0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frS4+q+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frS4+q+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A071F000E9;
	Wed, 27 May 2026 21:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779918002;
	bh=rQo/0EL9TzOm0ksis7+tP9dUTod5L/Vstxtqiox69to=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=frS4+q+2icqH74YSbJ3LXeS+OBhNUeOzlOx0SAey85dMiFgR5PCIVmSnwDdZCLSEq
	 ztIUp3FAlgbBsjapmPecoQxnrJQ2VJRKryZ3pbizdrPxdFZ5IEykBqyVvXokX9xw5H
	 Cbk168pbEwIZv0ZejvLzpKJUnyD5M0PujNAbA5QofuQzQUxjA37F+FbztIOMsWnU+5
	 D2QNCkNh5nHXn40f1W2egsj/zXpA1WEMM+uAK6599J6Mj6Y7kCb+pv4RE9upGLpnts
	 QTA6a0ZKJAwshKfgLYZKOtMgU/JlevLBEWpLXV1jTlWKdRaelLyWsq0+e61DG4k445
	 1GPuaRLywWbSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B80380CFDE;
	Wed, 27 May 2026 21:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] dpll: monitor: add -t/--timestamp and
 --tshort options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177991800740.659484.12113652491930326498.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 21:40:07 +0000
References: <20260526115245.64824-1-poros@redhat.com>
In-Reply-To: <20260526115245.64824-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 ivecera@redhat.com, vgrinber@redhat.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 26 May 2026 13:52:45 +0200 you wrote:
> Bring dpll monitor in line with the rest of iproute2 by allowing each
> received notification to be prefixed with a wall-clock timestamp.
> 
>   -t / --timestamp  emit a separate "Timestamp:" line before each event,
>                     using the default text form of print_timestamp()
>                     (matches ip / bridge / tc -t monitor)
>   --tshort          emit a compact ISO 8601 prefix
>                     "[YYYY-MM-DDTHH:MM:SS.uuuuuu]" inline instead
>                     (matches ip -ts monitor)
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] dpll: monitor: add -t/--timestamp and --tshort options
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=83ba195fa4f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


