Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E9175A84
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126281; cv=none; b=FBDqd30Yg0X506U9VpamHp7oFdjckFQ+aqAG24/6qL+oCld9mSM48pNXkRMpdr0TPlj7G5R21jbfxQagrN1yaHsFeFh4VXHxS3qJj3PQVEUHK4sClBGE+iGZ9itBf5HTLrsvpu+Aa/t+hRGs0Tp+aixHbKN0irpMKhYixFbTMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126281; c=relaxed/simple;
	bh=fdsp+b7hLBqyiTgmmYHc6hAqMx8tYFo+pZSC3/RQAlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkZt11CcT78YukYFkyt6XWMoadLW2aou6TvlnyYDPWc3l+NO79/xATgAjZI8EeIgdSSlLhjiLa11K40NR7ambAwJvsMqYjz7JTeaTvUuuPJ1PZ3MO1GyRoQvdikTPHu7ARGoTR+HEinsPVCMRRPuIlQDgfEB9voUObAG+UnGw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne4IPhSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne4IPhSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14D61F000FF;
	Wed, 23 Sep 2026 01:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126280;
	bh=fdsp+b7hLBqyiTgmmYHc6hAqMx8tYFo+pZSC3/RQAlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ne4IPhSBGyczcPH4N7tqKo+Jn52RWOycsPaj06rW5T8jlVGqGQZa+lYOy0afROow2
	 PQSkRX9WM4cdqiWa1w+37HQ2jEAQk2+u1Bz4RhrC7Lzlo/iZGVbtcPrai3LCz+mJC3
	 JPY/MuCRNs/knFIfRAa4kbjUJIZlovacQiQ8kORSDzWc5V2oXFNse3KBN0+ZamQJm6
	 jeL9P1j4afN2eKiRH8tCUvMOoxSnvLW6lD4EosIbdRf8J/inE+34Tx2ngKYORZvXyS
	 Ov1fXurnyNzBB5WWr126MvXhBOJ6yZI7DkJ7JrozrMjUXyas5VtBStwYcTvd8AheT1
	 uwpA3w5ASbu/w==
Date: Tue, 22 Sep 2026 18:17:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, aleksandr.loktionov@intel.com,
 sandeep.penigalapati@intel.com, ananth.s@intel.com,
 alexander.duyck@gmail.com
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: Add ACL support
Message-ID: <20260922181759.6cfd5cdf@kernel.org>
In-Reply-To: <a37799a1-8b41-4a8d-a350-9f4f913330f3@linux.intel.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
	<a37799a1-8b41-4a8d-a350-9f4f913330f3@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 18:02:49 +0200 Marcin Szycik wrote:
> I see 0/9/18/2 issues were found by one of the sashikos [1] (other one still
> embargoed), I assume some of them are valid. I will be analyzing and fixing
> these for next version, unless all are false positives (unlikely).
> For reference, previous version tally was 2/20/8/1 [2].

Thanks, FWIW I'll pick up the first two patches.
