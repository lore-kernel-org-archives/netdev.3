Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFCB3921ED
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748295; cv=none; b=Em9MGPaKHuOCGOfTMOUDpl/GlcuaajnOSREWb0y6JDBOD24/RcCXa05XVP1rX4rvl+95haotAFYZrBAyoIvyNnJw0Li+orWfeRvgZxSwp0ewNn+04m9BPIyqerfu2ZBLQO+4W3a87Aiv78mbOS4Tnyhb6U8MbEjpxl55sgdbuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748295; c=relaxed/simple;
	bh=0rY9FSpHuGg4ujkeEySndZRMqiZFzZdzqwZ0kxIdBI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSnWHVj6v8eumMKBxDxfuRz86e44myj5SSfwKzBTewTveHVB6YvncQd74akktgtBfLqE3DLmq0VdJTf5OkQgl9/TiZALUYShzhyrJ98bdP09vscG+1bhT0XbbkdsIbckknbIqbMH+Hq7T2sHxPh66qfRpxckD/Vydw6w8qQjLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpLGgPKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpLGgPKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790748292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogrKXzfldwajrdorFdbIi+uGh9p6QqICcURCvwNSeTI=;
	b=KpLGgPKNhR35FUhRsBWQkIWxJZmXoCWSKY/wPHxPTEczEQ2Yo8KHbvbKKYH3sGM3Ic7z3J
	xt+OeLw69B4KeuhhbbFEx10JTRN2FQXtsvAnbLxTUykuEywJIScvVpqwXiComDMGj8/VU2
	4WItixELDYonrzpflKhyNO1n2OUJkdA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-TyKBdVBrN6y6yT4pMf3x8A-1; Wed,
 30 Sep 2026 02:04:49 -0400
X-MC-Unique: TyKBdVBrN6y6yT4pMf3x8A-1
X-Mimecast-MFC-AGG-ID: TyKBdVBrN6y6yT4pMf3x8A_1790748287
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95341182A120;
	Wed, 30 Sep 2026 06:03:59 +0000 (UTC)
Received: from griffin (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B8B51956042;
	Wed, 30 Sep 2026 06:03:56 +0000 (UTC)
Date: Wed, 30 Sep 2026 08:03:53 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Wentao Luo <luowentao077@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Edward
 Cree <ecree.xilinx@gmail.com>, Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net] vxlan: fix NULL deref when joining a group without
 a socket
Message-ID: <20260930080353.0ccae75b@griffin>
In-Reply-To: <b3682f3b-f895-4843-815f-7f8a09530ba3@suse.de>
References: <b397156b-c184-4061-a9d5-52cce5c4f07e@gmail.com>
	<b3682f3b-f895-4843-815f-7f8a09530ba3@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, 29 Sep 2026 17:27:01 +0200, Fernando Fernandez Mancera wrote:
> On 9/29/26 2:22 PM, Wentao Luo wrote:
> > vxlan_sock_add() ignores -EAFNOSUPPORT when creating the IPv6 socket
> > of a metadata device, so the device can come up with vn6_sock NULL
> > after ipv6.disable=3D1. A later IPv6 multicast join still uses that
> > socket. vxlan_igmp_join() dereferences it and oopses.
> >=20
> > This was observed on an external vnifilter device by adding an IPv6
> > group while the device was up:
> >=20
> >  =C2=A0 BUG: KASAN: null-ptr-deref in vxlan_igmp_join+0xb8/0x18c
> >  =C2=A0 Read of size 8 at addr 0000000000000010 by task bridge/729
> >  =C2=A0 Call trace:
> >  =C2=A0=C2=A0 show_stack+0x18/0x24 (C)
> >  =C2=A0=C2=A0 dump_stack_lvl+0x78/0x90
> >  =C2=A0=C2=A0 print_report+0x468/0x5cc
> >  =C2=A0=C2=A0 kasan_report+0xa4/0xf0
> >  =C2=A0=C2=A0 __asan_load8+0x7c/0xd0
> >  =C2=A0=C2=A0 vxlan_igmp_join+0xb8/0x18c
> >  =C2=A0=C2=A0 vxlan_vni_update_group+0x2b4/0x390
> >  =C2=A0=C2=A0 vxlan_process_vni_filter+0xfe0/0x1750
> >  =C2=A0=C2=A0 vxlan_vnifilter_process+0x218/0x270
> >  =C2=A0=C2=A0 rtnetlink_rcv_msg+0x1ec/0x514
> >  =C2=A0=C2=A0 netlink_rcv_skb+0xc0/0x1f0
> >  =C2=A0=C2=A0 rtnetlink_rcv+0x18/0x24
> >  =C2=A0=C2=A0 netlink_unicast+0x4b8/0x558
> >  =C2=A0=C2=A0 netlink_sendmsg+0x2b8/0x584
> >  =C2=A0=C2=A0 ...
> >=20
> > Return -EAFNOSUPPORT from vxlan_igmp_join() and vxlan_igmp_leave()
> > when the address family has no socket. The same leave path runs while
> > rolling back a failed join.
> >=20
> > Fixes: d074bf960044 ("vxlan: correctly handle ipv6.disable module=20
> > parameter")

While I've introduced my share of bugs over the years, this one is not
introduced by my commit. Commit d074bf960044 specifically checks for
the metadata mode and leaves the ipv6 socket as NULL only in the
metadata mode. In the metadata mode, there's no multicast and the
vxlan_igmp_* functions are never reached. This was introduced by a
different commit.

With the current commit message:

Nacked-by: Jiri Benc <jbenc@redhat.com>

Please find the real cause, fix the Fixes header and resubmit.

Thanks,

 Jiri

