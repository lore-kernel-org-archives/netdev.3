Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25843EB813;
	Wed,  6 May 2026 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065743; cv=none; b=RpEE2n9oeelllO6rm/Rq3Hx92jbzLbeE+Y2VISdRLu7bUvRwV2JnI6NCWEFTLhwBBQ3ARsZLIA/g2GzxMi6goIS2hCDp1aFdnsnFNzmKXHDNnehyWjWSG5RJ/nqafAV8K3aG4p+btEK1nx7Sj7bIAE1Dl3qkQfauSQag+zQVhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065743; c=relaxed/simple;
	bh=C21UES+I40tjFBD2O4bQaaiN8Rh9gVhdJ6kwnCRUMWc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bH6o3MmgrTVHXsD1tCLRFloSK19LDvWc0FWJLIuVlHVeabUWJjActAo25I7K0Q5LSdHX4tZ2YmHVyjPHb4EbnaAB9x2vPeYzo2wwnZlO6lol5zo01tU4MYJocRSg2/PJ/tS/hQge/o+wY02C86scdbE13Ot6X92VReeW1Jwp/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=1uXMC9Hw; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="1uXMC9Hw"
Received: from ehlo.thunderbird.net (unknown [193.96.224.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id AE85853414AC;
	Wed, 06 May 2026 13:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1778065729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DVO//G3TKWIp172nJp3YBO1FcCFLDzW/DktqIattPs=;
	b=1uXMC9HwGDCuQkG7nLQsJC7ngtgA2K0qVBJ+qWXqua9jsHBc+IK7m6FS1gO9dj4u+HcwXn
	4LBhMZS7VOhhtyegpyNzVAddhMdABC3E8mLZU1/DQSh6LcJ7ZcKkO+70GwbU7qYmmqj96u
	f1oBPpvjFJllfMky75CY8nizrw4c8pQ=
Date: Wed, 06 May 2026 11:08:44 +0000
From: David Heidelberg <david@ixit.cz>
To: Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: David Heidelberg <david+nfc@ixit.cz>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Kees Cook <kees@kernel.org>, Junxi Qian <qjx1298677004@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in llcp_sock_release()
In-Reply-To: <20260506081145.GA305027@google.com>
References: <20260429134115.3558604-1-lee@kernel.org> <20260501162759.06ef164b@kernel.org> <20260506081145.GA305027@google.com>
Message-ID: <F9112727-E4DF-4884-807A-015809EA5DC7@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Lee=2E

Yeah, I think today these should hit the linux-next integration tree, and =
I need to setup the Thank you email to work in `b4 review` :)

David


-------- Original Message --------
From: Lee Jones <lee@kernel=2Eorg>
Sent: 6 May 2026 08:11:45 UTC
To: Jakub Kicinski <kuba@kernel=2Eorg>
Cc: David Heidelberg <david+nfc@ixit=2Ecz>, "David S=2E Miller" <davem@dav=
emloft=2Enet>, Eric Dumazet <edumazet@google=2Ecom>, Paolo Abeni <pabeni@re=
dhat=2Ecom>, Simon Horman <horms@kernel=2Eorg>, Kuniyuki Iwashima <kuniyu@g=
oogle=2Ecom>, Kees Cook <kees@kernel=2Eorg>, Junxi Qian <qjx1298677004@gmai=
l=2Ecom>, Ingo Molnar <mingo@kernel=2Eorg>, Samuel Ortiz <sameo@linux=2Eint=
el=2Ecom>, netdev@vger=2Ekernel=2Eorg, linux-kernel@vger=2Ekernel=2Eorg
Subject: Re: [PATCH 1/2] nfc: llcp: Fix use-after-free in llcp_sock_releas=
e()

On Fri, 01 May 2026, Jakub Kicinski wrote:

> On Wed, 29 Apr 2026 13:40:41 +0000 Lee Jones wrote:
> > llcp_sock_release() unconditionally unlinks the socket from the local
> > sockets list=2E  However, if the socket is still in connecting state, =
it
> > is on the connecting list=2E
> >=20
> > Fix this by checking the socket state and unlinking from the correct l=
ist=2E
> >=20
> > Fixes: b4011239a08e ("NFC: llcp: Fix non blocking sockets connections"=
)
> > Signed-off-by: Lee Jones <lee@kernel=2Eorg>
>=20
> Adding David H and dropping from netdev's patchwork=2E=2E

Is anyone looking at these please?

These are pretty important=2E

