Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A63ABDA5
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908202; cv=none; b=NzCak1xQxfnq5bvNtPq3CdgjUb2DosaPgeDmyvSPXi3kdYopbtLkEKfsFiFVkRRcugw34GRWmyTJ89Tn05Gx8c/kTDWZwDIKS5SS7sHQYwqiuhsB7eGJliurbtCnRPbl/eWDNYQSg8Ju5ZpVSZNeNADFMm2m09rqQHL0dHBLV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908202; c=relaxed/simple;
	bh=1HURYdC0tSC+fz+SZBWgvNfTKqnLjTT7rEurc+hFXcE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=fyZZB/3D2a0ScFmQAoAYjxoasp+34iCbktpm1EX1AOXBIZdo5AMfK/9i0/5RRLoCrVpGzOsPUdE8x5wk7tISNGsG50OrOwCndOxK8KETZFIDI0vxp8/aWGRDVXp7yb9aTYxDRMZEr4LPKFP7+qN7AxprwZxvogxmX2jXNi8GCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWgvdfbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWgvdfbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6901F00A3D
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908201;
	bh=1HURYdC0tSC+fz+SZBWgvNfTKqnLjTT7rEurc+hFXcE=;
	h=Date:From:To:Subject;
	b=MWgvdfboAxXWBap6yH8dMsLWbouZReIeRkizwU/QM7vIuI7Pp7WLcsFb+P+fS8n+b
	 eFcYfnd9EUxK7Y5TB0cBvF70BOXmoreXD5mQPZXyEWIwOqajleUYD3jpVmTZHHuxzA
	 PPS+KZEV7pIyq1ysd8rsz5HLrSeNbUUu60UWovfpsmckJoIJ5vPWjUrq5XTvCuORov
	 1/hxIvfJS+WRRKuhfS/+ZQax17gmX01Olb7KupsUn20/Xp/H8/7XZghglRGv+fjDtM
	 OLU4aYTznn17b9EtntuaVOprgFrqhghhsE5z0KChH4Sj86teZ5S8o8N2WE+rPm9SRY
	 8vl3rPdE3jesg==
Date: Tue, 8 Sep 2026 15:56:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] patchwork turbulence
Message-ID: <20260908155640.02d96800@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

JFYI the kernel.org admins upgraded patchwork, which broke a bunch of
things. One very visible issue is that a number of patches go marked
as conflicting with other changes because patchwork started serving
invalid diffs during download. Ignore this false positive red check.

You may also no longer be able to use computationally-expensive
functionality within patchwork without logging in. This AFAIU is
supposed to help with AI scraper-induced overloads.
