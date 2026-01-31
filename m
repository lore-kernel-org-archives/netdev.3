Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CE2DEA7A
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882676; cv=none; b=er2dkH987jhFyxzGU97wErmBCiguyU0mr1BkiM/MpLi1J4hGH266xXuvJxdti/sBEiL0dRxglCURcQD1ZyIkq8mi1cdQt4mw18cPIi/NDglfcddZDsG3Wa0aAT8tRdGbHMaefDMI/GkyHh7d+gQfSv66shKPPRA57yuAFDNpT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882676; c=relaxed/simple;
	bh=JrATpqB6uJf7cMES6fsC24E8Iotb22Do0DyecbQxtBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IM0Dj/KIVrIRkSVVMKo67o5ZMebMHz+BpCI6+SL/8rMveJmLpbEecZKiS8Ft7lWy2idffYnvD1/O8MMM8vGcQuRgzHD1G4Vgh0pLBvaW+PIl5BhDfj63J6l4xxGnuzrqqnh2J344gkvAB8Gzm+yJdBWlnEhLsTO3vKioH13z3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha7jrGjq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha7jrGjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35243C4CEF1;
	Sat, 31 Jan 2026 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769882676;
	bh=JrATpqB6uJf7cMES6fsC24E8Iotb22Do0DyecbQxtBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ha7jrGjqR5uRqo6voSoQZ22n7SGKHPW2A0CX7NecNfu6Ubhi/8ZXaU7QrqnEM5sjF
	 Ddi519375UP8mMsXTHpaErJCDCS2DFcVWYkKh7cab1/MMZKb+lnV0/0C1yM5xnYQAB
	 nhlmwafgpmAM2Zna+pG/YTf5HlXfuM1qGVJnFMr+QpxFA4YuIdB5lhhvtWUjQRz9Cc
	 FyOPNHInyaFTRa+1vzsrxqDzGjriujJ6IZaTAr7UHDpd2A6NwnH2MzaHT8dEA8TzWp
	 +d03rlygBg/Y9WsRqWOfJFYgwx+GKSBro9mLf1n2gBiVai6yULyUWO3H7nIG7KyNKO
	 vzG5tt4Bo20Pg==
Date: Sat, 31 Jan 2026 10:04:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com
Subject: Re: [Question] Dead code in rawv6_mh_filter_register()?
Message-ID: <20260131100435.36c2aa34@kernel.org>
In-Reply-To: <20260131150212.3292929-1-ingyujang25@korea.ac.kr>
References: <20260131150212.3292929-1-ingyujang25@korea.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Feb 2026 00:02:12 +0900 Ingyu Jang wrote:
> Since rawv6_mh_filter_register() never fails, this error path
> appears to be dead code. The same applies to
> rawv6_mh_filter_unregister() in mip6_fini().

Please do not send such reports for networking.
register and alloc functions should always be assumed to
need error handling, so that we don't have to fix all
the callers once they do and check why there's no error 
checking when reviewing the code..
