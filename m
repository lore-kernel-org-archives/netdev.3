Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8334F48A
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742101; cv=none; b=EdKyw6se+glA09FacbACsFE11MVxq0Cjmhg+cFcOFgN1Rltcu9ntv8WlC+p7jCuj7ee3bL7E1tU4gS8/N1vrA4wF8kEfHIgjeexXq/w5eA2OzRxBqf3ia/UPXmisNnlk/fQX8A+Z4sb6vTU5EXistsWPCEaUMRhHB1bPqwWyMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742101; c=relaxed/simple;
	bh=OXaAjo67SbYNrCeiFpKv/+MBUhbwES7JSeMF/GAOe4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozzGrAnOfm5jDPu8AuBBpduj195HJ+A2/OjsRuffImsO2FIwOtDEwTdZTmbAUpbQWxeI3uLsg/xJosnnh0ARoQVzyW1xlalpO+fYQxqgKwlQGEtNNf7kdZhf8yeSgYq+DoRarsSRvb2SmlNE4IkQ84s4DH0D09DoV8X8z1CLF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnRwgJ3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnRwgJ3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487EC19425;
	Sat,  2 May 2026 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742101;
	bh=OXaAjo67SbYNrCeiFpKv/+MBUhbwES7JSeMF/GAOe4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bnRwgJ3QZH2XBbWLr4/CJCtiFD7a+PwFtEg5RievyY6FXoHmjy5hwpKFmfAOHTdDS
	 dATsN2mRYNJ+qTgT5COpQkpMPARzzZ3NzoqofanfJyTYV3Mv7+wSY9seWhzxVwnKQd
	 Htd9+gsl3MuLwJSZCdaH/AqIjcZ96U9mdwEXnJf5BxhlcoJ2zgapWLfm3iyAYXBE7R
	 5Ni6cHodsGfNWv/H34cgdyHzy3svjO+eRWiG52tTHHm4gE30qRhPyL2OnkKvb2ci2u
	 9/KnigW7+9K7rNUBztQUyZcVEhdQOae1VYZEIg7EJIfEkmpph7o5mzFXa7sDeIA3s0
	 73BY4wXlcxXOA==
Date: Sat, 2 May 2026 10:14:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, andrew+netdev@lunn.ch, chleroy@kernel.org,
 qiang.zhao@nxp.com
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Message-ID: <20260502101459.46e9de13@kernel.org>
In-Reply-To: <20260501122756.GB15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
	<20260501122756.GB15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 May 2026 13:27:56 +0100 Simon Horman wrote:
> Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

This appears to be a SHA of the second patch in some local tree.
Supposedly the correct tag is:

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
