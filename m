Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794329881;
	b=oPYNsBPlsVHAUMWJUN7yzVw3vi3oPvHmyxJNXnDt2rdhV51aDnZ+5JcNyWuDKjyLuYxh
	 otPIvmE+HjvcX1DxY1r7287mUS0Kkxkjghvp0uJPxLum7NGRYN0hT+WmFOHTotoan7hhw
	 3axj0ZCNpeCUnmvonl66LlVaZSSyClYF/wL3nIHqhBZNUC91rtsZzI8v3Rkuvjda83xgw
	 wrK+sTFuJlgCq/zPmRqTl0DTR/YnubAQwwCKPRxq46IgAIEtMawiRSNivzfoM2txgfus4
	 hKN92afHZTboXWTGO5ip9n07/FmblpZNKJsZMryHzfbn0EHUXLQ+U8I2UCMndUSQD3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1HlRMg2f8VT1EI4K27T8+cqMdE7ojzLtyN9VMRiohws=;
	b=y3o/9Ty/NotlleWACB+nmXw6fVqH6BBZygvIoJSJRodTJMYTBIz+kVeVp2ZaSBjsNAaY
	 SBQLLO1cnt7qJYSagohBgDGyy4mFULtJIzMgQ9iyAhm5eru/MV3HnuQsjVcdwRAGkiAxT
	 bhDy+yfG/Zwu024qoxs/BwKeXSbw7MxLJjlJuxlcJdX/7flZyw5pimn9jqWr8LYUbmIPb
	 R3TqgBB5vcsdzNWo4s7wTxAZvGxR1HU7e3wTOC10YAQwg3m2MFIUqt775ubNvHe03qSiw
	 i99UPZaZFmO1Y3fVum8ZqOXveAp279qDZ1rK08j81KWerRjkEkbQH3OF7Tr+SYRe1Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8iT54ru;
	arc=fail smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA528606A9D8
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 16:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA528606A9D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8iT54ru
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1379330a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:58:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794329880; cv=none;
        d=google.com; s=arc-20260327;
        b=a3BaaT1Pld7Od3AyBP8eADXKv8H9ar3AIFsgJ+WXybXZvxK1Ao9Pz1HBFOChfK+UDK
         o4uom1ss9Q9TyCphqhDaVBSj8H3Rc05gQuNWTklZAMSygUf445w+Wv26eJEalZs0DvHK
         lnJ84HPX1akHLF0sR8g7KXHe2DuWCq1Xt5cTpy3AHvkQM8/mecEa0Tu9Ugvoxx2UvJ9i
         ZWHcJ6S2b/fLPrqMicmEL4oRs9s0avSsCGMnnt6sLBFyDgNcjhNr48V+bdYW12xy/u55
         YcM5y59bU8IJkJOQO7VEcb2fR4KRGIxO7bl83WSFMfMZdd+oLEVTkmfYttGSnLWs6Osi
         JZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1HlRMg2f8VT1EI4K27T8+cqMdE7ojzLtyN9VMRiohws=;
        fh=qGoVm5M3GT7ykalCWRDtCMedfcdcL9azXiMiylvAcDA=;
        b=S6oFHJv+nuo1fXz7pbLuHcahpW42P0fmp+bTdUk+0tp66T73xPz9UwVGxj96MYF5ar
         spJ2HH2S1zHjbbMWcaYPGZGtpsewQuokgnOL8st4uyuepAepQwTZbpsByhlQKHi1E4jC
         SlaVaDtDBoQDopZGVntPQUpfu2uDCLkamWHrmd4WecifewmeswCfOiMFSx3iUocspvAY
         +UqAczF9IaPKT0pCL9kPfiaVtLtE6pTdZOUmlgavDVUxcLtJiL1LmH0mPH4NoeGJmWMo
         lFoQeiuIGvMQhaysoa7dIGKu2CGf9L74OQQwRQWg/8BsgUeGW/R2r6yF9WQgY83Vuutz
         NOMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329880; x=1794934680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1HlRMg2f8VT1EI4K27T8+cqMdE7ojzLtyN9VMRiohws=;
        b=t8iT54ruLSMY3csAPAgojvVYw8cwh2154xKRj95sLz8EdPdBZx8f41EcmmLGuC1F1l
         ElLJg1Coj8V/Ns9BmZZDFhRsax5ulWClrHftzpsakovCHNkHPvpuPf8qyGPMEvS+ZBpx
         /8pV8ycjMItO8GluGRwVeuxn5Niim18numJAMJCOkn2GtDYz8TXf89kGi9r++cn8vuAx
         pUhime1PYdjP5LkIeHAA3e/gHsvVtzNNo30B7FiujRhOh3tTqAzd98atJr4QoUaBJFsF
         lyo11wt0d95LzOafUNNzZOifg0sIxvglqaOuSTlWwJc5A1Bs05wNjJEnYABaNIonOyUI
         V+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329880; x=1794934680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1HlRMg2f8VT1EI4K27T8+cqMdE7ojzLtyN9VMRiohws=;
        b=gSS6hemff+NKcjjxa3KekagYeiy1Dak5PG1TNuYuJQD/9rcIzzT4YAlIWfk4n4KN1n
         dUchi2hVHXjiU0cDgQ3y5aw13DCv0txYavfPKhBnNcHzAp64JajFywv88LPP65GQWzSW
         scdaHZPOqk1VMBpPMFxsaIE2urIBd59vW1DFDnHOfse8MhlYfybfPggNVX7+PbSZJVFI
         4dLI/SVeV6HeE9a/y35japxIEOMMMyS6BDstY4DEfXH0UthQi/prt3znvvv9pfI9Sdc4
         ntXz+0dmBiENWIx2IKVf6JB9oId6TVby0Z70BUJCI4nf+nAAVEvE5bFgPXSrbPa3N9yC
         lYsA==
X-Gm-Message-State: APuU4Z8J7CyNs/SrQ5wjVHE92DedMhG1d5i8nnEanbP/gQBR1rskzw6H
	NXLKKgObvH96OdIBdqOmnOw2WBdgQy6Ur3bSm/jVdd3YYjgqjdybGvvXV9/3jAnEXLNkzufwuo0
	esqbM9EUxNMCEdIUCLb3Co4xZ322YyV2BeWVr/EM=
X-Gm-Gg: AYBFou0bhhcPU0g4f8Ez3FrunsB3WZpwcL/+4XqqDbFexljdcyHkIcgdBiM2kDZxTh3
	pPYzEe0H/e8oFH/SZOEDfv8Tvp7M5YtKa4oc4Zbe6fk0G+xPXBptN8B4fX3g0dZ+NXaCughwMRw
	3bflA8Or57nNZTvkGMXZ2OiSmM0LigJeeMb43IF0L9PlzGO2j5Ln90pxavM2Eo1bpfglIGrAf0I
	83ZJcOzVd+uzBh4g5Lawh5W6lwrGOhbuUfA1RNiV3o0hpxJvq0+bS9+jh8wqebEW/LKYePA3e8n
	guNv6SCH2BhxRM/jI4Nd9CL07oc6c415jf4b019AW/XHDLh5PCJVISPkA4FGA/rT5PUEy5RCQaP
	sUhMoQY+pPOnq+JkNpS1h52PdGOe7+HXJX1XMbxr+YOZsF6VbyCMNRd7oXuF7FatY2ukmuaIKod
	MgpiBGyuLBBeiuSbgQlZgzkU99cimUj0oV3yo9Wg==
X-Received: by 2002:a05:6a21:4d92:b0:3eb:292d:6667 with SMTP id
 adf61e73a8af0-3f18fc7916bmr3102272637.45.1794329880120; Tue, 10 Nov 2026
 08:58:00 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794241654.git.lucien.xin@gmail.com> <20261110074153.4b895bb6@kernel.org>
In-Reply-To: <20261110074153.4b895bb6@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 11:57:48 -0500
X-Gm-Features: AclHuK_HpW_I6LMxVTgDVIWnA6pZgPm7vgrtWceSe67s1c1ZnBXYAOFgqXCnPVE
Message-ID: <CADvbK_e3aoDOyk3hbPtS8pk3U0QSiLtYafpH2oaoNbbR9mV9aw@mail.gmail.com>
Subject: Re: [PATCH net-next v18 00/15] net: introduce QUIC infrastructure and
 core subcomponents
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, 
	kernel-tls-handshake@lists.linux.dev, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	mef@scarletmail.rutgers.edu, paul@jakma.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon,  9 Nov 2026 11:27:21 -0500 Xin Long wrote:
> > The QUIC protocol, defined in RFC 9000, is a secure, multiplexed transp=
ort
> > built on top of UDP. It enables low-latency connection establishment,
> > stream-based communication with flow control, and supports connection
> > migration across network paths, while ensuring confidentiality, integri=
ty,
> > and availability.
>
> coccicheck says:
>
> v:250:19-25: ERROR: invalid reference to the index variable of the iterat=
or on line 241
> net/quic/connid.c:252:16-22: ERROR: invalid reference to the index variab=
le of the iterator on line 241
> --
> pw-bot: cr

This is a code pattern concern, not a real bug though, as the use_count <=
=3D 1
check guarantees the loop always hits break.

Thanks.
