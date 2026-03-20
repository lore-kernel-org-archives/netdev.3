Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0735F600
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036669; cv=none; b=rvDfS2GXFzVVm3wSdsyVd/j6rZmWVSoHz1ac/0xIkNmELQ2UMWIpL1QLaylHiRLrRIg8Nzdin1RKpiTaPZSaqqi9azYHdjQ5jcIgCWyCSnq9Z5Tt9THcK8RT89VxQZJxZAiRm1dZUu9yeQmTYPcMYhRTFCAwz7WHa15zQ3evdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036669; c=relaxed/simple;
	bh=t9B5H/VMcIfqiAeXQ2rk4ql7kLQyXGHI4PB6+emckco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmcd/BEF1n9qv0A9OP64An4qDUxaXQvV0Ni+wh8YnL4OBEsR8eDLIdgELPanvTpZS2A+kQFpVmU4/xuSbmOYQojRENqnsaAeDzCmvAptIsoyWfiOIRiA3ngl7+ik8P7NT6q3tjMcRNyw4tHsz/tZVEH4016Nx5ObilAdozTgWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZQD51Wq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZQD51Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A875C4CEF7;
	Fri, 20 Mar 2026 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774036669;
	bh=t9B5H/VMcIfqiAeXQ2rk4ql7kLQyXGHI4PB6+emckco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZQD51Wq0om2Wvtrzk6MVzOo4jz7mM6ilPx3AstsPy1bfXYeHSw0XvXIztMkJFbW8
	 ywbvKNcdjW8vuk5QNVPFHPk1pFF2RxQ8cYVuN4wOOM+/6b/YI5ReVQFENCJYSqfMDo
	 lyH22JGkMzpQl1FQ6pkuJ9o29cmlncy2ozQBIDagco0XQtvdJ/598Y3cyyxW6kFnAV
	 b1CGMcIWI7rxdzA+8k7kiJRjSaX7YhlzLajB/M9VcuI/Ddeup6xm7WF2TGm+d0c4mI
	 wc0K4XWUcMGtKGzd8LY7Wvvrej+bAugXgPp5Vu+9mEBv9m9byNWQadyLEKdHuBWImC
	 bAlQWePinaYzQ==
Date: Fri, 20 Mar 2026 19:57:45 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH iwl-next] ice: reduce loglevel to debug for 'Can't delete
 DSCP' message
Message-ID: <20260320195745.GL74886@horms.kernel.org>
References: <20260320050548.422684-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050548.422684-1-aleksandr.loktionov@intel.com>

On Fri, Mar 20, 2026 at 06:05:48AM +0100, Aleksandr Loktionov wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> 
> Reduce netdev message "Can't delete DSCP netlink app ..." from error
> to debug level when in FW (firmware) DCB mode.
> This is not a real error and a kind of expected behavior. The device
> is fully operational and error message might be wrongly interpreted by
> the user.
> 
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

