Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173D432BC3;
	Fri, 18 Sep 2026 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750979; cv=none; b=aawmlGXKurlOHSQ224RzdF/aCqGKxFF6LTkPBS7zd+03teSiiDzLzx+6DW5QAZmW94JVihdzccOmfeWueXcHRhdDOrciTkwmvcSre19//5fcXoOCcQvZnOfquDjFIKVhacLZdW+XkamR62YCsp3oI5bHrm5/tr39xRtbY2jVAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750979; c=relaxed/simple;
	bh=PpUq25wPm/jfx2F62tUw4ZCTLMWc1hTT6ZkJwbhoS2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM2Z1LV4zrk3vywka7wr3qQ3MfksA2hEq0Y3e0IPfP6ev5KxZ83fqVhfFk/LUiNGxkTzxOO6pRdwJP5qfcVGi242vhgvJOFerTuf7QYxQNytbW+Rg2La2LpJcbHf0K5egxj3xDTEFu/MtxLYC8QZ3vcAzHRY4weH8wQ0m/ZxBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqM1BNkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqM1BNkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E8F1F000FF;
	Fri, 18 Sep 2026 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789750977;
	bh=SZZ14vgPCBujECBZ2B1QditiMj4rHjKuyn6K/jxHEWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZqM1BNkdN7ygvjf3DI1xQO8LW4R0T/Z0dMQ0AUybpQ2ZRPO6oatl/7BZj3xhWK1Lr
	 XPrexxdjYhtlGrlcFwGyR3AcV4rvNpchmz/zgG8YjWLQvxUwTkXpNI81G0h6qQ4bwM
	 ACOHz+2u3p3o3lCUWQ02nxFLL13dQzMwGlCeJcYiwPacEpKT8DhpAHxgXWDA3DSajg
	 0cRRqbHQRqbrJ6wIh8BMjtkVdZ13PVW9CtzHhUW07/Kwl59JnkbDbgep08RMBftnSQ
	 DrKE+VNY5c0D6cS0m6C6YFFuAXuO5L5AxVj2cWbwrlph2inisi+QPEYBHwyJL6zlv8
	 sKNiBgUcKjT9A==
Date: Fri, 18 Sep 2026 19:02:37 +0200
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
Message-ID: <35spnanlpb6tefiqvc4spzufecgwsikv5ruzdwzfmap4gu6pda@6yfsalrk3d7y>
References: <20260918101621.2848322-1-linux@leemhuis.info>
 <lgyho3avi65edtr4xggbsrja47cjhqbamrnmchnfh4blmyygd6@bhotovqqqubj>
 <85c50e6f-a270-4755-8576-c4ba2b961e26@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85c50e6f-a270-4755-8576-c4ba2b961e26@leemhuis.info>

On Fri, Sep 18, 2026 at 06:56:19PM +0200, Thorsten Leemhuis wrote:
> On 9/18/26 18:37, Manivannan Sadhasivam wrote:
> > On Fri, Sep 18, 2026 at 12:16:21PM +0200, Thorsten Leemhuis wrote:
> >> This reverts commit 544d85de4dc22c01badfd8cefa59829ce35c4858.
> >>
> >> It causes suspend and resume problems for numerous people, including
> >> maintainers and developers of ath wifi drivers. A fix was proposed[1],
> >> but did not get any traction, so go for a revert instead.
> >>
> >> Cc: Chris Lew <christopher.lew@oss.qualcomm.com>
> >> Cc: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> >> Cc: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
> >> Reported-by: Daniel J Blueman <daniel@quora.org>
> >> Link: https://lore.kernel.org/all/20260909055846.16539-1-daniel@quora.org/ [1]
> >> Reported-by: Takashi Iwai <tiwai@suse.de>
> >> Link: https://lore.kernel.org/all/87a4plsg4w.wl-tiwai@suse.de/
> >> Reported-by: Vlastimil Babka <vbabka@suse.com>
> >> Link: https://lore.kernel.org/all/ab1491bb-cca5-4145-ac7d-31c966abf7b4@suse.com/
> >> Reported-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> >> Link: https://lore.kernel.org/all/6257c447-788d-4362-851e-0d552bcf7c56@oss.qualcomm.com/
> >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> >> ---
> >>
> >> I'm not affected by this, but due to all those reporters mentioned above
> >> it seems it would be good to get this fixed for 7.3-rc4, as Linus' rule
> >> of thumb wrt to fixing regressions is "generally be 'within a week',
> >> preferably before the next rc". Which is why I currently plan to ask
> >> Linus to pull this directly. If this is a bad idea, just tell me.
> >>
> >> The patch from Daniel linked above[1] could have fixed the problem, but
> >> none of the developers of the culprit or the maintainers for this area
> >> commented on it within a week
> > 
> > Really?
> > https://lore.kernel.org/all/hcr4woicsnz3pbhzlguuwjlego7yli3znhjmsx4cdz66xa74zd@wjtle2yslc4b/
> 
> Apologies, I had forgotten about that one.

Np :)

> > FWIW, I don't mind a revert too, but the comment was misleading.
> Just tell me what you would prefer, you are likely the best one to judge
> here. I just think it would be great to get this resolved for -rc4 and
> your option would really help there. Sounds like you would prefer that
> fix, is that right?
> 

Yes, even if my comment about kernel-doc is not addressed.

Let me ping netdev folks in that thread again.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
