Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461F265606
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678437; cv=none; b=cRDz+7DTs7/dfNYsziN2DpoE5D4LIWfVSx48KNaprU71IakE62WxbcVkVOgXBv/l6rdWiU14uNAQR77gIliTV/N7J+SgSpIiCt7b1GfclojPqVIkjWdAE+ICZPOuC2bFDDoHxfH3XbZe3sgDEpnTjFN+gdFSyfNd8nQCQRC2i9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678437; c=relaxed/simple;
	bh=nebmuNBlQfivwWr2vXL7zALhKYqUnWIfNHixePoUBFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZkObYbRE9lJn/UFlTBms5wj2Ikzh5oSCv6F8iXrSn18WP+sutf05bwEI43kL82dsefJTUtoBUZmCXmDKhRHINrdbBYGOlkzGIOVrLOy9LNH/cHJ73ySZs5ONSaNeJ7BXv93vGqQ0IucDDMQ/h0E+0kPGQ2wwhLLzoWlspr4nBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toM3WnRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toM3WnRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BEBC4CEF7;
	Thu,  5 Mar 2026 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678437;
	bh=nebmuNBlQfivwWr2vXL7zALhKYqUnWIfNHixePoUBFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=toM3WnRZqmzSXoewL5zceJmJamZB8JsbCT/MQ3Ku7pcjh058hrbrjXpb/CW306J6U
	 qhWmMzMAd4kHZ8On5KYJz+8t55uUQzel5i50Ah33oW2wA/Y440+XAdWOzb1ovO+NPa
	 kHwhCKzEPTCLwRbOsgxTYUQyZuFvKGdTEaKIP2tjHLp01YDhxq85bxUZxwiQUgs3sK
	 R+aK18B37r3GKeSDG5iVwgLhSjmAsBzjRYFEx/HuoySj0VHXyJG/Rn8tSQulcH46Lf
	 e29QSVOyYx2FRgLbVWn1cQs5vUnS5S+ryjLm7Es5z9KEOHA9nrK3X/MoqXb3PCmCGR
	 yeRNE+b44ydKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA83808200;
	Thu,  5 Mar 2026 02:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: openvswitch: clean up some kernel-doc
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267843754.2487871.12321677190144402614.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:40:37 +0000
References: <20260304012437.469151-1-rdunlap@infradead.org>
In-Reply-To: <20260304012437.469151-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dev@openvswitch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 17:24:37 -0800 you wrote:
> Fix some kernel-doc warnings in openvswitch.h:
> 
> Mark enum placeholders that are not used as "private" so that kernel-doc
> comments are not needed for them.
> 
> Correct names for 2 enum values:
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: openvswitch: clean up some kernel-doc warnings
    https://git.kernel.org/netdev/net-next/c/39ae83b0f557

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


