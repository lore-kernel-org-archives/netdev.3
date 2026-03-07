Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A030C635;
	Sat,  7 Mar 2026 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853026; cv=none; b=VcG5YHV0oC7x3rL3daxYje95hVz0fEPs43INJyntXHsHqHz6lSBqgzRIaO2dKaR4kuiR7lOqs8Wb42Fj8s/lepkdwZqcMBeX4Wdj4RmdxsBJej/mbJAe6wgJ3TM8vvAQ56MqQs1P7K2wWW677Zcx8z4fR99WvIrhPaO6U5fGudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853026; c=relaxed/simple;
	bh=XLdWlwtlfJKjWUowgwoxRGqlKsLccKUUdUCfGVV3AL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZbDoSVtBWNEs/5oMDpmoGTHqAObDfx6/wrc+lIZcvw237u81d9HlAJw1fB6lfedqvg/Hg58+tXYO654L6F1wgHaTq9CBJ4HjgwyovRNpbGSbF0YjL75dLxKNxwrbG7NhFqPmaj1nVHrjmQLnz7VlV60vyZI+Nc6X6dj655qkKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/SRS7q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/SRS7q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D67C2BC9E;
	Sat,  7 Mar 2026 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853025;
	bh=XLdWlwtlfJKjWUowgwoxRGqlKsLccKUUdUCfGVV3AL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N/SRS7q3dgF5mdlv7QzRax/s6Rvtj319WlCgJlDPvlRu5QkPkYiq3USEv7jKk5py4
	 s5R9GuvBieeWkxTDE1nQY7sOmHGuyWteSIzHhhW+TiFkf+VmedoZrvvn/VGk5qvoOD
	 YG0fPJi0+XLUuBIRc4AFmdJh6IcZrw697+7UVWmkx1J5pZ0tATaIoXc3vtE3BaftGQ
	 UHCQPTZaVDX+xexuOsPVipP+ZJf0B0rxGUD42XErnmnbpVRKRZYfsPAzlciE5S/wfG
	 al2le4r5RzwHtLi00k/tqKZJWAne4nqfSGsi+WMGQPsCiEJ1IjuzQS7vRiZ0j0b/lm
	 rpomJsIvpynLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D853808200;
	Sat,  7 Mar 2026 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] nfc: drop redundant USB device references
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177285302447.135595.5467461178834238826.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 03:10:24 +0000
References: <20260305111019.18030-1-johan@kernel.org>
In-Reply-To: <20260305111019.18030-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 12:10:17 +0100 you wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop redundant device references to reduce cargo culting, make it easier
> to spot drivers where an extra reference is needed, and reduce the risk
> of memory leaks when drivers fail to release them.
> 
> [...]

Here is the summary with links:
  - [1/2] nfc: pn533: drop redundant device reference
    https://git.kernel.org/netdev/net-next/c/6c7f71032522
  - [2/2] nfc: port100: drop redundant device reference
    https://git.kernel.org/netdev/net-next/c/1a2d4bfa0491

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


