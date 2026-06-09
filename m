Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCA33F5A8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969481; cv=none; b=tmmNpiMUASnHG91OYBpPkDa+dnJJmEhywQSwPmpqhh4pfgQILkk7jc7gmoPdokeI1Vrzlo/CQbhtUVGMa1bLUzS8z4R3lMJLuS2JYlgv6RzsoTCuCONInHHYfT4XAVhKHZMLO2/BAH4rVDXZjE57xDOVHpXHCB40OYuBwoR5hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969481; c=relaxed/simple;
	bh=so4zAyAo11zuXv4dkBAB3AdA1x58zl3QB+WyfPZ65xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XncBTYSPATzQ6jehat52+u+/XTMJMzoVPfrQlSih9NALFTv5aUyV02WZrXz+NKzFbfyABAqNgwhXwcvrARJ4+GKT5YNEP+sTUqaTr+IDSy04jwQVSvOo6JSareCZPl0XF05ZWDVhFA6Tje4Y597dsoBlCPqS1hiIKMuY9PeeLyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDAXstC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDAXstC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5161F00893;
	Tue,  9 Jun 2026 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969480;
	bh=cK2LKA5UTOsu2lvMtMaEowkuUEfI/iDTHt8ieFK57hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BDAXstC8HfsSknbEL93ubOlVvHM7liv9h5kUVQskAY4SnvYMFgT0gZnbQcx3D6DGd
	 ZiFeDFwtQ8soMu8r40Hs7g8uT1+jktbz+Nk7pCc9WdnC+uFncFRKYgNsARlcWwO0nI
	 I9i6x3WArwYixQPLXE8R/cOoAezfgQ0huhcIEI/PGHtsvA68oWUgEM5YOhqwCWDvCZ
	 JbZs9qaw5GI0U1L4qTvufEqb0LAsAHOZ1V3pjPyyF5McJi/vLblIJOK9DUxj6m5sBY
	 2dnME9qMWIU2gLbP75SV7hsL6Uw2RtYVeQ5RgcgSmRU8laZxE8kpEAfRnFPYiVy1Bj
	 NyxxuC4qISBbg==
Date: Mon, 8 Jun 2026 18:44:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com,
 tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com,
 jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com,
 jakub@cloudflare.com, nb@tipi-net.de
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
Message-ID: <20260608184439.40e3502b@kernel.org>
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 17:29:00 -0700 Jakub Kicinski wrote:
> With the ethtool_get_link_ksettings() situation hopefully ironed out
> the previous series (commit 6a5d837f0ce2) let's return to the main
> part of the series.

FWIW I checked Sashiko and all issues are either preexisting or
unreachable.
