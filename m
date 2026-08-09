Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896010F0;
	Sun,  9 Aug 2026 04:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786250027; cv=none; b=OFdEhEMKaL8vJ+9fuzPzYrfI6qekvyAl1zNh2UGhsMwGpgh6Y1DZQQgqjo+RwfcDnKMN2nYE2ZFhkZTu+xdwDfqOlSeX0d/2l2est8TqIzjnC35tIoHeRPzDfpzF6nufFN/JMldh1Eiqa7/Y3jaYWgiiOFkLUcf75Dvv3tge90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786250027; c=relaxed/simple;
	bh=7LOuCTS3Xwuulza0hUxIfNu6s9FcUt96tpWYouqPuP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWFzX8i6cv48ZAUjtPdelUqwGRtCr2rYLfaQq8G9QUw0AvSwCDsoVtqqPBvWkcNpQi3HEDXOm30P8xW4U1JOwjXMxkihTAKtqAl65fW6AmOgH0fivJt5ItnAOKzYKi4o6ghUHCQb2is0IDqGYKSruMtKC368yApvj+wNvBx11AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=22k//EK9; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=M0Tu2MzN; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="22k//EK9";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="M0Tu2MzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786250024;
	bh=7LOuCTS3Xwuulza0hUxIfNu6s9FcUt96tpWYouqPuP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=22k//EK9EQoyN+mVQtHWxzGc9NLFqrEXj72O6rAlS3jHQ3SipxAr/2TCVH0WnjsYq
	 qWn8oYsnS4J2cYGGnnx+LO+5+ExgZjPse2yqCP/+9KQ0LOdpY+Rc2p1YR2bfLGloq0
	 9qFQgZMHEubQ1c3oCJKwyt5jdVaGUM1hCDAqdYeMNQ0GheG4fchDKBNy32F57ZFsqk
	 OFgavQh7taH8cOR2l79FBsIOuOWOkvyarCWXZwX9YWPqFuNslNiW2/hBfcTO30bcjP
	 CEH9A89uocsv3VdqoIMjcdorqJFM4x5bIOvEHWM8UxoMR7ev+UPg5Ry/evqrsbXOld
	 0/clEknoxpnCw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7E9E549751; Sun,  9 Aug 2026 04:33:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1786250023;
	bh=7LOuCTS3Xwuulza0hUxIfNu6s9FcUt96tpWYouqPuP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M0Tu2MzNiSqLgehgcBDY6zt2UwIdcex58Vnc1lmngzN2LsQQhdvt/55OWCmY6II4N
	 LGVLUXUlLtDb06t/HOwaNNx7qBXIc+ytmyDzDIhzk/QXyVhGM8CVbGWVuMB2+8zrQy
	 hx60wZZCrhyLyT4hbJxH7IGVSkrvl/eaY0DjE5VCa5FQVWeYBWeVhhOiSOabWi9Mke
	 Nsx69viaIZPPU5NufviTrkMQYESz1Tcz5LJYZvl1z+ni9W1LykVn2AmILgPaTHRwD3
	 +o4K8NKLINGv8sPyBxRkWE6mioW3zMVAjil8Zu3lfgRXDQHz5ZZlbdhfwDHJz5vjp7
	 d3dfI3VFTp9zw==
Received: from [IPV6:2003:c6:9f06:3400:435a:e092:2ab7:871f] (p200300c69f063400435ae0922ab7871f.dip0.t-ipconnect.de [IPv6:2003:c6:9f06:3400:435a:e092:2ab7:871f])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 1FA514130F;
	Sun,  9 Aug 2026 04:33:43 +0000 (UTC)
Message-ID: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
Date: Sun, 9 Aug 2026 06:33:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Jianhui Xu <neuromoments@gmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
References: <20260806-ax88179a-v6-0-fde7414619e6@birger-koblitz.de>
 <20260809013628.3165246-1-neuromoments@gmail.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260809013628.3165246-1-neuromoments@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jianhui,

thanks for testing this so thoroughly, again!
On 09/08/2026 03:36, Jianhui Xu wrote:
> Hi Birger,
> 
> I tested v6 on the same ASIX AX88179B adapter (USB 0b95:1790,
> bcdDevice 0x0200, firmware 1.3.0.0).
> 
> The 13 patches applied to net-next commit
> df13c1df8147675470213ffff29dd5762fa321f5 and built successfully as
> 7.2.0-rc3-ax88179b-v6. The full build and focused W=1 builds for ax88179.o
> and ax88796b.o were clean.
> 
> All 13 fresh direct-kernel QEMU starts completed a new DHCPDISCOVER at
> 1000baseT/Full without reloading the driver. This includes five functional
> runs and the eight independent suspend/resume runs described below, so
> I did not reproduce the v5 cold zero-RX failure.
> 
> However, I reproduced the intermittent 100-Mbit carrier-without-RX problem
> in two of the five functional runs. In both failures, advertise 0x008
> negotiated 100baseT/Full and reported carrier, but ARP remained incomplete,
> bound pings to both the gateway and test host failed, and the RX counter
> did not move (60 to 60 and 61 to 61) while TX increased. The same
> transition passed in the other three runs.
So the bottom line is that everything works, except that there are spurious
failures with 100baseT/Full links where RX is disabled after the link
was established. I have so far not seen this myself, but will test with more
and different adapters as link partners in order to reproduce the issue. I tested
the 100MBit connections mainly with a AX88772E 100MBit adapter (UGREEN CR110),
which has the same firmware (1.3.0.0) as your and my AX88179B adapter. You did
not mention which device is used on the other side of the Ethernet link (or maybe
I missed that), could you specify this?

> An immediate readback in mac_link_up() was not sufficient. An exact build
> with that diagnostic reproduced zero RX after an EEE restore, showing that
> AX_MEDIUM_RECEIVE_EN can be lost after mac_link_up() has returned.
The only way this could be coming from the driver that I see is via a call to
ax88179a_stop(), which would clear exactly that bit.
Have you traced this and can exclude that this function is called somehow?
If this is not the case, this would mean there is a bug in the firmware
of the adapter which clears AX_MEDIUM_RECEIVE_EN in some cases for 100baseT/Full,
which seems to be what you also seem to suspect based on your proposed patch.

> As an experiment, I therefore added a delayed check one second after
> link-up. If carrier is still present and AX_MEDIUM_RECEIVE_EN is clear, the
> worker restores the bit and verifies it by readback. The work is cancelled
> on link-down and synchronously cancelled during stop, suspend, and detach.
If this can indeed be attributed to a bug in the firmware of the adapters, I would
add your patch to the series with an "Authored-by" you, as this sounds like a
good solution for this issue.

Birger
