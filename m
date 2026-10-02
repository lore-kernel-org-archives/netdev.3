Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBB412C0F
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973575; cv=none; b=CVSkt+3haz2IvsLAHEiUM4IL8D9RIhhvZH0bzbRaglMUiDrbhye5J6ocn0j9qCQAvwvjAOtHaB0u/5dEgwX3tZwIs3qeZMkA7jcZY2XsTfVcPXRRMien7QqhI3shItvej+nIb+enKbnQtv3AwJ4PD+nAZb7wXlxIRnMv/I7v/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973575; c=relaxed/simple;
	bh=GSyf5PvvrVFoGrgL5n2Wm9W9YjRXtKgyVuxuWxp5P+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYzNFZuL/WcoV6WqRoviswJnwlkn8DFdx9g+jwVsn6RdycGgSKvn4M2EOhmFIPhwis3ep0tP++YScOJ9diW6Baxaat/SkKytGQ8DRkhLuSjqnldWOprTJzuJYucFJTF3cVx/4AM/5w3ypu/1bqJc7jUGrg/cF3lX2OAOgPSFjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVy9BioB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVy9BioB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B991F000FF;
	Fri,  2 Oct 2026 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790973573;
	bh=TDeuJoibuG2G2C+P1zOqSiJy5WXA4TniuL429D9HTzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PVy9BioBk5FkGm8m3xxvudVjekUZaXmmwhvV7+iMre7GqgVRMlMixiFnPTW9vMwVp
	 1+yItB/FdmBzccjZj/m8Y+JoUkFxirElNmk7eyORLNB6/Pyb8vZEpNF9NY7kr3V/8b
	 TYqgcO5lA3944KjimUO5aI8GTsssgLrbbSXUtOZnQoYFmREpe2m80mu58lEBNj+aJd
	 Upowasaq/b0eMtMp2po7D7ikxXb3OAcntr889f0mVDrCicPna6ihqTVOiKED34YAFo
	 5KxQbf9V4f9ak/Pl0y2MvBkPlFjPwx9ti/jIsqZQm7o/aC3XPf7h1deZIW9Sg/lvYu
	 +Wt2iEtlKf37A==
Date: Fri, 2 Oct 2026 13:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@kernel.org>,
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
 <emil.s.tantilov@intel.com>, <luoxuanqiang@kylinos.cn>,
 <bryan.fraschetti@canonical.com>, <tristan@talencesecurity.com>,
 <tomasz.lichwala@linux.intel.com>, <david.butler@appgate.com>,
 <horms@kernel.org>
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
Message-ID: <20261002133932.0b2b0776@kernel.org>
In-Reply-To: <3c736ba6-d2b5-450d-bf9a-c104cb818f1b@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
	<3c736ba6-d2b5-450d-bf9a-c104cb818f1b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 16:47:22 -0700 Tony Nguyen wrote:
> Patches 1 & 5 will need to be reworked and resubmitted; responses to 
> Sashiko are on 3 & 6. I'm hoping would be willing take the acceptable 
> ones and I will resubmit the reworked ones later.

I'm not touching 6 since Dave's response has the confidentiality clause.

So basically I'm picking ice patches as-is, and dropping the rest.
