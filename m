Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501B18C933
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201121; cv=none; b=Y5lij3tR08Q97+V/zX6TTH1kkyLuP1YKOil1QwclOPN5h5qzcdRjdMUZES3m/o+1xW2AWfZbmUv3QwLF/9vQoEEHeuoETTQ6rWkfDdJQrZb+JK6cK3K3lrpKijpvCs+g/44syGmfoYEeFeivS+WKnUgA14aqaaBpll0qxPgKve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201121; c=relaxed/simple;
	bh=3mLfRO/PPrsrdybsmFq5DHs4SE/oj4WkhpM6l1jHqVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIDWKcuaQyzibnNnpkyW34AANQLMLbyXFAYInOjIDjJRKXUOMJZC2xCoGwqQkGQ8A5jyr93ZKhFGrvJc07N2ezATzDL1ekQbz5fVmURmsIQU14DMgi1GRaOo5BGfWzSh8sZh4Og3jRCnHx+xJzO1xP9ws3lRuTo0xcSECwjUIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFwgaeOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFwgaeOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A827C1F000E9;
	Tue, 28 Jul 2026 01:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201120;
	bh=aA8TNZhxi8Y6E2rakA2uAUqcefRIYqdd2Gk/Fpzawbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FFwgaeOLODQgrXKSTchu9qa3xcGwAxuG1XSP5xMLOQKB7mS6GBFAcRU++YBcP74rg
	 dUgTAqi6xuGvrILH3DxxmTNTqD1PuvgWEl3aUsB6aK9ij/TXn4xdOvDDUBBoGTqAxA
	 WCkrE11YR3zg0TIZNKL0W97rmBRSDCsk8Gmn/klhMBhGlDPvDf9aAspq7p9OgfQYjs
	 Ta6sidXQcpkvuNcc0eIVIg3pU4MAQX2AI1atyAw+1A6um/kuYt/96N+/2bs4EzcSNC
	 otkl3S0qR45A+niOsuc6GKE4dJZ88/7AcT4CDK8DghLGOk4PQzJ8eOLeTICFtj5I4g
	 rqOoD2PlbYJsg==
Date: Mon, 27 Jul 2026 18:11:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Siddaraju DH <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, Shubham
 Das <Shubham.Das@intel.com>, Balaji Chintalapalle
 <balaji.chintalapalle@intel.com>, Vijay Srinivasan
 <vijay.srinivasan@intel.com>, Magnus Lindberg
 <magnus.k.lindberg@ericsson.com>, Niklas Damberg
 <niklas.damberg@ericsson.com>, Jonas Wirandi <jonas.wirandi@ericsson.com>,
 Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: [PATCH v3 net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Message-ID: <20260727181158.1791cf45@kernel.org>
In-Reply-To: <20260721150638.3084698-1-siddaraju.dh@intel.com>
References: <20260721150638.3084698-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 20:36:38 +0530 Siddaraju DH wrote:
> Add comment to clarify the physical media 10000baseCR follows.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.

v2 as already applied (no need to repost just for review tags)
