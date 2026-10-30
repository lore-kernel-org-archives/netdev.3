Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793319508;
	b=SG3zkSbn+XrZiY2YrQw0/bjCF/rAFPWWHUVndHieIgUlij+l/DqB3t6Cg9gcNscK6qmN
	 eyoQ+pcQLcRLC/bbcesv3P9HrXKl5ah7HiTWo/Z2b7evJ+HhPL/9R7fO86VihTv6LVW6M
	 L1bWNRfeZyHXv99KZz/N86gNz7IO/r7IM//I355afce+Yhlu5IqL09zqAR1a5kRJ9ZvuQ
	 gUhVhrkMmJoFPL5pHfFp7qbszND0cVNPSbVPZS+tITYGWIbu4OcioJcDPmXlaD7BUc9DO
	 SLxZRxA9YZIJt7l9f4sASGmroqKHnv4RsvkewpOSB5jmL/oTyDEGahy8efawu2L9jBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S5DSU31pXzY2v2OdMcYxNjC9qvtcKKd9XcG8ttX3g2I=;
	b=muMQtJFIwiazsAAgmFP1f3s7V9weRkrkM3ZV6rifa9hu8WjVaGrXDxDE5e5M2USbs4k9
	 dPIzmMlx3gzZK4e+omIRTAiBbxkDiyXT82kFeDYtwNqjdamQXHOwtPDdpQQVA9tFnKHdp
	 cWGHQ+9g9cd2BtfZB1JHFhya7/B6MuDK9pNcBKRgFKLI4/MKPGxuPJKXuqYOmQDMwxW34
	 NSn9tDdvNmO7zIrAzS+qQKKHDQShKv22Imz1iqjmjn6w+qxjWbWV5pHXCy3kk4itsheQC
	 XJ9GFxl59EX5KcmLmXiurQfg8tq9YxNnaPwown6PFoWNC9pOgJNdnbQGidfDESicKsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=khdGFdjD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50111606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50111606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=khdGFdjD
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so5427a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793319507; cv=none;
        d=google.com; s=arc-20260327;
        b=B/J2W5ONmeQpl2MqCdk8C57PH+JcYY6DGofvU13pD09ioLOoU9o6rQIBlQuJ8TSJFF
         XwIURxOgS/sWGXG1M0GoHnApLUKeZ/kQM4aKN9EOIG7cBKFjP9Y7jseKNR6VTP+MaSro
         h//2JrIywgum/vliTrdO8D8IpO4Lpfqwq/0oMdYidlc8t3vKxjAtUbA+L72f8fugWTnf
         TAKAVujAb5X+RLf4gnAQIjQjhznG1uCRuy6hexz275f5lbTUYm2sFMKRyrbPA8q5Fagv
         BkX1hZqNQOj7RabDdtTkIbNwIsAriJypQgnGbOfTK5hWao9+HSRSriW3Xj7RIKZ4cci5
         3DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S5DSU31pXzY2v2OdMcYxNjC9qvtcKKd9XcG8ttX3g2I=;
        fh=O+C/qfjNqXtzH4SSX7k+qLc3gipJ76nD10vA6XZPts0=;
        b=hj2HfPvLVTAWfz6BvjlgFb9a+hreeej5m7YwGYUeiJw/wYs8TMaemnP8vawTMwFOkE
         GFSgdxE8DU0xNXg6ddpliexGGORrEz0b7Ut35O1NN6jgvSc7zltmvAZJP7TP3Oh4mubh
         Uh5FMrhraq3x/cSDi7KBA8pW/fEWE2Tnr7zVwAZN4d1Zm45qSaqCO3QeXUj9q5pyuzBe
         CYdLvxwc2DMFhY5pmwbYNT3K3Mx6vTKGv3bB4te2RUGj4SQKRiz/w6W0VvCd/hN/rg9K
         yDx458S1o+sC9EiFgKLhRerrT4kc285WGBuNEfzotfdazU8U8D+DkFxxLQJ39lUXNyrF
         98Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793319507; x=1793924307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5DSU31pXzY2v2OdMcYxNjC9qvtcKKd9XcG8ttX3g2I=;
        b=khdGFdjDFpOqYC8MJ28K+ZFEyclaWMJe9IFj7hLEoAqBgyxPF2pcHZ6fgec1TCOwkB
         NkOxqBwqUK8iuT+O6pEu+Y1135bbQ10CQMfb/E0jCSMQqEmI2cM1DcyJkeTlleUMVzgM
         SU9cUzkwj/0K4CtbWW3w2X8QCCSGKzAWyG9q7kauVOzqmin2ACDIuBS/3tnkTF9ftEKM
         HVRnqucADVSX4zdAFio1SMY5b3fbLh8JhG9pr8vYwr6CxPe8Wpo/tI7ktMa5EKoroeQb
         2jcF6at+dqLOpNeWWniaEJv5na7Gc9fvJMYz2FnUZHJ42RR+gcLWnAFKXxzIfgq/JEzR
         lZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319507; x=1793924307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5DSU31pXzY2v2OdMcYxNjC9qvtcKKd9XcG8ttX3g2I=;
        b=zW7+0OQLZGQDBtV8NREJtyyrAPWSA78OZ4Qely0zPR9zJttfDZh21o2iwkSJcvkWub
         I3DN+tHi10pau/cmfX7BFkstnrA31ENFlhKxqe0YOKnQvUZJplERMd4+M6GD9nc5zDo2
         6p0K0wGgs6lGcjRSSKT5rRfBXu83cnJbOFIQBFehKlybzlgQj2rAIpbaPIMkOo9j0UBY
         kslc9JrTYUdmg1y0iUhcIk5i44cBadIWHrq1uE0qIG0DNJLl9tM5KvJvfCNA8yjyX5jP
         9u8+Pg6udXvZ7psnLyy4zDL042HDHMn5bpwOkEmmFG63rUGDDM115Qj+PumL808ypmlI
         m53A==
X-Forwarded-Encrypted: i=1; AKwUvBwuAiHwz81YqwC4CbSUhx4T2wxNwJXjZvoV7hyGH8RPpFT8YOZp8uNcZJ+bVqMe5Xn1rwym+ko=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYN6qYMBxTdCigcGPjneG/hUGDsh7TiEVrYqq7rPQ0dWjxBj2C
	pQVW3ycQNMWsdggyFrScfZY1h6OC/nJGMhpHN1kSeqRJkSJ6ryBAbcARrDXIXGSuH6ACU5RNMBt
	Dx5bgv1ES/0w4cpFTse5rq0ba9b8ILq1lKS+XXnpu
X-Gm-Gg: AYBFou35y3ZAMp6AcfP28AFgRt+68N6crjWQRcNa8T+NAvjWBYSL/rZL4Yw/J7R6goc
	TEJ/Fk2nH1XvN8+bMTInRztdM18k/V4nCuXQguhel/msMCqgeaC/V0f+beN+wccxu6VQmC35KnM
	NGAnHH2gQhObk2H9BC8gQImj5o1sGgt1D+ut+9R+fBbWJ7Qa5ckChwgWiTJ11Zg/zpde1dk7oPb
	yroO5JACqxjdHC5pbo8Y62/mYEj3e2YD7bLs9OEUUwQnY0grgmqUiUelXoe09nMZXV43szOYHAa
	Ipi6N37rhqTcNlna5ds5Da2Yv0qheEDmtC+l4mq1lGYTWHYRnLvaoccnQ5THCbak69NB8l/5oKd
	/ILBOzV+9gTZhnE9NpxNHjdbY5GQVaakFP9s=
X-Received: by 2002:a05:6402:a20c:20b0:6b4:2d6:cb9e with SMTP id
 4fb4d7f45d1cf-6b4b0e90adfmr140391a12.2.1793319506250; Thu, 29 Oct 2026
 17:18:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030001444.289973-1-omermetekaya0@gmail.com>
In-Reply-To: <20261030001444.289973-1-omermetekaya0@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 29 Oct 2026 17:18:14 -0700
X-Gm-Features: AclHuK89zkJqX9oz31JoSer2NQVqLZj3zAgbKT6NjSS1tQOfjKS1pGrNQOfrUC0
Message-ID: <CAHS8izOAYwGR_ukmXNq8V-wOVDxGu0TWET1tjGa_nXG99LFUmA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevsim: reject port addition and clean up
 ports after a failed reload
To: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:15=E2=80=AFPM =C3=96mer Mete Kaya <omermetekaya0@=
gmail.com> wrote:
>
> nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
> can be added via new_port after a failed reload.  nsim_dev_reload_destroy=
()
> returns early in that state, leaving them behind.  nsim_drv_remove() then
> hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free=
.
>
> Block port creation with -EIO when reload has failed, and delete any
> leftover ports on the early-return path as a safety net.
>
> Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
> Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D88435e204734072bf39a
> Signed-off-by: =C3=96mer Mete Kaya <omermetekaya0@gmail.com>

I'm so sorry, I don't think I was clear. Currently net-next is closed.
I should have said wait until net-next re-opens and THEN send your
fix:

https://netdev.bots.linux.dev/net-next.html

And yes, normally fixes go to net, but the volume of fixes has been so
large that non-critcal fixes now go to net-next.

Let me try this:

pw-bot: defer


--=20
Thanks,
Mina
