Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0639D6D7;
	Tue,  3 Mar 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534411; cv=none; b=Kv6+6ZmHOlBEQ0rvxqiHj3ci2526KNvTQlVCfSPObtJVj7DHFZRzjjTBJvlJ4PH9vXXysxE2KpNcYcVgyX9kmtugVLtydqin2YY8Dxb9M8gFfVdBUqM2WqhGXhyfCUpEZIn74nm4E2OMmPBg7nn8Wt8HzM8OZUThfYhRlrVDpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534411; c=relaxed/simple;
	bh=sCQr2PDstNwyoubAKjHSTNrGhEUkHUVAEngDre6l2dk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jT4Bd2Xg940EZn5x8i16Qq5KuOVwtpu0BN0260/asuY5/swFZNrXnZctZnmUUmV7Ln3Onpwm/1B9j3cCB6MjKDJeDLIv8wpVcHockN+Vhm3UJYIHcekAElgGxPO5emiYI6URi2mVRWTOysaiWgQO3HaRdiY5iVR2shLTNLQ6QpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEpNC/Fs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEpNC/Fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C2C116C6;
	Tue,  3 Mar 2026 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772534410;
	bh=sCQr2PDstNwyoubAKjHSTNrGhEUkHUVAEngDre6l2dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IEpNC/FsAq6ExyvLxJuV4sb94jVPVMMenBcYfZ+Ff5t3u/8QLNNgrhdMDKv0vipO+
	 lR69G5Tnv5OkB4kzHjQ4kW/51wDVcWIN3G5zGCJbGl+th4zycnUnGpZlI54hTecjaI
	 JOjyjdT0VkHgXVJM81fVvnY4xvGFNIvxraW6Rrm/2sAaiSKOWsJ426effTy0U76sw5
	 KpdH7xrQ6ratNAKefGOjfNdrlO6VUwgciIHZx3izXv3H7G++EgQ4jXYEzvIMJuuA+2
	 lAHu53JzypU+a62enK7+tpvq/XMXn3aUvpCM0D0ueqceDhUQSTmBS7mVtb+O3TxHEG
	 z3m49ux5tcMSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE9A380A961;
	Tue,  3 Mar 2026 10:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] avoid compiler and IQ/OQ reordering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253441229.791831.6108494712543738989.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 10:40:12 +0000
References: <20260227091402.1773833-1-vimleshk@marvell.com>
In-Reply-To: <20260227091402.1773833-1-vimleshk@marvell.com>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sedara@marvell.com,
 srasheed@marvell.com, hgani@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 09:13:56 +0000 you wrote:
> Utilize READ_ONCE and WRITE_ONCE APIs to prevent compiler
> optimization and reordering. Ensure IO queue OUT/IN_CNT
> registers are flushed. Relocate IQ/OQ IN/OUT_CNTS updates
> to occur before NAPI completion, and replace napi_complete
> with napi_complete_done.
> 
> Vimlesh Kumar (4):
>   octeon_ep: Relocate counter updates before NAPI
>   octeon_ep: avoid compiler and IQ/OQ reordering
>   octeon_ep_vf: Relocate counter updates before NAPI
>   octeon_ep_vf: avoid compiler and IQ/OQ reordering
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] octeon_ep: Relocate counter updates before NAPI
    https://git.kernel.org/netdev/net/c/18c04a808c43
  - [net,v2,2/4] octeon_ep: avoid compiler and IQ/OQ reordering
    https://git.kernel.org/netdev/net/c/43b3160cb639
  - [net,v2,3/4] octeon_ep_vf: Relocate counter updates before NAPI
    https://git.kernel.org/netdev/net/c/2ae7d20fb24f
  - [net,v2,4/4] octeon_ep_vf: avoid compiler and IQ/OQ reordering
    https://git.kernel.org/netdev/net/c/6c73126ecd10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


