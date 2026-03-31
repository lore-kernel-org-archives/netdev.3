Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A003F8E03;
	Tue, 31 Mar 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967141; cv=none; b=mBJMDKuiKVxUZzFJHLA86gqbzvObAOcvD7qcUSm+EP+a1/18sTDg5ZXI+IkNpIaFl5KRNl3aZdLadvNFx0Ax5nHJr0V/qkOxBFSUDsaMjcCDB3PpXkHzsYAQt8QNMq5BZufp+BJ2Yg03VqqJmC2FZgz+IIS2nQepjZWY2uW3txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967141; c=relaxed/simple;
	bh=U5uM51uyVywz0Ku3+6t2AG2QfNtCodrg01eurmUPSo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crEOHVIxQoqRHs1razT+O9QYaVpw6i7c8U7TOR/pm9jO+t0gvJ4W6tPpGdaK7VYrW+VwCwqF+owitr0r3rco9S5M766OlZ/P8UdiJEVS+dDDxeb/8hz8Goxn7GDKjJr26oFNEThtECuI2PxiihgKvcfV8Vciu7NJ+FXy2aBxlqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=F+kOVDit; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="F+kOVDit"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.18.1/8.18.1/Debian-6) with ESMTPS id 62VEP91q825675
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 10:25:10 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4flVks1M0SzdZY88;
	Tue, 31 Mar 2026 10:25:09 -0400 (EDT)
Date: Tue, 31 Mar 2026 10:25:08 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jaco Kroon <jaco@uls.co.za>
Cc: Qingfang Deng <dqfext@gmail.com>, linux-ppp@vger.kernel.org,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras
 <paulus@ozlabs.org>,
        James Carlson <carlsonj@workingcode.com>
Subject: Re: [PATCH net-next] pppoe: update Kconfig URLs
Message-ID: <20260331102508.2eb6dce8@gato.skoll.ca>
In-Reply-To: <1bba860e-a204-4a5b-9b8f-4d55a559d01e@uls.co.za>
References: <20260331033303.5664-1-dqfext@gmail.com>
	<0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za>
	<20260331091655.30212333@gato.skoll.ca>
	<1bba860e-a204-4a5b-9b8f-4d55a559d01e@uls.co.za>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=00IX2/FPj4y7ZScMI81Y5QFxmS44uuUj/r6XE4KfdQ4=; b=F+kOVDitfAgI
	UcjOIi/bfiaYiuxz2Pr2IDV6kAlR7NPGZ7BC4gdWET+ns0TjwnsG5biq7yUpDO/Y
	ujepG4vjaTgu9Xk+p/vGB+0jaYTyQ+BqlWj0kBfG/EKHrgJQb4meo0pVIJniwat8
	+0inZ2IBXsQ2E48MK+72sN6n9GTP0hvB25R9HALEriJ7TYjpmdX3NX6dVACCFANu
	Hz/hB8dOHNxiur0IpYleywnRKr66HQVkPy23o9xI2tOHqiosx/XqH0RhUhysMDYS
	rw2wccVzlULFakF7quUk1qwSFheQ633zg1iFv2kXEz6U6LqYOIlW5dKXL8cMfjjK
	GFMJiugYGA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.20 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20260331 / 01gVqp93O

Hi, all,

> My bad, my apologies. It was the userspace code you dropped then, which 
> does NOT require the kernel options?

I was considering doing that, but I kept the userspace code.  The reason is
that on some platforms, such as uclinux on a processor without an MMU,
the dlopen() system call is not implemented, so there's no way to use
a plugin with pppd.  One user asked me to keep the userspace code, so I
did.

But you are correct in that 99.99% of Linux users will not need to download
rp-pppoe if all they want to do is connect to the Internet using a PPPoE
client.

Regards,

Dianne.
