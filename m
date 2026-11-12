Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442351;
	b=Pc/U2/gyDv3Ih8bK2zDhmg4YNd4bMQOHTkeU98EN9lg7W9e+Cj9GpfNDaXhnF1gHKPfm
	 umOetA72027tis5iggj9q3ka4r14nfk1SJa4jqJNSLuNxPY33QS4rLXk7htMM/8D+bIoa
	 oIbiy6EjFtBJ0S5xiIvxKuU1D9pU4mkI2/J1OZagQMjZ54ofeK7NOLQMCbQpEBY/EbxK/
	 bM/blR5VYnGCB1ixKF379L8KVVcRLdkzuXj7To8Z4zluG//5lVt+/EGC/35/1zXHWHavE
	 5IYSZl0mqLaXYOkouNeJ8hPAXUsxj+aRbFVd7EkYf5ko5RTVigbD8Kq801vxipmPiiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442351;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gTyO3X8pSKWt1MgW/zJVanTQYKSVAuU4mGWeixd1i6k=;
	b=j68YatJxHri4gFN0NQ+ZbhwHnooQCAKPdXYF2+7lsIbCVdOW3zJ8HSovCQzY0hxEbLMR
	 N/8hf907Sb1Vicpck1jDT0gf+rrn9EinjEF68Bw5KUtEzRrfFUACPGq50kqa2cMZ7zTcp
	 W/4GOVbzkjtwT/R2DDXoXikBHXPVes92AQ1oL8cEbB1CEKokjjm8e6g//wdyQTDQNnsET
	 /YOXibJmPi7T3aOrUHhGo0Vkp+lZfIkF3+eplZvUBq6VYH8/OXcNZaPHWhFyMMNyTO7ic
	 bzR4/ZW5zi65b5mqUYaLqz2/VdqUEJx6fDz8faTwqZifwo1HLAeDrWRdRTVCS6XoiWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9asc4pv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37257606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9asc4pv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A8C1F00A05;
	Thu, 12 Nov 2026 00:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442350;
	bh=gTyO3X8pSKWt1MgW/zJVanTQYKSVAuU4mGWeixd1i6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c9asc4pvfOwaz+2Q+2bg9H6b3DVpkiMHgQ2rL3WzuRVXldIvr/rJywdhbHh4QUDUc
	 32mEl9YFOBj58Oe8yVaHS1OTz+hn3dFCGy5PhDrFy45LUw4+3hHBBfjrj/9M+ozJ3y
	 WYhtQQYfK3iQUNPhlGOW6I4+Y4Obt1y0gKO5/iVKcXvhLDofJqnxh03ZXSbMxs+LsC
	 ydbEt4I+EH6C7achO2ZQl2E1MJPFIEjF66EEU4XAWIZe3ZUn+NDbsk6o++G1wqBUDE
	 dDMqJzvtDdiRpB6Pj87C3SzMXA6KZ1kqJVqjHvMD+jjsZgfuwrENDflc/8XVvaOtXE
	 ELLV7HigDc6ZQ==
Date: Wed, 11 Nov 2026 16:12:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev,
 horms@kernel.org, almasrymina@google.com
Subject: Re: [PATCH v12 net-next 2/3] netdevsim: Implement basic ptp support
Message-ID: <20261111161229.75fe6283@kernel.org>
In-Reply-To: <f9e139ec-c4d6-42ac-8fe3-90e0c342765b@machnikowski.net>
References: <20261108201503.85000-3-maciek@machnikowski.net>
	<179425609934.994134.5338593155278222514@kernel.org>
	<f9e139ec-c4d6-42ac-8fe3-90e0c342765b@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 21:46:55 +0100 Maciek Machnikowski wrote:
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >=20
> > - [Medium] nsim_start_xmit() (drivers/net/netdevsim/netdev.c) only
> >   overwrites or clears skb_hwtstamps(skb)->hwtstamp inside `if=E2=80=A6=
A non-issue. We are not working with a real HW, so we have to cut some =20
> corners to make it work. The most probable leaks are fixed, those are
> hypothetical.

It's about as hypothetical as testing this in SW is useful.
Please drop the netdevsim patches and just add the selftest under
drivers/net/hw
