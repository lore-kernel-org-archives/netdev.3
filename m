Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465406;
	b=B9D5BwaS20O0R3dNeOj8wqho1NEgkvUsFTnqfZ4UahrUpWgeh60px3+gCCS4UXKI1sI5
	 Z1ULTINJFpEmGfyn626GQTmjkIr3vtQfuojfEPi8hzrgwdbhwe49RkRBaDoYS/9V1QG1r
	 ds6h9lMTeHqt1/1PP3XPzCiJyZq8zdX/n5Xp4dBBuIu61LpMf5DnEUzsyn7YskfYiczf0
	 TM0O6Pin95WDFQ2zIIxfkk+fRG4GzRbCpLaHnKtVxLo/psDkYzb5mlCIdmQOx1p1YPeQ4
	 3qhjlJzJ+Vhkbrl0zBUVo5AZxDzhDwoAbxAb1dCawVqPl312Zp9mFdH28p8ylj6ym0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7iKM8EwoaojoyuTFakOaMxaMyLliXbiGe3dN6S9YDMY=;
	b=5hwTKwsgBrjdyPJUZZRqyOGIB8p4AZ+4DKTewFOA08xnyySXqn+Kwt/L0z22/fIVumct
	 zmJh+8t9K5Qy7BnGuueNGEz0nUcbwl6dzSZ+hp+bB3eb0hlyf9y25llbcPnuUAbyQ/CrL
	 BUlJrKPaGBxi6n05z+irrkk+1lxfyiOMnPTpZ7VNhekky1hBL+Owf+hSS3RNl7PJ6eg5X
	 +XH6Mwm93/sVlsQEab/SlVjDmx5z0bwJofbjJhfly2PeoVq+g8pa547A4WfZz6qIWrsmP
	 R0swR3M2q05bEsL89jkS+a0XBnhtsL8oL7GOQKZHo56w1/T61wvTjerdleB8uV9UyeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YkYiYCQN;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED5606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96ED5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YkYiYCQN
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2380805a91.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792465406; x=1793070206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7iKM8EwoaojoyuTFakOaMxaMyLliXbiGe3dN6S9YDMY=;
        b=YkYiYCQNhIREwubHqRXjpJhIVLCmen08ktmOr/IDht2Mu0NDdDzkeStxyUqonSytNf
         NOLbZ++Nt7V5JnCVSAURZdnUHuBkGppvaArpkmC5EtySpmzRNMQYd9nwO3zsPN2eK0Jt
         ToIiOPVq2Gc0VOov9KpToQPQOmOGHk8ozyaZTkW4LVu9hsMFTGKlYL2OryBvMwpSVT1O
         omtRVAVVY2VwnWo+Te45Lt3acnvdgEfnAD5cm6ap9SEu7XJWcfvQZeu+AHZEnxAziZ+r
         0Ym21wMmptonI813GOS0BSJmyeQ/v550S/JYDvcMyTMAE23nuF6R5NIHSrHTRvtxkMt0
         m8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792465406; x=1793070206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iKM8EwoaojoyuTFakOaMxaMyLliXbiGe3dN6S9YDMY=;
        b=Ef93TuRnIZn2Fv2UpvkujXpXBqOCJkn6XMyT/+LTWoBr0Pl1Svc/nfmWxcvzRCpxXE
         IUsajRXIBHAItNgheMCltg+37YunyL+ZwTYOMBjWmSFcOV4NMHMY5Up8HzNDcnCYaBbA
         4P6vl0IOHjClx235jHBGxxlSkM6jXAwP/iUBIOUbYHscUxmNHM4QcYvc9LYq9GNAxZBl
         CImjnE0BB+IN7NFtwAFK1RfQ4qGOYovuiV+a1sLJlnTNpHbxSDeJZXIuSR3dDQUZbuZ5
         D4qy3FV2DqQDnAmXuMFo+OePOWV8iJCz254hvpcabLZEmgq2Q08VtN3CbgFiAKSi3bkr
         tFtA==
X-Forwarded-Encrypted: i=1; AKwUvBzvp+vJOignZyu52Xl/FRc8XrwNQyJF44NihDza32xJaKhs07ficH9mp5lVw3DDTIVRXEnW4IA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfshShKFFzeeJUChWGYETjn5q2Zbc1GfQPy4K0EysVH2jyk0Mi
	N2q/ocz37EubqkM1J+G6J88jRjtFiWLaqOP/7O5n3SnNZ8p8cwNirsAn
X-Gm-Gg: AYBFou3PmghoyTQ4UFPrx3ZeviDPPEj2Lo+Oq1/K+yerLOSIGHBhp9daob6ZWbUxqcy
	SXjOupJxcR81U6kBEYujFGTLusXxVarPdXOs/rT8NdF7JOXkYVHqOXpqs3LnSnm5EKC59PhoiX3
	shsHaijEqL09+NLq2TFOTzH022CTgMVJsnAteS8U20IsATrYI9mkU9/9CDsEH91GSDe8zakz6Yz
	yMSc+rUEn17UBtjp0mN0yc37QDkKD6Qw7TwvEXa3bs8qzWxqPic5wFb8cES2/XHgtusSi2uy78L
	7qMarDT7cKJ+Yi+aFNs4sBARfveasbfFRFS8rQahkRlMWDh/s01jb89F8FwZ+444glYpgyIfDEo
	VE8fhqyBZpLTqATnB8Z+ETXI3APjoHG16dmYBjeDaVO6nY/bJCnEi8Xspi27uKFnU5ZiF72XRTb
	qB4tNJAgZ20J5oMZyVka/RWQ8i/esAJPrVcLUzZYSrWixY346edzjzDanBQyFPtG4AlYwsEsHhJ
	ej5qHtMQDb7oYq+r/j0G/CsSDclWgqXX+QL8spiVQLvNgTiAk+eA/zaJTTICSSEpBp1IB/gZoow
	N6tJRhl/kf++p4VFdJQjU3cC7uObd6Vl
X-Received: by 2002:a17:90b:582f:b0:3a6:f1d2:57f3 with SMTP id 98e67ed59e1d1-3acef542fa9mr8451695a91.58.1792465405825;
        Mon, 19 Oct 2026 20:03:25 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d4005b1sm2215884a91.6.2026.10.19.20.03.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 20:03:25 -0700 (PDT)
From: "=?UTF-8?q?=E6=9D=A8=E5=9B=BD=E5=B8=85?=" <yangguoshuai@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E6=9D=A8=E5=9B=BD=E5=B8=85?= <ygs@cgcal.com>
To: netdev-bot+sashiko@kernel.org
Cc: Guoshuai Yang <yangguoshuai@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Tue, 20 Oct 2026 11:03:18 +0800
Message-ID: <20261020030318.6471-1-ygs@cgcal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179237120528.3135.16925112275068010433@kernel.org>
References: <20261018005218.53267-1-yangguoshuai@gmail.com> <179237120528.3135.16925112275068010433@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guoshuai Yang <yangguoshuai@gmail.com>

On Mon, Oct 19, 2026 at 12:53:25AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> 
> Does this reset only reach the head skb? skb_gso_reset() writes to
> skb_shinfo(skb) only, and the frag_list members seem to keep the outer
> TCP GSO state.
> 
> In the case the commit message describes, strparser chains a cloned
> spillover member onto frag_list. skb_cow_data() then replaces that member
> with skb_copy(), and skb_copy_header() copies the GSO fields over from
> the shared outer TCP shinfo:
...
> Could the GSO fields also be cleared on each skb_walk_frags() member at
> skip_cow, in both esp_input() and esp6_input()? The members should be
> private there, because skb_cow_data() copies every cloned or nonlinear
> member.

Good catch. Indeed, skb_cow_data() copies cloned frag_list members via
skb_copy() -> skb_copy_header(), which preserves the outer TCP GSO
fields on those members. If the decrypted inner packet later takes the
ip_do_fragment() frag_list fast path, each detached member still carries
stale outer GSO metadata when reaching validate_xmit_skb().

I will send a v2 that also clears the GSO state on each skb_walk_frags()
member at skip_cow in both esp_input() and esp6_input().

pw-bot: cr
