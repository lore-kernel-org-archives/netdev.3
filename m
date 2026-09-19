Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0E28315D;
	Sat, 19 Sep 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808675; cv=none; b=i2fX2Msp0cSlk7AJU+Z6eAX/GD5cF29gbYjAC38MM40FqJTX/Kxe03GxLquBxX5NjyKedtI7tOZDW3XkXErITrltP+UXW7dBVtuTZpMjrkMuIAVuoc3c+yJqu6RbJF4WEFMZiaX7B2Ibw6r2dBIf8c1E7HF7VrPMKEIt2spEw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808675; c=relaxed/simple;
	bh=SzYwxn01SsB6ztVJAUDOdcGw1j3zMFGEBYfOS3NOm+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5taPBziJi90zaRn42ZlPoxpfdOSdcLmQKrs+e+A9hmh9pmRBZopbNKsv5Zo1eHpJ+mMhYCZBHFjx7ilathPUR1UH3wyX2et97kgMAJgpavVpsa2bYMaIyFFcc0RazgPsYTZpjxZPUmUP0zQy2SyAYLjSO3vykGFfzMVH05FN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x7qzZ-000000003cO-2VU7;
	Sat, 19 Sep 2026 09:04:17 +0000
Date: Sat, 19 Sep 2026 10:04:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v16 0/6] net: dsa: mxl862xx: devlink flash and
 rescue
Message-ID: <aq5QDmuQnqQTudca@makrotopia.org>
References: <cover.1789477568.git.daniel@makrotopia.org>
 <20260918180709.2fe12c2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918180709.2fe12c2c@kernel.org>

On Fri, 18 Sep 2026 18:07:09 -0700 Jakub Kicinski wrote:
> Having the "rescue mode" which only allows flashing a better / working
> FW is fairly common these days. Did you consider driving the operation
> more from user space. Let the user devlink reload into flashing mode,
> and devlink reload back into normal operation mode?

The reload plumbing itself would look much like the flash_update hook
this series adds: reload_up/reload_down trampolines in the shared
dsa_devlink_ops forwarding to new dsa_switch_ops callbacks, plus
reload_actions. So "DSA has no reload" is not really the obstacle.

The difference is what the callbacks have to do. flash_update is a
pure forward to the driver. reload_* has to reinitialise the switch
while its devlink instance stays alive, since the reload command runs
through it. In DSA that instance is allocated and freed inside
dsa_switch_setup() and dsa_switch_teardown(), bracketing
ops->setup()/ops->teardown(), and the ports, tagger and user netdevs
come up a level higher in dsa_tree_setup(). So reload would need a new
DSA-core path that reinitialises a switch, and its ports, without
tearing down its devlink instance, and in a multi-switch tree touches
only the one switch.

The deferred re-probe avoids all of that by reusing the existing
unbind/register path, which rebuilds everything, a fresh devlink
instance included, so it needs nothing new in the DSA core. And the
helper it uses, device_schedule_reprobe(), is not something this
series invents just to sidestep reload: it should also replace the
open-coded deferred self-reprobe that iwlwifi, hci_h5 and btintel_pcie
already carry[1], where the work function ends by freeing its own
module text from under a racing rmmod. It is worth having on that
merit alone, with mxl862xx its first user and those conversions to
follow. So the re-probe leans on driver-core infrastructure that is
useful regardless; driving this through devlink reload instead would
add the DSA-core reinit path in addition to that helper, which those
three drivers still want, so it is more new code overall than a swap.

For that reason, and because the re-probe is what I have tested, I would
rather keep it, but I will add the DSA reload path if you feel firmware
activation on DSA should go through devlink reload. Either way the
rescue-mode detection at probe stays, since a switch found in MCUboot
has to register something for devlink to be reachable at all.

Cheers,

Daniel

[1]: https://lore.kernel.org/all/cover.1787281239.git.daniel@makrotopia.org/
