Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092751;
	b=XKlXDnE8+G8X3ViTn6lxssHOnP0vRtOiUM8DXYkGV/B6YcJQhCtDxPcXJRIS8PLu6PqK
	 w4f0tWAaJhn10penVmU3O2FzNDhlImX68CckRm6kAXLFN+Am0Fep7Jn5MypsVkRu2D+oE
	 r9x/fhZYgNybI+KLuPRmVsfkTusmKb67xD+jxxYKDce1Ygj8xC4uJVLXvp10Lkv9NkOSZ
	 bNmVA4tm0TsEZgj4KFO91/HInh6idIc/oJEydfhpJBWzFouZaTuHSxziyVU0zrbBbCb4G
	 qcg5hep/Sb3az5T8TYdMi+xASQSeFqSxhjh4HZU1Le1XqSn62ylAhQ8ixH1WM7vLrRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092751;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=0caqeUvhoyd73MwX92KLCVLJ4OlRT1yAOV5WgVoUV7g=;
	b=aSfWk8aLoBb8+8W1w4j88YiOBzsygUUGIqalOTkpMWIR6BaMaj69mbJZoeQX98ll4cTg
	 wZQwjdJPezmW7JL9xTXMbf52P9gvde7mBmcWWHRevAfa31v4kmf0c43ohQbp90SLF7b8b
	 2+z/Q8TtHaSPZAe3O4TanHzIvSawWr85yHhi4fYyf4OZkIEbuupDtJ/0zA7qdx+My7UH5
	 /n9bIL10HHQ3f0oiH+AEsBejtHUiumdHpiF1DxiNUZLiB/Z7DHpVc1gUzEQpntwVh4B04
	 4HkAdKs61j4P08LiRM0AmmYi8E01B0YKPeC77WF9ehw/XHkf9x/IBLUKuxt15WIXaoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vX34J1gO;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEB606A31B;
	Tue, 27 Oct 2026 09:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vX34J1gO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0caqeUvhoyd73MwX92KLCVLJ4OlRT1yAOV5WgVoUV7g=; b=vX34J1gO9ozZgfa3Jw58sG6Q+3
	rL5VazSTDov9tbeKxe5PA3CQUSHnZqzZeQ3Z3AtBzt6EmOKlClFYDTW8zvKaHR40I8j8pdQv+h+JH
	zIjXw+P9x4btEh/HukiBfONb1qlhaw2lrGPOCV0fQA3BurEFLksbLS+TmmK/atmIDGQiU2/1nrqn+
	Njm+nTNYFJqbaNwxB3HFNQ15E8tki3Vks3ih5gOk12nPuqBflB50qAhXLlKfxzb1P8QqLJ2XPaVgq
	Iu7hzpy2cSeRVc7JQ4eKXuuG/h97dZkdZFRYTeKcPWaYoL1a78tb7YgHUSWM0q0QnAXFIPwz7YwA0
	j1VhnP7Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLdKf-001M1U-0y;
	Tue, 27 Oct 2026 09:19:02 +0000
Date: Tue, 27 Oct 2026 02:18:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] netconsole: recheck device registration after
 waiting for carrier
Message-ID: <auBrysA0RUkVlTOA@gmail.com>
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
 <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
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
In-Reply-To: <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com>
X-Debian-User: leitao

On Wed, Oct 21, 2026 at 03:19:07PM +0100, Gustavo Luiz Duarte wrote:
> netcons_netpoll_setup() drops RTNL while it waits for carrier when the
> device is not yet up. If the device is unregistered in that window, the
> NETDEV_UNREGISTER notifier runs before np->dev is set and has nothing
> to match.
> 
> We might then end up setting up netpoll on a device that is being
> unregistered while holding a reference to it, stalling
> unregister_netdevice() in netdev_wait_allrefs_any().
> 
> Add a check to confirm the device is still registered once we retake
> RTNL. Release the device reference and return -ENODEV otherwise.
> 
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-netcons-fixes-v3-1-1aac85ed7665@gmail.com
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index be7eb632ee42..bd36ebd334aa 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -534,6 +534,16 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
>  		rtnl_unlock();
>  		netcons_wait_carrier(np, ndev);
>  		rtnl_lock();
> +
> +		/* Check that ndev hasn't been unregistered when we released
> +		 * the RTNL above.
> +		 */
> +		if (ndev->reg_state != NETREG_REGISTERED) {
> +			np_err(np, "%s was unregistered while waiting for carrier, aborting\n",
> +			       netcons_egress_dev(np, buf, sizeof(buf)));
> +			err = -ENODEV;
> +			goto put;
> +		}
>  	}

I think there is a better way to do it, inside netcons_wait_carrier().

netcons_wait_carrier() loops waiting for the carrier, and exit if in
time_after(). I think it will be cleaner to exit there.

then netcons_wait_carrier() would return a bool, and you goto 'put' in
both case (ndev->reg_state != NETREG_REGISTERED) or in the
time_after() exit.

Wouldn't it be better?

Thanks for the fixes,
--breno
