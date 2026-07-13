Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EF930214B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050321; cv=none; b=gukjWi2m93JiOWEQ1rddvYnVged1BNXd1F4pP3pnemKHf0snMsFRFH/bkA1C173TN+T+YOvrPNWp3pAwlvJoXF69cwBeAmPVTwiJCjdQPxUrSVs9pDBgYkfUocawi47KxXUJ+Olq5nblzywtxpSCG3SjH8RqqhQdphZ/6f21I28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050321; c=relaxed/simple;
	bh=6gsQE7uclDyJ/8N7gnovSfU1Qx7ihfB3bfFds1vXw2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V53TE6ei7NWJ7+uTLHP9LlMTmCm5nF8InJUSbvEuSHou6CxPS4VxpoRCrK3JL0CnvTONRgTQsWjuJVCroqNB4W+ekAIAlkTFEITeTeDoT3xsuOXU5y7VGB7frNoLB6GICIAxbpo2k0t2PoFt5wPo5AOQhXxB15hPtzUlanyTvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id 077DBC0137;
	Tue, 14 Jul 2026 20:26:33 +0300 (EEST)
Received: from basile.remlab.net ([2001:14ba:a082:6301:c5d2:3c3d:3f09:1404])
	by ursule.remlab.net with ESMTPSA
	id uaCgN0lxVmqiWAEAwZXkwQ
	(envelope-from <remi@remlab.net>); Tue, 14 Jul 2026 20:26:33 +0300
From: =?UTF-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
To: netdev@vger.kernel.org
Cc: Minhong He <heminhong@kylinos.cn>
Subject:
 Re: [PATCH] phonet: check register_netdevice_notifier() error in
 phonet_device_init()
Date: Mon, 13 Jul 2026 22:22:56 +0300
Message-ID: <3425812.44csPzL39Z@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20260713075212.431455-1-heminhong@kylinos.cn>
References: <20260713075212.431455-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le maanantaina 13. hein=C3=A4kuuta 2026, 10.52.12 It=C3=A4-Euroopan kes=C3=
=A4aika Minhong He=20
a =C3=A9crit :
> phonet_device_init() registers a netdevice notifier before calling
> phonet_netlink_register(), but does not check whether notifier
> registration succeeded. On failure, netlink setup still proceeds and
> init may return success without the notifier in place.

> Check the notifier registration error and unwind through
> phonet_device_exit() on failure.

That will unregister a notifier that is not registered. While I believe tha=
t=20
would fail safe, I am not sure if that is really considered proper by=20
contemporary kernel coding standards.

=2D-=20
R=C3=A9mi Denis-Courmont
https://www.remlab.net/



