Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5721A6821;
	Fri,  6 Mar 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807080; cv=none; b=s0faoZUXWZPyNQeEJONgmrqN0+6JIH5fMoKg390eOFixnNIqyXr3ek5HqTTnSpf8mZL7prLN7CJsEYi3vCzXeHxKqhJoBjciN3DX/sHmT1coKSznHy9Pmkzaz3rQ0cnZpQkuOQ7RmrBg5DFaNZV9c0LgVd4E3zLuxSWIynrlpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807080; c=relaxed/simple;
	bh=rI4ryq8KZf+a00K5dlAbYNQ2TI+H+3gBJALRx1ZwXsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2Xz0Vj5Az2K8rEJd+XqjPaBUPuBh2OD2HZIdbWueed/r1fYFXBlZQkWESXVBqTMAaI5rFdjqhA8pI1B9Svid35CJ1ePCkOqmGH+kcj4uA3UcRBFBr6mjTy4exwSPL8afo0ywLXYtjFagf66ol2vHMUoXVugtKPvBg+A0FjD05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzJm0ows; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzJm0ows"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30031C4CEF7;
	Fri,  6 Mar 2026 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772807080;
	bh=rI4ryq8KZf+a00K5dlAbYNQ2TI+H+3gBJALRx1ZwXsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzJm0owssArBal9Ng5DRFON9urN/z8qjY5QUDsjqOEQ8S6xXnNWe+4LA+Tnq+L6Rm
	 wjGXGRpD/v/tadNlqPkD02di1aRAYJBAlyiyoNfwlq/1/c3O1rNB2enhMf/bsdvtDw
	 7XDM7Vj9CmuP5zZEUdMnssK8C2yjGHD5jtKv9zIDq8dxrMdtkLiuIa5oTqcFkMyfGJ
	 +wyXzdI7Kg5sYzuL/IagHlsVQpvX8Mzre4BLr9uc2WwfA/gDjQjPiQEU2qY+9fqMQK
	 5yANEzEtVx61P5kR5USNWNV1473D2qkhdnKL03bfoCMkVRYNBoE7oxHtaX5qoMKIiP
	 2IiTYJ3RY0OcQ==
Date: Fri, 6 Mar 2026 14:24:34 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com
Subject: Re: [PATCH v2 net-next 3/5] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <20260306142434.GF461701@kernel.org>
References: <20260304043032.3661647-1-rkannoth@marvell.com>
 <20260304043032.3661647-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304043032.3661647-4-rkannoth@marvell.com>

On Wed, Mar 04, 2026 at 10:00:30AM +0530, Ratheesh Kannoth wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
> 
> Add a runtime devlink parameter "srch_order" (
> DEVLINK_PARAM_TYPE_U32_ARRAY) to control the order in which
> subbanks are searched during MCAM allocation.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/base/memory.c                         |  1 -
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 87 ++++++++++++++++++
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  2 +
>  .../marvell/octeontx2/af/rvu_devlink.c        | 92 +++++++++++++++++--
>  4 files changed, 171 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index a3091924918b..88762061e0a1 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -97,7 +97,6 @@ static void memory_block_release(struct device *dev)
>  	kfree(mem);
>  }
>  
> -
>  /* Max block size to be set by memory_block_advise_max_size */
>  static unsigned long memory_block_advised_size;
>  static bool memory_block_advised_size_queried;

Hi Ratheesh,

It looks like this hunk crept into this patch by mistake.

-- 
pw-bot: changes-requested
