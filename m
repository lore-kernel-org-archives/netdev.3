Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8526AA91;
	Fri, 17 Apr 2026 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436976; cv=none; b=Tb03SsoJPy/q0uwRL5P4CrqCo0yu28EIlmUi9jGiq3LwuSD9LnFtYSkdtPmjBAHmgve4f2j1/Pz3OgjMIYtNXkEwJLDSNYbAhRz9dcZY3CGJSkgNJaEP0PvNWfeqJyIBHZXhd9411vMJ1B7P7bdXVps6LlNKoUfko0kUV9ym2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436976; c=relaxed/simple;
	bh=8KFLICfcE1WXv7AuEFY/UpyQ2o9z9BQQPKpgSn0MhMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AssHRk1uf0mlysw4X4I3FKRZJAypT7Wt3TlnNHOTQIj8D8WTZuRIenKx0VkOximuZ+LiErYL/gYW17OwCNzb35N4rdvikBt621XrVPJj8O1VlbkhZ33XuBCPv9ETnyMBPT/wP8C/1LXQ/iN/Cl1IfhT/eTj3FK0vOEhW0NPUdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIAFWcVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIAFWcVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104B6C19425;
	Fri, 17 Apr 2026 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776436975;
	bh=8KFLICfcE1WXv7AuEFY/UpyQ2o9z9BQQPKpgSn0MhMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WIAFWcVXiEbDNV/6pUvNtUtYCsdfPyaWnpZ+S3N5zWqFzb/QmJgUaL6I9xFAF+wK2
	 Z54YIVaDfSvMCxDl8vxpme7FsyqO7IVO6MBiLtkHyUsI09/9bRZQNPGS6YYnT3y4AM
	 oZkmyy34C1pPVUmS/R613dS/oKlsqMZVusZCT1JwsroKww+C6z4pQO4U88e7CYmUGV
	 IupbU0MfnuZtzupGV+i4QYiXkmHQiukaG6xQTLvpKPJBBBQYKz2m6pAbqJWXuuO6ni
	 lvXkXLqlS1G7l4ouvSLwT+32p044zs/SqVjO2wv9pQJYYuDCovpNNlOGKytgbKcBnH
	 tkhosNTWBfhEg==
Date: Fri, 17 Apr 2026 07:42:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com,
 bhargava.marreddy@broadcom.com, rajashekar.hudumula@broadcom.com,
 ajit.khaparde@broadcom.com, dharmender.garg@broadcom.com,
 rahul-rg.gupta@broadcom.com
Subject: Re: [PATCH net v2 1/2] bnge: fix initial HWRM sequence
Message-ID: <20260417074254.42f01fa7@kernel.org>
In-Reply-To: <CAHLZf_voEPTrfkuO6pJcchaQaOqJin8m7j-+hwMrjJcGFmJv0A@mail.gmail.com>
References: <20260415151621.1104956-2-vikas.gupta@broadcom.com>
	<20260417022201.1807745-1-kuba@kernel.org>
	<CAHLZf_voEPTrfkuO6pJcchaQaOqJin8m7j-+hwMrjJcGFmJv0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 11:46:08 +0530 Vikas Gupta wrote:
> > > -err_func_unrgtr:
> > > -     bnge_fw_unregister_dev(bd);
> > > +err_free_ctx_mem:
> > > +     bnge_free_ctx_mem(bd);
> > >       return rc;
> > >  }  
> >
> > This error path appears to have the same regression. If
> > bnge_hwrm_func_drv_rgtr() fails after bnge_func_qcaps() has already
> > configured the backing store, freeing the context memory directly without
> > unregistering might allow the hardware to access freed memory.  
> 
> Even if bnge_hwrm_func_drv_rgtr() fails, it is still safe to free the context
> memory at the host because the driver unloads from this point.

Looking closer, indeed, the way bnge_hwrm_func_drv_unrgtr() is written
the AI suggestion is pointless. Hopefully you're right cause debugging
FW corrupting host memory after reboot on bnxt is not fun.

> AI reviews appear to ignore logic related to handling context memory
> in the patch.
> I see no valid comments on the patch.

Why is bnge_func_qcaps() allocating context mem? It may be the case
that context mem has to be allocated but bnge_func_qcaps() doesn't
sound like a function that'd perform such key part of init.
Why not just move the alloc earlier in bnge_fw_register_dev() ?
