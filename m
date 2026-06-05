Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8640B360
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702778; cv=none; b=FvKMyi47W/CChBzOpZEXI2dyl3sD/6skz9xVNfexq6nDoXPyLKg2pufSp40ie8vxkAR8qX1Y8yxTBnVbY8KRKX1umvTzUgmiBhyP3y24bo6j3aROo3KMq5OuxurxRN/Wq2HVJphQr2gHhlZJCy7oLtwaRLF4DTTk6VrNQo4Kht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702778; c=relaxed/simple;
	bh=1m5DMUHMutsRulgLy1wQ+Vt+ivcmY4xgriwPalShQBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATE4PwrNVyrU52ZijFEuFaPMKNgK0SNHupefmZzhyWypJn21WYaqWWJln5Pq6A+A8W4A1IMOKNYgl3eMCP/z7W3AWKRXdIQsBcEjZzq8qpABUb7TEEU1JXVmXM658vIVsEAnMP6VKVS8K04uQ3i9W5rUGM3QVNHjYnWzJHoDiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM1eTWM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM1eTWM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D032F1F00893;
	Fri,  5 Jun 2026 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702776;
	bh=AQq9czar8AbipDD8eVbqtXsxiT3BezSjgfZW2+6o/pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aM1eTWM1nLmjy82I0KXtiq/od/OIE0nd++u9w31jqsjI1ngIJi3d4Ay2ejbmQxqMn
	 +cvz0YlLgFbna4hSwkQzVtea05wwHmlT5oZiweATHROmU3zBxk7INB6pQjfVbF4W4A
	 n9iCn5OWnYvsrr6dOPlWm2+P+If2jgGiRHOH4QHIUPm57K2NONwF6PS5YXlFzDbXVs
	 IgcicS1wg9wceXn3zo19pWxpUfNLJbulKOfx1Uomi0KTNj8OMCOvNSLzYd5f+IOUnw
	 CrlDQf0m6nux2brotkHXPSsf/Y3AhOh8x/bVRf1uDP4DoiSz++xrLXEzBKGjtQabdn
	 tIOeMyZFm8gBw==
Date: Fri, 5 Jun 2026 16:39:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <poros@redhat.com>,
 <arkadiusz.kubalewski@intel.com>, <przemyslaw.kitszel@intel.com>,
 <horms@kernel.org>, <aleksandr.loktionov@intel.com>,
 <pmenzel@molgen.mpg.de>, <sx.rinitha@intel.com>
Subject: Re: [PATCH net 1/3] i40e: keep q_vectors array in sync with channel
 count changes
Message-ID: <20260605163934.547c7bdd@kernel.org>
In-Reply-To: <25ca3a21-7d29-47e8-a0fb-5fbb7ddfea99@intel.com>
References: <20260602225513.393338-2-anthony.l.nguyen@intel.com>
	<20260604012707.2843206-1-kuba@kernel.org>
	<25ca3a21-7d29-47e8-a0fb-5fbb7ddfea99@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 11:01:19 -0700 Tony Nguyen wrote:
> > Should the new err_lump label, and the existing err_vsi exits from the
> > two allocation steps above, instead unwind through the err_rings block
> > (unregister_netdev / free_netdev / i40e_devlink_destroy_port /
> > i40e_aq_delete_element) the way i40e_vsi_setup()'s err_msix path does?
> > 
> > The pre-patch code had the same defective err_vsi target for the
> > qp_pile and arrays paths, but the patch adds two new failure points
> > (the unconditional q_vectors kzalloc and the new
> > i40e_vsi_setup_vectors() call) that route into it during reset
> > rebuild, where vsi->netdev is already registered.  
>  
> This does seem valid, but as mentioned by Sashiko the pre-patch code has 
> the same target/issue. There's a recent submission [1], with changes 
> requested, that should cover this. Did you want to take this now or wait 
> and have it sent with this other one?

Hm. I convinced myself yesterday that the old code did _not_ 
have the issue because it was pass false as the second arg to
i40e_vsi_{alloc,free}_arrays() ? Good chance that I misread,
it's tricky code. As much as I would love to apply this to prevent 
the deadlock in NIPA - let's wait for the follow up. I'll pick up 
the other two patches from this series off the list.
