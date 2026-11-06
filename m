Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793938742;
	b=dKHyfoylzb1WZWmpk7t8wyPz8/QcSk79x98MEhDpLWnGky5Zd3d9gZfW0tQeaZlbhf2c
	 W5F1VTeLwABcm59gq7piuJ5ILVxGzY5O0ziFQ4UV48ppvcSRScF9YC1j7VV0eTFVk4rNF
	 zei6jZLNK7Lx2RbB3rkwjlc55U6BhceezrfeYJG8iEJA88ORngNE3HQk3rgffeW/YkfFG
	 /rm6cfgqlP1m8Tmjqbk5z/VZfiuEgYeLOZt4AfQmItMUPxTBAYtvtLEi/NnzSXJxUz3sl
	 SKQfLWyxWk1t4EK7GYH/8BCLqGQASmE1tERX4bPOM2OVHqRrmCcJXjzzYO8n6w18ryg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
	b=3E3xcgaLlKE9vSURSo2FAw2W0UT+ljk6y9lwCBZCCrpzsWoRQuZO4AVz2IvjdeGLmT1V
	 4fzZDkyqSYTfvSxyBN8vgE8S8OIL5UoSeWYNA2errXBijJPYcp75noXmxVJDSqg5VAZhF
	 o+wbiE/bBzzXTgmWzg/69uDeUcBE6k+onvpDLrskDk3ZOZNojovOulOoxaB/UWZhaQHFK
	 g4iptLvF0U4001o5paBrAoWtwUItvDXx1ttjH638JDKbf45iaKEeP3s8Yk/1Bq1VC8G0+
	 pFohXbNgjrRq7wXr/RxoiZF9+51QdlyrtcrqvuVzrx3HQGqR8plyt0KmaVpbdKLVpVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQOMVIgD;
	arc=fail smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C9606A31B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 04:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95C9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQOMVIgD
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so224643a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 20:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793938740; cv=none;
        d=google.com; s=arc-20260327;
        b=E/R2yqTqRC7XURSawPzgofntMEuSQVOpa6vuzW5RQB+9TZxYpdpYtEELEwKLJ+Z6bt
         D+9QKhhpIeKOdApokBlw3D3d/o+A/1qHkm/1QoQ2lCIj5r8CFhpdBpznR1KnyXZvH9aR
         qEPvM2NHCay7ULLRJrZ9rEj2v8xkx8L37siO2eT6JFwvs0kMTPmFyIvPQZVjkMCsviaQ
         0GbYnitmvuD+G0H6fEHGc2uSfjy2HiKZWioP8J0cUdKJ+LYo3f+ETyNflh95Ut8KCKO3
         UW3NpJRFYIeEG0cx/rgaTOqcx3PfDU3QrKaUYZUVDFkpPO4ihWuen4gfd1r+qJ+3+h91
         9Z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
        fh=9CHDF1iDQguliH/9kCOajRxM/5VA08trtA6kpWV2S10=;
        b=WeTgBO8++QnUm/wW9H6ECldIPxp5lOz9T1tjztIr7lPIvvAbh2h8shdvUgkWIcy5L6
         5u6M7W/QF/88RbS5braDDEBSemI3S3XaUQe8fbSw8sdXUKo1wi94HAx1AotLbwAGUvWC
         zOcbx66NOxtJXWwNnXGXbIJ/SbzCkdpGxwtrBUaOr/ZwLF3Vt6hudpty8izzb7GeAVV0
         WqZjGTM26nKiJSLt6BAztdjhA8JnPgfHB6/1B1RqG1zxVd1YZSgfXhtWpyAnaaxEmmV4
         1eODSvDXscb+KwAczCAGmtDiU+Az33jIk+WKUYMu0hgFmNPXtB+cnTaoDKNkQT8dTTZo
         3C+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938740; x=1794543540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
        b=SQOMVIgDG07Rs1CVYdq8e/3W4Jclytnfj0371yqD/4HbKar+1TpM/XjYuwZeIB2N6e
         yOrLPPyTfSmQ6ffdSnQJ61qSbjTZGO26AHMhsoy+obNqIe5Gkb9+0jX8NX2VGLFL0ryl
         MpJ2OXQoysU1Hj9T3R6ZdTrNWv2VmEJSzRDVd5nLS5vgSPQshnelZEvXb7FPbPM0YQ6K
         dKCTggP55elkJCpzHDkXOq6kEvIuYSEBi0oefqzVtheYjaq6HeHUvA9OFLEdBTUfj7hH
         vcEJRsr6N+lt7oPPpxCuoUhVHsR6S8DJri7Rr1oo4HKdthigi0EB9QQnMkfDUJyCr1Lo
         0haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938740; x=1794543540;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+QHalZACJ3QrM7+p2YDwvBbF+vGSs6C8jZh48BjQxEk=;
        b=MtOSPTy1jI39yDVpo9StJp12Y3WeO7Fp3bTbfxVIIs+VX01hzUqBbMSXXNKsBz66b3
         K8e1rAX+wTcwlXUTN7SIXiFMLWZUBOLfAOGHaryAmFEddja2fK4e7S+KvaSGANla14cP
         cTTA+U3BYuHCl2TtNeHAm3snx6CPF/Z+tyVi/l2geNrfk+CKVwjRGSVgVrWEUgULGcj4
         CVZ6TWQ62eW+oZd++n6g2JoW7qUmofVEoaGIqThZTp+PTh38KyoOkNaHdIlx2FDpCR9x
         F0JZRNjdmle7DRgjiWvKArcRcuOSjNtUccgITea6O/Q5lBdJFyViNsptCKaH2rfGQMph
         rSWw==
X-Forwarded-Encrypted: i=1; AKwUvBzDTHF5pYI0ABovbuCwLYUd3yp0K+Zjlh2pF+58xH6NqfMLDroWPd4QX+KknhXYJwvqO9ZSFAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ovKCVUBUWU/PGZpoZOx3hN/lhuqt3KMADwZoBj+8RH8R+boyF
	sEZqE2HUBaotstdG5Gzh5oMh6OQLhhtHIe+grIxZn/J1AVqWOBUx3PUaEs8BYiYQd+lqci+E2pI
	9ROeJbefbYZ6KygVk1geBmSTDYbrjXbc=
X-Gm-Gg: AYBFou2Ej5IaStXrztTO+WKEzZqC1NcziegWEJocUZTuxd40KK9CQ809LK5KAHO1fPV
	+bEyE/5YTxwbU1kyRZ1aeuYyTa02L8nG1iJRoAVtqV+JPHNjYR4KBjon3CYLT0K4+pAR0k9tGlf
	HKEw9CQs4DdMAVx16TCKVYMAcHzGKjvgE2uto5rHNR7Uoy4OZkWdb5DbAs5k37J2YcaRT73n/qj
	+KlCnITgpv8qsn2BZ/IC2P4fguu6m4F2LYFMEUc5G1SI+BQOGi00LXkm132gJE49M7O65KYrwEI
	m+yQKNMeUxZOLsjai3426G74zOPNa6bRcSKJGEh8a5ZCsex9UoDiDv+m+RBvt2sUipv1pdKRXOX
	XdYspl+YbMvtYblZ8MAMkTRG25UPQ8L4ia/eV
X-Received: by 2002:a05:6402:428f:b0:6b4:8d16:af57 with SMTP id
 4fb4d7f45d1cf-6b5977dd07emr739331a12.23.1793938739937; Thu, 05 Nov 2026
 20:18:59 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
In-Reply-To: <CAHeizqGJ6WpknaU=WE+PB2A09jWi==-sUUgmc36qgStVDRdSLQ@mail.gmail.com>
From: Subham Pal <subhampal789@gmail.com>
Date: Fri, 6 Nov 2026 09:48:47 +0530
X-Gm-Features: AclHuK_XRxaa4K9UC2UuqiWc4DvioVlO-BGrZn2eJzo2Ajh9WhPEJCLIzENhwTY
Message-ID: <CAHeizqFNiJ=06rh_0yg5+xWiB4uq_M4mxsJrmXNrKKhadmP2dA@mail.gmail.com>
Subject: Re: [PATCH nf-next v2 0/2] netfilter: nf_conntrack_h323: fixes for
 NAT bypass and ASN.1 decode
To: Pablo Neira Ayuso <pablo@netfilter.org>, fw@strlen.de
Cc: phil@nwl.cc, kaber@trash.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a gentle follow-up on this v2 series for nf-next to see if you have
had a chance to look over it, or if any changes are needed.

Thanks,
Subham Pal
