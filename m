Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD444A722
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926364; cv=none; b=HweWesWwQlqVYSijxgYqVeAXzE4Ot/Y7HeghDpfgoULJF5tCGluII5Nkt8oVO8zw7PTqE1+FS8Xalhd/A9JKQcdW9l3NHeizjoooFTe+c2FBPGIwtqzwzl3YWpy+pqbfFlVqzrykh7kl1N1RsfPIvwldoVOl9L9BREkUhL9BmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926364; c=relaxed/simple;
	bh=Rngc678hNJTr25sQmCLjzdFBZY/QVlfT9rMJmXRGFns=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=IgC/LhPwl+Wn4FW/9aoTh4m9n875cEMDGy1v+twQNF3pxy52sUCJoDlJkH5DontmraGRVbucWeSeW12fvPWWnp6YvJWJIoqpuFLfqRfA1/s/uHHQjj9qiwUVx3cgdn0nQE2Y5a197rafh+ZQVnDMZkyvARkWqBUX8BrxCMuhTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ARr7Z2gc; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ARr7Z2gc"
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5d94:0:640:92d3:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 758BF80DB8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:25:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sPd9gfxGsW20-y6b8st0n;
	Tue, 20 Jan 2026 19:25:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1768926355; bh=Rngc678hNJTr25sQmCLjzdFBZY/QVlfT9rMJmXRGFns=;
	h=Date:To:From:Subject:Message-ID;
	b=ARr7Z2gc0VoHHs2vvAU9uh2q8/z2SJNrVD+CwhpKYmZTwUAAdJvcvffBxz63Z94r0
	 cqqfXnYsKoVScIiZctsfCCol5V1q+y3jauj+x0dmgGylSPUg/qH9YqD5qGv7cIQ5Hg
	 /bPWnf6u/tgGVeBtfJ9xiZlI/RPcNq6VbEUO1Prw=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <68ff91a70ff77f85c655b4de4d450b2172ef802a.camel@yandex.ru>
Subject: On managing socket's error queue
From: Dmitry Antipov <dmantipov@yandex.ru>
To: netdev@vger.kernel.org
Date: Tue, 20 Jan 2026 19:25:54 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Is there a common design pattern to manage 'sk_error_queue' of 'struct sock=
'?
I've found that some socket destructors (say, 'iucv_sock_destruct()') do
'skb_queue_purge(&sk->sk_error_queue)' but (most of the?) others do not,
and it would be very helpful to know why it is so.

This question comes from https://syzkaller.appspot.com/bug?extid=3D7ff4013e=
abad1407b70a
where the trivial patch (hopefully) fixes a memory leak.

Dmitry
