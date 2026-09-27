Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791439B48D;
	Sun, 27 Sep 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497573; cv=none; b=V3YutDT1FhmFimxFBa9b8mrfzCStDgz7Jw8ZL3BR2PgT26vdVcevNi7Ua1tEZCiu/y5n8DjNf885C/5jr35fOgob+Hk4K2NGfyo+GntCDzn1793oDjlqF38u/hudp+d9kMua99n4ReM9omp8F5QJH0kRMFePsvt+ch23vSsz0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497573; c=relaxed/simple;
	bh=XZIh0uZRUoo23DHiJxAEjpZ/jNsTw+Hm5gYSVlMCmRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HL3OJG8I46FCVsEHiBpfvq66huLqwDWPykBfhLnwvhK6jrFQTshBXUPPNqNJNZv5cVnSveGDYoWFFMET+o6GiCcA2CBN0ImGkPbLjQy/t0qVKP2oBHJOOuJ3y///gsjgJNkPCjFu5hwLkY1ToSyIDj79XSz1eWMR7G8OgKIBgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rxGpbyRC; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=cqYVtaj3; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rxGpbyRC";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="cqYVtaj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790497045;
	bh=XZIh0uZRUoo23DHiJxAEjpZ/jNsTw+Hm5gYSVlMCmRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rxGpbyRCIVL+/Y6yd6+5K5s35Qt88MdRkkjprrSw0IbL227NK3cVBzS20zgZBhIDh
	 botlWoP0ZyE1RryjDTLcsZf4fbXDvsaxN41pKp8uVKK3qII2DkmAvlrkKilUWapcY/
	 hCuP0+0fP+aK3xEyf2315BIv9ofzqbaMMpailCw7ZkdwDs3CS5CQ/NdwUa7Ui01yWr
	 wBgUcbM5eQ5aUcUrZrxuOPGLg4cENmDrDeJo71WWZElBVSLtby6ubMLbYDzQjz9q/w
	 OsAja2YfRb70Lupg2znCwGFvnEuxVcb/5Q13Bs910U8B6wnNMdBfzt3lyLlCsa2KsB
	 7Fa1QWUpeiXZw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 05F54412E6; Sun, 27 Sep 2026 08:17:25 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1790497043;
	bh=XZIh0uZRUoo23DHiJxAEjpZ/jNsTw+Hm5gYSVlMCmRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cqYVtaj3rDZ9KcJbOx+bac1cXwayNpc9Wyh1ztpvLJz1kbYh9A40AgDRXvrgKzMWf
	 qnwp2gdzFiiv8iyz77ubsfyMC/Bs5sRgpUTY4VHF/KgQ9rJzJPG1/k+VWwN3A9Wc4M
	 GfdHqXPznhYDg2ZWMKcL10JomsXEQee8f9fyEcswoyvItQntwxlrmXhIcLOovaBbq2
	 uacnQU6TW4E9brnvzQ5EwqKxY+IHx0bGgMvbx1O3FgyJqhpoackSjfLs9PzAoOZkKj
	 IQ1tssgxzW8TFTl6Sm5DCL6Ql9sElMFgEzRPXZpsDWjyR+eQvRTVDAZ5y/Jm4O3BT0
	 jxLPDwwWT1hbw==
Received: from [192.168.2.51] (p5798b961.dip0.t-ipconnect.de [87.152.185.97])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CCACA412CE;
	Sun, 27 Sep 2026 08:17:22 +0000 (UTC)
Message-ID: <42e33e65-0b6b-478b-b13e-82e1436db365@birger-koblitz.de>
Date: Sun, 27 Sep 2026 10:17:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 05/15] ax88179_178a: Add netdev2data()
 convenience function
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
 <20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
 <20260919150515.400c4de4@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260919150515.400c4de4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/09/2026 12:05 am, Jakub Kicinski wrote:
> On Wed, 16 Sep 2026 05:24:04 +0200 Birger Koblitz wrote:
>> Add a convenience function for the ethtool ops that use
>> phylink and need to retrieve the ax88179_data structure from
>> net_device.
> 
> 8 loc? just squash it into the patch that needs it..
Will squash.

