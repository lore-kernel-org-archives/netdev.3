Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E822A1AA;
	Fri, 13 Feb 2026 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951773; cv=none; b=NQD111HbE5I4SedBlGTLsZuzpkfxHw7bPgZXpNJejrCf+HOYLl0bFC0bexaKFe8xST+niBgZg2GbnPwGdf8yg3l5EEcKSqdTahGMLYjOaAztZs7MNXUYsbpBpR/qkBX1kY9gc4hVWH4pfvMMqeZJIcTAptrsUXkR2bYde3fGFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951773; c=relaxed/simple;
	bh=R4OE9UZKhp9C8ehxyGzNd7n/X490Ud+l0e0d0n0JlbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx0YJ2IdyPtQsBypgrA9VV+CoGi7ZIU/HY3yB9FGBdbvwotgBAcmJvRMSMJZkGRFgTyVMveZc3Or2X6v00FgAEwXg5f04mT9Vtm5RkkBCKFKbfvnPiICFZ5YCBdzeWutJCOrFkN6bbdfWliFSKQhfsMiV+WBom5c686Q0AZAivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD/JWsif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD/JWsif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16313C4CEF7;
	Fri, 13 Feb 2026 03:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951772;
	bh=R4OE9UZKhp9C8ehxyGzNd7n/X490Ud+l0e0d0n0JlbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WD/JWsifZuh92vWmITzu1kWCq8w6JYbScI+/BCO+tODRHED7F0UUka9WTATqOwTTn
	 1Mwhbd8CaokI2CEV16bYTgvxJ4GrTgj0UoHei41V6x1jIBGHAV8reAiJol4K+uXT0y
	 s14v5+D75p05eUM6wZ4FCL0BU/V4ipxnRRMzolsMhRRUe2JtU3kI8ysvEUUjaXGmkc
	 WQfZilks5Jy33Ct9zvtOj5QHDDUY9MVQ8Z6Au94VGN9bMoKi899PI6W0CC95rxHHrw
	 CLr2qqYa1oFNv5ohA1M9ogQ403vYEi96HpZQmtgsTyyDmRHlC0EYZLm82lj/KUIw4G
	 DB56UedG1Q8xA==
Date: Thu, 12 Feb 2026 19:02:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1] ptp: ocp: Add Xilinx-based Adva Timecard support
Message-ID: <20260212190251.4e570413@kernel.org>
In-Reply-To: <20260212150007.6628-1-maimon.sagi@gmail.com>
References: <20260212150007.6628-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 17:00:07 +0200 Sagi Maimon wrote:
> Add support for the Adva TimeCard variant that uses a Xilinx-based
> design. This patch introduces the necessary handling to identify and
> integrate this hardware into the existing OCP timecard framework.
> 
> The new variant reuses the common code paths already present in the
> driver, requiring only minimal additions.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

