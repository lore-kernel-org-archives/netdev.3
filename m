Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81560361640;
	Sat, 17 Oct 2026 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199408; cv=none; b=Ns0IQKm9+YY8z2bR6u4OhDKQOKZ0z6e3OaeyHjGoIfV0DFbKCcjedtr+D/RaMqeCtv7bpFSaovQijncarHww3qp6R1S4qJGX3R58TnEmtPyZoCMP6w5DlwAZSP7xHDKaE7KLBHS7SOtW31DsdqLMSyMErAy/rBDmHBQOJEDqmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199408; c=relaxed/simple;
	bh=kngYW9Acd5uFJOcKy1IwzHKHRk9hMCk2zWAmhmlip5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QWE4mosUKzZpBBaAKS4dr77uuBHrp/0SATUGkfPpDqogrnI7uLOH8P1q5s2o+TJKYLw6atda0w/5375Db+JBY8WsLa4zBKNvSVjbbSlQTKPh5od1SwO0Bs0hNANdbT7hguBihuUqJ2CPeC6X8BXtCAJ38krMQXIjpjoyqntSNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilSz8nWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilSz8nWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0820C1F000C4;
	Sat, 17 Oct 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792199407;
	bh=K77WVRrV8TE28I8U0O85wc7MMLGGxqqZI5Zgidghy94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ilSz8nWZPz5KloseSYEVNrGPM1nszelMp44oMQyst16A0OphwmUpVF7m7kzqdDKdX
	 HJ91wJa62AuwM9mpFAyzB2Rq6wsH0Pb2w8R8G6E4zqAZJ5mO9vEfBPJA1c7oHifdyy
	 i1V9UNgHHt5NRWqNbhqvrMFhPWH8ZbrkrZs2lYxgTzrgYyAos0neX5MtXzR+HSmccq
	 XnHiIY0TytSjV9sRjuGf6oDarfb3h8z9Tk6bHMhN18wRxugAnvBCSw3XbNwHgTv6sx
	 uhIDGMwBt/CkiJ5TsRBA5B6g+39dMQqUTBRDQFXbWStyirvuhJ0uLeY5cDKJ30sWJW
	 5aubCa5TiAACw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15A9380CED8;
	Sat, 17 Oct 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/5] dpll: zl3073x: fix output pin frequency,
 esync and sibling notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179219940577.1041032.9554002490347498296.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:10:05 +0000
References: <20261011061211.448373-1-ivecera@redhat.com>
In-Reply-To: <20261011061211.448373-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, min.li@microchip.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 Prathosh.Satish@microchip.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 08:12:06 +0200 you wrote:
> This series fixes several issues in the zl3073x output pin handling:
> 
> 1. Do not offer 0 Hz as a supported frequency, it leads to a division
>    by zero.
> 2. Reject N-divided output frequencies that cannot be set exactly.
> 3. Reject output frequencies whose divisor is too small for the HW.
> 4. Update the eSync period and width when the output frequency changes.
> 5. Notify the sibling pin when a shared output setting changes.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/5] dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
    https://git.kernel.org/netdev/net-next/c/23171065fb43
  - [net,v5,2/5] dpll: zl3073x: reject inexact frequencies for N-divided outputs
    https://git.kernel.org/netdev/net-next/c/f8993627d310
  - [net,v5,3/5] dpll: zl3073x: reject output frequencies with too small divisor
    https://git.kernel.org/netdev/net-next/c/456027325c9c
  - [net,v5,4/5] dpll: zl3073x: make embedded sync follow the output carrier frequency
    https://git.kernel.org/netdev/net-next/c/bf6f105f2cb6
  - [net,v5,5/5] dpll: zl3073x: notify sibling pin when shared output config changes
    https://git.kernel.org/netdev/net-next/c/0748e473b65a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


