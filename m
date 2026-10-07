Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A317A2F6
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337087; cv=none; b=C2CCsFvhCYH0/nNYRtUoiHZ1yBPK7pv3zs+D1i1hwrJCUrE93CE836DcMousQHEsLNC0/n5ua/zqWrNlzi51Iu9+BTkXosCEA1+u5YwUMNg+tx8sHpM8o2NzpuYkVVYsottd3zKS2/G0arsKBvIFHV2NK/BMBr9OevFL97Ahd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337087; c=relaxed/simple;
	bh=1Q/KOcJs5etq/nzIcZQAPMnD8CA9HapaqYjT6YeRf6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mka8GZ14DqOJWlmR/exkoWdN2/9yMKso3rPoTjGzu4MGvtqmx6eUwqQo5WTiJAaBMkx2BC4iMwhIx7qQMoG3zvo2OffXg7cYvAL24WpfU+OzKBi7qcHBnDnRgusLFsrmY2PLBNR4Lq6U+4QzFu40v0Z9z6r1Cj4oKJLb7b8mowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCDW5Udp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCDW5Udp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80E41F0089B;
	Wed,  7 Oct 2026 01:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791337086;
	bh=q+q9CxwZyoZFVTt1wzj2eQJlP+VcEUlWimtLQHNtGIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MCDW5UdpIsv43jlq/vyPr3+RGprMpdXiraczdv1+553/geT4bE0dfVBJbxFh1/9eA
	 GrAiu72QoVljuXoQ2U16OlRi/eCnYzCWjKT9BijYE05X1M6cQpN2tahnr5hh4UpQCj
	 QjfyYHarIEVWbeWimUOPIPV5P0/D9qWP2jrK8T81G/HIenaVEfjmC0W8/nSX2JPvVb
	 RR1wMBFBQaDqQkIIcca4R8hhzDjeiCFTixfOkUcZVVOMxG1AIIqRILJHbvDLty7G0F
	 aNCTUaLOgAHmEFUV1Z/BpTh3gK3AEKRnmyQSGCU0qtc4nx87EM+IABVBg4QmBqVhGp
	 bip1G8v8PNwNQ==
Date: Tue, 6 Oct 2026 18:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in
 SW_RESET, restore it to SW_RESET
Message-ID: <20261006183805.125a09fa@kernel.org>
In-Reply-To: <61e7e89a-c04f-4700-8387-5cbe776460ba@broadcom.com>
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
	<179080972360.31693.266631430009737406@kernel.org>
	<20261001184130.2b7ab18a@kernel.org>
	<897ffc5a-48ad-4516-89f2-0cdac082d7a8@broadcom.com>
	<20261005182721.776af8b8@kernel.org>
	<a1dc7c80-acef-479b-ad03-dc83164d77c2@broadcom.com>
	<20261006154407.64ecac6b@kernel.org>
	<61e7e89a-c04f-4700-8387-5cbe776460ba@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 16:05:48 -0700 Justin Chen wrote:
> >> Sorry Jakub, I am not understanding what you are asking for. I believe I
> >> answered the questions above? Or am I missing something else?  
> > 
> > I mean other threads, immediate example:
> > 
> > https://lore.kernel.org/all/20260929203400.1588868-1-justin.chen@broadcom.com/  
> 
> Hmmmm. Looks like those missing info emails didn't hit my inbox. They 
> were sent as I can see them on kernel lore... Let me see what happened 
> there. Florian submitted more patches, but these should be the only two 
> inflight from me. But yes, I will answer on the bcmasp patch as well.

Thanks. I wonder if it's something about Broadcom email filters or we're
running afoul of gmail(?) with the rate of these automatic requests :(
