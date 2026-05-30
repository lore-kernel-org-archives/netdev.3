Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1DB29D26E;
	Sat, 30 May 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156903; cv=none; b=Be3j5XX18mN8BR1yAE+RltFvPauuyTVuAFh0nk/evhfIS9dI9lESVLSPipQllluDL9GsMxCSnCRYMc/WTeCnSZfT4F0qqJ9nSxua+a4/25ZdtPNyPmGP2un4MgcP2kv80eoj83+hI/2J1IiZxYV+ctxdC2VJNEM6DQwzatDcmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156903; c=relaxed/simple;
	bh=RmotepugSboKCrjRbQ7UdOdNYQFVdXVjLt/lyuYOKI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZy1+UhxlPlMmgwU5OQV8olYjsGWKc6fv9kIXjLbMOHvyliwrdYd1bM4PAEVH3yl0W56IfAH6Kun1Nqpg+qQhofJqf/9OF4lXqU6P82fbe/VaDJSPktB4KMMD6Tiw8s3LEORjqotwFtnYvQ4T9XRfQbRsQ/ZnNHVvJDlyS4HrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ls4NEO6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ls4NEO6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7741F00893;
	Sat, 30 May 2026 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780156902;
	bh=RmotepugSboKCrjRbQ7UdOdNYQFVdXVjLt/lyuYOKI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ls4NEO6to6vA7kKJVpphRT3t/crc0JjOceHLwJxqsH+2kYqtAyBClmr+WwSSgABGw
	 v3qPivb9oRm8LsxgDk28udNaKhcPsDROT71z2zyoZu6MndZkNFTh12FXHS4x5YJlpP
	 P5EPnzl/5o9stVpyyfvjQps6YMagi959o+mtXByQ=
Date: Sat, 30 May 2026 18:00:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cyber_black <Cyberblackk@proton.me>
Cc: "security@kernel.org" <security@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"david+nfc@ixit.cz" <david+nfc@ixit.cz>,
	"oe-linux-nfc@lists.linux.dev" <oe-linux-nfc@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: NFC/LLCP: unsafe userspace sockaddr handling in bind/connect
 paths
Message-ID: <2026053008-level-debrief-7f65@gregkh>
References: <0AJFeQ-7iEFm2WdHkRhf_kX_3FFbc3ONYxT3fxz75i4eAP8glmc1jmY7JOHngN73P9L6yPrflvcZs63EHu_XazAsLhPIe0zUrtdK7cKnC6Q=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0AJFeQ-7iEFm2WdHkRhf_kX_3FFbc3ONYxT3fxz75i4eAP8glmc1jmY7JOHngN73P9L6yPrflvcZs63EHu_XazAsLhPIe0zUrtdK7cKnC6Q=@proton.me>

On Sat, May 30, 2026 at 12:15:37PM +0000, Cyber_black wrote:
> SUGGESTED FIX

<snip>

As documented, please just send a real patch for this so that it can be
applied properly.

thanks,

greg k-h
