Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B538BF6A;
	Thu, 30 Jul 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430934; cv=none; b=KP9h+EutIQilTv6trrPO+iyjWg3LghTulug6hIXJxgAToMyZQw9gu7NY7MSEXvHr1rnI8xlRjH8YkXK5ze1sHzIN3NJOoKEdV0iAwf8iRjuNEM4sGx/6eX6arLXVgrZAq+af/1PJ6ATRWx+cb9q6EVF6rRSqfyWbrMnu1CHj1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430934; c=relaxed/simple;
	bh=Y/gmc6BQfAaHw54Jgm0gF1Q7hmulfYR4r4ja/LY5OIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJzUCzru6vhycQcp2tPjZGN3RUqwt1RtkHx5c5QQMIuZgTj4u3nf8OUGjjuGZEVC8VvY1u/nDM8gXLX4hSeNE3SezHU6JwsnRVNEvruNZ/8/a6N/nvcasbz5QbVtH42vMNXZmWBxJyS+u1bRhl7iy8vkJmtDvFNzUMEeSKTeeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=qR3jONz0; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="qR3jONz0"
Received: from L30177.local (unknown [81.201.198.134])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 79834B00572;
	Thu, 30 Jul 2026 19:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785430929;
	bh=Y/gmc6BQfAaHw54Jgm0gF1Q7hmulfYR4r4ja/LY5OIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qR3jONz0dknW8h6dUYqXtwMQbFln/FAfigaSJqM3Jfrq6wKEXX/MJgs7hUsJN1fdI
	 mpvQeK3LmcNmbiE0a5KWbgL0/7NfI6zdrXDawmw/5UIJLy8dQFKoK8h7o5SZdT5Vtx
	 Um31XuUBKoyLQPjskUtm10z5Ya8vhXjEFcN08qj/ZXRmRELN4Dpqz/oJPVNdmTGwI8
	 UlxE5/AJfwuXK+XhsW2vRqydYJuldUU7h7CLxgZtxZ0ZauqGhDA1iQkWHh3/Sv3iw3
	 krm3PIWReM1MOgkP858bBGdDZtk/mFreUWwE6wkcFkoBCIB9pkfAquVwNq/MpSDM5v
	 kB8XRkwhwglYQ==
Date: Thu, 30 Jul 2026 19:01:55 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Conor Dooley <conor@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dpll: zl3073x: add ZL30643 compatible
Message-ID: <amuDg_eXFs9SeCw8@L30177.local>
References: <20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr>
 <20260724-for-upstream-zl30643-v1-1-ea93ba4d85c8@free.fr>
 <20260724-gloater-palpable-89703c14e394@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724-gloater-palpable-89703c14e394@spud>

Ho Conor,

Le 24/07/26 17:46, Conor Dooley a écrit :
> On Fri, Jul 24, 2026 at 01:09:12AM +0200, Vincent Jardin via B4 Relay wrote:
> > From: Vincent Jardin <vjardin@free.fr>
> > 
> > The Microchip ZL30643 (chip ID 0x0E3B) is a 3 DPLL channel member
> > of the ZL3073x family. Add its compatible string to the binding enum.
> > 
> > Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> What about this device makes it incomaptible with existing ones?

Nothing makes it incompatible at the programming level: it is
register-compatible with the existing parts. I compared both
datasheets of the zl3064x and zl3073x.

They are the same registers for both families
(zl3064x for line cards, zl3073x for central system/CPU).

The register descriptions are identical, both use the same chip-ID encoding
 base,
 A-series +0x1000
 B-series +0x2000
 7x7 package +0x8000

zl30643 for 0x0E3B is the 3-channel part, i.e. register-equivalent to
zl30733 = 0x0E95.

Nevertheless, I'll switch to a fallback compatible instead of a bare new
enum entry:

    compatible = "microchip,zl30643", "microchip,zl30733";

Thanks,
  Vincent
