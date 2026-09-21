Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6A3517BAA;
	Mon, 21 Sep 2026 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028163; cv=none; b=U2Hfii+B1C5FTVQPEyX9ejXdqZ6OS27l1iAl5c/KExt/gOUD3zzRXmToP/ox09j3wHRLt+8ibbGufv1sLG9BwEH3HJMeyEXmxBeJZW/aSiwUCPLv6yDgiGrWF7eaHAUfWOdjYYvlm1ZVecEXiS4rJOupOK5cWn41nLluZPSxP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028163; c=relaxed/simple;
	bh=HQBz3aUz+4BAC1yO7H66nQH66KTLNOrF1NxNVs9sFQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOudC2MfanLXp0y0A9Sh8MsShqVMB9BPNpyxxkPoDaz0glEHZw8sCmwJ0639t1trj+jnc3s8rSjQNQ5OJzAwigPZtVBDKN2IfkFmdGhLiENxng3z956VFDYDKjdvAW+gGwtKW4oJE6lTJHn+I0tpvMCGiMvzm24nvPYsE2bcnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4OoGWFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4OoGWFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA8F1F00893;
	Mon, 21 Sep 2026 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028162;
	bh=v6PqrnIjiixkddBOVLPeYoAJYOCz5r3L4BvE3zxVWPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e4OoGWFVzi9D5W2sY5LTiZOzsF69x7x5nb+gQc7TNCQV9rU49tLXB55H9Oj/YJcyv
	 X/7PRQKBWrtG5K/YhH5Y/V6cjrp7uuChL07oa04EzjM+90YbhQMB8kkaTOhMj3YtSL
	 sE+CnLn4SQ1t8iKSQSFAQt/pDkMeLWdQ97V2YTjnVZlJDzjMZSxxnLCe+f20vP4NZZ
	 xFcagqPQbUWlGsAeWTFGbMOieCp9eSPBWjFhyrXO7sXeyLvtIXtsT5gDOKCamyxAMJ
	 NJzlOWoycrcMg677jaeZg3K/zQoVtY/KjtVSbN442XuoyQWeQzvnpr1tN8XWVGYEKy
	 ulK8s9idRMjxw==
Date: Mon, 21 Sep 2026 15:02:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev-bot+sashiko@kernel.org>, <davem@davemloft.net>,
 <gakula@marvell.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>, <pabeni@redhat.com>, <sbhatta@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: nix: Export CN10K admin queue enqueue
 mbox handler
Message-ID: <20260921150241.10a47c1f@kernel.org>
In-Reply-To: <aqzpNjAtWSoi7hX1@rkannoth-OptiPlex-7090>
References: <20260915072357.980485-1-rkannoth@marvell.com>
	<178971638355.22033.14086854049232485813@kernel.org>
	<aqzpNjAtWSoi7hX1@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sep 2026 13:03:10 +0530 Ratheesh Kannoth wrote:
> > - [High] New EXPORT_SYMBOL() with no in-tree consumer:
> >   `EXPORT_SYMBOL(rvu_mbox_handler_nix_cn10k_aq_enq)` is added in=E2=80=
=A6 =20
> Can i post this patch to net-next as consumer is out of tree ?

No, we don't carry exports for OOT code upstream.
--=20
pw-bot: reject
