Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF664C74
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751759920; cv=none; b=fFnZwjzgYnx9q5sdCxnaZ20OH+obuvUfBit7L0a6F2LlgyA6odoxOzm4mmRcfglMBcPc8SCrLm/oMOhb9RwOtqN2EqM/71RM6RTgECUjnIv42KpBigC5mQXuT+Rsk6g/M/sXT7kWFX/FcLZCO6ipjo9alEL825Nhkczh5ZFbsUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751759920; c=relaxed/simple;
	bh=acTFcej2Y0fpTkgqMV3QzFQJ/DnWcIn+O7Rc3vAor3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL35dVFhx27F854Z+9HVe9W1/f7vRLvFbDBHS78uangZXxEz/yCWeGiIgbBOdxEjnRaUCpdvOqCNvpkV+H3Dg3VC+RhwMq9uNAgb10Io5RoFgT6+Jay7JH/gi0pOyiW4/KmygHM0oc6N7oLbMjNsEYOz+S+Ed9cMULi9w0pbp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 67CA460FA9; Sun,  6 Jul 2025 01:58:29 +0200 (CEST)
Date: Sun, 6 Jul 2025 01:58:28 +0200
From: Florian Westphal <fw@strlen.de>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: netdev@vger.kernel.org
Subject: Re: nftables, prerouting and rate limiting
Message-ID: <aGm8JGRpR8oPQ2wR@strlen.de>
References: <388009b205bbb4046cdad4124e7e447d8f16d6dc.camel@interlinx.bc.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388009b205bbb4046cdad4124e7e447d8f16d6dc.camel@interlinx.bc.ca>

Brian J. Murrell <brian@interlinx.bc.ca> wrote:
> In that case, is the rate limiting being applied to only connection
> establishing packets (i.e. SYN, SYN/ACK three-way handshake packets in
> the case of TCP as similar to the above description for the filter
> case) or is it applying to every packet in the connection/stream?

It is only applied to the first ("new") packet.  For tcp, to the
syn (but not any others including syn/ack).
