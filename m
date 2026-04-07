Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCEE2836AF;
	Tue,  7 Apr 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527833; cv=none; b=UawhSRnZyOhAOuaJPmgOMRcFSQBdwAz5uWdWYZ0+kGNWhHGCWu2CYh6Qw+/R2HhiQwehAnZocHRLf0jbDWfMJhdIf2wzgzxEIXk+qqi86nM3OMyXWARmQNpjmyfeQk0KUqk3ev6GDsR7HPgKaYdj2FLOYrXBR0A4wT6NULBmDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527833; c=relaxed/simple;
	bh=27jpjNzx0cFfgKTYlxhm5WUR7kjfs0yfVFmSOEdpKPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZKxrtM0UpyHjbnnUrQl9xwFOs/BnOZ6g+LbvjJIEje3v2wgl8blt8qRKs/81fWOvwgPuJ4zeMnHPrUr9LAfglCNyknM36cb4oJFnJs8lR//Rk1xz/DhvZaOvNqjtpvHIOpMUlscO+dbZjU+PQ0Sq50bhApzQeMDWH8m8VsUfE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzXTZKaH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzXTZKaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ED4C4CEF7;
	Tue,  7 Apr 2026 02:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527833;
	bh=27jpjNzx0cFfgKTYlxhm5WUR7kjfs0yfVFmSOEdpKPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EzXTZKaHmvzWCLcXoXOtQY7cO0WXSsI1wCe83GtBzVaYOdiMRqgCIWpGZZDSd/Hlp
	 cnCDA0gwcvLfwaGGEf9rAgooiPAjtzBaT2Npq9jPUk1hYi2lR3Qn5gA7iZkxpAtE4s
	 G94JUAdMQHiDnKS4gAXHwEv9XCO1KwV6TYqa1ZLb5JRJ5ptDDbCO4uYKuSLVFc2Hjk
	 Nbz4Tw1JAwiqJ+PMH9unFvclZSjc2v9pRc7w/QAXQCHrv/h/kDQJvz7ensk2MVt2ue
	 IY52fve4m+z9//+LKNASQ+jaVbbGhM0YDnrsYi0ktHC67XPh3oZIlPLA5jeB2Eb0xV
	 Uo4CyzXcWtEqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE63809A28;
	Tue,  7 Apr 2026 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/5] NFC support for five Qualcomm SDM845 phones
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552781154.3342975.13085478526282398962.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:10:11 +0000
References: <20260403-oneplus-nfc-v3-0-fbdce57d63c1@ixit.cz>
In-Reply-To: <20260403-oneplus-nfc-v3-0-fbdce57d63c1@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, amartinz@shift.eco,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, casey.connolly@linaro.org,
 amartinz@shiftphones.com, petr.hodina@protonmail.com, l.j.beemster@gmail.com,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, krzk@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 15:58:45 +0200 you wrote:
> - OnePlus 6 / 6T
>  - Pixel 3 / 3 XL
>  - SHIFT 6MQ
> 
> Verified with NFC card using neard:
> 
> systemctl enable --now neard
> nfctool --device nfc0 -1
> nfctool -d nfc0 -p
> gdbus introspect --system --dest org.neard --object-path /org/neard/nfc0/tag0/record0
> 
> [...]

Here is the summary with links:
  - [v3,1/5] dt-bindings: nfc: nxp,nci: Document PN557 compatible
    https://git.kernel.org/netdev/net-next/c/e72058a4bed0
  - [v3,2/5] arm64: dts: qcom: sdm845-oneplus: Enable NFC
    (no matching commit)
  - [v3,3/5] arm64: dts: qcom: sdm845-shift-axolotl: Correct touchscreen sleep state
    (no matching commit)
  - [v3,4/5] arm64: dts: qcom: sdm845-shift-axolotl: Enable NFC
    (no matching commit)
  - [v3,5/5] arm64: dts: qcom: sdm845-google-common: Enable NFC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


