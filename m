Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98D352015
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740628; cv=none; b=uh28RwPn1uUoputTNPJWZON7iWya4LMYvwYc78KXbg3MLqoVINdV6zKGC+hmQPg/YXD4ANtBBRQldyacy9B5nWIT/8g15oRGA45aqhlR4DCOUUoHvorKyVLjTXfN+OdnOvTs+FiTy12xQlInQBXaF+5aeB5P+t373vb6L8JI0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740628; c=relaxed/simple;
	bh=lfmaxQzTvq7ZS6TmNhWzoMoI1Q+uVlWiXgkrEjdwqDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjJEFgP3H1Igc3tnirEJA+0+ajMK3MgTxTCLRUUQyuqukjHaH8kDHlbjwTlh8nY0c9lUVyDl8iwKlRaGBLPBj5GiAUmQwPdElGjC4J2+tCNDWUPB1vv6UC3HNrD+tpEZ9Sv2JZBckSSykq3gt938UVmCobWmoJF+FR2bPR8S+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFUvewKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFUvewKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEE01F000E9;
	Fri, 14 Aug 2026 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786740627;
	bh=61JLJbBjsmbNSKXa9DpEvwzmdAjUBYLgTDzPMZLNVCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iFUvewKf0FyipIHYu4BTYG61wRgLQYov40gLHjuGyBpGDJymjdhMWbvIB4Ctk0qx7
	 UhPMs7vZiWjPSz9hJKYiyY31sy+kZN2HoEB/C+kKarJx3Tohub0Ell9HEAS/jkJqC1
	 EyZTI1RvcahezN/v+wXnAKVfpoaH19Wau/fWLMcc/2SWpVLPo5dy0boE64RIPpQvRx
	 ZaNFITW1zTW4Hc1e9dh5pLqRFVDzOLdfGjj7EM4mHuXOKOYHCODS053BUZUi1m+4wG
	 5w9WRFY7hmSiWcdP9z48lKlMqrAWyuix4qdhLhH8fTgBYwemqaxbIoj2k3YdT4bi9A
	 oodisw25wmPWQ==
Date: Fri, 14 Aug 2026 13:50:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next 2/2] eth: bnxt: preserve IRQ affinity across
 IRQ reallocation
Message-ID: <20260814135026.7b629337@kernel.org>
In-Reply-To: <20260813193248.2578626-3-kuba@kernel.org>
References: <20260813193248.2578626-1-kuba@kernel.org>
	<20260813193248.2578626-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 12:32:48 -0700 Jakub Kicinski wrote:
> +		 * Set after installing the notifier, if we race with the user
> +		 * it's better to overwrite than miss the notification.

'shiko warns about the race between the notifier and the init.
This is effectively the same pre-existing race we I'm flagging
in this comment. We ignore updates while the device is down
completely, I don't think it's worth trying to reliably delay
the racing user programming after init has finished.
