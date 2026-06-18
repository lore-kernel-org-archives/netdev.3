Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63C3FBED2;
	Thu, 18 Jun 2026 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791222; cv=none; b=du3sEEBewobVekBebzvYfk9rlsHITlpRlNteNkqSgyjOx9zFXl2m0S60NwJkTyPoyNuXtLuWsbeH+yRtXKtB9T800DjtSGn1qlvBwvA48oPuQBJa+ufsypEtKSjX52uWpSZBw2WAHwPFst0DWWlQvMhvvmiXv25q/ZjfRnH86QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791222; c=relaxed/simple;
	bh=NjVlpOXm6RHQOlL3ulASs3AfzNZ46gmqIVkXc7lQutk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVXUWZAEaARZm+J2ffbNk2HIlVG5fyMHO1TN5XEAxbWGJXVF1vYjGQChAjKBCKuE5HlllVhbH41v94AZd12cCXD+0Id6f+jWIt6/VLuULVb3IJMugnw8RRXlAPV/xNkve9WV/Epb0N2r34Q6Y3Q8LoPZG+Eg6uE4XyW6Ngk8Pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuCrV+XL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuCrV+XL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999171F00A3A;
	Thu, 18 Jun 2026 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781791219;
	bh=usXAkm81oxURlLo9g3M0MwCRraiXK0GggTZdNWsk98s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WuCrV+XLsoH8gca7hc6PBW0571b/7hxn6jLHzTNqu6VmqnHJ4i9KAAHbkCl9ycpB3
	 FPMW0fp77uLtetC8tEoixHehWwfUMXERhYQCLBITlXQCtKB7/LNrYFQ9ThKj4X3gtT
	 oDDZXiuVZOj9455lDVNEGenAxzy6+fY0ww6PxtnC7srqiOCa+zkzxH2wgfAcLBdcsW
	 FBVDT1fx9AoDT56qncfQfLLP447tTQNo8tgONbMqxRAmZ0ViqkdxGB0FBiYkr4T92c
	 wK2Q+GUFwimH7W6XLvwOQNNz1u3pNDDhmfoIN5m+1TN5oiIj3lKsMHnkklvCaP6/D5
	 M+leZ4/nhJlIQ==
Date: Thu, 18 Jun 2026 15:00:15 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-af: npc: cn20k: fix NPC defrag
Message-ID: <20260618140015.GP827683@horms.kernel.org>
References: <20260617102149.1309913-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617102149.1309913-1-rkannoth@marvell.com>

On Wed, Jun 17, 2026 at 03:51:49PM +0530, Ratheesh Kannoth wrote:
> npc_defrag_alloc_free_slots() always passed NPC_MCAM_KEY_X2 into
> __npc_subbank_alloc(), which must match sb->key_type, so defrag never
> allocated replacement slots on X4 banks. Pass the subbank key type for
> bank 0, and only extend the search into bank 1 for X2 (X4 MCAM indices
> are confined to b0b..b0t).
> 
> Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

