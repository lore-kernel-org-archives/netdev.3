Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C22BE7D1;
	Sun, 10 May 2026 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438572; cv=none; b=Q409Sd+w1YPUerUnUe+WEccrFQNXwMPPnpc8QhS9ujEVpEbeg3+g9Dy9LOLmwwT4RMIlMR5McAvDHlxovQk1Kyku0G9xgsx0zzE8FF88oqDwBab2+Nl8ELKZjkgj9/qMIFqyzdAdLnaVmoS8cGxqfm6pO+mC8zlzKYG3p4mTucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438572; c=relaxed/simple;
	bh=c5c2ZAL03zmKL8mHxnCnpohMbFC9CvMEM4kXlgE/Jro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYu3l3v9USJwL47YVwCp/uLXn6gyuX3XNX+tmnkZ7g2sbAKXBn+7Nm6me561/qHNQpUGaMHLdMQnfLp6E07SedVLPd58i8dws+XE6eEWCIAZF6rSZ6WzLE/h4nb5zX9uunZ1lfnBFpS2/Q2UrVr3mbbhsjCxAlELzu8Ip6V4TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8Vc8CGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8Vc8CGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92FC2BCB8;
	Sun, 10 May 2026 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778438571;
	bh=c5c2ZAL03zmKL8mHxnCnpohMbFC9CvMEM4kXlgE/Jro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8Vc8CGEduvYMQKW02kF20a0L74C51+hoXAZrmZlbx/uluKdoYP//PCKV4v5WPBsd
	 qSTzqD/9SfX2mNtpX7sdPY03ebZZAWdxawdhVUKOSK6sIDIWdEVSrym/JhYpqO3LM3
	 gNFhkxeu/9M8LAmF5fXojTv7SpeXheAUqUsBPjyFe4gwRW0aQcryn0X3JCGLASjJQv
	 B6/v1GeQJT1k+Tp0mNeUNr06t85/5q9LK8rpDkwKWjRyWdVk7eR0ZOHAcq2DQbJQZ8
	 dq53jygvu8w0tLXE4iLILZ7Df/PE4zzaHq046e+O4WvPZZFZL9QHaukUBv09QLzlQV
	 W/QMR/+39pvKQ==
Date: Sun, 10 May 2026 19:42:47 +0100
From: Simon Horman <horms@kernel.org>
To: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH net] net: xgene: fix mdio_np leak in
 xgene_mdiobus_register()
Message-ID: <20260510184247.GW15617@horms.kernel.org>
References: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
 <20260510184122.GV15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510184122.GV15617@horms.kernel.org>

On Sun, May 10, 2026 at 07:41:27PM +0100, Simon Horman wrote:
> On Thu, May 07, 2026 at 07:50:24PM +0530, Shitalkumar Gandhi wrote:
> > The for_each_child_of_node() loop captures mdio_np via break,
> > holding the refcount. of_mdiobus_register() does not consume the
> > reference, so it leaks on success.
> > 
> > Put it after registration.
> > 
> > Fixes: e6ad767305eb ("drivers: net: Add APM X-Gene SoC ethernet driver support.")
> > Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> FTR: There is an AI-generated review of this patch which you may
>      want to look at for possible follow-up. I do not believe it
>      should block progress of this patch.

       I meant to mention that the AI-generated review I'm referring
       to is available on sashiko.dev.
