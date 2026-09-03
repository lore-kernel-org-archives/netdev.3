Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070349DBAE
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442880; cv=none; b=e3Sdty2KNW2VRrmf7hns0naGe87uLPUwM3BQxkFdQLG5LkYdJPHfImHMKJsGUrkMOxd5wpinHNJ8/7s/NocwdT7B2xgK0XwVgpIwZN3GAj9ofdHS9zoYe36v6phkcLfraPwNGGLSiNI3tDhfAzcdv2rwHM+kZ5QUsWppgE2wM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442880; c=relaxed/simple;
	bh=c+WRNGPyT5mwMLpW58Nc+EdWkMp/baHUrtSULy5KJzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVHTKBf/tsv/QpG8AWRlQEJGPjxZ5fLcvxFsK4K5XV3WiEYSKV6nXU89pdgFY7uZPTz/mXKUdzZ9zttreitDG2ibQK7EJfEkiduFdb8w+LAd0y2B1GSvLebH8L6Ukejq/4hd4QeAg8Vo6NFPJkPbViBPHTVRcHcIY5gzgMZWpIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqW3Snjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqW3Snjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6EA1F00ACF;
	Thu,  3 Sep 2026 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442865;
	bh=tWwra2HPxysM+2/X94BX6HsJaz2LgY6/rqJnvItf4Ds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NqW3SnjtORQbGMjyOKa+RsLsfLjQpn69LxA5hh0ikP+m3e9rx5NMEUtR5W/jqqwue
	 SdUld3nRHetYICclZBj2feIMYVGKe4WtibXEK4p3+etNk8/JY1gCFTUHWAWDCyLysu
	 6QBJNl8WCkl5GEqJvYPbS7tydj7yvI9znAsXqsvcCEkJKUSZe4iilCUe9wgi/M4fTS
	 qA95nFamKOrtalcxXjNNfh5giltCbK8riZlib0VnVKLfd1NtImb1Xhrh2RGHDWsO9l
	 hWr1Ov8DAn+jcwyjylIIYPP06mrAbpRtyFK7KtA8ZZH0+OrORLvC1rkZDmOjQ0rbto
	 mtjeDg+82hNnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1938119C0;
	Thu,  3 Sep 2026 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: libwx: rename wx_pf_flags to wx_flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178844280639.3351199.9655270665792858479.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 13:40:06 +0000
References: <9479B0506F544556+20260901065659.41273-1-jiawenwu@trustnetic.com>
In-Reply-To: <9479B0506F544556+20260901065659.41273-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 leitao@debian.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Sep 2026 14:56:59 +0800 you wrote:
> The flags defined in `enum wx_pf_flags` and its terminator
> `WX_PF_FLAGS_NBITS` were originally named with a "PF" (Physical Function)
> prefix. However, these flags are not exclusive to PFs and are also
> utilized by Virtual Functions (VFs).
> 
> Rename the enumeration to `enum wx_flags` and the bit count to
> `WX_FLAGS_NBITS` to accurately reflect their shared usage across both PF
> and VF drivers, and to prevent potential confusion.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: libwx: rename wx_pf_flags to wx_flags
    https://git.kernel.org/netdev/net-next/c/7042c8c193e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


