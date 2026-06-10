Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D51A6838
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056700; cv=none; b=pAnyz5Xu4FlX70jDglMxdqC2ZqT/Wtw3tfb1LjfEfNxp5CSu4u+KLHnKSooXfLdS1j+xiICQITx3+SJ7unA7qklVhJmRH2bUSn/Igz8Djl1Gpgh4IknYAyfFmSGYzYWCcZt2L4oend/Y67Xek0ewE92avueGUtkdNmeD+Vns/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056700; c=relaxed/simple;
	bh=+K2amxWImyAtYdSVjiAiZ3dRNVDo8MPCTXOWAQfMK2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLcMozvsoO1nKWi+rEHGpyV371KHaH4N0cbomxe1md4lB3Y83sRuIVaYnbWA1SIFLkniQGeQlMX6Iu9yu+e846baaf8ymV7ZRGiFEKqP28iWon4ZiKB51NivEq+9/lnbwDmFHTfSZFInFDN7t8VmDO8BRXJScAZawz0K9WLBTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em+0Rau1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em+0Rau1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFCA1F00893;
	Wed, 10 Jun 2026 01:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056699;
	bh=HZCLaHfvgEqJ4yBhkF++Uy/d6DGo3FNckiBla8E4FNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=em+0Rau1ICC1QQL4sApbuL775VmkJDFXNanvvsjfCYkmaDhjRvWjeiG13quDdHY/S
	 zrIj0U+4C9CYD8xA/4wV+poC4dmIPR2WSJQpmB5B71PITDNS3leADtBxvTqTHsWZe7
	 P8SNZlWLBuIxSJfmDM9HmdsOXwtIC40SCDjIXfiq9fdARqAemlFcmJvijCxI7rOgm1
	 8nTc7+ZovvAGx81YT9Hnn5iX73nsaQu44Wh1sTH1W5EYGUmLb8wg4URjdeynhkt+YE
	 O3ble5Bcox9xdSMIWq/RTEi/5aAPdzyvh1i+zrCnuikeEwdOA7VPadFW18SnxpkodG
	 y0RPNa06wx8FQ==
Date: Tue, 9 Jun 2026 18:58:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, zcliangcn@gmail.com
Subject: Re: [PATCH net v2 1/2] llc: conn: use one state snapshot in
 llc_conn_service
Message-ID: <20260609185818.309ebf30@kernel.org>
In-Reply-To: <86c82b564186dd085fae59984ea481493341b823.1780850934.git.zcliangcn@gmail.com>
References: <86c82b564186dd085fae59984ea481493341b823.1780850934.git.zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 15:46:53 +0800 Ren Wei wrote:
> llc_conn_service() only rejects states above NBR_CONN_STATES before
> the state machine lookup. That misses LLC_CONN_OUT_OF_SVC, whose value
> is 0.

Warning: ../net/llc/llc_conn.c:393 function parameter 'state' not described in 'llc_qualify_conn_ev'
-- 
pw-bot: cr
