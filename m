Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73D26ACC;
	Thu, 30 Apr 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592866; cv=none; b=U3E6a1eUXt1fazljRzpDJDLWtKMvKPG/Jnr3T6Xub+2581c7cm4Xr8Ku2fVmYsTE4yqkXoYWX0LQyDZPIyx5v8Lp9CMfQeJlM/wiVhaiA5Z1cLgo9uwy3m+7oTza2k3OP4N9H56Qkdqj6q40MmsRKtEr7QfO/+/QvadA72raFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592866; c=relaxed/simple;
	bh=fNlU6nM/WQqGWO1zvYg917z+GEHG8JL+foXmFX7NqLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms4rZ8i0GTnr8L6eEt7U1hVx+BEACWMkh+rgVzq6jOasfvg4IH8byFnO8pzwFgYk0VZsAOFN6X+Ym96uXVhpqELvTKgVH9BLg1ABlASskiCpJKkH+5TYK+WqUd4ctyGNUKwO8sX4wOSuiMplHdYahosa7ISlOT3Xw6IASU+Sa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdnX94TK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdnX94TK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E534C2BCB3;
	Thu, 30 Apr 2026 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777592866;
	bh=fNlU6nM/WQqGWO1zvYg917z+GEHG8JL+foXmFX7NqLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdnX94TKgFAV2Bgg+4GvekBoaYtkII0IsjEPfVcZrE+TRa0xss1gnd5ynTM1ExCdQ
	 XSUcfi1phde4IK1FOJuQht1LrJ189wg4AZ+qBMgVNxlZq9kRjjFuEKXhWxJyq7i/ur
	 OY9PtXkP+VHVmwk3/y/i7V69jslDVOyErfFJJchFYG2otPFEPrf2f3XIuni85uTVf+
	 QlSWi5VipVDMarfcBleTtdg6JTsPyF2RWd7Q/MPWKiLRec2dhjzNSt71G8H+Hs+n5j
	 11TETs9Vpdn3kE2fGWHdjr6sOM8zT33Y5bcSeXKtnrWo35pUaggg3aJLW/4x2qFwrq
	 RFJRxwTfRrkTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 net-next 04/11] net/nebula-matrix: channel msg value and msg struct
Date: Thu, 30 Apr 2026 16:47:44 -0700
Message-ID: <20260430234744.3074612-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114910.2616-5-illusion.wang@nebula-matrix.com>
References: <20260428114910.2616-5-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/nebula-matrix: channel msg value and msg struct

This patch introduces the channel message id enumeration and a few
message parameter structures for the nebula-matrix driver. The commit
message notes that for compatibility the msg id values are fixed and
fields can only be appended, not removed.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index ff03a53b9f5d..99e1d8455e0e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -8,6 +8,255 @@
>  
>  struct nbl_channel_mgt;
>  struct nbl_adapter;
> +enum nbl_chan_msg_type {

[ ... ]

> +	NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
> +	NBL_CHAN_MSG_GET_VSI_ID,
> +	NBL_CHAN_MSG_SET_PROSISC_MODE,

Is this a typo for NBL_CHAN_MSG_SET_PROMISC_MODE (promiscuous)?

The commit message states "the msg id value is fixed", so renaming this
identifier once later patches in the series start referencing it
becomes more churn than fixing it here.

> +	NBL_CHAN_MSG_GET_FIRMWARE_VERSION,

[ ... ]
-- 
pw-bot: cr
