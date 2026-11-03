Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674741;
	b=4Yh6uxTtXax7kOTNYmwnLesO5EERrsLZvOpXoBBsMb8l8Xo/V8RBoPOBbB8sbCb48fHX
	 KzDDstflNtQiIp5LwcrT/MtXXII6Bj6BjeHbIHJz3vL80qXLRn+PfXOzpqw4p7vSP+NZx
	 v7rdknKknteHBim/B4O0mnrceIT+IZN5COzilpIwy173b7ahqD69sRodwIONQ95J6k4jx
	 NjQJ5N8LXb0+A+siVl8EArj9YPgFbWAqB5ukRs+ffb3JYgVglqPR3ZMwGSJv1RfXLMCRr
	 WTnMLu9fwNVvYced+BRF/GUIJCLyQrsNXj0IpIqI1nFOgtnIQps3iE7TNrdENPwoOWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UeAgzZLdotti0IHP6YHs9fQ/pnjZZ1tIB55pQGz1Z2g=;
	b=TrqZ1Z22NSaqGeNcHCObVFOUbnS+pP6Cq8c8Oam2VoR3nU5NfhtShWT0Ry5hb92XivAY
	 jGLzNo2g8Ev3IDCTudKYDRcULI/9iYL+N6PhS9kepPpcadwpfXDlbLiE7tgOLR7MkvlAG
	 0LGUOME0U45GBDTGfEmufkhFFk51c+AI+yHZMIUNA/eQO7Bg1fbX0faW8yOjiOGxL2WOU
	 zpHUIUe2vajfRfFGbb6AlYtoUnfVQfuaCSCAn1ead/wkGB1vi3z7xPajuftYl9kE+51/l
	 Z/PwYhUGrXJXg4BtSwkrnd2XvtHovqRs5TZUP6c03QZPif7Ctxz1/aot5ovdHoMbj/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SWftFRzf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB6606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CB6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SWftFRzf
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2849a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:59:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793674740; cv=none;
        d=google.com; s=arc-20260327;
        b=IALgtszq+qMJYw8vytfwUFW9M3M8PPAl6DrK+uBr1scI3PzMe5cy+rcqXlZNU1dbnv
         VgIWmqEedf/Qybr2IHN7ehvG76bMRrB23sq3i7OValkS3jaLA8EX+MUn8uhqSBCNz2O1
         LaK/QbCi8F/W1vzWql6uUeZJuaU+LlQqa2DDOPADXZqnYFmbCrWX13i3LuSP8K6cw2um
         KvSBH8/kf/U/iuafZnPD0+sr2Ubu8HtSQ3wLBw9TUpxsJ9gFM1WNmk/yC++3icHL0c00
         vNU2O94roCV4YmtLcvvUF/ROKnQM2pUO9udYIJ4ZVes/6/M8DWfJkXV7ffs6fWQmnkLn
         uQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UeAgzZLdotti0IHP6YHs9fQ/pnjZZ1tIB55pQGz1Z2g=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=HCq9kL2wjBUMKCXdEmCyzoqCT7pVYe4oVSdXZKhPPoFADLuwqLlI2631b+VtPPQCVR
         8l573Kme7IwJkoTS5wsNDaN082gkm0r5/ydSQ/hdn8xGrh3ynCD9yrln73h27QbM8axP
         6yV6jZ8kFv4qWdxYKTywWShalkMeMPnglN2bl7Rja7h8zSnvI6QVpHRvkw43z+KDz9rM
         fcDcGJwm8FN6fD0XSrXRsDDQ5W1iQ3DwKBOl+kDtcSdMyNlzNdOhD/ODn5cv1OBHR/q1
         8sDYTil+tFXgnDtXp6ULOx36wt8fn3bE/xl7cNbexntYI6S7WvuGmGIxe34bEzkfMDng
         0oZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793674740; x=1794279540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UeAgzZLdotti0IHP6YHs9fQ/pnjZZ1tIB55pQGz1Z2g=;
        b=SWftFRzfsr6HRx4mZ7jlKL9NBy880MECjOX0cGycb8yBgGDCdwhmaMudA5uCPfnCsr
         12rC+qqqvmSvKFG7NqLjNYRVUZE34khfj2SjffiiS8W5B5WZr/ZYboQR6rm2ybo5agl6
         KXtEvNcgHqwKMkLMR95tW4NLAlMHOmoqEX0mXlVeJqVOqHwpQ7u/x7oYcJcbK6Whw0Yv
         SxHXuClHnSuLcYRwTHj9cfFqZT5eWfkatAmjmPJy9ZR93RGnD24qRv3ORgNWVvy0TSYi
         DHvVQHYtwo4qQKosyCBDfYGYqALpH+v6Yh7R/cORV1TV7J7hYBYNhA+WlDn9ASn3KBGH
         lUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674740; x=1794279540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UeAgzZLdotti0IHP6YHs9fQ/pnjZZ1tIB55pQGz1Z2g=;
        b=YzC52KlqVQz3b4P85vBc/8bWBeiUbcvgNtk+GN3vtZwPSu8ct9FdVQHMoCEkoU6tUI
         CLPVmtGyRGqfzxth+GZL1qaoXLz8enNTN/f8NRJTOMIQ04bXCDnoHdYyGdFm9+2+JiR6
         IE+xS5/XxDIciS8b4ipnsi/SMrOdHuR4bnG1bMdT/hLPeQT1Xk50aOOP4fIVVTq9aXob
         7nyHlHw1dJ6xuvXE48lNKEia2KXigs/joBTV8/4naLHcrkeBmqgwYulKqQ+MdEZ+zdR8
         GtoD6sOAFxCmQ5pbzHUGh5stXpB5XxscWm0F7UrDkTzqQFxTPFpueaB7XehxhOYits/P
         2S0g==
X-Gm-Message-State: APuU4Z95KdQUSN7AB8GumMf0V75PmHDylfA4x5lmYeLRJKde8OINQnkN
	pdgfiZqMKjNTZWdBvZO/2QcHBuR1uOTgvhxcJwKYnw2v35LOC+1B58XQBII9Dxnbyd/jmsd+Nx5
	cdlnreI6UfpxQ7d3Sibsdl5fm6vuWSOyBrLtjGtNl
X-Gm-Gg: AYBFou1JbJcte5FS+DM8hOJ7UdpCp1Dn8XIzwgtDkVlNsAZU4q5ltH8njLvc6AjnXwv
	zKOq+M9+NgctLhjkZz/WKdyBEh5wzVzRcBykP+JLn04OYsoWei/SdLk7gmrWnrH8R8GlXBrV3e9
	MJU8nw3sjVUb7KqXNf5HR4Au3+ZSUAgRrU3nyX+h1JOU/BoIBzXOqpwUuE1JbQLiIvxvHIDZWF0
	HbIcpvVG8vtt6WTiTjVlNXGe1j4Srm+5Htpxl9UpccsAHgzunH7sWN3zJHQUEi25Vaq9I/HNdX+
	k86MZXkBzSFKhBTBdeAyiyH2jS7/O0CmbU3aHQ+GqWyzFIZHldEJUNetEf2jVMMXobkV69am58o
	jSbmLdD+lADA+qt32VqU2Y8Pui49DDnq9SXTbjAs=
X-Received: by 2002:a05:6402:438d:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b53e778d41mr32077a12.14.1793674739712; Mon, 02 Nov 2026
 18:58:59 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-8-sdf@fomichev.me>
In-Reply-To: <20261102191438.1059771-8-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 18:58:48 -0800
X-Gm-Features: AclHuK9Z5oWBbhWwMCS_z-DuUMSaT3p8QPAgg8n9KeMCHplfWy0Bv6rYsGa7af8
Message-ID: <CAHS8izMyGmLC0yg+WT7eAZ0tkSoJ5K80t-J8-WfYegvjDXonMA@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] selftests: drv-net: devmem: TX from a
 hugepage-backed dmabuf
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> TX net_iovs are now sized from the dmabuf layout, but the TX tests
> use a regular memfd, which usually keeps them small. Add -H to ncdevmem
> to back the udmabuf with 2MB hugepages and a TX test which sends a 3MB
> buffer from it, so that frags end at and continue past the 2MB net_iov
> boundary. The payload has a 7 byte period to catch offset errors.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
