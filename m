Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708949;
	b=K6yRpBgsrqM4+bx7dNybtAA4V1CQ++DV9J3yKq8w9GFymhtvUNaprE2kCmeXP7EalKbU
	 JSQcaIDhCdIhLNIND1HybLnpOZnqdzO/HextlNocl64s86Sj3/1ffrodODbYQmkeY+sHE
	 DUu2huEuEx6a6AyBX3pFXaZZCZBDQm3z1MlVSeqGv7ezKuWBjVKllaXAWcxCVkwpmEg7S
	 d84ODEhCskByJPuWzUzkXWdLazSSmfznsP4tAYSQegVxuLzmq02Ufr/xIr9Y43SSNSI8R
	 CEgDewZtqdJOrgJ+IVJjCg6mR6mra/PnYnXOxdhmyOjagMxl1FvbWAsorstJBpWchvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708949;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=dXVOtNhsvETk1ahsPbFZ/MoyUGdtPmlljazR6U0smHQ=;
	b=dR0c9gDKXi7S/TPaOcJXnaOFw3rlRMGZxuLrwJmUVfJumm0wH4HH/t3xrIgxzVMjzG6u
	 wkZzJaAeZmP2wqbiJYPY8XZPWO/wWDsEzLDkUSetyxFU2yrNc2o0B/qWWT81sb0gtuSV2
	 AOGc5DJU6ZhHKNj5hHZsalCgQxzyX8FJBXjJuejK5r79olHklvxDUZ+OmoJgNnIpHcu0J
	 lcodrJzzjToJChD1Z+k4UBxFLQ/cmRRUZIMqKKplPqnIrG1hFtpEnSSqX3nja6bfafz4S
	 +/KbN4EOvAv8Evs2Vz1uW9T8gI3WNeQTeDbhmY5aiFpWKF6szNKgUk16sAf4+5BK18A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=G8FbTDdI;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21F606A327;
	Tue,  3 Nov 2026 12:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD21F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=G8FbTDdI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dXVOtNhsvETk1ahsPbFZ/MoyUGdtPmlljazR6U0smHQ=; b=G8FbTDdIdsWdmXJ01ozv5hG06Y
	18tBkgYaIAwqj3XncFOHtbfyNV8W/nRIfmi2VnPtjMwAFuwYV0CH75MSYQpcJMCwzGDLAjWI/JmXa
	poVqs5D3yTb7VC/wav2qLKwk4etL9W5u0mstnb/DTt0fwYDRowaOa26u8Bz8LKHPAhTfImOLNBolS
	xHg9nEHfl9EU7sR0mVW6p4cDtvFHrd6RGLDwdBd0vwBkKRjT6SS9lvRIflCPj6At08lS8BbCZzy4C
	dNboULkGOqXHO+gjW3iX53rNjrqgooJEpMk5GarVLTin+neTKxO/9mXGxnRfAm56atoJCLuA9rSJW
	NQRvAAeQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xODdN-006vuv-0e;
	Tue, 03 Nov 2026 12:29:02 +0000
Date: Tue, 3 Nov 2026 04:28:57 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 4/4] netconsole: stop waiting for carrier once the
 device is unregistered
Message-ID: <aunTfNV9n8_eaato@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
 <20261102-netcons-fixes-v5-4-bdada2f03563@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-netcons-fixes-v5-4-bdada2f03563@gmail.com>
X-Debian-User: leitao

On Mon, Nov 02, 2026 at 07:54:52PM +0000, Gustavo Luiz Duarte wrote:
> netcons_netpoll_setup() releases RTNL and waits in netcons_wait_carrier()
> for up to carrier_timeout seconds for the device to report carrier. If
> the device is unregistered in the meantime, the loop keeps polling until
> the timeout expires.
> 
> Stop waiting as soon as the device is no longer NETREG_REGISTERED.
> 
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-netcons-fixes-v4-0-3857120c6340@gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
