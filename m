Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2055166F1A
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999769; cv=none; b=c9T7+UCO2rXUt90TuTUHrLhinHM02D1mD5FFgbFZUxzu72rOt8p6N1gSneqhT/9hfSsRDPQEw77iCgEMXTQB717HDzreLKaXhcyfleojR1P5VCNxY6KtAg3P7qR2zfUlMHdBHKQM/gICaOj6ONAGcbH1f5zGTkvW07roEVDKTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999769; c=relaxed/simple;
	bh=+GaeAUSMWZ4A3X5PbuQRiRWRpQk3A6nipAojdcxufRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSDe6tIoy9WWbt+kdZAlUTNuk3mkxxoZI/51lbmGwD//apr1X5yteyjJ4DB5QrN1iUN7LqsH0Ro60JtJAcxRAnIGeM/mK4fVM3SfTo7Qd6TqcVNJdKTjeiNaDBz6SSOp+AFgL3ytjZq6qs42dQZpQbq93a9ZrvJsUyXnP3LynsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFX358ef; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFX358ef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC78C4CED2;
	Mon, 27 Jan 2025 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737999768;
	bh=+GaeAUSMWZ4A3X5PbuQRiRWRpQk3A6nipAojdcxufRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oFX358efwc3DfsvWJbikh7ppR1u7iZRGB6Zru4GWJlTtv77C9Ul4Jt2J74YXOfPQf
	 ncoJ7EJNbE0X/fHViuJlkLmUB2NluvFFwysVTjVeIXrU4Qsu66MOCeXDDH8JTSZto1
	 7LikANewMHFw/HTSyhkRbUFR7Gu3vUH5tCYzS9+pzbFHKTk4bXRcPzg3k/TeTHlVf0
	 Msp+6vlyCr6HD4DW3zmHIKoBEJ0UNJ5CF+CqEXMZ7D3UQq3Dfh+Gg/igwlwquPaCgy
	 WdC47emUXm6K1It8ccEB4vvRf8+D2LKZfu7II1sCTm0V94b/CrFCGO0Y50SuOaEYBl
	 qGQ2GRWPfJuXQ==
Date: Mon, 27 Jan 2025 09:42:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Singh, Krishneil K" <krishneil.k.singh@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Emil Tantilov" <emil.s.tantilov@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [PATCH iwl-net v1 0/4] fix locking issue
Message-ID: <20250127094247.40b169a1@kernel.org>
In-Reply-To: <95288bb1-8931-4d18-b8f6-25a4f6148afe@intel.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
	<MW4PR11MB5911F6BAECF5DAC79199B362BAEC2@MW4PR11MB5911.namprd11.prod.outlook.com>
	<95288bb1-8931-4d18-b8f6-25a4f6148afe@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 09:11:41 +0100 Przemek Kitszel wrote:
> @netdev
> I would like to consider adding "in reset" state for the netdev,
> to prevent such behavior in more civilized way though.

Can you provide more context? We already have netif_device_detach()
