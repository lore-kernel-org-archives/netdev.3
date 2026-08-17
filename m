Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154173BE178
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999902; cv=none; b=D35eyNQW7mmKmPY/F+6Ed36hJqstZUo7I7LzH9Su0NH+SUFVMm8TRVDain4dXG2kNRedOHHo7sZZUSF/XlKhLJ0Xllr0AC5swxP3vT1JyUPHiTJLUW8JSbBrhhTu3E5X3I8CfweK8TY5yAZDrIAGcgj67FAkmdsL9Xdk95GDcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999902; c=relaxed/simple;
	bh=LN0TpuSE5gvRyvGvBe9lyfvP4qAiHZ3vKJ2gaD7SoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lssdgm3gb+dtiCiQIHurXenUeJFhnANIUBDO/fxTVio1iayr8SQOhohq6jMmrJK56Th3SGKHMtD3VeKKJ+8dfRIB751xPoOGbcmPEtQxAfck/IZKNXbTm2G3E2yUSgMNBrR+jljE/cIJj5CCH5iDzJjggfWC9p+w9zLm0OWjuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvszu26h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvszu26h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A501F000E9;
	Mon, 17 Aug 2026 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999901;
	bh=LN0TpuSE5gvRyvGvBe9lyfvP4qAiHZ3vKJ2gaD7SoWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jvszu26horZdYF8oCq77XydH2lk1A69clFH9eKPSqWhzfdsK/EznZQMhMqxfOn25O
	 L5dl13m9nZifAVcRCF0Qp6MMwNRcp1fcb1lZAqGyrEUXnRe/I91jXHA+7kVHUrzK8/
	 KRXehAAr1hS8fxV3ku0bPX3nzsItNEP+Wx2w/hjdeHlguYUr9v7vE8CP+9i2Z1Yrt0
	 GuS6a/HXBZOXEq5qB8zEoEiIbaVNk+m+rJOI+5qULs0eRRrLDyJHjJg/ozpNhW0MGr
	 /N5RacDoX1NToUZYD8HR934YjCX7GBa5UaQfcBAwYMzNQUbUuRiNZF9WVqpOrpRS/p
	 oA9FKb6cHaRZg==
Date: Mon, 17 Aug 2026 13:51:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2026-08-12 (ice)
Message-ID: <20260817135140.37c7f578@kernel.org>
In-Reply-To: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
References: <20260812204619.32253-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 22:18:04 +0200 Przemek Kitszel wrote:
> Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2026-08-12 (ice)

BTW you marked as a pull request but there's no PR info.
Make sure to drop the [pull request]
