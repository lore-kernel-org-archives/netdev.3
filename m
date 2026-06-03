Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B13DDDD8
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454719; cv=none; b=NgGy3F52iIQhSkXfA+0zu8qaEtcc2u9LiNMQ6fobsFXH4eQM/piemJpbTH2KpJvytv3o7mUOXP0rdXGvFF+Jtf0tErJnkg0ml/UoydAgJ4953QS1UbkLZ0BlRsrw7wx15y6v1YL9Fut6obDjQawpJLnCV7Di0ERYSfVeONAVAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454719; c=relaxed/simple;
	bh=mM0kkjpA6HitXPKlOqoxx9AwKH6HHBEiJMvJqeb8by0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Kpk14eWoNktQFTvjjWJH0pux0k3DHGrl6tcjhwMObDDnyfDGFb2YmDO/es8hl3SXtB4nV+7KZOeA/ZprXySdXK9R2TroAWpm8iOqlZzTCFnQZmq8XoYbx6kkfIh4IXYl3PsOIiDzUV3idMGWcBa6+mYMvMpovS8oClXWzWr13MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlsGLvR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlsGLvR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9501F00893
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780454716;
	bh=zU2cCzQccBAEZaIUvIaIxUcUko/+eiucmH6QVETXgAk=;
	h=Date:From:To:Subject;
	b=MlsGLvR7NucLIJF07kgslsrv5eRvzDptbpMoES/wBrWBFHVMo3iKardsSTuFkibrv
	 2UjxnW+Dk4/K/96sk1pu+Gf41/HQ9kqYWaQ4QRUKGk1gINwOZv6R1huym0KUK9Wwhm
	 u0/78cF+PjeTOqL8mkW7uaBVZjL++osFa9UKnAvjE5WCUnK/FjqHR1CdugHDYnW/0z
	 5tQSCmCZ7XsIQZsWra9N3TFLsgtiMaxj+FXu6Zj5JEcLl4IoovGnkWL8x+Oe+VVOU0
	 eMxVM6avBFgecFbwYBAzqyKDt88Hfwt2xPmri0satI5ALtkTBehO90FAxMVl+o+qpe
	 BMJtFU2gtHg0w==
Date: Tue, 2 Jun 2026 19:45:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Jun 2nd
Message-ID: <20260602194515.4e8f2ff2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Present: Andrew, Eric, Jakub, Johannes, Willem, Simon

Logo: paperwork in progress

Academic Research program
 - Academic Research Grant Program doc ready
 - Sample topics added (near top). 
 - Draft is now only missing contact..
 - Need to double check the size of the grant
 AI: add information about grant size (somewhere); contact board

Netconf: on the first day of Netdev 0x1A. 13th July
 - Have room for ~20 people
 AI: Simon to confirm status of invitations with Paolo

AI Reviews, Expect to:
 - be able to control Sashiko.dev output of existing issues
 - get access to embargoed Sashiko.dev reviews
 - run cross review via GPT

Wireless CI to move to foundation infrastructure

HW testing is running in lab

Pause testing: draft specification reviewed

CI development and lab maintenance proceeding
