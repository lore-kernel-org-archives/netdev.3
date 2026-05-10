Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E937754B;
	Sun, 10 May 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428723; cv=none; b=IMrAZj7YjuAE0ESTnAnOI6O0oUALrTo5en1th4wDFQOjNew5Bwmkw6WEUGgQC0fXzS+ViOuOALXDg6ZqVBynD9cNWXONuMtVosCgE5t6iTq60HcPFRCqlV/jl73kwXHnXE2nqQpgxT8LxH+UohY91Tq+kg701WB8GL3FUwsKn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428723; c=relaxed/simple;
	bh=VRGYYL4OLKO7RCTcIN/u+clw2lKg7gWF82T7G0HhC14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8zVItM7wZ6rLpW0wkpAij9o79jr6wIjConwicLXW/1ZEy7Zv84ooUiS2YFACGKFWtv9Z41aQKoIo83NseUBmwPUpl68AqikWcorK89RUVF5BiLbm764ejPIiFyxUASG/x1navnGHJ2g9bHWMTPEBrSNumdsNqLONWwLnqkhgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0WbLwyA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0WbLwyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FA1C2BCB8;
	Sun, 10 May 2026 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778428722;
	bh=VRGYYL4OLKO7RCTcIN/u+clw2lKg7gWF82T7G0HhC14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G0WbLwyAttWAZWd8F33/xlo/GM7gv8vqBo4WfpkyoYm5BVYQQ+xBPQ57CKYD4W2LX
	 tHSL094ghEOZ7aormwWKRz+rbh2PkTQnsovite4qhwLsyvcqcQc+YLUPA3dwiurzNu
	 Y2CkjJoHssEjAw0GUcmExDI3i7EUnnd0kFyMXL6Wh9QDg4DU+RhiAdTuPcH2PQxnEt
	 G6d+SuTeGMh/oRt5lHOEj8+U4TLCaCvQe/7+9nHk5l+cD0dt17gyYZBDXesoGjwV3E
	 mGGw9iEFbLx+fQ+JZcRaMcGferE9wcvErBAv01UPFw+AUDf/D+m04hCMZJla3jFJSn
	 87/i4aFdAZeHg==
Date: Sun, 10 May 2026 08:58:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Ethan Nelson-Moore
 <enelsonmoore@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: MAINTAINERS: Add self for the 3c509 network driver
Message-ID: <20260510085841.243bdd7e@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk>
References: <177827761704.865600.12887598979033208728.git-patchwork-notify@kernel.org>
	<20260509230519.57607-2-enelsonmoore@gmail.com>
	<alpine.DEB.2.21.2605100246020.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 02:57:15 +0100 (BST) Maciej W. Rozycki wrote:
> On Sat, 9 May 2026, Ethan Nelson-Moore wrote:
> > > This patch was applied to netdev/net.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:  
> > >   - MAINTAINERS: Add self for the 3c509 network driver  
> > 
> > Hi, Jakub,
> > 
> > Did you forget to revert the driver removal, or have you just not gotten
> > around to it yet?  
> 
>  Thanks for the heads-up.  I can see the removal was fast-tracked to 
> Linus; I didn't expect that, waiting a couple of weeks for people to speak 
> out wouldn't have hurt.  Now `git revert 91f3a27ae9f6' is in order.  
> Shall I post the output from that, or what is the expected way to handle 
> this situation?

Sorry, must have missed it or forgotten.
Could you point me to the report of these driver being used?
