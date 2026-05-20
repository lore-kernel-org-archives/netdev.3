Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AD2C08D0;
	Wed, 20 May 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243009; cv=none; b=M8GAAu2FcT415UK1BYb7+tStU5n2wvH9L+41q8Ddl7Hgik+1T/RFX1DKMf+UFcyFJNllS6FJy1MshqdjLpKckdYltT2Fa+C7s54q6fAv6IwztFRafGG2+YUDGLxJs7D8tPkIGpgLFwDdGkwdWcoOxkQHReQxpoWaN2dhsgkngQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243009; c=relaxed/simple;
	bh=2nZv+NIHZShJEkfNkkw/ovtI9wmtnBemM7UkZHTCnpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUTYT2aZpzREB11qGpHaYQ131kNaNdlorlQOKHX1Xqm9KhmMcPat7tQ4JK7+pMZZ2OBTHKZ8lKIYhDvufLjjIEdvmOktQM9Ale6bJbzYgv4bspGsAfEAXNFRzf3XDjRct4buJAUzocU2j11oYMkSEo2h7eoxwClc8LY2GANlbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cykZcfJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cykZcfJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5B71F000E9;
	Wed, 20 May 2026 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779243008;
	bh=a7ZtFUqF300mm+jObkR+jptFWEW80YqDlE5BXGP3XHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cykZcfJbGGlTjjq5jUBLW9ISf8F6RJYZ4/WVkUWXH5PYEoyWsvCAugw8oW11xDrbt
	 DOqXC+M4rES1/QSRucHjEvHWU6zLDiVbTQgpktdjNakWJuc0XNxVB5E5Kp907uMIp6
	 Gw7t6EBuMOgZT0Y6zmYL3ZdGxzABmKG3sP/c5ZdAXXnfC9MngaKfNxLb6DEpc7ZM4T
	 aQc6dvPaUqYrdKIAjBVmoVTz1ImEZVWQmDXq83WHjf0vp3qSla6D/XdefaB8dSgoU7
	 UqugBUTmTNL3KcU1h43PAw9WlBvl0O7//hsZNn8unIOy5AxgTWdzDf2vEVxPtyyj6A
	 KRA9BPhXfLTEw==
Date: Tue, 19 May 2026 19:10:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Richard
 Cochran <richardcochran@gmail.com>, Pascal Eberhard
 <pascal.eberhard@se.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tristram Ha <tristram.ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 1/8] net: dsa: microchip: don't reset on
 shutdown or driver removal
Message-ID: <20260519191006.01f83aed@kernel.org>
In-Reply-To: <20260515-clean-ksz-2nd-series-v2-1-35a968a739f6@bootlin.com>
References: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
	<20260515-clean-ksz-2nd-series-v2-1-35a968a739f6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 10:38:36 +0200 Bastien Curutchet wrote:
> @@ -4170,16 +4170,15 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
>   * the wol_enabled flag accordingly to reflect whether WoL is active on any
>   * port.
>   */
> -static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
> +static void ksz_wol_pre_shutdown(struct ksz_device *dev)

this needs a kdoc update, did I not report it on v1?
Maybe I forgot. scripts/kernel-doc is buggy, unfortunately
and doesn't catch it. The fix is on the way.
