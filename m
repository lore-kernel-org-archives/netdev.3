Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF631A051
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634405; cv=none; b=UWrnj9jsxdvUj43sC8A8fhAhAB4ZW/3Jo45WKUAmp5xPgX1wu5p2zgjIpaxE6zEoQIdR1NuIGLB05fkTmYaBlJ2ai3sq7YiS20FSPGw6pG/wcwN4j6ZmxyIaj0fHBlb8epk+1jNHi98i5nTby/TIzIEXzVoums8SOS0/2TPkKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634405; c=relaxed/simple;
	bh=+rhU6T9gZtMQyQQaiv14gSj3cchdFROIRmzKJvfKKvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SnW5mKM8YG9yZDbXywpHEDa3/PGxj3bAVNWrGyYwab6MvhEAcL5hdL6FJB9Ycwx3z3YFbu+kfL2mpeJ9oIY1+ghzxJkRtS73/tW8nPYY0TCeWLjZnllgo33zLHpFNW2P4lOUMHArdYMLhybyvFviQWRYrS05sQUrdWpoiur7w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYJEiRLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYJEiRLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882E3C116C6;
	Sat, 21 Feb 2026 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634405;
	bh=+rhU6T9gZtMQyQQaiv14gSj3cchdFROIRmzKJvfKKvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RYJEiRLIy/QXrgT2MEDgZhwDy9j0ZdOSCSfwc/5UrLiRMLB7BcEX8yk09b4mQ3+F2
	 Q70qJUAqrOhny+orlhRE0JOEdTCTiLO+CTYThHXKA9duK+lqAakP/TMDXjvLYQxRLu
	 sdPPhN8V03GcW4YWoJVIyEVisFIxPIUwDfwe435dgD8eKUPBT33TPlbAlsx4ky3GqP
	 LF6NwGhUlhdWh4g0/nHrfqsFP/+llSuuTxzMPoE7a5cifrbSxU5hP+5z9j+k4iiR9T
	 RFLSTwTXiDWK+sJvI/97LwAO8mfCKJCewuxhM5XpSrdoctZsq8pIEnd/gYWTBI+VUx
	 TweMKE5Sx67mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A63753808200;
	Sat, 21 Feb 2026 00:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx:
 test
 RSS contexts persist after ifdown/up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177163441330.959452.15768501686557599073.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 00:40:13 +0000
References: <20260212081250.4088970-1-pavan.chebbi@broadcom.com>
In-Reply-To: <20260212081250.4088970-1-pavan.chebbi@broadcom.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com,
 bobbyeshleman@gmail.com, davem@davemloft.net, edumazet@google.com,
 michael.chan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Feb 2026 00:12:50 -0800 you wrote:
> On Wed, Feb 11, 2026 at 10:01 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > >
> > > My experiments are pointing to 'self.cancel()' sometimes taking a lot
> > > of time as part of the exec().
> > > I don't know but I feel the new test code itself should be OK. I can
> > > send a v3 and you can run it once too?
> >
> > Could you reply to this thread with what the version of the patch where
> > you see defer() takes a long time? We use defer all over the place..
> 
> [...]

Here is the summary with links:
  - [1/1] Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
    https://git.kernel.org/netdev/net/c/ce5a0f4612db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


