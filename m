Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88955172D7;
	Fri, 18 Sep 2026 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749495; cv=none; b=FF9cRNLnoBnm9D5bCiLS0JJ/ZGtntd92Go88skoSGn0UoQ2j3UELczujhnYUfrqsMDqvSqGNF0iqbJ+yW2Ohb2Lkrapws91aO4QwxRoihYvX/T/6h+SUYJd6eEbbVJl7vuqj415XbxVBiVTRwhMDKAs63WPHxbAks7NiIfJyoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749495; c=relaxed/simple;
	bh=QLRvLTdFBHVr7X10cKNaAGFOnTS1+KBvwf5jbrECKU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsgY7K/6V961lgYz3NzureXQ+6qjVIv0Ya+lRo7tx+fgcUVDgHPHocJt6srSao7MZYd7bfJ5pwi+/GW0sTiVe/RXQfBhicqSRJ67eyKFmUkb8oSgHzSGZmE24OGCcx6pE6RCgzlEC72YxNsCM0GlBVwpoCp4VfX+iTsKld866vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkRD28H2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkRD28H2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940151F000FF;
	Fri, 18 Sep 2026 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749494;
	bh=1jguSdZKVQAzVJWlUAqUKfAANJh6/U827CisOt7PoEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JkRD28H2C6Q6mO9N1fNjEs9X5ijRGwgAs+3y3CS7zBTPr4yNaUyaUviLNj9Ox1EZC
	 LVTuu/+cv0rV00CarPU8rZtBj1D3Mluxs/wijbgxpTrjZBMm0o3ewr5PaDSCvEbiiw
	 og4wtspCk2K0p6DPPk7VMaL1+ICBf95PxuCc7ZlA40JmXtbkYpjtoZyXbhTDqS4IdB
	 TVuaZyuwvD0z7Wj66Qf/yfBxgZC7Pvdj3V4lPEg4qWr+ER6Raxa+bx/SPtY49/dUdz
	 cdZ8HUzyHJHHd0648e3W1K6U7iUNy+tXYGh7j5+oWBtXJe5IMe5TJLqXZgS5D2No7Z
	 Ow4voCum2bHMQ==
Date: Fri, 18 Sep 2026 18:37:54 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Chris Lew <christopher.lew@oss.qualcomm.com>, Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>, 
	Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>, Daniel J Blueman <daniel@quora.org>, 
	Takashi Iwai <tiwai@suse.de>, Vlastimil Babka <vbabka@suse.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH net] Revert "net: qrtr: Send HELLO message on endpoint
 register"
Message-ID: <lgyho3avi65edtr4xggbsrja47cjhqbamrnmchnfh4blmyygd6@bhotovqqqubj>
References: <20260918101621.2848322-1-linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918101621.2848322-1-linux@leemhuis.info>

On Fri, Sep 18, 2026 at 12:16:21PM +0200, Thorsten Leemhuis wrote:
> This reverts commit 544d85de4dc22c01badfd8cefa59829ce35c4858.
> 
> It causes suspend and resume problems for numerous people, including
> maintainers and developers of ath wifi drivers. A fix was proposed[1],
> but did not get any traction, so go for a revert instead.
> 
> Cc: Chris Lew <christopher.lew@oss.qualcomm.com>
> Cc: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Cc: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
> Reported-by: Daniel J Blueman <daniel@quora.org>
> Link: https://lore.kernel.org/all/20260909055846.16539-1-daniel@quora.org/ [1]
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Link: https://lore.kernel.org/all/87a4plsg4w.wl-tiwai@suse.de/
> Reported-by: Vlastimil Babka <vbabka@suse.com>
> Link: https://lore.kernel.org/all/ab1491bb-cca5-4145-ac7d-31c966abf7b4@suse.com/
> Reported-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/6257c447-788d-4362-851e-0d552bcf7c56@oss.qualcomm.com/
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> 
> I'm not affected by this, but due to all those reporters mentioned above
> it seems it would be good to get this fixed for 7.3-rc4, as Linus' rule
> of thumb wrt to fixing regressions is "generally be 'within a week',
> preferably before the next rc". Which is why I currently plan to ask
> Linus to pull this directly. If this is a bad idea, just tell me.
> 
> The patch from Daniel linked above[1] could have fixed the problem, but
> none of the developers of the culprit or the maintainers for this area
> commented on it within a week

Really?
https://lore.kernel.org/all/hcr4woicsnz3pbhzlguuwjlego7yli3znhjmsx4cdz66xa74zd@wjtle2yslc4b/

FWIW, I don't mind a revert too, but the comment was misleading.

In any case,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
