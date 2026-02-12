Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF611EDA2B
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929325; cv=none; b=uOiJHGabAFRo06S62sQP39QwIzjbGRnANaoRIMtbNPHs1jez7YvpbwEHA/kvxUercuydhadA+j9fzCFKFBERNewd4ePhTJwsqe23NRUJzvAMefaFzHMcQ52Zuc/UZwu7/j6cG3pjCMEJdLjWYw0sIF4T27Mmmy442HhOJqpKVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929325; c=relaxed/simple;
	bh=F7yhD+mVO2Br3s+whVRfIfAvP1hOE0RqxEZq3O1HHC4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AGRDmlgluTGD22oDHBMPdRos1MEWnuqX8z7NgM/iUzzbLxoAXt46tPHEOWLWG8mMNVV3PVLRiSmqeHGv0l1VUkbHtwDWqzT03I+Uds57DQex5e0hrWbvoG1Nz2TC1I0Sr/rZxOkyq6kSqGYGlO9s+JgCmyxLRu1Y+nzuR8iSYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWrmeR/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWrmeR/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ED4C4CEF7
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770929324;
	bh=F7yhD+mVO2Br3s+whVRfIfAvP1hOE0RqxEZq3O1HHC4=;
	h=Date:From:To:Subject:From;
	b=CWrmeR/PELg0dIIS8sX0aBIlb8XWdTbISYqeqarc2moCm6lxBQtvTKte1nevAyzrP
	 KCtpUcoxhbIpFc9noCru/+xrkFW3MqeIPR1Ibd2F53s31LmPrSLNbG7hHxqLSLtJwF
	 /BmNmyeeWADejszgkKedcsCadAN+92kzboFPsAZ3E8XuAS7PktWUWmt83XA4lXPOFV
	 Vmp31zr+gVpXU2SjaCAKT4gcMt8jQ40MFMfVWlJGq4icGRrN+HOhHBkat4k37CKc9p
	 T9zi98vhJJPlyK5xBW0qjOh4z0Q6kVg2p7EXSyrTnfNuvjwXH6E+2p3QFXGR9MmwKI
	 +nKHMrEzpF2VA==
Date: Thu, 12 Feb 2026 12:48:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Feb 10th
Message-ID: <20260212124843.7fbbb3fc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Present: Andrew, Eric, Paolo, Simon, Willem, Johannes, Jakub

NIPA maintenance help (MoU)
 - Simon: proposal submitted to the board, not yet voted on
 - question from the board:
   - are we coordinating with K and LF on similar efforts (yes)

PHY SoW
 - signed, minor delays on trivial contracting matters

Lab stage 2 HW
 - delay on 2nd machine. Due to RAM supply issues
 - current delivery data in Nov - will follow up with the supplier
 - need to source a 10G cable as well due to shipping error

Patchwork
 - discussing possible contract work via LF
 - Jakub to write up a full proposal for the board

Lab admin
 - Paolo: could not log into some machines on Monday
 - Ansible needs some attention
 - plan to document how to maintain lab to allow load to be shared
 - Monday issues tracked down to linux.dev DNS outage

NetConf
 - discussed location options: Netdev Conference; LPC; Kernel Recipes

Research grants
 - plan to create RFP
