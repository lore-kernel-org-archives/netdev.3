Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40532B99F;
	Wed, 20 May 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275935; cv=none; b=lDb16mdidCu75xot6LhTCnjNht6PNGjYX4SoesiIu6KDqujI8invNjHx64qYBPG1hyD1YuB/ZC+PtaFooSkr0pTRSDq/PeSbCgEhj73zzrFCdPqbJZyV2fXLpsr39Fsr+CGeK5skbIcg7NFuQ7Y6bm5KUUVGdQOyX1rTC8X2BRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275935; c=relaxed/simple;
	bh=NsQIu3gfs8SIQBf/LMYuZhVBwHZNGeQTOmrrOhUBlfI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=OeyjPLmAeiXYI2pDgLzMknGcGcY354YDTp1qyD7mzL4xKW6JRhXiiwyjdgFbp08Lyv39ItRS0FI5nbrGRKnTSKkdDz32z+Hl3X32JKQ9qfXaGP8ZEFyn6lm6/3aOBn1E2gb6XBMI3YMoUrzUJj4iXVFbSm7zjY0E5431BopNaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C555B92009C; Wed, 20 May 2026 13:18:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C163A92009B;
	Wed, 20 May 2026 12:18:44 +0100 (BST)
Date: Wed, 20 May 2026 12:18:44 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
Message-ID: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 As per the previous discussions[1][2] this patch series brings the 3c509 
driver back.  Picking up net rather than net-next as I consider it a fix 
to accidental removal and so that any downstream users do not suffer from 
disruption when using released kernels.

 In the course of making the coding style changes requested I have come 
across an actual bug in transceiver type selection code, where the old 
setting is not masked out before ORing in the new one, causing no change 
to be actually made in a requested transition from BNC to AUI.  I guess 
this code must have been executed exceedingly rarely, as it's always been 
wrong ever since it was added in 2.5.42 back in 2002.

 Therefore I find it not worth backporting to stable branches, however for 
the sake of appropriateness, in case someone downstream does want to have 
the fix, I chose to apply it second in the series, right after the actual 
revert and before code clean-ups.

 The remaining patches of the series should be obvious; see the respective 
commit descriptions for details.

 Please apply.

References:

[1] "drivers: net: 3com: 3c509: Remove this driver", 
    <https://lore.kernel.org/r/alpine.DEB.2.21.2604240004280.28583@angie.orcam.me.uk/>.

[2] "MAINTAINERS: Add self for the 3c509 network driver", 
    <https://lore.kernel.org/r/alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk/>.

  Maciej
