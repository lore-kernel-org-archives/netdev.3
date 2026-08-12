Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677D31ED93
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576716; cv=none; b=Iia63GD3KjdRGLdWxG/UV9eyAfy8Gbz4thuduQeQfJQyHJWAXCuYShu0tTrOevTmHemgnRbXqAZ4xFbihjz1EKoWGpFb9vheK2MAXsuqqssDxJYuatiyad5mGjAT+VXPvAvHNtHyrpaBP7VXdu4ZdS3gsGh2iQQJ2KnjFsbGP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576716; c=relaxed/simple;
	bh=QXdx7rk5xANXAQj75Y0uiJKZHqH8ddJzE6bf5+4L6eY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1ybjl/djxGD+9UgIFBpzZmqearqSKbSDhwjPWECQc8NcI5yijMRaCgB/M/iQmP++/rywaxE86242uxkSmWMxvmtGYNVgZSB+NJ7g1Qr0DiDm5IkYBn9cfdTfEeZ1HLPQ2+ulYenPouQRyTis+uFPmHi8JF9Y9akIrJRYrnkHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xikf3XSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xikf3XSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8151F000E9;
	Wed, 12 Aug 2026 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576714;
	bh=QXdx7rk5xANXAQj75Y0uiJKZHqH8ddJzE6bf5+4L6eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xikf3XSAQZX/Rww0o/ybrS23BeeUDfDrIIzMq1vW8EGNjaEtq9y7syGoJXguZIeft
	 hkUnIVFgmXsWLla01VwG8SL60gJRmxCB+XG2+WvA0ts2Kdfi8piEiHiZqLqafAgmQD
	 o7Q6fAhXRiDOB29VguBN+eV0N0ZQhsSHq1+/4fpd5H2o+msccOGxGqJIVHr+KHc75Y
	 uNvDa3rfMkH3X3cvKDyt2FZeWxsg8TT6+b1bT89NtNoXJEBh+ecmfUqYHgiskj8xmr
	 QDGNp2OSDUBogtZZod8wUeg0wmFoMeJrE1xRsRkMR/IhusTx9uK/dj7dWqWY1T14U1
	 Zc/+3uTdkCnMA==
Date: Wed, 12 Aug 2026 16:18:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next v6 06/15] bnxt_en: Allocate and free MPC
 channels from firmware
Message-ID: <20260812161833.1e02a9e9@kernel.org>
In-Reply-To: <CACKFLinLEGcLXV+n1hv986QR=5faOgrU7B1qSDV0u57C=Ch=6Q@mail.gmail.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
	<20260810051358.1244418-7-michael.chan@broadcom.com>
	<CACKFLinLEGcLXV+n1hv986QR=5faOgrU7B1qSDV0u57C=Ch=6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 23:36:38 -0700 Michael Chan wrote:
> Responding to 2 High Sashiko comments:
> https://sashiko.dev/#/patchset/20260810051358.1244418-1-michael.chan%40broadcom.com

Hi Michael, please TAL at this one, FWIW:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com
