Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C43195FC;
	Wed,  4 Mar 2026 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587836; cv=none; b=dfifdjaFmW8q8TRBQxTSmr7yX7f5qCWx5LL0Gu1AbCVkbAOxKcoImYsQ7mXEWgbuTFprelwLeyRGegJURcYyOhh0Dq3J9MEuMsAYBjp5x8W0Sw7lotU82MsF+YzTNrOCp0ZOqwp6sheO7WRtV+uwgolMZEOvc+YRzVwNEiGoxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587836; c=relaxed/simple;
	bh=9m1wHg5IdT0/1rRJGgg3icrgBxLt9KFHPk7M4QdVLx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KjiEct6TJGAOg4l9paGLGBh7nEtViMoZaaLhxKGL5CnbTJ/d0k2OWxhUBFdG5aeVDLFDQfAJnV8ZUO2ymzmfB5jPK75qP2p8Ri7ZW+5aMIcWQvMA3NpJFkNj/ek2H6BILbtCuPfcLFo45ygSnlZDGHMNx1tYk87JC98qbrcLfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACM2hz+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACM2hz+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA40C19422;
	Wed,  4 Mar 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587836;
	bh=9m1wHg5IdT0/1rRJGgg3icrgBxLt9KFHPk7M4QdVLx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ACM2hz+ki8rvh049/s9hiaHErSIQDfWV7QG+9bvyl07CWSxujSHnHv0Spa91hCQxs
	 WDjduJOwoUFP9MJXkODvLLUo2i0TMZDu1gygRtc98fH5TmElRAFdCmZk0xMQeUiASK
	 xOvYAa+8pjihBnJc/TIKSjyyQ1LOLlKgsM3wgHuBkr64ke9qlckZQPK6zNRUDd7AFK
	 QUvMRi156Numfa1vh3+mthVMyXtWRF2KuMBsbILGBKhlRtHNwlb70rpLZRmeXNgO/V
	 92lmxLumJYkg01ILH/DjL6EnqhBYThSsP2fmghbSlpAZ24KZI+lZtTfm11TX/7S1f6
	 8Gx+q4SIirtnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE153808200;
	Wed,  4 Mar 2026 01:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] NFC: nfcmrvl: Replace strcpy() with strscpy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258783704.1546050.13471430707557277282.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:37 +0000
References: <20260301144345.218628-1-tomasz.unger@yahoo.pl>
In-Reply-To: <20260301144345.218628-1-tomasz.unger@yahoo.pl>
To: None <tomasz.unger@yahoo.pl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Mar 2026 15:43:45 +0100 you wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> Replace strcpy() with strscpy() which limits the copy to the size of
> the destination buffer. Since fw_dnld->name is an array, the
> two-argument variant of strscpy() is used - the compiler deduces
> the buffer size automatically.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] NFC: nfcmrvl: Replace strcpy() with strscpy()
    https://git.kernel.org/netdev/net-next/c/c49a9eb650d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


