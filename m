Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6F2FFF8B;
	Mon, 25 May 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730819; cv=none; b=CqI4dOdjF7kUx+1L1FA3vAWAPEiIAXSZxAsQN6r2kSqITuZIfsHBo065OlucH3Rnrv9i+/ndvWj+/2MpiIesCVoMJRyUO8zw8QIzQ3aTzPE3hFoGsAfgjlG9AjJnMf2o3qntfMKGllo3VDUCoeEEhnNGA1matq9+fjjUlZBrj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730819; c=relaxed/simple;
	bh=pVSRzBW1/YtVtSt33aZ6adleD2H+QRFV6Vfiinp3o64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pYNQPwTc5f0UNDlTinJfGL9PKibhV6qQPuq2Kah/eWAC2zD+U0uqB1ElgKZylkQ3OZLjlrdfYlTbORtl/ZTYI3tGHejDxqWeeEfG6HJGf93DRypMGupHQwHO4DUGKXE3eaAZU1hU8vItIznB04S6yqDdszg5RAbDk0rezYg9OMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzXZMRPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzXZMRPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286711F000E9;
	Mon, 25 May 2026 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779730818;
	bh=kfUPN2x28LbgLrcoScII+O1xXMTHRSdhnqVg0Iv4h2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HzXZMRPPqs8o3e+bNLb6KFZza2CCUHVinL4dq2sXdMO+pKMDrRklfKmvAnO6ugm9v
	 t/mLxHTg486dMQ6YcpuP62K2lThYW+S0sXZpD/534ocB6R7luqOAtra9EsYAbVy7O9
	 zhR0Ktzw/ivFXP4V7WQqkt8d8fAjiCZuHRJv8V757zk0loXtGTCa2HpJxLTRT0xfFl
	 yYghFY1LhcgXMFW00Ptlg7wE0oUhvJufhjaF6I9xyiIqT5QUhl1nnQt0KknP6EEKdM
	 hdC3cUK1YxKs8J7zk5FNKL9QF1gA/p7R8rSL1wgBeRG/Wnzi3ZvgU3a/DW8RdbhoZf
	 yEifhNTB2C/fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AA5380AA75;
	Mon, 25 May 2026 17:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net/mlx5: HWS: Reject unsupported remove-header
 action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973082490.3066906.4143470150331519754.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 17:40:24 +0000
References: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
In-Reply-To: <20260506000054.51797-1-prathameshdeshpande7@gmail.com>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, moshe@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 01:00:31 +0100 you wrote:
> mlx5_cmd_hws_packet_reformat_alloc() handles
> MLX5_REFORMAT_TYPE_REMOVE_HDR by looking up a matching HWS remove-header
> action.
> 
> If mlx5_fs_get_action_remove_header_vlan() returns NULL, the code only
> logs an error and continues. The function then returns success with a NULL
> HWS action stored in the packet-reformat object.
> 
> [...]

Here is the summary with links:
  - [net,v1] net/mlx5: HWS: Reject unsupported remove-header action
    https://git.kernel.org/netdev/net/c/86f1d0f063e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


