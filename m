Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A33D5C3A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501536; cv=none; b=ChECCm+HMvuNhCy+kCbLgZZh96pkdjRCZDqia9PVHe9ewliLbEqErozfrpK0YvOaLAsBvrokfAwq8s1mylCtrYZ0yWATMRa+WvZXjQYRfeZJn/JQRxMU8TYNCIB/ZeQlPxklsGP5Ez+FQ6W6En+EoWAoS3S8nf1WKaayMDI/mPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501536; c=relaxed/simple;
	bh=r/Tsj9lFnJ0Xua0vZTKXQyxgMAR5f0eRvXGKKujtKyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TlS1c+B3brRnEBSHWd86tqLnze60spEv99orbRxBhqoQzMGs+y/AeCOBQPnaDzO6BSKE+sYMhNn0+wSCjsbGDl35jNR3IyVk0yopkk9owypNkvPp1NY2dm4IXS9B4tPv5Gke2TcPyD+aJnRB3AoFccjWrkSc1gNU9WtYOPBbSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vKJUdFGK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vKJUdFGK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6BD5C4E40113;
	Wed,  3 Jun 2026 15:45:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3E3605FA0A;
	Wed,  3 Jun 2026 15:45:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6635910888CCD;
	Wed,  3 Jun 2026 17:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780501530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r/Tsj9lFnJ0Xua0vZTKXQyxgMAR5f0eRvXGKKujtKyw=;
	b=vKJUdFGKVY3Gl1TeFlMvojHC8glWlqPjg2OTLkqa9f//v4R9+ry5Wrl0KUd5GcYr8cFMby
	/IeJIOmF7H+4bxATuaXv37kNKsuRQsMVga8oPACplTQanp1SQmQ4S8YFFhCeyJtE5SpJqJ
	DwaHqeTapo7R1EDpwdjN82JOJ8oouohtf5OVdNb0kz8atxdi7OuB+M8iDhBRPa1PavkguT
	LCsHySMzyBAF1OruZaq3EoqAkECPuwT5tYMtZp8VHr5AREv1hr7eF5gUBZ5y3XvaiFvVhe
	MFFbdabptCu1U64PjfQ6kY3OfvtBqE4rE9rJKttR0ZloxZtc6jstlSCRuHokuA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  netdev@vger.kernel.org,  eric.dumazet@gmail.com,
  syzbot+f13c19f75e1097abd116@syzkaller.appspotmail.com,  Alexander Aring
 <alex.aring@gmail.com>,  Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH net] ieee802154: 6lowpan: only accept IPv6 packets in
 lowpan_xmit()
In-Reply-To: <20260603072955.4032221-1-edumazet@google.com> (Eric Dumazet's
	message of "Wed, 3 Jun 2026 07:29:55 +0000")
References: <20260603072955.4032221-1-edumazet@google.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 03 Jun 2026 17:45:25 +0200
Message-ID: <87h5njzkyy.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Eric,

On 03/06/2026 at 07:29:55 GMT, Eric Dumazet <edumazet@google.com> wrote:

> The aoe driver (or similar) generates a non-IPv6 packet
> (e.g., ETH_P_AOE) and queues it for transmission via dev_queue_xmit()
> on a 6LoWPAN interface (configured by the user or test case).
>
> Since the packet is not IPv6, the 6LoWPAN header_ops->create function
> (lowpan_header_create or header_create) returns early without initializing
> the lowpan_addr_info structure in the skb headroom.
>
> In the transmit function (lowpan_xmit), the driver calls lowpan_header
> (or setup_header) which unconditionally copies and uses the lowpan_addr_i=
nfo
> from the headroom, which contains uninitialized data.
>
> Fix this by dropping non IPv6 packets.

I am not sure I fully grasped the syzbot report. The problem may happen
because an interface can be configured as a 6lowpan interface, which in
this case should not transmit the packet, but there are other possible
configurations which would just work and accept ETH_P_AOE packets
(whatever that is). Is this correct? If so, then this indeed looks like
the best approach,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

But otherwise I guess this fix would totally prevent the AOE driver
from working correctly, so I just want to double check my understanding.

Thanks,
Miqu=C3=A8l
