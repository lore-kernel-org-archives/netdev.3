Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF988220F24
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719179; cv=none; b=UeTIH9Epb2NAL3SHrsUFvSHhTs3v9RoLHKFPKXRtOW5btNtXRITEZ4GoyV7+dvTk/lADjH8sce/5ZxXUcn6unhCcmUc9UufYX2hou2hjpbrkA78hmXa1TDH63gjbsqxV1mx+qT/AlE+SrJtf2RTKdsAd35QdsbUAjsmlpse00w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719179; c=relaxed/simple;
	bh=UrZqa4/2SiaoFCc5EAhxYtQNEFH632XbA0HEGe/ZX0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1vOuLIDakxUylSM/sYbWcttZ2YBE3cUhy+zVU97C+FNfjnSQC8Z3XTxoNb0bz3K3pnQB63m2BbLcZuRpOjGVoGLs/wXsJM6jbC+SiPs4w0AJBCcu3iAIOO3j7DS0+auG6YowSym0AQcdQkMeT9SAt52aGQ0+GPfs1WqYuL+JWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLLT/K54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLLT/K54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32246C4CEF1;
	Fri, 12 Sep 2025 23:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757719179;
	bh=UrZqa4/2SiaoFCc5EAhxYtQNEFH632XbA0HEGe/ZX0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLLT/K54kvwLLZ5okQVaydAuSG62KtIPGEMv0vmluDPtoSab359g/arQtHrJVvGqD
	 WReV2UlJyy2DOOHys4v4KRlCh6EuhTtLdIQND2gh0dvoXEDpNkXztUpGhPpevNHSfM
	 SdE2JDY/5pAnCXnyAZk6MbB2N7DCNdFRmrDu1VJBz1+vO6nq9x/ZuSr0wizt5JUezC
	 wQLjFrvZUCvlVsqPH0OtSYkFRi8ui47suqTfz5ECU/SNNkEmYFZhAaSo3LZLbf9rx/
	 tlo5uEM7VuxDbtd63DU9PFHUsu/WPHHdZ++I+kZAi33vUa6BbUC8z+J4zybY/8etPj
	 xsRbiSA2/9AZg==
Date: Fri, 12 Sep 2025 16:19:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 2/9] ice: move service task start out of
 ice_init_pf()
Message-ID: <20250912161938.1647096b@kernel.org>
In-Reply-To: <20250912130627.5015-3-przemyslaw.kitszel@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
	<20250912130627.5015-3-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 15:06:20 +0200 Przemek Kitszel wrote:
> +	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
> +	pf->serv_tmr_period = HZ;
> +	INIT_WORK(&pf->serv_task, ice_service_task);
> +	clear_bit(ICE_SERVICE_SCHED, pf->state);

I should just read the code, but this looks like an open-coded
deferred_work ?
