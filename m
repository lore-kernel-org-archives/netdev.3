Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573861;
	b=QQwYq7IUuxA1F755SuwYfe7npfnR3nN/S/nrdSjkiNs58VQ5zcNn23DDRweJh3VOJXYI
	 y1hZxTl8/w+XJ8SxQlpbz/0oUrV/wqqMcs7UvIT5U/uuguOrHDjaWe2+TadU+tf64ODXV
	 IZmNJ5zQHzmsxCJOsq8jNRaq6Bms1l/aU8EPMncA7qZAYmuf2H8z6fLVHR3cFFTB1OGIO
	 6nmsqPCDKthHKoP7w1VfN1Bwx78sCa2cmqLWia6DoPcE0rcGWGlRZlXY1+viQovxmo7vF
	 ijxI3JtzWn/Ulg7ywggfpx2uMQTiYUeGjP180Cn7G6voFggtymI4xqsrEAzewjiBgCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573861;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y5ygzn+mCyBWWHOdQ1MZcvZ5pM6jb7ZcWe0s7vwGCTc=;
	b=tSO6xvdJJuEd5MnG7e3XQ4X1U0qwUgD45yM7Gtqbm5+cgtPOVcnTatoa6pVkD8ur/wZ8
	 YXzniVwg5dxW83HVytQb3azSdmirbBWbNch7kumzvmDz2RQiYuRDend3gz+Nq/oCsAg5A
	 uaU3AvDdgH+wwVeD6vsEUS9LI0Zts0N/Q3uILuuCgUa5seHHME7lt86PnDnntD8Nmvt6x
	 YH+FplztY6i3TKrLPOsh6RN9r30mGZuUuhi0BAIPnAgPfh7mrNDyg3CZ8pP2CrLR9193J
	 a7RN5VFllLe6RYGgdcELxmhXcf9Lsh10hzMNMxV3/KBm4oE/DiqTlyQWtUlxGrPk3Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyCxD9dv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02535606A327;
	Fri, 13 Nov 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyCxD9dv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3D21F000C4;
	Fri, 13 Nov 2026 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573860;
	bh=y5ygzn+mCyBWWHOdQ1MZcvZ5pM6jb7ZcWe0s7vwGCTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HyCxD9dvPdly9/3jm+F+H4WIIowVKdBKyQr29xcfBgIl7pbXB51qAy9Wb2AgQcn8o
	 pF98CKJt1iGz/+9FO/X/bM87O9kBiDYpGBQGbdzCl2kWoqFfammBS+gFXiH4W19Kg+
	 V+5uDKlaVoAU34+DmEPa7pSZFYRHmiqC5H0hxwASLiIfN+VBlKnnghiHIGrvm+hPtn
	 ff//wbEFH/+FzgfiR5qhql9Ac91lc1CpfLuxiPnqXeAuYM/oi6XPwgig8N5iV43Byf
	 gZFhH8WPkE4SyQYGv/M+8uLUyEvkW1r2lQtWN0xpk6b14oSBd8JRZ8HcpNtF+SrP06
	 6eP3SrrWx4mtg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRqde-00000002B2B-19A4;
	Fri, 13 Nov 2026 13:44:18 +0100
Date: Fri, 13 Nov 2026 13:44:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
	Randy Dunlap <rdunlap@infradead.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH 03/14] docs: security-bugs: never publish reproducers of
 bugs with a security impact
Message-ID: <avcGInkdsphy_n1v@hovoldconsulting.com>
References: <20261109080240.29444-1-w@1wt.eu>
 <20261109080240.29444-4-w@1wt.eu>
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
In-Reply-To: <20261109080240.29444-4-w@1wt.eu>

On Mon, Nov 09, 2026 at 09:02:29AM +0100, Willy Tarreau wrote:

> diff --git a/Documentation/process/threat-model.rst b/Documentation/process/threat-model.rst
> index 04e5df6a6f78b..72cb36dd383d6 100644
> --- a/Documentation/process/threat-model.rst
> +++ b/Documentation/process/threat-model.rst
> @@ -105,7 +105,21 @@ In the Linux kernel's threat model, the following classes of problems are
>  **NOT** considered Linux Kernel vulnerabilities. However, when it is believed
>  that the kernel could do better, they should be reported, so that they can be
>  reviewed and fixed where reasonably possible, but they will be handled as any
> -regular bug:
> +regular bug.
> +
> +Some of these bugs may still have a security impact for a few users, for
> +example when their exploitation requires a dedicated network link, a crafted
> +device, or a crafted file system image that only root may mount. For the vast
> +majority of users the impact is null, and such isolated bugs do not represent a
> +target worth writing an exploit for, which is why they are handled publicly
> +(a CVE may still be assigned later by the :doc:`CVE team <cve>`). However,
> +publishing a reproducer or an exploit could put the few exposed users at risk.
> +For such bugs, the fix is sent publicly like any regular fix, with a commit
> +message that does not detail how to exploit the bug, while the reproducer and
> +any exploit are only shared privately with the maintainers and are never posted
> +to public lists.
> +
> +The following classes of problems are not considered as vulnerabilities:

s/as//

or 

s/as/to be/?

>  
>  * **Configuration**:

Johan
