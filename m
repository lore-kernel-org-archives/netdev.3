Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A2197A7D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929080; cv=none; b=QjdX+vwi0TY2kbG+mNf982xIk4ZjKi4zAXfCH0Bu/2g7k05Aoy1N63ro4/Auxc3W97PAbevFavVbUBf3smWGhFolz9f6kSgB7K7pAedcPP8V9ex2doJpXL8od+YosJKxRWVqOH04i+GRPZfc0k/inx/pIhh1fGP29K81dfX9EyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929080; c=relaxed/simple;
	bh=eHBD2YwjcGL2Kupke6osxp+ZsQKJLogIiYNcVD0QOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElIkAjwwOMLy3eIWNz9S7MBbh1lB5HF0k9FFXRF8/MOWg135Yb6gXfqRuez5lOJjY5wbDAwK76jzyqW7V4HraROGm3Pn2chyl+qJqMShiXD7gShvySguHGBqGuT/HsJGdXyuhOC7xzzpK4WuO2M1V6fPNMC7A02p08PETYRtz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvMjeoxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvMjeoxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B491F00A3A;
	Thu, 28 May 2026 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779929079;
	bh=0GhPTDPLy3t0sp2Ls5AKQu4sV/wdA0f7m/trx3B/a6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jvMjeoxHI8wy4vsHF2LmDDbzsuWzjO01t1ykvDmdOFm3kvOHBDBuKI9jx4WAP+0pK
	 PgF/bu58dXUqenIYMwUn4DQucoLgImP5Cdw+yZYNKxRC6ACGmEXh0rH1OLjjHEFXRT
	 1Dy/4Ly7rzUBTuQXK+2gFxKdd9YVZD3bD+lubGZU7zCb/w27gaBI2ZnsKAvViJqEtH
	 rkOHFPPwMtRBynE5V9/gbVnHkvXt45TaZrapU5b2qnxmdF8SmwXMoIwFoOe10sPUPe
	 liiIWtd9BO2W12zPwRD/ZCnBjdAYkga/NqVrn5KDQ+wHps4sdcDbhxB5WfjP4bSHWT
	 Fq4aE+6qEtclw==
Date: Wed, 27 May 2026 17:44:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, richardcochran@gmail.com,
 yangbo.lu@nxp.com, kuniyu@google.com, willemb@google.com
Subject: Re: [PATCH net] ethtool: vclock: propagate errors from
 ptp_get_vclocks_index()
Message-ID: <20260527174437.5b48187d@kernel.org>
In-Reply-To: <20260526153650.2779821-1-kuba@kernel.org>
References: <20260526153650.2779821-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 08:36:50 -0700 Jakub Kicinski wrote:
> ptp_get_vclocks_index() was written with sock_timestamping_bind_phc()
> in mind. Any return <= 0 will get converted to EINVAL by the virtue
> of sock_timestamping_bind_phc() not finding a matching vclock.

Sashiko points out that dump needs to skip over devices without vclock
cleanly. I'll respin.
-- 
pw-bot: cr
