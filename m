Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E93630AD;
	Sat, 13 Jun 2026 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781321857; cv=none; b=EahNrpzunOf4QhityEtYBEaYAlasI0Y4XPxmhpWqqpnQonobG6xqHNPAZ7uwf6gbkpid2GH1iVKLo3NdQV5uw7vmXgUsmr2B9rRzvIevz29QXrvHPXRu9HlCBBS9fZWsUoG4HYku38aserdUpCsUw8AVQtwi1WlVaiQC5E9DPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781321857; c=relaxed/simple;
	bh=Qz5j3NYVF0nrsmWvtdLPQIxAXyH2cm4x7IGMZTXf4FU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B5nQ1Z8rBH+jSn262owbUGIGKa+dGueYlPY8GAmravVb5+ccN/5qejmwdZmuUbn+1bmBVcqm+EweF3S1sAXWQbLx7lI+boxz+qObkYCM887I/HdTdoKxeAUgEg/izAiizWBKS4veM+JGTsTaeVjM6qD60SsdLJkbHQD1yWjQMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=sLpoyB3B; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="sLpoyB3B"
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 348F5600B3;
	Fri, 12 Jun 2026 23:37:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1781321847; bh=Qz5j3NYVF0nrsmWvtdLPQIxAXyH2cm4x7IGMZTXf4FU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=sLpoyB3BhbWi7Byp4FtewSSxO4+l9Kl8jkRn9gJpo9IRN2juwVIfqhmn7PqQmkjdX
	 iruBp/Yp4S5jvPG1XaUXRrAkargZCQ2LX4SaSiRIq3zABUBrO7Vw0JBM/ch0pCoT4B
	 OLlW3yAlDLA1jRCA8+Gd7uNrR/d9C4Lo6GpxHjW4paci/hyp3Tbx6rvPFot7NtdIuZ
	 TANzBsJwujKhRQK6ZjvtI9sqUMvwAFjqK4LTXktGpjxZkKHmFpxkKdU5ewSGfg144H
	 Pm0YQ/4z6PE/nbbS6WSjlydLnJg3yyl8qZAPyZOOStO5EM349zyQT8fxIZIdKAcG6O
	 GP/9Cqpy7uZCw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next v7 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260612153656.4c5b8c62@kernel.org>
Date: Sat, 13 Jun 2026 13:37:08 +1000
Cc: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>,
 cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E7B1B5A-ACE1-4488-A600-96FAD88D070E@padl.com>
References: <20260609-net-next-mv88e6xxx-cbs-v7-0-7d5d732df545@luminex.be>
 <20260609-net-next-mv88e6xxx-cbs-v7-2-7d5d732df545@luminex.be>
 <20260612153656.4c5b8c62@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

> Are DSA ports multi-queue? I would have expected a DSA driver to
> offload PRIO not MQPRIO.

(Noting that the example did not offload the MQPRIO Qdisc =E2=80=93)

Some Marvell switches do have multiple TX queues, but a flexible mapping =
from PCP/DSCP values is configurable only on ingress. Cedric has a =
separate patch to do this via DCB APP for PCP. These mappings are global =
on the 6352 family and per-port on the 6390.

On egress, one can use the switch chips=E2=80=99 AVB support, but this =
limits the number of TCs to three (corresponding to SR class A, B, and =
=E2=80=98legacy=E2=80=99 traffic). I have a submitted MQPRIO offload =
patch that does this. This matches how MQPRIO and CBS are used on end =
station NICs, but is not flexible enough to support an arbitrary number =
of TCs. Because of this, offloading PRIO may be cleaner.

Luke=
