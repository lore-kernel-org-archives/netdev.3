Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E19199D8
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347937; cv=none; b=d2mtGE6DdIuRI+E1s7FskUGhBvHiemFNb/unsBSED0kooAdr+KZXmSGdZLWDIFwTe1LtBDsJP8hnnYjNfNbCVSMznCQojhfHijV+WcHDkNV/YRFptHTguLE/gBUtRNnwrVVvQySRk1O45SRylNYnyuXMXneWkPKf7UtgThfLAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347937; c=relaxed/simple;
	bh=BiE1bhI5jbqMMbXQak3DGFI1QZb9oa8pA0iR8BD2rco=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fWBtZ6qX3xxXbJpDUpSXe3CORi5qrPL5GRjUYk1Avktd9NwxS5N4DmgQtMwQLHALMozF3BNL1RolMWsNwE4NZbAlQlEj7CIRokNK8Vr54u/dIFtQjl+p49EA1fenEgQrpRnb7BjJGZWcOgvn7AOVn4tMU34QQoMFgnVSILpsyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BXIatxp4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BXIatxp4"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772347923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UI6tQN7/V6GHu788gOAS8+QWQ7O8T3MTG5e+BGoQTHs=;
	b=BXIatxp4k8GHJm6QoEwM7AST6Hk2MUvyYobd2HSS5XE50NmzE6zMaSkf0pQnotf9enLDXz
	jTySJuRJzB/KNlT5qHOk5KS3Tsd7aK4I0uq9ggqPMKow+JDvu+oERk//GMVt/UQ2iWgc/d
	eF5M2qLk13CvOks2avtsp5Ul/Nwwp78=
Date: Sun, 01 Mar 2026 06:52:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <f85c8e268a8384fe14ba5b0033b9f9b931afc122@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] tls: fix hung task in tx_work_handler by using
 non-blocking sends
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+ca1345cca66556f3d79b@syzkaller.appspotmail.com, "John Fastabend"
 <john.fastabend@gmail.com>, "Sabrina Dubroca" <sd@queasysnail.net>,
 "David S.  Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Paolo  Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Vakul Garg" <vakul.garg@nxp.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260228091545.412a9a2d@kernel.org>
References: <20260227063231.168520-1-jiayuan.chen@linux.dev>
 <20260228091545.412a9a2d@kernel.org>
X-Migadu-Flow: FLOW_OUT

March 1, 2026 at 01:15, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@ker=
nel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:


>=20
>=20On Fri, 27 Feb 2026 14:32:31 +0800 Jiayuan Chen wrote:
>=20
>=20>=20
>=20> tx_work_handler calls tls_tx_records with flags=3D-1, which preserv=
es
> >  each record's original tx_flags but results in tcp_sendmsg_locked
> >  using an infinite send timeout. When the peer is unresponsive and th=
e
> >  send buffer is full, tcp_sendmsg_locked blocks indefinitely in
> >  sk_stream_wait_memory. This causes tls_sk_proto_close to hang in
> >  cancel_delayed_work_sync waiting for tx_work_handler to finish,
> >  leading to a hung task:
> >=20=20
>=20>  INFO: task ...: blocked for more than ... seconds.
> >  Call Trace:
> >  cancel_delayed_work_sync
> >  tls_sw_cancel_work_tx
> >  tls_sk_proto_close
> >=20=20
>=20>  A workqueue handler should never block indefinitely. Fix this by
> >  introducing __tls_tx_records() with an extra_flags parameter that
> >  gets OR'd into each record's tx_flags. tx_work_handler uses this to
> >  pass MSG_DONTWAIT so tcp_sendmsg_locked returns -EAGAIN immediately
> >  when the send buffer is full, without overwriting the original
> >  per-record flags (MSG_MORE, MSG_NOSIGNAL, etc.). On -EAGAIN, the
> >  existing reschedule mechanism retries after a short delay.
> >=20=20
>=20>  Also consolidate the two identical reschedule paths (lock contenti=
on
> >  and -EAGAIN) into one.
> >=20
>=20It's not that simple. The default semantics for TCP sockets is that
> queuing data and then calling close() is a legitimate thing to do
> and the data should be sent cleanly, followed by a normal FIN in such
> case.
>=20
>=20Maybe we should explore trying to make sure we have enough wmem befor=
e
> we start creating records. Get rid of the entire workqueue mess?



Regarding wmem pre-check: the async crypto path is not triggered by
wmem shortage =E2=80=94 it's triggered when the crypto operation itself i=
s
asynchronous (e.g. cryptd fallback when SIMD is unavailable). At the
time tls_do_encryption() returns -EINPROGRESS, wmem may be perfectly
fine. The problem occurs later when tls_encrypt_done() fires and
tx_work_handler tries to push the completed records =E2=80=94 by that poi=
nt
the send buffer may have filled up. Since these are two different
points in time, pre-checking wmem at record creation wouldn't help.

> Regarding your patch I think all callers passing -1 as flags are on=20
>=20the close path, you could have just added | DONTWAIT if the flags=20
>=20are -1.



Regarding adding MSG_DONTWAIT unconditionally when flags =3D=3D -1:
tls_sw_release_resources_tx() also calls tls_tx_records(sk, -1).
That's in the close path where we actually want to block and flush
remaining records to honour the "close() should send data cleanly"
semantics you mentioned. Making that non-blocking would cause data
loss. So we do need to distinguish between the two callers, which
is why I introduced __tls_tx_records() with the extra_flags parameter.


Thanks,

> pw-bot: cr
>
