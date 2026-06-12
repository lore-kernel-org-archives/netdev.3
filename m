Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF34286419;
	Fri, 12 Jun 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261549; cv=none; b=sWt6TWZyJIqLYrLW6j5KG67vUvG84Y8svKX2N5SYvPtuj0Aa9rz6EwGn0Mmq6c0AxE/fjlm7xNU8sMB53hbs20qkgw6lKcmVIybR/ypE0UsNh1nlh9OqrKx+8oXr2AK6Imx1eMLLtXeLW/DkDeuVO9C69Y6QR/GjwFo7ckFGz8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261549; c=relaxed/simple;
	bh=MArvv7Ru88iKitGxkvVvZXHajfQ4Z50+pXbO5bZ1EAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9H8XVDDtkucy2L/8TI1MxUGlL7U6Nj/LGDhFmE9QNaI7CXos3tgHiql9dRvQqhUHH6kvWRXQPF/xPdm6XuYqY6kYnKlW5Rz/ENpMcW6cThHANqVQyHQ0kLyJRAERvLoYf+CsvGJYfsoh2z4x1HYozq6SqmRXlgFE9e76U265SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkHJRF8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkHJRF8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955641F000E9;
	Fri, 12 Jun 2026 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781261548;
	bh=n9EVBNJbDJiD2z8YzHu4nhzPOU2ESNG+J0ZNytBH0BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nkHJRF8GqRD9bDHGNq30uFrod3yNrXhAf+WwinbRGnhqmVz8r6zxCFq9aAUJOot2+
	 /SS7NurR+GdPCEz+rL+s19Ym/yWV2Y6cJtu9LC863FaQu3IyCQSN2kWC0ozJM/JRNt
	 wmLzWyKkYDSZTyjrk8yup2VddLyolTWhRWCjt121TQQbXWf+WnItq2techpr8wZZwb
	 hse4ise0HiDB5tueYFDLl8YLsX+KjOR5ZRoaLHZPNBZO8U0F/Nxjj6GLC6hMSXMgPY
	 QYDGzszx72W6ev27iybxGAEZg0VWVgUqa3JQJ9z72y39Ryz2i2KzVlFyRwTQDa1nIT
	 +CD7uzuCU1Gbg==
Date: Fri, 12 Jun 2026 11:52:24 +0100
From: Simon Horman <horms@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH net-next v8 00/10] enic: SR-IOV V2 admin channel and MBOX
 protocol
Message-ID: <20260612105224.GE625020@horms.kernel.org>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>

On Tue, Jun 09, 2026 at 09:32:26AM -0700, Satish Kharat wrote:
> This series adds the admin channel infrastructure and mailbox (MBOX)
> protocol needed for V2 SR-IOV support in the enic driver.
> 
> The V2 SR-IOV design uses a direct PF-VF communication channel built on
> dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.
> 
> Firmware capability and admin channel infrastructure (patches 1-4):
>   - Probe-time firmware feature check for V2 SR-IOV support
>   - Admin channel open/close, RQ buffer management, CQ service
>     with MSI-X interrupt and workqueue-based polling
> 
> MBOX protocol and VF enable (patches 5-10):
>   - MBOX message types, core send/receive, PF and VF handlers
>   - V2 SR-IOV enable wiring with admin channel setup
>   - V2 VF probe with admin channel and PF registration
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Hi Satish,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch.
