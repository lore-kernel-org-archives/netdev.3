Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793255317;
	b=T22UtH9o1c5C8PoMa2Sn+dTsORwv7EFnThEYfBUaihkFhyzslpwGkwFV1riI08A9tb3q
	 3lOd82c9oLWhzIDE8Gh2POKl9PzPQ1udQeBz5fpwC/MgNTXaWBD4D0n7rdWic3nH6gZSB
	 1UK9c2eC7sU8hEfwbEWls/1O/xIyCumI+2SeXojnhnYYshp30UklxP229zMXnkZCOkkls
	 ZJQAE9a/a61D3s3yVZ7clmkL9QK0hcEo6V+ZdVcIPCUAwVD/oYdYb8wwG7nDyfEKAfa+M
	 xCJxHwxCCLs5e7+TSASOxVtpCEJ9+tp2p/tqllGcixcnSAKoj/yUplKHB3R2JCQ2ZUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255317;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
	b=1Xorqq7GZPIE07aj7FwZWMJN1SNrOJqb5GEy1GUQ1NMZALNDPcvbmZLiG7zsAH8WSBw2
	 QHnovFUullPuEGjq6suQrOneE2bGVHxgttqIhyEklvNl4MM09eoEWI3syQ9nWQ/9fTF1j
	 pO1TKGEyuOjlAi/0z1rZzwA8EvLqwYtVmNvSQirXrZeu3wJRMMzdFHFMd1m65yv9tJ75B
	 YlBKaZ+IC5GTPdiMj6K9r3K5wkGiXZEt2RiJJkMocnei6w/thqoVHAFlBpoSm47ULSQdy
	 YbqLxi38xaI/S0BeF7I1A0Y2SlmjIQ9BA3jDANbtHkfAdu114FAle1uyRaBwWdHE8+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXGQZ8gE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XExwyMTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B8606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dXGQZ8gE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XExwyMTA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793255316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
	b=dXGQZ8gEyOQ5oh3QEezH5FCP2bIHc+ugtLtAan7KtKRVi4GrAdNesMpbYLg0xJ7Sco7hyN
	eXscDYWjLUAH5lbnXYY7RCRZqOSKHPVF4m7LCON460vnEwvp+TTNqkQxIJHTLQxMpr3anR
	V+faZnOCEZqbpJjoYyfyfUibw7lFWKs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-2caYmKaxPX-H4C_zGMtj8w-1; Thu, 29 Oct 2026 02:28:34 -0400
X-MC-Unique: 2caYmKaxPX-H4C_zGMtj8w-1
X-Mimecast-MFC-AGG-ID: 2caYmKaxPX-H4C_zGMtj8w_1793255313
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3a9e7d65fe4so9621571fa.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 23:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793255313; cv=none;
        d=google.com; s=arc-20260327;
        b=isRowGH6yjHJS0XQNjuXo57HXI57q/B/hrsS7FjZaUn9yJRnaJLbF8QNFwk921t8Yo
         RDjfKbrKM8fEISqgSFrtSc6lY9lgDouDNSgqjT5I7bo9hndnYOwN7TKNzynfXjO9EiwY
         oAp8lQmBcPWxZ+QWLOPgDAtAKWGwDEvZ854CyTvlCWTQsTZwge/e/+MUeEvuz9uYuRNX
         iUyk65XIrugoQDe6l6DQ3n2bYVI+JIiIHMjmHW1XGnN8iC5IIwp9pl/MqlULLAfk9gNV
         Vhcm5FgjkOlk9apFz8w//kmG4qg1AX3SFM6J6CtVoow1PB7PckMX7ORzi+E7WIEnCWUf
         oJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
        fh=5egDsH/bkwv+I6DOd29CxOY0+7DiRx5QV5c2Qan+RPY=;
        b=BhbmrUuWnwObbZzuJCxPufRmZx2xb9v21d5YDo7ENfiDKIdwv++qHvyJR+xUEf0bJK
         DbTkwk4hdoTrL75XDmFesMIAVdrMzRDTI7lW7kvNAKsLMu9EytDIQ+o71Vcucxx2vcHY
         6bxF5nQzZ6q/y5i4AsKenPhhsoUs+PrwZvRT8kq3QBOhHzyik8tpP0oyJTqsR2QGcBPG
         hsksv8Q5xH/KRBDfbtl4bgaJRFsxQl51GduJ9sR4o1NtwUa5TwXcycjn+v3BiokYdXOW
         90gHSXbkN6lSANk6sjPAlAubOkHoyIfMxouJlDaIu5VOANm+ldVyGgn3M/x6XFHpvrOy
         hotQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793255313; x=1793860113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
        b=XExwyMTA8DYbGGxcBAgigzAVW0ncFH8daEbWVof1HBicSweDQIU9RlX7anvY7lmysf
         m0XqJHSVZKGmAnYYXH4iR2dDd5VWahEwXyZr+VUM+Ou2Nogratli96r3ctrjc9z5FHZ0
         NHOXhaUs0n2MzhoySUyTY/s64ZpNAPg1v5rIIefRgTxgMk/efdoYlJGN7Qar9S4/fqaJ
         5wno6MaPs3c4ncrTtY/0er52+/EQsiseLH2ydHp+GzJ9Lt6OVSuLhaTjz7VntlrXXtdg
         +7YalFMtHTlECAURj7OwLv/Ht9+9YPk/rSEorxTWmpfO5OIF1ddX8PTUOpgq6I2ebCe7
         oznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255313; x=1793860113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1iJxU2srr5LwVZydpcZZOyNys/GEnKfXjQqJD4/acz4=;
        b=Hz5pqBztSm0hyQxVSpiJzbaNesidCcrLrVKwIUbCBaR1LpRfWfWqox8FlyTZ5UGsGC
         zzigZu4W2EUWxToIrga/ET9ygjfSzIJDLZi4mL71SmSZ92lGNHz5Fgq5un0HErWQFzo8
         DmvsTLOK6AptuMnAeZ6DQ4UM4ox2Mw6BrZXlaoCF9oMtkCt7PKqErTNxJvN3hQN671Db
         IW83o4haIcC0H8aiwDtvpCxMJh5QayC6AGnzeTLmSNDweitnL7sRI6ziXAADsoxbxcPu
         LCrnV/dAOqABNbJQQ1bqY2EeZB1y/I/t8hP0OS4hFBo9GzR553T1h6TqX0fkprs1THRn
         75Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzQ6yFUsufBTrw2usULZaU2EZvYZsFS1YShW4NQrurXnnFzopNHOL3FyHrnH+d7J3LJ7bSgMGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUgPoa/Lk04gI7wncO0uEZOui5jYVdgf0P1Qh6TZAQGemsGorm
	ZY7ePWX+QIm+iENKQS9tDxMo7UB+6SIeE9WISUXM/1DLmdX2bCFLm0jfcZM7kqExxX5h8Hyy7DO
	AY+I7Qx/1v+IjJ96pPMsmvfIdgP6TUMWe+ijp1auyBeJ44jBhY1F0dMXLbVCIj9ViJ1Z3vfW3AS
	HZceSGVrzkmiD2YoINrezd6c+LQoPsg+0b
X-Gm-Gg: AYBFou2S8E8b/wqENjDguSWs88AOnzjsF5VwS7btemxcKRyYN4Hk+6bfcaebEnNxJUM
	It6cWfzg9k5+XbjrTpuHs/y/fdf/5uInzuYyabdjPwmOuQFHaYqu8dpfIem0RC7R56PpJVsezGr
	wvnsrn5/OQY3RnKVBD901IqUFdH/t1GlEk8RWHDWhEGZvYbKpxJEFfqiYR
X-Received: by 2002:a05:6512:1318:b0:5b8:f8f9:e080 with SMTP id 2adb3069b0e04-5bfcad432cdmr1771593e87.26.1793255312927;
        Wed, 28 Oct 2026 23:28:32 -0700 (PDT)
X-Received: by 2002:a05:6512:1318:b0:5b8:f8f9:e080 with SMTP id
 2adb3069b0e04-5bfcad432cdmr1771542e87.26.1793255312465; Wed, 28 Oct 2026
 23:28:32 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028191103.623156-1-ihuguet@riseup.net> <20261028191103.623156-3-ihuguet@riseup.net>
 <CAAVpQUC7hezdMEQkzAX4oqFdO_uzBmtRwn85_5_iWf4ExPqpTA@mail.gmail.com>
In-Reply-To: <CAAVpQUC7hezdMEQkzAX4oqFdO_uzBmtRwn85_5_iWf4ExPqpTA@mail.gmail.com>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Thu, 29 Oct 2026 07:28:21 +0100
X-Gm-Features: AclHuK-x6fsuiHpokXnJ3Qx6-V8BzmKKkHRK86q2oMBiEy9ie31bHyN-v0SCuv4
Message-ID: <CACT4oueJgvE=CKSY2T2jkpD0cjT4bwU+ME4bb=j-cno2q57Kxw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] net/ipv6: don't route packets with unknown
 source address
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Neal Cardwell <ncardwell@google.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, coreteam@netfilter.org, 
	Emil Tsalapatis <emil@etsalapatis.com>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Joe Damato <joe@dama.to>, 
	John Fastabend <john.fastabend@gmail.com>, Junseo Lim <zirajs7@gmail.com>, 
	Kees Cook <kees@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, 
	Li RongQing <lirongqing@baidu.com>, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>, 
	Qi Tang <tpluszz77@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Yonghong Song <yonghong.song@linux.dev>, Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 1:02=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> This changes longstanding user-visible behaviour,
> so the series should target net-next.

You're absolutely right and I already agreed on sending it to
net-next, but sent to net by mistake.

Please review here and I'll send v4 to net-next.


--=20
=C3=8D=C3=B1igo Huguet

