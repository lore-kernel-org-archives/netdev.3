Received: from mta1.migadu.com (out-142.mta1.migadu.com [95.215.58.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161B242D6B
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881313; cv=none; b=LQhNXxTpFF2sW+nsMAB0Sv+PR5c2UrElo0uHJAoVdbmXTTw0rD5UfJBseTlF4WwwYBArjmhfx8Qyf2UgV3oOkhSvyWQh4ms+XHY1CdV5QRFsD9ChrhD1zLsyaELCh0rPimq2wAWp6a6YNfTbc2rrwfnx+FuwTuFEnghajliJGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881313; c=relaxed/simple;
	bh=kpSeqosgnracdP3JFhVUo24EJrTnvL6cnEkIWNBdVcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A99/mA5whDKMYHkzDLa8sSvbZqXa0uC/AFovr2tn5NxdGFlLprX/RdwY2Fz3Z6aDkU7UU5h73iB4rByuaRj3rSZZ8y5ADi7qS4I8YycaeaTq2l2rgdqeSr8Lz1Am/63VpXelz/rn2gl+e/GkJtz4OqhWkLHvwfUwh9OIESyzOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lveLZiHP; arc=none smtp.client-ip=95.215.58.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lveLZiHP"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kpSeqosgnracdP3JFhVUo24EJrTnvL6cnEkIWNBdVcU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787881310; v=1; x=1788486110;
 b=lveLZiHP5CLBdFszOjllxy1ugPPHxcZqAX5ZZP5GVtUXmRzKPRcKVU45AojQ26pFnwBLe6fH
 JM71ZKmZs8UukaWysy6cdfX/+UHAKujfOq96iAsunM3xkDlGP/JnElo+lq6m6f1d8VECLpu6hqT
 dkLCgBFeePnHvPbQbLkj+VFU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b6996e5a22c93adc;
	Fri, 28 Aug 2026 01:41:50 +0000
X-Mizu-Trace-ID: b6996e5a22c93adc
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 09:41:40 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [ynl] how to fix the order of selector and `_decode_sub_msg`
Message-ID: <apDnVCOroIPIhFWG@fedora>
References: <ao2PN6wp9A2SjRar@fedora>
 <20260827101416.44f53ba5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101416.44f53ba5@kernel.org>

On Thu, Aug 27, 2026 at 10:14:16AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Aug 2026 20:48:55 +0800 Hangbin Liu wrote:
> > Hi Donald, Jakub,
> > 
> > Recently I have been trying to add encap decoding support for `rt‑route.yaml`,
> > with formats similar to:
> > 
> >       -
> >         name: encap-type
> >         type: u16
> >         enum: encap-type
> >       -
> >         name: encap
> >         type: sub-message
> >         sub-message: encap-data
> >         selector: encap-type
> > 
> > However, sub‑message decoding is broken inside `ynl.py`. The root cause is
> > that `lwtunnel_fill_encap()` sets the encap‑type *after* the encap payload
> > data.
> > 
> > In iproute2, `parse_rtattr()` extracts all attributes together. In contrast,
> > `ynl.py` stores attributes one‑by‑one into `search_attrs` after they get
> > decoded (_decode() -> self._rsp_add()). As a result, we cannot locate the
> > `selector` while decoding the "encap" payload.
> > 
> > Should we decode sub‑messages after finishing first‑level attribute decoding?
> > Do you have any suggestions on how we can fix this?
> 
> I'd change the kernel to output the type before the data.
> The code seems to be trying to cancel out cleanly on EOPNOTSUPP.
> Which is a good code pattern in principle but I don't think it makes
> sense for dump / get. And no existing ->fill_encap can return EOPNOTSUPP
> so instead of complicating things we should just move the type before
> the data in the kernel.

Thanks, that would be an easy fix.

Hangbin
