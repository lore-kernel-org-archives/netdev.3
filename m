Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7546EC61;
	Wed,  5 Aug 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933494; cv=none; b=FQ2jVtBf6CxjLNL13QywY3kXdNffo2TIGUbTDp7p0PiSa+gXsk3LTiCCXfEUvFUhuQaCipFynpiBtxEHpzJp3mCXrRk1IYBv1uemnlAiDGFU0Sbod82hTO+IuoEjovnYfr5QaxUP3ZD209ZkSLsUKndtR6MxCDq2GTTrUeDbKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933494; c=relaxed/simple;
	bh=pbRWr1+k/Jed7Vv5KHccLLn5dWDoca7aLP3d0+lSc/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNsZ1j6jS3PduIKDXyETSeLurwYI1iGtv/lgVmss1bJlEg0UIdSHnd14aYTEwCQoYJZGaOjjjLQrSgAwCGto79bJxlSPwQUidOH7uJ3QAf4ks5C1OdeHqblnGq/F1lSCwHWw6KjxSL4KWWk7uDTnU/ksFrcIYPbh7dykBL08LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv1TjCUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv1TjCUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980EF1F000E9;
	Wed,  5 Aug 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933492;
	bh=NhSLhPizo/ipc9ZTmrz7MLzsobqy+AL36Zzzlytq9SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xv1TjCUJgX4vsOnDqiUA7a9U8Z6ow0njKD7vozCJOgIVaRhmShv83EnFkQ4xfNcON
	 HVqdArqANl3fbBbY3hovsok0RtqI773/x943GLCIwB64Q7WQpLYzQVlS4w6zKJfSJE
	 z/Co9IqLCEzERyyhsQM4S0jeg/YGJqKS98KScCWOfZr2HKENGaWLpb3z7SjnyKrXbv
	 HuUH1O/+f8nepiFLeiWXT4pmJsknv91I1M6vP3p8KeBlgIvMd6QrKXcAEmWLknhFdY
	 xlBqc5vb0Hl1sA9oEKxzXjf4ohxQIpLc/EkVTXRTEYiMcvfyj/8cbLaNoH9BAx/XZv
	 nTC3vKB87pvfw==
Date: Wed, 5 Aug 2026 13:38:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, ningwei15@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: add myself as a maintainer for
 Hisilicon Network Subsystem
Message-ID: <20260805123808.GT51943@horms.kernel.org>
References: <20260804130554.871716-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804130554.871716-1-shaojijie@huawei.com>

On Tue, Aug 04, 2026 at 09:05:54PM +0800, Jijie Shao wrote:
> I am already listed as a maintainer for the HNS3 and HIBMCGE drivers,
> but not for the broader Hisilicon Network Subsystem entry, whose file
> pattern covers drivers/net/ethernet/hisilicon/ (e.g. the legacy hns
> driver). As a result, patches to those files are not CC'd to me.
> 
> Add myself alongside Jian Shen to help maintain these legacy Hisilicon
> ethernet drivers and ensure patches in this tree are routed to me.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Acked-by: Jian Shen <shenjian15@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>
