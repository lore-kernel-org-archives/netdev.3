Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DE32ED27
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781737009; cv=none; b=D6avz7ybNB8+hBP4chs6B9OVG2cb4N38geIndawA5c3wQfRf+XtqIiOOiiYVZQyjv7d+8KHnw2p7iOTLP91A8ZNzIuBBkxWsoeGCgo8DOPr/KE/UAD9oMpIv71eVFPekgxjlT1D8dRYTEv39LnxzFPqfcz8aTezd6yvIzesiavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781737009; c=relaxed/simple;
	bh=RvctmYDa3xZVlcrU2f+tZVPrXqI+vNI7nKiwIvKMQtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJiq5nitUoB2VaP7ujMq76wU2vSd8M+7EoWIor6AISbKZh7vSF/eXg6/7i+d80hZjQK3WtefOqP1HEaT55bOwOL9XcaH203N+xJ2gOHkaVAMu1uOAeMbSd4kcf6Fayi8/cix2da+iXXvBruwGb71Ce97AsBptqV/EzDxI8AUbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMKbd+BA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMKbd+BA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28741F000E9;
	Wed, 17 Jun 2026 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781737008;
	bh=RvctmYDa3xZVlcrU2f+tZVPrXqI+vNI7nKiwIvKMQtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HMKbd+BA8bmmKJQurj/KD48a8Atr0sJAlpbYv7wc59eHONfgy3yAOvToYw+INLhxu
	 xw1dahST/ZtM8e9EtLWxwGGs4KXpnr2Mx95NQQ6qPCB8d924yZLnx3+LUGhPi2VMNg
	 Ew3LuRXbAYJldhc2fXNO+8EZCYbf2P5z4C3VLpAZWXDBVKBGgETgJ9ROntn7qQsrmy
	 hqdIjesPPVbbVypdaIVRR8R/35crk/SkPCdfS9XuX4yoGbxFAdwrWBOlZouXbPgi12
	 EZdCGLZlb6OK9fwi1V8MpbPwS6cdoWQZ+k0W9NFT9gyf9o2U2MWrgi3wcGHI0FEtmS
	 oYgN8flROPHAA==
Date: Wed, 17 Jun 2026 15:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@everpuredata.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v14 6/9] tls: device: add TX KeyUpdate support
Message-ID: <20260617155647.78e3b3c8@kernel.org>
In-Reply-To: <CAKaoeS3mTGUo-dvtdmQfz3JAnn69-e36xrj9YmjbWTnsiw9uqg@mail.gmail.com>
References: <20260515212715.3151307-7-rjethwani@purestorage.com>
	<20260525211608.2508449-1-kuba@kernel.org>
	<CAKaoeS3mTGUo-dvtdmQfz3JAnn69-e36xrj9YmjbWTnsiw9uqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 15:32:58 -0700 Rishikesh Jethwani wrote:
> From: Rishikesh Jethwani <rjethwani@everpuredata.com>

Please keep in mind that net-next is currently closed.
You need to wait until the merge window is over (2 weeks)
before reposting.
