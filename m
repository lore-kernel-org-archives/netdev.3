Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422710;
	b=Tp7NU6QIWfU4ehrcPP9I6yQX/NnhdUTCFFNp1+3vQo28IYQjvctk7gbuXU5GE4BsKYM1
	 ApG640lrEnuMptF/kb3AtX7ug+AbWO4szlZ9GNjdgS22sO+imSOh7fcpL6Zm2OpCP0ArM
	 wmuSOS3hyI5h/+pgKlhis0MXAFavfN5/cBp2VerPZv3HFLL8fUt7f9BHAyPryp0rPrQTR
	 BQbnY+HONej3F6XwIXMgQQ8UIROcjxPkfyePnCEtDZ1QPFn3gDNrOdaJRAFYiOtvj/2ci
	 g/vMN+58oPAsYSlrfy1yosmm37X3qsKkcl34Icyh18vya/tMwaemhtbqTPi6SYCfoBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RLXIhLCf/9C679guusd4Cass0BZ8cph69Gx5b5prPFQ=;
	b=zU9OBM8fFwH1c1XbEz0pkWD/c4J8fYPTuvnn11CbfnVaF3iEHYv4rsy47ONu77xDpoy4
	 lgUI0wV+C80ovbVpp6RX8U6mChUhm5/kGRIV+hVAh2xGl+ikvJgTUcL17MDGFUgRB87Kq
	 WYq+i56nH33LOsxerUXtSxqDWFSOAMJqm14yyIzDEHHYZqYmwPtxguqmRVTaVcuWCuTpT
	 r7qgst9BSVPrXcl/WYfP4TqyaMvnYhtQcUFdHKJmT/lueK66DndT6FbgFwKFZmsCGP5Ka
	 VSbu9fnuaIRhcB4NPHhzCtqA62NUDYkL6fxeoNYarjQPOHj3USE7nYVerq+mhkyL6xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsbJGhK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FD606A330
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsbJGhK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33881F00A05;
	Wed, 11 Nov 2026 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422710;
	bh=RLXIhLCf/9C679guusd4Cass0BZ8cph69Gx5b5prPFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cRsbJGhK8y2n8yVkHGbTVmqejSoGbLI9CUPxt+b7/HsjlblofRzDnQmsa2W89oXar
	 oKXMtWIpomfFZq/+ML21n4YMJPBJGGjc7KrRggnL/t4qFRkPceRgS9KWaV0UIHmmQS
	 ewF28mIz/xiRcoTymi8YHNHgWpEjXV8xdxrpDBmySN9ssVaWBdO22zjgDvzmBEepC2
	 pw0FK8lDAo3kogTfni72Jklgm+e6YBhhRA42VGii5bQEwEJu5zA4P/lKVu7r7tg01u
	 lwqEoysuCpLI1h+8DdtjiSZ166Y6wjM/UZD6ciRfvSsfH9S0RVKqJPmjDgoIFp7rYF
	 2lg6RLYq2n9Aw==
Date: Wed, 11 Nov 2026 10:45:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Subject: Re: [PATCH net-next v2 5/5] hv_netvsc: let the core take XDP off a
 netvsc device that is going away
Message-ID: <20261111104508.685dbfe5@kernel.org>
In-Reply-To: <179439413336.2199510.16556459400141468213@kernel.org>
References: <20261109194843.1353592-6-kuba@kernel.org>
	<179439413336.2199510.16556459400141468213@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 10:48:53 +0000 netdev-bot+sashiko@kernel.org wrote:
> > +		/* The channels and the VF are gone, and so is the program,
> > +		 * except for the reference netvsc_suspend() keeps for
> > +		 * netvsc_resume().
> > +		 */  
> 
> [Severity: Medium]
> Is "and so is the program" true on the unbind path in the failed-suspend
> and failed-reconfiguration cases that v2 targets?

The goal of this patch is to stop returning the false positive
errors when core clears XDP prog during netvsc shutdown.
This would trigger a WARN() in the core once core tracks the propagated
programs. The 100s of netvsc bugs are not my concern.
