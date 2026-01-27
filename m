Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C328CF6F;
	Tue, 27 Jan 2026 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547948; cv=none; b=GFIrjIgA8tljLSZzuo55ZsF/8y7Dasy3GphuNT4/1yGEIuhOtJm03X8xrVmEavPHc2mXvEPQUkApfRyoFGZ1/eaiuxQkg5ybPKOqnnygYxQKEOmtFjkyHPObY3BY479nAZfCPBuqS4Eh4lH+04KcM6ESLEatl1bJNSZLp3IqWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547948; c=relaxed/simple;
	bh=MGqoHIPS8t69zUOzhez5KOrD690dgNjsI9iHjaEmiWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQG5SlgGqTRHCaURyCxzUE+p7poVs9Du7jCstRZI+mCb8jtfSfL0cTylLFZVDkQTZ4asINKL56hl1oP80fI0mXmBaKMGKs4ass63T3EaRYlU1ZGiMpbA3BNRWdRkBPxh07Pyt0HkXOyzgEYXyQcZhIV+aaScd1oEbxF/porgBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow2/sAFl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow2/sAFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9EBC116C6;
	Tue, 27 Jan 2026 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547947;
	bh=MGqoHIPS8t69zUOzhez5KOrD690dgNjsI9iHjaEmiWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ow2/sAFl7zvG43BVaLg9kmbvUXQ67CaRuA6NMk/gJ+0ehZIgxcpIAZeFNTjAGnst4
	 swwRIHlmZ6BGTR9J7DxgoR0dCPDaAO0kFd/Mi52/k7xltAjtIYW5SbK380Iwe4Cquq
	 vpxvpcucEnY0xEjtm3hF/zUMZqH/msn0Ywphc62ku5BhpAZjUVPsiDLJCDJptdScih
	 eQXnQLPCKOyV9Ufou/d8RQ2DV9GdSh8bGrLM0J4R+wMWy5FBJ4p488d1CJywXOQA/n
	 8/tysB/FU8V2sGBIs0kT0Q594RSi8bSkp3O0ZR1J/d+YYAxWSmzwy6ypGysyOgV2Qg
	 C78tgvEg9GiJA==
Date: Tue, 27 Jan 2026 13:05:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jianhao.xu@seu.edu.cn, kory.maincent@bootlin.com,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v3 0/3] net: liquidio: Fix memory leaks in
 setup_nic_devices()
Message-ID: <20260127130546.7f53b313@kernel.org>
In-Reply-To: <20260127151241.1144039-1-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 15:12:38 +0000 Zilin Guan wrote:
> This series fixes memory leaks in the initialization paths of the 
> NIC devices.
> 
> Patch 1 fixes an off-by-one error in the PF cleanup loop. It ensures
> the current device index is cleaned up and correctly handles the 
> post-loop devlink_alloc failure case.
> 
> Patch 2 fixes the same off-by-one error in the VF cleanup loop.
> 
> Patch 3 moves the initialization of oct->props[i].netdev before queue 
> setup calls. This ensures that if queue setup fails, the cleanup function 
> can find and free the allocated netdev. It also initializes lio->oct_dev 
> early to prevent a crash in the cleanup path.

Coccicheck says:

drivers/net/ethernet/cavium/liquidio/lio_main.c:3769:8-9: WARNING: Unsigned expression compared with zero: i >= 0
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:2215:8-9: WARNING: Unsigned expression compared with zero: i >= 0
-- 
pw-bot: cr
