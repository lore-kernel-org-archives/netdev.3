Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3898328B71
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571314; cv=none; b=oOUp/on1NagKT36pfLMtEH/2vjAkyM/2/f1oq6Xzc9bhwX1npxY19oEpwcdr+c28wCjhOLuOPHnKGQdMPIdgpJCeldvz+vKFGbPL6A9MkpaUIQGXRJn+wmqrpBLM2lxatpyRSPhEbkkU6nV+/Bb3pD6QWPuU/CQ5pjshtFmw+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571314; c=relaxed/simple;
	bh=msOBHPL4JjjjLLHj7ablUexwrzLgZtyvs3DCUgAu9PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwI2U59DyyImfRARi2ZZg89SuHa0mfhBRGKpmjngF7aM8P0dem/TjobTDDXpOm91Vm1B6us2AG/95ReEvMrzRcGTsepXTThg4y4WOmTmGkyppUD+gE2GYYEmX7ddAufw0jsUBJtfZndO9UanqEOcPt23IITICyecpy/GQiySOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz3JlF/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz3JlF/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEB31F00A3D;
	Sat,  5 Sep 2026 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788571313;
	bh=alJkwn6vkMKqyuJlU3OF+3sMsnfyq6Vg40LxasmGGjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fz3JlF/noxJ0WZxtiKedMv8cIfVPn0r3a8RYSpDYpuIHheEkQpz1DdYKYxo8CswV5
	 HESbIIBSrCJUSz6R7RsikOi6zXg5P1oVzpwTuZUOjM1vro9HC5ONpUDryo488j/8zC
	 XZ0nSbe2ZL05idnvSBjhDAwBjP+7tkFrwXLIftly+tTHI5Q41r7a2oM4g+SwphN9nn
	 /kRArCAWyHfaswClUfUiZR9n68+OcqvEcpMrtL2UJBaMO23QFNrnrhg+I6n4vo86Dv
	 OZ3Fgrnf2c+MF975eLzIpyC6tt5Mf0t1oTe0iEWdQCh+r7IQZ1+luyH+Pq1A7IM4js
	 w5D6EAmhvthYA==
Date: Fri, 4 Sep 2026 18:21:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: nikhil.rao@amd.com, netdev@vger.kernel.org, pabeni@redhat.com,
 brett.creeley@amd.com, eric.joyner@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH net v3 3/3] pds_core: check info_regs in the identity
 debugfs reader
Message-ID: <20260904182152.489856d5@kernel.org>
In-Reply-To: <178857041188.219967.13424554495565611887@kernel.org>
References: <20260901044219.1361466-4-nikhil.rao@amd.com>
	<178857041188.219967.13424554495565611887@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 05 Sep 2026 01:06:51 +0000 netdev-bot+sashiko@kernel.org wrote:
> > -	seq_printf(seq, "fw_heartbeat:     0x%x\n",
> > -		   ioread32(&pdsc->info_regs->fw_heartbeat));
> > +	if (pdsc->info_regs)
> > +		seq_printf(seq, "fw_heartbeat:     0x%x\n",
> > +			   ioread32(&pdsc->info_regs->fw_heartbeat));  
> 
> [Severity: Medium]
> Is the guard enough when the unmap happens concurrently with the read?
> The test and the use are two separate plain loads of pdsc->info_regs,
> and identity_show() holds none of the driver's locks:

If the comment is correct the patch is pointless in its current form..
