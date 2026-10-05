Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93237B022
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189353; cv=none; b=Aee9ZxRbzkABWneF5xNICy7BuAgGQoGbKn0DPUK4HgNX3FscJyWnULIIYPs9NDAo45JITb75EJyYeNPN18qqfY/3TkhbTLDbHbndJxXWenX12iVpvD/mRuHCObqB0W2cMyMjv1BWBZ9iDeR4+3Utr5cy0LAHELE9rKojZDkJvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189353; c=relaxed/simple;
	bh=6PkHJhi1Hyzs0Xy73ugDZL+OPDEvkLStoC3GoxL7zEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzVaOw2QHpe38sQEqDpbSX9Wdymf4IBr7BSw4ouf+BhjS7XlT0IPxnTdUhiZY+mN+z6xGiiNS6M7fI0+2j2CVrSI0e67KTcOfd83wrHqOY2DZNP6pw6fB7lXSC5lbGIJVENYbQ/22lkx7/oyuKwuyNjOv3TLHCPF8Ch1RuQyUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=dVWzTQ94; arc=none smtp.client-ip=62.149.156.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="dVWzTQ94"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id DeAlxMctKXXg5DeAlxn2O1; Mon, 05 Oct 2026 10:35:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1791189348; bh=6PkHJhi1Hyzs0Xy73ugDZL+OPDEvkLStoC3GoxL7zEQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=dVWzTQ94ZOzqP5OctB3N5Wg37EtO1e6JpQWkg4hgDMoOibhmavIkPudBm6db1RFCR
	 fsz9AR7TPQLRr2tvaUu5vNstSTwtIasH9dkFLF8pzZC/VjtciQU91uzRTJ6Fv1fGQ8
	 zea+viT70j4d7bvkR/L+hmgOY1hWLFfAQwearuDfi+eI+u6+4vUxEWglJ7KUdPhT2x
	 U1rqRRsp+hI2b+R+pPCDwYuDOum2flOlo5sKZWde3ICJhJKGVCkPQ/L+cBPBSz/tmf
	 3cg8Xh+rFY817wNMXnrqojD8tjN3NXbAX0p3o6A3DX6vemX0llM8UXUg2YWyTNWqYT
	 lKVbIUyYdjyZA==
Message-ID: <d352287f-156c-436e-8fa5-b203771a6a84@enneenne.com>
Date: Mon, 5 Oct 2026 10:35:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: add reset
 timing properties
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261002135542.359756-1-giometti@enneenne.com>
 <20261002135542.359756-2-giometti@enneenne.com>
 <20261004-transparent-cuscus-of-honor-8ccbb4@quoll>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20261004-transparent-cuscus-of-honor-8ccbb4@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOLT+fep3IaGm7pk4NDL3zAI+995bto4w0a/HX9/i6B+QfIZ9RI2II9ouB6WG4fAZhul8rv8wxzxWLlbVNwweb5ZBkDjFVxugec/ozCQ38qVh8j4YJyE
 tCl9V3gDcUkcr+p3LTYMv1fEecmqfJ3uex6oz9ar4CTDiSXCl7WUHXLzl7WEQBv1diTVoKFPF0SiCrCHuMOw5qVj3rpSHc94fCn6e4UcQO/iy6ez4tz3G8Mq
 3OSQmVmuWS9ZN+T12BqY+Thk8WP5cT0wZGzbMeOTg49Ft6rrKBYsxjZPC+Sj4AfQ5A6qALBpQhl7XR7RRVUCAlWA+Ltgk5crbwx4Kx/RMYIQa+1i/6jb+MiY
 2G727GEitCKo7oWeQxNxvKe/h40svZS53PMYzEf/LlYcWV4SlcyqShAqG/QIwA14DZB4jrRehWeTbwd/50NSZQC+lhP9zDZX3WWHz3UDqG/uduOzYCYvptAT
 Ze6SdTkCCvqLa3vrF0gH3BFTp8BtmWv7TQPZwytMUFcczqnqAlDLbwC7vnN4hfQjWa2kDQYgEeWpURNr4X53GU9E7nPAGtoQAEJ4dpaarzKZEgOZ7nW8ngF/
 ezEC61JDSk13UJqfpgtaLIWrwBppzzxJCfrxpN7df4lbS+2DM/uNMjtqATIzRskfBXM=

On Sun, Oct 04, 2026 at 09:27:04AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Oct 02, 2026 at 03:55:41PM +0200, Rodolfo Giometti wrote:
> > How long a KSZ switch needs before it answers on its management bus
> > after the reset line is released depends on the board it sits on, and a
> > board that needs longer than the driver waits has no way to say so.
>
> Not completely. This is implied by compatible. Individual phys/mdios
> have their own delays but not the entire device.

I see. Honestly speaking, what I measured is the switch itself needing
longer after a long reset: 95-120ms after a 10ms pulse, ~160ms after 1s
held in reset, on one board, while a second board gets through the same
sequence in under 100ms. So I cannot tell whether the difference comes
from the board or from the part.

I will drop the binding patch, then. For v2 I am thinking of keeping the
fixed wait and then polling the chip ID until the switch answers, with
an upper bound in the driver, so that no property is needed: a generous
bound costs nothing to a switch that answers early.

If that is not the right direction, I'd be glad to hear it before posting.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
