Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EB35580D;
	Wed, 21 Jan 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963242; cv=none; b=N1w9AF3EVDGjipOxxBBi7VsW3DCRB+YrAjwzoFgv0wazanJCKVQnKlMG4q9LxoI/cIkFEngYtHAr1gD11wfyVpehsiX1h/+1oMVEr5vBUsLGb3yFXUe2Gb/M9woA8aOVWf0HiQby1ro/VIEXiF71Jr5/Q4hkzp+QkK1LgaUmEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963242; c=relaxed/simple;
	bh=KSM/996KvsYGXQgLqRHjxAdgZDlRmMt3bbuzVe+HEts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rzqcqu/CeI0Nm+MMuWEeNgrB1w/tQbxAPVyVX9LgL0WxViR01KVX3OwRT/9kA6fppCD+ZWYmLFamp4V+FHKXSnNag4BsEaQ3hdlKjrKwKitgrKaufVrq83FNn4tn+mPMlF1OeLYj81jJOcHDGk6Obxlq3KG8DcASEYOhapphxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIetLn1G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIetLn1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA751C16AAE;
	Wed, 21 Jan 2026 02:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963241;
	bh=KSM/996KvsYGXQgLqRHjxAdgZDlRmMt3bbuzVe+HEts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VIetLn1GYtMKBWXqBzXuLKpO5H2Ou2ORNXKh8bnPtaKnvXGG15TOK7pY77VrH5q1h
	 DwMmvlkXYEndCf1+Fx378BC1v3gH6YOo9gQmvzrTpbP5Arm0fg1VFqp51HEmzU+H5c
	 y16AfuN2sthyrhcreRKQj1Ov8HSvs71AYkB+q4d3W94xEAONG1ujW03AmCTScCC3Qj
	 SiB4jVuzsBbZedUx/U7qADVKbHDaKwhLtuPrRIR4B4duhyXUHAUEhop2niysTYSN0q
	 P+RLgre6fxINk9NYIIt2zS9Lkzkgtw+3dn6QljyyzXRWozwMNyUoX61R60uINX3fHE
	 UFtmwZIHH6rgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EEAA380820D;
	Wed, 21 Jan 2026 02:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Convert the Micrel bindings to DT schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896323909.699622.9160745595214081259.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:39 +0000
References: <20260116130948.79558-1-eichest@gmail.com>
In-Reply-To: <20260116130948.79558-1-eichest@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 14:09:10 +0100 you wrote:
> Convert the device tree bindings for the Micrel PHYs and switches to DT
> schema.
> 
> Changes since v2:
>  - Remove maxItems from clock-names (Rob)
>  - Add Reviewd-by tag (Rob)
>  - Kept the micrel,rmii-referenc-clock-select-25-mhz property in if/then
>    schema to make validator happy (discussed with Rob)
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: micrel: Convert to DT schema
    https://git.kernel.org/netdev/net-next/c/4dd29c654b0a
  - [v3,2/2] dt-bindings: net: micrel: Convert micrel-ksz90x1.txt to DT schema
    https://git.kernel.org/netdev/net-next/c/283d58723887

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


