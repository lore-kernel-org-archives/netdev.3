Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057466;
	b=UZfDKbO+RpfNnNPytGDh2Z/6730cqFddiWfrNH1PTzvZ+9qZsTWKbhaX73zjcjPKKSSn
	 uMhtXQPZpD4fvGjpwBZJ1PIu/vtQLAEqV9KWozTsRWuNZ3bmZI0ukN2v3RIL6c49k0qGk
	 UZ8Xsh/xly0gXRb0nd3gpZLTIn6lEp0NMUB+8Ta553zLJ+26KGuM6qoTdb+yVwdMJadco
	 UbfVBaCiQEjjL68PYeRjSXROBW4jSd+KUbLevM5bi6JsQIAEi0c0Y4Ojs4cpA8scE5KOO
	 IsEYiUz+5MBkZDEQyFjvnQdMPsdHLj6Ajy2uGLBj3NVNQOK+pSZk8j3Q6LRKsaxSVmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057466;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Z1RyZWAi78ndVHxKqcXWt9kL8B14QePwfDTsZT4EoFs=;
	b=tZB7rDxASI+yHtiZe15RcDyjgmiO7EadZLKndetCNJoTZc4IuCAVUrItcGQfLlKa9l7w
	 MXjL+dgJpxr0XkfDNCiWNMXY5Nm+lKQ9rcAm8pMWfpL0apsl3H8kIyXQbgg5QSFLQMB/Z
	 T3CGqj1EwfHatFVxJiff6BNaLmBcN0j2m5pkpaIe1gfxGiHbU2uzqICETTpfkasolWqJd
	 u3PZLhQxEFmHpup+n5WjjGmG8EcS+J3VuIWuW2+5Oz8xTDWzypkmzm6osp8XFAkjHAr89
	 Rtm+xHNGnnBFJZRTbP4aA51ORbPelHJTC/sugnqVsloAwubqn9VTj2r4T9nlqjZDEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U807TgqL;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2B606A31E;
	Mon, 26 Oct 2026 23:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF2B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=U807TgqL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Z1RyZWAi78ndVHxKqcXWt9kL8B14QePwfDTsZT4EoFs=; b=U807TgqLYju5/OsccI52dt/h7P
	GaXN+erPhJzMw0V+4OfcQhvDK19by3fq29FwbbvdzXgxKpwbnaUpe0RoBqhi/Vq5bhv6wDcBMpCff
	4UXskh7J5kle/tb7fZLzFIhExMYylaW1FD2hapgEsc9QtiTWf58LEQOYizpFOPC9dkrlF4/QSthg9
	TqRip/W8W8Ry9p1jUcQwgMeAiPBHy5AXv4Vw8Km4GBrv0gWQPgiJ82cdbX/fhFGrJINO83DiXnE/A
	Rnb7qcEbkhk2f0I+bHj7cg0bnhEgN0toprzZSQ6K0hVklmqtedv4l6f4tcU/u0+vMWZB5VVfK1H1+
	MnimUWVg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU9X-00000003Rz0-3d2E;
	Mon, 26 Oct 2026 23:30:55 +0000
Message-ID: <5ebdcc81-29ec-462c-a600-bacfc670f5f3@infradead.org>
Date: Mon, 26 Oct 2026 16:30:54 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 03/10] net: pcs: Add subsystem
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Horman <horms@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
 <20250610233134.3588011-4-sean.anderson@linux.dev>
 <f5b16bd6-01b6-45c0-9668-41ccf90445a3@infradead.org>
 <b7137a4a-cb87-4aa5-958f-a83d3239e967@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b7137a4a-cb87-4aa5-958f-a83d3239e967@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
Sorry for the delay.


On 6/12/25 8:38 AM, Sean Anderson wrote:
> On 6/10/25 20:24, Randy Dunlap wrote:
>> Hi,
>>
>>
>>> diff --git a/Documentation/networking/pcs.rst b/Documentation/networking/pcs.rst
>>> new file mode 100644
>>> index 000000000000..4b41ba884160
>>> --- /dev/null
>>> +++ b/Documentation/networking/pcs.rst
>>> @@ -0,0 +1,102 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +=============
>>> +PCS Subsystem
>>> +=============
>>> +
>>> +The PCS (Physical Coding Sublayer) subsystem handles the registration and lookup
>>> +of PCS devices. These devices contain the upper sublayers of the Ethernet
>>> +physical layer, generally handling framing, scrambling, and encoding tasks. PCS
>>> +devices may also include PMA (Physical Medium Attachment) components. PCS
>>> +devices transfer data between the Link-layer MAC device, and the rest of the
>>> +physical layer, typically via a serdes. The output of the serdes may be
>>> +connected more-or-less directly to the medium when using fiber-optic or
>>> +backplane connections (1000BASE-SX, 1000BASE-KX, etc). It may also communicate
>>> +with a separate PHY (such as over SGMII) which handles the connection to the
>>> +medium (such as 1000BASE-T).
>>> +
>>> +Looking up PCS Devices
>>> +----------------------
>>> +
>>> +There are generally two ways to look up a PCS device. If the PCS device is
>>> +internal to a larger device (such as a MAC or switch), and it does not share an
>>> +implementation with an existing PCS, then it does not need to be registered with
>>> +the PCS subsystem. Instead, you can populate a :c:type:`phylink_pcs`
>>> +in your probe function. Otherwise, you must look up the PCS.
>>> +
>>> +If your device has a :c:type:`fwnode_handle`, you can add a PCS using the
>>> +``pcs-handle`` property::
>>> +
>>> +    ethernet-controller {
>>> +        // ...
>>> +        pcs-handle = <&pcs>;
>>> +        pcs-handle-names = "internal";
>>> +    };
>>> +
>>> +Then, during your probe function, you can get the PCS using :c:func:`pcs_get`::
>>
>> It's preferable to use                               PCS using pcs_get()::
>> instead of the :c:func: notation to make the .rst file more human-readable.
>> They produce the same generated output.
> 
> If you find this syntax useful, then you should update
> Documentation/doc-guide/{kernel-doc,sphinx}.rst. I did not use it
> because it I did not know about it because it is not documented.

See Documentation/doc-guide/kernel-doc.rst,
commit 7c8b9e3000f8
Author: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
Date:   Thu Sep 3 00:58:26 2020 +0000
    kernel-doc: Update "cross-referencing from rST" section to use automarkup


Cross-referencing from reStructuredText
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No additional syntax is needed to cross-reference the functions and types
defined in the kernel-doc comments from reStructuredText documents.
Just end function names with ``()`` and write ``struct``, ``union``, ``enum``
or ``typedef`` before types.

-- 
~Randy

