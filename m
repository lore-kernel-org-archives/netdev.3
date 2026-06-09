Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECB4CA29F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026834; cv=none; b=gvQDnpLrSbfLlmTQmREIxXwkbctAahQuMjmlhiDo1o6V1a518ddH93FWXtjU4lzXu07LILapRT2utQtfmNipECRWh51Z9igpMA8ExwRlMNlVMt6vu2tLqXA8pBVi0PNytU+7PTBJ1PUW+clcOnwAxTWf79bxOwPDYBViSp4qBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026834; c=relaxed/simple;
	bh=5WDMz/x/utr04OsnArtwnvfE6JMqgBIINSg8cv8iCvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoF5vaTCh8oFO7Zr+q/WgJ3SIliWQxFP9llZx4Ozvs+HHpW2Dt13hCVozE9jyEHNkyOBVHt74EfOoX/a73F2mTfzMpM/ao5lu/UVlqO+AhrbKJvMkbajpTjW9IqRPTa83xKHt3dAjXDvcXgNXtDrBJkBgZbpAPS+N1Hs+d5f8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hiyCHfQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiyCHfQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781026832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WDMz/x/utr04OsnArtwnvfE6JMqgBIINSg8cv8iCvA=;
	b=hiyCHfQEqT7Y2OjoU6Wan6gGgcxlbG7zCLVRIJs76FMcWkW8RXinnN34I9Gd9YN/cDEmBU
	FezjKf7WZGNG023EyusYP0q2xo/udofBTgFk2yde7vF3n87oMETtJHFvkIwuRTVuc6Dk/b
	7AyKQmwU872i7frNkfTHmhkuqZKNPX8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-KiEpRw6ZP5S_nAW37xMOwA-1; Tue,
 09 Jun 2026 13:40:30 -0400
X-MC-Unique: KiEpRw6ZP5S_nAW37xMOwA-1
X-Mimecast-MFC-AGG-ID: KiEpRw6ZP5S_nAW37xMOwA_1781026827
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 637FB1955EBA;
	Tue,  9 Jun 2026 17:40:27 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.65.149])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9664F18005A0;
	Tue,  9 Jun 2026 17:40:25 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
 eparis@redhat.com, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2] netlink,
 audit: prevent false ENOBUFS on timeout expiry
Date: Tue, 09 Jun 2026 13:40:23 -0400
Message-ID: <2756655.vYhyI6sBWr@x2>
Organization: Red Hat
In-Reply-To: <20260528162901.2d68e2e0@kernel.org>
References:
 <20260513172443.1128496-1-rrobaina@redhat.com> <2143396.Jadu78ljVU@x2>
 <20260528162901.2d68e2e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello,

On Thursday, May 28, 2026 7:29:01=E2=80=AFPM Eastern Daylight Time Jakub Ki=
cinski=20
wrote:
> On Thu, 28 May 2026 18:40:44 -0400 Steve Grubb wrote:
> > > > (3) A new NETLINK_F_RECV_NO_ENOBUFS socket flag doesn't exist in
> > > > stable
> > > > kernels where this bug is actively impacting users
> > >=20
> > > Which commit are you referring to? Isn't that flag itself ancient?
> >=20
> > You're right, it is. I see how this flag would fix the pathological
> > behavior that was reported. But as I have looked at this suggestion,
> > there seems to be one wrinkle. User space should not need to know that
> > the audit code in the kernel has this retry mechanism.
>=20
> It's not about the retry mechanism, at least in my mind - I read
> your reply as "user space should not know that there was congestion".
> Why?

In the audit case, it is not useful. I know there can be an endless supply=
=20
and there's not much that can be done except dequeueing what's next.

> It's not very useful, I get that, but user space can just clear
> the congestion signal and keep going.

How? The recvfrom man page doesn't even discuss ENOBUFS. Which is one of th=
e=20
strongest arguments for a kernel side patch. The fact that there is exists =
a=20
socket option to declare that you do not want ENOBUFS on netlink sockets is=
=20
esoteric knowledge. The netlink(7) man page does cover the flag. But even=20
where it discusses ENOBUFS, it does not mention that this is preventable by=
=20
setting a socket option. I do appreciate this being pointed out. But gettin=
g=20
from the recvfrom man page to a solution is not obvious.

> > It seems like the audit subsystem should set the flag on auditd's
> > socket at registration time in auditd_set(). The kernel is the right
> > place for this because it's the kernel that manages the retry/ hold
> > queues and sets the sk_sndtimeo that triggers the overrun path -
> > auditd has no knowledge of these internals.
>=20
> We have to carry this code somewhere, either in user space or in
> the kernel. I'd prefer not to carry it in the kernel.

I can put this in the audit daemon. But whoever else writes a similar app=20
will have to independently discover the same solution when faced with the=20
pathologically bad behavior. A kernel side fix would have made it easier fo=
r=20
future app developers to be successful.

=2DSteve



