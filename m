Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3B223DFF;
	Mon,  8 Jun 2026 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955256; cv=none; b=ktSMkLUhfuxdG0gGAGHLrjHPDz/8bfIK+Ee+cyX9/5Zs/XAbkHCO4vgoF6HJfxIK5DFi9lMZRMDvzYERAQueJr34kUjswnnv5bDPqmeMzYQAAT4av2lirk2cgPg6UGDtKfFt7j3VtJn56rJoB4fzi6injOFzOm/ejhigDSU8pzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955256; c=relaxed/simple;
	bh=ZyRpuVX16kKMoS1mAKp3W3ccdVbgqYPYlye8Jzwnp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZS18bKTIR7aTsaYmpjZBiDGgKC9a9JdmErNkuSfvzdi7/KCfGmwUS6G0KcCt5AY4dLmrro8tWfSEs/shWcJR87NiBkmVC3cD6pTKF305g0P7V3yxx2+G1UjeWdNrvOZHu98OBk912I4ARJPd13u/Z9xM08K6WESkH+i2CECbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp7wFb2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp7wFb2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A41F00893;
	Mon,  8 Jun 2026 21:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780955255;
	bh=2Ws7SCqGd9yTZpOF0W/PLej9DkeY+2Y3ZdgH5+m9bDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qp7wFb2AeUvKYTZSkHQwcPPUhoxifCDu1syESAtMKWhWRYyhWPNEd+xoLC9UAAYhX
	 SHfsUcNl8cFfZcYWDM11TeABywIvCZ3rYuq+erX7lLay1Gv8H0sSdKvBcfr/F/OWgO
	 TXT6uIHtMzD9E5rdClswYXAm3XMQB6wyWILcGmNDSOrI7ojIxiyIKO9qJiYSZnw4CY
	 X8gSSCbiXkB/3ZfdMWg0E26elrVjkxvRDJYeqWRlywhfx9e4P/dKfCTHEHdo/SQfts
	 4JYwDFs8ULEa2F8lU1gF9g1sWHzVeKfpgvGsfzfTbXgmxZvIxHyu5kmBEjeEcOGZc1
	 h/XiEIu8C5qnA==
Date: Mon, 8 Jun 2026 14:47:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/7] r8169: add support for new interrupt
 mapping
Message-ID: <20260608144734.5293f6e2@kernel.org>
In-Reply-To: <20260604102733.1582-4-javen_xu@realsil.com.cn>
References: <20260604102733.1582-1-javen_xu@realsil.com.cn>
	<20260604102733.1582-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 18:27:29 +0800 javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VEC_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.

drivers/net/ethernet/realtek/r8169_main.c:5168:6: warning: variable 'tx_done' set but not used [-Wunused-but-set-variable]
 5168 |         int tx_done;
      |             ^
-- 
pw-bot: cr
