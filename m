Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5368362153
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734129; cv=pass; b=XBXStWwEkxGnDGVkrk/CXx34/8FJ5+V742Fk5IRN6y7ImMZ5j/cq8UnaQsMaAEyGw2KwE4ACJ5sr8rX6WHYoHa7wf2lNEIYNB7TRhu9iGLjcBw1fRpcVjGylyjPoGKYfOS4i82FoVb8v6QhOmFs1RZgRNaFhHkYEAnaqjzxxhhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734129; c=relaxed/simple;
	bh=cHLQbGT9PXI0kmTGgvdCK4575npp2vblOC3chIxwSP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jj1tRPYVww7iQJmHOUEZUNAhw2nY4TTDNyn48ouUa7kgSiAzte+bkJTgNKKUGWPo1NPhkOByqr2iN4Yf3PDerrveTzz3atn2i4/DdymcIkYiVvRwFUM05tSxdDHlPGFxb00fp0yFwtlUIavJbGlQ9oJgZCY/t4H2ibFNX9j9VRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n67kha2O; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n67kha2O"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64d20990fso46503831fa.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:08:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790734126; cv=none;
        d=google.com; s=arc-20260327;
        b=nDve88aav2eH9SvnrlTLbi57cIJtS0chENQZwp31pqAiBGu58IxxYOX706tMQPcoTi
         1W/bEenhlAseXzhP8oSrlWsfh9sumqVev/BBHeJgGL5szJ6ukDz/Z9DNlmQlKCxr0US8
         8+lmvXBE7PVYY68XSM6HJlKcRnhXn7019ewotbk4zPMUaUZcEyaLoDfyNq89MuhkN7g1
         armyZuqdjBAzzHUT1LvK6rZ92BVkFNpHWOyHqShCBBzjnhTvjJY5f9VBUZP+1LfzT6Ag
         cIdu9SM969LllVAZqlWRrFOjUlieNE9LCPGvGU/y8HHtFoaztDw2HFZyS/WfMfvLtw0l
         +ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XpGo+Qr9OCMDAzBQXslhcLH2BJM+ZWKFH/nT0r3qdg=;
        fh=aS0R4AxlHBcRqpKtZHtHWfUxKEZRtkLhw2FbrY9B+XI=;
        b=KDZ1kmnPE6N5zxImRN4l/QPf6n9XYazAT4IJ2l41PO8RaeC4TD1Jn/gWIips0BtuQZ
         lurcoYXMjQ7Wx8gtQTxR26f5PM63Y6p77q6A4lVUfKRn3TFzCkBLr6Q8HrVY7RFfgYo6
         5QFEuxsJYPlMdtPY6bcq88QVn2PsatM881RUDVaFVOwdI7fdGC+9PbZzFFtM2etW8SLb
         zXwvOp19JPvsGs45UvZdUF6pXMSW6qFWaOAHgoIufzGzGY9urwweuIgFW5q7cUj88DbA
         /fyLSblDirV8sfLECrsdOSPm6ZkOrsoXFETm75ndkX+EbGlOdlygc8HbIgAGD0ZSwsve
         FQVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790734126; x=1791338926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/XpGo+Qr9OCMDAzBQXslhcLH2BJM+ZWKFH/nT0r3qdg=;
        b=n67kha2O3eRTAu/+9aajfOHbrfd1Pswfutj9JWRNNeH7FuRlIB4YYhJqkzkI1ee4sm
         WcApItTS+PrFM3Vf1eRBo4nGuRXMxnHOlIVIEuECOmFU28w3ImzedT1vbb6+L3oP5v2i
         7SvlJjF7iX3t6lOGk70a3mTVpguQSqnDdmdbS9YxKeZnIggBOHHr1//7CMXT5h892B85
         ouKOxmhMOEpb6HHVLV6VBss6G4YVVHUoy/IGS4Az5zvMczzVvGbZIVpTO0jDcetFxLLh
         xLkNOh0AchftufNtBDO9s+umtZvs+Kgb62TE5Jt9Gz4P9FtfJtbFX3B7NXEbWwBA+P0i
         Mo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790734126; x=1791338926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XpGo+Qr9OCMDAzBQXslhcLH2BJM+ZWKFH/nT0r3qdg=;
        b=PMTWfgPRahzrTFIQh1yoNkkmg1I9yMTZuWbsz7RtpF8dw9+K9+zt38YDsdSOYmx7W2
         7HVcc4hexUsC9ybZyY0eb92jxiuzaPsxmonUOaa1IopZR2UIAZbt+6FFd7b8OEL1SYhq
         ZVOZHpd4re9iE0Au6dtEn5me9XuaFYkKNTEnGscF3YUWDiLUjk7/KGA48rRLnMDE1XlB
         oLb82U4unaolihEtVX9LO1dqyn641aUMCzdeE/7UmWMsuQNRaA5+keRYIYYz5OXm5Ifb
         ld52pF/b4rOQ5/tNxqOlVw/72jTsA6vSRbmvyCvWdc8Sc2qatglXCs5Qs0ZhbUxUxwGu
         xitg==
X-Gm-Message-State: AFq9FYIrAM9XtZeTnEbXz5ENikxj4I5zf8MNSHKmWHVXewTBMl4fUY07
	Eo5DN9NisSchYzOcj6fs3599n1pZ/bz+Pby6DRH+3epWnXLE25dpSDf6QdtcwCCQXNVmqUIrGJ6
	idofKgX5ClHhxpy+sXe4QV9I0p8OPzJI=
X-Gm-Gg: AYBFou0wR+cGCC1tVupUMq9j7NkqulhM+LvipwNUvITn7JgWgDwF9xlchhTAlBCRxuk
	auggYgc2voCVeoLxgr97yFvljDcF3H0NYLLtS7jyjvQyhVJnN+WWdzt4t0mpNZ4DFyvuFQss9i0
	Xj3O7WZDKd6LCRzbd/Gu2JOkCWO/MnQOkigaAt487Jy3FQkh6MMyk5eylBZLmcC04drYhKMlJeU
	YzzkcMbU4+XntUIwSAI4Gkt4V/XZeyaaC+PriZ5fE292Rtv3T8DzoJXRQgJDq13hAXjhuUo3TaD
	tc4KJVI+UQPvAWy1h1V4nWmj3Z5H7B1jMY5Qkj0i8Lxeo7wYQpkAid5ldpRrnaJ2IY3tGP9flkt
	09GixLCI=
X-Received: by 2002:a05:651c:b12:b0:3a3:749e:31a1 with SMTP id
 38308e7fff4ca-3a77924b77amr186021fa.21.1790734125697; Tue, 29 Sep 2026
 19:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929064742.576651-1-liushike123@gmail.com>
 <179066487225.31693.13001631968601791232@kernel.org> <CAL9mPHsf_10zX4Z_2WFHNJob7Tkfnaw6sp03q2+ujnTygn1Ucg@mail.gmail.com>
In-Reply-To: <CAL9mPHsf_10zX4Z_2WFHNJob7Tkfnaw6sp03q2+ujnTygn1Ucg@mail.gmail.com>
From: shike liu <liushike123@gmail.com>
Date: Wed, 30 Sep 2026 10:08:34 +0800
X-Gm-Features: AclHuK-Qp4hFCJIT-_w2B4gFyJoXlAvyzEx2aVeUJ5RKp0h3YBXE-WkFgycO1fk
Message-ID: <CAL9mPHuyOrK4WN4ZSWRFSYWpeTQBGjqXLDiy_Wr9AtEahL9KYw@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] tipc: notify pending connects of peer node loss
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, tung.quang.nguyen@est.tech, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue was first observed on actual network devices operating in a
  cluster. The client was waiting in connect() for the server to accept the
  connection. When contact with the peer node was lost, the pending
  connect did not return promptly and instead continued waiting for its
  connection timeout.

  I subsequently investigated the TIPC connection setup and node-loss
  paths with LLM assistance. The analysis showed that pending connects
  were not registered in the peer node's conn_sks list, so
  node_lost_contact() did not notify them. The initial report came from
  the observed device failure, rather than an LLM or static-analysis scan.

  I then reproduced the behavior using the same final selftest on the
  unmodified base kernel and on that base with this series applied, in
  x86_64 QEMU/KVM guests. The tests use two network namespaces connected
  by veth pairs and disable TIPC Ethernet bearers to simulate loss of
  connectivity.

  On the unmodified kernel, 8 tests passed and 10 failed. With the series
  applied, all 18 tests passed, covering SOCK_STREAM and SOCK_SEQPACKET.
  The node-loss cases check completion within two seconds and the
  expected EHOSTUNREACH error.

  I will include this discovery background in the commit message if a
  revised series is needed. I am not reposting the series solely for this
  clarification.

  Regards,
  liushike

shike liu <liushike123@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8830=E6=97=
=A5=E5=91=A8=E4=B8=89 10:01=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
>   > - How the issue was discovered, e.g. hit in production, hit during
>   >   development, syzbot report, manual code inspection, LLM or static
>   >   analysis tool scan.
>
>   The issue was first observed on actual network devices operating in a
>   cluster. The client was waiting in connect() for the server to accept t=
he
>   connection. When contact with the peer node was lost, the pending
>   connect did not return promptly and instead continued waiting for its
>   connection timeout.
>
>   I subsequently investigated the TIPC connection setup and node-loss
>   paths with LLM assistance. The analysis showed that pending connects
>   were not registered in the peer node's conn_sks list, so
>   node_lost_contact() did not notify them. The initial report came from
>   the observed device failure, rather than an LLM or static-analysis scan=
.
>
>   I then reproduced the behavior using the same final selftest on the
>   unmodified base kernel and on that base with this series applied, in
>   x86_64 QEMU/KVM guests. The tests use two network namespaces connected
>   by veth pairs and disable TIPC Ethernet bearers to simulate loss of
>   connectivity.
>
>   On the unmodified kernel, 8 tests passed and 10 failed. With the series
>   applied, all 18 tests passed, covering SOCK_STREAM and SOCK_SEQPACKET.
>   The node-loss cases check completion within two seconds and the
>   expected EHOSTUNREACH error.
>
>   I will include this discovery background in the commit message if a
>   revised series is needed. I am not reposting the series solely for this
>   clarification.
>
>   Regards,
>   liushike
>
> <netdev-bot+sinfo@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:54=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>  - How the issue was discovered, e.g. hit in production, hit during
>>    development, syzbot report, manual code inspection, LLM or static
>>    analysis tool scan.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>>
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
