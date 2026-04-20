Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83050379980
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705067; cv=none; b=lIy+1ue4aknpyKwxGOj0+1BgybhbrqCojzoRb5ZoelHLpo8n9lD6YB36uhoZ1QeXXcWpjlJlS4qRtjylgJnCL4kC7hMIaprxKFHmop3XfqfMOtYpvcIsUw6A49YQWQjo3y1KMUQHS471+DNWM29Wt1RtmgKGFGF3OB+4KLDE3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705067; c=relaxed/simple;
	bh=hnLqiUuA8Wfe7PvAAwrdR7vJUTOt1Rmp26QJzmYBlG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDvd4aa0JvJEGx5xSBtObUN2O+ewweFjvsoOm3vrAEsqdjlcjcCr7KNG1y5a8vuAhcUNdACfKIqC/n3w4TNHkAcHgVJlbHX59NzAtCDmqGJkkwEHxSc5O37eOxhm4nCX3AKiWaGLDtL8eKPcSYDHBsGzgTXyGcbtcThtWYNIXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUhZT+Cg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUhZT+Cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB29C19425;
	Mon, 20 Apr 2026 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705067;
	bh=hnLqiUuA8Wfe7PvAAwrdR7vJUTOt1Rmp26QJzmYBlG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EUhZT+CgOr9e2W4NrjQqMKkHAUpW/SNn4Uzz8+depaMM6EDGE0auQe2L3od6Hii54
	 Duf9+WBadn9+/AK4gV1qvZcBEYktzItp/mt2sCAcUy1KJReEqFWZJsTHSxZZNxh8Du
	 WM+fjWtp8+uYcTdsqmFtNAOgf/ExT/f0tTztgLW4lRiVIyT7JX4L2uiihGCVSxum9N
	 7cqO3qms331rIR/h54UFeJsyJbKXLegdJbskPVQIRkAAQeJJQJLv7xjY+KIF1mXfTw
	 dMsAdutGpsXP5QxSX6BanWKji8lfFCdsTflBndHzGQlqgTIDvJPDH8hKwU0lLbiP+j
	 tnUq2C7n8fWWQ==
Date: Mon, 20 Apr 2026 10:11:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mISDN: fix socket/device lifetime and naming
 races
Message-ID: <20260420101105.1c5f9fcc@kernel.org>
In-Reply-To: <CANAAWHJKfRVO++ZdXYAKSaTH8JCBi_Xeu4DE-Ldaa6zu2Kub6A@mail.gmail.com>
References: <20260414071322.30851-1-shuvampandey1@gmail.com>
	<cover.1776446840.git.shuvampandey1@gmail.com>
	<CANAAWHJKfRVO++ZdXYAKSaTH8JCBi_Xeu4DE-Ldaa6zu2Kub6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Apr 2026 06:09:03 +0545 Shuvam Pandey wrote:
> Please ignore v2 for now. I=E2=80=99m reworking the series and will send a
> corrected v3.

Please hold off until Thursday, I'm intending to delete ISDN from the
tree. Please resend if the code still exists in Linus's tree at that
point.
