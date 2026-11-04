Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810933;
	b=R0aKpbkWQmhW9H93KYVIlidMUuFsYjXhPD5n6tPD+VXTXER6VX9TRVjoVIocTgdXco5P
	 upxmUGH5U3meUGJpoBU9fXW58ULqrboBJd4qccuQdy8xLKfljzg1Bg9ygiKvkXaKGoYTJ
	 ijQC5YSehtthSstX0YXV//nmkONl5G00fsgCtFrshSnMJiYaKiWHozz4DWfW0jzbAph2T
	 dyt93YJqAw+Dit9w8noLb98dzhus4CtmBQT4djJgeA5jcvobTrv5R8R4Ve60JDAe49rlF
	 pXRyyW/+iaZYIg20u/mY5vw1d6Dq4UOTUhIS0+TAsTN/QNqBONZmXyy8CUdFCUAZeRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810933;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=+6NWrTkD19j6pXo7fX9iBIpL0RSF2GXs9ygbR1u2JBY=;
	b=BLsOqj0T9bnxzgsij4cwfEtEP1nA0jb3MQQ5fTOXrqKeXtiS1F5KmYESIIewWKj9rDd4
	 8b8WeQ0jaGo530EgA74XsIE3rjFSlZiRlKoQNMycdeqHGsdv1Vk/dqoAltCVB/fCHufoJ
	 3coJIBgPeOLf2MZqSbdEz6OJbSgtbOH/HyRFDa4DDF7EQQcOP6m/QCbhhplFSdB2M7cvq
	 0ampsHaYH//86x1t333LJ2v2aPvB5hHKCb4utTBesHTj6dv+62KHKFgW/3puQ84hxX9E/
	 OnsnJirS/08CBFTNf+eBwQiC4+B4KFUOVsw3Uu2HBnPT+i/j861/Vvr8F9hJ8N5c0Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=vFIzAH37;
	arc=pass header.oldest-pass=0 smtp.remote-ip=176.119.200.173
Received: from mail-200173.simplelogin.co (mail-200173.simplelogin.co [176.119.200.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00C606D815
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B00C606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=vFIzAH37
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793810930;
	cv=none; b=N0D8eoC8N93Rzw2s/p7ne8H5Qo2NehM3SEUus6xtEEucCRWTSTU4odUMAFcI5UgFsSaXgy7q8sFmjfyjhzVy/bVYpcv8KINQ1zgrEAzyJgnWJhvfoFnVcY/YkKR90hMp+cjtJZgMoQN3BP+s1/JlwGC7zMSmI1HIoeCklN15Rgruqi/MyluW/hFq/dJzp/jcAnpASpYBtVanaxzv2Yi7pNQDoM3d8jODdAvEFBMQEHnajDRVyzm2U16z/GoMlCcpzJofXjdaYu9CxLhtx8Cr09nA1Dsd+zhk6W66iN7p0QyqKL9uID9MEjkDQzL8W10gq7mYlpqy/RnxOUnluRAomg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793810930; c=relaxed/simple;
	bh=NZfHjc8GabK+5fWc9xU1eIPV8ar6IHlihuK1W6X9Wrk=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=2iqJnhFf4VrmHikqBv0PQ8K5NOhbaMGatWwyMimu1PLix+Qs5J94WbChyvcux0x3SAH+WAUU1qJ4ofY8vNqpZoR7Ov3H6ri3IPULnDIs9WCd0LeR5veg/OTMKEuuTmj5CEy0r4qr5nlZvIqv6ewEgvlUAqTd0E2EZjRJ5oDg8yrBkPm3tcbf05cNKCq789u7YsfAvW/8f/8Cape1+ghk7cbmrMHPm9Yflf4u2AWUkr7YqEXGqBtuDND7BR+ZrfS9X08NeBv9QkKVaf7IRV3fic2hXeymLXQAKaoxqYOLk1PziXzCz7cYG1wRrpGd35cQ0OpREoyyG8NEBtfrPsgsSA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793810930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6NWrTkD19j6pXo7fX9iBIpL0RSF2GXs9ygbR1u2JBY=;
	b=vFIzAH37Cw5VrNpmVFx3zCpuY0HMvAs8h3OdcAiJwMmK75wgnH+SUsX+0FMbLZK3Wt7ACv
	Uj6m29AHzV6CsBGkDlTCceU5UIchtfrK/FYZPU9/OH9o9Xh4JhkfGAdDtShlx4eVXFVUDG
	uVG2UKdHELMjqEsMSpM8siiqPJxdJJw=
Date: Wed, 04 Nov 2026 16:48:44 +0000
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting for
 data in recvmsg
In-Reply-To: <auSkQOU6qmj0NPEt@sgarzare-redhat>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,"David S. Miller"
 <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub Kicinski
 <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,"Michael S. Tsirkin" <mst@redhat.com>,Michal Luczaj
 <mhal@rbox.co>,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179381093020.9.4719932034061956856.1746278795@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
 <auSkQOU6qmj0NPEt@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746278807
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 03:18:10PM +0100, Stefano Garzarella wrote:
> Ditto about commit message, please put more effort on writing something
> readable by a human.

Agreed, I'll rewrite both messages myself for v4, much shorter.

> >+            if (sk->sk_err) {
> >+                    ret =3D -sk->sk_err;
>
> Why?

Same as vsock_connectible_wait_data(): an error that arrives during the
wait is returned to recv(). Without the check the loop still ends, since
every path that sets sk_err also closes the socket or sets peer_shutdown,
but recv() then returns 0 or -ENOTCONN instead of the error.

> >+            if (sk->sk_state !=3D TCP_ESTABLISHED) {
> >+                    ret =3D sock_flag(sk, SOCK_DONE) ? 0 : -ENOTCONN;
> >+                    break;
> >+            }
>
> I'm thinking if we should split this in multiple patches.

From reading the code, it can be split without breaking bisect: first
loop on all exit conditions with the lock still held, then drop the lock
around wait_woken(). The order is fixed, since dropping the lock alone
brings back the early -EAGAIN, and the loop alone does not fix the
deadlock, so both would carry the Fixes tag. That is why I kept it as one
patch, but I'm fine either way. Split it like that for v4, with the
current 2/2 on top, or keep it as one?

> >+            if (!timeo) {
> >+                    ret =3D -EAGAIN;
> >+                    break;
> >+            }
>
> Is the move of this check changing some user visible error?
> I mean before this patch it was one of the first checks, is this okay?

Yes, for non-blocking reads, intentionally: -sk_err, 0 on peer shutdown
and the not-connected result now come before -EAGAIN, as on the native
recvmsg path. I'll say so in the commit message.

> >+            if (signal_pending(current)) {
> >+                    ret =3D sock_intr_errno(timeo);
> >+                    break;
> >+            }
>
> Why? Should be a separate patch?

No, the loop needs it: with a pending signal wait_woken() returns at
once, so without the check the loop spins until SO_RCVTIMEO expires, or
forever if none is set. I checked it by removing the check: a signalled
reader without SO_RCVTIMEO never returned and used a full CPU. The
native path does the same.

> >+            if (data < 0) {
>
> Why not data <=3D 0  and void the other if?

Right, will do in v4.

Thanks,
Jerome

