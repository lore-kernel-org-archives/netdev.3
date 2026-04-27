Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D367279903
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332521; cv=none; b=URLVYhU7JOjMbjUc7+fwRBgMdXBAFJwFeHGQwPrGV77dbgYRfW/B+hnQaCb1maPPK8Fmw1vipnAWdfzljMTkBdJWqSSzewBBdav/EGXFI0S5ZbGJtl8W22RYYIkGMgN250ruWZhlOQwYVjnpLVBVqzh+4JUYtyZyWkfw1h+Eki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332521; c=relaxed/simple;
	bh=xysbY8sph3l57de7MgdutJ1XnDCyzhQWxaKE/MVYGTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htdtm6Hns3pW6ZjGL7/ySodaAUEV6KgI7x5o+Jq+I7+F9aWA7IHhTlEFEZ7JuHO5oDCSgJVqx/Q1kUG1xi5vNFywvn6mEkLiSIGefFOngv6aPYFt1YOGLSoPhWPwSlO8YY1w7ru2z7kDNMc/CALXgbEgsuv7zGorDdYGoo8MSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llfv4Qu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llfv4Qu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B12C19425;
	Mon, 27 Apr 2026 23:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332521;
	bh=xysbY8sph3l57de7MgdutJ1XnDCyzhQWxaKE/MVYGTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=llfv4Qu0qY0Qiq9spc05A8MBZD8GevEkLW8a8HmibwmiyK91tBrv++04yeiDs8ozC
	 owTp8zgEtn1gsZaJ49S4MeWkjT/nY/LLfRKaD54eLHkfcFDoP1HM65CMwBrI3x4S4l
	 jtJL3wjB2NXNike406xyHUzkk7/H0I30HPTmbql4Npez+D1ezvfbUTHPjLr2ot2xW6
	 zE15VRQYI120BW+CQCq0MZs8dFdyS/n1X+yw05H9eqsB2wNL3NnvEc4X/CwI53S75y
	 v71IiOT04GCzHxGBYT/fogLCNNjoeiaRO8janjfgwT3GbHpVvj96lpjF4Gk9H/q16Z
	 N27iK69IV4JPQ==
Date: Mon, 27 Apr 2026 16:28:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju.Rangoju@amd.com
Cc: Patrick Oppenlander <patrick.oppenlander@gmail.com>,
 netdev@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: CL37 autonegotiation not working on amd-xgbe
Message-ID: <20260427162839.350135c8@kernel.org>
In-Reply-To: <CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com>
References: <CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 10:18:49 +1000 Patrick Oppenlander wrote:
> A recent change [1] stopped CL37 autonegotiation from working on
> amd-xgbe hardware.

Hi Raju! Are you looking into this report?
