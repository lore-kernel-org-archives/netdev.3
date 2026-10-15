Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37138503BF4;
	Thu, 15 Oct 2026 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060826; cv=none; b=ukQuem6EibuWM56d1D7aJfiVxidGubg6rvur8/yJNLcJOSXNZay5t2Nk0AV0ND97CjtjGX3jCxTDKtbACMcsS1Q0funvxyy6+p/wckert3GiyrjuSiiqwTmVguJ4c7hoZPBIBbO0lmkZ7El4X8Ox2ETpQjIiRkas57ZOwnVDCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060826; c=relaxed/simple;
	bh=6QnLYhTuITx1Dvbnjsv9kmV5C0rki8dpp8VFdnDGLZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mf3RQYOaLcgJ2DVPPW/i965j8yu9V1n+sOxtgy6sxe4hexywsQH4+tlTpXV5FiaiMPq16yqrbJMBGMPNJZNjOvln7u9sqWK552egNai0QSDfGVwHJQnPhdIu9OzVyN8IoABJzRQb4AAq/5ULEA52nMxaaUTj7iLJZSWdAtkIQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx2QYl0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx2QYl0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9251F000C4;
	Thu, 15 Oct 2026 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060824;
	bh=9y/dCGag0YklyJ0+G8qH9kDNVYd08PFkR4SRAnALcEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mx2QYl0QC8m9TsHbuGsSswjPidDOuNnXwDlR/CEfMFtn3SiHHbs1wE/UFrhlI1r5j
	 tNzlrwJKGb9qK5Dv9F/7fqQ/EYDgBAVp6ZfTskb80PG10q76u5RMAaQTl3GTNh53X5
	 zjeFfjAE2ccxY9lHeB8VK5OAaRi8nmnMpT+OnCUJuSGmpl31HRMJTtnSFMzsK8baZW
	 KUoTBojZEvsTCsejtwT4FEPQW8XMAaWmpjKPEjAw0sR7mR+kwVFk2qSeBCDvRnDlgh
	 l5oriCnDSwUqgF2v6ggSrJoqisNo4FC6RSsfj53/vVmqMmp4d84xms3ZuDbECLYUL9
	 /cwIar2JCpQlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4467392EA58;
	Thu, 15 Oct 2026 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: ethernet-controller: Allow
 "ethernet-N" node names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179206082337.3345829.7874654486393814216.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 10:40:23 +0000
References: <20261009155444.2347045-2-robh@kernel.org>
In-Reply-To: <20261009155444.2347045-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Oct 2026 10:54:45 -0500 you wrote:
> The HiSilicon hisilicon,hns-nic-v2 binding uses "ethernet-N" node names
> as there is no "reg" property and multiple instances. Add support for
> this pattern which is a common pattern on other node names.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: ethernet-controller: Allow "ethernet-N" node names
    https://git.kernel.org/netdev/net-next/c/d8839381c196

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


