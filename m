Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB25385519
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723964; cv=none; b=mXbdDqx5v+EZxmOMtG5om1+A3bXYiap9allNiBKczlS2vbKReguTjBmFBC0LZOPHTz0pljfWDxomdUqsFljmEwV8LvwjUek6Lt21ciw+OWyTozpsTNELqXZYEPZnkR3XeEUmfXoI4eYq20rEtiMI57ri6wGLlmF3OY+naVYdfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723964; c=relaxed/simple;
	bh=vLJPIkJDNTxgPfGn+jE7fN1tk1CROCLkukpsE7fuqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgqQmsifNzEmtp/Sn3iwjogE1w0odZJwz9dOmA/JOfpGEZZVNNCqw8ihWTB7GEcm9+o8kkt7YKhnnrEN9ppkzivqfTYK4jEkHjKNyyx4L1lthkZp8MvlGGtYrq9zBqu1LHpFp43b7hHY6mA561d0Jgkxejtpp5nVoH4rqpidhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqxEf95K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqxEf95K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C54F1F000E9;
	Mon, 25 May 2026 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723963;
	bh=vLJPIkJDNTxgPfGn+jE7fN1tk1CROCLkukpsE7fuqTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FqxEf95Kx+Touz5zOQbKB2YNNiJhgaGZRh/v1eU0dSZ8UngOZh38CxMNrx7S0xiph
	 rEBsWPaAmlyagpGpZn7mjkMKeZ6VKCFADZt5oWfvHdpH7FfY5AEN5ARgHiy2QdIFa9
	 XZgagJASjq4KTI8x8snnl4e1/VQQJjAiqemdTyCJjxlm43JTzDQQQR46jq2iwFs6iI
	 IjuvN9T6ObBl14Xtn0eKKaWd4hGlUyKw0jVcG7cM2tYq+7hqLjIlF1do1RySdl9bxX
	 jVpOp9jlJEMoYsxKdlX4o8G9YMlRyVzexbjCvai+dwHt5q3EqRTlG6OB7UjuXRMpkP
	 K03tQwEyC7vRw==
Date: Mon, 25 May 2026 08:46:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/2] pcnet32: stop holding device spin lock
 during napi_complete_done
Message-ID: <20260525084602.685e450e@kernel.org>
In-Reply-To: <20260525125437.4061-2-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
	<20260525125437.4061-2-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 14:54:36 +0200 Oscar Maes wrote:
> napi_complete_done may call gro_flush_normal (though not currently, as GRO
> is unsupported at the moment), which may result in packet TX. This will
> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> while trying to re-acquire the already locked spin lock.

Looks like a legit bug fix, please add a Fixes tag and repost for net
(rather than net-next)
