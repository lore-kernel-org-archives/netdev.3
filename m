Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752156;
	b=pS6oPcgWjuqfr6mOM2X193LxCzX4DIjND1R1GY6/nhglFTV+9YVOCehDJgeJQ3qsqhdJ
	 E/pQ8DaVPwbSGPMJLLM2Kfe95JF6ijxRWjQh08dVAFqtbd8myNVuNfy1zCpvOiz58yZMz
	 qz8c2fKJUVPnCy9hf93VePhMT4Gl8K5PjTLR9Vut70LdoiPHuEkpsGMRO0HzarHp2ZTqs
	 qcTM1cA93jXRQcg3XiZUXkPVvGgFiKAFd2LYGeKGACAmu8rUNyyVABwS0I7Fg8FSxNHUJ
	 55XkvfdQF9kBym1hXbogpZUwIUZ+ell9kKE+kZIkA+/uaZMFSoSZ+ikeMdqaowdRJrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
	b=xTmJP8Qzg/Gc4fkf/iBmDMkedq8zlKBneHMo1i3Rx977ZqJi88YE1NYHzy3BKJyfaA5M
	 8pQhGSpzXzZPZDxonHt4s6n3PL65rFWD+LpnwNaz2Jfid2kcBPxeJKxmmD5DWs6zboy/O
	 D1EeqqKAHN7edfe8LxDL8cPEXuNvHO4HGLX54ELOXWNPi8nU7ZzPSdOyQpuVpZEcGZkKv
	 G6Qcmg6GMhE2msFsX1iq03GZiT8pyhNNkQUDJQzlafc48y0wm/e0WbRTDRy5zmtwDDXd8
	 8oCyVS9jL9p7r5hVPBDpQC3D0ajcjBbvGB/ybrK/KXrQqTkU/TxyODGedh+SDL1Bcsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBUEiztG;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775ED606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 00:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 775ED606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBUEiztG
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so68329a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752155; x=1794356955; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
        b=RBUEiztG2mkc9wkpbfWllotA5zqmrPvAI+p0nJ8kQwmD3bEEwGI4J3ukZN8tZaAjzm
         2I/RzAuS1GA+aJoW9TwSl9KYPP4xuCr/2XViDm1nb7CzGeOjmBBZXQnhZ/wgLtcUWAQR
         LxCySRWs2wStsR0B+V/L2k7amGXRHhVKlPzSmWKoUYmQMxxIBznJnS9SOiQJJcUpinbF
         erXG5Yf3upf7oFXK55zxMvZM6iRS+/IZRicXZYNeiesTezDlAf2XO9cJ+9ey0eMaRAxE
         Yu+uwierp25Wk3pqUAiy+T8FkNTOwF9j5hDg7h4+Qsz8+R+HY83pr3g1dUsZWpyPs2TB
         +HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752155; x=1794356955;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
        b=xLIMUlDNTIrY8GHSlorReaL5R+u8qWJlqd41v7Qm04WC/wdVb4nG6Pc1ORAefDSiMi
         D8oqT+O/c3sluxArVggcysDrWd7xFYqrRIuX0KMXxGbZyPaxK2rw2mpbRMtR1ib27Hix
         BH2TKCMN2bJZ/V8U0mrTrNeSLUdzWPzaSx2NBgpyUwH7GE+DMGO7G6rcCPHFthMjC3v0
         eP8SUUHEn2L0LHAyYHd2fzua/XVsUV24D50Zru+c8B51kOek8JVZ8ZRlE2OfiQVyr4XU
         EZMCFnYCIGrIE6I1kyrcgAG5Kkolf5DN2GcTv9KcWhijLiysnd/PApe12IIQbrCR4Vmg
         kP8A==
X-Forwarded-Encrypted: i=1; AKwUvBz1NTX0TBlCvyAAGEJ0Or2+AT/BwEOLD8Ir4u8jQ4uLdnVNnSdOOyx3NvT/dFZoJKQyreZ2g8k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t0VdCEf2x0C8LpEStTDSc9qChM5nvomprGBCPC+JZFtwHiP13
	fGrnbw8XVIHSw/v64KqQwsiswowVAeg4iRK5heg3bQQEMvHDvmOCUp0z
X-Gm-Gg: AYBFou2fPQ09Z49LTqXkxDpvEFBaRHxiklvLLZWA8ohewKQhCz3zpbOiHs8ReOE4fKr
	V0yenrJVqhWPtjZvh/hvJRqw+dSSMndr0x5oeuQlRGjxSsHG+TTWWkkHreVOiS9tQ309c91oQNs
	6EGojnCQSqimN9UCtPFwM461j428rNoc7LvdUp9oHfOWxerQwlBLzFXk4X1B7SbU+ujDL86q2Pn
	bvDLDAaNt8CFdMmhg7tykWOe7Mfz5S2VadLn5Ap4mw+KcRcIwb+FZFHLWq0NnRpMGwSNBme0Al0
	mYeCZM29hQmV7kjjtPH8gQGR4+3NR/C/2F3kLknsKrVF6Alyp5y7joPCjV6JYv2TQgPid3PT7yJ
	nTI67BpDTz8FJv9xJiWmOUayLiqvKulJ8T9ur+mM5WDgSmiQsOydmPC6HdKtuxlmbqQ5QIZqrWO
	fCncbpYAkG/PZjK4H7mUwUxMQJrogt+iCgRxFESCRHRxzJLsAG1mwd9EO9ZFVS95KVarcP2DTrL
	z9VZkaXGvkRyxHpygEa7oNGNKfTV+r7V7hewuA3wLh+GAu7Gbe8zEM+8SB+u9mWfw1YkNoB/3wL
	gZ+Sqf0xV/9nG2nui/H7KLoBk5ghAcPzUGAovMTqvdpddczZfTZsVmp/OVl67D4YgghY0RLt1uP
	6PUHmYAWw7CtwnwRYQaCz+KBFr3BsVDCL5g==
X-Received: by 2002:a17:90b:588d:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3ae8970ef58mr11861580a91.14.1793752155221;
        Tue, 03 Nov 2026 16:29:15 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5aa69fsm6514115a91.2.2026.11.03.16.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:13 +0000
Message-Id: <DMM02JFDLH2N.3UXPNYN6KZ5JK@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP
 listener
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374187870.488855.7800063583184291863@kernel.org>
References: <20261102072112.4160195-7-alexei.starovoitov@gmail.com> <179374187870.488855.7800063583184291863@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:37 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
>> +		goto no_progs;
>
> This only checks sk_state at insert time. Can a socket that was inserted
> while ESTABLISHED still become a listener that carries the psock's
> sk_data_ready?

Yes. It's an old bug, not from this patch.
This hunk is for a socket that listens when it's added to the map.
For a socket that listens later the patch fixes the children only.

>> +	if (!is_insidevar(prot, tcp_bpf_prots))
>> +		return;
>
> The callback reset only happens when the copied sk_prot is a tcp_bpf
> proto. Can a child copy the restored sk_prot together with a stale psock
> sk_data_ready?

The window is there, but it's tiny and it's not from this patch.
Without the patch every child of such a listener gets the callbacks.
