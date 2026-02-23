Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5122EC090
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861034; cv=none; b=mq3ErUwFDttnKrGXlYxgTHDi055S/aQh3PaA7qtPjpZEwlZ+4vA5Mf/WHwqpFzxEgh+qHwBl+BQMXTXWWhWM9gX4GqHAYY7gW990lc6Zx0jTAQnaLknYq4yc+++dtW/igQ43JY8u6T1yewoHP1MoFQzq6jCaevpArHD0yTekd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861034; c=relaxed/simple;
	bh=0o95pXJjgp4FLQTdYQkchaekc3rRuTiM+bQT8AHAU5I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=jBLnbPzD6bBVHfoJnmDOwTwJW9onEpRKnFEm2LYkoQhb/veM7FMufRMCexv4KZ+qeZ8Nc7I/loiQvUULr5WcToTLIr/vnyZ4wyMhuGCBD0I0iQFuYeQ4Yer0klp9gbCwWDho4ul1/QokAQnc2u2+n8uIPMzt5jkUkcbtHMKu2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0cd2s3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0cd2s3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D8EC116C6
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861034;
	bh=0o95pXJjgp4FLQTdYQkchaekc3rRuTiM+bQT8AHAU5I=;
	h=Date:From:To:Subject:From;
	b=n0cd2s3/Ay4aRGLApwb8TuwouepaKwLTiGTSNqPt92qBzQ9A+7wyYh4rmYAH5EPsM
	 51rCUTrN4dWx/xWDhbY5/gaAnENbv+h61MgOfrLgAWJE4g5DrK2bSbtf7PZk17tOwm
	 Ct3xbeaxqin8SXt9+4J2QCXxNCVjGhRps364PI4qH1HE4v00e/oD5xrsZErEsXHuP3
	 ngEvLWs1w6AiRb4UtBX21FGEd6cwNFcqCJJI8kbcTzys+YFlAHOF6Qdm0aVRNTXvct
	 nGqv6o0VjAkjf63cOlgXMEnSUCevorW7J7nalNs71lX9DaNYw98ilnMnJoe9h39/v+
	 mbKkPlVk4isew==
Date: Mon, 23 Feb 2026 07:37:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260223073713.711a8058@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open.
