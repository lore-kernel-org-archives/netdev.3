Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40C4A5C37;
	Tue,  8 Sep 2026 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857399; cv=none; b=up5dZ4P2+fdptOsUugdYov8DGI6aa5DpTMLsNHUil/p8sWSdxjW+kE/we5udNsBjrvsYf5vQMU4jBTrO4JtW7pyVnM8QEDyJpY/jcgmSey7+86y6RGTJ6rWHitJWpH28VHVFwTSkpUzQLaWhXJnPB3PgDmhxKqsN1yy5o34Qcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857399; c=relaxed/simple;
	bh=hlX3Iqaqua/xtZ/oB2bfK4czVNom8a9KdVFrX/vRPgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLUtXNOT93FkmUsuHAULaQv65WAsZYaIEpSW1ZEi7+m4y0ZKAcPLiL/78eQGLR/0aEG/rwKXeVayEf2VI32+ug+Tp1yQbgz7iMImepdimOak+xwK7uDeIEXjrMS9BJkLeIMsx8F1S1ufHmEkIfoTUxiHTZNLUsXcxRMQAjZ0BXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux/6rO6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux/6rO6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BE1F00A3A;
	Tue,  8 Sep 2026 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857388;
	bh=evTVsArVkjw/HqhPNx1c7QC+crugD4MQPhZEQL5jwlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ux/6rO6WyuwRd+OGVJ78umAyZo6l9Bd2fqaSBTx2B8ZPGSUqSwd+e+yFn7eoSiy/I
	 yKI+9eHTCgRGCzskJizrsD9MSpz1NfzeFUh4Yb9jO4wZeUZ5WeIzRyzgMvNQnUAc6o
	 Y86+KAHVmcI7DSW+36vy34jQEn5EnoJ8z43eHno1Lj48LmpLG25przrp8D5RgqTgEg
	 P8MTlqi8tyZoNGPNSnrIOXJ6AqEAstWaTdDUK1e4g7c5KGt75gN2slwRtvcNE0L3K8
	 nwVTLhHCUQwO+1H4v90NAe0+SOURn/NmHcy4tLLS/SHfLDkV+r+nylMP9H304iJyc/
	 tNLIw3J8jHc8Q==
Date: Tue, 8 Sep 2026 09:49:44 +0100
From: Simon Horman <horms@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	andre.przywara@arm.com, hancock@sedsystems.ca,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/3] net: xilinx: axienet: Fix IRQ error
 handling
Message-ID: <20260908084944.GN40544@horms.kernel.org>
References: <20260903073252.339250-4-phucduc.bui@gmail.com>
 <178880965548.219967.14368880612178322930@kernel.org>
 <CAABR9nFGduckDNRGBt0NHdSHNPo1pKD1PJbtpw1eUqL200LCdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABR9nFGduckDNRGBt0NHdSHNPo1pKD1PJbtpw1eUqL200LCdQ@mail.gmail.com>

On Tue, Sep 08, 2026 at 09:51:26AM +0700, Bui Duc Phuc wrote:
> >
> > Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0
> >
> > - [High] Incomplete fix: the axistream-connected branch of
> >   axienet_probe() still cannot request a probe retry, and this patch now…
> >
> 
> irq_of_parse_and_map() has always folded every failure into plain 0,
> with no way to tell "not ready yet" from "malformed DT". Before this
> patch, that 0 was already turned into a terminal -ENOMEM, not
> -EPROBE_DEFER, so there was no retry path to begin with - this patch
> doesn't remove one, it's a pre-existing API-level limitation.
> 
> > Pre-existing issues:
> > - [Medium] DT binding and driver disagree on interrupt index ordering.
> >
> 
> This is a pre-existing issue, unrelated to this patch. I'll keep this
> patch's scope as is.

Thanks, agreed on both counts.

Reviewed-by: Simon Horman <horms@kernel.org>

