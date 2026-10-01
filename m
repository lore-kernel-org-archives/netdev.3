Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682640B0FA
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896042; cv=none; b=LJ/ChZqp1dXI1xMb56wsP//Wh0GJHzjAW3/1L0ch82+mcOsMrZ3BZAA0IuY30caLJeVSp3DeMWRF0ufjQOv9ICc15QjrhkFtR8vJmgOwO7E40l+H/BEKf6Ih+9Ioet4iTi5km+7aGp9J2dI1QcMCPVsOlKF0fI1WmHbtEkHSW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896042; c=relaxed/simple;
	bh=c24UZjBl6TRRiVUg5W9BRI2U0LPGWrkiTcikCRWcthI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDbOEewchAG2/geNj6RxyMTuc5q/sqOq0UN82NOpqKS4tFrOqHsH6/h/2B8dMHlgmqGL+y88z0b9uPHhPkU4XTRBEznBcaFiZX17A0AhUQQ4kzj6DG1V2XXCqPhgMZLaG9KWJYcr1OLKKIN3AjXdx0lTs4mekDVjFAyjxDC+2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8jWD115; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8jWD115"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCFA1F00893;
	Thu,  1 Oct 2026 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896041;
	bh=c24UZjBl6TRRiVUg5W9BRI2U0LPGWrkiTcikCRWcthI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J8jWD115c3bkBEAJw2PqhoZOt03+/WpHPnFzZziKRU1dCtzj9dcgWSte8dw0uTFYT
	 V5qsiJHXtBLYj3JXgEpHsIguHCP6hsCZYYmtH3JRLeCv3ZrDI5qThdNitQQeNgvyPY
	 JbPRxIMnaKGH7AchX3xYnEWK7Gksf1smSelcUWNazWuE/+PHbwP8ZsAVsimssu89Ur
	 shrWbkBPaPLl0l9vovJ1RDU81H3b2R/38XLzJuPYNYb+F09WM0gb70WG/PGT7vhpxf
	 d/bh1Pbr8svKimv1abkm3piSgXVw2AdM7J3tibo+a5Y1nJpnkjNw3XaeFaUqis37KY
	 GdYS5of+/w2hg==
Date: Thu, 1 Oct 2026 16:07:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: nramaswamy@openai.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] tcp: restore RACK list membership when undoing
 loss
Message-ID: <20261001160720.0a663ec7@kernel.org>
In-Reply-To: <20260926002520.42955-5-nramaswamy@openai.com>
References: <20260926002520.42955-4-nramaswamy@openai.com>
	<20260926002520.42955-5-nramaswamy@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 17:25:22 -0700 nramaswamy@openai.com wrote:
> Partial undo can clear the TCPCB_LOST flag on segments already removed from
> RACK's list, which prevents subsequent RACK loss detection and can lead to
> long retransmission delays. Restoring them to the RACK list allows them to
> be reconsidered for fast retransmission in the future. To do this, we first
> sort the segments whose lost flag is being cleared, and reinsert them into
> the RACK list (which is sorted by transmission time).

Could you add to the commit msg if this was found with an LLM scan
of the source code or its been seen in prod?
