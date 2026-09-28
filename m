Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6A4E50D9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617381; cv=pass; b=jXFQyYUFQRiwkoVUh4vT+6cUsQutzvvAtSq0Bub39dMoCEI9Si0QXNwUIlaAuwTp31Z0F8cnMwO0ZcUxZsb8DrsJiocfMWhRoy9IQ5/ygmdaeIQl0mtWTgptzJxQGvqpcwYzvLdcpEfweGDMi6irg2N+cvbUpEEcBQbJAF9P/Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617381; c=relaxed/simple;
	bh=tBMm4XuAu0hAMOVLllg1YwkUSfbdG6RXoepaWP9ckQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFiP3W5+4GjfscyByt2gp5cTjtmh0IEwQHpH7bRJoIqMWaIoLJ/+Br2+PfHZ0y2bEesufsbBLV5Eb5JJIUBnYDgKecICntPrG9s0NLhmqCG2K8JVA+F/6/U2mV9wc7Ow4G2HEQ7rx6tW1X72i5K9VGC8Tzz8THhYdqgZoCjH/vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiydTQbP; arc=pass smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiydTQbP"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91434eba587so32709386d6.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790617379; cv=none;
        d=google.com; s=arc-20260327;
        b=WOmFN09V1/Xk4xVJ2Q0Tg9ESUPjbPeGYUWB/6j1U2/wBflXuq0uFx/mKByGAI1yBsF
         zmydBcIQXRZyRQs9J86f76mX9hh4jf6qhtgjTOfG/VeSJ7EccsVTsj7rPRAkfcO46jri
         qiNlxXnPqE5sqWFoxQZIrBLjclAl7HJPTB+KQJpoLY1O9AjYLnHQqfgf4CV+YVI24UUc
         swWI4u5OTpw8JPO38SGNWaXERwiTb8K26N8MQGjtMrsly5xktgOT+9sfajLMEr8VHg0U
         40m0uG/nU55Ui95oS6yxnmVZTmVyiBEfEpkH0ch7pMUnQX1FHlwjxGo3vr/gunZBZYj+
         QKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tBMm4XuAu0hAMOVLllg1YwkUSfbdG6RXoepaWP9ckQU=;
        fh=JawWCUzA618jMjYbRgB/cX/mxOjTcLKhHRlnVIZwBJI=;
        b=ZGfPiy8+ittU18/ePygs9eLilqYQSmxwnzkoY2gnsDklNI4MtZjmwMDBvkYSlPjcLf
         PasiDbRNjwxqoma5UalHCQPv/k2Xb0dKeaWFYGkIi2tBVm0nr5crwNJ7NoBhr4Wc0CaK
         I+ujEjdF1cRrSLMGjjdh6AtBvYJrG6WP4JcfVwgzmJhhqIRgO78IlVeU54WTbrfV66kH
         GTbHB8J9iOquNeomGF3zu17HLSP2+RJiYAtzi6mH3xi18H60Iv/Uob3H82xAJT5lO0ei
         w2lnPGB1fod9PMt5hoW0YgovuCDgwGiUCUyFHIxMJfyt+dQzU1aajrWEsqKOrvD5c8Tr
         JKkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617379; x=1791222179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tBMm4XuAu0hAMOVLllg1YwkUSfbdG6RXoepaWP9ckQU=;
        b=BiydTQbPOeAdEz0U+bzGEnx/hSE1k6ewf4aMRoMI/2XZlXpRXLQclvnvxsqPdEQG/l
         h00rCmCFEAO7p6193k7t3r5BZ1/uO5vFJ5jRnNpc6euCKQQlYo9cFwDBrPle58+YUDCs
         RnFFe7BesbeSIbde3fl4loiPTl6ckapSOxjdF/Hm62pwMLuubtuuu0w/cUqYRZwH4RkB
         WAnf4uaBNuRDmMPQ4pP7M7m6qetqPjewMQqqtS5yhRLeQp0p+0YmTq8SVNnDv20jZdL7
         9rJ1N8jll8Y1mcwGYYgd4ydjInK4EFedd6RZAYWyRalLFLG9X01Vmslp3yvMjQCC+VDS
         /rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617379; x=1791222179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tBMm4XuAu0hAMOVLllg1YwkUSfbdG6RXoepaWP9ckQU=;
        b=L/7O/QIe8Ux/hm1WoHA9oUuDqyK+I//JdDjhHhJVzeERhKptGz4lQt1c8eh2xOexOi
         92YywmBVOuKL0sYoK3JVXGXEkf94sUAXLFAzZXmd4G/84Hc6+AE+RiB9JMiKQ0pC1ORh
         ZqFSnsJLMvQNxfh7sSIg1mGijf9PQ/xuV2MaAdC7W6brabD7RoHIAq7gB8uSSvVH4gCF
         lGam6k/plA6GCknty83wQ5tDIANeuYjk3Q7dSL1oFbE4jcOG+23UM5/J4UrgyN8DD1rr
         YzvcK/zq2rSZ3krG7lZI/Ymb9gs8BVacO3kigoG6iOp4b7RaDjwXEWBVjQgF+4+v3ofe
         KYQg==
X-Forwarded-Encrypted: i=1; AKwUvBzOYcNuuPd/v8k0E9kmWnEHMiFPaOAS+iDC2XWkbPfPNJHjPb8rwt+XiKb4OLTI1YAZHs0UDFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKifvBPV7N7uwf4n9e8gPKwwWW8lm0QZIPopY+uT9gwSTxMM+Tb
	wGKoyw53/TQAiojCUSslliMiz3OBjubSaM8UmDuZxX5H9yrgMQzh2HXkHaGbj2VNL0KUFkq5MKn
	6IACXj9BSEddnjpHG87J+myqrKThqTIKv00ZkXaYj
X-Gm-Gg: AYBFou2M1jaPIhFOpAsbF4b1l+u+zHR+V+VsrWr9GzAzY9yNAh2Sdx+gu+DDPFYdUA4
	WiyGsV2yDH8zod3pvbUOeIZcWbF3MuG3g1dsaF6WeOdfZj7SHYx+JYCs+nAfikggY661wie8Rq2
	O5+Eq0OKUZT9H1OghekhxqSO4KoTMZi8Wylp+vZUBMX9dDBAqXCcuk+eui3pYQC+fj3IcdqA7h3
	h3N2QAkqLf8T2IkPj7luRlNgqObHr8dmREF5XPd+q80kYCPqwfE/dBdfaMr+zVKw2FafqFQmVlz
	qLvw+1Rl9gUYC8ADEFJIioj/5BTtvbUXb6O9f7klMBt0mS3UR96HKce3+0ROrthhwuguu/JZ/ro
	LqkzBd+geigmdLD7Q0bAVR0fawWaJVEXTY+qwxuJUjw==
X-Received: by 2002:a05:6214:21a9:b0:910:2f02:8c46 with SMTP id
 6a1803df08f44-9143222edc2mr218567806d6.14.1790617378675; Mon, 28 Sep 2026
 10:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a73d174.5aeeccc9.207e63.000c.GAE@google.com> <6ab29768.514bccd6.255447.001e.GAE@google.com>
 <6ab8c8cb.e548f532.1ca396.0037.GAE@google.com> <arjO9qbNdbvdi7ao@gmail.com>
In-Reply-To: <arjO9qbNdbvdi7ao@gmail.com>
From: Pimyn Girgis <pimyn@google.com>
Date: Mon, 28 Sep 2026 13:42:47 -0400
X-Gm-Features: AclHuK-qpUM45iPuLgTgCnMsb-qo1Qn6VReor2uYb0e5oZPZ4T_26Jl9lysMnJ4
Message-ID: <CAJWNTGzZ5=bBUzsAhaLLqNE0J3a_tj9BB0OvHhOaaWR8xn9S3g@mail.gmail.com>
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in rxrpc_destroy_all_connections
 (2)
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 4:14=E2=80=AFAM Jose A. Perez de Azpillaga
<azpijr@gmail.com> wrote:
>
> I just don't understand why it is failing... :(

Hi Jose,

For future reference, you can send the patch as a text file attachment
with the `#syz test:` command instead, which will avoid any parsing
issues.

--=20
=E2=B2=A0=E2=B2=9F=E2=B2=93=E2=B2=99=E2=B2=8F=E2=B2=9B =E2=B2=84=E2=B2=89=
=E2=B2=B1=E2=B2=A3=E2=B2=85=E2=B2=93=E2=B2=9F=E2=B2=A5 - Pimyn Girgis
Software Engineer
Kernel Dynamic Analysis
pimyn@google.com
