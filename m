Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577D376A0B
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073285; cv=none; b=QkfACqoLoGjw8nb8XssdlBABfen6tww3KGJGH+4RoCT+/sWElO5enlalgCRE7QNxdnMscoQP1oJDsF8a/XlEs1SglNDQ9vzENBkMRyVvh807DPLfPb7H1avHVtafO3q13V426DsGtvN7afTn0SzwaWXDuh2NC+lbAQS1Wib6QG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073285; c=relaxed/simple;
	bh=DfU5/K1gFPhgXQnFFHykVAYXXONzFxPNREb3odRx9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIBPzctqhQu9KSMWbj7BQsVuumtiGiyi0Z32xKIe53wOfgQaHqTAM3C6ZamyZbXr4UZZmg55c/vXX7QCJsyhfErAQiEUoKUxPIW4Zul9MFSYjWNZ2ocMhng2yksNvui5+jLVCq5bMFPT2XnEMYFztnOuXjacYv/jzU14QOpgwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH8WJulS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH8WJulS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7980A1F000E9;
	Tue, 18 Aug 2026 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073283;
	bh=zR1ZYWI2XJgx4QJsRWIsO0y+YllMBbdSPeI+8KRcsCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jH8WJulSQWbzTDipM6v7B+LiGOaL/RrkSMYfP+vLaRF5v5eE8rBU91xVUaSS+asE/
	 QsgRK9QH+33rHpNKtDXYqIWnL2vNpUpN/tVlx+qVICnFAxL+KnX77J+GN2Kx4XWYM6
	 +Ju+uqsr7UnexkUetmgxoskAOsngD/z5POZIwk6R2KKtus/8ldpwzNREuJI82R5HQJ
	 ACbMjowRHMPNxAzBKfFb9nX/8saR/y9ofHz0NeNZ3wNkK2VSNlSrdb5fj5YGBGbobv
	 54QEuGT6ocSD79g1I8lgT/QAvX8fMpQF9XhIvP/6R1Ge027RdZ9NDlkpbXbCxILNwy
	 ZZWCaR4QblHlA==
Date: Tue, 18 Aug 2026 10:14:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] tipc: limit the memory pinned by incomplete fragment
 chains
Message-ID: <20260818101442.15dee2c4@kernel.org>
In-Reply-To: <20260818162634.95D8247D950@smtp.subspace.kernel.org>
References: <20260818162634.95D8247D950@smtp.subspace.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:26:34 +0000 (UTC) Chuyf26 wrote:
> Subject: [PATCH] tipc: limit the memory pinned by incomplete fragment chains

Please don't submit any more patches until all patches you posted to
netdev@ were reviewed. 
