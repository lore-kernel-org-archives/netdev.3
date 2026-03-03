Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B682D46B3
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538604; cv=none; b=gY8Dh0yAO7rC/t+2DEWPuRxo/QPQcJoQb9xZ1tRfzvxEM3p6JnoONHcvC7K4N9LN4t/AjccM89rlds5VGP+oSv/CjZwuE/1vNJ0Rba8draIUGdQktUzKG4xlyACT9YnRnMVjdsETOdFSx7AkbxH/KAeRSeIC0uQa0T5Rcqt5+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538604; c=relaxed/simple;
	bh=u8rbT8/NeKpEeeWz81Ro38SoLa3EiUTRyj4XZHnUePs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qj69GMopMOMGc0dbuSn1kMQXUcQVOZ5lZ/hslIMBHag6uS/Hdk6aSdCdEEa2LFbpS/hCO6MA6gp01hzQMSu+KJS1DF7ebGyYYekyA0EWAHck5vHQLYhvWVmvIZeSpLcclOcwupYl9hRZr2ORDg/IVX021F34iuNjJrrp72g66VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES/NAHaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES/NAHaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1154C116C6;
	Tue,  3 Mar 2026 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772538603;
	bh=u8rbT8/NeKpEeeWz81Ro38SoLa3EiUTRyj4XZHnUePs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ES/NAHafPPT6VOzbqOeuwzNiDHTrQNI1c1pbNI6Mjb05tHLgfLn6Q/hNyo8P+zEt1
	 i1511EMuYJby5DUv6/QPUpdxXYL1O4BLSc7oLm8sN5/w/lYdVxV1TvFo79985nKEB0
	 nNN2mpvwTX2s4PaJIXN9vU+xnvorZKk5kH74LpmOvht09iwa+OW9IvqzSHoG/IzUCS
	 d53kIn9yCKlyS3CzG6tC1MWW0f/Yie+vMew1kfyw+6yg5nB0m4BPtiCDYyU7Rgz8vn
	 lxGoqZaB6SLcqI3M9Fsj48surk3XYwv8eTPXQ7KSBtMPiBMHOIHPqwvlL2NcQzMR5r
	 9wUqs9NgnBCjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC7380A965;
	Tue,  3 Mar 2026 11:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] indirect_call_wrapper: do not reevaluate function
 pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253860530.835747.6240964290195165095.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 11:50:05 +0000
References: <20260227172603.1700433-1-edumazet@google.com>
In-Reply-To: <20260227172603.1700433-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 17:26:03 +0000 you wrote:
> We have an increasing number of READ_ONCE(xxx->function)
> combined with INDIRECT_CALL_[1234]() helpers.
> 
> Unfortunately this forces INDIRECT_CALL_[1234]() to read
> xxx->function many times, which is not what we wanted.
> 
> Fix these macros so that xxx->function value is not reloaded.
> 
> [...]

Here is the summary with links:
  - [net] indirect_call_wrapper: do not reevaluate function pointer
    https://git.kernel.org/netdev/net/c/710f5c765803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


